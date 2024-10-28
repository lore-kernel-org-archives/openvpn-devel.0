From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 28 Oct 2024 13:48:22 +0000
In-Reply-To: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
References: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <f89be01a5a5f97202b673843a92465cbe1b854e0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="p7hOA6zR2e0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Refuse clients if
 username or password is longer than USER_PASS_LEN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--p7hOA6zR2e0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Refuse clients if username or password is longer than USER_=
PASS_LEN
......................................................................

Refuse clients if username or password is longer than USER_PASS_LEN

When OpenVPN is compiled without PKCS11 support USER_PASS_LEN is 128
bytes. If we encounter a username larger than this length, we would
only read the 2 bytes length header of the username/password.  We did
then also NOT skip the username or password field meaning that we would
continue reading the rest of the packet at the wrong offset and get
garbage results like not having peerinfo and then rejecting a client
because of no common cipher or missing data v2 support.

This will tell the client that username/password is too regardless
of whether password/username authentication is used.  This way we
do not leak if username/password authentication is active.

To reproduce this issue have the server compiled with a USER_PASS_LEN
set to 128 (e.g. without pkcs11 or manually adjusting the define) and
have the client with a larger USER_PASS_LEN to actually be able to
send the larger password. The server must also be set to use only
certificate authentication while the client must use certificates
and auth-user-pass because otherwise the user/pass verification will
reject the empty credentials.

Using the openvpn3 test client with overlong username/password also
works.

Change-Id: I60f02c919767eb8f1b95253689a8233f5f68621d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 33 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/787/2

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e2be614..8040e7b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1835,20 +1835,33 @@
     return true;
 }

-static bool
+/**
+ * Read a string that is encoded as a 2 byte header with the length from t=
he
+ * buffer \c buf. Will return the non-negative value if reading was succes=
sful.
+ * The returned value will include the trailing 0 byte.
+ *
+ * If the message is over the capacity or could not be read
+ * it will return the negative length that was in the
+ * header and try to skip the string. If the string cannot be skipped, the
+ * buf will stay at the current position or position + 2
+ */
+static int
 read_string(struct buffer *buf, char *str, const unsigned int capacity)
 {
     const int len =3D buf_read_u16(buf);
     if (len < 1 || len > (int)capacity)
     {
-        return false;
+        buf_advance(buf, len);
+
+        /* will also return 0 for a no string being present */
+        return -len;
     }
     if (!buf_read(buf, str, len))
     {
-        return false;
+        return -len;
     }
     str[len-1] =3D '\0';
-    return true;
+    return len;
 }

 static char *
@@ -2218,8 +2231,6 @@
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];      /* primary ke=
y */

-    bool username_status, password_status;
-
     struct gc_arena gc =3D gc_new();
     char *options;
     struct user_pass *up =3D NULL;
@@ -2253,7 +2264,7 @@
     }

     /* get options */
