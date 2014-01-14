From: Gert Doering <gert@...1296...>
Date: Tue, 14 Jan 2014 14:33:18 +0100
Message-Id: <1389706398-26922-1-git-send-email-gert@...1296...>
In-Reply-To: <20140113185822.GV226@...1296...>
References: <20140113185822.GV226@...1296...>
Subject: [Openvpn-devel] [PATCH 3/2] Merge get_default_gateway()
	implementation for all 4+1 BSD variants.
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

This was 3 times mostly the same code, with the 4 traditional BSDs
only differing in a single line, while MacOS X had more refined code
to do not only gateway determination, but also netmask, interface name
and MAC address.

The MacOS X code works perfectly well on the other BSDs *if* one macro
is #ifdef'ed to use "(uint32_t)" on MacOS X and "(long)" on all other
BSDs, 32 and 64 bit variants.  API change by OSX when going to 64bit.

Tested on FreeBSD 8.3/i386, FreeBSD 9.1/amd64, NetbSD 5.1/amd64,
OpenBSD 4.9/i386, OpenBSD 5.4/amd64 (= all affected platforms except
DragonFly BSD).

See also trac#42 and trac#340.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/route.c | 246 +++++-----------------------------------------------
 1 file changed, 21 insertions(+), 225 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d397f11..25c81b9 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2606,118 +2606,9 @@ get_default_gateway (struct route_gateway_info *rgi)
   gc_free (&gc);
 }
 
-#elif defined(TARGET_FREEBSD)||defined(TARGET_DRAGONFLY)
-
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <net/route.h>
-
-struct {
-  struct rt_msghdr m_rtm;
-  char       m_space[512];
-} m_rtmsg;
-
-#define ROUNDUP(a) \
-        ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
-
-/*
- * FIXME -- add support for netmask, hwaddr, and iface
- */
-void
-get_default_gateway (struct route_gateway_info *rgi)
-{
-  struct gc_arena gc = gc_new ();
-  int s, seq, l, pid, rtm_addrs, i;
-  struct sockaddr so_dst, so_mask;
-  char *cp = m_rtmsg.m_space; 
-  struct sockaddr *gate = NULL, *sa;
-  struct  rt_msghdr *rtm_aux;
-
-#define NEXTADDR(w, u) \
-        if (rtm_addrs & (w)) {\
-            l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
-        }
-
-#define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
-
-#define rtm m_rtmsg.m_rtm
-
-  CLEAR(*rgi);
-
-  pid = getpid();
-  seq = 0;
-  rtm_addrs = RTA_DST | RTA_NETMASK;
-
-  bzero(&so_dst, sizeof(so_dst));
-  bzero(&so_mask, sizeof(so_mask));
-  bzero(&rtm, sizeof(struct rt_msghdr));
-
-  rtm.rtm_type = RTM_GET;
-  rtm.rtm_flags = RTF_UP | RTF_GATEWAY;
-  rtm.rtm_version = RTM_VERSION;
-  rtm.rtm_seq = ++seq;
-  rtm.rtm_addrs = rtm_addrs; 
-
-  so_dst.sa_family = AF_INET;
-  so_dst.sa_len = sizeof(struct sockaddr_in);
-  so_mask.sa_family = AF_INET;
-  so_mask.sa_len = sizeof(struct sockaddr_in);
-
-  NEXTADDR(RTA_DST, so_dst);
-  NEXTADDR(RTA_NETMASK, so_mask);
-
-  rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;
-
-  s = socket(PF_ROUTE, SOCK_RAW, 0);
-
-  if (write(s, (char *)&m_rtmsg, l) < 0)
-    {
-      msg(M_WARN|M_ERRNO, "Could not retrieve default gateway from route socket:");
-      gc_free (&gc);
-      close(s);
-      return;
-    }
-
-  do {
-    l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
-  } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
-                        
-  close(s);
-
-  rtm_aux = &rtm;
-
-  cp = ((char *)(rtm_aux + 1));
-  if (rtm_aux->rtm_addrs) {
-    for (i = 1; i; i <<= 1)
-      if (i & rtm_aux->rtm_addrs) {
-	sa = (struct sockaddr *)cp;
-	if (i == RTA_GATEWAY )
-	  gate = sa;
-	ADVANCE(cp, sa);
-      }
-  }
-  else
-    {
-      gc_free (&gc);
-      return;
-    }
-
-
-  if (gate != NULL )
-    {
-      rgi->gateway.addr = ntohl(((struct sockaddr_in *)gate)->sin_addr.s_addr);
-      rgi->flags |= RGI_ADDR_DEFINED;
-
-      gc_free (&gc);
-    }
-  else
-    {
-      gc_free (&gc);
-    }
-}
-
-#elif defined(TARGET_DARWIN)
+#elif defined(TARGET_DARWIN) || \
+	defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || \
+	defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
 
 #include <sys/types.h>
 #include <sys/socket.h>
