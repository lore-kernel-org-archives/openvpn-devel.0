From: openvpn-devel@...2127...
Date: Sat, 21 May 2016 11:22:05 +0200
Message-Id: <1463822525-2532-3-git-send-email-openvpn-devel@...2127...>
In-Reply-To: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
References: <1463822525-2532-1-git-send-email-openvpn-devel@...2127...>
Subject: [Openvpn-devel] [PATCH 2/2] Add table output formatting to
	t_client.sh
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

From: Jens Neuhalfen <jens@...2127...>

Test results will be printed in a tabular format, e.g.

| ID | TEST                                | RESULT               |
| -- | ----------------------------------- | -------------------- |
|  1 | testing tun/udp/ipv4                | [SUCCESS]            |
|  2 | testing tun/udp/ipv4 with pam       | [FAIL: 5 fails]      |
| -- | ----------------------------------- | -------------------- |
Test sets succeded: 1.
Test sets failed: 2.

Signed-off-by: Jens Neuhalfen <jens@...2127...>
---
 tests/t_client.sh.in | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 9f0c8f6..e026dee 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -361,18 +361,26 @@ print_test_results(){
     # see here for an explanation on the calling convention:
     #   http://stackoverflow.com/questions/1063347/passing-arrays-as-parameters-in-bash
     local -a test_ids=("${!1}")
-    local -a test_number_of_fails=("${!2}")
+    local -a test_names=("${!2}")
+    local -a test_number_of_fails=("${!3}")
 
     local summary_ok=""
     local summary_fail=""
 
-    for (( i = 0 ; i < ${#test_ids[@]} ; i++ )) do
-        if [ ${test_number_of_fails[$i]} == 0 ]; then
+    local fmt="| %2s | %-35s | %-20s |\n"
+
+    printf "$fmt" "ID" "TEST" "RESULT"
+    printf "$fmt" "--" "-----------------------------------" "--------------------"
+    for (( i = 0 ; i < ${#test_names[@]} ; i++ )) do
+        if [ ${test_number_of_fails[$i]} = 0 ]; then
             summary_ok="$summary_ok ${test_ids[$i]}"
+            printf "$fmt" "${test_ids[$i]}" "${test_names[$i]}" "[OK]"
         else
             summary_fail="$summary_fail ${test_ids[$i]}"
+            printf "$fmt" "${test_ids[$i]}" "${test_names[$i]}" "[FAIL: ${test_number_of_fails[$i]} fails]"
         fi
     done
+    printf "$fmt" "--" "-----------------------------------" "--------------------"
 
     if [ -z "$summary_ok" ] ; then summary_ok=" none"; fi
     if [ -z "$summary_fail" ] ; then summary_fail=" none"; fi
@@ -389,6 +397,7 @@ run_test_loop() {
     local -i any_test_failed=0
     local -i number_of_fails_in_test=0
     local -a test_ids
+    local -a test_names
     local -a test_number_of_fails
     local -i current_test_index=0
 
@@ -405,6 +414,7 @@ run_test_loop() {
         eval ping6_hosts=\"\$PING6_HOSTS_$SUF\"
 
         test_ids[$current_test_index]="$SUF"
+        test_names[$current_test_index]="$test_run_title"
 
         run_test "$test_prep" "$test_cleanup" "$test_run_title" "$openvpn_conf" "$expect_ifconfig4" "$expect_ifconfig6" "$ping4_hosts" "$ping6_hosts"
         number_of_fails_in_test=$?
@@ -416,7 +426,7 @@ run_test_loop() {
         current_test_index=$((current_test_index + 1))
     done
 
-    print_test_results test_ids[@] test_results[@]
+    print_test_results test_ids[@] test_names[@] test_results[@]
 
     return $any_test_failed
 }
-- 
2.8.2


