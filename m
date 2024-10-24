From: Gert Doering <gert@...1296...>
Date: Thu, 24 Oct 2024 15:32:17 +0200
Message-ID: <20241024133220.4864-1-gert@...1296...>
In-Reply-To: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
References: <gerrit.1728021778000.I49f1e7d25edb62bf202ffceb45dedc213f2eafdd@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] t_server_null: persist test log files
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

From: Samuli Seppänen <samuli.seppanen@...277...>

The goal is to help debug issues with t_server_null. The immediate goal
is to be able to debug server startup issues encountered on some of the
*BSD platforms.

Change-Id: I49f1e7d25edb62bf202ffceb45dedc213f2eafdd
Signed-off-by: Samuli Seppänen <samuli.seppanen@...277...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/776
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/t_server_null.sh b/tests/t_server_null.sh
index 7627edf..61a9cdc 100755
--- a/tests/t_server_null.sh
+++ b/tests/t_server_null.sh
@@ -56,11 +56,16 @@
 fi
 
 srcdir="${srcdir:-.}"
+export t_server_null_logdir=t_server_null-`hostname`-`date +%Y%m%d-%H%M%S`
+
+# Create directory for server and client logs
+mkdir $t_server_null_logdir
 
 "${srcdir}/t_server_null_server.sh" &
 "${srcdir}/t_server_null_client.sh"
 retval=$?
 
+
 # When running make jobs in parallel ("make -j<x> check") we need to ensure
 # that this script does not exit before all --dev null servers are dead and
 # their network interfaces are gone. Otherwise t_client.sh will fail because
diff --git a/tests/t_server_null_client.sh b/tests/t_server_null_client.sh
index c1a25df..846f790 100755
--- a/tests/t_server_null_client.sh
+++ b/tests/t_server_null_client.sh
@@ -14,7 +14,7 @@
         $client_conf \
         --writepid "${pid}" \
         --setenv pid $pid \
-        --log "${log}" &
+        --log "${t_server_null_logdir}/${log}" &
 }
 
 wait_for_results() {
@@ -44,7 +44,7 @@
     should_pass=$2
     log="${test_name}.log"
 
-    grep "Initialization Sequence Completed" "${log}" > /dev/null
+    grep "Initialization Sequence Completed" "${t_server_null_logdir}/${log}" > /dev/null
     exit_code=$?
 
     if [ $exit_code -eq 0 ] && [ "${should_pass}" = "yes" ]; then
diff --git a/tests/t_server_null_server.sh b/tests/t_server_null_server.sh
index 10bb44b..f8ba3a3 100755
--- a/tests/t_server_null_server.sh
+++ b/tests/t_server_null_server.sh
@@ -4,12 +4,11 @@
     server_name=$1
     server_exec=$2
     server_conf=$3
-    log="${server_name}.log"
+    log="${t_server_null_logdir}/${server_name}.log"
     status="${server_name}.status"
     pid="${server_name}.pid"
 
     if [ -z "${RUN_SUDO}" ]; then
-        rm -f "${status}" "${log}" "${pid}"
         "${server_exec}" \
          $server_conf \
          --status "${status}" 1 \
@@ -17,7 +16,6 @@
          --writepid "${pid}" \
          --explicit-exit-notify 3
     else
-        $RUN_SUDO rm -f "${status}" "${log}" "${pid}"
         $RUN_SUDO "${server_exec}" \
                    $server_conf \
                    --status "${status}" 1 \

