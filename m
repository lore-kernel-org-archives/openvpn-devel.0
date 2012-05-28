From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 28 May 2012 23:57:55 +0300
Message-Id: <1338238675-20048-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <20120527202737.GV1161@...1296...>
References: <20120527202737.GV1161@...1296...>
Subject: [Openvpn-devel] [PATCH] build: t_client re-addition
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Adding integration tests that needs and/or manual intervention to
make check is not something that should be encouraged.

Tiered of arguing.

But if you add this, at least use the following.
---
 tests/Makefile.am    |   11 ++++++-----
 tests/t_client.sh.in |   13 ++++++++-----
 2 files changed, 14 insertions(+), 10 deletions(-)

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6ae845b..f6d9d1b 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -12,13 +12,14 @@
 MAINTAINERCLEANFILES = \
 	$(srcdir)/Makefile.in
 
-test_scripts = t_lpback.sh t_cltsrv.sh
+test_scripts = t_lpback.sh t_cltsrv.sh t_client.sh
 
-TESTS_ENVIRONMENT = top_srcdir="$(top_srcdir)"
+TESTS_ENVIRONMENT = \
+	top_srcdir="$(top_srcdir)" \
+	top_builddir="$(top_builddir)" \
+	builddir="$(builddir)"
 TESTS = $(test_scripts)
 
 dist_noinst_SCRIPTS = \
 	$(test_scripts) \
-	t_cltsrv-down.sh \
-	t_client.sh
-
+	t_cltsrv-down.sh
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 7ba124c..a9337a0 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -13,17 +13,20 @@
 #
 
 srcdir="${srcdir:-.}"
+builddir="${builddir:-${srcdir}}"
 top_builddir="${top_builddir:-..}"
-if [ -r "${srcdir}"/t_client.rc ] ; then
+if [ -r "${builddir}"/t_client.rc ] ; then
+    . "${builddir}"/t_client.rc
+elif [ -r "${srcdir}"/t_client.rc ] ; then
     . "${srcdir}"/t_client.rc
 else
-    echo "$0: cannot find 't_client.rc' in ('${srcdir}'). SKIPPING TEST." >&2
+    echo "$0: cannot find 't_client.rc' in ('${srcdir}', '${builddir}'). SKIPPING TEST." >&2
     exit 77
 fi
 
 if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
 then
-    echo "no (executable) openvpn binary in current directory. FAIL." >&2
+    echo "no (executable) openvpn binary in '${top_builddir}' directory. FAIL." >&2
     exit 1
 fi
 
@@ -83,7 +86,7 @@ fail()
 get_ifconfig_route()
 {
     # linux / iproute2? (-> if configure got a path)
-    if [ "@IPROUTE@" != "ip" ]
+    if [ -n "@IPROUTE@" ]
     then
 	echo "-- linux iproute2 --"
 	@IPROUTE@ addr show     | grep -v valid_lft
@@ -236,7 +239,7 @@ do
     trap "$RUN_SUDO kill $opid ; trap - 0 ; exit 1" 1 2 3 15
 
     echo "wait for connection to establish..."
-    sleep 10
+    sleep ${SETUP_TIME_WAIT:-10}
 
     # test whether OpenVPN process is still there
     if $RUN_SUDO kill -0 $opid
-- 
1.7.3.4


