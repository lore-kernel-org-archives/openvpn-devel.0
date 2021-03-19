From: Max Fillinger <max@...2606...>
Date: Fri, 19 Mar 2021 22:54:48 +0100
Message-Id: <20210319215448.38350-1-max@...2606...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Wipe Socks5 credentials after use
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

Plaintext authentication is not exactly high security, but we might as
well memzero the credentials before leaving the function.
---
 src/openvpn/socks.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 36df7470..add7a6d4 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -104,12 +104,13 @@ socks_username_password_auth(struct socks_proxy_info *p,
     const int timeout_sec = 5;
     struct user_pass creds;
     ssize_t size;
+    bool ret = false;
 
     creds.defined = 0;
     if (!get_user_pass(&creds, p->authfile, UP_TYPE_SOCKS, GET_USER_PASS_MANAGEMENT))
     {
         msg(M_NONFATAL, "SOCKS failed to get username/password.");
-        return false;
+        goto cleanup;
     }
 
     if ( (strlen(creds.username) > 255) || (strlen(creds.password) > 255) )
@@ -117,7 +118,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
         msg(M_NONFATAL,
             "SOCKS username and/or password exceeds 255 characters.  "
             "Authentication not possible.");
-        return false;
+        goto cleanup;
     }
     openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int) strlen(creds.username),
                      creds.username, (int) strlen(creds.password), creds.password);
@@ -126,7 +127,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
     if (size != strlen(to_send))
     {
         msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port write failed on send()");
-        return false;
+        goto cleanup;
     }
 
     while (len < 2)
@@ -147,21 +148,21 @@ socks_username_password_auth(struct socks_proxy_info *p,
         get_signal(signal_received);
         if (*signal_received)
         {
-            return false;
+            goto cleanup;
         }
 
         /* timeout? */
         if (status == 0)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read timeout expired");
-            return false;
+            goto cleanup;
         }
 
         /* error */
         if (status < 0)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read failed on select()");
-            return false;
+            goto cleanup;
         }
 
         /* read single char */
@@ -171,7 +172,7 @@ socks_username_password_auth(struct socks_proxy_info *p,
         if (size != 1)
         {
             msg(D_LINK_ERRORS | M_ERRNO, "socks_username_password_auth: TCP port read failed on recv()");
-            return false;
+            goto cleanup;
         }
 
         /* store char in buffer */
@@ -182,10 +183,14 @@ socks_username_password_auth(struct socks_proxy_info *p,
     if (buf[0] != 5 && buf[1] != 0)
     {
         msg(D_LINK_ERRORS, "socks_username_password_auth: server refused the authentication");
-        return false;
+        goto cleanup;
     }
 
-    return true;
+    ret = true;
+cleanup:
+    secure_memzero(&creds, sizeof(creds));
+    secure_memzero(to_send, sizeof(to_send));
+    return ret;
 }
 
 static bool
-- 
2.29.2