-    if (!read_string(buf, options, TLS_OPTIONS_LEN))
+    if (read_string(buf, options, TLS_OPTIONS_LEN) < 0)
     {
         msg(D_TLS_ERRORS, "TLS Error: Failed to read required OCC options =
string");
         goto error;
@@ -2266,8 +2277,8 @@
      * peer_info data which follows behind
      */
     ALLOC_OBJ_CLEAR_GC(up, struct user_pass, &gc);
-    username_status =3D read_string(buf, up->username, USER_PASS_LEN);
-    password_status =3D read_string(buf, up->password, USER_PASS_LEN);
+    int username_len =3D read_string(buf, up->username, USER_PASS_LEN);
+    int password_len =3D read_string(buf, up->password, USER_PASS_LEN);

     /* get peer info from control channel */
     free(multi->peer_info);
@@ -2290,10 +2301,21 @@
         multi->remote_ciphername =3D string_alloc("none", NULL);
     }

-    if (tls_session_user_pass_enabled(session))
+    if (username_len < 0 || password_len < 0)
+    {
+        msg(D_TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too l=
ong",
+            abs(username_len), abs(password_len));
+        auth_set_client_reason(multi, "Username or password is too long. "
+                               "Maximum length is 128 bytes");
+
+        /* treat the same as failed username/password and do not error
+         * out (goto error) to sent an AUTH_FAILED back to the client */
+        ks->authenticated =3D KS_AUTH_FALSE;
+    }
+    else if (tls_session_user_pass_enabled(session))
     {
         /* Perform username/password authentication */
-        if (!username_status || !password_status)
+        if (!username_len || !password_len)
         {
             CLEAR(*up);
             if (!(session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL))

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I60f02c919767eb8f1b95253689a8233f5f68621d
Gerrit-Change-Number: 787
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--p7hOA6zR2e0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Refuse clients if username or password is longer tha=
n USER_PASS_LEN<br><br>When OpenVPN is compiled without PKCS11 support USER=
_PASS_LEN is 128<br>bytes. If we encounter a username larger than this leng=
th, we would<br>only read the 2 bytes length header of the username/passwor=
d.  We did<br>then also NOT skip the username or password field meaning tha=
t we would<br>continue reading the rest of the packet at the wrong offset a=
nd get<br>garbage results like not having peerinfo and then rejecting a cli=
ent<br>because of no common cipher or missing data v2 support.<br><br>This =
will tell the client that username/password is too regardless<br>of whether=
 password/username authentication is used.  This way we<br>do not leak if u=
sername/password authentication is active.<br><br>To reproduce this issue h=
ave the server compiled with a USER_PASS_LEN<br>set to 128 (e.g. without pk=
cs11 or manually adjusting the define) and<br>have the client with a larger=
 USER_PASS_LEN to actually be able to<br>send the larger password. The serv=
er must also be set to use only<br>certificate authentication while the cli=
ent must use certificates<br>and auth-user-pass because otherwise the user/=
pass verification will<br>reject the empty credentials.<br><br>Using the op=
envpn3 test client with overlong username/password also<br>works.<br><br>Ch=
ange-Id: I60f02c919767eb8f1b95253689a8233f5f68621d<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file chan=
ged, 33 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/87/787/2</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/ssl.c b/src/openvpn/ssl.c</span><br><span>index e2be614..8040e7b 100644</=
span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ss=
l.c</span><br><span>@@ -1835,20 +1835,33 @@</span><br><span>     return tru=
e;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Rea=
d a string that is encoded as a 2 byte header with the length from the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buffer \c buf. Will r=
eturn the non-negative value if reading was successful.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * The returned value will include the =
trailing 0 byte.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the message is=
 over the capacity or could not be read</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * it will return the negative length that was in the</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * header and try to =
skip the string. If the string cannot be skipped, the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * buf will stay at the current position =
or position + 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br=
><span> read_string(struct buffer *buf, char *str, const unsigned int capac=
ity)</span><br><span> {</span><br><span>     const int len =3D buf_read_u16=
(buf);</span><br><span>     if (len &lt; 1 || len &gt; (int)capacity)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      buf_advance(buf, len);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 will also return 0 for a no string being present */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return -len;</span><br><span>    =
 }</span><br><span>     if (!buf_read(buf, str, len))</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -le=
n;</span><br><span>     }</span><br><span>     str[len-1] =3D &#39;\0&#39;;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return len;</span><b=
r><span> }</span><br><span> </span><br><span> static char *</span><br><span=
>@@ -2218,8 +2231,6 @@</span><br><span> {</span><br><span>     struct key_s=
tate *ks =3D &amp;session-&gt;key[KS_PRIMARY];      /* primary key */</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool =
username_status, password_status;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span>     struct gc_arena gc =3D gc_new();</span><b=
r><span>     char *options;</span><br><span>     struct user_pass *up =3D N=
ULL;</span><br><span>@@ -2253,7 +2264,7 @@</span><br><span>     }</span><br=
><span> </span><br><span>     /* get options */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (!read_string(buf, options, TLS_OPTIONS_LE=
N))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (read_str=
ing(buf, options, TLS_OPTIONS_LEN) &lt; 0)</span><br><span>     {</span><br=
><span>         msg(D_TLS_ERRORS, &quot;TLS Error: Failed to read required =
OCC options string&quot;);</span><br><span>         goto error;</span><br><=
span>@@ -2266,8 +2277,8 @@</span><br><span>      * peer_info data which fol=
lows behind</span><br><span>      */</span><br><span>     ALLOC_OBJ_CLEAR_G=
C(up, struct user_pass, &amp;gc);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    username_status =3D read_string(buf, up-&gt;username, USER_=
PASS_LEN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    passwor=
d_status =3D read_string(buf, up-&gt;password, USER_PASS_LEN);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    int username_len =3D read_st=
ring(buf, up-&gt;username, USER_PASS_LEN);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int password_len =3D read_string(buf, up-&gt;pas=
sword, USER_PASS_LEN);</span><br><span> </span><br><span>     /* get peer i=
nfo from control channel */</span><br><span>     free(multi-&gt;peer_info);=
</span><br><span>@@ -2290,10 +2301,21 @@</span><br><span>         multi-&gt=
;remote_ciphername =3D string_alloc(&quot;none&quot;, NULL);</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (tls_session_user_pass_enabled(session))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (username_len &lt; 0 || password_l=
en &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERROR=
S, &quot;TLS Error: Username (%d) or password (%d) too long&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            abs(username_len=
), abs(password_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        auth_set_client_reason(multi, &quot;Username or password is too =
long. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                        &quot;Maximum length is 128 bytes&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* treat the same as failed username/pas=
sword and do not error</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+         * out (goto error) to sent an AUTH_FAILED back to the client */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;auth=
enticated =3D KS_AUTH_FALSE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (tls_session_user_pass_enabled(session))</span><br><span>     {</spa=
n><br><span>         /* Perform username/password authentication */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!username_status =
|| !password_status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!username_len || !password_len)</span><br><span>         {</sp=
an><br><span>             CLEAR(*up);</span><br><span>             if (!(se=
ssion-&gt;opt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL))</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/787?usp=3Demail">change 787</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/78=
7?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I60f02c919767eb8f1b95253689a=
8233f5f68621d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--p7hOA6zR2e0=--

