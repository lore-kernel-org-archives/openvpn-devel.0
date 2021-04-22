From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:17:22 +0200
Message-Id: <20210422151724.2132573-5-arne@...1227...>
In-Reply-To: <20210422151724.2132573-1-arne@...1227...>
References: <20210422151724.2132573-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/7] Extracting key_state deferred auth
 status update into function
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

This extract the update of a deferred key status into into own
function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_verify.c | 90 ++++++++++++++++++++++++++--------------
 1 file changed, 58 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e000f75f7..912012eb7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1073,6 +1073,56 @@ key_state_test_auth_control_file(struct auth_deferred_status *ads, bool cached)
     return ACF_DISABLED;
 }
 
+/**
+ * This method takes a key_state and if updates the state
+ * of the key if it is deferred.
+ * @param cached    If auth control files should be tried to be opened or th
+ *                  cached results should be used
+ * @param ks        The key_state to update
+ */
+static void
+update_key_auth_status(bool cached, struct key_state *ks)
+{
+    if (ks->authenticated == KS_AUTH_FALSE)
+    {
+        return;
+    }
+    else
+    {
+        enum auth_deferred_result auth_plugin = ACF_DISABLED;
+        enum auth_deferred_result auth_script = ACF_DISABLED;
+        enum auth_deferred_result auth_man = ACF_DISABLED;
+        auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth, cached);
+        auth_script = key_state_test_auth_control_file(&ks->script_auth, cached);
+#ifdef ENABLE_MANAGEMENT
+        auth_man = man_def_auth_test(ks);
+#endif
+        ASSERT(auth_plugin < 4 && auth_script < 4 && auth_man < 4);
+
+        if (auth_plugin == ACF_FAILED || auth_script == ACF_FAILED
+           || auth_man == ACF_FAILED)
+        {
+            ks->authenticated = KS_AUTH_FALSE;
+            return;
+        }
+        else if (auth_plugin == ACF_PENDING
+                 || auth_script == ACF_PENDING
+                 || auth_man == ACF_PENDING)
+        {
+            if (now < ks->auth_deferred_expire)
+            {
+                /* key state is remains in KS_DEFERRED */
+            }
+        }
+        else
+        {
+            /* auth_plugin and auth_man are either ACF_DISABLED or ACF_SUCCEDED */
+            ks->authenticated = KS_AUTH_TRUE;
+        }
+    }
+}
+
+
 enum tls_auth_status
 tls_authentication_status(struct tls_multi *multi, const int latency)
 {
@@ -1096,43 +1146,19 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
         if (TLS_AUTHENTICATED(multi, ks))
         {
             active++;
+            update_key_auth_status(cached, ks);
+
             if (ks->authenticated == KS_AUTH_FALSE)
             {
                 failed_auth = true;
             }
-            else
+            else if (ks->authenticated == KS_AUTH_DEFERRED)
             {
-                enum auth_deferred_result auth_plugin = ACF_DISABLED;
-                enum auth_deferred_result auth_script = ACF_DISABLED;
-                enum auth_deferred_result auth_man = ACF_DISABLED;
-                auth_plugin = key_state_test_auth_control_file(&ks->plugin_auth, cached);
-                auth_script = key_state_test_auth_control_file(&ks->script_auth, cached);
-#ifdef ENABLE_MANAGEMENT
-                auth_man = man_def_auth_test(ks);
-#endif
-                ASSERT(auth_plugin < 4 && auth_script < 4 && auth_man < 4);
-
-                if (auth_plugin == ACF_FAILED || auth_script == ACF_FAILED
-                   || auth_man == ACF_FAILED)
-                {
-                    ks->authenticated = KS_AUTH_FALSE;
-                    failed_auth = true;
-                }
-                else if (auth_plugin == ACF_PENDING
-                         || auth_script == ACF_PENDING
-                         || auth_man == ACF_PENDING)
-                {
-                    if (now < ks->auth_deferred_expire)
-                    {
-                        deferred = true;
-                    }
-                }
-                else
-                {
-                    /* auth_plugin and auth_man are either ACF_DISABLED or ACF_SUCCEDED */
-                    success = true;
-                    ks->authenticated = KS_AUTH_TRUE;
-                }
+                deferred = true;
+            }
+            else if (ks->authenticated == KS_AUTH_TRUE)
+            {
+                success = true;
             }
         }
     }
-- 
2.31.1


