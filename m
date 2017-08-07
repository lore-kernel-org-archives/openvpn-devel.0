From: Ilya Shipitsin <chipitsine@...277...>
Date: Mon,  7 Aug 2017 18:23:01 +0500
Message-Id: <20170807132301.22759-3-chipitsine@...277...>
In-Reply-To: <20170807132301.22759-1-chipitsine@...277...>
References: <20170807132301.22759-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH 3/3] add a test to "openvpn --help"
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

inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13808.html
---
 tests/Makefile.am |  2 +-
 tests/t_usage.sh  | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 1 deletion(-)
 create mode 100755 tests/t_usage.sh

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 0795680c..7306d1d1 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,7 +14,7 @@ MAINTAINERCLEANFILES = \
 
 SUBDIRS = unit_tests
 
-test_scripts = t_client.sh
+test_scripts = t_client.sh t_usage.sh
 if ENABLE_CRYPTO
 test_scripts += t_lpback.sh t_cltsrv.sh
 endif
diff --git a/tests/t_usage.sh b/tests/t_usage.sh
new file mode 100755
index 00000000..f4845468
--- /dev/null
+++ b/tests/t_usage.sh
@@ -0,0 +1,29 @@
+#!/bin/sh
+#
+# run "openvpn --help"
+# - check that openvpn did not crash
+#
+# prerequisites:
+# - openvpn binary in current directory
+#
+# inspired by https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13808.html
+#
+
+top_builddir="${top_builddir:-..}"
+
+if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
+then
+    echo "no (executable) openvpn binary in current build tree. FAIL." >&2
+    exit 1
+fi
+
+exit_code=0
+
+"${top_builddir}/src/openvpn/openvpn" --help >/dev/null
+
+if [ $? -ne 1 ]
+then
+   exit_code=1
+fi
+
+exit $exit_code
-- 
2.13.3


