From: Magnus Kroken <mkroken@...277...>
Date: Fri,  9 Dec 2016 10:07:35 +0100
Message-Id: <1481274455-657-1-git-send-email-mkroken@...277...>
Subject: [Openvpn-devel] [PATCH] mbedtls: include correct net/net_sockets
	header according to version
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

<mbedtls/net.h> is deprecated as of mbedTLS 2.4.0, it is renamed
<mbedtls/net_sockets.h>. OpenVPN will fail to build with
mbedTLS 2.4.0 with MBEDTLS_DEPRECATED_REMOVED defined.

Check MBEDTLS_VERSION_NUMBER, and include net.h for < 2.4.0 and
net_sockets.h for >= 2.4.0.

Signed-off-by: Magnus Kroken <mkroken@...277...>
---
Tested, builing with both mbedTLS 2.3.0 and 2.4.0 with 
MBEDTLS_DEPRECATED_REMOVED is successful. 

This patch is as much to document the issue as a suggested patch.
I don't know if MBEDTLS_DEPRECATED_REMOVED is considered a
distro/package maintainers problem or something to fix with 
an #if, so I won't be sad if it isn't accepted.

 src/openvpn/ssl_mbedtls.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 11ee65b..985a39f 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -51,11 +51,17 @@
 #include "ssl_verify_mbedtls.h"
 #include <mbedtls/debug.h>
 #include <mbedtls/error.h>
-#include <mbedtls/net.h>
+#include <mbedtls/version.h>
+
+#if MBEDTLS_VERSION_NUMBER >= 0x02040000
+    #include <mbedtls/net_sockets.h>
+#else
+    #include <mbedtls/net.h>
+#endif
+
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>
 #include <mbedtls/sha256.h>
-#include <mbedtls/version.h>
 
 void
 tls_init_lib()
-- 
2.1.4


