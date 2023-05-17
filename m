From: Arne Schwabe <arne@...1227...>
Date: Wed, 17 May 2023 13:02:29 +0200
Message-Id: <20230517110230.2234266-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Introduce get_key_by_management_key_id
 helper function
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

This function allows us to map from a management key id to a key structure
and also allows this function to be reused.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_common.h | 20 ++++++++++++++++++++
 src/openvpn/ssl_verify.c | 17 +++++++----------
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 27b029479..ebfd25432 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -722,4 +722,24 @@ get_primary_key(const struct tls_multi *multi)
     return &multi->session[TM_ACTIVE].key[KS_PRIMARY];
 }
 
+#ifdef ENABLE_MANAGEMENT
+/**
+ * Gets the \c key_state  object that belong to the management key id or
+ * return NULL if not found.
+ */
+static inline struct key_state *
+get_key_by_management_key_id(struct tls_multi *multi, unsigned int mda_key_id)
+{
+    for (int i = 0; i < KEY_SCAN_SIZE; ++i)
+    {
+        struct key_state *ks = get_key_scan(multi, i);
+        if (ks->mda_key_id == mda_key_id)
+        {
+            return ks;
+        }
+    }
+    return NULL;
+}
+#endif
+
 #endif /* SSL_COMMON_H_ */
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 1b589f1a6..4c78c2b2c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1268,22 +1268,19 @@ tls_authentication_status(struct tls_multi *multi)
 bool
 tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, const bool auth, const char *client_reason)
 {
-    bool ret = false;
+    struct key_state *ks = NULL;
     if (multi)
     {
-        int i;
+
         auth_set_client_reason(multi, client_reason);
-        for (i = 0; i < KEY_SCAN_SIZE; ++i)
+        ks = get_key_by_management_key_id(multi, mda_key_id);
+
+        if (ks)
         {
-            struct key_state *ks = get_key_scan(multi, i);
-            if (ks->mda_key_id == mda_key_id)
-            {
-                ks->mda_status = auth ? ACF_SUCCEEDED : ACF_FAILED;
-                ret = true;
-            }
+            ks->mda_status = auth ? ACF_SUCCEEDED : ACF_FAILED;
         }
     }
-    return ret;
+    return (bool) ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-- 
2.39.2 (Apple Git-143)


