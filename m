From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  4 Jan 2016 14:43:44 +0200
Message-Id: <1451911424-12970-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1451908945-12244-1-git-send-email-lstipakov@...277...>
References: <1451908945-12244-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH v2] Drop recursively routed packets
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

Trac #642

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/forward.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 36a99e6..af05bd0 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -973,6 +973,68 @@ read_incoming_tun (struct context *c)
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
+  struct openvpn_sockaddr tun_sa = c->c2.to_link_addr->dest;
+
+  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), buf))
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
+  else if (is_ipv6 (TUNNEL_TYPE (c->c1.tuntap), buf))
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
@@ -998,6 +1060,7 @@ process_incoming_tun (struct context *c)
 
   if (c->c2.buf.len > 0)
     {
+      drop_if_recursive_routing (c, &c->c2.buf);
       /*
        * The --passtos and --mssfix options require
        * us to examine the IP header (IPv4 or IPv6).
-- 
1.9.1