@@ -2730,8 +2621,25 @@ struct rtmsg {
   char       m_space[512];
 };
 
-#define ROUNDUP(a) \
+/* the route socket code is identical for all 4 supported BSDs and for
+ * MacOS X (Darwin), with one crucial difference: when going from
+ * 32 bit to 64 bit, the BSDs increased the structure size but kept
+ * source code compatibility by keeping the use of "long", while
+ * MacOS X decided to keep binary compatibility by *changing* the API
+ * to use "uint32_t", thus 32 bit on all OS X variants
+ *
+ * We used to have a large amount of duplicate code here which really
+ * differed only in this (long) vs. (uint32_t) - IMHO, worse than
+ * having a combined block for all BSDs with this single #ifdef inside
+ */
+
+#if defined(TARGET_DARWIN)
+# define ROUNDUP(a) \
         ((a) > 0 ? (1 + (((a) - 1) | (sizeof(uint32_t) - 1))) : sizeof(uint32_t))
+#else
+# define ROUNDUP(a) \
+        ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
+#endif
 
 #define NEXTADDR(w, u) \
         if (rtm_addrs & (w)) {\
@@ -2925,118 +2833,6 @@ get_default_gateway (struct route_gateway_info *rgi)
 
 #undef max
 
-#elif defined(TARGET_OPENBSD) || defined(TARGET_NETBSD)
-
-#include <sys/types.h>
-#include <sys/socket.h>
-#include <netinet/in.h>
-#include <net/route.h>
-
-struct {
-  struct rt_msghdr m_rtm;
-  char       m_space[512];
-} m_rtmsg;
-
-#define ROUNDUP(a) \
-        ((a) > 0 ? (1 + (((a) - 1) | (sizeof(long) - 1))) : sizeof(long))
-
-/*
- * FIXME -- add support for netmask, hwaddr, and iface
- */
-void
-get_default_gateway (struct route_gateway_info *rgi)
-{
-  struct gc_arena gc = gc_new ();
-  int s, seq, l, rtm_addrs, i;
-  pid_t pid;
-  struct sockaddr so_dst, so_mask;
-  char *cp = m_rtmsg.m_space; 
-  struct sockaddr *gate = NULL, *sa;
-  struct  rt_msghdr *rtm_aux;
-
-#define NEXTADDR(w, u) \
-        if (rtm_addrs & (w)) {\
-            l = ROUNDUP(u.sa_len); memmove(cp, &(u), l); cp += l;\
-        }
-
-#define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
-
-#define rtm m_rtmsg.m_rtm
-
-  CLEAR(*rgi);
-
-  pid = getpid();
-  seq = 0;
-  rtm_addrs = RTA_DST | RTA_NETMASK;
-
-  bzero(&so_dst, sizeof(so_dst));
-  bzero(&so_mask, sizeof(so_mask));
-  bzero(&rtm, sizeof(struct rt_msghdr));
-
-  rtm.rtm_type = RTM_GET;
-  rtm.rtm_flags = RTF_UP | RTF_GATEWAY;
-  rtm.rtm_version = RTM_VERSION;
-  rtm.rtm_seq = ++seq;
-  rtm.rtm_addrs = rtm_addrs; 
-
-  so_dst.sa_family = AF_INET;
-  so_dst.sa_len = sizeof(struct sockaddr_in);
-  so_mask.sa_family = AF_INET;
-  so_mask.sa_len = sizeof(struct sockaddr_in);
-
-  NEXTADDR(RTA_DST, so_dst);
-  NEXTADDR(RTA_NETMASK, so_mask);
-
-  rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;
-
-  s = socket(PF_ROUTE, SOCK_RAW, 0);
-
-  if (write(s, (char *)&m_rtmsg, l) < 0)
-    {
-      msg(M_WARN|M_ERRNO, "Could not retrieve default gateway from route socket:");
-      gc_free (&gc);
-      close(s);
-      return;
-    }
-
-  do {
-    l = read(s, (char *)&m_rtmsg, sizeof(m_rtmsg));
-  } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
-                        
-  close(s);
-
-  rtm_aux = &rtm;
-
-  cp = ((char *)(rtm_aux + 1));
-  if (rtm_aux->rtm_addrs) {
-    for (i = 1; i; i <<= 1)
-      if (i & rtm_aux->rtm_addrs) {
-	sa = (struct sockaddr *)cp;
-	if (i == RTA_GATEWAY )
-	  gate = sa;
-	ADVANCE(cp, sa);
-      }
-  }
-  else
-    {
-      gc_free (&gc);
-      return;
-    }
-
-
-  if (gate != NULL )
-    {
-      rgi->gateway.addr = ntohl(((struct sockaddr_in *)gate)->sin_addr.s_addr);
-      rgi->flags |= RGI_ADDR_DEFINED;
-
-      gc_free (&gc);
-    }
-  else
-    {
-      gc_free (&gc);
-    }
-}
-
 #else
 
 /*
-- 
1.8.3.2


