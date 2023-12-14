From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 14 Dec 2023 12:16:35 +0100
Message-Id: <20231214111635.237429-1-frank@...2641...>
In-Reply-To: <gerrit.1702310034000.Ic7265d89142637b0963a6847c6beb06d9163bbb1@...2715...>
References: <gerrit.1702310034000.Ic7265d89142637b0963a6847c6beb06d9163bbb1@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] tests: disable automake serial_tests
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

Serial mode is the old one and offers much less options for
running the tests. Generally our tests seem to work fine
with the newer parallel mode. The only reason we stuck with
serial_tests seems to be that we didn't like that it doesn't
output the test output by default. We could fix that with a
custom test driver. But will put that into a separate commit.

Change-Id: Ic7265d89142637b0963a6847c6beb06d9163bbb1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/477
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/configure.ac b/configure.ac
index 54f79ab..2823f04 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,20 +41,6 @@
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])
 
-dnl Initialize automake.  automake < 1.12 didn't have serial-tests and
-dnl gives an error if it sees this, but for automake >= 1.13
-dnl serial-tests is required so we have to include it.  Solution is to
-dnl test for the version of automake (by running an external command)
-dnl and provide it if necessary.  Note we have to do this entirely using
-dnl m4 macros since automake queries this macro by running
-dnl 'autoconf --trace ...'.
-m4_define([serial_tests], [
-    m4_esyscmd([automake --version |
-                head -1 |
-                awk '{split ($NF,a,"."); if (a[1] == 1 && a[2] >= 12) { print "serial-tests" }}'
-    ])
-])
-
 dnl Automake 1.14+ warns if sources are in sub-directories but subdir-objects
 dnl options is not enabled. However, automake before 1.15a has a bug that causes
 dnl variable expansion to fail in foo_SOURCES when this option is used.
@@ -69,7 +55,7 @@
 
 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
-AM_INIT_AUTOMAKE(foreign serial_tests subdir_objects 1.9) dnl NB: Do not [quote] this parameter.
+AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this parameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS
 
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 80673d5..6c71067 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,6 +14,8 @@
 
 SUBDIRS = unit_tests
 
+AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) System Tests'
+
 if !WIN32
 test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
 if HAVE_SITNL
diff --git a/tests/unit_tests/example_test/Makefile.am b/tests/unit_tests/example_test/Makefile.am
index 24eb0ba..1ae80c8 100644
--- a/tests/unit_tests/example_test/Makefile.am
+++ b/tests/unit_tests/example_test/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS = foreign
 
+AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) example Unit-Tests'
+
 check_PROGRAMS = example_testdriver example2_testdriver
 
 if !CROSS_COMPILING
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index ef45b11..cecf4dc 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS = foreign
 
+AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) Unit-Tests'
+
 test_binaries=
 
 if HAVE_LD_WRAP_SUPPORT
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/Makefile.am
index de5e96e..ba32013 100644
--- a/tests/unit_tests/plugins/auth-pam/Makefile.am
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS = foreign
 
+AM_TESTSUITE_SUMMARY_HEADER = ' for $(PACKAGE_STRING) auth_pam Plugin Unit-Tests'
+
 if ENABLE_PLUGIN_AUTH_PAM
 check_PROGRAMS = auth_pam_testdriver
 TESTS = $(check_PROGRAMS)

