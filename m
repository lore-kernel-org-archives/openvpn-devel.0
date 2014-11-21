From: samuli@...515...
Date: Fri, 21 Nov 2014 12:09:45 +0200
Message-Id: <1416564585-14546-1-git-send-email-samuli@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix to --shaper documentation on the
	man-page
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

From: Samuli Sepp=C3=A4nen <samuli@...515...>

Trac: #413
Trac-URL: https://community.openvpn.net/openvpn/ticket/413
Signed-off-by: Samuli Sepp=C3=A4nen <samuli@...515...>
---
 doc/openvpn.8 | 1 +
 1 file changed, 1 insertion(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 8fca9aa..96ba555 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1437,6 +1437,7 @@ Currently defaults to 100.
 Limit bandwidth of outgoing tunnel data to
 .B n
 bytes per second on the TCP/UDP port.
+Note that this will only work if mode is set to p2p.
 If you want to limit the bandwidth
 in both directions, use this option on both peers.
=20
--=20
1.9.1


