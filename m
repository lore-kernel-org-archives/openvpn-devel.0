From: Gert Doering <gert@...1296...>
Date: Thu, 15 Jan 2026 10:11:16 +0100
Message-ID: <20260115091124.23360-1-gert@...1296...>
In-Reply-To: <gerrit.1768323591000.I701f9e0a96a7b43f278f8e6089e9156feab772c8@...2715...>
References: <gerrit.1768323591000.I701f9e0a96a7b43f278f8e6089e9156feab772c8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] forward: Avoid conversion warning in
 ipv6_send_icmp_unreachable
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

From: Frank Lichtenheld <frank@...2641...>

Since all values are limited by MAX_ICMPV6LEN we can
just cast to uint16_t.

While here remove a unused gc arena in neighbouring
code.

Change-Id: I701f9e0a96a7b43f278f8e6089e9156feab772c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1472
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1472
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d208c21..3730cd5 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1352,11 +1352,6 @@
     check_status(c->c2.buf.len, "read from TUN/TAP", NULL, c->c1.tuntap);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Drops UDP packets which OS decided to route via tun.
  *
@@ -1483,8 +1478,6 @@
 void
 process_incoming_tun(struct context *c, struct link_socket *out_sock)
 {
-    struct gc_arena gc = gc_new();
-
     if (c->c2.buf.len > 0)
     {
         c->c2.tun_read_bytes += c->c2.buf.len;
@@ -1528,7 +1521,6 @@
     {
         buf_reset(&c->c2.to_link);
     }
-    gc_free(&gc);
 }
 
 /**
@@ -1593,7 +1585,7 @@
     icmp6out.icmp6_type = OPENVPN_ICMP6_DESTINATION_UNREACHABLE;
     icmp6out.icmp6_code = OPENVPN_ICMP6_DU_NOROUTE;
 
-    int icmpheader_len = sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);
+    const int icmpheader_len = sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);
     int totalheader_len = icmpheader_len;
 
     if (TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TAP)
@@ -1606,10 +1598,11 @@
      * frame should be <= 1280 and have as much as possible of the original
      * packet
      */
-    int max_payload_size = min_int(MAX_ICMPV6LEN, c->c2.frame.tun_mtu - icmpheader_len);
-    int payload_len = min_int(max_payload_size, BLEN(&inputipbuf));
+    const int max_payload_size = min_int(MAX_ICMPV6LEN, c->c2.frame.tun_mtu - icmpheader_len);
+    const int payload_len = min_int(max_payload_size, BLEN(&inputipbuf));
+    const uint16_t icmp_len = (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payload_len);
 
-    pip6out.payload_len = htons(sizeof(struct openvpn_icmp6hdr) + payload_len);
+    pip6out.payload_len = htons(icmp_len);
 
     /* Construct the packet as outgoing packet back to the client */
     struct buffer *outbuf;
@@ -1665,10 +1658,6 @@
 #undef MAX_ICMPV6LEN
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *buf,
                   struct link_socket *sock)

