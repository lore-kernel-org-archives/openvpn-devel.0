From: Gert Doering <gert@...1296...>
Date: Mon,  3 Nov 2025 15:58:37 +0100
Message-ID: <20251103145842.22969-1-gert@...1296...>
In-Reply-To: <gerrit.1762179991000.Ie153b3d5bf19200f225cd09131de8583645110be@...2715...>
References: <gerrit.1762179991000.Ie153b3d5bf19200f225cd09131de8583645110be@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] test_networking: use appropriate assert
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

Inall unit tests we rely on CMocka's provided assert
helpers.
However, test_networking.c was still on the default
assert() call, which we try to avoid in favour of more
appropriate helpers.

Substitute them all with assert_*() from CMocka.

Change-Id: Ie153b3d5bf19200f225cd09131de8583645110be
Reported-by: Marc Heuse <marc@...2953...>
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1342
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1342
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 6a2d09f..1c9cac1 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -2,7 +2,8 @@
 #include "syshead.h"
 #include "networking.h"
 
-#include <assert.h>
+#include <setjmp.h>
+#include <cmocka.h>
 
 static char *iface = "ovpn-dummy0";
 
@@ -27,7 +28,7 @@
     int ret = net_iface_type(NULL, name, ret_type);
     if (ret == 0)
     {
-        assert(strcmp(type, ret_type) == 0);
+        assert_string_equal(type, ret_type);
     }
 
     return ret;
@@ -265,10 +266,10 @@
 
         /* following tests are standalone and do not print any CMD= */
         case 8:
-            assert(net__iface_new("dummy0815", "dummy") == 0);
-            assert(net__iface_type("dummy0815", "dummy") == 0);
-            assert(net__iface_del("dummy0815") == 0);
-            assert(net__iface_type("dummy0815", NULL) == -ENODEV);
+            assert_int_equal(net__iface_new("dummy0815", "dummy"), 0);
+            assert_int_equal(net__iface_type("dummy0815", "dummy"), 0);
+            assert_int_equal(net__iface_del("dummy0815"), 0);
+            assert_int_equal(net__iface_type("dummy0815", NULL), -ENODEV);
             return 0;
 
         default:

