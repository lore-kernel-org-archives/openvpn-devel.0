From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:55:09 +0200
Message-ID: <1308909312-17824-17-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 25/28] Refactored: Moved crypto.h inline
	functions to end of file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

---
 crypto.h |   21 +++++++++++----------
 1 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/crypto.h b/crypto.h
index 2888021..dd99598 100644
--- a/crypto.h
+++ b/crypto.h
@@ -480,16 +480,6 @@ void free_ssl_lib (void);
 #endif /* USE_SSL */
 
 /*
- * Inline functions
- */
-
-static inline bool
-key_ctx_bi_defined(const struct key_ctx_bi* key)
-{
-  return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher || key->decrypt.hmac;
-}
-
-/*
  * md5 functions
  */
 
@@ -509,5 +499,16 @@ void md5_digest_clear (struct md5_digest *digest);
 bool md5_digest_defined (const struct md5_digest *digest);
 bool md5_digest_equal (const struct md5_digest *d1, const struct md5_digest *d2);
 
+/*
+ * Inline functions
+ */
+
+static inline bool
+key_ctx_bi_defined(const struct key_ctx_bi* key)
+{
+  return key->encrypt.cipher || key->encrypt.hmac || key->decrypt.cipher || key->decrypt.hmac;
+}
+
+
 #endif /* USE_CRYPTO */
 #endif /* CRYPTO_H */
-- 
1.7.4.1


