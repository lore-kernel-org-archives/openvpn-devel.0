From: Frank de Brabander <brabander@...1435...>
Date: Thu, 16 Feb 2012 13:02:32 +0100
Message-ID: <CB62AEE8.E86%brabander@...1435...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Cipher problem on Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hello,

I have looked into the problem, it seems to be caused by the return type
of cipher_kt_mode() in crypto_backend.h being declared as a bool. This
function is called from init_key_type() of crypto.c during the tests. The
actual mode value in cipher_kt_mode() of openssl_backend.c during the
failed test is 2, but is converted to 1 due to this boolean return type.
My guess is that this is only happening on OS X because of a specific GCC
compiler version or custom Apple patches.

Below I have included a patch that changes the bool return type to an int.
This will result in 'make check' to pass.

diff --git a/crypto_backend.h b/crypto_backend.h
index 8622962..a0966dd 100644
--- a/crypto_backend.h
+++ b/crypto_backend.h
@@ -218,7 +218,7 @@ int cipher_kt_block_size (const cipher_kt_t
*cipher_kt);
  * @return             Cipher mode, either \c OPENVPN_MODE_CBC, \c
  *                     OPENVPN_MODE_OFB or \c OPENVPN_MODE_CFB
  */
-bool cipher_kt_mode (const cipher_kt_t *cipher_kt);
+int cipher_kt_mode (const cipher_kt_t *cipher_kt);
=20
=20
 /**
diff --git a/crypto_openssl.c b/crypto_openssl.c
index db6b78e..0a41b39 100644
--- a/crypto_openssl.c
+++ b/crypto_openssl.c
@@ -555,7 +555,7 @@ cipher_kt_block_size (const EVP_CIPHER *cipher_kt)
   return EVP_CIPHER_block_size (cipher_kt);
 }
=20
-bool
+int
 cipher_kt_mode (const EVP_CIPHER *cipher_kt)
 {
   ASSERT(NULL !=3D cipher_kt);
diff --git a/crypto_polarssl.c b/crypto_polarssl.c
index e7470d5..ac4cadd 100644
--- a/crypto_polarssl.c
+++ b/crypto_polarssl.c
@@ -313,7 +313,7 @@ cipher_kt_block_size (const cipher_info_t *cipher_kt)
   return cipher_kt->block_size;
 }
=20
-bool
+int
 cipher_kt_mode (const cipher_info_t *cipher_kt)
 {
   ASSERT(NULL !=3D cipher_kt);


