From: selva.nair@...277...
Date: Fri,  3 Feb 2023 19:45:11 -0500
Message-Id: <20230204004512.250271-2-selva.nair@...277...>
In-Reply-To: <20230204004512.250271-1-selva.nair@...277...>
References: <20230204004512.250271-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Build unit tests in mingw Windows build
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

From: Selva Nair <selva.nair@...277...>

- Minor changes to the build system to include some
  dependencies for Windows build

- test_tls_crypt not built as it will pull in win32.c and
  its dependencies

- If cross-compiling, "make check" will only build the tests but not
  run any. Copy to Windows and run manually. Executables are in
  <buid-dir>/tests/unit_tests/openvpn/.libs/ and these depend on
  cmocka.dll in addition to openssl libs that some tests link to.

  Building with mingw on Windows should run the tests (untested).

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac                              |  2 ++
 tests/Makefile.am                         |  2 ++
 tests/unit_tests/example_test/Makefile.am |  2 ++
 tests/unit_tests/openvpn/Makefile.am      | 35 +++++++++++++++++------
 4 files changed, 33 insertions(+), 8 deletions(-)

diff --git a/configure.ac b/configure.ac
index 95d795c3..66ba6f38 100644
--- a/configure.ac
+++ b/configure.ac
@@ -364,6 +364,8 @@ case "$host" in
 		;;
 esac
 
+AM_CONDITIONAL([CROSS_COMPILING], test "${cross_compiling}" = "yes")
+
 PKG_PROG_PKG_CONFIG
 AC_PROG_CPP
 AC_PROG_INSTALL
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 87dd7e17..a46f2573 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,10 +14,12 @@ MAINTAINERCLEANFILES = \
 
 SUBDIRS = unit_tests
 
+if !WIN32
 test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
 if HAVE_SITNL
 test_scripts += t_net.sh
 endif
+endif
 
 TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
 TESTS = $(test_scripts)
diff --git a/tests/unit_tests/example_test/Makefile.am b/tests/unit_tests/example_test/Makefile.am
index 04a5ad35..24eb0ba1 100644
--- a/tests/unit_tests/example_test/Makefile.am
+++ b/tests/unit_tests/example_test/Makefile.am
@@ -2,7 +2,9 @@ AUTOMAKE_OPTIONS = foreign
 
 check_PROGRAMS = example_testdriver example2_testdriver
 
+if !CROSS_COMPILING
 TESTS = $(check_PROGRAMS)
+endif
 
 example_testdriver_CFLAGS  = @TEST_CFLAGS@
 example_testdriver_LDFLAGS = @TEST_LDFLAGS@
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index 7720a85d..909ac4e2 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,20 +7,29 @@ test_binaries += argv_testdriver buffer_testdriver
 endif
 
 test_binaries += crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_testdriver \
-    pkt_testdriver
+pkt_testdriver
 if HAVE_LD_WRAP_SUPPORT
+if !WIN32
 test_binaries += tls_crypt_testdriver
 endif
+endif
 
 test_binaries += provider_testdriver
 
-TESTS = $(test_binaries)
-check_PROGRAMS = $(test_binaries)
+if WIN32
+test_binaries += cryptoapi_testdriver
+LDADD = -lws2_32
+endif
 
 if HAVE_SITNL
-check_PROGRAMS += networking_testdriver
+test_binaries += networking_testdriver
 endif
 
+if !CROSS_COMPILING
+TESTS = $(test_binaries)
+endif
+check_PROGRAMS = $(test_binaries)
+
 openvpn_includedir = $(top_srcdir)/include
 openvpn_srcdir = $(top_srcdir)/src/openvpn
 compat_srcdir = $(top_srcdir)/src/compat
@@ -31,12 +40,14 @@ argv_testdriver_SOURCES = test_argv.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/buffer.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/argv.c
 
 buffer_testdriver_CFLAGS  = @TEST_CFLAGS@ -I$(openvpn_srcdir) -I$(compat_srcdir)
 buffer_testdriver_LDFLAGS = @TEST_LDFLAGS@ -L$(openvpn_srcdir) -Wl,--wrap=parse_line
 buffer_testdriver_SOURCES = test_buffer.c mock_msg.c mock_msg.h \
 	mock_get_random.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/platform.c
 
 crypto_testdriver_CFLAGS  = @TEST_CFLAGS@ \
@@ -51,6 +62,7 @@ crypto_testdriver_SOURCES = test_crypto.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/mtu.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/mss.c
 
 packet_id_testdriver_CFLAGS  = @TEST_CFLAGS@ \
@@ -63,14 +75,14 @@ packet_id_testdriver_SOURCES = test_packet_id.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/reliable.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/session_id.c
 
-
 pkt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
 pkt_testdriver_LDFLAGS = @TEST_LDFLAGS@
 pkt_testdriver_SOURCES = test_pkt.c mock_msg.c mock_msg.h \
-$(openvpn_srcdir)/argv.c \
+	$(openvpn_srcdir)/argv.c \
 	$(openvpn_srcdir)/base64.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/crypto.c \
@@ -84,9 +96,10 @@ $(openvpn_srcdir)/argv.c \
 	$(openvpn_srcdir)/run_command.c \
 	$(openvpn_srcdir)/session_id.c \
 	$(openvpn_srcdir)/ssl_pkt.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/tls_crypt.c
 
-
+if !WIN32
 tls_crypt_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 	-I$(openvpn_includedir) -I$(compat_srcdir) -I$(openvpn_srcdir)
 tls_crypt_testdriver_LDFLAGS = @TEST_LDFLAGS@ \
@@ -106,6 +119,7 @@ tls_crypt_testdriver_SOURCES = test_tls_crypt.c mock_msg.c mock_msg.h \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
 	$(openvpn_srcdir)/run_command.c
+endif
 
 if HAVE_SITNL
 networking_testdriver_CFLAGS = @TEST_CFLAGS@ \
@@ -136,6 +150,7 @@ provider_testdriver_SOURCES = test_provider.c mock_msg.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/base64.c \
 	mock_get_random.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/platform.c
 
 auth_token_testdriver_CFLAGS  = @TEST_CFLAGS@ \
@@ -152,6 +167,7 @@ auth_token_testdriver_SOURCES = test_auth_token.c mock_msg.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/base64.c
 
 
@@ -169,6 +185,8 @@ ncp_testdriver_SOURCES = test_ncp.c mock_msg.c \
 	$(openvpn_srcdir)/otime.c \
 	$(openvpn_srcdir)/packet_id.c \
 	$(openvpn_srcdir)/platform.c \
+	$(openvpn_srcdir)/win32-util.c \
+	$(compat_srcdir)/compat-strsep.c \
 	$(openvpn_srcdir)/ssl_util.c
 
 misc_testdriver_CFLAGS  = @TEST_CFLAGS@ \
@@ -177,8 +195,9 @@ misc_testdriver_CFLAGS  = @TEST_CFLAGS@ \
 misc_testdriver_LDFLAGS = @TEST_LDFLAGS@
 
 misc_testdriver_SOURCES = test_misc.c mock_msg.c \
-    mock_get_random.c \
+	mock_get_random.c \
 	$(openvpn_srcdir)/buffer.c \
 	$(openvpn_srcdir)/options_util.c \
 	$(openvpn_srcdir)/ssl_util.c \
+	$(openvpn_srcdir)/win32-util.c \
 	$(openvpn_srcdir)/platform.c
-- 
2.34.1


