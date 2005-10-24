Message-ID: <435DC341.7070509@...481...>
From: Meno Abels <meno.abels@...481...>
MIME-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------090806070504090700090409"
Subject: [Openvpn-devel] ipv6 tcp mssfix
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Oct 24 22:34:20 2005
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------090806070504090700090409
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

i had a problem with tcp on ipv6 through openvpn. The problem is that
the ipv6 mssfix is not implemented. So i added these to the 
openvpn-2.0.2 software.
I attach the patch to this email.
I tried hard to adapted to the codeing style but there could be some 
faults.
I only tested it on macos x and freebsd so there are some other 
platforms to go.
One major change is that I renamed the openvpn_iphdr structure to 
openvpn_ip4hdr
and added the openvpn_ip6hdr which are now both needed.

Have fun

meno


--------------090806070504090700090409
Content-Type: text/plain;
 name="openvpn-2.0.2-ipv6mss.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.0.2-ipv6mss.patch"

diff -ur openvpn-2.0.2.orig/forward.c /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/forward.c
--- openvpn-2.0.2.orig/forward.c	Thu Aug  4 05:22:16 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/forward.c	Sun Oct 23 04:29:09 2005
@@ -878,7 +878,7 @@
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
-      process_ipv4_header (c, PIPV4_PASSTOS|PIPV4_MSSFIX, &c->c2.buf);
+      process_ip_header (c, PIPV4_PASSTOS|PIPV4_MSSFIX, &c->c2.buf);
       encrypt_sign (c, true);
     }
   else
@@ -890,7 +890,7 @@
 }
 
 void
