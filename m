From: "Bluca (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 22:31:14 +0000
References: <gerrit.1774477871000.Ib99f171fb69d51f2260b44edf8ebe21ac958f233@...2715...>
Reply-To: luca.boccassi@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1d6c3e9d295104bc4ebae06fb0bde6a37d6519f7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bJwtOixZJEA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: management: add
 password-base64 multi-line input for passwords
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bJwtOixZJEA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail

to review the following change.


Change subject: management: add password-base64 multi-line input for passwo=
rds
......................................................................

management: add password-base64 multi-line input for passwords

Allow management clients to send long passwords via the
usual multi-line base64 encoded protocol.

A client sends a 'password-base64 <type>' line, followed by
as many lines (each up to 1024 bytes) as needed, in base64
encoded format, terminated by 'END'.

This is useful when a password is a JIT-generated use-once
token.

Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Signed-off-by: Luca Boccassi <luca.boccassi@...277...>
---
M doc/management-notes.txt
M src/openvpn/manage.c
M src/openvpn/manage.h
3 files changed, 88 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1593/1

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 41e2a91..f3373d4 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -313,6 +313,21 @@
   The escaping rules are the same as for the config file.
   See the "Command Parsing" section below for more info.

+  If the password is too long to fit in a single command line
+  (longer than 256 bytes), the management interface client should
+  use the password-base64 command with multi-line base64 format
+  instead:
+
+    password-base64 "Auth"
+    [BASE64_PASSWORD_LINE]
+    ...
+    END
+
+  In this format, the password is base64-encoded and split across
+  multiple lines, followed by END.  Each line can be at most 1024
+  bytes.  This is the same format used by pk-sig and certificate
+  commands.
+
   The PASSWORD real-time message type can also be used to
   indicate password or other types of authentication failure:

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index df72f15..c4db3b0 100644
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
@@ -107,6 +108,8 @@
     msg(M_CLIENT, "                         where action is reply string."=
);
     msg(M_CLIENT, "net                    : (Windows only) Show network in=
fo and routing table.");
     msg(M_CLIENT, "password type p        : Enter password p for a queried=
 OpenVPN password.");
+    msg(M_CLIENT, "password-base64 type   : Enter password for a queried O=
penVPN password");
+    msg(M_CLIENT, "                         base64-encoded on subsequent l=
ines followed by END.");
     msg(M_CLIENT, "remote type [host port] : Override remote directive, ty=
pe=3DACCEPT|MOD|SKIP.");
     msg(M_CLIENT, "remote-entry-count     : Get number of available remote=
 entries.");
     msg(M_CLIENT, "remote-entry-get  i|all [j]: Get remote entry at index =
=3D i to to j-1 or all.");
@@ -1012,6 +1015,41 @@
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
TLS-Auth", etc)
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
@@ -1045,6 +1083,33 @@
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
+                                  OPENVPN_BASE64_LENGTH(USER_PASS_LEN));
+            struct buffer *buf =3D buffer_list_peek(man->connection.in_ext=
ra);
+
+            if (buf && BLEN(buf) > 0)
+            {
+                int len =3D openvpn_base64_decode(BSTR(buf), decoded,
+                                                USER_PASS_LEN - 1);
+                if (len < 0)
+                {
+                    msg(M_CLIENT, "ERROR: could not base64-decode password=
");
+                    break;
+                }
+                decoded[len] =3D '\0';
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
@@ -1596,6 +1661,13 @@
             man_query_password(man, p[1], p[2]);
         }
     }
+    else if (streq(p[0], "password-base64"))
+    {
+        if (man_need(man, p, 1, 0))
+        {
+            man_query_password_base64(man, p[1]);
+        }
+    }
     else if (streq(p[0], "forget-passwords"))
     {
         man_forget_passwords(man);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 38f437f..797021d 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -296,6 +296,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958f233
Gerrit-Change-Number: 1593
Gerrit-PatchSet: 1
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--bJwtOixZJEA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>Bluca would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1593?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">management: add password-base64 multi-line =
input for passwords<br><br>Allow management clients to send long passwords =
via the<br>usual multi-line base64 encoded protocol.<br><br>A client sends =
a &#39;password-base64 &lt;type&gt;&#39; line, followed by<br>as many lines=
 (each up to 1024 bytes) as needed, in base64<br>encoded format, terminated=
 by &#39;END&#39;.<br><br>This is useful when a password is a JIT-generated=
 use-once<br>token.<br><br>Change-Id: Ib99f171fb69d51f2260b44edf8ebe21ac958=
f233<br>Signed-off-by: Luca Boccassi &lt;luca.boccassi@...277...&gt;<br>---=
<br>M doc/management-notes.txt<br>M src/openvpn/manage.c<br>M src/openvpn/m=
anage.h<br>3 files changed, 88 insertions(+), 0 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/9=
3/1593/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/doc/management-notes.txt b/doc/management-not=
es.txt</span><br><span>index 41e2a91..f3373d4 100644</span><br><span>--- a/=
doc/management-notes.txt</span><br><span>+++ b/doc/management-notes.txt</sp=
an><br><span>@@ -313,6 +313,21 @@</span><br><span>   The escaping rules are=
 the same as for the config file.</span><br><span>   See the &quot;Command =
Parsing&quot; section below for more info.</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  If the password is too long to f=
it in a single command line</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+  (longer than 256 bytes), the management interface client should</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+  use the password-ba=
se64 command with multi-line base64 format</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+  instead:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
assword-base64 &quot;Auth&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    [BASE64_PASSWORD_LINE]</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ...</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+  In this format, the pa=
ssword is base64-encoded and split across</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+  multiple lines, followed by END.  Each line can be =
at most 1024</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  bytes=
.  This is the same format used by pk-sig and certificate</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+  commands.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span>   The PASSWORD real-time me=
ssage type can also be used to</span><br><span>   indicate password or othe=
r types of authentication failure:</span><br><span> </span><br><span>diff -=
-git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index df=
72f15..c4db3b0 100644</span><br><span>--- a/src/openvpn/manage.c</span><br>=
<span>+++ b/src/openvpn/manage.c</span><br><span>@@ -31,6 +31,7 @@</span><b=
r><span> #include &quot;error.h&quot;</span><br><span> #include &quot;fdmis=
c.h&quot;</span><br><span> #include &quot;options.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#include &quot;base64.h&quot;</span><=
br><span> #include &quot;sig.h&quot;</span><br><span> #include &quot;event.=
h&quot;</span><br><span> #include &quot;otime.h&quot;</span><br><span>@@ -1=
07,6 +108,8 @@</span><br><span>     msg(M_CLIENT, &quot;                   =
      where action is reply string.&quot;);</span><br><span>     msg(M_CLIE=
NT, &quot;net                    : (Windows only) Show network info and rou=
ting table.&quot;);</span><br><span>     msg(M_CLIENT, &quot;password type =
p        : Enter password p for a queried OpenVPN password.&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &quot;pas=
sword-base64 type   : Enter password for a queried OpenVPN password&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_CLIENT, &=
quot;                         base64-encoded on subsequent lines followed b=
y END.&quot;);</span><br><span>     msg(M_CLIENT, &quot;remote type [host p=
ort] : Override remote directive, type=3DACCEPT|MOD|SKIP.&quot;);</span><br=
><span>     msg(M_CLIENT, &quot;remote-entry-count     : Get number of avai=
lable remote entries.&quot;);</span><br><span>     msg(M_CLIENT, &quot;remo=
te-entry-get  i|all [j]: Get remote entry at index =3D i to to j-1 or all.&=
quot;);</span><br><span>@@ -1012,6 +1015,41 @@</span><br><span>     }</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * E=
nter multi-line base64 mode for receiving a password that exceeds the</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * single-line parameter =
size limit. The management client sends:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  password TYPE</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *  &lt;base64-encoded password line 1&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  &lt;base64-encoded password line 2&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ...</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  END</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param man           The management interface struct</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param type          The type=
 of password being entered (e.g. &quot;Auth&quot;, &quot;TLS-Auth&quot;, et=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+man_query_password_base64(struct manageme=
nt *man, const char *type)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const b=
ool needed =3D ((man-&gt;connection.up_query_mode =3D=3D UP_QUERY_PASS</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
  || man-&gt;connection.up_query_mode =3D=3D UP_QUERY_USER_PASS)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                         &amp;=
&amp; man-&gt;connection.up_query_type);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!needed)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_CLIENT, &quot;ERROR: no password is currently needed at t=
his time&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!man-&gt;conn=
ection.up_query_type || !streq(man-&gt;connection.up_query_type, type))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: pa=
ssword of type &#39;%s&#39; entered, but we need one of type &#39;%s&#39;&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ty=
pe, man-&gt;connection.up_query_type);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct man_connection *mc =3D &amp;man-&gt;connection;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    mc-&gt;in_extra_cmd =3D IEC_PAS=
SWORD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_extra_=
reset(mc, IER_NEW);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
static void</span><br><span> in_extra_dispatch(struct management *man)</spa=
n><br><span> {</span><br><span>@@ -1045,6 +1083,33 @@</span><br><span>     =
        man-&gt;connection.ext_cert_input =3D man-&gt;connection.in_extra;<=
/span><br><span>             man-&gt;connection.in_extra =3D NULL;</span><b=
r><span>             return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ca=
se IEC_PASSWORD:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c=
har decoded[USER_PASS_LEN];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            CLEAR(decoded);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         buffer_list_aggregate(man-&gt;connection.in_extra,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                  O=
PENVPN_BASE64_LENGTH(USER_PASS_LEN));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            struct buffer *buf =3D buffer_list_peek(man-&=
gt;connection.in_extra);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                int len =3D openvpn_base64_decode(BSTR(buf), decod=
ed,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                                USER_PASS_LEN - 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                if (len &lt; 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_CLIEN=
T, &quot;ERROR: could not base64-decode password&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                decoded[len] =3D =
&#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            man_query_password(=
man, man-&gt;connection.up_query_type,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                               decoded);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            secure_memzero(decoded,=
 sizeof(decoded));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span>     }</span><br><span>     in_extra_reset(&amp;man=
-&gt;connection, IER_RESET);</span><br><span> }</span><br><span>@@ -1596,6 =
+1661,13 @@</span><br><span>             man_query_password(man, p[1], p[2]=
);</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;password-b=
ase64&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man_need=
(man, p, 1, 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ma=
n_query_password_base64(man, p[1]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span>     else if (streq(p[0], &quot;forget-password=
s&quot;))</span><br><span>     {</span><br><span>         man_forget_passwo=
rds(man);</span><br><span>diff --git a/src/openvpn/manage.h b/src/openvpn/m=
anage.h</span><br><span>index 38f437f..797021d 100644</span><br><span>--- a=
/src/openvpn/manage.h</span><br><span>+++ b/src/openvpn/manage.h</span><br>=
<span>@@ -296,6 +296,7 @@</span><br><span> #define IEC_RSA_SIGN    3</span>=
<br><span> #define IEC_CERTIFICATE 4</span><br><span> #define IEC_PK_SIGN  =
   5</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define IEC_PAS=
SWORD    6</span><br><span>     int in_extra_cmd;</span><br><span>     stru=
ct buffer_list *in_extra;</span><br><span>     unsigned long in_extra_cid;<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1593?usp=3Demail">change 1593</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1593?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib99f171fb69d51f2260b44edf8e=
be21ac958f233 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1593 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--bJwtOixZJEA=--

