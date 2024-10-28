From: Gert Doering <gert@...1296...>
Date: Mon, 28 Oct 2024 14:55:04 +0100
Message-ID: <20241028135505.28651-1-gert@...1296...>
In-Reply-To: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
References: <gerrit.1729867531000.I60f02c919767eb8f1b95253689a8233f5f68621d@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Refuse clients if username or password
 is longer than USER_PASS_LEN
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

From: Arne Schwabe <arne@...1227...>

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
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/787
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e2be614..8040e7b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1835,20 +1835,33 @@
     return true;
 }
 
-static bool
+/**
+ * Read a string that is encoded as a 2 byte header with the length from the
+ * buffer \c buf. Will return the non-negative value if reading was successful.
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
     const int len = buf_read_u16(buf);
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
     str[len-1] = '\0';
-    return true;
+    return len;
 }
 
 static char *
@@ -2218,8 +2231,6 @@
 {
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
-    bool username_status, password_status;
-
     struct gc_arena gc = gc_new();
     char *options;
     struct user_pass *up = NULL;
@@ -2253,7 +2264,7 @@
     }
 
     /* get options */
-    if (!read_string(buf, options, TLS_OPTIONS_LEN))
+    if (read_string(buf, options, TLS_OPTIONS_LEN) < 0)
     {
         msg(D_TLS_ERRORS, "TLS Error: Failed to read required OCC options string");
         goto error;
@@ -2266,8 +2277,8 @@
      * peer_info data which follows behind
      */
     ALLOC_OBJ_CLEAR_GC(up, struct user_pass, &gc);
-    username_status = read_string(buf, up->username, USER_PASS_LEN);
-    password_status = read_string(buf, up->password, USER_PASS_LEN);
+    int username_len = read_string(buf, up->username, USER_PASS_LEN);
+    int password_len = read_string(buf, up->password, USER_PASS_LEN);
 
     /* get peer info from control channel */
     free(multi->peer_info);
@@ -2290,10 +2301,21 @@
         multi->remote_ciphername = string_alloc("none", NULL);
     }
 
-    if (tls_session_user_pass_enabled(session))
+    if (username_len < 0 || password_len < 0)
+    {
+        msg(D_TLS_ERRORS, "TLS Error: Username (%d) or password (%d) too long",
+            abs(username_len), abs(password_len));
+        auth_set_client_reason(multi, "Username or password is too long. "
+                               "Maximum length is 128 bytes");
+
+        /* treat the same as failed username/password and do not error
+         * out (goto error) to sent an AUTH_FAILED back to the client */
+        ks->authenticated = KS_AUTH_FALSE;
+    }
+    else if (tls_session_user_pass_enabled(session))
     {
         /* Perform username/password authentication */
-        if (!username_status || !password_status)
+        if (!username_len || !password_len)
         {
             CLEAR(*up);
             if (!(session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL))

