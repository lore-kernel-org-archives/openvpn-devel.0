From: haixiao.yan.cn@...3018...
Date: Thu, 26 Mar 2026 14:20:16 +0800
Message-Id: <20260326062016.3856597-1-haixiao.yan.cn@...3018...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tests: skip test execution when
 cross-compiling
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

From: Haixiao Yan <haixiao.yan.cn@...3018...>

The auth-pam unit test Makefile.am unconditionally assigns the TESTS variable,
causing test execution to fail during cross-compilation because the target
binaries are not executable on the build host.

Signed-off-by: Haixiao Yan <haixiao.yan.cn@...3018...>
---
 tests/unit_tests/plugins/auth-pam/Makefile.am | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/Makefile.am
index ba32013ac920..7da299ccde92 100644
--- a/tests/unit_tests/plugins/auth-pam/Makefile.am
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
@@ -4,8 +4,10 @@ AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) auth_pam Plugin Unit-Tests
 
 if ENABLE_PLUGIN_AUTH_PAM
 check_PROGRAMS = auth_pam_testdriver
+if !CROSS_COMPILING
 TESTS = $(check_PROGRAMS)
 endif
+endif
 
 auth_pam_testdriver_SOURCES = test_search_and_replace.c  $(top_srcdir)/src/plugins/auth-pam/utils.h $(top_srcdir)/src/plugins/auth-pam/utils.c
 auth_pam_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(top_srcdir)/src/plugins/auth-pam
-- 
2.43.0


