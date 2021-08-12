From: Antonio Quartulli <a@...2181...>
Date: Thu, 12 Aug 2021 09:57:57 +0200
Message-Id: <20210812075757.31759-1-a@...2181...>
In-Reply-To: <YRQA6duboZXtB9do@...1296...>
References: <YRQA6duboZXtB9do@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] mbedtls: do not define
 mbedtls_ctr_drbg_update_ret for mbedtls <2.15 and >=2.14.1
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

The mbedtls_ctr_drbg_update_ret() function was backported to the 2.14
branch of mbedtls since 2.14.1. For this reason, we must exclude the
definition of our compat function for mbedtls >=2.14.1 but <2.15

Cc: Max Fillinger <maximilian.fillinger@...2507...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---

Successfully compiled tested on mbedTLS:
* 2.10.0
* 2.14.1
* 2.20.0
* 2.26.0

 src/openvpn/ssl_mbedtls.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 1853335e..a2ed59ac 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -66,8 +66,13 @@
  * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 and
  * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
  * For older versions, we call mbedtls_ctr_drbg_update and return 0 (success).
+ *
+ * Note: mbedtls_ctr_drbg_update_ret was backported to the mbedtls 2.14 branch
+ * since 2.14.1. For this reason, the definition of this function has to be
+ * excluded for any mbedtls going from 2.14.1 (included) to 2.15 (excluded)
  */
-#if MBEDTLS_VERSION_NUMBER < 0x02100000
+#if MBEDTLS_VERSION_NUMBER < 0x02100000 && \
+	!(MBEDTLS_VERSION_NUMBER > 0x020E0000 && MBEDTLS_VERSION_NUMBER < 0x020F0000)
 static int mbedtls_ctr_drbg_update_ret(mbedtls_ctr_drbg_context *ctx,
                                        const unsigned char *additional,
                                        size_t add_len)
-- 
2.31.1


