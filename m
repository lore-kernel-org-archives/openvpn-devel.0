From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  8 Dec 2023 18:35:29 +0100
Message-Id: <20231208173529.95023-1-frank@...2641...>
In-Reply-To: <gerrit.1701876289000.I5e394bb73702d87562ed354100eaff9b41f5389e@...2715...>
References: <gerrit.1701876289000.I5e394bb73702d87562ed354100eaff9b41f5389e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] unit_tests: remove includes for
 mock_msg.h
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Not actually used.

Change-Id: I5e394bb73702d87562ed354100eaff9b41f5389e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master and release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/467
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/tests/unit_tests/openvpn/test_auth_token.c b/tests/unit_tests/openvpn/test_auth_token.c
index d96984f..a027330 100644
--- a/tests/unit_tests/openvpn/test_auth_token.c
+++ b/tests/unit_tests/openvpn/test_auth_token.c
@@ -36,8 +36,6 @@
 
 #include "auth_token.c"
 
-#include "mock_msg.h"
-
 struct test_context {
     struct tls_multi multi;
     struct key_type kt;
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 5564524..9e5469a 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -38,7 +38,6 @@
 #include "options.h"
 #include "ssl_backend.h"
 
-#include "mock_msg.h"
 #include "mss.h"
 
 static const char testtext[] = "Dummy text to test PEM encoding";
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index 90c67ac..2a2a973 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -36,8 +36,6 @@
 #include "packet_id.h"
 #include "reliable.h"
 
-#include "mock_msg.h"
-
 struct test_packet_id_write_data {
     struct {
         uint32_t buf_id;
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index 9f49ee7..7f05184 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -40,7 +40,6 @@
 #include "ssl_pkt.h"
 #include "tls_crypt.h"
 
-#include "mock_msg.h"
 #include "mss.h"
 #include "reliable.h"
 
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index ed7c794..465543a 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -36,8 +36,6 @@
 
 #include "tls_crypt.c"
 
-#include "mock_msg.h"
-
 /* Define this function here as dummy since including the ssl_*.c files
  * leads to having to include even more unrelated code */
 bool

