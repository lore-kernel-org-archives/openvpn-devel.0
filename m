From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:07 +0200
Message-Id: <20210512131511.1309914-6-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/9] Add ifdef guards to unit test
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

the unit tests do not compile under windows since they are missing
the correct ifdef guards

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 tests/unit_tests/openvpn/test_argv.c       | 2 ++
 tests/unit_tests/openvpn/test_auth_token.c | 2 ++
 tests/unit_tests/openvpn/test_crypto.c     | 4 ++++
 tests/unit_tests/openvpn/test_misc.c       | 2 ++
 tests/unit_tests/openvpn/test_ncp.c        | 2 ++
 tests/unit_tests/openvpn/test_tls_crypt.c  | 2 ++
 6 files changed, 14 insertions(+)

diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 3dc470a52..6ab9be53c 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -2,7 +2,9 @@
 #include "syshead.h"
 
 #include <stdio.h>
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
+#endif
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index dbde86318..b0fbd6dec 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -30,7 +30,9 @@
 #include "syshead.h"
 
 #include <stdio.h>
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
+#endif
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index af83da689..edbee2c95 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -30,7 +30,11 @@
 #include "syshead.h"
 
 #include <stdio.h>
+
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
+#endif
+
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index c3bea8fc8..f09ad4ba0 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -30,7 +30,9 @@
 #include "syshead.h"
 
 #include <stdio.h>
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
+#endif
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 4077be5e8..5a886ca26 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -30,7 +30,9 @@
 #include "syshead.h"
 
 #include <stdio.h>
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
+#endif
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 218772e8b..15788aa2f 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -30,7 +30,9 @@
 #include "syshead.h"
 
 #include <stdio.h>
+#ifdef HAVE_UNISTD_H
 #include <unistd.h>
+#endif
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
-- 
2.31.1


