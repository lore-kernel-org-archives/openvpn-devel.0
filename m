From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  3 Nov 2016 23:28:23 +0200
Message-Id: <1478208503-25929-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20161102195835.GQ28918@...1296...>
References: <20161102195835.GQ28918@...1296...>
Subject: [Openvpn-devel] [PATCH v4] Drop recursively routed packets
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
Cc: Lev Stipakov <lev.stipakov@...2164...>

From: Lev Stipakov <lev.stipakov@...2164...>

v4:
 - Account for IP header offset in TAP mode
 - Correct handle of non-IP protocols in TAP mode

v3: Use better way of figuring out IP proto version which
does not break TAP mode. Add an option to allow recursive
routing, could be useful when packets sent by openvpn itself
are not subject to the routing tables that would move packets
into the tunnel.

v2: better method naming

On certain OSes (Windows, OS X) when network adapter is
disabled (ethernet cable pulled off, Wi-Fi hardware switch disabled),
operating system starts to use tun as an external interface.
Outgoing packets are routed to tun, UDP encapsulated, given to
routing table and sent to.. tun.

As a consequence, system starts talking to itself on full power,
traffic counters skyrocket and user is not happy.

To prevent that, drop packets which have gateway IP as
destination address.

Tested on Win7/10, OS X.
---
 Changes.rst           |  2 ++
 doc/openvpn.8         |  4 +++
 src/openvpn/forward.c | 72 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/options.c | 10 +++++++
 src/openvpn/options.h |  4 +++
 src/openvpn/proto.h   | 39 ++++++++++++++++++++++++++++
 6 files changed, 131 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 8fd5859..d7aae00 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -188,6 +188,8 @@ User-visible Changes
   capable. The ``--tun-ipv6`` option is ignored (behaves like it is always
   on).
 
+- On the client side recursively routed packets, which have same destination as host,
+  are dropped. This could be disabled with --allow-recursive-routing option.
 
 Maintainer-visible changes
 --------------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 3a4ab21..863dcf9 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4004,6 +4004,10 @@ to the same server, with
 
 OpenVPN will not send any exit
 notifications unless this option is enabled.
+.TP
+.B \-\-allow\-recursive\-routing
+When this option is set, OpenVPN will not drop incoming tun packets
+with same destination as host.
 .\"*********************************************************
 .SS Data Channel Encryption Options:
 These options are meaningful for both Static & TLS-negotiated key modes
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b3077ed..3a4c26a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -993,6 +993,76 @@ read_incoming_tun (struct context *c)
   perf_pop ();
 }
 
+/**
+ * Drops UDP packets which OS decided to route via tun.
+ *
+ * On Windows and OS X when netwotk adapter is disabled or
+ * disconnected, platform starts to use tun as external interface.
+ * When packet is sent to tun, it comes to openvpn, encapsulated
+ * and sent to routing table, which sends it again to tun.
+ */
+static void
+drop_if_recursive_routing (struct context *c, struct buffer *buf)
+{
+  bool drop = false;
+  struct openvpn_sockaddr tun_sa;
+  int ip_hdr_offset = 0;
+
+  if (c->c2.to_link_addr == NULL) /* no remote addr known */
+    return;
+
+  tun_sa = c->c2.to_link_addr->dest;
+
+  int proto_ver = get_tun_ip_ver (TUNNEL_TYPE (c->c1.tuntap), &c->c2.buf, &ip_hdr_offset);
+
+  if (proto_ver == 4)
+    {
+      const struct openvpn_iphdr *pip;
+
+      /* make sure we got whole IP header */
+      if (BLEN (buf) < ((int) sizeof (struct openvpn_iphdr) + ip_hdr_offset))
+	return;
+
+      /* skip ipv4 packets for ipv6 tun */
+      if (tun_sa.addr.sa.sa_family != AF_INET)
+	return;
+
+      pip = (struct openvpn_iphdr *) (BPTR (buf) + ip_hdr_offset);
+
+      /* drop packets with same dest addr as gateway */
+      if (tun_sa.addr.in4.sin_addr.s_addr == pip->daddr)
+	drop = true;
+    }
+  else if (proto_ver == 6)
+    {
+      const struct openvpn_ipv6hdr *pip6;
+
+      /* make sure we got whole IPv6 header */
+      if (BLEN (buf) < ((int) sizeof (struct openvpn_ipv6hdr) + ip_hdr_offset))
+	return;
+
+      /* skip ipv6 packets for ipv4 tun */
+      if (tun_sa.addr.sa.sa_family != AF_INET6)
+	return;
+
+      /* drop packets with same dest addr as gateway */
+      pip6 = (struct openvpn_ipv6hdr *) (BPTR (buf) + ip_hdr_offset);
+      if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
+	drop = true;
+    }
+
+  if (drop)
+    {
+      struct gc_arena gc = gc_new ();
+
+      c->c2.buf.len = 0;
+
+      msg(D_LOW, "Recursive routing detected, drop tun packet to %s",
+		print_link_socket_actual(c->c2.to_link_addr, &gc));
+      gc_free (&gc);
+    }
+}
+
 /*
  * Input:  c->c2.buf
  * Output: c->c2.to_link
@@ -1018,6 +1088,8 @@ process_incoming_tun (struct context *c)
 
   if (c->c2.buf.len > 0)
     {
+      if ((c->options.mode == MODE_POINT_TO_POINT) && (!c->options.allow_recursive_routing))
+	drop_if_recursive_routing (c, &c->c2.buf);
       /*
        * The --passtos and --mssfix options require
        * us to examine the IP header (IPv4 or IPv6).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index be31ed3..552bf5a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -508,6 +508,8 @@ static const char usage_message[] =
   "--connect-timeout n : when polling possible remote servers to connect to\n"
   "                  in a round-robin fashion, spend no more than n seconds\n"
   "                  waiting for a response before trying the next server.\n"
+  "--allow-recursive-routing : When this option is set, OpenVPN will not drop\n"
+  "                  incoming tun packets with same destination as host.\n"
 #endif
 #ifdef ENABLE_OCC
   "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
@@ -886,6 +888,7 @@ init_options (struct options *o, const bool init_gc)
   }
 #endif /* WIN32 */
 #endif /* P2MP_SERVER */
