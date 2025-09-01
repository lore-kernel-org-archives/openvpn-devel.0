From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 1 Sep 2025 15:09:33 +0000
In-Reply-To: <gerrit.1753360288000.I0937165c5efa95136bd951345a076e33e396f26a@...2715...>
References: <gerrit.1753360288000.I0937165c5efa95136bd951345a076e33e396f26a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1cd404225f56f29329624f7964161c06c58d45d3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ixDkt0oFa0Q="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: manage: Make sure
 various management flags are treated as unsigned
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

--ixDkt0oFa0Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1105?usp=3Demail

to look at the new patch set (#10).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: manage: Make sure various management flags are treated as u=
nsigned
......................................................................

manage: Make sure various management flags are treated as unsigned

The variables that hold them are already unsigned, make sure
the flags are as well to avoid spurious conversion warnings.

Change-Id: I0937165c5efa95136bd951345a076e33e396f26a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/init.c
M src/openvpn/manage.h
M src/openvpn/options.h
3 files changed, 41 insertions(+), 41 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/05/1105/10

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9dd3b96..39ea8e4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -370,7 +370,7 @@
         && ((ce->flags >> CE_MAN_QUERY_REMOTE_SHIFT) & CE_MAN_QUERY_REMOTE=
_MASK)
                =3D=3D CE_MAN_QUERY_REMOTE_QUERY)
     {
-        int flags =3D 0;
+        unsigned int flags =3D 0;
         if (!strcmp(p[1], "ACCEPT"))
         {
             flags =3D CE_MAN_QUERY_REMOTE_ACCEPT;
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index b8892c8..e9e1f95 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -24,24 +24,24 @@
 #define MANAGE_H

 /* management_open flags */
-#define MF_SERVER                 (1 << 0)
-#define MF_QUERY_PASSWORDS        (1 << 1)
-#define MF_HOLD                   (1 << 2)
-#define MF_SIGNAL                 (1 << 3)
-#define MF_FORGET_DISCONNECT      (1 << 4)
-#define MF_CONNECT_AS_CLIENT      (1 << 5)
-#define MF_CLIENT_AUTH            (1 << 6)
-/* #define MF_CLIENT_PF         (1<<7) *REMOVED FEATURE* */
-#define MF_UNIX_SOCK              (1 << 8)
-#define MF_EXTERNAL_KEY           (1 << 9)
-#define MF_EXTERNAL_KEY_NOPADDING (1 << 10)
-#define MF_EXTERNAL_KEY_PKCS1PAD  (1 << 11)
-#define MF_UP_DOWN                (1 << 12)
-#define MF_QUERY_REMOTE           (1 << 13)
-#define MF_QUERY_PROXY            (1 << 14)
-#define MF_EXTERNAL_CERT          (1 << 15)
-#define MF_EXTERNAL_KEY_PSSPAD    (1 << 16)
-#define MF_EXTERNAL_KEY_DIGEST    (1 << 17)
+#define MF_SERVER                 (1u << 0)
+#define MF_QUERY_PASSWORDS        (1u << 1)
+#define MF_HOLD                   (1u << 2)
+#define MF_SIGNAL                 (1u << 3)
+#define MF_FORGET_DISCONNECT      (1u << 4)
+#define MF_CONNECT_AS_CLIENT      (1u << 5)
+#define MF_CLIENT_AUTH            (1u << 6)
+/* #define MF_CLIENT_PF              (1u << 7) *REMOVED FEATURE* */
+#define MF_UNIX_SOCK              (1u << 8)
+#define MF_EXTERNAL_KEY           (1u << 9)
+#define MF_EXTERNAL_KEY_NOPADDING (1u << 10)
+#define MF_EXTERNAL_KEY_PKCS1PAD  (1u << 11)
+#define MF_UP_DOWN                (1u << 12)
+#define MF_QUERY_REMOTE           (1u << 13)
+#define MF_QUERY_PROXY            (1u << 14)
+#define MF_EXTERNAL_CERT          (1u << 15)
+#define MF_EXTERNAL_KEY_PSSPAD    (1u << 16)
+#define MF_EXTERNAL_KEY_DIGEST    (1u << 17)


 #ifdef ENABLE_MANAGEMENT
@@ -64,9 +64,9 @@
 {
     unsigned long cid;

-#define DAF_CONNECTION_ESTABLISHED (1 << 0)
-#define DAF_CONNECTION_CLOSED      (1 << 1)
-#define DAF_INITIAL_AUTH           (1 << 2)
+#define DAF_CONNECTION_ESTABLISHED (1u << 0)
+#define DAF_CONNECTION_CLOSED      (1u << 1)
+#define DAF_INITIAL_AUTH           (1u << 2)
     unsigned int flags;

     unsigned int mda_key_id_counter;
@@ -117,23 +117,23 @@
     union log_entry_union u;
 };

-#define LOG_PRINT_LOG_PREFIX   (1 << 0)
-#define LOG_PRINT_ECHO_PREFIX  (1 << 1)
-#define LOG_PRINT_STATE_PREFIX (1 << 2)
+#define LOG_PRINT_LOG_PREFIX   (1u << 0)
+#define LOG_PRINT_ECHO_PREFIX  (1u << 1)
+#define LOG_PRINT_STATE_PREFIX (1u << 2)

-#define LOG_PRINT_INT_DATE  (1 << 3)
-#define LOG_PRINT_MSG_FLAGS (1 << 4)
-#define LOG_PRINT_STATE     (1 << 5)
-#define LOG_PRINT_LOCAL_IP  (1 << 6)
+#define LOG_PRINT_INT_DATE  (1u << 3)
+#define LOG_PRINT_MSG_FLAGS (1u << 4)
+#define LOG_PRINT_STATE     (1u << 5)
+#define LOG_PRINT_LOCAL_IP  (1u << 6)

-#define LOG_PRINT_CRLF   (1 << 7)
-#define LOG_FATAL_NOTIFY (1 << 8)
+#define LOG_PRINT_CRLF   (1u << 7)
+#define LOG_FATAL_NOTIFY (1u << 8)

-#define LOG_PRINT_INTVAL (1 << 9)
+#define LOG_PRINT_INTVAL (1u << 9)
=20
-#define LOG_PRINT_REMOTE_IP (1 << 10)
+#define LOG_PRINT_REMOTE_IP (1u << 10)

-#define LOG_ECHO_TO_LOG (1 << 11)
+#define LOG_ECHO_TO_LOG (1u << 11)

 const char *log_entry_print(const struct log_entry *e, unsigned int flags,=
 struct gc_arena *gc);

@@ -175,7 +175,7 @@
 {
     void *arg;

-#define MCF_SERVER (1 << 0) /* is OpenVPN being run as a server? */
+#define MCF_SERVER (1u << 0) /* is OpenVPN being run as a server? */
     unsigned int flags;

     void (*status)(void *arg, const int version, struct status_output *so);
@@ -253,9 +253,9 @@
     int client_gid;

 /* flags for handling the management interface "signal" command */
-#define MANSIG_IGNORE_USR1_HUP  (1 << 0)
-#define MANSIG_MAP_USR1_TO_HUP  (1 << 1)
-#define MANSIG_MAP_USR1_TO_TERM (1 << 2)
+#define MANSIG_IGNORE_USR1_HUP  (1u << 0)
+#define MANSIG_MAP_USR1_TO_HUP  (1u << 1)
+#define MANSIG_MAP_USR1_TO_TERM (1u << 2)
     unsigned int mansig;
 };

diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 44f3fc9..bb2c052 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -147,14 +147,14 @@
     int explicit_exit_notification; /* Explicitly tell peer when we are ex=
iting via OCC_EXIT or
                                        [RESTART] message */
=20
-#define CE_DISABLED                (1 << 0)
-#define CE_MAN_QUERY_PROXY         (1 << 1)
+#define CE_DISABLED                (1u << 0)
+#define CE_MAN_QUERY_PROXY         (1u << 1)
 #define CE_MAN_QUERY_REMOTE_UNDEF  0
 #define CE_MAN_QUERY_REMOTE_QUERY  1
 #define CE_MAN_QUERY_REMOTE_ACCEPT 2
 #define CE_MAN_QUERY_REMOTE_MOD    3
 #define CE_MAN_QUERY_REMOTE_SKIP   4
-#define CE_MAN_QUERY_REMOTE_MASK   (0x07)
+#define CE_MAN_QUERY_REMOTE_MASK   (0x07u)
 #define CE_MAN_QUERY_REMOTE_SHIFT  (2)
     unsigned int flags;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1105?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0937165c5efa95136bd951345a076e33e396f26a
Gerrit-Change-Number: 1105
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ixDkt0oFa0Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>flichtenheld <strong>uploaded patch set #10</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1105?usp=3Demail">View =
Change</a></p><p>The change is no longer submittable: checks~ChecksSubmitRu=
le is unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">manage: Make sure various management flags are treat=
ed as unsigned<br><br>The variables that hold them are already unsigned, ma=
ke sure<br>the flags are as well to avoid spurious conversion warnings.<br>=
<br>Change-Id: I0937165c5efa95136bd951345a076e33e396f26a<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/init.c<b=
r>M src/openvpn/manage.h<br>M src/openvpn/options.h<br>3 files changed, 41 =
insertions(+), 41 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/05/1105/10</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/init=
.c b/src/openvpn/init.c</span><br><span>index 9dd3b96..39ea8e4 100644</span=
><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.=
c</span><br><span>@@ -370,7 +370,7 @@</span><br><span>         &amp;&amp; (=
(ce-&gt;flags &gt;&gt; CE_MAN_QUERY_REMOTE_SHIFT) &amp; CE_MAN_QUERY_REMOTE=
_MASK)</span><br><span>                =3D=3D CE_MAN_QUERY_REMOTE_QUERY)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       int flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        unsigned int flags =3D 0;</span><br><span>         if (!strcmp(=
p[1], &quot;ACCEPT&quot;))</span><br><span>         {</span><br><span>     =
        flags =3D CE_MAN_QUERY_REMOTE_ACCEPT;</span><br><span>diff --git a/=
src/openvpn/manage.h b/src/openvpn/manage.h</span><br><span>index b8892c8..=
e9e1f95 100644</span><br><span>--- a/src/openvpn/manage.h</span><br><span>+=
++ b/src/openvpn/manage.h</span><br><span>@@ -24,24 +24,24 @@</span><br><sp=
an> #define MANAGE_H</span><br><span> </span><br><span> /* management_open =
flags */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MF_SE=
RVER                 (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#define MF_QUERY_PASSWORDS        (1 &lt;&lt; 1)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define MF_HOLD                   =
(1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 MF_SIGNAL                 (1 &lt;&lt; 3)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define MF_FORGET_DISCONNECT      (1 &lt;&lt; 4)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define MF_CONNECT_AS_CLIENT=
      (1 &lt;&lt; 5)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define MF_CLIENT_AUTH            (1 &lt;&lt; 6)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/* #define MF_CLIENT_PF         (1&lt;&lt;7) *REM=
OVED FEATURE* */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne MF_UNIX_SOCK              (1 &lt;&lt; 8)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define MF_EXTERNAL_KEY           (1 &lt;&lt; 9)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MF_EXTERNAL_KEY_NO=
PADDING (1 &lt;&lt; 10)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define MF_EXTERNAL_KEY_PKCS1PAD  (1 &lt;&lt; 11)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define MF_UP_DOWN                (1 &lt;&l=
t; 12)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MF_QUER=
Y_REMOTE           (1 &lt;&lt; 13)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define MF_QUERY_PROXY            (1 &lt;&lt; 14)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define MF_EXTERNAL_CERT          =
(1 &lt;&lt; 15)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e MF_EXTERNAL_KEY_PSSPAD    (1 &lt;&lt; 16)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define MF_EXTERNAL_KEY_DIGEST    (1 &lt;&lt; 17)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF_SERVER      =
           (1u &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define MF_QUERY_PASSWORDS        (1u &lt;&lt; 1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define MF_HOLD                   (1u =
&lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
MF_SIGNAL                 (1u &lt;&lt; 3)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define MF_FORGET_DISCONNECT      (1u &lt;&lt; 4)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF_CONNECT_AS_C=
LIENT      (1u &lt;&lt; 5)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define MF_CLIENT_AUTH            (1u &lt;&lt; 6)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* #define MF_CLIENT_PF              (=
1u &lt;&lt; 7) *REMOVED FEATURE* */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define MF_UNIX_SOCK              (1u &lt;&lt; 8)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define MF_EXTERNAL_KEY      =
     (1u &lt;&lt; 9)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define MF_EXTERNAL_KEY_NOPADDING (1u &lt;&lt; 10)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MF_EXTERNAL_KEY_PKCS1PAD  (1u &lt=
;&lt; 11)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF=
_UP_DOWN                (1u &lt;&lt; 12)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define MF_QUERY_REMOTE           (1u &lt;&lt; 13)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MF_QUERY_PROXY =
           (1u &lt;&lt; 14)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define MF_EXTERNAL_CERT          (1u &lt;&lt; 15)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define MF_EXTERNAL_KEY_PSSPAD    (1=
u &lt;&lt; 16)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defi=
ne MF_EXTERNAL_KEY_DIGEST    (1u &lt;&lt; 17)</span><br><span> </span><br><=
span> </span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>@@ -64,9 +=
64,9 @@</span><br><span> {</span><br><span>     unsigned long cid;</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define DAF_=
CONNECTION_ESTABLISHED (1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#define DAF_CONNECTION_CLOSED      (1 &lt;&lt; 1)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define DAF_INITIAL_AUTH       =
    (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define DAF_CONNECTION_ESTABLISHED (1u &lt;&lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define DAF_CONNECTION_CLOSED      (1u &lt;&l=
t; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define DAF_IN=
ITIAL_AUTH           (1u &lt;&lt; 2)</span><br><span>     unsigned int flag=
s;</span><br><span> </span><br><span>     unsigned int mda_key_id_counter;<=
/span><br><span>@@ -117,23 +117,23 @@</span><br><span>     union log_entry_=
union u;</span><br><span> };</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#define LOG_PRINT_LOG_PREFIX   (1 &lt;&lt; 0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#define LOG_PRINT_ECHO_PRE=
FIX  (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine LOG_PRINT_STATE_PREFIX (1 &lt;&lt; 2)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define LOG_PRINT_LOG_PREFIX   (1u &lt;&lt; 0)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#define LOG_PRINT_ECHO_P=
REFIX  (1u &lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define LOG_PRINT_STATE_PREFIX (1u &lt;&lt; 2)</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#define LOG_PRINT_INT_DATE  (=
1 &lt;&lt; 3)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
LOG_PRINT_MSG_FLAGS (1 &lt;&lt; 4)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#define LOG_PRINT_STATE     (1 &lt;&lt; 5)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define LOG_PRINT_LOCAL_IP  (1 &lt;&lt; 6=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define LOG_PRINT_=
INT_DATE  (1u &lt;&lt; 3)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define LOG_PRINT_MSG_FLAGS (1u &lt;&lt; 4)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define LOG_PRINT_STATE     (1u &lt;&lt; 5)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define LOG_PRINT_LOC=
AL_IP  (1u &lt;&lt; 6)</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define LOG_PRINT_CRLF   (1 &lt;&lt; 7)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#define LOG_FATAL_NOTIFY (1 &lt;&lt; 8=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define LOG_PRINT_=
CRLF   (1u &lt;&lt; 7)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define LOG_FATAL_NOTIFY (1u &lt;&lt; 8)</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#define LOG_PRINT_INTVAL (1 &lt;&lt=
; 9)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define LOG_PRI=
NT_INTVAL (1u &lt;&lt; 9)</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#define LOG_PRINT_REMOTE_IP (1 &lt;&lt; 10)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define LOG_PRINT_REMOTE_IP (=
1u &lt;&lt; 10)</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define LOG_ECHO_TO_LOG (1 &lt;&lt; 11)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define LOG_ECHO_TO_LOG (1u &lt;&lt; 11)<=
/span><br><span> </span><br><span> const char *log_entry_print(const struct=
 log_entry *e, unsigned int flags, struct gc_arena *gc);</span><br><span> <=
/span><br><span>@@ -175,7 +175,7 @@</span><br><span> {</span><br><span>    =
 void *arg;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define MCF_SERVER (1 &lt;&lt; 0) /* is OpenVPN being run as a serv=
er? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MCF_S=
ERVER (1u &lt;&lt; 0) /* is OpenVPN being run as a server? */</span><br><sp=
an>     unsigned int flags;</span><br><span> </span><br><span>     void (*s=
tatus)(void *arg, const int version, struct status_output *so);</span><br><=
span>@@ -253,9 +253,9 @@</span><br><span>     int client_gid;</span><br><sp=
an> </span><br><span> /* flags for handling the management interface &quot;=
signal&quot; command */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define MANSIG_IGNORE_USR1_HUP  (1 &lt;&lt; 0)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define MANSIG_MAP_USR1_TO_HUP  (1 &lt;&lt; 1)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define MANSIG_MAP_USR1=
_TO_TERM (1 &lt;&lt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define MANSIG_IGNORE_USR1_HUP  (1u &lt;&lt; 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define MANSIG_MAP_USR1_TO_HUP  (1u &lt;&=
lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MANSI=
G_MAP_USR1_TO_TERM (1u &lt;&lt; 2)</span><br><span>     unsigned int mansig=
;</span><br><span> };</span><br><span> </span><br><span>diff --git a/src/op=
envpn/options.h b/src/openvpn/options.h</span><br><span>index 44f3fc9..bb2c=
052 100644</span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ =
b/src/openvpn/options.h</span><br><span>@@ -147,14 +147,14 @@</span><br><sp=
an>     int explicit_exit_notification; /* Explicitly tell peer when we are=
 exiting via OCC_EXIT or</span><br><span>                                  =
      [RESTART] message */</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define CE_DISABLED                (1 &lt;&lt; 0)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define CE_MAN_QUERY_PRO=
XY         (1 &lt;&lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define CE_DISABLED                (1u &lt;&lt; 0)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define CE_MAN_QUERY_PROXY         (1u=
 &lt;&lt; 1)</span><br><span> #define CE_MAN_QUERY_REMOTE_UNDEF  0</span><b=
r><span> #define CE_MAN_QUERY_REMOTE_QUERY  1</span><br><span> #define CE_M=
AN_QUERY_REMOTE_ACCEPT 2</span><br><span> #define CE_MAN_QUERY_REMOTE_MOD  =
  3</span><br><span> #define CE_MAN_QUERY_REMOTE_SKIP   4</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#define CE_MAN_QUERY_REMOTE_MASK   (0x0=
7)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CE_MAN_QU=
ERY_REMOTE_MASK   (0x07u)</span><br><span> #define CE_MAN_QUERY_REMOTE_SHIF=
T  (2)</span><br><span>     unsigned int flags;</span><br><span> </span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1105?usp=3Demail">change 1105</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1105?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0937165c5efa95136bd951345a0=
76e33e396f26a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1105 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ixDkt0oFa0Q=--

