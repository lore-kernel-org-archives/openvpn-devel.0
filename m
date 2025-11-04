From: Gert Doering <gert@...1296...>
Date: Tue,  4 Nov 2025 09:16:47 +0100
Message-ID: <20251104081653.3368-1-gert@...1296...>
In-Reply-To: <gerrit.1762213799000.I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866@...2715...>
References: <gerrit.1762213799000.I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] unit_tests: prefer proper cmocka assert
 helpers
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

From: Antonio Quartulli <antonio@...2726...>

We have agreed to never use the plain assert()
anywhere in the code.

Unit tests are almost there as they always use
cmocka provided assert helpers, except for two cases.
Convert those two to cmocka assert calls too.

While at it also ensure that the proper bool helpers
are used rather than checking _int_equal against true/false.

Drop assert.h in cryptoapi.c as well as it's not needed
anymore.

GitHub: Closes OpenVPN/openvpn#894
Change-Id: I61e4968f2e83d12d4d3fc3ccba92a06eb5ed5866
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1345
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1345
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index bba6ed2..b18b9d4 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -45,7 +45,6 @@
 #include <ncrypt.h>
 #include <stdio.h>
 #include <ctype.h>
-#include <assert.h>
 
 #include "buffer.h"
 #include "openssl_compat.h"
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 92c4c65..25a8def 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -463,38 +463,38 @@
     const char test1[] = A_TIMES_256 "EOL\n" A_TIMES_256 "EOF";
 
     /* line buffer bigger than actual line */
-    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
     status = buf_parse(&buf, '\n', line, sizeof(line));
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOL");
     status = buf_parse(&buf, '\n', line, sizeof(line));
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOF");
 
     /* line buffer exactly same size as actual line + terminating \0 */
     buf_reset_len(&buf);
-    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
     status = buf_parse(&buf, '\n', line, 260);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOL");
     status = buf_parse(&buf, '\n', line, 260);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256 "EOF");
 
     /* line buffer smaller than actual line */
     buf_reset_len(&buf);
-    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
     status = buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256);
     status = buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, "EOL");
     status = buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, A_TIMES_256);
     status = buf_parse(&buf, '\n', line, 257);
-    assert_int_equal(status, true);
+    assert_true(status);
     assert_string_equal(line, "EOF");
 
     gc_free(&gc);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 6e83465..2edfba9b 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -121,7 +121,7 @@
         { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", hash4, 0 },
         { 0 }
     };
-    assert(sizeof(certs_local) == sizeof(certs));
+    assert_int_equal(sizeof(certs_local), sizeof(certs));
     memcpy(certs, certs_local, sizeof(certs_local));
 }
 
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 10bed1d..954794e 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -101,7 +101,7 @@
     const char *msg = parse_auth_failed_temp(&o, teststr);
     assert_string_equal(msg, "");
     assert_int_equal(o.server_backoff_time, 42);
-    assert_int_equal(o.no_advance, true);
+    assert_true(o.no_advance);
 }
 
 static void
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
index 01cbf96..81d2280 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -148,7 +148,7 @@
         { cert4, key4, cname4, "OVPN TEST CA2", "OVPN Test Cert 4", { 0 }, NULL },
         { 0 }
     };
-    assert(sizeof(certs_local) == sizeof(certs));
+    assert_int_equal(sizeof(certs_local), sizeof(certs));
     memcpy(certs, certs_local, sizeof(certs_local));
 }
 

