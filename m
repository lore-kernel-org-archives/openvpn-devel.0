From: selva.nair@...277...
Date: Wed, 21 Feb 2018 11:46:02 -0500
Message-Id: <1519231562-5641-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Disable external ec key support when
 building with libressl
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

From: Selva Nair <selva.nair@...277...>

- This codepath uses some openssl-1.1 specific API and is enabled only
  for openssl 1.1 and higher versions. But, due to incompatible
  version numbering in libressl, it gets wrongly enabled with libressl
  versions that do not support the reqired API. As an easy workaround
  disable the feature when LIBRESSL_VERSION_NUMBER is defined.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Caution: Only partially compile tested on freebsd 11 + libressl 2.6.4
due to other conflicts with that version of libressl.

 src/openvpn/ssl_openssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 56b12b7..d91458b 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1159,7 +1159,7 @@ err:
     return 0;
 }
 
-#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC) && !defined(LIBRESSL_VERSION_NUMBER)
 
 /* called when EC_KEY is destroyed */
 static void
@@ -1307,7 +1307,7 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
             goto err;
         }
     }
-#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC)
+#if OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(OPENSSL_NO_EC) && !defined(LIBRESSL_VERSION_NUMBER)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
         if (!tls_ctx_use_external_ec_key(ctx, pkey))
-- 
2.1.4


