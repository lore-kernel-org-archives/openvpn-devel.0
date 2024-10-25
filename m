From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 25 Oct 2024 14:45:34 +0000
References: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <bf0db224d3c7128ad980128c8d86874ecc5c7960-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UEG2X/eLKvc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Refuse clients if
 username or password is > USER_PASS_LEN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UEG2X/eLKvc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail

to review the following change.


Change subject: Refuse clients if username or password is > USER_PASS_LEN
......................................................................

Refuse clients if username or password is > USER_PASS_LEN

When OpenVPN is compiled without PKCS11 support USER_PASS_LEN is 128
bytes. If we encounter a username larger than this length we would
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
send the larger password.

Using the openvpn3 test client with overlong username/password also
works.

Change-Id: I60f02c919767eb8f1b95253689a8233f5f68621d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl.c
1 file changed, 36 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/787/1

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e2be614..e5f4f2b 100644
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
@@ -2266,8 +2277,11 @@
      * peer_info data which follows behind
      */
     ALLOC_OBJ_CLEAR_GC(up, struct user_pass, &gc);
-    username_status =3D read_string(buf, up->username, USER_PASS_LEN);
-    password_status =3D read_string(buf, up->password, USER_PASS_LEN);
+    int username_len =3D read_string(buf, up->username, USER_PASS_LEN);
+    int password_len =3D read_string(buf, up->password, USER_PASS_LEN);
+
+    msg(D_TLS_ERRORS, "TLS INFO: Username (%d) or password (%d)  long",
+        abs(username_len), abs(password_len));

     /* get peer info from control channel */
     free(multi->peer_info);
@@ -2290,10 +2304,21 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--UEG2X/eLKvc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Refuse clients if username or password is &gt; USER_PASS_LEN<=
br><br>When OpenVPN is compiled without PKCS11 support USER_PASS_LEN is 128=
<br>bytes. If we encounter a username larger than this length we would<br>o=
nly read the 2 bytes length header of the username/password.  We did<br>the=
n also NOT skip the username or password field meaning that we would<br>con=
tinue reading the rest of the packet at the wrong offset and get<br>garbage=
 results like not having peerinfo and then rejecting a client<br>because of=
 no common cipher or missing data v2 support.<br><br>This will tell the cli=
ent that username/password is too regardless<br>of whether password/usernam=
e authentication is used.  This way we<br>do not leak if username/password =
authentication is active.<br><br>To reproduce this issue have the server co=
mpiled with a USER_PASS_LEN<br>set to 128 (e.g. without pkcs11 or manually =
adjusting the define) and<br>have the client with a larger USER_PASS_LEN to=
 actually be able to<br>send the larger password.<br><br>Using the openvpn3=
 test client with overlong username/password also<br>works.<br><br>Change-I=
d: I60f02c919767eb8f1b95253689a8233f5f68621d<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl.c<br>1 file changed, 3=
6 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/87/787/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl.=
c b/src/openvpn/ssl.c</span><br><span>index e2be614..e5f4f2b 100644</span><=
br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</s=
pan><br><span>@@ -1835,20 +1835,33 @@</span><br><span>     return true;</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Read a st=
ring that is encoded as a 2 byte header with the length from the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * buffer \c buf. Will return =
the non-negative value if reading was successful.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * The returned value will include the traili=
ng 0 byte.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * If the message is over =
the capacity or could not be read</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * it will return the negative length that was in the</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * header and try to skip t=
he string. If the string cannot be skipped, the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * buf will stay at the current position or pos=
ition + 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span=
> read_string(struct buffer *buf, char *str, const unsigned int capacity)</=
span><br><span> {</span><br><span>     const int len =3D buf_read_u16(buf);=
</span><br><span>     if (len &lt; 1 || len &gt; (int)capacity)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
buf_advance(buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* will =
also return 0 for a no string being present */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        return -len;</span><br><span>     }</spa=
n><br><span>     if (!buf_read(buf, str, len))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return false;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return -len;</spa=
n><br><span>     }</span><br><span>     str[len-1] =3D &#39;\0&#39;;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return len;</span><br><span=
> }</span><br><span> </span><br><span> static char *</span><br><span>@@ -22=
18,8 +2231,6 @@</span><br><span> {</span><br><span>     struct key_state *k=
s =3D &amp;session-&gt;key[KS_PRIMARY];      /* primary key */</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool usernam=
e_status, password_status;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     char *options;</span><br><span>     struct user_pass *up =3D NULL;</s=
pan><br><span>@@ -2253,7 +2264,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     /* get options */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (!read_string(buf, options, TLS_OPTIONS_LEN))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (read_string(buf=
, options, TLS_OPTIONS_LEN) &lt; 0)</span><br><span>     {</span><br><span>=
         msg(D_TLS_ERRORS, &quot;TLS Error: Failed to read required OCC opt=
ions string&quot;);</span><br><span>         goto error;</span><br><span>@@=
 -2266,8 +2277,11 @@</span><br><span>      * peer_info data which follows b=
ehind</span><br><span>      */</span><br><span>     ALLOC_OBJ_CLEAR_GC(up, =
struct user_pass, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    username_status =3D read_string(buf, up-&gt;username, USER_PASS_L=
EN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    password_stat=
us =3D read_string(buf, up-&gt;password, USER_PASS_LEN);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int username_len =3D read_string(b=
uf, up-&gt;username, USER_PASS_LEN);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    int password_len =3D read_string(buf, up-&gt;password,=
 USER_PASS_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(D_TLS_ERRORS, =
&quot;TLS INFO: Username (%d) or password (%d)  long&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        abs(username_len), abs(pass=
word_len));</span><br><span> </span><br><span>     /* get peer info from co=
ntrol channel */</span><br><span>     free(multi-&gt;peer_info);</span><br>=
<span>@@ -2290,10 +2304,21 @@</span><br><span>         multi-&gt;remote_cip=
hername =3D string_alloc(&quot;none&quot;, NULL);</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (tls_session_user_pass_enabled(session))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (username_len &lt; 0 || password_len &lt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERRORS, &quot;TLS=
 Error: Username (%d) or password (%d) too long&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            abs(username_len), abs(passw=
ord_len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        a=
uth_set_client_reason(multi, &quot;Username or password is too long. &quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
            &quot;Maximum length is 128 bytes&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* treat the same as failed username/password and do=
 not error</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
* out (goto error) to sent an AUTH_FAILED back to the client */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ks-&gt;authenticated =
=3D KS_AUTH_FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (tl=
s_session_user_pass_enabled(session))</span><br><span>     {</span><br><spa=
n>         /* Perform username/password authentication */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (!username_status || !passwo=
rd_status)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!username_len || !password_len)</span><br><span>         {</span><br><sp=
an>             CLEAR(*up);</span><br><span>             if (!(session-&gt;=
opt-&gt;ssl_flags &amp; SSLF_AUTH_USER_PASS_OPTIONAL))</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/787?usp=3Demail">change 787</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/787?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I60f02c919767eb8f1b95253689a=
8233f5f68621d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 787 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--UEG2X/eLKvc=--

