From: Antonio Quartulli <a@...2181...>
Date: Thu, 19 Sep 2019 09:28:20 +0200
Message-Id: <20190919072820.9913-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_net.sh: wait for NO-CARRIER bit to settle
 before starting test
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

Interfaces of type tun are marked as NO-CARRIER when no process is
attached to them. However, this bit gets set with some delay after
creation.

For this reason, it is better to wait for the bit to settle before
starting any test, otherwise any timing influence on the test may lead
to inconsistencies due to the NO-CARRIER bit randomly being or not in
the snapshot output taken by t_net.sh.

This patch add a 'sleep 1' command right after creation of the
interface, to give the NO-CARRIER bit a chance to settle.

This issue has been witnessed on a buildbot that is
apparently slowler than average to run the unit tests.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 tests/t_net.sh | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index 18799d12..97e947ab 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -34,6 +34,13 @@ reload_dummy()
 {
     $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
     $RUN_SUDO $openvpn --dev $IFACE --dev-type tun --mktun >/dev/null
+
+    # it seems that tun devices will settle on NO-CARRIER while not connected to
+    # any process, but this won't happen immediately. To avoid having the
+    # NO-CARRIER bit appear in the middle of the tests - which would compromise
+    # the results - let's wait 1 sec here for it to settle.
+    sleep 1
+
     if [ $? -ne 0 ]; then
         echo "can't create interface $IFACE"
         exit 1
-- 
2.23.0


