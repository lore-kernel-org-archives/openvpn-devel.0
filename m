From: Gert Doering <gert@...1296...>
Date: Tue,  7 Oct 2025 14:27:41 +0200
Message-ID: <20251007122747.16064-1-gert@...1296...>
In-Reply-To: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
References: <gerrit.1759763846000.I20205ebd06bbf7cbee8c9be93f399961f5b74fcc@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] sitnl: Clean up type handling
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

- Make some type casts explicit. Due to the types used
  in our networking API and the netlink APIs respectively
  this can't be avoided.
- In many cases just use correct types from the start, e.g.
  where we use constants anyway.

Change-Id: I20205ebd06bbf7cbee8c9be93f399961f5b74fcc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1251
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1251
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <antonio@...2726...>

        
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index 1815faf..b3adb16 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -59,9 +59,9 @@
         _nest;                                          \
     })
 
-#define SITNL_NEST_END(_msg, _nest)                                      \
-    {                                                                    \
-        _nest->rta_len = (void *)sitnl_nlmsg_tail(_msg) - (void *)_nest; \
+#define SITNL_NEST_END(_msg, _nest)                                                        \
+    {                                                                                      \
+        _nest->rta_len = (unsigned short)((void *)sitnl_nlmsg_tail(_msg) - (void *)_nest); \
     }
 
 /* This function was originally implemented as a macro, but compiling with
@@ -131,29 +131,24 @@
     inet_address_t gw;
 };
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Helper function used to easily add attributes to a rtnl message
  */
 static int
-sitnl_addattr(struct nlmsghdr *n, int maxlen, int type, const void *data, int alen)
+sitnl_addattr(struct nlmsghdr *n, size_t maxlen, unsigned short type, const void *data, size_t alen)
 {
-    int len = RTA_LENGTH(alen);
-    struct rtattr *rta;
+    size_t len = RTA_LENGTH(alen);
 
-    if ((int)(NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen)
+    if ((NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(len)) > maxlen)
     {
-        msg(M_WARN, "%s: rtnl: message exceeded bound of %d", __func__, maxlen);
+        msg(M_WARN, "%s: rtnl: message exceeded bound of %zu", __func__, maxlen);
         return -EMSGSIZE;
     }
 
-    rta = sitnl_nlmsg_tail(n);
+    struct rtattr *rta = sitnl_nlmsg_tail(n);
     rta->rta_type = type;
-    rta->rta_len = len;
+    ASSERT(len <= USHRT_MAX);
+    rta->rta_len = (unsigned short)len;
 
     if (!data)
     {
@@ -252,11 +247,10 @@
 sitnl_send(struct nlmsghdr *payload, pid_t peer, unsigned int groups, sitnl_parse_reply_cb cb,
            void *arg_cb)
 {
-    int len, rem_len, fd, ret, rcv_len;
+    int fd, ret;
     struct sockaddr_nl nladdr;
     struct nlmsgerr *err;
     struct nlmsghdr *h;
-    unsigned int seq;
     char buf[1024 * 16];
     struct iovec iov = {
         .iov_base = payload,
@@ -275,7 +269,11 @@
     nladdr.nl_pid = peer;
     nladdr.nl_groups = groups;
 
-    payload->nlmsg_seq = seq = time(NULL);
+    /* NB: We currently do not verify seq and pid on answers.
+     * If we ever want to start with that we probably need to come up
+     * with something better than "seconds since epoch"...
+     */
+    payload->nlmsg_seq = (uint32_t)time(NULL);
 
     /* no need to send reply */
     if (!cb)
@@ -290,16 +288,14 @@
         return -errno;
     }
 
-    ret = sitnl_bind(fd, 0);
-    if (ret < 0)
+    if (sitnl_bind(fd, 0) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: can't bind rtnl socket", __func__);
         ret = -errno;
         goto out;
     }
 
-    ret = sendmsg(fd, &nlmsg, 0);
-    if (ret < 0)
+    if (sendmsg(fd, &nlmsg, 0) < 0)
     {
         msg(M_WARN | M_ERRNO, "%s: rtnl: error on sendmsg()", __func__);
         ret = -errno;
@@ -318,8 +314,8 @@
          */
         msg(D_RTNL, "%s: checking for received messages", __func__);
         iov.iov_len = sizeof(buf);
-        rcv_len = recvmsg(fd, &nlmsg, 0);
-        msg(D_RTNL, "%s: rtnl: received %d bytes", __func__, rcv_len);
+        ssize_t rcv_len = recvmsg(fd, &nlmsg, 0);
+        msg(D_RTNL, "%s: rtnl: received %zd bytes", __func__, rcv_len);
         if (rcv_len < 0)
         {
             if ((errno == EINTR) || (errno == EAGAIN))
@@ -350,8 +346,8 @@
         h = (struct nlmsghdr *)buf;
         while (rcv_len >= (int)sizeof(*h))
         {
-            len = h->nlmsg_len;
-            rem_len = len - sizeof(*h);
+            uint32_t len = h->nlmsg_len;
+            ssize_t rem_len = len - sizeof(*h);
 
             if ((rem_len < 0) || (len > rcv_len))
             {
@@ -361,7 +357,7 @@
                     ret = -EIO;
                     goto out;
                 }
-                msg(M_WARN, "%s: malformed message: len=%d", __func__, len);
+                msg(M_WARN, "%s: malformed message: len=%u", __func__, len);
                 ret = -EIO;
                 goto out;
             }
@@ -388,7 +384,7 @@
             if (h->nlmsg_type == NLMSG_ERROR)
             {
                 err = (struct nlmsgerr *)NLMSG_DATA(h);
-                if (rem_len < (int)sizeof(struct nlmsgerr))
+                if (rem_len < sizeof(struct nlmsgerr))
                 {
                     msg(M_WARN, "%s: ERROR truncated", __func__);
                     ret = -EIO;
@@ -443,7 +439,7 @@
 
         if (rcv_len)
         {
-            msg(M_WARN, "%s: rtnl: %d not parsed bytes", __func__, rcv_len);
+            msg(M_WARN, "%s: rtnl: %zd not parsed bytes", __func__, rcv_len);
             ret = -1;
             goto out;
         }
@@ -456,7 +452,7 @@
 
 typedef struct
 {
-    int addr_size;
+    size_t addr_size;
     inet_address_t gw;
     char iface[IFNAMSIZ];
     bool default_only;
@@ -469,7 +465,7 @@
     route_res_t *res = arg;
     struct rtmsg *r = NLMSG_DATA(n);
     struct rtattr *rta = RTM_RTA(r);
-    int len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
+    size_t len = n->nlmsg_len - NLMSG_LENGTH(sizeof(*r));
     unsigned int table, ifindex = 0;
     void *gw = NULL;
 
@@ -547,7 +543,8 @@
     req.n.nlmsg_type = RTM_GETROUTE;
     req.n.nlmsg_flags = NLM_F_REQUEST;
 
-    req.r.rtm_family = af_family;
+    ASSERT(af_family <= UCHAR_MAX);
+    req.r.rtm_family = (unsigned char)af_family;
 
     switch (af_family)
     {
@@ -761,7 +758,7 @@
 }
 
 static int
-sitnl_addr_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family,
+sitnl_addr_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family,
                const inet_address_t *local, const inet_address_t *remote, int prefixlen)
 {
     struct sitnl_addr_req req;
@@ -775,7 +772,8 @@
     req.n.nlmsg_flags = NLM_F_REQUEST | flags;
 
     req.i.ifa_index = ifindex;
-    req.i.ifa_family = af_family;
+    ASSERT(af_family <= UINT8_MAX);
+    req.i.ifa_family = (uint8_t)af_family;
 
     switch (af_family)
     {
@@ -797,7 +795,8 @@
     {
         prefixlen = size * 8;
     }
-    req.i.ifa_prefixlen = prefixlen;
+    ASSERT(prefixlen <= UINT8_MAX);
+    req.i.ifa_prefixlen = (uint8_t)prefixlen;
 
     if (remote)
     {
@@ -890,9 +889,9 @@
 }
 
 static int
-sitnl_route_set(int cmd, uint32_t flags, int ifindex, sa_family_t af_family, const void *dst,
+sitnl_route_set(uint16_t cmd, uint16_t flags, int ifindex, sa_family_t af_family, const void *dst,
                 int prefixlen, const void *gw, enum rt_class_t table, int metric,
-                enum rt_scope_t scope, int protocol, int type)
+                enum rt_scope_t scope, unsigned char protocol, unsigned char type)
 {
     struct sitnl_route_req req;
     int ret = -1, size;
@@ -917,15 +916,17 @@
     req.n.nlmsg_type = cmd;
     req.n.nlmsg_flags = NLM_F_REQUEST | flags;
 
-    req.r.rtm_family = af_family;
-    req.r.rtm_scope = scope;
+    ASSERT(af_family <= UCHAR_MAX);
+    req.r.rtm_family = (unsigned char)af_family;
+    req.r.rtm_scope = (unsigned char)scope;
     req.r.rtm_protocol = protocol;
     req.r.rtm_type = type;
-    req.r.rtm_dst_len = prefixlen;
+    ASSERT(prefixlen >= 0 && prefixlen <= UCHAR_MAX);
+    req.r.rtm_dst_len = (unsigned char)prefixlen;
 
-    if (table < 256)
+    if (table <= UCHAR_MAX)
     {
-        req.r.rtm_table = table;
+        req.r.rtm_table = (unsigned char)table;
     }
     else
     {
@@ -1348,7 +1349,7 @@
 }
 
 static int
-sitnl_parse_rtattr_flags(struct rtattr *tb[], int max, struct rtattr *rta, int len,
+sitnl_parse_rtattr_flags(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len,
                          unsigned short flags)
 {
     unsigned short type;
@@ -1369,14 +1370,14 @@
 
     if (len)
     {
-        msg(D_ROUTE, "%s: %d bytes not parsed! (rta_len=%d)", __func__, len, rta->rta_len);
+        msg(D_ROUTE, "%s: %zu bytes not parsed! (rta_len=%u)", __func__, len, rta->rta_len);
     }
 
     return 0;
 }
 
 static int
-sitnl_parse_rtattr(struct rtattr *tb[], int max, struct rtattr *rta, int len)
+sitnl_parse_rtattr(struct rtattr *tb[], size_t max, struct rtattr *rta, size_t len)
 {
     return sitnl_parse_rtattr_flags(tb, max, rta, len, 0);
 }
@@ -1474,10 +1475,6 @@
     return sitnl_send(&req.n, 0, 0, NULL, NULL);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* !ENABLE_SITNL */
 
 #endif /* TARGET_LINUX */

