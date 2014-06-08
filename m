From: Steffan Karger <steffan@...1856...>
Date: Sun,  8 Jun 2014 18:16:12 +0200
Message-Id: <1402244175-31462-2-git-send-email-steffan@...1856...>
In-Reply-To: <1402244175-31462-1-git-send-email-steffan@...1856...>
References: <1402244175-31462-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/4] Rename ALLOW_NON_CBC_CIPHERS to
	ENABLE_OFB_CFB_MODE, and add to configure.
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

Makes OFB/CFB compile time configurable, and fixes output of --show-ciphers
to also show OFB/CFB ciphers along the way (becasue crypto.h was not
included from crypto_openssl.c).

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                 | 8 ++++++++
 src/openvpn/crypto.c         | 2 +-
 src/openvpn/crypto.h         | 2 --
 src/openvpn/crypto_openssl.c | 2 +-
 4 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/configure.ac b/configure.ac
index 6f405ea..39174ff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -72,6 +72,13 @@ AC_ARG_ENABLE(
 )
 
 AC_ARG_ENABLE(
+	[ofb-cfb],
+	[AS_HELP_STRING([--enable-ofb-cfb], [enable support for OFB and CFB cipher modes @<:@default=yes@:>@])],
+	,
+	[enable_crypto_ofb_cfb="yes"]
+)
+
+AC_ARG_ENABLE(
 	[ssl],
 	[AS_HELP_STRING([--disable-ssl], [disable SSL support for TLS-based key exchange @<:@default=yes@:>@])],
 	,
@@ -1093,6 +1100,7 @@ fi
 
 if test "${enable_crypto}" = "yes"; then
 	test "${have_crypto_crypto}" != "yes" && AC_MSG_ERROR([${with_crypto_library} crypto is required but missing])
+	test "${enable_crypto_ofb_cfb}" = "yes" && AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
 	OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CRYPTO_CFLAGS}"
 	OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_CRYPTO_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO], [1], [Enable crypto library])
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index d0dc069..2a7fcb2 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -428,7 +428,7 @@ init_key_type (struct key_type *kt, const char *ciphername,
       {
 	const unsigned int mode = cipher_kt_mode (kt->cipher);
 	if (!(mode == OPENVPN_MODE_CBC
-#ifdef ALLOW_NON_CBC_CIPHERS
+#ifdef ENABLE_OFB_CFB_MODE
 	      || (cfb_ofb_allowed && (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB))
 #endif
 	      ))
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 3b4b88e..1f1e1b6 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -32,8 +32,6 @@
 
 #ifdef ENABLE_CRYPTO
 
-#define ALLOW_NON_CBC_CIPHERS
-
 #include "crypto_backend.h"
 #include "basic.h"
 #include "buffer.h"
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index c3480e0..74539b6 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -263,7 +263,7 @@ show_available_ciphers ()
 	{
 	  const unsigned int mode = EVP_CIPHER_mode (cipher);
 	  if (mode == EVP_CIPH_CBC_MODE
-#ifdef ALLOW_NON_CBC_CIPHERS
+#ifdef ENABLE_OFB_CFB_MODE
 	      || mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE
 #endif
 	      )
-- 
1.9.1


