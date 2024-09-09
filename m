From: Gert Doering <gert@...1296...>
Date: Mon,  9 Sep 2024 16:23:30 +0200
Message-ID: <20240909142330.20424-1-gert@...1296...>
In-Reply-To: <gerrit.1723550412000.I2e0c50d33f8a57c023120cf348f95d34acbfcde5@...2715...>
References: <gerrit.1723550412000.I2e0c50d33f8a57c023120cf348f95d34acbfcde5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] dco-win: support for data_v3 features
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

Since version 1.4, dco-win drivere supports data_v3 features
such as:

 - AEAD tag at the end
 - 64bit pktid

We have to:

 - check in runtime if driver supports data_v3 features (we might be
 running with the older driver)

 - if those features are negotiated, we pass them to the driver
 as bit flags via the (newly added) NEW_KEY_V2 ioctl

Introduce NEW_KEY_V2 ioctl, which accepts a new OVPN_CRYPTO_DATA_V2
structure, which includes a field for bit flags for the new
crypto options.

Make dco_supports_data_v3() implementation platform-dependend (as it
should be) and indicate data_v3 support by dco-win if the driver version
is at least 1.4. Extend the Windows-specific struct dco_context and
store data_v3 support there so that when dco_new_key() is called, we
know which API to use.

Change the dco internal API and pass crypto options flags to dco_new_key().

Change-Id: I2e0c50d33f8a57c023120cf348f95d34acbfcde5
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/725
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7f0d53d..baaeb95 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -70,7 +70,7 @@
     int ret = dco_new_key(multi->dco, multi->dco_peer_id, ks->key_id, slot,
                           encrypt_key, encrypt_iv,
                           decrypt_key, decrypt_iv,
-                          ciphername);
+                          ciphername, ks->crypto_options.flags);
     if ((ret == 0) && (multi->dco_keys_installed < 2))
     {
         multi->dco_keys_installed++;
diff --git a/src/openvpn/dco.h b/src/openvpn/dco.h
index 3ce2c31..ec4ec42 100644
--- a/src/openvpn/dco.h
+++ b/src/openvpn/dco.h
@@ -253,11 +253,7 @@
  * Return whether the dco implementation supports the new protocol features of
  * a 64 bit packet counter and AEAD tag at the end.
  */
-static inline bool
-dco_supports_data_v3(struct context *c)
-{
-    return false;
-}
+bool dco_supports_data_v3(struct context *c);
 
 #else /* if defined(ENABLE_DCO) */
 
diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 9a90f5c..4516cd5 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -415,14 +415,14 @@
             dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
             const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
+            const char *ciphername, unsigned int co_flags)
 {
     struct ifdrv drv;
     nvlist_t *nvl;
     int ret;
 
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, co_flags %u",
+        __func__, slot, keyid, peerid, ciphername, co_flags);
 
     nvl = nvlist_create(0);
 
@@ -778,4 +778,11 @@
     return "none:AES-256-GCM:AES-192-GCM:AES-128-GCM:CHACHA20-POLY1305";
 }
 
+bool
+dco_supports_data_v3(struct context *c)
+{
+    /* not implemented */
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_FREEBSD) */
diff --git a/src/openvpn/dco_internal.h b/src/openvpn/dco_internal.h
index 624c110..35500a4 100644
--- a/src/openvpn/dco_internal.h
+++ b/src/openvpn/dco_internal.h
@@ -70,7 +70,7 @@
                 dco_key_slot_t slot,
                 const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
                 const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-                const char *ciphername);
+                const char *ciphername, unsigned int co_flags);
 
 int dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot);
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 277cd64..4197d30 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -557,10 +557,10 @@
             dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
             const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
+            const char *ciphername, unsigned int co_flags)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, co_flags %u",
+        __func__, slot, keyid, peerid, ciphername, co_flags);
 
     const size_t key_len = cipher_kt_key_size(ciphername);
     const int nonce_tail_len = 8;
@@ -1058,4 +1058,11 @@
     return "AES-128-GCM:AES-256-GCM:AES-192-GCM:CHACHA20-POLY1305";
 }
 
