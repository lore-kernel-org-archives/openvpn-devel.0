From: David Sommerseth <davids@...515...>
Date: Fri,  9 Dec 2016 14:45:05 +0100
Message-Id: <1481291105-27739-3-git-send-email-davids@...515...>
In-Reply-To: <1481291105-27739-1-git-send-email-davids@...515...>
References: <1481291105-27739-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 2/2 v3] push: Provide a warning if
	--ifconfig-push have --topology mismatch
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

This adds a warning to the log file if --topology is configured to use
subnet or net30 and the 'subnet mask' argument of an --ifconfig-push option
is not an subnet mask.

v2 - Make use of ifconfig_sanity_check() in tun.c instead of doing the exact
     same check and warning in prepare_push_reply().  Also improve documentation
     of ifconfig_sanity_check() while at it.

v3 - Adopted to the new ifconfig_sanity_check() API

Trac: #755
Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/push.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 9953079..5292b06 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -333,6 +333,14 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
 		       print_in_addr_t (ifconfig_local, 0, gc),
 		       print_in_addr_t (c->c2.push_ifconfig_remote_netmask,
 					0, gc));
+
+      /* Warn if ifconfig_remote_netmask contains an unexpected value
+       * when checking configuration up against TUN/TAP device and
+       * network topology
+       */
+      ifconfig_sanity_check(c->c1.tuntap->type == DEV_TYPE_TUN,
+                            c->c2.push_ifconfig_remote_netmask,
+                            c->options.topology, true);
     }
 
   /* Send peer-id if client supports it */
-- 
1.8.3.1


