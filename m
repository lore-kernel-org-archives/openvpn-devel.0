From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 8 Sep 2024 20:06:15 +0000
In-Reply-To: <gerrit.1723691967000.I42e17e09a02f01aedadc2b03f9527967f6e1e8ff@...2715...>
References: <gerrit.1723691967000.I42e17e09a02f01aedadc2b03f9527967f6e1e8ff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b809c07b103f65b1e37a7e09692d5281c75b39e1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="szkwczJtxi4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Protect cached
 username, password and token on client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--szkwczJtxi4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/728?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Protect cached username, password and token on client
......................................................................

Protect cached username, password and token on client

Keep the memory segment containing username and password in
"struct user_pass" encrypted. Works only on Windows.

Username and auth-token cached by the server are not covered
here.

v2: Encrypt username and password separately as it looks more
robust. We continue to depend on the username and password buffer
sizes to be a multiple of CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16,
which is the case now. An error is logged if this is not the case.

v3: move up ASSERT in auth_token.c

Change-Id: I42e17e09a02f01aedadc2b03f9527967f6e1e8ff
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240906112908.1009-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
079.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/auth_token.c
M src/openvpn/misc.c
M src/openvpn/misc.h
M src/openvpn/proxy.c
M src/openvpn/ssl.c
M src/openvpn/ssl_verify.c
M src/openvpn/win32.c
M src/openvpn/win32.h
M tests/unit_tests/openvpn/test_user_pass.c
9 files changed, 153 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/728/4

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6787ea7..5de65cb 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -301,6 +301,7 @@
      * Base64 is <=3D input and input is < USER_PASS_LEN, so using USER_PA=
SS_LEN
      * is safe here but a bit overkill
      */
+    ASSERT(up && !up->protected);
     uint8_t b64decoded[USER_PASS_LEN];
     int decoded_len =3D openvpn_base64_decode(up->password + strlen(SESSIO=
N_ID_PREFIX),
                                             b64decoded, USER_PASS_LEN);
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 598fbae..ef4ab69 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -223,6 +223,7 @@
         bool password_from_stdin =3D false;
         bool response_from_stdin =3D true;

+        unprotect_user_pass(up);
         if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
         {
             msg(M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -479,14 +480,18 @@
         secure_memzero(up, sizeof(*up));
         up->nocache =3D nocache;
     }
-    /*
-     * don't show warning if the pass has been replaced by a token: this i=
s an
-     * artificial "auth-nocache"
-     */
-    else if (!warn_shown)
+    else
     {
-        msg(M_WARN, "WARNING: this configuration may cache passwords in me=
mory -- use the auth-nocache option to prevent this");
-        warn_shown =3D true;
+        protect_user_pass(up);
+        /*
+         * don't show warning if the pass has been replaced by a token: th=
is is an
+         * artificial "auth-nocache"
+         */
+        if (!warn_shown)
+        {
+            msg(M_WARN, "WARNING: this configuration may cache passwords i=
n memory -- use the auth-nocache option to prevent this");
+            warn_shown =3D true;
+        }
     }
 }

@@ -495,6 +500,7 @@
 {
     if (strlen(token))
     {
+        unprotect_user_pass(tk);
         strncpynt(tk->password, token, USER_PASS_LEN);
         tk->token_defined =3D true;

@@ -505,6 +511,7 @@
         {
             tk->defined =3D true;
         }
+        protect_user_pass(tk);
     }
 }

@@ -513,6 +520,7 @@
 {
     if (strlen(username))
     {
+        unprotect_user_pass(tk);
         /* Clear the username before decoding to ensure no old material is=
 left
          * and also allow decoding to not use all space to ensure the last=
 byte is
          * always 0 */
@@ -523,6 +531,7 @@
         {
             msg(D_PUSH, "Error decoding auth-token-username");
         }
+        protect_user_pass(tk);
     }
 }

@@ -779,3 +788,43 @@

     return combined_path;
 }
+
+void
+protect_user_pass(struct user_pass *up)
+{
+    if (up->protected)
+    {
+        return;
+    }
+#ifdef _WIN32
+    if (protect_buffer_win32(up->username, sizeof(up->username))
+        && protect_buffer_win32(up->password, sizeof(up->password)))
+    {
+        up->protected =3D true;
+    }
+    else
+    {
+        purge_user_pass(up, true);
+    }
+#endif
+}
+
+void
+unprotect_user_pass(struct user_pass *up)
+{
+    if (!up->protected)
+    {
+        return;
+    }
+#ifdef _WIN32
+    if (unprotect_buffer_win32(up->username, sizeof(up->username))
+        && unprotect_buffer_win32(up->password, sizeof(up->password)))
+    {
+        up->protected =3D false;
+    }
+    else
+    {
+        purge_user_pass(up, true);
+    }
+#endif
+}
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 963f3e6..a967ec8 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -60,6 +60,7 @@
      * use this second bool to track if the token (password) is defined */
     bool token_defined;
     bool nocache;
+    bool protected;

 /* max length of username/password */
 #ifdef ENABLE_PKCS11
@@ -207,6 +208,19 @@
 struct buffer
 prepend_dir(const char *dir, const char *path, struct gc_arena *gc);

+/**
+ * Encrypt username and password buffers in user_pass
+ */
+void
+protect_user_pass(struct user_pass *up);
+
+/**
+ * Decrypt username and password buffers in user_pass
+ */
+void
+unprotect_user_pass(struct user_pass *up);
+
+
 #define _STRINGIFY(S) #S
 /* *INDENT-OFF* - uncrustify need to ignore this macro */
 #define MAC_FMT _STRINGIFY(%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx)
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index eddacc9..404ea08 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -291,13 +291,14 @@
                       UP_TYPE_PROXY,
                       flags);
         static_proxy_user_pass.nocache =3D p->options.nocache;
