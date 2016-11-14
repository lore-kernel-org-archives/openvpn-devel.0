From: Steffan Karger <steffan@...1856...>
Date: Mon, 14 Nov 2016 20:43:23 +0100
Message-Id: <1479152603-5103-1-git-send-email-steffan@...1856...>
In-Reply-To: <201611141931.uAEJVoLJ085097@...2054...>
References: <201611141931.uAEJVoLJ085097@...2054...>
Subject: [Openvpn-devel] [PATCH] Make argv unit tests obey {MBEDTLS,
	OPENSSL}_{LIBS, CFLAGS}
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

Fixes builds that use MBEDTLS_CFLAGS and friends to tell the build where
the header files and libraries are.  Also alphabetically orders some of
the listed files in relates Makefile.am files.


Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac                         | 4 ++--
 tests/unit_tests/Makefile.am         | 2 +-
 tests/unit_tests/openvpn/Makefile.am | 6 ++++--
 3 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index a42257a..bd6797c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1270,10 +1270,10 @@ AC_CONFIG_FILES([
 	src/plugins/down-root/Makefile
 	tests/Makefile
         tests/unit_tests/Makefile
-        tests/unit_tests/plugins/Makefile
-        tests/unit_tests/plugins/auth-pam/Makefile
         tests/unit_tests/example_test/Makefile
         tests/unit_tests/openvpn/Makefile
+        tests/unit_tests/plugins/Makefile
+        tests/unit_tests/plugins/auth-pam/Makefile
         vendor/Makefile
 	sample/Makefile
 	doc/Makefile
diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
index 44ab26b..31d37b8 100644
--- a/tests/unit_tests/Makefile.am
+++ b/tests/unit_tests/Makefile.am
@@ -1,5 +1,5 @@
 AUTOMAKE_OPTIONS = foreign
 
 if CMOCKA_INITIALIZED
-SUBDIRS = example_test plugins openvpn
+SUBDIRS = example_test openvpn plugins
 endif
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index af7f12f..b706fae 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,8 +7,10 @@ TESTS = $(check_PROGRAMS)
 openvpn_srcdir = $(top_srcdir)/src/openvpn
 compat_srcdir = $(top_srcdir)/src/compat
 
-argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
-argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
+argv_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir) \
+	$(OPTIONAL_CRYPTO_CFLAGS)
+argv_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line \
+	$(OPTIONAL_CRYPTO_LIBS)
 argv_testdriver_SOURCES = test_argv.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/buffer.c \
-- 
2.7.4


