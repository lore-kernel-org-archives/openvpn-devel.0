From: David Sommerseth <davids@...515...>
Date: Wed, 30 Nov 2016 23:41:27 +0100
Message-Id: <1480545687-19365-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] push: Provide a warning if --ifconfig-push
	have argument mismatch with --topology
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
is not an subnet mask.  The check done is to ensure the first octet is 0xff (255)

Trac: #755
Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/push.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 9953079..0819bf8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -333,6 +333,16 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
 		       print_in_addr_t (ifconfig_local, 0, gc),
 		       print_in_addr_t (c->c2.push_ifconfig_remote_netmask,
 					0, gc));
+
+      /* Warn if ifconfig_remote_netmask does not contain
+       * subnet mask in subnet topology */
+      if ((c->options.topology == TOP_SUBNET || c->options.topology == TOP_NET30)
+          && (c->c2.push_ifconfig_remote_netmask & 0xff000000) != 0xff000000)
+        {
+          msg(M_WARN, "WARNING: When --topology is subnet or net30, the second argument "
+              "to --ifconfig-push MUST be a subnet mask.  This client will not be able "
+              "to connect.");
+        }
     }
 
   /* Send peer-id if client supports it */
-- 
1.8.3.1


