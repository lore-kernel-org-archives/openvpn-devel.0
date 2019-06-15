From: Antonio Quartulli <a@...2181...>
Date: Sun, 16 Jun 2019 01:02:12 +0200
Message-Id: <20190615230213.14888-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] t_net.sh: make bash dep explicit and
 run only if SITNL is compiled
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

The t_net script currently has #!/bin/sh but it implicitly assume to
be using bash.
This is fine on most distros, but some do not have sh pointing to bash
by default, thus breaking the script.
Explicitly use bash to avoid failures.

On the other hand, run this unit-test only if SITNL was enabled at
compile time. This test was designed with SITNL in mind and it is
not yet ready for other backends.

Running only when SITNL is enabled implies running on Linux only
therefore we are guaranteed that bash will always work.

While at it, also add a comment as of why the t_client.rc file is
sourced.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 configure.ac                         | 3 +++
 tests/Makefile.am                    | 7 ++++---
 tests/t_net.sh                       | 3 ++-
 tests/unit_tests/openvpn/Makefile.am | 2 +-
 4 files changed, 10 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index 2d78098e..8c95e310 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1226,11 +1226,14 @@ else
 	enable_plugin_down_root="no"
 fi
 
+AM_CONDITIONAL([HAVE_SITNL], [false])
+
 if test "${enable_iproute2}" = "yes"; then
 	test -z "${IPROUTE}" && AC_MSG_ERROR([ip utility is required but missing])
 	AC_DEFINE([ENABLE_IPROUTE], [1], [enable iproute2 support])
 else if test "${have_sitnl}" = "yes"; then
 	AC_DEFINE([ENABLE_SITNL], [1], [enable sitnl support])
+	AM_CONDITIONAL([HAVE_SITNL], [true])
 else if test "${WIN32}" != "yes" -a "${have_sitnl}" != "yes"; then
 	test -z "${ROUTE}" && AC_MSG_ERROR([route utility is required but missing])
 	test -z "${IFCONFIG}" && AC_MSG_ERROR([ifconfig utility is required but missing])
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 67acf7e3..801192ed 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,9 +14,10 @@ MAINTAINERCLEANFILES = \
 
 SUBDIRS = unit_tests
 
-test_scripts = t_net.sh
-test_scripts += t_client.sh
-test_scripts += t_lpback.sh t_cltsrv.sh
+test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
+if HAVE_SITNL
+test_scripts += t_net.sh
+endif
 
 TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
 TESTS = $(test_scripts)
diff --git a/tests/t_net.sh b/tests/t_net.sh
index 0be5bb42..1940ec92 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -1,4 +1,4 @@
-#!/bin/sh
+#!/usr/bin/env bash
 
 IFACE="dummy0"
 UNIT_TEST="./unit_tests/openvpn/networking_testdriver"
@@ -74,6 +74,7 @@ run_test()
 
 ## execution starts here
 
+# t_client.rc required only for RUN_SUDO definition
 if [ -r "${top_builddir}"/t_client.rc ]; then
     . "${top_builddir}"/t_client.rc
 elif [ -r "${srcdir}"/t_client.rc ]; then
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index c6da91a8..e61c57c4 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -14,7 +14,7 @@ endif
 TESTS = $(test_binaries)
 check_PROGRAMS = $(test_binaries)
 
-if TARGET_LINUX
+if HAVE_SITNL
 check_PROGRAMS += networking_testdriver
 endif
 
-- 
2.22.0


