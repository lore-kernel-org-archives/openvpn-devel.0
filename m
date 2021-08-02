From: Arne Schwabe <arne@...1227...>
Date: Mon,  2 Aug 2021 12:07:40 +0200
Message-Id: <20210802100740.694474-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Remove unistd.h from unit test
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

the unit tests do not compile under Windows since Windows does not
provide a unistd.h header. The header is still included on Unix
platforms via syshead.h

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_argv.c       | 1 -
 tests/unit_tests/openvpn/test_auth_token.c | 1 -
 tests/unit_tests/openvpn/test_crypto.c     | 1 -
 tests/unit_tests/openvpn/test_misc.c       | 1 -
 tests/unit_tests/openvpn/test_ncp.c        | 1 -
 tests/unit_tests/openvpn/test_tls_crypt.c  | 1 -
 6 files changed, 6 deletions(-)

diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 3dc470a52..e686adcb5 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -2,7 +2,6 @@
 #include "syshead.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index 6bfad6efb..5299c3643 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -30,7 +30,6 @@
 #include "syshead.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index f4cc81a04..32063fc46 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -30,7 +30,6 @@
 #include "syshead.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index b7623bea0..70f726d0f 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -30,7 +30,6 @@
 #include "syshead.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 293093f1a..613b5f1ba 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -30,7 +30,6 @@
 #include "syshead.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 3e604d672..12ea9452d 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -30,7 +30,6 @@
 #include "syshead.h"
 
 #include <stdio.h>
-#include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
-- 
2.32.0


