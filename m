From: selva.nair@...277...
Date: Fri, 30 Dec 2016 21:45:07 -0500
Message-Id: <1483152307-15687-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Always release dhcp address in close_tun()
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

From: Selva Nair <selva.nair@...277...>

Also make sure --dhcp-pre-release results in not just dhcp_release()
in open_tun() but a subsequent dhcp_renew() as well. Else dhcp transaction
gets aborted as this call to release() happens after the adapter status
is changed to connected.

Alternatively, the undocumented --dhcp-pre-release may be removed.

Fixes Trac #807 (but can't say the same for Trac #665 without knowing
how to reproduce it)

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/tun.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f812844..31fcd67 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -6056,6 +6056,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             if (tt->options.dhcp_pre_release)
             {
                 dhcp_release(tt);
+                dhcp_renew(tt);
             }
             if (tt->options.dhcp_renew)
             {
@@ -6224,10 +6225,7 @@ close_tun(struct tuntap *tt)
         }
 #endif
 
-        if (tt->options.dhcp_release)
-        {
-            dhcp_release(tt);
-        }
+        dhcp_release(tt);
 
         if (tt->hand != NULL)
         {
-- 
2.1.4


