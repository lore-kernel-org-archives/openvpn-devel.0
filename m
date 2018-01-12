Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 12 Jan 2018 17:48:26 +0100
Message-Id: <cdffbc73cd197b4ac2ca65dcf3f9dfa238f733b4.1515775195.git.logout@...260...>
In-Reply-To: <cover.1515775195.git.logout@...260...>
References: <cover.1515775195.git.logout@...260...>
In-Reply-To: <cover.1515775195.git.logout@...260...>
References: <cover.1515775195.git.logout@...260...>
Subject: [Openvpn-devel] [PATCH 3/3] OpenSSL: remove EVP_PKEY_id()
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

The function is no longer used so we don't need to keep it in the
OpenSSL 1.1 compatibility layer.

Signed-off-by: Emmanuel Deloget <logout@...260...>

diff --git a/configure.ac b/configure.ac
index b4fd1b3f..716b45dc 100644
--- a/configure.ac
+++ b/configure.ac
@@ -925,7 +925,6 @@ if test "${with_crypto_library}" = "openssl"; then
 			X509_STORE_get0_objects \
 			X509_OBJECT_free \
 			X509_OBJECT_get_type \
-			EVP_PKEY_id \
 			EVP_PKEY_get0_RSA \
 			EVP_PKEY_get0_DSA \
 			EVP_PKEY_get0_EC_KEY \
diff --git a/src/openvpn/openssl_compat.h b/src/openvpn/openssl_compat.h
index 8b29cdaf..2c4a08c1 100644
--- a/src/openvpn/openssl_compat.h
+++ b/src/openvpn/openssl_compat.h
@@ -258,20 +258,6 @@ EVP_PKEY_get0_EC_KEY(EVP_PKEY *pkey)
 }
 #endif
 
-#if !defined(HAVE_EVP_PKEY_ID)
-/**
- * Get the PKEY type
- *
- * @param pkey                Public key object
- * @return                    The key type
- */
-static inline int
-EVP_PKEY_id(const EVP_PKEY *pkey)
-{
-    return pkey ? pkey->type : EVP_PKEY_NONE;
-}
-#endif
-
 #if !defined(HAVE_EVP_PKEY_GET0_DSA)
 /**
  * Get the DSA object of a public key
-- 
2.11.0


