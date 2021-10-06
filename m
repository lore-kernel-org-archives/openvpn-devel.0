From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  6 Oct 2021 12:07:09 +0300
Message-Id: <20211006090709.200-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Fix loading PKCS12 files on Windows
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

Starting from 2.5.4 we have switched to MSVC builds,
including dependencies such as OpenSSL.

When we link with natively-built OpenSSL .DLLs
(not cross compiled with MinGW), we are expected to include
applink.c, which provides glue between OpenSSL BIO layer
and compiler run-time. This doesn't apply to ARM64.

Failure to do that results in "no OPENSSL_Applink" fatal error
when calling, for example, d2i_PKCS12_fp(), which we do when
loading PKCS12 files.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/ssl_openssl.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 31d94f2b..27fb66aa 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -65,6 +65,10 @@
 #include <openssl/ec.h>
 #endif
 
+#if defined(_MSC_VER) && !defined(_M_ARM64)
+#include <openssl/applink.c>
+#endif
+
 /*
  * Allocate space in SSL objects in which to store a struct tls_session
  * pointer back to parent.
-- 
2.23.0.windows.1


