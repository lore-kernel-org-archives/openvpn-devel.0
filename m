From: Frank Lichtenheld <frank@...2641...>
Date: Sun,  7 Nov 2021 18:40:00 +0100
Message-Id: <20211107174000.16210-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix error in example firewall.sh script
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
Cc: Adrian <adrian.crespo@...2282...>, Frank Lichtenheld <frank@...2641...>

From: Adrian <adrian.crespo@...2282...>

The man page says:
[!] -s, --source address[/mask][,...]

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 sample/sample-config-files/firewall.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

As part of an initative to clean up the Github PR submissions, submitting
this patch to the mailing list for inclusion. Looks obviously correct to
me.

diff --git a/sample/sample-config-files/firewall.sh b/sample/sample-config-files/firewall.sh
index 19d75ee9..456700ca 100755
--- a/sample/sample-config-files/firewall.sh
+++ b/sample/sample-config-files/firewall.sh
@@ -50,7 +50,7 @@ iptables -A OUTPUT -p tcp --sport 137:139 -o eth0 -j DROP
 iptables -A OUTPUT -p udp --sport 137:139 -o eth0 -j DROP
 
 # Check source address validity on packets going out to internet
-iptables -A FORWARD -s ! $PRIVATE -i eth1 -j DROP
+iptables -A FORWARD ! -s $PRIVATE -i eth1 -j DROP
 
 # Allow local loopback
 iptables -A INPUT -s $LOOP -j ACCEPT
-- 
2.30.2


