From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Jun 2021 09:12:26 +0300
Message-Id: <20210617061226.244-1-lstipakov@...277...>
In-Reply-To: <20210617061027.140-1-lstipakov@...277...>
References: <20210617061027.140-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] crypto_openssl.c: disable explicit
 initialization on Windows
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Commit a4071b ("crypto_openssl: add initialization to pick up local configuration")
added openssl initialization to load configuration file. However on Windows
this file is loaded from user-writable directory, such as c.\etc\ssl for mingw builds
and (for example) c:\vcpkg\packages\openssl_x64-windows\openvpn.cnf for vcpkg
builds. This could be a security risk.

Since aforementioned commit implements a niche feature which anyway
should use CryptoAPI on Windows, make this code conditional.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/crypto_openssl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index c571030b..603c67b0 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -154,11 +154,13 @@ crypto_init_lib_engine(const char *engine_name)
 void
 crypto_init_lib(void)
 {
+#ifndef _WIN32
 #if (OPENSSL_VERSION_NUMBER >= 0x10100000L)
     OPENSSL_init_crypto(OPENSSL_INIT_LOAD_CONFIG, NULL);
 #else
     OPENSSL_config(NULL);
 #endif
+#endif /* _WIN32 */
     /*
      * If you build the OpenSSL library and OpenVPN with
      * CRYPTO_MDEBUG, you will get a listing of OpenSSL
-- 
2.23.0.windows.1


