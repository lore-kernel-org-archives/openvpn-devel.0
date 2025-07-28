From: Gert Doering <gert@...1296...>
Date: Mon, 28 Jul 2025 12:42:29 +0200
Message-ID: <20250728104234.29797-1-gert@...1296...>
In-Reply-To: <gerrit.1753697277000.I2ab13767b5aa858e024b45be3d161bf6090de763@...2715...>
References: <gerrit.1753697277000.I2ab13767b5aa858e024b45be3d161bf6090de763@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] unit_tests/plugins/auth-pam: fix
 stdint.h related build error on fedora 42
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

add <stdint.h> to test_search_and_replace.c to fix build error on
fedora 42 / arm64 ("error: uintptr_t undeclared")

Change-Id: I2ab13767b5aa858e024b45be3d161bf6090de763
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1118
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
index d40467f..50b241d 100644
--- a/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
+++ b/tests/unit_tests/plugins/auth-pam/test_search_and_replace.c
@@ -2,6 +2,7 @@
 #include <unistd.h>
 #include <stdlib.h>
 #include <stdarg.h>
+#include <stdint.h>
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>

