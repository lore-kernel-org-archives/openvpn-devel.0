From: Arne Schwabe <arne@...1227...>
Date: Mon, 10 Jul 2023 13:37:04 +0200
Message-Id: <20230710113704.344360-1-arne@...1227...>
In-Reply-To: <20230517110230.2234266-1-arne@...1227...>
References: <20230517110230.2234266-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Introduce get_key_by_management_key_id
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

Patch v2: add message when key is not found.
Patch v3: only consider valid keys

Change-Id: I42d8785959c24bf688190965e58b9b98251b8557
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl_common.h | 20 ++++++++++++++++++++
 src/openvpn/ssl_verify.c | 23 +++++++++++++----------
 2 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 27b029479..be0f18746 100644
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
+        if (ks->mda_key_id == mda_key_id && ks->state > S_UNDEF)
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
index 90416b69e..2395e55c8 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1266,22 +1266,25 @@ tls_authentication_status(struct tls_multi *multi)
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
+        else
+        {
+            msg(D_TLS_DEBUG_LOW, "%s: no key state found for management key id "
+                "%d", __func__, mda_key_id);
+        }
+
     }
-    return ret;
+    return (bool) ks;
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-- 
2.39.2 (Apple Git-143)


