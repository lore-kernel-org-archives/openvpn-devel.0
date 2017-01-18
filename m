From: selva.nair@...277...
Date: Wed, 18 Jan 2017 15:42:52 -0500
Message-Id: <1484772172-19758-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Add a check for -Wl,
	--wrap support in linker
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

From: Selva Nair <selva.nair@...277...>

- Also make tests that require --wrap option to be
  conditional on this support

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 configure.ac                         | 26 ++++++++++++++++++++++++++
 tests/unit_tests/openvpn/Makefile.am |  6 +++++-
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 43487b0..0b7fea9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -582,6 +582,31 @@ AC_COMPILE_IFELSE(
 	[AC_MSG_RESULT([no])]
 )
 
+saved_LDFLAGS="$LDFLAGS"
+LDFLAGS="$LDFLAGS -Wl,--wrap=exit"
+AC_MSG_CHECKING([linker supports --wrap])
+AC_LINK_IFELSE(
+	[AC_LANG_PROGRAM(
+		[[
+			void exit(int);
+			void __real_exit(int);
+			void __wrap_exit(int i) {
+				__real_exit(i);
+			}
+		]],
+		[[
+			exit(0);
+		]]
+	)],
+	[
+		AC_MSG_RESULT([yes])
+		have_ld_wrap_support=yes
+		AC_DEFINE([HAVE_LD_WRAP_SUPPORT], [1], [Define to 1 if linker supports -Wl,--wrap option])
+	],
+	[AC_MSG_RESULT([no])],
+)
+LDFLAGS="$saved_LDFLAGS"
+
 dnl We emulate signals in Windows
 AC_CHECK_DECLS(
 	[SIGHUP],
@@ -1244,6 +1269,7 @@ AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
 AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])
+AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" = "yes"])
 
 plugindir="${with_plugindir}"
 sampledir="\$(docdir)/sample"
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am
index fafe6b2..b902b20 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -1,6 +1,10 @@
 AUTOMAKE_OPTIONS = foreign
 
-check_PROGRAMS = argv_testdriver buffer_testdriver
+check_PROGRAMS=
+
+if HAVE_LD_WRAP_SUPPORT
+check_PROGRAMS += argv_testdriver buffer_testdriver
+endif
 
 if ENABLE_CRYPTO
 check_PROGRAMS += tls_crypt_testdriver
-- 
2.1.4


