From: Antonio Quartulli <a@...2181...>
Date: Thu, 16 Apr 2020 15:49:25 +0200
Message-Id: <20200416134925.8848-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_net.sh: use dummy interface instead of tun
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

The tun interface has proved to be a bit fragile for basic netlink tests
as it may introduce delays in switching state, depending on the system
the test is ran on.

For this reason, switch to dummy interface type and at the same type
set its oper-state to up right after creation to avoid hitting the
no-carrier state later. No-carrier has been problematic in pasts tests
as it sometimes persists long enough to create a discrepancy between the
various tests snapshots thus causing a test failure.

Setting a static MAC addressis also re-enabled to avoid it being
different and thus causing a test failure when comparing snapshots.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 tests/t_net.sh | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 49790f0f..8f1bc361 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -32,21 +32,16 @@ LAST_STATE=$((${#GET_STATE[@]} - 1))
 
 reload_dummy()
 {
-    $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
-    $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --mktun >/dev/null
+    $RUN_SUDO ip link del $IFACE
+    $RUN_SUDO ip link add $IFACE type dummy
+    $RUN_SUDO ip link set dev $IFACE state up
 
     if [ $? -ne 0 ]; then
         echo "can't create interface $IFACE"
         exit 1
     fi
 
-    # it seems that tun devices will settle on NO-CARRIER while not connected to
-    # any process, but this won't happen immediately. To avoid having the
-    # NO-CARRIER bit appear in the middle of the tests - which would compromise
-    # the results - let's wait 1 sec here for it to settle.
-    sleep 1
-
-    #ip link set dev $IFACE address 00:11:22:33:44:55
+    $RUN_SUDO ip link set dev $IFACE address 00:11:22:33:44:55
 }
 
 run_test()
-- 
2.26.1


