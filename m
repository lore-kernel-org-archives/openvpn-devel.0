From: Steffan Karger <steffan@...1856...>
Date: Sun, 13 Nov 2016 13:37:09 +0100
Message-Id: <1479040629-22488-1-git-send-email-steffan@...1856...>
In-Reply-To: <007153b7-099b-0b86-0aa1-a70e9d8d1495@...2080...>
References: <007153b7-099b-0b86-0aa1-a70e9d8d1495@...2080...>
Subject: [Openvpn-devel] [PATCH] Don't deference type-punned pointers
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

Dereferencing type-punned pointers is undefined behaviour according to the
C standard.  We should either obey the standard, or ensure that all
supported compilers deal with dereferencing type-punned pointers as we
want them to.  I think just obeying the standard is the easiest solution.

See e.g. http://blog.regehr.org/archives/959.

This commit refactors the offending code to use unions or memcpy() to
comply to strict aliasing rules.

Note that this also slightly changes mroute_addr_mask_host_bits(), to
behave as it was probably intended to:  only mask the address part, not
also the port part of IPv6 adresses if MR_WITH_PORT is used (ie ma->len
is sizeof(struct in6_addr)+2).

v2: fix all strict aliasing occurrences, not just those in mroute.h.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/error.h  | 10 +++++++
 src/openvpn/mroute.c | 85 +++++++++++++++++++++++++---------------------------
 src/openvpn/mroute.h | 41 +++++++++++++++++++++----
 src/openvpn/multi.c  |  4 +--
 src/openvpn/ps.c     | 10 ++++---
 src/openvpn/socket.c |  3 +-
 6 files changed, 96 insertions(+), 57 deletions(-)

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index ced2fdf..c90b36b 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -27,6 +27,8 @@
 
 #include "basic.h"
 
+#include <assert.h>
+
 /* #define ABORT_ON_ERROR */
 
 #ifdef ENABLE_PKCS11
@@ -219,6 +221,14 @@ FILE *msg_fp(const unsigned int flags);
 void assert_failed (const char *filename, int line, const char *condition)
   __attribute__((__noreturn__));
 
+/* Poor-man's static_assert() for when not supplied by assert.h, taken from
+ * Linux's sys/cdefs.h under GPLv2 */
+#ifndef static_assert
+#define static_assert(expr, diagnostic) \
+    extern int (*__OpenVPN_static_assert_function (void)) \
+      [!!sizeof (struct { int __error_if_negative: (expr) ? 2 : -1; })]
+#endif
+
 #ifdef ENABLE_DEBUG
 void crash (void); /* force a segfault (debugging only) */
 #endif
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 972f1dd..ad42f76 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -58,7 +58,8 @@ is_mac_mcast_addr (const uint8_t *mac)
 static inline bool
 is_mac_mcast_maddr (const struct mroute_addr *addr)
 {
-  return (addr->type & MR_ADDR_MASK) == MR_ADDR_ETHER && is_mac_mcast_addr (addr->addr); 
+  return (addr->type & MR_ADDR_MASK) == MR_ADDR_ETHER &&
+      is_mac_mcast_addr (addr->eth_addr);
 }
 
 /*
@@ -73,7 +74,7 @@ mroute_learnable_address (const struct mroute_addr *addr)
 
   for (i = 0; i < addr->len; ++i)
     {
-      int b = addr->addr[i];
+      int b = addr->raw_addr[i];
       if (b != 0x00)
 	not_all_zeros = true;
       if (b != 0xFF)
@@ -90,7 +91,7 @@ mroute_get_in_addr_t (struct mroute_addr *ma, const in_addr_t src, unsigned int
       ma->type = MR_ADDR_IPV4 | mask;
       ma->netbits = 0;
       ma->len = 4;
-      *(in_addr_t*)ma->addr = src;
+      ma->v4.addr = src;
     }
 }
 
@@ -102,7 +103,7 @@ mroute_get_in6_addr (struct mroute_addr *ma, const struct in6_addr src, unsigned
       ma->type = MR_ADDR_IPV6 | mask;
       ma->netbits = 0;
       ma->len = 16;
-      *(struct in6_addr *)ma->addr = src;
+      ma->v6.addr = src;
     }
 }
 
@@ -226,14 +227,14 @@ mroute_extract_addr_ether (struct mroute_addr *src,
 	  src->type = MR_ADDR_ETHER;
 	  src->netbits = 0;
 	  src->len = 6;
-	  memcpy (src->addr, eth->source, 6);
+	  memcpy (src->eth_addr, eth->source, sizeof(dest->eth_addr));
 	}
       if (dest)
 	{
 	  dest->type = MR_ADDR_ETHER;
 	  dest->netbits = 0;
 	  dest->len = 6;
-	  memcpy (dest->addr, eth->dest, 6);
+	  memcpy (dest->eth_addr, eth->dest, sizeof(dest->eth_addr));
 
 	  /* ethernet broadcast/multicast packet? */
 	  if (is_mac_mcast_addr (eth->dest))
