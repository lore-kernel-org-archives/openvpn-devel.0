From: Lev Stipakov <lstipakov@...277...>
Date: Sat, 17 Sep 2016 12:47:32 +0300
Message-Id: <1474105652-5672-1-git-send-email-lstipakov@...277...>
In-Reply-To: <20160830200339.GA78279@...1296...>
References: <20160830200339.GA78279@...1296...>
Subject: [Openvpn-devel] [PATCH v3] Drop recursively routed packets
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
 src/openvpn/forward.c | 71 +++++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/options.c | 10 ++++++++
 src/openvpn/options.h |  4 +++
 src/openvpn/proto.h   | 32 +++++++++++++++++++++++
 6 files changed, 123 insertions(+)

diff --git a/Changes.rst b/Changes.rst
index 9fcba75..4cc4acf 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -135,6 +135,8 @@ User-visible Changes
   ciphers configured in the config file.  Use --ncp-disable if you don't want
   that.
 
+- On the client side recursively routed packets, which have same destination as host,
+  are dropped. This could be disabled with --allow-recursive-routing option.
 
 Maintainer-visible changes
 --------------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 2f42636..49d2f72 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3985,6 +3985,10 @@ to the same server, with
 
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
index 6c11439..3016677 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -993,6 +993,75 @@ read_incoming_tun (struct context *c)
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
+
+  if (c->c2.to_link_addr == NULL) /* no remote addr known */
+    return;
+
+  tun_sa = c->c2.to_link_addr->dest;
+
+  int proto_ver = get_tun_ip_ver (TUNNEL_TYPE (c->c1.tuntap), &c->c2.buf);
+
+  if (proto_ver == 4)
+    {
+      const struct openvpn_iphdr *pip;
+
+      /* make sure we got whole IP header */
+      if (BLEN (buf) < (int) sizeof (struct openvpn_iphdr))
+	return;
+
+      /* skip ipv4 packets for ipv6 tun */
+      if (tun_sa.addr.sa.sa_family != AF_INET)
+	return;
+
+      pip = (struct openvpn_iphdr *) BPTR (buf);
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
+      if (BLEN (buf) < (int) sizeof (struct openvpn_ipv6hdr))
+	return;
+
+      /* skip ipv6 packets for ipv4 tun */
+      if (tun_sa.addr.sa.sa_family != AF_INET6)
+	return;
+
+      /* drop packets with same dest addr as gateway */
+      pip6 = (struct openvpn_ipv6hdr *) BPTR(buf);
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
@@ -1018,6 +1087,8 @@ process_incoming_tun (struct context *c)
 
   if (c->c2.buf.len > 0)
     {
+      if ((c->options.mode == MODE_POINT_TO_POINT) && (!c->options.allow_recursive_routing))
+	drop_if_recursive_routing (c, &c->c2.buf);
       /*
        * The --passtos and --mssfix options require
        * us to examine the IP header (IPv4 or IPv6).
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c100d4c..90d26c0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -500,6 +500,8 @@ static const char usage_message[] =
   "--connect-timeout n : when polling possible remote servers to connect to\n"
   "                  in a round-robin fashion, spend no more than n seconds\n"
   "                  waiting for a response before trying the next server.\n"
+  "--allow-recursive-routing : When this option is set, OpenVPN will not drop\n"
+  "                  incoming tun packets with same destination as host.\n"
 #endif
 #ifdef ENABLE_OCC
   "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
@@ -875,6 +877,7 @@ init_options (struct options *o, const bool init_gc)
   }
 #endif /* WIN32 */
 #endif /* P2MP_SERVER */
+  o->allow_recursive_routing = false;
 }
 
 void
@@ -2128,6 +2131,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	msg (M_USAGE, "--ifconfig-ipv6-pool needs --ifconfig-ipv6");
       if (options->ifconfig_ipv6_local && !options->tun_ipv6 )
 	msg (M_INFO, "Warning: --ifconfig-ipv6 without --tun-ipv6 will not do IPv6");
+      if (options->allow_recursive_routing)
+	msg (M_USAGE, "--allow-recursive-routing cannot be used with --mode server");
 
       if (options->auth_user_pass_file)
 	msg (M_USAGE, "--auth-user-pass cannot be used with --mode server (it should be used on the client side only)");
@@ -7365,6 +7370,11 @@ add_option (struct options *options,
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
index 9b7b57c..45412b1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -596,6 +596,10 @@ struct options
 #endif
 
   struct pull_filter_list *pull_filter_list;
+
+  /* Useful when packets sent by openvpn itself are not subject
+     to the routing tables that would move packets into the tunnel. */
+  bool allow_recursive_routing;
 };
 
 #define streq(x, y) (!strcmp((x), (y)))
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index f91e787..93444dd 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -219,6 +219,38 @@ struct ip_tcp_udp_hdr {
                              - sizeof(struct openvpn_tcphdr))
 
 /*
+ * This returns an ip protocol version of packet inside tun.
+ */
+inline static int get_tun_ip_ver(int tunnel_type, struct buffer *buf)
+{
+  int offset;
+  int ip_ver;
+  const struct openvpn_iphdr *ih;
+
+  ip_ver = -1;
+
+  /* for tun get ip version from ip header */
+  if (tunnel_type == DEV_TYPE_TUN)
+    {
+      if (likely(BLEN (buf) >= (int) sizeof (struct openvpn_iphdr)))
+	{
+	  ip_ver = OPENVPN_IPH_GET_VER (*BPTR(buf));
+	}
+    }
+  else if (tunnel_type == DEV_TYPE_TAP)
+    {
+      /* for tap get ip version from eth header */
+      if (likely(BLEN (buf) >= (int)(sizeof (struct openvpn_ethhdr))))
+	{
+	  const struct openvpn_ethhdr *eh = (const struct openvpn_ethhdr *) BPTR (buf);
+	  return (ntohs (eh->proto) == OPENVPN_ETH_P_IPV6) ? 6 : 4;
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


