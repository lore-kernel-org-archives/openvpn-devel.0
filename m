From: Antonio Quartulli <a@...2181...>
Date: Tue, 28 Apr 2020 15:17:00 +0200
Message-Id: <20200428131700.9123-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_net.sh: assign MAC address directly
 during interface creation
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---

- tested with buildbot

 tests/t_net.sh | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 8f1bc361..c67c3df2 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -33,15 +33,13 @@ LAST_STATE=$((${#GET_STATE[@]} - 1))
 reload_dummy()
 {
     $RUN_SUDO ip link del $IFACE
-    $RUN_SUDO ip link add $IFACE type dummy
+    $RUN_SUDO ip link add $IFACE address 00:11:22:33:44:55 type dummy
     $RUN_SUDO ip link set dev $IFACE state up
 
     if [ $? -ne 0 ]; then
         echo "can't create interface $IFACE"
         exit 1
     fi
-
-    $RUN_SUDO ip link set dev $IFACE address 00:11:22:33:44:55
 }
 
 run_test()
-- 
2.26.2


