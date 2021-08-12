From: Antonio Quartulli <a@...2181...>
Date: Thu, 12 Aug 2021 10:53:00 +0200
Message-Id: <20210812085300.4738-1-a@...2181...>
In-Reply-To: <20210812075757.31759-1-a@...2181...>
References: <20210812075757.31759-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] mbedtls: do not define
 mbedtls_ctr_drbg_update_ret when not needed
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
Cc: Antonio Quartulli <a@...2181...>, Max Fillinger <maximilian.fillinger@...2507...>

The mbedtls_ctr_drbg_update_ret() function was backported to various
older branches, including 2.14 and 2.7.
To aqvoid making the if guard too complex, let's detect if this function
exist at configure time.
All versions not having this function, will use our compat code.

Cc: Max Fillinger <maximilian.fillinger@...2507...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Compile tests:
* Testing mbedtls-2.7.19...
* mbedtls-2.7.19 OK
* Testing mbedtls-2.10.0...
* mbedtls-2.10.0 OK
* Testing mbedtls-2.14.1...
* mbedtls-2.14.1 OK
* Testing mbedtls-2.16.11...
* mbedtls-2.16.11 OK
* Testing mbedtls-2.20.0...
* mbedtls-2.20.0 OK
* Testing mbedtls-2.26.0...
* mbedtls-2.26.0 OK
* Testing mbedtls-2.27.0...
* mbedtls-2.27.0 OK

 configure.ac              | 6 ++++++
 src/openvpn/ssl_mbedtls.c | 5 ++++-
 2 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 56b536dc..5d378962 100644
--- a/configure.ac
+++ b/configure.ac
@@ -891,6 +891,12 @@ elif test "${with_crypto_library}" = "mbedtls"; then
 		[have_export_keying_material="no"]
 	)
 
+	AC_CHECK_FUNC(
+		[mbedtls_ctr_drbg_update_ret],
+		AC_DEFINE([HAVE_CTR_DRBG_UPDATE_RET], [1],
+			  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),
+	)
+
 	CFLAGS="${saved_CFLAGS}"
 	LIBS="${saved_LIBS}"
 	AC_DEFINE([ENABLE_CRYPTO_MBEDTLS], [1], [Use mbed TLS library])
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 1853335e..cea88f41 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -66,8 +66,11 @@
  * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 and
  * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
  * For older versions, we call mbedtls_ctr_drbg_update and return 0 (success).
+ *
+ * Note: this change was backported to other mbedTLS branches, therefore we
+ * rely on function detection at configure time.
  */
-#if MBEDTLS_VERSION_NUMBER < 0x02100000
+#ifndef HAVE_CTR_DRBG_UPDATE_RET
 static int mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,
                                        const unsigned char *additional,
                                        size_t add_len)
-- 
2.31.1


