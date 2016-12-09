From: David Sommerseth <davids@...515...>
Date: Fri,  9 Dec 2016 14:45:04 +0100
Message-Id: <1481291105-27739-2-git-send-email-davids@...515...>
In-Reply-To: <1481291105-27739-1-git-send-email-davids@...515...>
References: <1481291105-27739-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/2 v3] Improve ifconfig_sanity_check()
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

- Extend ifconfig_sanity_check() to know which context it is called from,
  if it is used to check --ifconfig or --ifconfig-push

- Improve error messages to also report errornous IP address usage when
  being in TOP_SUBNET

- Improve the TAP check too, providing the IP address used instead of the
  subnet mask

v2 - Revert the subnet mask check to the initial version and extend
     ifconfig_sanity_check() with a context flag.

v3 - Rearranged some of the code so this can be applied first.  Before,
     what is now the second patch was to be applied first.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/tun.c | 46 ++++++++++++++++++++++++++++++++++------------
 src/openvpn/tun.h |  2 ++
 2 files changed, 36 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 572e168..f5b8a6f 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -285,29 +285,51 @@ guess_tuntap_dev (const char *dev,
 /* --ifconfig-nowarn disables some options sanity checking */
 static const char ifconfig_warn_how_to_silence[] = "(silence this warning with --ifconfig-nowarn)";
 
-/*
- * If !tun, make sure ifconfig_remote_netmask looks
- *  like a netmask.
+/**
+ * If not a tun device, make sure ifconfig_remote_netmask looks
+ * like a netmask.
  *
- * If tun, make sure ifconfig_remote_netmask looks
- *  like an IPv4 address.
+ * If a tun device, make sure ifconfig_remote_netmask looks
+ * like an IPv4 address if topology is also TOP_NET30 or TOP_P2P.
+ *
+ * The result of this check is only reported to the log file as a warning
+ * when issues are found.
+ *
+ * @param tun       Boolean; if true device is a tun device, otherwise tap
+ * @param addr      Address to do sanity check on
+ * @param topology  Expected to be TOP_NET30, TOP_P2P, TOP_SUBNET
+ * @param pushctx   Is this called from a push context or not?  This decides if
+ *                  the warning should point at --ifconfig or --ifconfig-push
  */
-static void
-ifconfig_sanity_check (bool tun, in_addr_t addr, int topology)
+void
+ifconfig_sanity_check (bool tun, in_addr_t addr, int topology, bool pushctx)
 {
   struct gc_arena gc = gc_new ();
   const bool looks_like_netmask = ((addr & 0xFF000000) == 0xFF000000);
+
   if (tun)
     {
       if (looks_like_netmask && (topology == TOP_NET30 || topology == TOP_P2P))
-	msg (M_WARN, "WARNING: Since you are using --dev tun with a point-to-point topology, the second argument to --ifconfig must be an IP address.  You are using something (%s) that looks more like a netmask. %s",
-	     print_in_addr_t (addr, 0, &gc),
-	     ifconfig_warn_how_to_silence);
+	{
+	  msg (M_WARN, "WARNING: Since you are using --dev tun with a point-to-point topology, the second argument to %s must be an IP address. You are using something (%s) that looks more like a netmask. %s",
+	       (pushctx ? "--ifconfig-push" : "--ifconfig"),
+	       print_in_addr_t (addr, 0, &gc),
+	       ifconfig_warn_how_to_silence);
+	}
+      else if (!looks_like_netmask && topology == TOP_SUBNET)
+	{
+	  msg (M_WARN, "WARNING: Since you are using --dev tun with subnet topology, the second argument to %s must be a netmask, for example something like 255.255.255.0. You are using something (%s) that looks more like an IP address. %s",
+	       (pushctx ? "--ifconfig-push" : "--ifconfig"),
+	       print_in_addr_t (addr, 0, &gc),
+	       ifconfig_warn_how_to_silence);
+	}
     }
   else /* tap */
     {
       if (!looks_like_netmask)
-	msg (M_WARN, "WARNING: Since you are using --dev tap, the second argument to --ifconfig must be a netmask, for example something like 255.255.255.0. %s",
+	msg (M_WARN, "WARNING: Since you are using --dev tap, the second argument to %s must be a netmask, for example something like 255.255.255.0. You are using something (%s) that looks more like an IP address. %s",
+	     (pushctx ? "--ifconfig-push" : "--ifconfig"),
+	     print_in_addr_t (addr, 0, &gc),
 	     ifconfig_warn_how_to_silence);
     }
   gc_free (&gc);
@@ -643,7 +665,7 @@ init_tun (const char *dev,       /* --dev option */
       if (strict_warn)
 	{
 	  struct addrinfo *curele;
-	  ifconfig_sanity_check (tt->type == DEV_TYPE_TUN, tt->remote_netmask, tt->topology);
+	  ifconfig_sanity_check (tt->type == DEV_TYPE_TUN, tt->remote_netmask, tt->topology, false);
 
 	  /*
 	   * If local_public or remote_public addresses are defined,
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 9b5a1b7..733f8a9 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -229,6 +229,8 @@ const char *guess_tuntap_dev (const char *dev,
 			      const char *dev_node,
 			      struct gc_arena *gc);
 
+void ifconfig_sanity_check (bool tun, in_addr_t addr, int topology, bool pushctx);
+
 struct tuntap *init_tun (const char *dev,       /* --dev option */
 			 const char *dev_type,  /* --dev-type option */
 			 int topology,          /* one of the TOP_x values */
-- 
1.8.3.1


