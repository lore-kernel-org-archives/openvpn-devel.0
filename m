From: Arne Schwabe <arne@...1227...>
Date: Thu, 22 Apr 2021 17:17:18 +0200
Message-Id: <20210422151724.2132573-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/7] Move tls_select_primary_key into its
 own function
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

tls_pre_encrypt mainly performs the task of selecting the primary
encryption key but also performs other minor tasks. To allow only
querying for the key that should be used for encryption extract this
part of the function into its own function.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/ssl.c | 36 +++++++++++++++++++++---------------
 src/openvpn/ssl.h | 10 ++++++++++
 2 files changed, 31 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3921b3ba9..3bc84e02c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3820,27 +3820,15 @@ error:
     return false;
 }
 
-/* Choose the key with which to encrypt a data packet */
-void
-tls_pre_encrypt(struct tls_multi *multi,
-                struct buffer *buf, struct crypto_options **opt)
+struct key_state *tls_select_encryption_key(struct tls_multi *multi)
 {
-    multi->save_ks = NULL;
-    if (buf->len <= 0)
-    {
-        buf->len = 0;
-        *opt = NULL;
-        return;
-    }
-
     struct key_state *ks_select = NULL;
     for (int i = 0; i < KEY_SCAN_SIZE; ++i)
     {
         struct key_state *ks = get_key_scan(multi, i);
         if (ks->state >= S_ACTIVE
-            && (ks->authenticated == KS_AUTH_TRUE)
-            && ks->crypto_options.key_ctx_bi.initialized
-            )
+            && ks->authenticated == KS_AUTH_TRUE
+            && ks->crypto_options.key_ctx_bi.initialized)
         {
             if (!ks_select)
             {
@@ -3853,6 +3841,24 @@ tls_pre_encrypt(struct tls_multi *multi,
             }
         }
     }
+    return ks_select;
+}
+
+
+/* Choose the key with which to encrypt a data packet */
+void
+tls_pre_encrypt(struct tls_multi *multi,
+                struct buffer *buf, struct crypto_options **opt)
+{
+    multi->save_ks = NULL;
+    if (buf->len <= 0)
+    {
+        buf->len = 0;
+        *opt = NULL;
+        return;
+    }
+
+    struct key_state *ks_select = tls_select_encryption_key(multi);
 
     if (ks_select)
     {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 6369e8bf6..135c60732 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -372,6 +372,16 @@ bool tls_pre_decrypt_lite(const struct tls_auth_standalone *tas,
 void tls_pre_encrypt(struct tls_multi *multi,
                      struct buffer *buf, struct crypto_options **opt);
 
+/**
+ * Selects the primary encryption that should be used to encrypt data of an
+ * outgoing packet.
+ * @ingroup data_crypto
+ *
+ * If no key is found NULL is returned instead.
+ *
+ * @param multi - The TLS state for this packet's destination VPN tunnel.
+ */
+struct key_state *tls_select_encryption_key(struct tls_multi *multi);
 
 /**
  * Prepend a one-byte OpenVPN data channel P_DATA_V1 opcode to the packet.
-- 
2.31.1


