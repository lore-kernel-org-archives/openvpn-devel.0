From: "Bluca (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 14:29:35 +0000
In-Reply-To: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
References: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <8f5e01a145c2323e61fd9dd1ddb959573867414a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aLs5482bMYg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: add
 base64 multi-line input for passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aLs5482bMYg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, cron2, plaisthos.

Hello cron2, plaisthos, selvanair,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail

to look at the new patch set (#9).


Change subject: management: add base64 multi-line input for passwords
......................................................................

management: add base64 multi-line input for passwords

Allow management clients to send long passwords via the
usual multi-line base64 encoded protocol.

A client declares MCV 5 support and sends a 'password <type>'
line, followed by as many lines (each up to 1024 bytes) as
needed, in base64 encoded format, terminated by 'END'.

This is useful when a password is a JIT-generated use-once
token.

Declare management version 6 for this feature.

Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
M doc/management-notes.txt
M src/openvpn/manage.c
M src/openvpn/manage.h
3 files changed, 106 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1593/9

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 7da4aaf..4cb3815 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -326,6 +326,22 @@
   The escaping rules are the same as for the config file.
   See the "Command Parsing" section below for more info.

+  If the password is too long to fit in a single command line
+  (longer than 256 bytes), the management interface client should
+  use the multi-line base64 format instead.  This requires that
+  the management client has announced version >=3D 5 via the
+  "version" command:
+
+    password "Auth"
+    [BASE64_PASSWORD_LINE]
+    ...
+    END
+
+  In this format, the password is base64-encoded and split across
+  multiple lines, followed by END.  Each line can be at most 1024
+  bytes.  This is the same format used by pk-sig and certificate
+  commands. Requires OpenVPN management version >=3D 6.
+
   The PASSWORD real-time message type can also be used to
   indicate password or other types of authentication failure:

@@ -513,6 +529,7 @@
     >PK_SIGN:[base64]           -- version 2 or greater
     >PK_SIGN:[base64],[alg]     -- version 3 or greater
     >PASSWORD:Need 'Auth' username -- version 4 or greater
+    >PASSWORD:multiline password from client -- version 5 or greater

 COMMAND -- auth-retry
 ---------------------
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6cab7db..c22a2a4 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -31,6 +31,7 @@
 #include "error.h"
 #include "fdmisc.h"
 #include "options.h"
+#include "base64.h"
 #include "sig.h"
 #include "event.h"
 #include "otime.h"
@@ -68,6 +69,7 @@
     MCV_PKSIGN =3D 2,
     MCV_PKSIGN_ALG =3D 3,
     MCV_USERNAME_ONLY =3D 4,
+    MCV_MULTILINE_PASSWORD =3D 5,
 };

 struct management *management; /* GLOBAL */
