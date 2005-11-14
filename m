Message-ID: <4378BAEA.70400@...481...>
From: Meno Abels <meno.abels@...481...>
MIME-Version: 1.0
References: <Pine.LNX.4.58.0511121919160.1972@...41...> <43770701.4030106@...481...> <Pine.LNX.4.58.0511131458120.1972@...41...>
In-Reply-To: <Pine.LNX.4.58.0511131458120.1972@...41...>
Content-Type: multipart/mixed;
 boundary="------------040804030903070701010607"
Subject: [Openvpn-devel] PATCH openvpn-2.1-beta7-809 ipv6mss
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
Date: Mon Nov 14 08:27:54 2005
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040804030903070701010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Hello,

today is tomorrow-:)
I have done the patch for svn version 809 which you named 2.1-beta7. I 
included
the #ifdef ENABLE_IPv6 and the configure option --disable/enable-ipv6.
So this should be production read. I only tested on freebsd. I'am on the 
move from
uk to germany back and so my mac and my linux is not there.

regards

meno

>On Sun, 13 Nov 2005, Meno Abels wrote:
>
>  
>
>>Hello,
>>
>>why do you not included my ipv6 tcp mss fix patch?
>>    
>>
>
>Meno,
>
>Sorry -- I missed it.
>
>I took a look at the patch, and it looks good, though I would like to make 
>one request:
>
>Can you bracket the code with
>
>  #ifdef ENABLE_IPv6
>
>People who use OpenVPN in embedded applications are very sensitive to code 
>size, and I'd like to make IPv6 support something that can be easily 
>disabled.
>
>For now we can put #define ENABLE_IPv6 in syshead.h.  In the future, I 
>plan to have it controlled via ./configure option.
>
>Thanks,
>James
>
>
>
>  
>


--------------040804030903070701010607
Content-Type: text/plain;
 name="openvpn-2.1-beta7-809-ipv6mss.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.1-beta7-809-ipv6mss.patch"

Index: openvpn/mss.c
===================================================================
--- openvpn/mss.c	(revision 809)
+++ openvpn/mss.c	(working copy)
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
 
@@ -69,7 +69,35 @@
     }
 }
 
+#ifdef ENABLE_IPv6
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
+      {
+        struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR (&newbuf);
+        if (tc->flags & OPENVPN_TCPH_SYN_MASK)
+          mss_fixup_dowork (&newbuf, (uint16_t) maxmss);
+      }
+  }
+}
+#endif
+
+
+void
 mss_fixup_dowork (struct buffer *buf, uint16_t maxmss)
 {
   int hlen, olen, optlen;
@@ -118,3 +146,4 @@
     }
   }
 }
+
Index: openvpn/mss.h
===================================================================
--- openvpn/mss.h	(revision 809)
+++ openvpn/mss.h	(working copy)
@@ -28,7 +28,8 @@
 #include "proto.h"
 #include "error.h"
 
-void mss_fixup (struct buffer *buf, int maxmss);
+void mss_fixup_ipv4 (struct buffer *buf, int maxmss);
+void mss_fixup_ipv6 (struct buffer *buf, int maxmss);
 void mss_fixup_dowork (struct buffer *buf, uint16_t maxmss);
 
 #endif
Index: openvpn/configure.ac
===================================================================
--- openvpn/configure.ac	(revision 809)
+++ openvpn/configure.ac	(working copy)
@@ -47,6 +47,12 @@
    [SSL="yes"]
 )
 
