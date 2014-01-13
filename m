From: Gert Doering <gert@...1296...>
Date: Mon, 13 Jan 2014 22:54:34 +0100
Message-Id: <1389650074-18455-2-git-send-email-gert@...1296...>
In-Reply-To: <1389650074-18455-1-git-send-email-gert@...1296...>
References: <20140113185822.GV226@...1296...>
	<1389650074-18455-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH 2/2] Replace copied structure elements with
	including <net/route.h>
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

The code for FreeBSD, Dragonfly, OpenBSD and NetBSD contained copies
of structures from <net/route.h> (struct rt_msghdr in particular).

OpenBSD changed some structure elements, making OpenVPN incompatible,
depending on the specific OpenBSD version.  Clean up: remove copied
definitions, replace by including <net/route.h> directly - this could
not be done originally due to a conflict with "struct route" in OpenVPN
and <net/route.h>, cleaned up by the previous commit.

Tested on FreeBSD 9.1-RELEASE, NetBSD 5.1, OpenBSD 4.9 (route.c compiles
with no warnings, and "openvpn --show-gateway" works, which is the only
part of the code that uses the structures in question).

Fix trac #340

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 95 ++---------------------------------------------------
 1 file changed, 2 insertions(+), 93 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d6344b9..d397f11 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2611,53 +2611,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
-
-/* all of this is taken from <net/route.h> in FreeBSD */
-#define RTA_DST     0x1
-#define RTA_GATEWAY 0x2
-#define RTA_NETMASK 0x4
-
-#define RTM_GET     0x4
-#define RTM_VERSION 5
-
-#define RTF_UP      0x1
-#define RTF_GATEWAY 0x2
-
-/*
- * These numbers are used by reliable protocols for determining
- * retransmission behavior and are included in the routing structure.
- */
-struct rt_metrics {
-        u_long  rmx_locks;      /* Kernel must leave these values alone */
-        u_long  rmx_mtu;        /* MTU for this path */
-        u_long  rmx_hopcount;   /* max hops expected */
-        u_long  rmx_expire;     /* lifetime for route, e.g. redirect */
-        u_long  rmx_recvpipe;   /* inbound delay-bandwidth product */
-        u_long  rmx_sendpipe;   /* outbound delay-bandwidth product */
-        u_long  rmx_ssthresh;   /* outbound gateway buffer limit */
-        u_long  rmx_rtt;        /* estimated round trip time */
-        u_long  rmx_rttvar;     /* estimated rtt variance */
-        u_long  rmx_pksent;     /* packets sent using this route */
-        u_long  rmx_filler[4];  /* will be used for T/TCP later */
-};
-
-/*
- * Structures for routing messages.
- */
-struct rt_msghdr {
-        u_short rtm_msglen;     /* to skip over non-understood messages */
-        u_char  rtm_version;    /* future binary compatibility */
-        u_char  rtm_type;       /* message type */
-        u_short rtm_index;      /* index for associated ifp */
-        int     rtm_flags;      /* flags, incl. kern & message, e.g. DONE */
-        int     rtm_addrs;      /* bitmask identifying sockaddrs in msg */
-        pid_t   rtm_pid;        /* identify sender */
-        int     rtm_seq;        /* for sender to identify action */
-        int     rtm_errno;      /* why failed */
-        int     rtm_use;        /* from rtentry */
-        u_long  rtm_inits;      /* which metrics we are initializing */
-        struct  rt_metrics rtm_rmx; /* metrics themselves */
-};
+#include <net/route.h>
 
 struct {
   struct rt_msghdr m_rtm;
@@ -2976,52 +2930,7 @@ get_default_gateway (struct route_gateway_info *rgi)
 #include <sys/types.h>
 #include <sys/socket.h>
 #include <netinet/in.h>
-
-/* all of this is taken from <net/route.h> in OpenBSD 3.6 */
-#define RTA_DST		0x1	/* destination sockaddr present */
-#define RTA_GATEWAY	0x2	/* gateway sockaddr present */
-#define RTA_NETMASK	0x4	/* netmask sockaddr present */
-
-#define RTM_GET		0x4	/* Report Metrics */
-
-#define RTM_VERSION	3	/* Up the ante and ignore older versions */
-
-#define	RTF_UP		0x1		/* route usable */
-#define	RTF_GATEWAY	0x2		/* destination is a gateway */
-
-/*
- * Huge version for userland compatibility.
- */
-struct rt_metrics {
-	u_long	rmx_locks;	/* Kernel must leave these values alone */
-	u_long	rmx_mtu;	/* MTU for this path */
-	u_long	rmx_hopcount;	/* max hops expected */
-	u_long	rmx_expire;	/* lifetime for route, e.g. redirect */
-	u_long	rmx_recvpipe;	/* inbound delay-bandwidth product */
-	u_long	rmx_sendpipe;	/* outbound delay-bandwidth product */
-	u_long	rmx_ssthresh;	/* outbound gateway buffer limit */
-	u_long	rmx_rtt;	/* estimated round trip time */
-	u_long	rmx_rttvar;	/* estimated rtt variance */
-	u_long	rmx_pksent;	/* packets sent using this route */
-};
-
-/*
- * Structures for routing messages.
- */
-struct rt_msghdr {
-	u_short	rtm_msglen;	/* to skip over non-understood messages */
-	u_char	rtm_version;	/* future binary compatibility */
-	u_char	rtm_type;	/* message type */
-	u_short	rtm_index;	/* index for associated ifp */
-	int	rtm_flags;	/* flags, incl. kern & message, e.g. DONE */
-	int	rtm_addrs;	/* bitmask identifying sockaddrs in msg */
-	pid_t	rtm_pid;	/* identify sender */
-	int	rtm_seq;	/* for sender to identify action */
-	int	rtm_errno;	/* why failed */
-	int	rtm_use;	/* from rtentry */
-	u_long	rtm_inits;	/* which metrics we are initializing */
-	struct	rt_metrics rtm_rmx; /* metrics themselves */
-};
+#include <net/route.h>
 
 struct {
   struct rt_msghdr m_rtm;
-- 
1.8.3.2