-process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
+process_ip_header (struct context *c, unsigned int flags, struct buffer *buf)
 {
   if (!c->options.mssfix)
     flags &= ~PIPV4_MSSFIX;
@@ -912,17 +912,22 @@
 #endif
 	{
 	  struct buffer ipbuf = *buf;
-	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
+	  switch (get_ipversion(TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
 	    {
+	      case OPENVPN_PROTO_IPV4:
 #if PASSTOS_CAPABILITY
-	      /* extract TOS from IP header */
-	      if (flags & PIPV4_PASSTOS)
-		link_socket_extract_tos (c->c2.link_socket, &ipbuf);
-#endif
-			  
-	      /* possibly alter the TCP MSS */
-	      if (flags & PIPV4_MSSFIX)
-		mss_fixup (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+	        /* extract TOS from IP header */
+	        if (flags & PIPV4_PASSTOS)
+	  	  link_socket_extract_tos (c->c2.link_socket, &ipbuf);
+#endif
+	        /* possibly alter the TCP MSS */
+	        if (flags & PIPV4_MSSFIX)
+		  mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+                break;
+	      case OPENVPN_PROTO_IPV6:
+	        if (flags & PIPV4_MSSFIX)
+		  mss_fixup_ipv6 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+
 	    }
 	}
     }
@@ -1061,7 +1066,7 @@
    * The --mssfix option requires
    * us to examine the IPv4 header.
    */
-  process_ipv4_header (c, PIPV4_MSSFIX, &c->c2.to_tun);
+  process_ip_header (c, PIPV4_MSSFIX, &c->c2.to_tun);
 
   if (c->c2.to_tun.len <= MAX_RW_SIZE_TUN (&c->c2.frame))
     {
diff -ur openvpn-2.0.2.orig/forward.h /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/forward.h
--- openvpn-2.0.2.orig/forward.h	Mon Apr 11 05:43:58 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/forward.h	Sun Oct 23 04:25:30 2005
@@ -75,7 +75,7 @@
 #define PIPV4_PASSTOS         (1<<0)
 #define PIPV4_MSSFIX          (1<<1)
 
-void process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf);
+void process_ip_header (struct context *c, unsigned int flags, struct buffer *buf);
 
 #if P2MP
 void schedule_exit (struct context *c, const int n_seconds);
diff -ur openvpn-2.0.2.orig/mroute.c /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/mroute.c
--- openvpn-2.0.2.orig/mroute.c	Thu Aug  4 01:58:52 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/mroute.c	Sun Oct 23 04:40:00 2005
@@ -101,9 +101,9 @@
 	  switch (OPENVPN_IPH_GET_VER (*BPTR(buf)))
 	    {
 	    case 4:
-	      if (BLEN (buf) >= (int) sizeof (struct openvpn_iphdr))
+	      if (BLEN (buf) >= (int) sizeof (struct openvpn_ip4hdr))
 		{
-		  const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *) BPTR (buf);
+		  const struct openvpn_ip4hdr *ip = (const struct openvpn_ip4hdr *) BPTR (buf);
 		  if (src)
 		    {
 		      src->type = MR_ADDR_IPV4;
diff -ur openvpn-2.0.2.orig/mss.c /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/mss.c
--- openvpn-2.0.2.orig/mss.c	Mon Apr 11 05:43:55 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/mss.c	Sun Oct 23 05:27:23 2005
@@ -39,16 +39,16 @@
  * encapsulation.
  */
 void
-mss_fixup (struct buffer *buf, int maxmss)
+mss_fixup_ipv4 (struct buffer *buf, int maxmss)
 {
-  const struct openvpn_iphdr *pip;
+  const struct openvpn_ip4hdr *pip;
   int hlen;
 
-  if (BLEN (buf) < (int) sizeof (struct openvpn_iphdr))
+  if (BLEN (buf) < (int) sizeof (struct openvpn_ip4hdr))
     return;
   
   verify_align_4 (buf);
-  pip = (struct openvpn_iphdr *) BPTR (buf);
+  pip = (struct openvpn_ip4hdr *) BPTR (buf);
 
   hlen = OPENVPN_IPH_GET_LEN (pip->version_len);
 
@@ -70,6 +70,31 @@
 }
 
 void
+mss_fixup_ipv6 (struct buffer *buf, int maxmss)
+{
+  const struct openvpn_ip6hdr *pip;
+  if (BLEN (buf) < (int) sizeof (struct openvpn_ip6hdr))
+    return;
+
+  verify_align_4 (buf);
+  pip = (struct openvpn_ip6hdr *) BPTR (buf);
+  if (pip->ip6_ctlun.ip6_un1.ip6_un1_nxt == OPENVPN_IPPROTO_TCP
+      && ntohs (pip->ip6_ctlun.ip6_un1.ip6_un1_plen) 
+         == BLEN (buf) - sizeof(struct openvpn_ip6hdr)
+      && BLEN(buf) - sizeof(struct openvpn_ip6hdr) 
+         >= (int) sizeof (struct openvpn_tcphdr))
+  {
+      struct buffer newbuf = *buf;
+      if (buf_advance (&newbuf, sizeof(struct openvpn_ip6hdr)))
+	{
+	  struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR (&newbuf);
+	  if (tc->flags & OPENVPN_TCPH_SYN_MASK)
+	    mss_fixup_dowork (&newbuf, (uint16_t) maxmss);
+	}
+  }
+}
+
+void
 mss_fixup_dowork (struct buffer *buf, uint16_t maxmss)
 {
   int hlen, olen, optlen;
@@ -118,3 +143,4 @@
     }
   }
 }
+
diff -ur openvpn-2.0.2.orig/mss.h /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/mss.h
--- openvpn-2.0.2.orig/mss.h	Mon Apr 11 05:43:55 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/mss.h	Sun Oct 23 04:29:29 2005
@@ -28,7 +28,8 @@
 #include "proto.h"
 #include "error.h"
 
-void mss_fixup (struct buffer *buf, int maxmss);
+void mss_fixup_ipv4 (struct buffer *buf, int maxmss);
+void mss_fixup_ipv6 (struct buffer *buf, int maxmss);
 void mss_fixup_dowork (struct buffer *buf, uint16_t maxmss);
 
 #endif
diff -ur openvpn-2.0.2.orig/multi.c /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/multi.c
--- openvpn-2.0.2.orig/multi.c	Thu Aug  4 01:59:32 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/multi.c	Sun Oct 23 04:25:53 2005
@@ -1809,7 +1809,7 @@
       item.instance->context.c2.buf = item.buffer->buf;
       if (item.buffer->flags & MF_UNICAST) /* --mssfix doesn't make sense for broadcast or multicast */
 	pipv4_flags |= PIPV4_MSSFIX;
-      process_ipv4_header (&item.instance->context, pipv4_flags, &item.instance->context.c2.buf);
+      process_ip_header (&item.instance->context, pipv4_flags, &item.instance->context.c2.buf);
       encrypt_sign (&item.instance->context, true);
       mbuf_free_buf (item.buffer);
 
diff -ur openvpn-2.0.2.orig/proto.c /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/proto.c
--- openvpn-2.0.2.orig/proto.c	Mon Apr 11 05:43:58 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/proto.c	Sun Oct 23 05:23:02 2005
@@ -31,6 +31,7 @@
 #include "syshead.h"
 
 #include "proto.h"
+#include "errlevel.h"
 
 #include "memdbg.h"
 
@@ -38,37 +39,41 @@
  * If raw tunnel packet is IPv4, return true and increment
  * buffer offset to start of IP header.
  */
-bool
-is_ipv4 (int tunnel_type, struct buffer *buf)
+int
+get_ipversion (int tunnel_type, struct buffer *buf)
 {
   int offset;
-  const struct openvpn_iphdr *ih;
+  uint8_t version;
 
   verify_align_4 (buf);
   if (tunnel_type == DEV_TYPE_TUN)
     {
-      if (BLEN (buf) < (int) sizeof (struct openvpn_iphdr))
-	return false;
+      if (BLEN (buf) < (int) sizeof (struct openvpn_ip4hdr))
+	return OPENVPN_PROTO_UNK;
       offset = 0;
     }
   else if (tunnel_type == DEV_TYPE_TAP)
     {
       const struct openvpn_ethhdr *eh;
       if (BLEN (buf) < (int)(sizeof (struct openvpn_ethhdr)
-	  + sizeof (struct openvpn_iphdr)))
+	  + sizeof (struct openvpn_ip4hdr)))
 	return false;
       eh = (const struct openvpn_ethhdr *) BPTR (buf);
-      if (ntohs (eh->proto) != OPENVPN_ETH_P_IPV4)
-	return false;
+      if (!(ntohs (eh->proto) == OPENVPN_ETH_P_IPV4 ||
+      	    ntohs (eh->proto) == OPENVPN_ETH_P_IPV6 ))
+	return OPENVPN_PROTO_UNK;
       offset = sizeof (struct openvpn_ethhdr);
     }
   else
-    return false;
-
-  ih = (const struct openvpn_iphdr *) (BPTR (buf) + offset);
+    return OPENVPN_PROTO_UNK;
 
-  if (OPENVPN_IPH_GET_VER (ih->version_len) == 4)
-    return buf_advance (buf, offset);
+  version = (*((uint8_t *)(BPTR (buf) + offset)) >> 4) & 0xf;
+  if (version == OPENVPN_PROTO_IPV4 || version == OPENVPN_PROTO_IPV6)
+    {
+       if (!buf_advance (buf, offset))
+         return OPENVPN_PROTO_UNK;
+       return version; 
+    }
   else
-    return false;
+    return OPENVPN_PROTO_UNK;
 }
diff -ur openvpn-2.0.2.orig/proto.h /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/proto.h
--- openvpn-2.0.2.orig/proto.h	Mon Apr 11 05:43:58 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/proto.h	Sun Oct 23 04:39:34 2005
@@ -54,7 +54,7 @@
   uint16_t proto;                     /* packet type ID field */
 };
 