+AC_ARG_ENABLE(ipv6,
+   [  --disable-ipv6          Disable ipv6 support],
+   [IPv6="$enableval"],
+   [IPv6="yes"]
+)
+
 AC_ARG_ENABLE(multi,
    [  --disable-multi         Disable client/server support (--mode server + client mode)],
    [MULTI="$enableval"],
@@ -606,6 +612,11 @@
    AC_DEFINE(USE_PKCS11, 1, [Enable PKCS11 capability])
 fi
 
+dnl enable ipv6 
+if test "$IPv6" = "yes"; then
+   AC_DEFINE(ENABLE_IPV6, 1, [Enable ipv6 support])
+fi
+
 dnl enable socks 
 if test "$SOCKS" = "yes"; then
    AC_DEFINE(ENABLE_SOCKS, 1, [Enable Socks proxy support])
Index: openvpn/multi.c
===================================================================
--- openvpn/multi.c	(revision 809)
+++ openvpn/multi.c	(working copy)
@@ -1962,7 +1962,7 @@
       item.instance->context.c2.buf = item.buffer->buf;
       if (item.buffer->flags & MF_UNICAST) /* --mssfix doesn't make sense for broadcast or multicast */
 	pipv4_flags |= PIPV4_MSSFIX;
-      process_ipv4_header (&item.instance->context, pipv4_flags, &item.instance->context.c2.buf);
+      process_tcp_header (&item.instance->context, pipv4_flags, &item.instance->context.c2.buf);
       encrypt_sign (&item.instance->context, true);
       mbuf_free_buf (item.buffer);
 
Index: openvpn/mroute.c
===================================================================
--- openvpn/mroute.c	(revision 809)
+++ openvpn/mroute.c	(working copy)
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
Index: openvpn/proto.c
===================================================================
--- openvpn/proto.c	(revision 809)
+++ openvpn/proto.c	(working copy)
@@ -39,39 +39,52 @@
  * If raw tunnel packet is IPv4, return true and increment
  * buffer offset to start of IP header.
  */
-bool
-is_ipv4 (int tunnel_type, struct buffer *buf)
+int
+get_ipversion (int tunnel_type, struct buffer *buf)
 {
   int offset;
+  uint8_t version;
   const struct openvpn_iphdr *ih;
+  int isip;
 
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
+      isip = ntohs (eh->proto) == OPENVPN_ETH_P_IPV4;
+#ifdef ENABLE_IPv6
+      isip = isip || ntohs (eh->proto) == OPENVPN_ETH_P_IPV6;
+#endif
+      if (!isip)
+	return OPENVPN_PROTO_UNK;
       offset = sizeof (struct openvpn_ethhdr);
     }
   else
-    return false;
+    return OPENVPN_PROTO_UNK;
 
-  ih = (const struct openvpn_iphdr *) (BPTR (buf) + offset);
-
-  if (OPENVPN_IPH_GET_VER (ih->version_len) == 4)
-    return buf_advance (buf, offset);
+  version = (*((uint8_t *)(BPTR (buf) + offset)) >> 4) & 0xf;
+  isip = version == OPENVPN_PROTO_IPV4;
+#ifdef ENABLE_IPv6
+  isip = isip || version == OPENVPN_PROTO_IPV6;
+#endif
+  if (isip)
+  {
+    if (!buf_advance (buf, offset))
+      return OPENVPN_PROTO_UNK;
+    return version; 
+  }
   else
-    return false;
+    return OPENVPN_PROTO_UNK;
 }
 
 #ifdef PACKET_TRUNCATION_CHECK
Index: openvpn/forward.c
===================================================================
--- openvpn/forward.c	(revision 809)
+++ openvpn/forward.c	(working copy)
@@ -912,7 +912,7 @@
        * The --passtos and --mssfix options require
        * us to examine the IPv4 header.
        */
-      process_ipv4_header (c, PIPV4_PASSTOS|PIPV4_MSSFIX, &c->c2.buf);
+      process_tcp_header (c, PIPV4_PASSTOS|PIPV4_MSSFIX, &c->c2.buf);
 
 #ifdef PACKET_TRUNCATION_CHECK
       /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -934,7 +934,7 @@
 }
 
 void