+bool
+dco_supports_data_v3(struct context *c)
+{
+    /* not implemented */
+    return false;
+}
+
 #endif /* defined(ENABLE_DCO) && defined(TARGET_LINUX) */
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 3ec946f..189864b 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -55,6 +55,9 @@
 bool
 ovpn_dco_init(int mode, dco_context_t *dco)
 {
+    dco->supports_data_v3 = dco_supports_data_v3(NULL);
+    msg(D_DCO_DEBUG, "dco supports data_v3: %d", dco->supports_data_v3);
+
     return true;
 }
 
@@ -291,47 +294,85 @@
     return 0;
 }
 
-int
-dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
-            dco_key_slot_t slot,
-            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
-            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
-            const char *ciphername)
+static int
+dco_new_key_v1(HANDLE handle, OVPN_CRYPTO_DATA *crypto_data)
 {
-    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s",
-        __func__, slot, keyid, peerid, ciphername);
-
-    const int nonce_len = 8;
-    size_t key_len = cipher_kt_key_size(ciphername);
-
-    OVPN_CRYPTO_DATA crypto_data;
-    ZeroMemory(&crypto_data, sizeof(crypto_data));
-
-    crypto_data.CipherAlg = dco_get_cipher(ciphername);
-    crypto_data.KeyId = keyid;
-    crypto_data.PeerId = peerid;
-    crypto_data.KeySlot = slot;
-
-    CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen = (char)key_len;
-    CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
-
-    CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen = (char)key_len;
-    CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
-
-    ASSERT(crypto_data.CipherAlg > 0);
-
     DWORD bytes_returned = 0;
 
-    if (!DeviceIoControl(dco->tt->hand, OVPN_IOCTL_NEW_KEY, &crypto_data,
-                         sizeof(crypto_data), NULL, 0, &bytes_returned, NULL))
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_KEY, crypto_data, sizeof(*crypto_data), NULL, 0, &bytes_returned, NULL))
     {
         msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY) failed");
         return -1;
     }
     return 0;
 }
+
+static int
+dco_new_key_v2(HANDLE handle, OVPN_CRYPTO_DATA_V2 *crypto_data, unsigned int co_flags)
+{
+    if (co_flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        crypto_data->CryptoOptions |= CRYPTO_OPTIONS_AEAD_TAG_END;
+    }
+
+    if (co_flags & CO_64_BIT_PKT_ID)
+    {
+        crypto_data->CryptoOptions |= CRYPTO_OPTIONS_64BIT_PKTID;
+    }
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(handle, OVPN_IOCTL_NEW_KEY_V2, crypto_data, sizeof(*crypto_data), NULL, 0, &bytes_returned, NULL))
+    {
+        msg(M_ERR, "DeviceIoControl(OVPN_IOCTL_NEW_KEY_V2) failed");
+        return -1;
+    }
+
+    return 0;
+}
+
+int
+dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid,
+            dco_key_slot_t slot,
+            const uint8_t *encrypt_key, const uint8_t *encrypt_iv,
+            const uint8_t *decrypt_key, const uint8_t *decrypt_iv,
+            const char *ciphername, unsigned int co_flags)
+{
+    msg(D_DCO_DEBUG, "%s: slot %d, key-id %d, peer-id %d, cipher %s, co_flags %u",
+        __func__, slot, keyid, peerid, ciphername, co_flags);
+
+    const int nonce_len = 8;
+    size_t key_len = cipher_kt_key_size(ciphername);
+
+    OVPN_CRYPTO_DATA_V2 crypto_data_v2;
+    ZeroMemory(&crypto_data_v2, sizeof(crypto_data_v2));
+
+    OVPN_CRYPTO_DATA *crypto_data = &crypto_data_v2.V1;
+
+    crypto_data->CipherAlg = dco_get_cipher(ciphername);
+    crypto_data->KeyId = keyid;
+    crypto_data->PeerId = peerid;
+    crypto_data->KeySlot = slot;
+
+    CopyMemory(crypto_data->Encrypt.Key, encrypt_key, key_len);
+    crypto_data->Encrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data->Encrypt.NonceTail, encrypt_iv, nonce_len);
+
+    CopyMemory(crypto_data->Decrypt.Key, decrypt_key, key_len);
+    crypto_data->Decrypt.KeyLen = (char)key_len;
+    CopyMemory(crypto_data->Decrypt.NonceTail, decrypt_iv, nonce_len);
+
+    ASSERT(crypto_data->CipherAlg > 0);
+
+    if (dco->supports_data_v3)
+    {
+        return dco_new_key_v2(dco->tt->hand, &crypto_data_v2, co_flags);
+    }
+    else
+    {
+        return dco_new_key_v1(dco->tt->hand, crypto_data);
+    }
+}
+
 int
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {
@@ -494,4 +535,39 @@
     }
 }
 
