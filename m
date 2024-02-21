From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 21 Feb 2024 12:17:22 +0100
Message-Id: <20240221111722.927042-1-frank@...2641...>
In-Reply-To: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
References: <gerrit.1708012740000.I4b5e8357d872c920efdb64632e9bce72cebee202@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Minor fix to process_ip_header
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Gianmarco De Gregori <gianmarco@...2726...>

Removed if-guard checking if any feature is
enabled before performing per-feature check.
It doesn't save us much but instead introduces
uneeded complexity.

While at it, fixed a typo IMCP -> ICMP for defined
PIPV6_ICMP_NOHOST_CLIENT and PIPV6_ICMP_NOHOST_SERVER
macros.

Fixes: Trac https://community.openvpn.net/openvpn/ticket/269
Change-Id: I4b5e8357d872c920efdb64632e9bce72cebee202
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/525
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 0443ca0..556c465 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1460,7 +1460,7 @@
          * us to examine the IP header (IPv4 or IPv6).
          */
         unsigned int flags = PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_NAT
-                             | PIPV6_IMCP_NOHOST_CLIENT;
+                             | PIPV6_ICMP_NOHOST_CLIENT;
         process_ip_header(c, flags, &c->c2.buf);
 
 #ifdef PACKET_TRUNCATION_CHECK
@@ -1644,73 +1644,60 @@
     }
     if (!c->options.block_ipv6)
     {
-        flags &= ~(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER);
+        flags &= ~(PIPV6_ICMP_NOHOST_CLIENT | PIPV6_ICMP_NOHOST_SERVER);
     }
 
     if (buf->len > 0)
     {
-        /*
-         * The --passtos and --mssfix options require
-         * us to examine the IPv4 header.
-         */
-
-        if (flags & (PIP_MSSFIX
-#if PASSTOS_CAPABILITY
-                     | PIPV4_PASSTOS
-#endif
-                     | PIPV4_CLIENT_NAT
-                     ))
+        struct buffer ipbuf = *buf;
+        if (is_ipv4(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
         {
-            struct buffer ipbuf = *buf;
-            if (is_ipv4(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
-            {
 #if PASSTOS_CAPABILITY
-                /* extract TOS from IP header */
-                if (flags & PIPV4_PASSTOS)
-                {
-                    link_socket_extract_tos(c->c2.link_socket, &ipbuf);
-                }
+            /* extract TOS from IP header */
+            if (flags & PIPV4_PASSTOS)
+            {
+                link_socket_extract_tos(c->c2.link_socket, &ipbuf);
+            }
 #endif
 
-                /* possibly alter the TCP MSS */
-                if (flags & PIP_MSSFIX)
-                {
-                    mss_fixup_ipv4(&ipbuf, c->c2.frame.mss_fix);
-                }
-
-                /* possibly do NAT on packet */
-                if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
-                {
-                    const int direction = (flags & PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
-                    client_nat_transform(c->options.client_nat, &ipbuf, direction);
-                }
-                /* possibly extract a DHCP router message */
-                if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
-                {
-                    const in_addr_t dhcp_router = dhcp_extract_router_msg(&ipbuf);
-                    if (dhcp_router)
-                    {
-                        route_list_add_vpn_gateway(c->c1.route_list, c->c2.es, dhcp_router);
-                    }
-                }
-            }
-            else if (is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
+            /* possibly alter the TCP MSS */
+            if (flags & PIP_MSSFIX)
             {
-                /* possibly alter the TCP MSS */
-                if (flags & PIP_MSSFIX)
-                {
-                    mss_fixup_ipv6(&ipbuf, c->c2.frame.mss_fix);
-                }
-                if (!(flags & PIP_OUTGOING) && (flags
-                                                &(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER)))
-                {
-                    ipv6_send_icmp_unreachable(c, buf,
-                                               (bool)(flags & PIPV6_IMCP_NOHOST_CLIENT));
-                    /* Drop the IPv6 packet */
-                    buf->len = 0;
-                }
-
+                mss_fixup_ipv4(&ipbuf, c->c2.frame.mss_fix);
             }
+
+            /* possibly do NAT on packet */
+            if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
+            {
+                const int direction = (flags & PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
+                client_nat_transform(c->options.client_nat, &ipbuf, direction);
+            }
+            /* possibly extract a DHCP router message */
+            if (flags & PIPV4_EXTRACT_DHCP_ROUTER)
+            {
+                const in_addr_t dhcp_router = dhcp_extract_router_msg(&ipbuf);
+                if (dhcp_router)
+                {
+                    route_list_add_vpn_gateway(c->c1.route_list, c->c2.es, dhcp_router);
+                }
+            }
+        }
+        else if (is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &ipbuf))
+        {
+            /* possibly alter the TCP MSS */
+            if (flags & PIP_MSSFIX)
+            {
+                mss_fixup_ipv6(&ipbuf, c->c2.frame.mss_fix);
+            }
+            if (!(flags & PIP_OUTGOING) && (flags
+                                            &(PIPV6_ICMP_NOHOST_CLIENT | PIPV6_ICMP_NOHOST_SERVER)))
+            {
+                ipv6_send_icmp_unreachable(c, buf,
+                                           (bool)(flags & PIPV6_ICMP_NOHOST_CLIENT));
+                /* Drop the IPv6 packet */
+                buf->len = 0;
+            }
+
         }
     }
 }
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index e19115e..bc00ba5 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -297,8 +297,9 @@
 #define PIP_OUTGOING                    (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
 #define PIPV4_CLIENT_NAT                (1<<4)
-#define PIPV6_IMCP_NOHOST_CLIENT        (1<<5)
-#define PIPV6_IMCP_NOHOST_SERVER        (1<<6)
+#define PIPV6_ICMP_NOHOST_CLIENT        (1<<5)
+#define PIPV6_ICMP_NOHOST_SERVER        (1<<6)
+
 
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4344126..712456c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3645,7 +3645,7 @@
 
     if (mbuf_extract_item(ms, &item)) /* cleartext IP packet */
     {
-        unsigned int pip_flags = PIPV4_PASSTOS | PIPV6_IMCP_NOHOST_SERVER;
+        unsigned int pip_flags = PIPV4_PASSTOS | PIPV6_ICMP_NOHOST_SERVER;
 
         set_prefix(item.instance);
         item.instance->context.c2.buf = item.buffer->buf;