-process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf)
+process_tcp_header (struct context *c, unsigned int flags, struct buffer *buf)
 {
   if (!c->options.mssfix)
     flags &= ~PIPV4_MSSFIX;
@@ -954,21 +954,28 @@
 #else
       if (flags & PIPV4_MSSFIX)
 #endif
-	{
-	  struct buffer ipbuf = *buf;
-	  if (is_ipv4 (TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
-	    {
+	     {
+          struct buffer ipbuf = *buf;
+          switch (get_ipversion(TUNNEL_TYPE (c->c1.tuntap), &ipbuf))
+          {
+          case OPENVPN_PROTO_IPV4:
 #if PASSTOS_CAPABILITY
-	      /* extract TOS from IP header */
-	      if (flags & PIPV4_PASSTOS)
-		link_socket_extract_tos (c->c2.link_socket, &ipbuf);
+            /* extract TOS from IP header */
+            if (flags & PIPV4_PASSTOS)
+       	    link_socket_extract_tos (c->c2.link_socket, &ipbuf);
 #endif
-			  
-	      /* possibly alter the TCP MSS */
-	      if (flags & PIPV4_MSSFIX)
-		mss_fixup (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
-	    }
-	}
+            /* possibly alter the TCP MSS */
+            if (flags & PIPV4_MSSFIX)
+              mss_fixup_ipv4 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+            break;
+#ifdef ENABLE_IPv6
+        case OPENVPN_PROTO_IPV6:
+       	   if (flags & PIPV4_MSSFIX)
+              mss_fixup_ipv6 (&ipbuf, MTU_TO_MSS (TUN_MTU_SIZE_DYNAMIC (&c->c2.frame)));
+            break;	
+#endif
+          }
+        }
     }
 }
 
@@ -1108,7 +1115,7 @@
    * The --mssfix option requires
    * us to examine the IPv4 header.
    */
-  process_ipv4_header (c, PIPV4_MSSFIX|PIPV4_OUTGOING, &c->c2.to_tun);
+  process_tcp_header (c, PIPV4_MSSFIX|PIPV4_OUTGOING, &c->c2.to_tun);
 
   if (c->c2.to_tun.len <= MAX_RW_SIZE_TUN (&c->c2.frame))
     {
Index: openvpn/proto.h
===================================================================
--- openvpn/proto.h	(revision 809)
+++ openvpn/proto.h	(working copy)
@@ -62,7 +62,7 @@
   uint16_t proto;                     /* packet type ID field */
 };
 
-struct openvpn_iphdr {
+struct openvpn_ip4hdr {
 # define OPENVPN_IPH_GET_VER(v) (((v) >> 4) & 0x0F)
 # define OPENVPN_IPH_GET_LEN(v) (((v) & 0x0F) << 2)
   uint8_t    version_len;
@@ -87,6 +87,29 @@
   /*The options start here. */
 };
 
+#ifdef ENABLE_IPv6
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
+#endif
+
 /*
  * UDP header
  */
@@ -159,15 +182,22 @@
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
+#ifdef ENABLE_IPv6
+#define OPENVPN_PROTO_IPV6 6
+#endif
+#define OPENVPN_PROTO_IPV4 4
+#define OPENVPN_PROTO_UNK  0
+int get_ipversion(int tunnel_type, struct buffer *buf);
 
+
 #ifdef PACKET_TRUNCATION_CHECK
 void ipv4_packet_size_verify (const uint8_t *data,
 			      const int size,
Index: openvpn/forward.h
===================================================================
--- openvpn/forward.h	(revision 809)
+++ openvpn/forward.h	(working copy)
@@ -76,7 +76,7 @@
 #define PIPV4_MSSFIX          (1<<1)
 #define PIPV4_OUTGOING        (1<<2)
 
-void process_ipv4_header (struct context *c, unsigned int flags, struct buffer *buf);
+void process_tcp_header (struct context *c, unsigned int flags, struct buffer *buf);
 
 #if P2MP
 void schedule_exit (struct context *c, const int n_seconds);
Index: openvpn/socket.h
===================================================================
--- openvpn/socket.h	(revision 809)
+++ openvpn/socket.h	(working copy)
@@ -800,7 +800,7 @@
 {
   if (ls && ipbuf)
     {
-      struct openvpn_iphdr *iph = (struct openvpn_iphdr *) BPTR (ipbuf);
+      struct openvpn_ip4hdr *iph = (struct openvpn_ip4hdr *) BPTR (ipbuf);
       ls->ptos = iph->tos;
       ls->ptos_defined = true;
     }

--------------040804030903070701010607--

