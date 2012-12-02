From: Gert Doering <gert@...1296...>
Date: Sun,  2 Dec 2012 22:11:12 +0100
Message-Id: <1354482672-16136-2-git-send-email-gert@...1296...>
In-Reply-To: <1354482672-16136-1-git-send-email-gert@...1296...>
References: <1354482672-16136-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Implement --mssfix handling for IPv6
	packets.
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

Rename process_ipv4_header() to process_ip_header() and PIPV4_MSSFIX
flag to PIP_MSSFIX, to make visible that it's no longer IPv4-only.

Inside process_ip_header(), call out to mss_fixup_ipv6() if --mssfix
is active and IPv6 packet seen.

Rename mss_fixup() to mss_fixup_ipv4(), implement mss_fixup_ipv6().

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/forward.c |   26 +++++++++++++--------
 src/openvpn/forward.h |    4 +-
 src/openvpn/mss.c     |   57 ++++++++++++++++++++++++++++++++++++++++++++++++-
 src/openvpn/mss.h     |    3 +-
 src/openvpn/multi.c   |    6 ++--
 src/openvpn/proto.c   |   19 +++++++++++++--
 src/openvpn/proto.h   |    3 +-
 7 files changed, 97 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 57c7846..024cd58 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -985,9 +985,9 @@ process_incoming_tun (struct context *c)
     {
       /*
        * The --passtos and --mssfix options require
-       * us to examine the IPv4 header.
+       * us to examine the IP header (IPv4 or IPv6).
        */
-      process_ipv4_header (c, PIPV4_PASSTOS|PIPV4_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf);
+      process_ip_header (c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf);
 
 #ifdef PACKET_TRUNCATION_CHECK
       /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1009,10 +1009,10 @@ process_incoming_tun (struct context *c)
 }
 
 void
-process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
+process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
 {
   if (!c->options.ce.mssfix)
-    flags &= ~PIPV4_MSSFIX;
+    flags &= ~PIP_MSSFIX;
 #if PASSTOS_CAPABILITY
   if (!c->options.passtos)
     flags &= ~PIPV4_PASSTOS;
@@ -1027,9 +1027,9 @@ process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
        * us to examine the IPv4 header.
        */
 #if PASSTOS_CAPABILITY
-      if (flags & (PIPV4_PASSTOS|PIPV4_MSSFIX))
+      if (flags & (PIPV4_PASSTOS|PIP_MSSFIX))
 #else
-      if (flags & PIPV4_MSSFIX)
+      if (flags & PIP_MSSFIX)
 #endif
 	{
 	  struct buffer ipbuf = *buf;
@@ -1042,8 +1042,8 @@ process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
 #endif
 			  
 	      /* possibly alter the TCP MSS */
-	      if (flags & PIPV4_MSSFIX)
-		mss_fixup (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+	      if (flags & PIP_MSSFIX)
+		mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
 
 #ifdef ENABLE_CLIENT_NAT
 	      /* possibly do NAT on packet */
@@ -1061,6 +1061,12 @@ process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
 		    route_list_add_vpn_gateway (c->c1.route_list, c->c2.es, dhcp_router);
 		}
 	    }
+	  else if (is_ipv6 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
+	    {
+	      /* possibly alter the TCP MSS */
+	      if (flags & PIP_MSSFIX)
+		mss_fixup_ipv6 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+	    }
 	}
     }
 }
@@ -1217,9 +1223,9 @@ process_outgoing_tun (struct context *c)
 
   /*
    * The --mssfix option requires
-   * us to examine the IPv4 header.
+   * us to examine the IP header (IPv4 or IPv6).
    */
-  process_ipv4_header (c, PIPV4_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIPV4_OUTGOING, &c->c2.to_tun);
+  process_ip_header (c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIPV4_OUTGOING, &c->c2.to_tun);
 
   if (c->c2.to_tun.len <= MAX_RW_SIZE_TUN (&c->c2.frame))
     {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0f829bd..1830a00 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -228,12 +228,12 @@ void process_outgoing_tun (struct context *c);
 bool send_control_channel_string (struct context *c, const char *str, int msglevel);
 
 #define PIPV4_PASSTOS         (1<<0)
-#define PIPV4_MSSFIX          (1<<1)
+#define PIP_MSSFIX            (1<<1)         /* v4 and v6 */
 #define PIPV4_OUTGOING        (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
 #define PIPV4_CLIENT_NAT      (1<<4)
 
-void process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf);
+void process_ip_header (struct context *c, unsigned int flags, struct buffer *buf);
 
 #if P2MP
 void schedule_exit (struct context *c, const int n_seconds, const int signal);
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 8981bad..64fd722 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -38,8 +38,13 @@
  * problems which arise from protocol
  * encapsulation.
  */
+
+/*
+ * IPv4 packet: find TCP header, check flags for "SYN"
+ *              if yes, hand to mss_fixup_dowork()
+ */
 void
-mss_fixup (struct buffer *buf, int maxmss)
+mss_fixup_ipv4 (struct buffer *buf, int maxmss)
 {
   const struct openvpn_iphdr *pip;
   int hlen;
@@ -69,6 +74,56 @@ mss_fixup (struct buffer *buf, int maxmss)
     }
 }
 
