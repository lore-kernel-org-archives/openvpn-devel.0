From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 14:37:51 +0200
Message-ID: <20251008123757.18670-1-gert@...1296...>
In-Reply-To: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
References: <gerrit.1758811182000.Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] dco-win: support for epoch data channel
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

From: Lev Stipakov <lev@...515...>

Starting from 2.8.0, dco-win driver supports
epoch data channel. This adds missing userspace part.

While on it, fix broken assert introduced in e77c34.
Key-Id 0 is a perfectly valid.

Change-Id: Ib5ed5969dcd405a47e34ed8479b7ffaaa5c43080
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1219
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1219
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 6afc680..8fb4662 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -56,8 +56,9 @@
                 const char *ciphername)
 
 {
-    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d, currently %d keys installed", __func__,
-        multi->dco_peer_id, ks->key_id, multi->dco_keys_installed);
+    bool epoch = ks->crypto_options.flags & CO_EPOCH_DATA_KEY_FORMAT;
+    msg(D_DCO_DEBUG, "%s: peer_id=%d keyid=%d epoch=%d, currently %d keys installed", __func__,
+        multi->dco_peer_id, ks->key_id, multi->dco_keys_installed, epoch);
 
     /* Install a key in the PRIMARY slot only when no other key exist.
      * From that moment on, any new key will be installed in the SECONDARY
@@ -71,7 +72,7 @@
     }
 
     int ret = dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot, encrypt_key, encrypt_iv,
-                          decrypt_key, decrypt_iv, ciphername);
+                          decrypt_key, decrypt_iv, ciphername, epoch);
     if ((ret == 0) && (multi->dco_keys_installed < 2))
     {
         multi->dco_keys_installed++;
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index a362977..e5e8709 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -251,11 +251,8 @@
  * Return whether the dco implementation supports the new protocol features of
  * a 64 bit packet counter and AEAD tag at the end.
  */
-static inline bool
-dco_supports_epoch_data(struct context *c)
-{
-    return false;
-}
+bool
+dco_supports_epoch_data(struct context *c);
 #else  /* if defined(ENABLE_DCO) */
 
 typedef void *dco_context_t;
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index b9f6bc7..947a769 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -487,14 +487,14 @@
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
-            const uint8_t *decrypt_iv, const char *ciphername)
+            const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
     struct ifdrv drv;
     nvlist_t *nvl, *encrypt_nvl, *decrypt_nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, keyid, peerid,
-        ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d", __func__, slot, keyid, peerid,
+        ciphername, epoch);
 
     nvl = nvlist_create(0);
 
@@ -876,4 +876,10 @@
     return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
 }
 
+bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 86af003..97a7048 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -66,7 +66,7 @@
 
 int dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
                 const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
-                const uint8_t *decrypt_iv, const char *ciphername);
+                const uint8_t *decrypt_iv, const char *ciphername, bool epoch);
 
 int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot);
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index d46fa46..0ae30b1 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -596,10 +596,10 @@
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
-            const uint8_t *decrypt_iv, const char *ciphername)
+            const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, keyid, peerid,
-        ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, epoch %d", __func__, slot, keyid, peerid,
+        ciphername, epoch);
 
     const int key_len = cipher_kt_key_size(ciphername);
     const int nonce_tail_len = 8;
@@ -1298,4 +1298,10 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }
 
+bool
+dco_supports_epoch_data(struct context *c)
+{
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 30307de..ca5eedf 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -528,7 +528,7 @@
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
-            const uint8_t *decrypt_iv, const char *ciphername)
+            const uint8_t *decrypt_iv, const char *ciphername, bool epoch)
 {
     msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s", __func__, slot, keyid, peerid,
         ciphername);
@@ -537,29 +537,42 @@
     size_t key_len = cipher_kt_key_size(ciphername);
     ASSERT(key_len <= 32);
 
-    OVPN_CRYPTO_DATA crypto_data;
+    OVPN_CRYPTO_DATA_V2 crypto_data;
     ZeroMemory(&crypto_data, sizeof(crypto_data));
 
-    crypto_data.CipherAlg = dco_get_cipher(ciphername);
+    OVPN_CRYPTO_DATA *v1 = &crypto_data.V1;
+
+    v1->CipherAlg = dco_get_cipher(ciphername);
     ASSERT(keyid >= 0 && keyid <= UCHAR_MAX);
-    crypto_data.KeyId = (unsigned char)keyid;
-    crypto_data.PeerId = peerid;
-    crypto_data.KeySlot = slot;
+    v1->KeyId = (unsigned char)keyid;
+    v1->PeerId = peerid;
+    v1->KeySlot = slot;
 
-    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen = (unsigned char)key_len;
-    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
+    /* for epoch we use key material as a seed, no as actual key */
+    CopyMemory(v1->Encrypt.Key, encrypt_key, epoch ? 32 : key_len);
+    v1->Encrypt.KeyLen = (unsigned char)key_len;
+    CopyMemory(v1->Encrypt.NonceTail, encrypt_iv, nonce_len);
 
-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen = (unsigned char)key_len;
-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
+    CopyMemory(v1->Decrypt.Key, decrypt_key, epoch ? 32 : key_len);
+    v1->Decrypt.KeyLen = (unsigned char)key_len;
+    CopyMemory(v1->Decrypt.NonceTail, decrypt_iv, nonce_len);
 
-    ASSERT(crypto_data.CipherAlg > 0);
+    ASSERT(v1->CipherAlg > 0);
+
+    DWORD ioctl = OVPN_IOCTL_NEW_KEY;
+    VOID *buf = &crypto_data.V1;
+    DWORD bufSize = sizeof(crypto_data.V1);
+    if (epoch)
+    {
+        ioctl = OVPN_IOCTL_NEW_KEY_V2;
+        crypto_data.CryptoOptions |= CRYPTO_OPTIONS_EPOCH;
+        buf = &crypto_data;
+        bufSize = sizeof(crypto_data);
+    }
 
     DWORD bytes_returned = 0;
 
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data, sizeof(crypto_data), NULL,
-                         0, &bytes_returned, NULL))
+    if (!DeviceIoControl(dco->tt->hand, ioctl, buf, bufSize, NULL, 0, &bytes_returned, NULL))
     {
         msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
         return -1;
@@ -1076,4 +1089,11 @@
     gc_free(&gc);
 }
 
+bool
+dco_supports_epoch_data(struct context *c)
+{
+    OVPN_VERSION ver = { 0 };
+    return dco_get_version(&ver) && ((ver.Major == 2 && ver.Minor >= 8) || (ver.Major > 2));
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index 9e1378a..e76770b 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -118,6 +118,13 @@
 	int PeerId;
 } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
 
+#define CRYPTO_OPTIONS_EPOCH (1<<1)
+
+typedef struct _OVPN_CRYPTO_DATA_V2 {
+    OVPN_CRYPTO_DATA V1;
+    UINT32 CryptoOptions;
+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
+
 typedef struct _OVPN_MP_SET_PEER {
     int PeerId;
     LONG KeepaliveInterval;

