From: Arne Schwabe <arne@...1227...>
Date: Sun, 19 Sep 2021 18:29:52 +0200
Message-Id: <20210919162956.695496-4-arne@...1227...>
In-Reply-To: <20210919162956.695496-1-arne@...1227...>
References: <20210919162956.695496-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/8] [OSSL 3.0] Remove DES check with
 OpenSSL 3.0
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

DES is very deprecated and accidently getting on the of the 16 insecure
keys that OpenSSL checks is extremely unlikely so we no longer use the
deprecated functions without replacement in OpenSSL 3.0.
---
 src/openvpn/crypto_openssl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index b4c59557b..9df6da02c 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -522,6 +522,11 @@ key_des_num_cblocks(const EVP_CIPHER *kt)
 bool
 key_des_check(uint8_t *key, int key_len, int ndc)
 {
+#if OPENSSL_VERSION_NUMBER < 0x30000000L
+    /* DES is deprecated and the method to even check the keys is deprecated
+     * in OpenSSL 3.0. Instead of checking for the 16 weak/semi-weak keys
+     * we just accept them in OpenSSL 3.0 since the risk of randomly getting
+     * these is pretty weak */
     int i;
     struct buffer b;
 
@@ -554,6 +559,9 @@ key_des_check(uint8_t *key, int key_len, int ndc)
 err:
     ERR_clear_error();
     return false;
+#else
+    return true;
+#endif
 }
 
 void
-- 
2.33.0