+  o->allow_recursive_routing = false;
 }
 
 void
@@ -2134,6 +2137,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--ifconfig-pool-persist must be used with --ifconfig-pool");
       if (options->ifconfig_ipv6_pool_defined && !options->ifconfig_ipv6_local )
 	msg (M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
+      if (options->allow_recursive_routing)
+	msg (M_USAGE, "--allow-recursive-routing cannot be used with --mode server");
       if (options->auth_user_pass_file)
 	msg (M_USAGE, "--auth-user-pass cannot be used with --mode server (it should be used on the client side only)");
       if (options->ccd_exclusive && !options->client_config_dir)
@@ -7385,6 +7390,11 @@ add_option (struct options *options,
       options->keying_material_exporter_length = ekm_length;
     }
 #endif
+  else if (streq (p[0], "allow-recursive-routing") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->allow_recursive_routing = true;
+    }
   else
     {
       int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f91a52..0ebea30 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -597,6 +597,10 @@ struct options
 #endif
 
   struct pull_filter_list *pull_filter_list;
+
+  /* Useful when packets sent by openvpn itself are not subject
+     to the routing tables that would move packets into the tunnel. */
+  bool allow_recursive_routing;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index f91e787..922f936 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -219,6 +219,45 @@ struct ip_tcp_udp_hdr {
                              - sizeof(struct openvpn_tcphdr))
 
 /*
+ * This returns an ip protocol version of packet inside tun
+ * and offset of IP header (via parameter).
+ */
+inline static int get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)
+{
+  int ip_ver = -1;
+
+  /* for tun get ip version from ip header */
+  if (tunnel_type == DEV_TYPE_TUN)
+    {
+      *ip_hdr_offset = 0;
+      if (likely(BLEN (buf) >= (int) sizeof (struct openvpn_iphdr)))
+	{
+	  ip_ver = OPENVPN_IPH_GET_VER (*BPTR(buf));
+	}
+    }
+  else if (tunnel_type == DEV_TYPE_TAP)
+    {
+      *ip_hdr_offset = (int)(sizeof (struct openvpn_ethhdr));
+      /* for tap get ip version from eth header */
+      if (likely(BLEN (buf) >= *ip_hdr_offset))
+	{
+	  const struct openvpn_ethhdr *eh = (const struct openvpn_ethhdr *) BPTR (buf);
+	  uint16_t proto = ntohs (eh->proto);
+	  if (proto == OPENVPN_ETH_P_IPV6)
+	    {
+	      ip_ver = 6;
+	    }
+	  else if (proto == OPENVPN_ETH_P_IPV4)
+	    {
+	      ip_ver = 4;
+	    }
+	}
+    }
+
+    return ip_ver;
+}
+
+/*
  * If raw tunnel packet is IPv4 or IPv6, return true and increment
  * buffer offset to start of IP header.
  */
-- 
1.9.1


