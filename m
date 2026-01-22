From: Frank Lichtenheld <frank@...2641...>
Date: Thu, 22 Jan 2026 14:30:50 +0100
Message-ID: <20260122133050.117000-1-frank@...2641...>
In-Reply-To: <gerrit.1768911679000.Idbb5c0fff759a2e645a8b4f62266509e32e3a44e@...2715...>
References: <gerrit.1768911679000.Idbb5c0fff759a2e645a8b4f62266509e32e3a44e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] route: Fix conversion warnings on BSDs
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Mostly just use better types. And in
some places remove overloading of
variables with nicer C11 code.

Change-Id: Idbb5c0fff759a2e645a8b4f62266509e32e3a44e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1481
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1481
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index d90c84b..93f61a1 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1762,11 +1762,6 @@
     return (status != RTA_ERROR);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 route_ipv6_clear_host_bits(struct route_ipv6 *r6)
 {
@@ -1833,7 +1828,7 @@
     if (r6->iface != NULL && gateway_needed
         && IN6_IS_ADDR_LINKLOCAL(&r6->gateway)) /* fe80::...%intf */
     {
-        int len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
+        size_t len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp = gc_malloc(len, true, &gc);
         snprintf(tmp, len, "%s%%%s", gateway, r6->iface);
         gateway = tmp;
@@ -2253,7 +2248,7 @@
     if (r6->iface != NULL && gateway_needed
         && IN6_IS_ADDR_LINKLOCAL(&r6->gateway)) /* fe80::...%intf */
     {
-        int len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
+        size_t len = strlen(gateway) + 1 + strlen(r6->iface) + 1;
         char *tmp = gc_malloc(len, true, &gc);
         snprintf(tmp, len, "%s%%%s", gateway, r6->iface);
         gateway = tmp;
@@ -2374,10 +2369,6 @@
     net_ctx_reset(ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * The --redirect-gateway option requires OS-specific code below
  * to get the current default gateway.
@@ -3354,19 +3345,19 @@
 #define NEXTADDR(w, u)        \
     if (rtm_addrs & (w))      \
     {                         \
-        l = sizeof(u);        \
+        size_t l = sizeof(u); \
         memmove(cp, &(u), l); \
         cp += ROUNDUP(l);     \
     }
 
 #define ADVANCE(x, n) (x += ROUNDUP(sizeof(struct sockaddr_in)))
 #else /* if defined(TARGET_SOLARIS) */
-#define NEXTADDR(w, u)                         \
-    if (rtm_addrs & (w))                       \
-    {                                          \
-        l = ((struct sockaddr *)&(u))->sa_len; \
-        memmove(cp, &(u), l);                  \
-        cp += ROUNDUP(l);                      \
+#define NEXTADDR(w, u)                                \
+    if (rtm_addrs & (w))                              \
+    {                                                 \
+        size_t l = ((struct sockaddr *)&(u))->sa_len; \
+        memmove(cp, &(u), l);                         \
+        cp += ROUNDUP(l);                             \
     }
 
 #define ADVANCE(x, n) (x += ROUNDUP((n)->sa_len))
@@ -3374,19 +3365,13 @@
 
 #define max(a, b) ((a) > (b) ? (a) : (b))
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 void
 get_default_gateway(struct route_gateway_info *rgi, in_addr_t dest, openvpn_net_ctx_t *ctx)
 {
     struct gc_arena gc = gc_new();
     struct rtmsg m_rtmsg;
     int sockfd = -1;
-    int seq, l, pid, rtm_addrs;
-    unsigned int i;
+    int rtm_addrs;
     struct sockaddr so_dst, so_mask;
     char *cp = m_rtmsg.m_space;
     struct sockaddr *gate = NULL, *ifp = NULL, *sa;
@@ -3397,8 +3382,8 @@
     CLEAR(*rgi);
 
     /* setup data to send to routing socket */
-    pid = getpid();
-    seq = 0;
+    const int pid = getpid();
+    int seq = 0;
 #ifdef TARGET_OPENBSD
     rtm_addrs = RTA_DST | RTA_NETMASK; /* Kernel refuses RTA_IFP */
 #else
@@ -3415,7 +3400,7 @@
     rtm.rtm_version = RTM_VERSION;
     rtm.rtm_seq = ++seq;
 #ifdef TARGET_OPENBSD
-    rtm.rtm_tableid = getrtable();
+    rtm.rtm_tableid = (u_short)getrtable();
 #endif
     rtm.rtm_addrs = rtm_addrs;
 
@@ -3430,7 +3415,8 @@
     NEXTADDR(RTA_DST, so_dst);
     NEXTADDR(RTA_NETMASK, so_mask);
 
-    rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;
+    /* sizeof(struct rt_msghdr) + padding */
+    rtm.rtm_msglen = (u_short)(cp - (char *)&m_rtmsg);
 
     /* transact with routing socket */
     sockfd = socket(PF_ROUTE, SOCK_RAW, 0);
@@ -3439,24 +3425,25 @@
         msg(M_WARN, "GDG: socket #1 failed");
         goto done;
     }
-    if (write(sockfd, (char *)&m_rtmsg, l) < 0)
+    if (write(sockfd, (char *)&m_rtmsg, rtm.rtm_msglen) < 0)
     {
         msg(M_WARN | M_ERRNO, "GDG: problem writing to routing socket");
         goto done;
     }
+    ssize_t ret;
     do
     {
-        l = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
-    } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
+        ret = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
+    } while (ret > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
     close(sockfd);
     sockfd = -1;
 
     /* extract return data from routing socket */
     rtm_aux = &rtm;
-    cp = ((char *)(rtm_aux + 1));
+    cp = (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
     {
-        for (i = 1; i; i <<= 1)
+        for (unsigned int i = 1; i; i <<= 1)
         {
             if (i & rtm_aux->rtm_addrs)
             {
@@ -3604,8 +3591,7 @@
 {
     struct rtmsg m_rtmsg;
     int sockfd = -1;
-    int seq, l, pid, rtm_addrs;
-    unsigned int i;
+    int rtm_addrs;
     struct sockaddr_in6 so_dst, so_mask;
     char *cp = m_rtmsg.m_space;
     struct sockaddr *gate = NULL, *ifp = NULL, *sa;
@@ -3614,8 +3600,8 @@
     CLEAR(*rgi6);
 
     /* setup data to send to routing socket */
-    pid = getpid();
-    seq = 0;
+    const int pid = getpid();
+    int seq = 0;
 #ifdef TARGET_OPENBSD
     rtm_addrs = RTA_DST | RTA_NETMASK; /* Kernel refuses RTA_IFP */
 #else
@@ -3632,7 +3618,7 @@
     rtm.rtm_version = RTM_VERSION;
     rtm.rtm_seq = ++seq;
 #ifdef TARGET_OPENBSD
-    rtm.rtm_tableid = getrtable();
+    rtm.rtm_tableid = (u_short)getrtable();
 #endif
 
     so_dst.sin6_family = AF_INET6;
@@ -3656,7 +3642,8 @@
     NEXTADDR(RTA_DST, so_dst);
     NEXTADDR(RTA_NETMASK, so_mask);
 
-    rtm.rtm_msglen = l = cp - (char *)&m_rtmsg;
+    /* sizeof(struct rt_msghdr) + padding */
+    rtm.rtm_msglen = (u_short)(cp - (char *)&m_rtmsg);
 
     /* transact with routing socket */
     sockfd = socket(PF_ROUTE, SOCK_RAW, 0);
@@ -3665,26 +3652,26 @@
         msg(M_WARN, "GDG6: socket #1 failed");
         goto done;
     }
-    if (write(sockfd, (char *)&m_rtmsg, l) < 0)
+    if (write(sockfd, (char *)&m_rtmsg, rtm.rtm_msglen) < 0)
     {
         msg(M_WARN | M_ERRNO, "GDG6: problem writing to routing socket");
         goto done;
     }
-
+    ssize_t ret;
     do
     {
-        l = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
-    } while (l > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
+        ret = read(sockfd, (char *)&m_rtmsg, sizeof(m_rtmsg));
+    } while (ret > 0 && (rtm.rtm_seq != seq || rtm.rtm_pid != pid));
 
     close(sockfd);
     sockfd = -1;
 
     /* extract return data from routing socket */
     rtm_aux = &rtm;
-    cp = ((char *)(rtm_aux + 1));
+    cp = (char *)(rtm_aux + 1);
     if (rtm_aux->rtm_addrs)
     {
-        for (i = 1; i; i <<= 1)
+        for (unsigned int i = 1; i; i <<= 1)
         {
             if (i & rtm_aux->rtm_addrs)
             {
@@ -3752,10 +3739,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #undef max
 
 #elif defined(TARGET_HAIKU)

