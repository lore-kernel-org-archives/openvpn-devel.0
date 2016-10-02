From: Gert Doering <gert@...1296...>
Date: Sun,  2 Oct 2016 15:19:23 +0200
Message-Id: <20161002131923.36681-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] make t_client robust against sudoers
	misconfiguration
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

Instead of testing (and priming) sudo with "true", prime with
"kill -0 $$" (just test signalling ourselves).  If this fails,
we won't be able to kill the openvpn process we're going to
start later on -> thus, SKIP on failure.

This helps with misconfigured setups (especially on the buildbots)
that can correctly start openvpn but then not stop it later on -
leaving openvpn processes dangling around, requiring manual
intervention.

Signed-off-by: Gert Doering <gert@...1296...>
---
 tests/t_client.sh.in | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 2b9bacf..a97e9be 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -42,12 +42,6 @@ if [ $? -ne 0 ]; then
     exit 77
 fi
 
-TRUE_EXEC=`which true`
-if [ $? -ne 0 ]; then
-    echo "$0: true not found in \$PATH" >&2
-    exit 77
-fi
-
 if [ ! -x "${top_builddir}/src/openvpn/openvpn" ]
 then
     echo "no (executable) openvpn binary in current build tree. FAIL." >&2
@@ -102,7 +96,13 @@ else
         # We have to use sudo. Make sure that we (hopefully) do not have
         # to ask the users password during the test. This is done to
         # prevent timing issues, e.g. when the waits for openvpn to start
-        $RUN_SUDO $TRUE_EXEC
+	if $RUN_SUDO $KILL_EXEC -0 $$
+	then
+	    echo "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
+	else
+	    echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
+	    exit 77
+	fi
     fi
 fi
 
-- 
2.9.0


