From: "Vladimir V. Kamarzin" <vvk@...1868...>
Date: Fri,  7 Mar 2014 15:58:18 +0600
Message-Id: <1394186298-226674-1-git-send-email-vvk@...1868...>
Subject: [Openvpn-devel] [PATCH] Flood unicast packet with unknown
	destination to all clients
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

From: "Vladimir V. Kamarzin" <vvk@...1868...>

When working in TAP mode, openvpn at server side maintains mapping table
"MAC" -> "client". It needs to know what MAC belongs to what client to
be able to forward traffic.

How does openvpn maintains it's MAC address table? Openvpn basically
emulates learning switch behavior, but not in 100% the same way. Openvpn
analyzes ethernet header of all packets, coming from clients, and
extracts MAC address from them.

So where is openvpn behavior differs from learning switch ones? Whether
learning switch sees a packet for broadcast, multicast or unknown
unicast destination, it sends it to all ports. Openvpn does the same
thing, except for unicast destinations.

Consider following example setup:
- S: switch
- A: generic network host, 192.168.0.1/24
- B: special device which provides access to C, 192.168.0.2/24 and MAC
  00:00:00:11:11:11
- C: special device that we want access, 192.168.0.3/24, MAC
  00:00:00:22:22:22

Plug scheme: (A) and (B) are plugged to (S). (C) is plugged to (B).
ARP handling for (B) is performed by (C).

Here is step-by-step scheme how it works:
1. (A) wants to "ping" (C). So it sends ARP request "who has
   192.168.0.3 tell 192.168.0.1" with broadcast destination in ethernet
   frame. Switch forwards this packet to all ports.
2. (B) receives ARP request and generates reply: "192.168.0.3 is at
   00:00:00:22:22:22". Although MAC in ethernet header is
   00:00:00:11:11:11!
3. Switch (S) see this reply and learns 00:00:00:11:11:11 to it MAC
   address table. (A) see this reply and add entry to ARP cache:
   192.168.0.3 -> 00:00:00:22:22:22
4. (A) sends unicast packet (ICMP echo request) to 192.168.0.3, with
   ethernet destination address 00:00:00:22:22:22
5. Switch (S) does not know where is 00:00:00:22:22:22, so it sends
   this packet to all ports
6. (C) receives ICMP echo request and generates ICMP echo reply.
   Ethernet header now contains 00:00:00:22:22:22.
7. Switch see frame with src 00:00:00:22:22:22 and learns it. All
   happy, traffic passes.

In openvpn case, there is no step 5. This patch implements option
"tap-flood-unknown-unicast", which changes openvpn behavior to
switch-like. Bandwidth on vpn links is limited & expensive, so it is
disabled by default.

Signed-off-by: Vladimir V. Kamarzin <vvk@...1868...>
---
 doc/openvpn.8         |  6 ++++++
 src/openvpn/multi.c   | 34 ++++++++++++++++++++++++++++++++--
 src/openvpn/options.c |  9 +++++++++
 src/openvpn/options.h |  2 ++
 4 files changed, 49 insertions(+), 2 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 6fc7462..01db9e8 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -5220,6 +5220,12 @@ the TAP-Win32 adapter time to come up before
 Windows IP Helper API operations are applied to it.
 .\"*********************************************************
 .TP
+.B \-\-tap-flood-unknown-unicast
+Flood an unicast packet to all clients whether destination address
+is not bound to any client. Useful when you have sort of an
+arp-proxy at the client side.
+.\"*********************************************************
+.TP
 .B \-\-show-net-up
 Output OpenVPN's view of the system routing table and network
 adapter list to the syslog or log file after the TUN/TAP adapter
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index ab3f10c..e7040be 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -991,6 +991,33 @@ multi_learn_addr (struct multi_context *m,
 }
 
 /*
+ * Do we have client instance associated with address?
+ */
+static bool
+multi_check_known_addr (struct multi_context *m,
+				    const struct mroute_addr *addr)
+{
+  struct multi_route *route;
+
+  /* check for local address */
+  if (mroute_addr_equal (addr, &m->local))
+    /* we don't need flooding of all clients when address is local */
+    return true;
+
+  route = (struct multi_route *) hash_lookup (m->vhash, addr);
+
+  /* does host route (possible cached) exist? */
+  if (route && multi_route_defined (m, route))
+    {
+      return true;
+    }
+  else
+    {
+      return false;
+    }
+}
+
+/*
  * Get client instance based on virtual address.
  */
 static struct multi_instance *
@@ -2341,8 +2368,11 @@ multi_process_incoming_tun (struct multi_context *m, const unsigned int mpp_flag
 	{
 	  struct context *c;
 
-	  /* broadcast or multicast dest addr? */
-	  if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
+	  /* Broadcast or multicast dest addr? Or unknown unicast dest addr? */
+	  if ((mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
+	       || (m->top.options.tap_flood_unknown_unicast == true
+		   && dev_type == DEV_TYPE_TAP
+		   && !multi_check_known_addr (m, &dest)))
 	    {
 	      /* for now, treat multicast as broadcast */
 #ifdef ENABLE_PF
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0ae2c61..2d9736c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -473,6 +473,8 @@ static const char usage_message[] =
   "--tcp-nodelay   : Macro that sets TCP_NODELAY socket flag on the server\n"
   "                  as well as pushes it to connecting clients.\n"
   "--learn-address cmd : Run command cmd to validate client virtual addresses.\n"
+  "--tap-flood-unknown-unicast  : Flood an unicast packet to all clients whether destination\n"
+  "                               address is not bound to any client.\n"
   "--connect-freq n s : Allow a maximum of n new connections per s seconds.\n"
   "--max-clients n : Allow a maximum of n simultaneously connected clients.\n"
   "--max-routes-per-client n : Allow a maximum of n internal routes per client.\n"
@@ -1194,6 +1196,7 @@ show_p2mp_parms (const struct options *o)
   SHOW_INT (virtual_hash_size);
   SHOW_STR (client_connect_script);
   SHOW_STR (learn_address_script);
+  SHOW_BOOL (tap_flood_unknown_unicast);
   SHOW_STR (client_disconnect_script);
   SHOW_STR (client_config_dir);
   SHOW_BOOL (ccd_exclusive);
@@ -2102,6 +2105,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--hash-size requires --mode server");
       if (options->learn_address_script)
 	msg (M_USAGE, "--learn-address requires --mode server");
+      if (options->tap_flood_unknown_unicast)
+	msg (M_USAGE, "--tap-flood-unknown-unicast requires --mode server");
       if (options->client_connect_script)
 	msg (M_USAGE, "--client-connect requires --mode server");
       if (options->client_disconnect_script)
@@ -6119,6 +6124,10 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_ROUTE_EXTRAS);
     }
+  else if (streq (p[0], "tap-flood-unknown-unicast"))
+    {
+      options->tap_flood_unknown_unicast = true;
+    }
   else if (streq (p[0], "pkcs11-id-type") ||
            streq (p[0], "pkcs11-sign-mode") ||
            streq (p[0], "pkcs11-slot") ||
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index f80532c..cba1049 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -591,6 +591,8 @@ struct options
   bool show_net_up;
   int route_method;
 #endif
+
+  bool tap_flood_unknown_unicast;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
-- 
1.8.3.2


