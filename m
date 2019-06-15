From: Antonio Quartulli <a@...2181...>
Date: Sun, 16 Jun 2019 01:02:13 +0200
Message-Id: <20190615230213.14888-2-a@...2181...>
In-Reply-To: <20190615230213.14888-1-a@...2181...>
References: <20190615230213.14888-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] t_net.sh: properly perform sudo check
 and print test steps
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

The current script is performing a tes ton the "kill" command, but this
is not useful to the t_net.sh script as it never really executes it.

Rather test that "sudo <unit-test-binary>" really works.

<unit-test-binary> has to be added to the sudoers file if this test
has to be performend unattanded. The path is:
./unit_tests/openvpn/networking_testdriver

On to pof that, print a simple OK for every test that is succesful.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 tests/t_net.sh                             | 12 +++++-------
 tests/unit_tests/openvpn/test_networking.c |  6 ++++++
 2 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 1940ec92..70e8517d 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -125,14 +125,12 @@ else
         echo "      must be set correctly in 't_client.rc'. SKIP." >&2
         exit 77
     else
-        # We have to use sudo. Make sure that we (hopefully) do not have
-        # to ask the users password during the test. This is done to
-        # prevent timing issues, e.g. when the waits for openvpn to start
-	    if $RUN_SUDO $KILL_EXEC -0 $$
+        # check that we can run the unit-test binary with sudo
+	    if $RUN_SUDO $UNIT_TEST test
         then
-	        echo "$0: $RUN_SUDO $KILL_EXEC -0 succeeded, good."
+	        echo "$0: $RUN_SUDO $UNIT_TEST succeeded, good."
         else
-	        echo "$0: $RUN_SUDO $KILL_EXEC -0 failed, cannot go on. SKIP." >&2
+	        echo "$0: $RUN_SUDO $UNIT_TEST failed, cannot go on. SKIP." >&2
 	        exit 77
         fi
     fi
@@ -172,7 +170,7 @@ for i in $(seq 0 $MAX_TEST); do
             exit 1
         fi
     done
-
+    echo "Test $i: OK"
 done
 
 # remove interface for good
diff --git a/tests/unit_tests/openvpn/test_networking.c b/tests/unit_tests/openvpn/test_networking.c
index 66035011..6c50da92 100644
--- a/tests/unit_tests/openvpn/test_networking.c
+++ b/tests/unit_tests/openvpn/test_networking.c
@@ -185,6 +185,12 @@ main(int argc, char *argv[])
         return -1;
     }
 
+    /* the t_net script can use this command to perform a dry-run test */
+    if (strcmp(argv[1], "test") == 0)
+    {
+        return 0;
+    }
+
     if (argc > 3)
     {
         iface = argv[2];
-- 
2.22.0