-struct openvpn_iphdr {
+struct openvpn_ip4hdr {
 # define OPENVPN_IPH_GET_VER(v) (((v) >> 4) & 0x0F)
 # define OPENVPN_IPH_GET_LEN(v) (((v) & 0x0F) << 2)
   uint8_t    version_len;
@@ -79,6 +79,27 @@
   /*The options start here. */
 };
 
+struct openvpn_in6_addr {
+        union {
+                uint8_t         __u6_addr8[16];
+                uint16_t        __u6_addr16[8];
+                uint32_t        __u6_addr32[4];
+        } __u6_addr;                    /* 128-bit IP6 address */
+}; 
+struct openvpn_ip6hdr {
+        union {
+                struct ip6_hdrctl {
+                        uint32_t ip6_un1_flow; /* 20 bits of flow-ID */
+                        uint16_t ip6_un1_plen; /* payload length */
+                        uint8_t  ip6_un1_nxt;  /* next header */
+                        uint8_t  ip6_un1_hlim; /* hop limit */
+                } ip6_un1;
+                uint8_t ip6_un2_vfc;   /* 4 bits version, top 4 bits class */
+        } ip6_ctlun;
+        struct openvpn_in6_addr ip6_src;        /* source address */
+        struct openvpn_in6_addr ip6_dst;        /* destination address */
+};
+
 /*
  * UDP header
  */
@@ -151,13 +172,18 @@
  *
  * (RFC 879, section 7).
  */
-#define MTU_TO_MSS(mtu) (mtu - sizeof(struct openvpn_iphdr) \
+#define MTU_TO_MSS(mtu) (mtu - sizeof(struct openvpn_ip4hdr) \
                              - sizeof(struct openvpn_tcphdr))
 
 /*
- * If raw tunnel packet is IPv4, return true and increment
+ * Check if raw tunnel packet is IPv4 or IPv6, 
+ * return the version and increment
  * buffer offset to start of IP header.
  */
-bool is_ipv4 (int tunnel_type, struct buffer *buf);
+
+#define OPENVPN_PROTO_IPV6 6
+#define OPENVPN_PROTO_IPV4 4
+#define OPENVPN_PROTO_UNK  0
+int get_ipversion(int tunnel_type, struct buffer *buf);
 
 #endif
diff -ur openvpn-2.0.2.orig/socket.h /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/socket.h
--- openvpn-2.0.2.orig/socket.h	Sat Apr 30 10:49:21 2005
+++ /jails/jails/neo/obj/ports/usr/ports/security/openvpn/work/openvpn-2.0.2/socket.h	Sun Oct 23 04:40:37 2005
@@ -735,7 +735,7 @@
 {
   if (ls && ipbuf)
     {
-      struct openvpn_iphdr *iph = (struct openvpn_iphdr *) BPTR (ipbuf);
+      struct openvpn_ip4hdr *iph = (struct openvpn_ip4hdr *) BPTR (ipbuf);
       ls->ptos = iph->tos;
       ls->ptos_defined = true;
     }

--------------090806070504090700090409--

