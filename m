From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:15 +0100
Message-ID: <1320074961-3809-3-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/8] Moved CryptoAPI header include to the
	ssl_openssl.c
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 ssl.c         |    4 ----
 ssl_openssl.c |    4 ++++
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/ssl.c b/ssl.c
index 955a0d1..c26756e 100644
--- a/ssl.c
+++ b/ssl.c
@@ -62,10 +62,6 @@
 #include "ssl_verify.h"
 #include "ssl_backend.h"
 
-#ifdef WIN32
-#include "cryptoapi.h"
-#endif
-
 #include "memdbg.h"
 
 #ifndef ENABLE_OCC
diff --git a/ssl_openssl.c b/ssl_openssl.c
index a1e45d9..1cc2bfb 100644
--- a/ssl_openssl.c
+++ b/ssl_openssl.c
@@ -39,6 +39,10 @@
 #include "ssl_backend.h"
 #include "ssl_common.h"
 
+#ifdef ENABLE_CRYPTOAPI
+#include "cryptoapi.h"
+#endif
+
 #include "ssl_verify_openssl.h"
 
 #include <openssl/err.h>
-- 
1.7.5.4


