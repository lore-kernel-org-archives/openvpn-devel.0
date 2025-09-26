From: Gert Doering <gert@...1296...>
Date: Fri, 26 Sep 2025 18:51:46 +0200
Message-ID: <20250926165151.1502-1-gert@...1296...>
In-Reply-To: <gerrit.1758890729000.I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258@...2715...>
References: <gerrit.1758890729000.I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] dco_win: In dco_new_key,
 document size assumptions for the integer casts
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

From: Frank Lichtenheld <frank@...2641...>

And make all casts explicit so that compiler doesn't complain.

Change-Id: I612bf3b1c56d70a89fc04fad6fe36fd9fadfd258
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1221
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1221
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/dco_win.c b/src/openvpn/dco_win.c
index 9e52859..7dd43d6 100644
--- a/src/openvpn/dco_win.c
+++ b/src/openvpn/dco_win.c
@@ -525,11 +525,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 dco_new_key(dco_context_t *dco, unsigned int peerid, int keyid, dco_key_slot_t slot,
             const uint8_t *encrypt_key, const uint8_t *encrypt_iv, const uint8_t *decrypt_key,
@@ -540,21 +535,23 @@
 
     const int nonce_len = 8;
     size_t key_len = cipher_kt_key_size(ciphername);
+    ASSERT(key_len <= 32);
 
     OVPN_CRYPTO_DATA crypto_data;
     ZeroMemory(&crypto_data, sizeof(crypto_data));
 
     crypto_data.CipherAlg = dco_get_cipher(ciphername);
-    crypto_data.KeyId = keyid;
+    ASSERT(keyid > 0 && keyid <= UCHAR_MAX);
+    crypto_data.KeyId = (unsigned char)keyid;
     crypto_data.PeerId = peerid;
     crypto_data.KeySlot = slot;
 
     CopyMemory(crypto_data.Encrypt.Key, encrypt_key, key_len);
-    crypto_data.Encrypt.KeyLen = (char)key_len;
+    crypto_data.Encrypt.KeyLen = (unsigned char)key_len;
     CopyMemory(crypto_data.Encrypt.NonceTail, encrypt_iv, nonce_len);
 
     CopyMemory(crypto_data.Decrypt.Key, decrypt_key, key_len);
-    crypto_data.Decrypt.KeyLen = (char)key_len;
+    crypto_data.Decrypt.KeyLen = (unsigned char)key_len;
     CopyMemory(crypto_data.Decrypt.NonceTail, decrypt_iv, nonce_len);
 
     ASSERT(crypto_data.CipherAlg > 0);
@@ -570,10 +567,6 @@
     return 0;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 dco_del_key(dco_context_t *dco, unsigned int peerid, dco_key_slot_t slot)
 {