@@ -105,6 +107,8 @@
     msg(M_CLIENT, "                         where action is reply string."=
);
     msg(M_CLIENT, "net                    : (Windows only) Show network in=
fo and routing table.");
     msg(M_CLIENT, "password type p        : Enter password p for a queried=
 OpenVPN password.");
+    msg(M_CLIENT, "password type          : (version >=3D5) Enter password=
 base64-encoded on");
+    msg(M_CLIENT, "                         subsequent lines followed by E=
ND.");
     msg(M_CLIENT, "remote type [host port] : Override remote directive, ty=
pe=3DACCEPT|MOD|SKIP.");
     msg(M_CLIENT, "remote-entry-count     : Get number of available remote=
 entries.");
     msg(M_CLIENT, "remote-entry-get  i|all [j]: Get remote entry at index =
=3D i to to j-1 or all.");
@@ -1019,6 +1023,41 @@
     }
 }

+/**
+ * Enter multi-line base64 mode for receiving a password that exceeds the
+ * single-line parameter size limit. The management client sends:
+ *
+ *  password TYPE
+ *  <base64-encoded password line 1>
+ *  <base64-encoded password line 2>
+ *  ...
+ *  END
+ *
+ * @param man           The management interface struct
+ * @param type          The type of password being entered (e.g. "Auth", "=
Private Key", etc)
+ */
+static void
+man_query_password_base64(struct management *man, const char *type)
+{
+    const bool needed =3D ((man->connection.up_query_mode =3D=3D UP_QUERY_=
PASS
+                          || man->connection.up_query_mode =3D=3D UP_QUERY=
_USER_PASS)
+                         && man->connection.up_query_type);
+    if (!needed)
+    {
+        msg(M_CLIENT, "ERROR: no password is currently needed at this time=
");
+        return;
+    }
+    if (!man->connection.up_query_type || !streq(man->connection.up_query_=
type, type))
+    {
+        msg(M_CLIENT, "ERROR: password of type '%s' entered, but we need o=
ne of type '%s'",
+            type, man->connection.up_query_type);
+        return;
+    }
+    struct man_connection *mc =3D &man->connection;
+    mc->in_extra_cmd =3D IEC_PASSWORD;
+    in_extra_reset(mc, IER_NEW);
+}
+
 static void
 in_extra_dispatch(struct management *man)
 {
@@ -1052,6 +1091,41 @@
             man->connection.ext_cert_input =3D man->connection.in_extra;
             man->connection.in_extra =3D NULL;
             return;
+
+        case IEC_PASSWORD:
+        {
+            char decoded[USER_PASS_LEN];
+            CLEAR(decoded);
+
+            buffer_list_aggregate(man->connection.in_extra,
+                                  OPENVPN_BASE64_LENGTH(USER_PASS_LEN) + 1=
024);
+            struct buffer *buf =3D buffer_list_peek(man->connection.in_ext=
ra);
+
+            if (buf && BLEN(buf) > 0)
+            {
+                if (OPENVPN_BASE64_DECODED_LENGTH(BLEN(buf)) >=3D USER_PAS=
S_LEN)
+                {
+                    msg(M_CLIENT, "ERROR: password too long");
+                    buf_clear(buf);
+                    break;
+                }
+                int len =3D openvpn_base64_decode(BSTR(buf), decoded,
+                                                USER_PASS_LEN - 1);
+                if (len < 0)
+                {
+                    msg(M_CLIENT, "ERROR: could not base64-decode password=
");
+                    buf_clear(buf);
+                    break;
+                }
+                decoded[len] =3D '\0';
+                buf_clear(buf);
+            }
+
+            man_query_password(man, man->connection.up_query_type,
+                               decoded);
+            secure_memzero(decoded, sizeof(decoded));
+            break;
+        }
     }
     in_extra_reset(&man->connection, IER_RESET);
 }
@@ -1598,9 +1672,20 @@
     }
     else if (streq(p[0], "password"))
     {
-        if (man_need(man, p, 2, 0))
+        if (man_need(man, p, 1, MN_AT_LEAST))
         {
-            man_query_password(man, p[1], p[2]);
+            if (p[2])
+            {
+                man_query_password(man, p[1], p[2]);
+            }
+            else if (man->connection.client_version >=3D MCV_MULTILINE_PAS=
SWORD)
+            {
+                man_query_password_base64(man, p[1]);
+            }
+            else
+            {
+                msg(M_CLIENT, "ERROR: the 'password' command requires 2 pa=
rameters");
+            }
         }
     }
     else if (streq(p[0], "forget-passwords"))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index e5ad23f..27d3b60 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -50,7 +50,7 @@
 #include "socket_util.h"
 #include "mroute.h"

-#define MANAGEMENT_VERSION                  5
+#define MANAGEMENT_VERSION                  6
 #define MANAGEMENT_N_PASSWORD_RETRIES       3
 #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100
 #define MANAGEMENT_ECHO_BUFFER_SIZE         100
@@ -297,6 +297,7 @@
 #define IEC_RSA_SIGN    3
 #define IEC_CERTIFICATE 4
 #define IEC_PK_SIGN     5
+#define IEC_PASSWORD    6
     int in_extra_cmd;
     struct buffer_list *in_extra;
     unsigned long in_extra_cid;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Gerrit-Change-Number: 1593
Gerrit-PatchSet: 9
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: cron2 <gert@...1296...>

--aLs5482bMYg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, cron2, plaisthos. </p>
<p>Bluca <strong>uploaded patch set #9</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">management: add base64 multi-line input for passwords<b=
r><br>Allow management clients to send long passwords via the<br>usual mult=
i-line base64 encoded protocol.<br><br>A client declares MCV 5 support and =
sends a &#39;password &lt;type&gt;&#39;<br>line, followed by as many lines =
(each up to 1024 bytes) as<br>needed, in base64 encoded format, terminated =
by &#39;END&#39;.<br><br>This is useful when a password is a JIT-generated =
use-once<br>token.<br><br>Declare management version 6 for this feature.<br=
><br>Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233<br>Signed-off-by:=
 Luca Boccassi &lt;luca.boccassi@...277...&gt;<br>---<br>M doc/management-n=
otes.txt<br>M src/openvpn/manage.c<br>M src/openvpn/manage.h<br>3 files cha=
nged, 106 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1593/9</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/doc/management-notes.txt b/doc/management-notes.txt</span><br><spa=
n>index 7da4aaf..4cb3815 100644</span><br><span>--- a/doc/management-notes.=
txt</span><br><span>+++ b/doc/management-notes.txt</span><br><span>@@ -326,=
6 +326,22 @@</span><br><span>   The escaping rules are the same as for the =
config file.</span><br><span>   See the &quot;Command Parsing&quot; section=
 below for more info.</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+  If the password is too long to fit in a single comman=
d line</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  (longer tha=
n 256 bytes), the management interface client should</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  use the multi-line base64 format instea=
d.  This requires that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+  the management client has announced version &gt;=3D 5 via the</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+  &quot;version&quot; comman=
d:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    password &quot;Auth&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    [BASE64_PASSWORD_LINE]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ...</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    END</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  In this format, the password is base64-encoded and split a=
cross</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  multiple lin=
es, followed by END.  Each line can be at most 1024</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  bytes.  This is the same format used by=
 pk-sig and certificate</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  commands. Requires OpenVPN management version &gt;=3D 6.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   The PASSWORD=
 real-time message type can also be used to</span><br><span>   indicate pas=
sword or other types of authentication failure:</span><br><span> </span><br=
><span>@@ -513,6 +529,7 @@</span><br><span>     &gt;PK_SIGN:[base64]       =
    -- version 2 or greater</span><br><span>     &gt;PK_SIGN:[base64],[alg]=
     -- version 3 or greater</span><br><span>     &gt;PASSWORD:Need &#39;Au=
th&#39; username -- version 4 or greater</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    &gt;PASSWORD:multiline password from client -- ver=
sion 5 or greater</span><br><span> </span><br><span> COMMAND -- auth-retry<=
/span><br><span> ---------------------</span><br><span>diff --git a/src/ope=
nvpn/manage.c b/src/openvpn/manage.c</span><br><span>index 6cab7db..c22a2a4=
 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/sr=
c/openvpn/manage.c</span><br><span>@@ -31,6 +31,7 @@</span><br><span> #incl=
ude &quot;error.h&quot;</span><br><span> #include &quot;fdmisc.h&quot;</spa=
n><br><span> #include &quot;options.h&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;base64.h&quot;</span><br><span> #inc=
lude &quot;sig.h&quot;</span><br><span> #include &quot;event.h&quot;</span>=
<br><span> #include &quot;otime.h&quot;</span><br><span>@@ -68,6 +69,7 @@</=
span><br><span>     MCV_PKSIGN =3D 2,</span><br><span>     MCV_PKSIGN_ALG =
=3D 3,</span><br><span>     MCV_USERNAME_ONLY =3D 4,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    MCV_MULTILINE_PASSWORD =3D 5,</span><=
br><span> };</span><br><span> </span><br><span> struct management *manageme=
nt; /* GLOBAL */</span><br><span>@@ -105,6 +107,8 @@</span><br><span>     m=
sg(M_CLIENT, &quot;                         where action is reply string.&q=
uot;);</span><br><span>     msg(M_CLIENT, &quot;net                    : (W=
indows only) Show network info and routing table.&quot;);</span><br><span> =
    msg(M_CLIENT, &quot;password type p        : Enter password p for a que=
ried OpenVPN password.&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    msg(M_CLIENT, &quot;password type          : (version &gt;=
=3D5) Enter password base64-encoded on&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;                        =
 subsequent lines followed by END.&quot;);</span><br><span>     msg(M_CLIEN=
T, &quot;remote type [host port] : Override remote directive, type=3DACCEPT=
|MOD|SKIP.&quot;);</span><br><span>     msg(M_CLIENT, &quot;remote-entry-co=
unt     : Get number of available remote entries.&quot;);</span><br><span> =
    msg(M_CLIENT, &quot;remote-entry-get  i|all [j]: Get remote entry at in=
dex =3D i to to j-1 or all.&quot;);</span><br><span>@@ -1019,6 +1023,41 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * Enter multi-line base64 mode for receiving a pas=
sword that exceeds the</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * single-line parameter size limit. The management client sends:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  password TYPE</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  &lt;base64-encoded password line 1&gt=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  &lt;base64-enc=
oded password line 2&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  ...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  END=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param man           The manageme=
nt interface struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param type          The type of password being entered (e.g. &quot;Auth=
&quot;, &quot;Private Key&quot;, etc)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+man_qu=
ery_password_base64(struct management *man, const char *type)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const bool needed =3D ((man-&gt;connection.up_q=
uery_mode =3D=3D UP_QUERY_PASS</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                          || man-&gt;connection.up_query_mode =
=3D=3D UP_QUERY_USER_PASS)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                         &amp;&amp; man-&gt;connection.up_query_type=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!needed)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR:=
 no password is currently needed at this time&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!man-&gt;connection.up_query_type || !streq(man-&gt=
;connection.up_query_type, type))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_CLIENT, &quot;ERROR: password of type &#39;%s&#39; entered, b=
ut we need one of type &#39;%s&#39;&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            type, man-&gt;connection.up_query_type);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct man_connection *mc =3D &am=
p;man-&gt;connection;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    mc-&gt;in_extra_cmd =3D IEC_PASSWORD;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    in_extra_reset(mc, IER_NEW);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> static void</span><br><span> in_extra_=
dispatch(struct management *man)</span><br><span> {</span><br><span>@@ -105=
2,6 +1091,41 @@</span><br><span>             man-&gt;connection.ext_cert_in=
put =3D man-&gt;connection.in_extra;</span><br><span>             man-&gt;c=
onnection.in_extra =3D NULL;</span><br><span>             return;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case IEC_PASSWORD:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            char decoded[USER_PASS_LEN];</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(decoded);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            buffer_list_aggregate(man-&gt=
;connection.in_extra,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                  OPENVPN_BASE64_LENGTH(USER_PASS_LEN) + =
1024);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            s=
truct buffer *buf =3D buffer_list_peek(man-&gt;connection.in_extra);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (buf &amp;&amp; BLEN(buf) &gt;=
 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (OP=
ENVPN_BASE64_DECODED_LENGTH(BLEN(buf)) &gt;=3D USER_PASS_LEN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_CLIENT, &=
quot;ERROR: password too long&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    buf_clear(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                int len =3D openvpn_=
base64_decode(BSTR(buf), decoded,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                                USER_PASS_LEN=
 - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (len &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 msg(M_CLIENT, &quot;ERROR: could not base64-decode passwor=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          buf_clear(buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                decoded[len] =3D &#39;\0&#39;;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                buf_clear(buf);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            man_query_password(man, man-&gt;connec=
tion.up_query_type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                               decoded);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            secure_memzero(decoded, sizeof(decoded));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>     }</span><br><span>     in_extra_reset(&amp;man-&gt;connection, IE=
R_RESET);</span><br><span> }</span><br><span>@@ -1598,9 +1672,20 @@</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;password&qu=
ot;))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (man_need(man, p, 2, 0))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (man_need(man, p, 1, MN_AT_LEAST))</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           man_query_password(man, p[1], p[2]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (p[2])</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                man_query_password(man, p[1], p[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (man=
-&gt;connection.client_version &gt;=3D MCV_MULTILINE_PASSWORD)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                man_query_password_bas=
e64(man, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg=
(M_CLIENT, &quot;ERROR: the &#39;password&#39; command requires 2 parameter=
s&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span>         }</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;forget-passwords&quot;))</span><br><span>diff --=
git a/src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index e5a=
d23f..27d3b60 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><=
span>+++ b/src/openvpn/manage.h</span><br><span>@@ -50,7 +50,7 @@</span><br=
><span> #include &quot;socket_util.h&quot;</span><br><span> #include &quot;=
mroute.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define MANAGEMENT_VERSION                  5</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define MANAGEMENT_VERSION            =
      6</span><br><span> #define MANAGEMENT_N_PASSWORD_RETRIES       3</spa=
n><br><span> #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE 100</span><br><spa=
n> #define MANAGEMENT_ECHO_BUFFER_SIZE         100</span><br><span>@@ -297,=
6 +297,7 @@</span><br><span> #define IEC_RSA_SIGN    3</span><br><span> #de=
fine IEC_CERTIFICATE 4</span><br><span> #define IEC_PK_SIGN     5</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PASSWORD    6</sp=
an><br><span>     int in_extra_cmd;</span><br><span>     struct buffer_list=
 *in_extra;</span><br><span>     unsigned long in_extra_cid;</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1593?usp=3Demail">change 1593</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1593?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8e=
be21ac958f233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1593 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--aLs5482bMYg=--