@@ -281,15 +282,15 @@ bool mroute_extract_openvpn_sockaddr (struct mroute_addr *addr,
 	  addr->type = MR_ADDR_IPV4 | MR_WITH_PORT;
 	  addr->netbits = 0;
 	  addr->len = 6;
-	  memcpy (addr->addr, &osaddr->addr.in4.sin_addr.s_addr, 4);
-	  memcpy (addr->addr + 4, &osaddr->addr.in4.sin_port, 2);
+	  addr->v4.addr = osaddr->addr.in4.sin_addr.s_addr;
+	  addr->v4.port = osaddr->addr.in4.sin_port;
 	}
       else
 	{
 	  addr->type = MR_ADDR_IPV4;
 	  addr->netbits = 0;
 	  addr->len = 4;
-	  memcpy (addr->addr, &osaddr->addr.in4.sin_addr.s_addr, 4);
+	  addr->v4.addr = osaddr->addr.in4.sin_addr.s_addr;
 	}
       return true;
     }
@@ -299,15 +300,15 @@ bool mroute_extract_openvpn_sockaddr (struct mroute_addr *addr,
 	  addr->type = MR_ADDR_IPV6 | MR_WITH_PORT;
 	  addr->netbits = 0;
 	  addr->len = 18;
-	  memcpy (addr->addr, &osaddr->addr.in6.sin6_addr, 16);
-	  memcpy (addr->addr + 16, &osaddr->addr.in6.sin6_port, 2);
+	  addr->v6.addr = osaddr->addr.in6.sin6_addr;
+	  addr->v6.port = osaddr->addr.in6.sin6_port;
 	}
       else
 	{
 	  addr->type = MR_ADDR_IPV6;
 	  addr->netbits = 0;
 	  addr->len = 16;
-	  memcpy (addr->addr, &osaddr->addr.in6.sin6_addr, 16);
+	  addr->v6.addr = osaddr->addr.in6.sin6_addr;
 	}
       return true;
   }
