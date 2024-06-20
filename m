From: Gert Doering <gert@...1296...>
Date: Thu, 20 Jun 2024 12:37:48 +0200
Message-ID: <20240620103749.7923-1-gert@...1296...>
In-Reply-To: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
References: <gerrit.1718814483000.I35f7cf84e035bc793d6f0f59e46edf1a2efe0391@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] t_server_null.sh: Fix failure case
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

From: Frank Lichtenheld <frank@...2641...>

The changes for POSIX shell compatibility and parallel
make compatibility broke actually failing the test
when a subtest fails.

Change-Id: I35f7cf84e035bc793d6f0f59e46edf1a2efe0391
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Samuli Seppänen <samuli@...515...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/668
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Samuli Seppänen <samuli@...515...>

        
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index cfca5ee..0e53ba4 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -64,9 +64,12 @@
 fi
 
 "${srcdir}/t_server_null_client.sh"
+retval=$?
 
 # When running make jobs in parallel ("make -j<x> check") we need to ensure
 # that this script does not exit before all --dev null servers are dead and
 # their network interfaces are gone. Otherwise t_client.sh will fail because
 # pre and post ifconfig output does not match.
 wait
+
+exit $retval
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index 5d5542b..8890007 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -130,7 +130,7 @@
     eval test_name=\"\$TEST_NAME_$SUF\"
     eval should_pass=\"\$SHOULD_PASS_$SUF\"
 
-    (get_client_test_result "${test_name}" "${should_pass}")
+    get_client_test_result "${test_name}" "${should_pass}"
 done
 
 exit $retval

