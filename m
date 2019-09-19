From: Antonio Quartulli <a@...2181...>
Date: Thu, 19 Sep 2019 22:22:57 +0200
Message-Id: <20190919202257.19405-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_net.sh: execute sleep after checking exit
 code of previous command
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
Cc: Antonio Quartulli <a@...2181...>, Steffan Karger <steffan@...1856...>

Ensure to check the exit code of the mktun command *before* running
sleep, otherwise '$?' will resolve to the exit code of sleep itself,
thus nullifying the check.

Reported-by: Steffan Karger <steffan@...1856...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 tests/t_net.sh | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 97e947ab..49790f0f 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -35,17 +35,17 @@ reload_dummy()
     $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
     $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --mktun >/dev/null
 
+    if [ $? -ne 0 ]; then
+        echo "can't create interface $IFACE"
+        exit 1
+    fi
+
     # it seems that tun devices will settle on NO-CARRIER while not connected to
     # any process, but this won't happen immediately. To avoid having the
     # NO-CARRIER bit appear in the middle of the tests - which would compromise
     # the results - let's wait 1 sec here for it to settle.
     sleep 1
 
-    if [ $? -ne 0 ]; then
-        echo "can't create interface $IFACE"
-        exit 1
-    fi
-
     #ip link set dev $IFACE address 00:11:22:33:44:55
 }
 
-- 
2.23.0