+/*
+ * IPv6 packet: find TCP header, check flags for "SYN"
+ *              if yes, hand to mss_fixup_dowork()
+ *              (IPv6 header structure is sufficiently different from IPv4...)
+ */
+void
+mss_fixup_ipv6 (struct buffer *buf, int maxmss)
+{
+  const struct openvpn_ipv6hdr *pip6;
+  struct buffer newbuf;
+
+  if (BLEN (buf) < (int) sizeof (struct openvpn_ipv6hdr))
+    return;
+
+  verify_align_4 (buf);
+  pip6 = (struct openvpn_ipv6hdr *) BPTR (buf);
+
+  /* do we have the full IPv6 packet?
+   * "payload_len" does not include IPv6 header (+40 bytes)
+   */
+  if (BLEN (buf) != (int) ntohs(pip6->payload_len)+40 )
+    return;
+
+  /* follow header chain until we reach final header, then check for TCP
+   *
+   * An IPv6 packet could, theoretically, have a chain of multiple headers
+   * before the final header (TCP, UDP, ...), so we'd need to walk that
+   * chain (see RFC 2460 and RFC 6564 for details).
+   *
+   * In practice, "most typically used" extention headers (AH, routing,
+   * fragment, mobility) are very unlikely to be seen inside an OpenVPN
+   * tun, so for now, we only handle the case of "single next header = TCP"
+   */
+  if ( pip6->nexthdr != OPENVPN_IPPROTO_TCP )
+    return;
+
+  newbuf = *buf;
+  if ( buf_advance( &newbuf, 40 ) )
+    {
+      struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR (&newbuf);
+      if (tc->flags & OPENVPN_TCPH_SYN_MASK)
+	    mss_fixup_dowork (&newbuf, (uint16_t) maxmss-20);
+    }
+}
+
+/*
+ * change TCP MSS option in SYN/SYN-ACK packets, if present
+ * this is generic for IPv4 and IPv6, as the TCP header is the same
+ */
+
 void
 mss_fixup_dowork (struct buffer *buf, uint16_t maxmss)
 {
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 0b290c3..0d32943 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -28,7 +28,8 @@
 #include "proto.h"
 #include "error.h"
 
-void mss_fixup (struct buffer *buf, int maxmss);
+void mss_fixup_ipv4 (struct buffer *buf, int maxmss);
+void mss_fixup_ipv6 (struct buffer *buf, int maxmss);
 void mss_fixup_dowork (struct buffer *buf, uint16_t maxmss);
 
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9876b80..ab3f10c 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2411,13 +2411,13 @@ multi_get_queue (struct mbuf_set *ms)
 
   if (mbuf_extract_item (ms, &item)) /* cleartext IP packet */
     {
-      unsigned int pipv4_flags = PIPV4_PASSTOS;
+      unsigned int pip_flags = PIPV4_PASSTOS;
 
       set_prefix (item.instance);
       item.instance->context.c2.buf = item.buffer->buf;
       if (item.buffer->flags & MF_UNICAST) /* --mssfix doesn't make sense for broadcast or multicast */
-	pipv4_flags |= PIPV4_MSSFIX;
-      process_ipv4_header (&item.instance->context, pipv4_flags, &item.instance->context.c2.buf);
+	pip_flags |= PIP_MSSFIX;
+      process_ip_header (&item.instance->context, pip_flags, &item.instance->context.c2.buf);
       encrypt_sign (&item.instance->context, true);
       mbuf_free_buf (item.buffer);
 
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 2cf8314..b437f1a 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -36,11 +36,12 @@
 #include "memdbg.h"
 
 /*
- * If raw tunnel packet is IPv4, return true and increment
+ * If raw tunnel packet is IPv<X>, return true and increment
  * buffer offset to start of IP header.
  */
+static
 bool
-is_ipv4 (int tunnel_type, struct buffer *buf)
+is_ipv_X ( int tunnel_type, struct buffer *buf, int ip_ver )
 {
   int offset;
   const struct openvpn_iphdr *ih;
@@ -68,12 +69,24 @@ is_ipv4 (int tunnel_type, struct buffer *buf)
 
   ih = (const struct openvpn_iphdr *) (BPTR (buf) + offset);
 
-  if (OPENVPN_IPH_GET_VER (ih->version_len) == 4)
+  /* IP version is stored in the same bits for IPv4 or IPv6 header */
+  if (OPENVPN_IPH_GET_VER (ih->version_len) == ip_ver)
     return buf_advance (buf, offset);
   else
     return false;
 }
 
+bool
+is_ipv4 (int tunnel_type, struct buffer *buf)
+{
+    return is_ipv_X( tunnel_type, buf, 4 );
+}
+bool
+is_ipv6 (int tunnel_type, struct buffer *buf)
+{
+    return is_ipv_X( tunnel_type, buf, 6 );
+}
+
 #ifdef PACKET_TRUNCATION_CHECK
 
 void
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 8cd4ede..f91e787 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -219,10 +219,11 @@ struct ip_tcp_udp_hdr {
                              - sizeof(struct openvpn_tcphdr))
 
 /*
- * If raw tunnel packet is IPv4, return true and increment
+ * If raw tunnel packet is IPv4 or IPv6, return true and increment
  * buffer offset to start of IP header.
  */
 bool is_ipv4 (int tunnel_type, struct buffer *buf);
+bool is_ipv6 (int tunnel_type, struct buffer *buf);
 
 #ifdef PACKET_TRUNCATION_CHECK
 void ipv4_packet_size_verify (const uint8_t *data,
-- 
1.7.8.6


