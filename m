From: Antonio Quartulli <a@...2181...>
Date: Thu,  7 Apr 2022 10:15:55 +0200
Message-Id: <20220407081555.25228-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] t_net.sh: delete dummy iface using iproute
 command
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

A dummy interface cannot be deleted using --rmtun because openvpn tries
to send some ioctl (i.e. TUNSETPERSIST) which is not supported by this
device type. This results in the following error:

2022-04-07 09:59:29 Cannot ioctl TUNSETPERSIST(0) ovpn-dummy0: Bad file descriptor (errno=9)
2022-04-07 09:59:29 Exiting due to fatal error

and the interface is not deleted.

Use iproute to generically delete an interface.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 tests/t_net.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tests/t_net.sh b/tests/t_net.sh
index f9dba404..af78152c 100755
--- a/tests/t_net.sh
+++ b/tests/t_net.sh
@@ -166,6 +166,6 @@ for i in $(seq 0 $MAX_TEST); do
 done
 
 # remove interface for good
-$RUN_SUDO $openvpn --dev $IFACE --dev-type tun --rmtun >/dev/null
+$RUN_SUDO ip link del $IFACE
 
 exit 0
-- 
2.35.1


