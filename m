From: Ilya Shipitsin <chipitsine@...277...>
Date: Sat, 17 Sep 2016 14:33:09 +0500
Message-Id: <1474104789-31735-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] skip t_lpback.sh and t_cltsrv.sh if openvpn
	configured --disable-crypto
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

---
 configure.ac      | 1 +
 tests/Makefile.am | 5 ++++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index d733023..dc95123 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1192,6 +1192,7 @@ AM_CONDITIONAL([WIN32], [test "${WIN32}" = "yes"])
 AM_CONDITIONAL([GIT_CHECKOUT], [test "${GIT_CHECKOUT}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_AUTH_PAM], [test "${enable_plugin_auth_pam}" = "yes"])
 AM_CONDITIONAL([ENABLE_PLUGIN_DOWN_ROOT], [test "${enable_plugin_down_root}" = "yes"])
+AM_CONDITIONAL([ENABLE_CRYPTO], [test "${enable_crypto}" = "yes"])
 
 plugindir="${with_plugindir}"
 sampledir="\$(docdir)/sample"
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 2cba9e6..235cd13 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,7 +14,10 @@ MAINTAINERCLEANFILES = \
 
 SUBDIRS = unit_tests
 
-test_scripts = t_client.sh t_lpback.sh t_cltsrv.sh
+test_scripts = t_client.sh
+if ENABLE_CRYPTO
+test_scripts += t_lpback.sh t_cltsrv.sh
+endif
 
 TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
 TESTS = $(test_scripts)
-- 
2.5.5


