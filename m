From: Juan Rodriguez Hervella <jrh@...176...>
Subject: Re: [Openvpn-devel] --redirect-gateway on FreeBSD
References: <twig.1078498926.20189@...41...>
In-Reply-To: <twig.1078498926.20189@...41...>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_RIGTAVbF5Fq7AbS"
Message-Id: <200403081307.49002.jrh@...176...>
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
Date: Mon Mar  8 04:17:12 2004
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net

--Boundary-00=_RIGTAVbF5Fq7AbS
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello!

I attach the patches. I've tested it and I think it's 
working fine.

If something goes wrong, just tell me and i will
be glad to fix it up.

Seeyou!

On Friday 05 March 2004 16:02, James Yonan wrote:
> Juan Rodriguez Hervella <jrh@...176...> said:
> > Hello,
> >
> > I've just subscribed to this list, but I've read on the
> > archives that the --redirect-gateway function is not
> > working yet on FreeBSD because of the problem of
> > retreiving the address of the default gateway.
> >
> > I've just written a small program which makes that,
> > looking at /usr/src/sbin/route.c
> >
> > Hope this helps, I've tested it on both FreeBSD-4.9
> > and FreeBSD-5.2
> >
> > It uses PF_ROUTE sockets.
> >
> > hope this helps!
> > --
> > ******
> > JFRH
> > ******
> >
> > Go climb a gravity well!
>
> Juan,
>
> It would be ideal if you could code this into OpenVPN's route.c, following
> the form of the other platforms, i.e.:
>
> ..
>
> #elif defined(TARGET_FREEBSD)
>
> static bool
> get_default_gateway (in_addr_t *ret)
> {
>   /* code me -- put gateway address into *ret */
> }
>
> #else
>
> ..
>
> James

-- 
******
JFRH
******

Paul's Law:
	In America, it's not how much an item costs, it's how much you
save.

--Boundary-00=_RIGTAVbF5Fq7AbS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="route.c_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="route.c_patch"

*** route.c_1.6rc1	Fri Mar  5 18:38:51 2004
--- route.c	Mon Mar  8 12:50:18 2004
***************
*** 45,50 ****
--- 45,62 ----
  
  #include "memdbg.h"
  
+ #if defined(TARGET_FREEBSD)
+ #include <sys/types.h>
+ #include <sys/socket.h>
+ #include <netinet/in.h>
+ 
+ struct {
+   struct rt_msghdr m_rtm;
+   char       m_space[512];
+ } m_rtmsg;
+ 
+ #endif
+ 
  static void add_route (struct route *r);
  static void delete_route (const struct route *r);
  static bool get_default_gateway (in_addr_t *ret);
***************
*** 810,815 ****
--- 822,917 ----
      }
    return false;
  }
+ 
+ #elif defined(TARGET_FREEBSD)
+ 
+ #define ROUNDUP(a) \
+         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
+ 
+ static bool
+ get_default_gateway (in_addr_t *ret)
+ {
+   int s, seq, l, pid, rtm_addrs, i;
+   struct sockaddr so_dst, so_mask;
+   char *cp = m_rtmsg.m_space; 
+   struct sockaddr *gate = NULL, *sa;
+   struct  rt_msghdr *rtm_aux;
+ 
+ #define NEXTADDR(w, u) \
+         if (rtm_addrs & (w)) {\
+             l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
+         }
+ 
+ #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
+ 
+ #define rtm m_rtmsg.m_rtm
+ 
+   pid = getpid();
+   seq = 0;
+   rtm_addrs = RTA_DST | RTA_NETMASK;
+ 
+   bzero(&so_dst, sizeof(so_dst));
+   bzero(&so_mask, sizeof(so_mask));
+   bzero(&rtm, sizeof(struct rt_msghdr));
+ 
+   rtm.rtm_type = RTM_GET;
+   rtm.rtm_flags = RTF_UP | RTF_GATEWAY;
+   rtm.rtm_version = RTM_VERSION;
+   rtm.rtm_seq = ++seq;
+   rtm.rtm_addrs = rtm_addrs; 
+ 
+   so_dst.sa_family = AF_INET;
+   so_dst.sa_len = sizeof(struct sockaddr_in);
+   so_mask.sa_family = AF_INET;
+   so_mask.sa_len = sizeof(struct sockaddr_in);
+ 
+   NEXTADDR(RTA_DST, so_dst);
+   NEXTADDR(RTA_NETMASK, so_mask);
+ 
+   rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;
+ 
+   s = socket(PF_ROUTE, SOCK_RAW, 0);
+ 
+   if (write(s, (char *)&m_rtmsg, l) < 0) {
+                 warn("writing to routing socket");
+                 return false;
+   }
+ 
+   do {
+         l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
+   } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
+                         
+ 
+   rtm_aux = &rtm;
+ 
+   cp = ((char *)(rtm_aux + 1));
+   if (rtm_aux->rtm_addrs) {
+         for (i = 1; i; i <<= 1)
+              if (i & rtm_aux->rtm_addrs) {
+                    sa = (struct sockaddr *)cp;
+ 		   if( i == RTA_GATEWAY )
+                       gate = sa;
+                    ADVANCE(cp, sa);
+ 	     }
+   }
+   else
+ 	return false;
+ 
+ 
+   if( gate != NULL )
+   {
+ 	*ret = ntohl(((struct sockaddr_in *)gate)->sin_addr.s_addr);
+ #if 1
+         msg (M_INFO, "gw %s",
+                  print_in_addr_t ((in_addr_t) *ret, false));
+ #endif
+ 
+ 	return true;
+   }
+   else
+ 	return false;
+ }
+ 
  
  #else
  

