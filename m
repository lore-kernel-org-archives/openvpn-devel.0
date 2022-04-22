From: Arne Schwabe <arne@...1227...>
Date: Fri, 22 Apr 2022 16:29:52 +0200
Message-Id: <20220422142953.3805364-18-arne@...1227...>
In-Reply-To: <20220422142953.3805364-1-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 27/28] Add unit test for
 reliable_get_num_output_sequenced_available
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

---
 tests/unit_tests/openvpn/Makefile.am       |  5 +-
 tests/unit_tests/openvpn/mock_get_random.c | 10 ++++
 tests/unit_tests/openvpn/test_packet_id.c  | 55 ++++++++++++++++++++++
 3 files changed, 69 insertions(+), 1 deletion(-)

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 63b53a6ac..832cc592f 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -61,7 +61,10 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
-	$(openvpn_srcdir)/platform.c
+	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/reliable.c \
+    $(openvpn_srcdir)/session_id.c
+
 
 pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
diff --git a/tests/unit_tests/openvpn/mock_get_random.c b/tests/unit_tests/openvpn/mock_get_random.c
index d0d2574ae..90cb2553d 100644
--- a/tests/unit_tests/openvpn/mock_get_random.c
+++ b/tests/unit_tests/openvpn/mock_get_random.c
@@ -26,6 +26,7 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <setjmp.h>
+#include <stdint.h>
 #include <cmocka.h>
 
 unsigned long
@@ -34,3 +35,12 @@ get_random(void)
     /* rand() is not very random, but it's C99 and this is just for testing */
     return rand();
 }
+
+void
+prng_bytes(uint8_t *output, int len)
+{
+    for (int i = 0; i < len; i++)
+    {
+        output[i] = rand();
+    }
+}
\ No newline at end of file
diff --git a/tests/unit_tests/openvpn/test_packet_id.c b/tests/unit_tests/openvpn/test_packet_id.c
index a3d4db285..96d3e870d 100644
--- a/tests/unit_tests/openvpn/test_packet_id.c
+++ b/tests/unit_tests/openvpn/test_packet_id.c
@@ -36,6 +36,7 @@
 #include <cmocka.h>
 
 #include "packet_id.h"
+#include "reliable.h"
 
 #include "mock_msg.h"
 
@@ -156,6 +157,59 @@ test_packet_id_write_long_wrap(void **state)
     assert_true(data->test_buf_data.buf_time == htonl(now));
 }
 
+static void
+test_get_num_output_sequenced_available(void **state)
+{
+
+    struct reliable *rel = malloc(sizeof(struct reliable));
+    reliable_init(rel, 100, 50, 8, false);
+
+    rel->array[5].active = true;
+    rel->array[5].packet_id = 100;
+
+    rel->packet_id = 103;
+
+    assert_int_equal(5, reliable_get_num_output_sequenced_available(rel));
+
+    rel->array[6].active = true;
+    rel->array[6].packet_id = 97;
+    assert_int_equal(2, reliable_get_num_output_sequenced_available(rel));
+
+    /* test ids close to int/usigned int barrier */
+
+    rel->array[5].active = true;
+    rel->array[5].packet_id = (0x80000000u -3);
+    rel->array[6].active = false;
+    rel->packet_id = (0x80000000u -1);
+
+    assert_int_equal(6, reliable_get_num_output_sequenced_available(rel));
+
+    rel->array[5].active = true;
+    rel->array[5].packet_id = (0x80000000u -3);
+    rel->packet_id = 0x80000001u;
+
+    assert_int_equal(4, reliable_get_num_output_sequenced_available(rel));
+
+
+    /* test wrapping */
+    rel->array[5].active = true;
+    rel->array[5].packet_id = (0xffffffffu -3);
+    rel->array[6].active = false;
+    rel->packet_id = (0xffffffffu - 1);
+
+    assert_int_equal(6, reliable_get_num_output_sequenced_available(rel));
+
+    rel->array[2].packet_id = 0;
+    rel->array[2].active = true;
+
+    assert_int_equal(6, reliable_get_num_output_sequenced_available(rel));
+
+    rel->packet_id = 3;
+    assert_int_equal(1, reliable_get_num_output_sequenced_available(rel));
+
+    reliable_free(rel);
+}
+
 int
 main(void)
 {
@@ -178,6 +232,7 @@ main(void)
         cmocka_unit_test_setup_teardown(test_packet_id_write_long_wrap,
                                         test_packet_id_write_setup,
                                         test_packet_id_write_teardown),
+        cmocka_unit_test(test_get_num_output_sequenced_available)
     };
 
     return cmocka_run_group_tests_name("packet_id tests", tests, NULL, NULL);
-- 
2.32.0 (Apple Git-132)


