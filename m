Sender: Emmanuel Deloget <emmanueldeloget53@...277...>
From: Emmanuel Deloget <logout@...260...>
Date: Wed, 17 Jan 2018 14:10:46 +0100
Message-Id: <20180117131046.32402-2-logout@...260...>
In-Reply-To: <20180117131046.32402-1-logout@...260...>
References: <20180117131046.32402-1-logout@...260...>
In-Reply-To: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
References: <CAKh=nwEOYB6Ab42xZUPkaHEWDwx-ECJVn79kh-rz0Y8HvG4Dbw@...278...>
Subject: [Openvpn-devel] [PATCH v3 2/2] OpenSSL: remove EVP_PKEY_id()
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
---
 configure.ac                 |  1 -
 src/openvpn/openssl_compat.h | 14 --------------
 2 files changed, 15 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2c1937e5..e855a241 100644
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
index 05ec4e95..2c8913e1 100644
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


