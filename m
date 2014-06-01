From: Steffan Karger <steffan@...1856...>
Date: Sun,  1 Jun 2014 19:58:53 +0200
Message-Id: <1401645536-27849-3-git-send-email-steffan@...1856...>
In-Reply-To: <1401645536-27849-1-git-send-email-steffan@...1856...>
References: <1401645536-27849-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/5] Fix ssl.c, ssl_verify_* includes
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

* ssl.c: remove three unneeded includes
* ssl_verify_polarssl.h: remove two unneeded includes
* ssl_verify_openssl.c: add missing ssl_verify_openssl.h and error.h
  includes, and reorder includes.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c                 | 4 ----
 src/openvpn/ssl_verify_openssl.c  | 6 +++++-
 src/openvpn/ssl_verify_polarssl.h | 2 --
 3 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9bcb2ac..e9e01ad 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -35,7 +35,6 @@
  * Both the TLS session and the data channel are multiplexed
  * over the same TCP/UDP port.
  */
-
 #ifdef HAVE_CONFIG_H
 #include "config.h"
 #elif defined(_MSC_VER)
@@ -48,7 +47,6 @@
 
 #include "error.h"
 #include "common.h"
-#include "integer.h"
 #include "socket.h"
 #include "misc.h"
 #include "fdmisc.h"
@@ -57,8 +55,6 @@
 #include "status.h"
 #include "gremlin.h"
 #include "pkcs11.h"
-#include "list.h"
-#include "base64.h"
 #include "route.h"
 
 #include "ssl.h"
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 98a888a..2482eaa 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -37,9 +37,13 @@
 
 #if defined(ENABLE_SSL) && defined(ENABLE_CRYPTO_OPENSSL)
 
+#include "ssl_verify_openssl.h"
+
+#include "error.h"
+#include "ssl_openssl.h"
 #include "ssl_verify.h"
 #include "ssl_verify_backend.h"
-#include "ssl_openssl.h"
+
 #include <openssl/x509v3.h>
 #include <openssl/err.h>
 
diff --git a/src/openvpn/ssl_verify_polarssl.h b/src/openvpn/ssl_verify_polarssl.h
index b5157ed..2076f2e 100644
--- a/src/openvpn/ssl_verify_polarssl.h
+++ b/src/openvpn/ssl_verify_polarssl.h
@@ -31,8 +31,6 @@
 #define SSL_VERIFY_POLARSSL_H_
 
 #include "syshead.h"
-#include "misc.h"
-#include "manage.h"
 #include <polarssl/x509_crt.h>
 
 #ifndef __OPENVPN_X509_CERT_T_DECLARED
-- 
1.9.1


