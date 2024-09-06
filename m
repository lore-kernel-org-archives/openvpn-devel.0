From: Gert Doering <gert@...1296...>
Date: Fri,  6 Sep 2024 13:29:08 +0200
Message-ID: <20240906112908.1009-1-gert@...1296...>
In-Reply-To: <gerrit.1723691967000.I42e17e09a02f01aedadc2b03f9527967f6e1e8ff@...2715...>
References: <gerrit.1723691967000.I42e17e09a02f01aedadc2b03f9527967f6e1e8ff@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Protect cached username,
 password and token on client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Selva Nair <selva.nair@...277...>

Keep the memory segment containing username and password in
"struct user_pass" encrypted. Works only on Windows.

Username and auth-token cached by the server are not covered
here.

v2: Encrypt username and password separately as it looks more
robust. We continue to depend on the username and password buffer
sizes to be a multiple of CRYPTPROTECTMEMORY_BLOCK_SIZE = 16,
which is the case now. An error is logged if this is not the case.

v3: move up ASSERT in auth_token.c

Change-Id: I42e17e09a02f01aedadc2b03f9527967f6e1e8ff
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/728
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6787ea7..5de65cb 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -301,6 +301,7 @@
      * Base64 is <= input and input is < USER_PASS_LEN, so using USER_PASS_LEN
      * is safe here but a bit overkill
      */
+    ASSERT(up && !up->protected);
     uint8_t b64decoded[USER_PASS_LEN];
     int decoded_len = openvpn_base64_decode(up->password + strlen(SESSION_ID_PREFIX),
                                             b64decoded, USER_PASS_LEN);
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 598fbae..ef4ab69 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -223,6 +223,7 @@
         bool password_from_stdin = false;
         bool response_from_stdin = true;
 
+        unprotect_user_pass(up);
         if (flags & GET_USER_PASS_PREVIOUS_CREDS_FAILED)
         {
             msg(M_WARN, "Note: previous '%s' credentials failed", prefix);
@@ -479,14 +480,18 @@
         secure_memzero(up, sizeof(*up));
         up->nocache = nocache;
     }
-    /*
-     * don't show warning if the pass has been replaced by a token: this is an
-     * artificial "auth-nocache"
-     */
-    else if (!warn_shown)
+    else
     {
-        msg(M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
-        warn_shown = true;
+        protect_user_pass(up);
+        /*
+         * don't show warning if the pass has been replaced by a token: this is an
+         * artificial "auth-nocache"
+         */
+        if (!warn_shown)
+        {
+            msg(M_WARN, "WARNING: this configuration may cache passwords in memory -- use the auth-nocache option to prevent this");
+            warn_shown = true;
+        }
     }
 }
 
@@ -495,6 +500,7 @@
 {
     if (strlen(token))
     {
+        unprotect_user_pass(tk);
         strncpynt(tk->password, token, USER_PASS_LEN);
         tk->token_defined = true;
 
@@ -505,6 +511,7 @@
         {
             tk->defined = true;
         }
+        protect_user_pass(tk);
     }
 }
 
@@ -513,6 +520,7 @@
 {
     if (strlen(username))
     {
+        unprotect_user_pass(tk);
         /* Clear the username before decoding to ensure no old material is left
          * and also allow decoding to not use all space to ensure the last byte is
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
+        up->protected = true;
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
+        up->protected = false;
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
index 5de0da4..a379c7a 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -289,13 +289,14 @@
                       UP_TYPE_PROXY,
                       flags);
         static_proxy_user_pass.nocache = p->options.nocache;
+        protect_user_pass(&static_proxy_user_pass);
     }
 
     /*
      * Using cached credentials
      */
     p->queried_creds = true;
-    p->up = static_proxy_user_pass;
+    p->up = static_proxy_user_pass; /* this is a copy of protected memory */
 }
 
 #if 0
@@ -666,6 +667,7 @@
         {
             clear_user_pass_http();
         }
+        unprotect_user_pass(&p->up);
     }
 
     /* are we being called again after getting the digest server nonce in the previous transaction? */
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
         get_user_pass(&passbuf, auth_file, UP_TYPE_PRIVATE_KEY, GET_USER_PASS_MANAGEMENT|GET_USER_PASS_PASSWORD_ONLY);
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
             up = &auth_token;
         }
+        unprotect_user_pass(up);
 
         if (!write_string(buf, up->username, -1))
         {
@@ -2106,8 +2110,11 @@
         /* save username for auth-token which may get pushed later */
         if (session->opt->pull && up != &auth_token)
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
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
+    ASSERT(up && !up->protected);
+
 #ifdef ENABLE_MANAGEMENT
     int man_def_auth = KMDA_UNDEF;
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 72496fa..86556a8 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1658,4 +1658,40 @@
     return wcsnicmp(system_dir, plugin_path, wcslen(system_dir)) == 0;
 }
 
+bool
+protect_buffer_win32(char *buf, size_t len)
+{
+    bool ret;
+    if (len % CRYPTPROTECTMEMORY_BLOCK_SIZE)
+    {
+        msg(M_NONFATAL, "Error: Unable to encrypt memory: buffer size not a multiple of %d",
+            CRYPTPROTECTMEMORY_BLOCK_SIZE);
+        return false;
+    }
+    ret = CryptProtectMemory(buf, len, CRYPTPROTECTMEMORY_SAME_PROCESS);
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
+        msg(M_NONFATAL, "Error: Unable to decrypt memory: buffer size not a multiple of %d",
+            CRYPTPROTECTMEMORY_BLOCK_SIZE);
+        return false;
+    }
+    ret = CryptUnprotectMemory(buf, len, CRYPTPROTECTMEMORY_SAME_PROCESS);
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
+ *         CRYPTPROTECTMEMORY_BLOCK_SIZE = 16
+ */
+bool
+protect_buffer_win32(char *buf, size_t len);
+
+/**
+ * Decrypt a previously encrypted region of memory using CryptUnProtectMemory()
+ * with access restricted to the current process.
+ *
+ * - buf   pointer to the memory
+ * - len   number of bytes to encrypt -- must be a multiple of
+ *         CRYPTPROTECTMEMORY_BLOCK_SIZE = 16
+ */
+bool
+unprotect_buffer_win32(char *buf, size_t len);
+
 #endif /* ifndef OPENVPN_WIN32_H */
 #endif /* ifdef _WIN32 */
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c
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

