From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:11:38 +0200
Message-Id: <1330546342-17794-9-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 08/52] cleanup: tun.c: fix incorrect option
	in message (ip-win32)
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 tun.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/tun.c b/tun.c
index c92c0d7..81b66fb 100644
--- a/tun.c
+++ b/tun.c
@@ -4492,7 +4492,7 @@ dhcp_masq_addr (const in_addr_t local, const in_addr_t netmask, const int offset
     msg (M_FATAL, "ERROR: There is a clash between the --ifconfig local address and the internal DHCP server address -- both are set to %s -- please use the --ip-win32 dynamic option to choose a different free address from the --ifconfig subnet for the internal DHCP server", print_in_addr_t (dsa, 0, &gc));
 
   if ((local & netmask) != (dsa & netmask))
-    msg (M_FATAL, "ERROR: --tap-win32 dynamic [offset] : offset is outside of --ifconfig subnet");
+    msg (M_FATAL, "ERROR: --ip-win32 dynamic [offset] : offset is outside of --ifconfig subnet");
 
   gc_free (&gc);
   return htonl(dsa);
-- 
1.7.3.4


