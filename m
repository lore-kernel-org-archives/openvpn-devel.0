From: David Sommerseth <davids@...515...>
Date: Fri,  9 Dec 2016 03:50:48 +0100
Message-Id: <1481251848-28460-1-git-send-email-davids@...515...>
In-Reply-To: <1480545687-19365-1-git-send-email-davids@...515...>
References: <1480545687-19365-1-git-send-email-davids@...515...>
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
is not an subnet mask.

v2 - Make use of ifconfig_sanity_check() in tun.c instead of doing the exact
     same check and warning in prepare_push_reply().  Also improve documentation
     of ifconfig_sanity_check() while at it.

Trac: #755
Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/push.c |  8 ++++++++
 src/openvpn/tun.c  | 20 ++++++++++++++------
 src/openvpn/tun.h  |  2 ++
 3 files changed, 24 insertions(+), 6 deletions(-)

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
+                            c->options.topology);
     }
 
   /* Send peer-id if client supports it */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 572e168..8df3489 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -285,14 +285,22 @@ guess_tuntap_dev (const char *dev,
 /* --ifconfig-nowarn disables some options sanity checking */
 static const char ifconfig_warn_how_to_silence[] = "(silence this warning with --ifconfig-nowarn)";
 
-/*
- * If !tun, make sure ifconfig_remote_netmask looks
- *  like a netmask.
+/**
+ * If not a tun device, make sure ifconfig_remote_netmask looks
+ * like a netmask.
+ *
+ * If a tun device, make sure ifconfig_remote_netmask looks
+ * like an IPv4 address if topology is also TOP_NET30 or TOP_P2P.
+ *
+ * The result of this check is only reported to the log file as a warning
+ * when issues are found.
+ *
+ * @param tun       Boolean; if true device is a tun device, otherwise tap
+ * @param addr      Address to do sanity check on
+ * @param topology  Expected to be TOP_NET30, TOP_P2P, TOP_SUBNET
  *
- * If tun, make sure ifconfig_remote_netmask looks
- *  like an IPv4 address.
  */
-static void
+void
 ifconfig_sanity_check (bool tun, in_addr_t addr, int topology)
 {
   struct gc_arena gc = gc_new ();
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9b5a1b7..1a1f0b2 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -229,6 +229,8 @@ const char *guess_tuntap_dev (const char *dev,
 			      const char *dev_node,
 			      struct gc_arena *gc);
 
+void ifconfig_sanity_check (bool tun, in_addr_t addr, int topology);
+
 struct tuntap *init_tun (const char *dev,       /* --dev option */
 			 const char *dev_type,  /* --dev-type option */
 			 int topology,          /* one of the TOP_x values */
-- 
1.8.3.1