@@ -326,23 +327,29 @@ bool mroute_extract_openvpn_sockaddr (struct mroute_addr *addr,
 void
 mroute_addr_mask_host_bits (struct mroute_addr *ma)
 {
-  in_addr_t addr = ntohl(*(in_addr_t*)ma->addr);
   if ((ma->type & MR_ADDR_MASK) == MR_ADDR_IPV4)
     {
+      in_addr_t addr = ntohl (ma->v4.addr);
       addr &= netbits_to_netmask (ma->netbits);
-      *(in_addr_t*)ma->addr = htonl (addr);
+      ma->v4.addr = htonl (addr);
     }
   else if ((ma->type & MR_ADDR_MASK) == MR_ADDR_IPV6)
     {
-      int byte = ma->len-1;		/* rightmost byte in address */
+      int byte = sizeof (ma->v6.addr) - 1;	/* rightmost byte in address */
       int bits_to_clear = 128 - ma->netbits;
 
       while( byte >= 0 && bits_to_clear > 0 )
         {
 	  if ( bits_to_clear >= 8 )
-	    { ma->addr[byte--] = 0; bits_to_clear -= 8; }
+	    {
+	      ma->v6.addr.s6_addr[byte--] = 0;
+	      bits_to_clear -= 8;
+	    }
 	  else
-	    { ma->addr[byte--] &= (IPV4_NETMASK_HOST << bits_to_clear); bits_to_clear = 0; }
+	    {
+	      ma->v6.addr.s6_addr[byte--] &= (IPV4_NETMASK_HOST << bits_to_clear);
+	      bits_to_clear = 0;
+	    }
         }
       ASSERT( bits_to_clear == 0 );
     }
@@ -390,51 +397,41 @@ mroute_addr_print_ex (const struct mroute_addr *ma,
       switch (maddr.type & MR_ADDR_MASK)
 	{
 	case MR_ADDR_ETHER:
-	  buf_printf (&out, "%s", format_hex_ex (ma->addr, 6, 0, 1, ":", gc)); 
+	  buf_printf (&out, "%s", format_hex_ex (ma->eth_addr,
+	      sizeof(ma->eth_addr), 0, 1, ":", gc));
 	  break;
 	case MR_ADDR_IPV4:
 	  {
-	    struct buffer buf;
-	    in_addr_t addr;
-	    int port;
-	    bool status;
-	    buf_set_read (&buf, maddr.addr, maddr.len);
-	    addr = buf_read_u32 (&buf, &status);
-	    if (status)
+	    if ((flags & MAPF_SHOW_ARP) && (maddr.type & MR_ARP))
+	      buf_printf (&out, "ARP/");
+	    buf_printf (&out, "%s", print_in_addr_t (ntohl (maddr.v4.addr),
+		(flags & MAPF_IA_EMPTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
+	    if (maddr.type & MR_WITH_NETBITS)
 	      {
-		if ((flags & MAPF_SHOW_ARP) && (maddr.type & MR_ARP))
-		  buf_printf (&out, "ARP/");
-		buf_printf (&out, "%s", print_in_addr_t (addr, (flags & MAPF_IA_EMPTY_IF_UNDEF) ? IA_EMPTY_IF_UNDEF : 0, gc));
-		if (maddr.type & MR_WITH_NETBITS)
+		if (flags & MAPF_SUBNET)
 		  {
-		    if (flags & MAPF_SUBNET)
-		      {
-			const in_addr_t netmask = netbits_to_netmask (maddr.netbits);
-			buf_printf (&out, "/%s", print_in_addr_t (netmask, 0, gc));
-		      }
-		    else
-		      buf_printf (&out, "/%d", maddr.netbits);
+		    const in_addr_t netmask = netbits_to_netmask (maddr.netbits);
+		    buf_printf (&out, "/%s", print_in_addr_t (netmask, 0, gc));
 		  }
+		else
+		  buf_printf (&out, "/%d", maddr.netbits);
 	      }
 	    if (maddr.type & MR_WITH_PORT)
 	      {
-		port = buf_read_u16 (&buf);
-		if (port >= 0)
-		  buf_printf (&out, ":%d", port);
+		buf_printf (&out, ":%d", maddr.v4.port);
 	      }
 	  }
 	  break;
 	case MR_ADDR_IPV6:
 	  {
-	    if ( IN6_IS_ADDR_V4MAPPED( (struct in6_addr*)&maddr.addr ) )
+	    if ( IN6_IS_ADDR_V4MAPPED( &maddr.v6.addr ) )
 	      {
-		buf_printf (&out, "%s",
-		     print_in_addr_t( *(in_addr_t*)(&maddr.addr[12]), IA_NET_ORDER, gc));
+		buf_printf (&out, "%s", print_in_addr_t (maddr.v4mappedv6.addr,
+		    IA_NET_ORDER, gc));
 	      }
 	    else
 	      {
-	        buf_printf (&out, "%s",
-		      print_in6_addr( *(struct in6_addr*)&maddr.addr, 0, gc));
+	        buf_printf (&out, "%s", print_in6_addr (maddr.v6.addr, 0, gc));
 	      }
 	    if (maddr.type & MR_WITH_NETBITS)
 	      {
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 608f70b..5fe17e7 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -31,6 +31,8 @@
 #include "list.h"
 #include "route.h"
 
+#include <stddef.h>
+
 #define IP_MCAST_SUBNET_MASK  ((in_addr_t)240<<24)
 #define IP_MCAST_NETWORK      ((in_addr_t)224<<24)
 
@@ -79,9 +81,35 @@ struct mroute_addr {
   uint8_t type;     /* MR_ADDR/MR_WITH flags */
   uint8_t netbits;  /* number of bits in network part of address,
 		       valid if MR_WITH_NETBITS is set */
-  uint8_t addr[MR_MAX_ADDR_LEN];  /* actual address */
+  union {
+    uint8_t raw_addr[MR_MAX_ADDR_LEN];  /* actual address */
+    uint8_t eth_addr[OPENVPN_ETH_ALEN];
+    struct {
+      in_addr_t addr;		/* _network order_ IPv4 address */
+      in_port_t port;		/* _network order_ TCP/UDP port */
+    } v4;
+    struct {
+      struct in6_addr addr;
+      in_port_t port;		/* _network order_ TCP/UDP port */
+    } v6;
+    struct {
+      uint8_t prefix[12];
+      in_addr_t addr;		/* _network order_ IPv4 address */
+    } v4mappedv6;
+  };
 };
 
+/* Double-check that struct packing works as expected */
+static_assert (offsetof(struct mroute_addr, v4.port) ==
+	offsetof(struct mroute_addr, v4) + 4,
+    "Unexpected struct packing of v4");
+static_assert (offsetof(struct mroute_addr, v6.port) ==
+	offsetof(struct mroute_addr, v6) + 16,
+    "Unexpected struct packing of v6");
+static_assert (offsetof(struct mroute_addr, v4mappedv6.addr) ==
+	offsetof(struct mroute_addr, v4mappedv6) + 12,
+    "Unexpected struct packing of v4mappedv6");
+
 /*
  * Number of bits in an address.  Should be raised for IPv6.
  */
@@ -167,7 +195,7 @@ mroute_addr_equal (const struct mroute_addr *a1, const struct mroute_addr *a2)
     return false;
   if (a1->len != a2->len)
     return false;
-  return memcmp (a1->addr, a2->addr, a1->len) == 0;
+  return memcmp (a1->raw_addr, a2->raw_addr, a1->len) == 0;
 }
 
 static inline const uint8_t *
@@ -189,16 +217,17 @@ mroute_extract_in_addr_t (struct mroute_addr *dest, const in_addr_t src)
   dest->type = MR_ADDR_IPV4;
   dest->netbits = 0;
   dest->len = 4;
-  *(in_addr_t*)dest->addr = htonl (src);
+  dest->v4.addr = htonl (src);
 }
 
 static inline in_addr_t
 in_addr_t_from_mroute_addr (const struct mroute_addr *addr)
 {
-  if ((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV4 && addr->netbits == 0 && addr->len == 4)
-    return ntohl(*(in_addr_t*)addr->addr);
-  else
+  if ((addr->type & MR_ADDR_MASK) == MR_ADDR_IPV4 && addr->netbits == 0 && addr->len == 4) {
+    return ntohl(addr->v4.addr);
+  } else {
     return 0;
+  }
 }
 
 static inline void
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a834e94..83b1e99 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1201,7 +1201,7 @@ multi_learn_in6_addr  (struct multi_context *m,
   addr.len = 16;
   addr.type = MR_ADDR_IPV6;
   addr.netbits = 0;
-  memcpy( &addr.addr, &a6, sizeof(a6) );
+  addr.v6.addr = a6;
 
   if (netbits >= 0)
     {
@@ -2431,7 +2431,7 @@ multi_process_incoming_link (struct multi_context *m, struct multi_instance *ins
 		{
 		  /* IPv6 link-local address (fe80::xxx)? */
 		  if ( (src.type & MR_ADDR_MASK) == MR_ADDR_IPV6 &&
-		        src.addr[0] == 0xfe && src.addr[1] == 0x80 )
+		        IN6_IS_ADDR_LINKLOCAL (&src.v6.addr) )
 		    {
 		      /* do nothing, for now.  TODO: add address learning */
 		    }
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index fe18a9d..2cb68f1 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -223,12 +223,12 @@ port_share_sendmsg (const socket_descriptor_t sd,
 
       if (socket_defined (sd_send))
 	{
-	  *((socket_descriptor_t*)CMSG_DATA(h)) = sd_send;
+	  memcpy (CMSG_DATA(h), &sd_send, sizeof (sd_send));
 	}
       else
 	{
 	  socketpair (PF_UNIX, SOCK_DGRAM, 0, sd_null);
-	  *((socket_descriptor_t*)CMSG_DATA(h)) = sd_null[0];
+	  memcpy (CMSG_DATA(h), &sd_null[0], sizeof (sd_null[0]));
 	}
 
       status = sendmsg (sd, &mesg, MSG_NOSIGNAL);
@@ -502,7 +502,8 @@ control_message_from_parent (const socket_descriptor_t sd_control,
   h->cmsg_len = CMSG_LEN(sizeof(socket_descriptor_t));
   h->cmsg_level = SOL_SOCKET;
   h->cmsg_type = SCM_RIGHTS;
-  *((socket_descriptor_t*)CMSG_DATA(h)) = SOCKET_UNDEFINED;
+  static const socket_descriptor_t socket_undefined = SOCKET_UNDEFINED;
+  memcpy (CMSG_DATA(h), &socket_undefined, sizeof(socket_undefined));
 
   status = recvmsg (sd_control, &mesg, MSG_NOSIGNAL);
   if (status != -1)
@@ -516,7 +517,8 @@ control_message_from_parent (const socket_descriptor_t sd_control,
 	}
       else
 	{
-	  const socket_descriptor_t received_fd = *((socket_descriptor_t*)CMSG_DATA(h));
+	  socket_descriptor_t received_fd;
+	  memcpy (&received_fd, CMSG_DATA(h), sizeof(received_fd));
 	  dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: RECEIVED sd=%d", (int)received_fd);
 
 	  if (status >= 2 && command == COMMAND_REDIRECT)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 18e6409..1fbb415 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2598,7 +2598,8 @@ setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openv
       if ( IN6_IS_ADDR_V4MAPPED( &addr->addr.in6.sin6_addr ))
 	{
 	  struct in_addr ia;
-	  ia.s_addr = *(in_addr_t *)&addr->addr.in6.sin6_addr.s6_addr[12] ;
+	  memcpy (&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12],
+	      sizeof (ia.s_addr));
 	  openvpn_snprintf (name_buf, sizeof (name_buf), "%s_ip", name_prefix);
 	  openvpn_snprintf (buf, sizeof(buf), "%s", inet_ntoa(ia) );
 	}
-- 
2.7.4


