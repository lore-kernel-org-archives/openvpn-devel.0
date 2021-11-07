From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Sun, 7 Nov 2021 17:05:08 +0100
Message-ID: <20211107160508.3935-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove unused havege.h header
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

This header was removed in mbedtls 3. Luckily, we weren't actually
using it, it seems.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/crypto_mbedtls.c | 1 -
 src/openvpn/ssl_mbedtls.c    | 2 --
 2 files changed, 3 deletions(-)

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 2f7f00d1..72e19d23 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -50,7 +50,6 @@
 #include <mbedtls/error.h>
 #include <mbedtls/md5.h>
 #include <mbedtls/cipher.h>
-#include <mbedtls/havege.h>
 #include <mbedtls/pem.h>
 
 #include <mbedtls/entropy.h>
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index e7c45c09..1cb27aaa 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -46,8 +46,6 @@
 #include "pkcs11_backend.h"
 #include "ssl_common.h"
 
-#include <mbedtls/havege.h>
-
 #include "ssl_verify_mbedtls.h"
 #include <mbedtls/debug.h>
 #include <mbedtls/error.h>
-- 
2.11.0