--Boundary-00=_RIGTAVbF5Fq7AbS
Content-Type: text/x-diff;
  charset="iso-8859-1";
  name="route.h_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="route.h_patch"

*** route.h_1.6rc1	Mon Mar  8 12:57:47 2004
--- route.h	Fri Mar  5 18:38:37 2004
***************
*** 32,37 ****
--- 32,90 ----
  
  #define MAX_ROUTES 50
  
+ #if defined(TARGET_FREEBSD)
+ 
+ /* all of this is taken from <net/route.h> in FreeBSD */
+ #define RTA_DST     0x1
+ #define RTA_GATEWAY 0x2
+ #define RTA_NETMASK 0x4
+ 
+ #define RTM_GET     0x4
+ #define RTM_VERSION 5
+ 
+ #define RTF_UP      0x1
+ #define RTF_GATEWAY 0x2
+ 
+ /*
+  * These numbers are used by reliable protocols for determining
+  * retransmission behavior and are included in the routing structure.
+  */
+ struct rt_metrics {
+         u_long  rmx_locks;      /* Kernel must leave these values alone */
+         u_long  rmx_mtu;        /* MTU for this path */
+         u_long  rmx_hopcount;   /* max hops expected */
+         u_long  rmx_expire;     /* lifetime for route, e.g. redirect */
+         u_long  rmx_recvpipe;   /* inbound delay-bandwidth product */
+         u_long  rmx_sendpipe;   /* outbound delay-bandwidth product */
+         u_long  rmx_ssthresh;   /* outbound gateway buffer limit */
+         u_long  rmx_rtt;        /* estimated round trip time */
+         u_long  rmx_rttvar;     /* estimated rtt variance */
+         u_long  rmx_pksent;     /* packets sent using this route */
+         u_long  rmx_filler[4];  /* will be used for T/TCP later */
+ };
+ 
+ 
+ /*
+  * Structures for routing messages.
+  */
+ struct rt_msghdr {
+         u_short rtm_msglen;     /* to skip over non-understood messages */
+         u_char  rtm_version;    /* future binary compatibility */
+         u_char  rtm_type;       /* message type */
+         u_short rtm_index;      /* index for associated ifp */
+         int     rtm_flags;      /* flags, incl. kern & message, e.g. DONE */
+         int     rtm_addrs;      /* bitmask identifying sockaddrs in msg */
+         pid_t   rtm_pid;        /* identify sender */
+         int     rtm_seq;        /* for sender to identify action */
+         int     rtm_errno;      /* why failed */
+         int     rtm_use;        /* from rtentry */
+         u_long  rtm_inits;      /* which metrics we are initializing */
+         struct  rt_metrics rtm_rmx; /* metrics themselves */
+ };
+ 
+ #endif
+ 
+ 
  struct route_special_addr
  {
    in_addr_t remote_endpoint;

--Boundary-00=_RIGTAVbF5Fq7AbS--

