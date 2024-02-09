From: Juliusz Sosinowicz <juliusz@...2525...>
Date: Fri,  9 Feb 2024 16:47:08 +0100
Message-Id: <20240209154708.109848-1-juliusz@...2525...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] wolfssl: include "ssl.h" by
 "src/openvpn/ssl.h"
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

Including "ssl.h" conflicts with the wolfSSL ssl.h header file. The include/wolfssl directory is included before openvpn/src. include/wolfssl needs to be included so that openvpn can pick up wolfSSL compatibility headers instead of OpenSSL headers without changing the paths.
---
 src/openvpn/auth_token.c                         | 2 +-
 src/openvpn/dco_linux.c                          | 2 +-
 src/openvpn/manage.c                             | 2 +-
 src/openvpn/openvpn.h                            | 2 +-
 src/openvpn/options.c                            | 2 +-
 src/openvpn/ps.h                                 | 2 +-
 src/openvpn/push.c                               | 2 +-
 src/openvpn/ssl.c                                | 2 +-
 src/openvpn/tls_crypt.c                          | 2 +-
 tests/unit_tests/openvpn/mock_ssl_dependencies.c | 2 +-
 tests/unit_tests/openvpn/test_pkcs11.c           | 2 +-
 tests/unit_tests/openvpn/test_ssl.c              | 2 +-
 12 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/auth_token.c b/src/openvpn/auth_token.c
index 6787ea7d..e020bdcb 100644
--- a/src/openvpn/auth_token.c
+++ b/src/openvpn/auth_token.c
@@ -12,7 +12,7 @@
 #include "auth_token.h"
 #include "push.h"
 #include "integer.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "ssl_verify.h"
 #include <inttypes.h>
 
diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 3c91606b..eac81924 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -37,7 +37,7 @@
 
 #include "socket.h"
 #include "tun.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "fdmisc.h"
 #include "multi.h"
 #include "ssl_verify.h"
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 27b6f90e..11c922c5 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -37,7 +37,7 @@
 #include "otime.h"
 #include "integer.h"
 #include "misc.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "common.h"
 #include "manage.h"
 #include "openvpn.h"
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index dabc5be4..3a3d1733 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -28,7 +28,7 @@
 #include "options.h"
 #include "socket.h"
 #include "crypto.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "packet_id.h"
 #include "comp.h"
 #include "tun.h"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1ec..cb06063e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -42,7 +42,7 @@
 #include "run_command.h"
 #include "shaper.h"
 #include "crypto.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "ssl_ncp.h"
 #include "options.h"
 #include "misc.h"
diff --git a/src/openvpn/ps.h b/src/openvpn/ps.h
index 2fe0c4c5..21427480 100644
--- a/src/openvpn/ps.h
+++ b/src/openvpn/ps.h
@@ -28,7 +28,7 @@
 
 #include "basic.h"
 #include "buffer.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 
 typedef void (*post_fork_cleanup_func_t)(void *arg);
 
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 22494340..854bf471 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -29,7 +29,7 @@
 
 #include "push.h"
 #include "options.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
 #include "manage.h"
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c86704..ac077a1c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -54,7 +54,7 @@
 #include "route.h"
 #include "tls_crypt.h"
 
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "ssl_verify.h"
 #include "ssl_backend.h"
 #include "ssl_ncp.h"
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 975d31fa..3df2bc61 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -33,7 +33,7 @@
 #include "platform.h"
 #include "run_command.h"
 #include "session_id.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 
 #include "tls_crypt.h"
 
diff --git a/tests/unit_tests/openvpn/mock_ssl_dependencies.c b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
index 9231d655..da22bbfe 100644
--- a/tests/unit_tests/openvpn/mock_ssl_dependencies.c
+++ b/tests/unit_tests/openvpn/mock_ssl_dependencies.c
@@ -34,7 +34,7 @@
 #include <cmocka.h>
 
 
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "ssl_verify.h"
 
 int
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 81cdf882..76cb80e5 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -33,7 +33,7 @@
 #include "xkey_common.h"
 #include "cert_data.h"
 #include "pkcs11.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 
 #include <setjmp.h>
 #include <cmocka.h>
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 8c1fb5b2..893bf8ec 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -44,7 +44,7 @@
 #include "ssl_verify_backend.h"
 #include "win32.h"
 #include "test_common.h"
-#include "ssl.h"
+#include "src/openvpn/ssl.h"
 #include "buffer.h"
 #include "packet_id.h"
 
-- 
2.34.1


