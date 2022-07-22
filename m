From: Frank Lichtenheld <frank@...2641...>
Date: Fri, 22 Jul 2022 15:49:02 +0200
Message-Id: <20220722134902.22092-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_client: Allow to force FAIL on
 prerequisite fails
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

In automated tests we want the build to fail if the
worker node is configured incorrectly.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 tests/t_client.sh.in | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 294546be..465c3a33 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -12,6 +12,10 @@
 # - for "ping6" checks: fping6 binary in $PATH
 #
 
+# by changing this to 1 we can force automated builds to fail
+# that are expected to have all the prerequisites
+TCLIENT_SKIP_RC="${TCLIENT_SKIP_RC:-77}"
+
 srcdir="${srcdir:-.}"
 top_builddir="${top_builddir:-..}"
 if [ -r "${top_builddir}"/t_client.rc ] ; then
@@ -21,25 +25,25 @@ elif [ -r "${srcdir}"/t_client.rc ] ; then
 else
     echo "$0: cannot find 't_client.rc' in build dir ('${top_builddir}')" >&2
     echo "$0: or source directory ('${srcdir}'). SKIPPING TEST." >&2
-    exit 77
+    exit "${TCLIENT_SKIP_RC}"
 fi
 
 # Check for external dependencies
 which fping > /dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping is not available in \$PATH" >&2
-    exit 77
+    exit "${TCLIENT_SKIP_RC}"
 fi
 which fping6 > /dev/null
 if [ $? -ne 0 ]; then
     echo "$0: fping6 is not available in \$PATH" >&2
-    exit 77
+    exit "${TCLIENT_SKIP_RC}"
 fi
 
 KILL_EXEC=`which kill`
 if [ $? -ne 0 ]; then
     echo "$0: kill not found in \$PATH" >&2
-    exit 77
+    exit "${TCLIENT_SKIP_RC}"
 fi
 
 if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
@@ -56,12 +60,12 @@ fi
 
 if [ -z "$CA_CERT" ] ; then
     echo "CA_CERT not defined in 't_client.rc'. SKIP test." >&2
-    exit 77
+    exit "${TCLIENT_SKIP_RC}"
 fi
 
 if [ -z "$TEST_RUN_LIST" ] ; then
     echo "TEST_RUN_LIST empty, no tests defined.  SKIP test." >&2
-    exit 77
+    exit "${TCLIENT_SKIP_RC}"
 fi
 
 # Ensure PREFER_KSU is in a known state
@@ -91,7 +95,7 @@ else
     then
         echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
         echo "      must be set correctly in 't_client.rc'. SKIP." >&2
-        exit 77
+        exit "${TCLIENT_SKIP_RC}"
     else
         # We have to use sudo. Make sure that we (hopefully) do not have
         # to ask the users password during the test. This is done to
@@ -101,7 +105,7 @@ else
 	    echo "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
 	else
 	    echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
-	    exit 77
+	    exit "${TCLIENT_SKIP_RC}"
 	fi
     fi
 fi
-- 
2.34.1