+        protect_user_pass(&static_proxy_user_pass);
     }

     /*
      * Using cached credentials
      */
     p->queried_creds =3D true;
-    p->up =3D static_proxy_user_pass;
+    p->up =3D static_proxy_user_pass; /* this is a copy of protected memor=
y */
 }

 #if 0
@@ -668,6 +669,7 @@
         {
             clear_user_pass_http();
         }
+        unprotect_user_pass(&p->up);
     }

     /* are we being called again after getting the digest server nonce in =
the previous transaction? */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 14c38cf..c2c9c29 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -243,6 +243,7 @@
 void
 pem_password_setup(const char *auth_file)
 {
+    unprotect_user_pass(&passbuf);
     if (!strlen(passbuf.password))
     {
         get_user_pass(&passbuf, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_P=
ASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
@@ -256,6 +257,7 @@
     {
         /* prompt for password even if --askpass wasn't specified */
         pem_password_setup(NULL);
+        ASSERT(!passbuf.protected);
         strncpynt(buf, passbuf.password, size);
         purge_user_pass(&passbuf, false);

@@ -295,6 +297,7 @@

     if (!auth_user_pass.defined && !auth_token.defined)
     {
+        unprotect_user_pass(&auth_user_pass);
 #ifdef ENABLE_MANAGEMENT
         if (auth_challenge) /* dynamic challenge/response */
         {
@@ -2094,6 +2097,7 @@
         {
             up =3D &auth_token;
         }
+        unprotect_user_pass(up);

         if (!write_string(buf, up->username, -1))
         {
@@ -2106,8 +2110,11 @@
         /* save username for auth-token which may get pushed later */
         if (session->opt->pull && up !=3D &auth_token)
         {
+            unprotect_user_pass(&auth_token);
             strncpynt(auth_token.username, up->username, USER_PASS_LEN);
+            protect_user_pass(&auth_token);
         }
+        protect_user_pass(up);
         /* respect auth-nocache */
         purge_user_pass(&auth_user_pass, false);
     }
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0b0e2c3..74b2775 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1594,6 +1594,8 @@
 {
     struct key_state *ks =3D &session->key[KS_PRIMARY];      /* primary ke=
y */

+    ASSERT(up && !up->protected);
+
 #ifdef ENABLE_MANAGEMENT
     int man_def_auth =3D KMDA_UNDEF;

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 72496fa..86556a8 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1658,4 +1658,40 @@
     return wcsnicmp(system_dir, plugin_path, wcslen(system_dir)) =3D=3D 0;
 }

+bool
+protect_buffer_win32(char *buf, size_t len)
+{
+    bool ret;
+    if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
+    {
+        msg(M_NONFATAL, "Error: Unable to encrypt memory: buffer size not =
a multiple of %d",
+            CRYPTPROTECTMEMORY_BLOCK_SIZE);
+        return false;
+    }
+    ret =3D CryptProtectMemory(buf, len, CRYPTPROTECTMEMORY_SAME_PROCESS);
+    if (!ret)
+    {
+        msg(M_NONFATAL | M_ERRNO, "Failed to encrypt memory.");
+    }
+    return ret;
+}
+
+bool
+unprotect_buffer_win32(char *buf, size_t len)
+{
+    bool ret;
+    if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
+    {
+        msg(M_NONFATAL, "Error: Unable to decrypt memory: buffer size not =
a multiple of %d",
+            CRYPTPROTECTMEMORY_BLOCK_SIZE);
+        return false;
+    }
+    ret =3D CryptUnprotectMemory(buf, len, CRYPTPROTECTMEMORY_SAME_PROCESS=
);
+    if (!ret)
+    {
+        msg(M_FATAL | M_ERRNO, "Failed to decrypt memory.");
+    }
+    return ret;
+}
+
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index ffad6d9..081beeb 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -351,5 +351,27 @@
 bool
 plugin_in_trusted_dir(const WCHAR *plugin_path);

+/**
+ * Encrypt a region of memory using CryptProtectMemory()
+ * with access restricted to the current process.
+ *
+ * - buf   pointer to the memory
+ * - len   number of bytes to encrypt -- must be a multiple of
+ *         CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16
+ */
+bool
+protect_buffer_win32(char *buf, size_t len);
+
+/**
+ * Decrypt a previously encrypted region of memory using CryptUnProtectMem=
ory()
+ * with access restricted to the current process.
+ *
+ * - buf   pointer to the memory
+ * - len   number of bytes to encrypt -- must be a multiple of
+ *         CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16
+ */
+bool
+unprotect_buffer_win32(char *buf, size_t len);
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index de60291..4dc4b83 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -83,6 +83,18 @@
     return 0;
 }

+bool
+protect_buffer_win32(char *buf, size_t len)
+{
+    return true;
+}
+
+bool
+unprotect_buffer_win32(char *buf, size_t len)
+{
+    return true;
+}
+
 /* tooling */
 static void
 reset_user_pass(struct user_pass *up)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/728?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I42e17e09a02f01aedadc2b03f9527967f6e1e8ff
Gerrit-Change-Number: 728
Gerrit-PatchSet: 4
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--szkwczJtxi4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by selvanair.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
728?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Protect cached username, password and token o=
n client<br><br>Keep the memory segment containing username and password in=
<br>&quot;struct user_pass&quot; encrypted. Works only on Windows.<br><br>U=
sername and auth-token cached by the server are not covered<br>here.<br><br=
>v2: Encrypt username and password separately as it looks more<br>robust. W=
e continue to depend on the username and password buffer<br>sizes to be a m=
ultiple of CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16,<br>which is the case now. =
An error is logged if this is not the case.<br><br>v3: move up ASSERT in au=
th_token.c<br><br>Change-Id: I42e17e09a02f01aedadc2b03f9527967f6e1e8ff<br>S=
igned-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240906112908.1009-1=
-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1484...=
ts.sourceforge.net/msg29079.html<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M src/openvpn/auth_token.c<br>M src/openvpn/misc.c<b=
r>M src/openvpn/misc.h<br>M src/openvpn/proxy.c<br>M src/openvpn/ssl.c<br>M=
 src/openvpn/ssl_verify.c<br>M src/openvpn/win32.c<br>M src/openvpn/win32.h=
<br>M tests/unit_tests/openvpn/test_user_pass.c<br>9 files changed, 153 ins=
ertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/28/728/4</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/auth_token=
.c b/src/openvpn/auth_token.c</span><br><span>index 6787ea7..5de65cb 100644=
</span><br><span>--- a/src/openvpn/auth_token.c</span><br><span>+++ b/src/o=
penvpn/auth_token.c</span><br><span>@@ -301,6 +301,7 @@</span><br><span>   =
   * Base64 is &lt;=3D input and input is &lt; USER_PASS_LEN, so using USER=
_PASS_LEN</span><br><span>      * is safe here but a bit overkill</span><br=
><span>      */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
ASSERT(up &amp;&amp; !up-&gt;protected);</span><br><span>     uint8_t b64de=
coded[USER_PASS_LEN];</span><br><span>     int decoded_len =3D openvpn_base=
64_decode(up-&gt;password + strlen(SESSION_ID_PREFIX),</span><br><span>    =
                                         b64decoded, USER_PASS_LEN);</span>=
<br><span>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><s=
pan>index 598fbae..ef4ab69 100644</span><br><span>--- a/src/openvpn/misc.c<=
/span><br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -223,6 +223,7 @=
@</span><br><span>         bool password_from_stdin =3D false;</span><br><s=
pan>         bool response_from_stdin =3D true;</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        unprotect_user_pass(u=
p);</span><br><span>         if (flags &amp; GET_USER_PASS_PREVIOUS_CREDS_F=
AILED)</span><br><span>         {</span><br><span>             msg(M_WARN, =
&quot;Note: previous &#39;%s&#39; credentials failed&quot;, prefix);</span>=
<br><span>@@ -479,14 +480,18 @@</span><br><span>         secure_memzero(up,=
 sizeof(*up));</span><br><span>         up-&gt;nocache =3D nocache;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * don&#39;t show=
 warning if the pass has been replaced by a token: this is an</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     * artificial &quot;auth-nocach=
e&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    else if (!warn_shown)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
M_WARN, &quot;WARNING: this configuration may cache passwords in memory -- =
use the auth-nocache option to prevent this&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        warn_shown =3D true;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        protect_user_pass(up);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+         * don&#39;t show warnin=
g if the pass has been replaced by a token: this is an</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+         * artificial &quot;auth-nocache=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!warn_sho=
wn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &q=
uot;WARNING: this configuration may cache passwords in memory -- use the au=
th-nocache option to prevent this&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            warn_shown =3D true;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><=
br><span> }</span><br><span> </span><br><span>@@ -495,6 +500,7 @@</span><br=
><span> {</span><br><span>     if (strlen(token))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        unprotect_user=
_pass(tk);</span><br><span>         strncpynt(tk-&gt;password, token, USER_=
PASS_LEN);</span><br><span>         tk-&gt;token_defined =3D true;</span><b=
r><span> </span><br><span>@@ -505,6 +511,7 @@</span><br><span>         {</s=
pan><br><span>             tk-&gt;defined =3D true;</span><br><span>       =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        protect_=
user_pass(tk);</span><br><span>     }</span><br><span> }</span><br><span> <=
/span><br><span>@@ -513,6 +520,7 @@</span><br><span> {</span><br><span>    =
 if (strlen(username))</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        unprotect_user_pass(tk);</span><br><span>=
         /* Clear the username before decoding to ensure no old material is=
 left</span><br><span>          * and also allow decoding to not use all sp=
ace to ensure the last byte is</span><br><span>          * always 0 */</spa=
n><br><span>@@ -523,6 +531,7 @@</span><br><span>         {</span><br><span>=
             msg(D_PUSH, &quot;Error decoding auth-token-username&quot;);</=
span><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        protect_user_pass(tk);</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span>@@ -779,3 +788,43 @@</span><br><span>=
 </span><br><span>     return combined_path;</span><br><span> }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+protect_user_pass(struct user_pass *up)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (up-&gt;protected)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (protect_buff=
er_win32(up-&gt;username, sizeof(up-&gt;username))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        &amp;&amp; protect_buffer_win32(up-&=
gt;password, sizeof(up-&gt;password)))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        up-&gt;protected =3D true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        purge_user_=
pass(up, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unprotec=
t_user_pass(struct user_pass *up)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (!up-&gt;protected)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret=
urn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (unprotect_buffer_win32(up-&=
gt;username, sizeof(up-&gt;username))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        &amp;&amp; unprotect_buffer_win32(up-&gt;password=
, sizeof(up-&gt;password)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  up-&gt;protected =3D false;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        purge_user_pass(up, t=
rue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvp=
n/misc.h b/src/openvpn/misc.h</span><br><span>index 963f3e6..a967ec8 100644=
</span><br><span>--- a/src/openvpn/misc.h</span><br><span>+++ b/src/openvpn=
/misc.h</span><br><span>@@ -60,6 +60,7 @@</span><br><span>      * use this =
second bool to track if the token (password) is defined */</span><br><span>=
     bool token_defined;</span><br><span>     bool nocache;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    bool protected;</span><br><span=
> </span><br><span> /* max length of username/password */</span><br><span> =
#ifdef ENABLE_PKCS11</span><br><span>@@ -207,6 +208,19 @@</span><br><span> =
struct buffer</span><br><span> prepend_dir(const char *dir, const char *pat=
h, struct gc_arena *gc);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Encrypt username and password buffers in user_pass</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+protect_user_pass(struct user_pass *up);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * D=
ecrypt username and password buffers in user_pass</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
nprotect_user_pass(struct user_pass *up);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> #define _STRINGIFY(S) #S</span><br><span> /* *INDENT-O=
FF* - uncrustify need to ignore this macro */</span><br><span> #define MAC_=
FMT _STRINGIFY(%02hhx:%02hhx:%02hhx:%02hhx:%02hhx:%02hhx)</span><br><span>d=
iff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index=
 eddacc9..404ea08 100644</span><br><span>--- a/src/openvpn/proxy.c</span><b=
r><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -291,13 +291,14 @@</sp=
an><br><span>                       UP_TYPE_PROXY,</span><br><span>        =
               flags);</span><br><span>         static_proxy_user_pass.noca=
che =3D p-&gt;options.nocache;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        protect_user_pass(&amp;static_proxy_user_pass);</span><b=
r><span>     }</span><br><span> </span><br><span>     /*</span><br><span>  =
    * Using cached credentials</span><br><span>      */</span><br><span>   =
  p-&gt;queried_creds =3D true;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    p-&gt;up =3D static_proxy_user_pass;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    p-&gt;up =3D static_proxy_user_pass; /* =
this is a copy of protected memory */</span><br><span> }</span><br><span> <=
/span><br><span> #if 0</span><br><span>@@ -668,6 +669,7 @@</span><br><span>=
         {</span><br><span>             clear_user_pass_http();</span><br><=
span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    unprotect_user_pass(&amp;p-&gt;up);</span><br><span>     }</span><br><s=
pan> </span><br><span>     /* are we being called again after getting the d=
igest server nonce in the previous transaction? */</span><br><span>diff --g=
it a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 14c38cf..c=
2c9c29 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b=
/src/openvpn/ssl.c</span><br><span>@@ -243,6 +243,7 @@</span><br><span> voi=
d</span><br><span> pem_password_setup(const char *auth_file)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unprotect_u=
ser_pass(&amp;passbuf);</span><br><span>     if (!strlen(passbuf.password))=
</span><br><span>     {</span><br><span>         get_user_pass(&amp;passbuf=
, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PA=
SSWORD_ONLY);</span><br><span>@@ -256,6 +257,7 @@</span><br><span>     {</s=
pan><br><span>         /* prompt for password even if --askpass wasn&#39;t =
specified */</span><br><span>         pem_password_setup(NULL);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(!passbuf.protect=
ed);</span><br><span>         strncpynt(buf, passbuf.password, size);</span=
><br><span>         purge_user_pass(&amp;passbuf, false);</span><br><span> =
</span><br><span>@@ -295,6 +297,7 @@</span><br><span> </span><br><span>    =
 if (!auth_user_pass.defined &amp;&amp; !auth_token.defined)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        unp=
rotect_user_pass(&amp;auth_user_pass);</span><br><span> #ifdef ENABLE_MANAG=
EMENT</span><br><span>         if (auth_challenge) /* dynamic challenge/res=
ponse */</span><br><span>         {</span><br><span>@@ -2094,6 +2097,7 @@</=
span><br><span>         {</span><br><span>             up =3D &amp;auth_tok=
en;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        unprotect_user_pass(up);</span><br><span> </span><br><sp=
an>         if (!write_string(buf, up-&gt;username, -1))</span><br><span>  =
       {</span><br><span>@@ -2106,8 +2110,11 @@</span><br><span>         /*=
 save username for auth-token which may get pushed later */</span><br><span=
>         if (session-&gt;opt-&gt;pull &amp;&amp; up !=3D &amp;auth_token)<=
/span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            unprotect_user_pass(&amp;auth_token);</span><br><span>  =
           strncpynt(auth_token.username, up-&gt;username, USER_PASS_LEN);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            protect_=
user_pass(&amp;auth_token);</span><br><span>         }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        protect_user_pass(up);</span><br=
><span>         /* respect auth-nocache */</span><br><span>         purge_u=
ser_pass(&amp;auth_user_pass, false);</span><br><span>     }</span><br><spa=
n>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><b=
r><span>index 0b0e2c3..74b2775 100644</span><br><span>--- a/src/openvpn/ssl=
_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@=
 -1594,6 +1594,8 @@</span><br><span> {</span><br><span>     struct key_stat=
e *ks =3D &amp;session-&gt;key[KS_PRIMARY];      /* primary key */</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT=
(up &amp;&amp; !up-&gt;protected);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span> =
    int man_def_auth =3D KMDA_UNDEF;</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><span>index 72=
496fa..86556a8 100644</span><br><span>--- a/src/openvpn/win32.c</span><br><=
span>+++ b/src/openvpn/win32.c</span><br><span>@@ -1658,4 +1658,40 @@</span=
><br><span>     return wcsnicmp(system_dir, plugin_path, wcslen(system_dir)=
) =3D=3D 0;</span><br><span> }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+protect_buffer_win32(char *buf, size_t len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bool ret;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_NONFATAL, &quot;Error: Unable to enc=
rypt memory: buffer size not a multiple of %d&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            CRYPTPROTECTMEMORY_BLOCK_SIZE=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return fa=
lse;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ret =3D CryptProtectMemor=
y(buf, len, CRYPTPROTECTMEMORY_SAME_PROCESS);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!ret)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_NONFATAL | M_ERRNO, &quot;Failed to encrypt memory.&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unprotect_=
buffer_win32(char *buf, size_t len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  bool ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
len % CRYPTPROTECTMEMORY_BLOCK_SIZE)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        msg(M_NONFATAL, &quot;Error: Unable to decrypt memory: buffer si=
ze not a multiple of %d&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            CRYPTPROTECTMEMORY_BLOCK_SIZE);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ret =3D CryptUnprotectMemory(buf, len, CRYPTPROT=
ECTMEMORY_SAME_PROCESS);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!ret)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_F=
ATAL | M_ERRNO, &quot;Failed to decrypt memory.&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> #endif /* ifdef _WIN32 */</span><br><span>diff --git a/sr=
c/openvpn/win32.h b/src/openvpn/win32.h</span><br><span>index ffad6d9..081b=
eeb 100644</span><br><span>--- a/src/openvpn/win32.h</span><br><span>+++ b/=
src/openvpn/win32.h</span><br><span>@@ -351,5 +351,27 @@</span><br><span> b=
ool</span><br><span> plugin_in_trusted_dir(const WCHAR *plugin_path);</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Encrypt a region of =
memory using CryptProtectMemory()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * with access restricted to the current process.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * - buf   pointer to the memory</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * - len   number of bytes to encry=
pt -- must be a multiple of</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *         CRYPTPROTECTMEMORY_BLOCK_SIZE =3D 16</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+protect_buffer_win32(char *buf, size_t len);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * De=
crypt a previously encrypted region of memory using CryptUnProtectMemory()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * with access restr=
icted to the current process.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * - bu=
f   pointer to the memory</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * - len   number of bytes to encrypt -- must be a multiple of</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *         CRYPTPROTECTMEM=
ORY_BLOCK_SIZE =3D 16</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+unprotect_buffer_win32(char *=
buf, size_t len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> #endif /* ifndef OPENVPN_WIN32_H */</span><br><span> #endif=
 /* ifdef _WIN32 */</span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span=
>index de60291..4dc4b83 100644</span><br><span>--- a/tests/unit_tests/openv=
pn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_use=
r_pass.c</span><br><span>@@ -83,6 +83,18 @@</span><br><span>     return 0;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+protect_buffer_win32(char *buf, size_t len)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+unprotect_buffer_win32(char *buf, size_t len)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> /* tooling */</span><br><span> static voi=
d</span><br><span> reset_user_pass(struct user_pass *up)</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/728?usp=3Demail">change 728</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/728?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I42e17e09a02f01aedadc2b03f95=
27967f6e1e8ff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 728 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--szkwczJtxi4=--

