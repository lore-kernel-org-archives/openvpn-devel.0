From: David Sommerseth <davids@...515...>
Date: Sat, 17 Sep 2016 12:44:15 +0300
Message-Id: <1474105455-26414-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] t_client.sh: Add support for Kerberos/ksu
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

If the t_client.rc have PREFER_KSU=1 configured, t_client.sh
will check if you have a valid Kerberos ticket and if so it will
do all execution via ksu instead of sudo.

If PREFER_KSU is not set or a Kerberos ticket is not found, it
will fallback to the configured RUN_SUDO approach.

When using ksu it needs the full path to the program being executed,
so there is also additional code to find the full path of true and kill.

Signed-off-by: David Sommerseth <davids@...515...>
---
 tests/t_client.sh.in | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index fc82cdb..4cd5413 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -36,6 +36,18 @@ if [ $? -ne 0 ]; then
     exit 77
 fi
 
+KILL_EXEC=`which kill`
+if [ $? -ne 0 ]; then
+    echo "$0: kill not found in \$PATH" >&2
+    exit 77
+fi
+
+TRUE_EXEC=`which true`
+if [ $? -ne 0 ]; then
+    echo "$0: true not found in \$PATH" >&2
+    exit 77
+fi
+
 if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
 then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
@@ -58,12 +70,31 @@ if [ -z "$TEST_RUN_LIST" ] ; then
     exit 77
 fi
 
+# Ensure PREFER_KSU is in a known state
+if [ -z "$PREFER_KSU" ]; then
+    PREFER_KSU=0
+fi
+
 # make sure we have permissions to run ifconfig/route from OpenVPN
 # can't use "id -u" here - doesn't work on Solaris
 ID=`id`
 if expr "$ID" : "uid=0" >/dev/null
 then :
 else
+    if [ $PREFER_KSU -eq 1 ];
+    then
+        # Check if we have a valid kerberos ticket
+        klist -l &> /dev/null
+        if [ $? -ne 0 ];
+        then
+            # No kerberos ticket found, skip ksu and fallback to RUN_SUDO
+            PREFER_KSU=0
+            echo "$0: No Kerberos ticket available.  Will not use ksu."
+        else
+            RUN_SUDO="ksu -q -e $*"
+        fi
+    fi
+
     if [ -z "$RUN_SUDO" ]
     then
         echo "$0: this test must run be as root, or RUN_SUDO=... " >&2
@@ -73,7 +104,7 @@ else
         # We have to use sudo. Make sure that we (hopefully) do not have
         # to ask the users password during the test. This is done to
         # prevent timing issues, e.g. when the waits for openvpn to start
-        $RUN_SUDO \true
+        $RUN_SUDO $TRUE_EXEC
     fi
 fi
 
@@ -90,6 +121,7 @@ exit_code=0
 # ----------------------------------------------------------
 # helper functions
 # ----------------------------------------------------------
+
 # print failure message, increase FAIL counter
 fail()
 {
@@ -273,14 +305,14 @@ do
     echo "  OpenVPN running with PID $opid"
 
     # make sure openvpn client is terminated in case shell exits
-    trap "$RUN_SUDO kill $opid" 0
-    trap "$RUN_SUDO kill $opid ; trap - 0 ; exit 1" 1 2 3 15
+    trap "$RUN_SUDO $KILL_EXEC $opid" 0
+    trap "$RUN_SUDO $KILL_EXEC $opid ; trap - 0 ; exit 1" 1 2 3 15
 
     echo "wait for connection to establish..."
     sleep ${SETUP_TIME_WAIT:-10}
 
     # test whether OpenVPN process is still there
-    if $RUN_SUDO kill -0 $opid
+    if $RUN_SUDO $KILL_EXEC -0 $opid
     then :
     else
 	fail "OpenVPN process has failed to start up, check log ($LOGDIR/$SUF:openvpn.log)."
@@ -315,7 +347,7 @@ do
     echo -e "ping tests done.\n"
 
     echo "stopping OpenVPN"
-    $RUN_SUDO kill $opid
+    $RUN_SUDO $KILL_EXEC $opid
     wait $!
     rc=$?
     if [ $rc != 0 ] ; then
-- 
1.8.3.1