+bool
+dco_supports_data_v3(struct context *c)
+{
+    bool res = false;
+
+    HANDLE h = CreateFile("\\\\.\\ovpn-dco-ver", GENERIC_READ,
+                          0, NULL, OPEN_EXISTING, 0, NULL);
+
+    if (h == INVALID_HANDLE_VALUE)
+    {
+        goto done;
+    }
+
+    OVPN_VERSION version;
+    ZeroMemory(&version, sizeof(OVPN_VERSION));
+
+    DWORD bytes_returned = 0;
+    if (!DeviceIoControl(h, OVPN_IOCTL_GET_VERSION, NULL, 0,
+                         &version, sizeof(version), &bytes_returned, NULL))
+    {
+        goto done;
+    }
+
+    /* data_v3 is supported starting from 1.4 */
+    res = (version.Major > 1) || (version.Minor >= 4);
+
+done:
+    if (h != INVALID_HANDLE_VALUE)
+    {
+        CloseHandle(h);
+    }
+
+    return res;
+}
+
 #endif /* defined(_WIN32) */
diff --git a/src/openvpn/dco_win.h b/src/openvpn/dco_win.h
index 4883629..f58488f 100644
--- a/src/openvpn/dco_win.h
+++ b/src/openvpn/dco_win.h
@@ -33,6 +33,7 @@
 
 struct dco_context {
     struct tuntap *tt;
+    bool supports_data_v3;
 };
 
 typedef struct dco_context dco_context_t;
diff --git a/src/openvpn/ovpn_dco_win.h b/src/openvpn/ovpn_dco_win.h
index ea2a733..9e437f0 100644
--- a/src/openvpn/ovpn_dco_win.h
+++ b/src/openvpn/ovpn_dco_win.h
@@ -94,6 +94,14 @@
 	int PeerId;
 } OVPN_CRYPTO_DATA, * POVPN_CRYPTO_DATA;
 
+#define CRYPTO_OPTIONS_AEAD_TAG_END (1<<1)
+#define CRYPTO_OPTIONS_64BIT_PKTID  (1<<2)
+
+typedef struct _OVPN_CRYPTO_DATA_V2 {
+    OVPN_CRYPTO_DATA V1;
+    UINT32 CryptoOptions;
+} OVPN_CRYPTO_DATA_V2, * POVPN_CRYPTO_DATA_V2;
+
 typedef struct _OVPN_SET_PEER {
 	LONG KeepaliveInterval;
 	LONG KeepaliveTimeout;
@@ -114,3 +122,4 @@
 #define OVPN_IOCTL_START_VPN    CTL_CODE(FILE_DEVICE_UNKNOWN, 6, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_DEL_PEER     CTL_CODE(FILE_DEVICE_UNKNOWN, 7, METHOD_BUFFERED, FILE_ANY_ACCESS)
 #define OVPN_IOCTL_GET_VERSION  CTL_CODE(FILE_DEVICE_UNKNOWN, 8, METHOD_BUFFERED, FILE_ANY_ACCESS)
+#define OVPN_IOCTL_NEW_KEY_V2   CTL_CODE(FILE_DEVICE_UNKNOWN, 9, METHOD_BUFFERED, FILE_ANY_ACCESS)

