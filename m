Message-ID: <4C0DE1E9.4090300@...360...>
Date: Tue, 08 Jun 2010 08:23:37 +0200
From: reg9009 <reg9009@...360...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060507030901030602010607"
Subject: [Openvpn-devel] Dynamic Routing Patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------060507030901030602010607
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit

  Hi all,

here's the 2nd and hopefully cleaner version of the dynamic routing patch.

Regards,
Sebastian

--------------060507030901030602010607
Content-Type: text/plain;
 name="0001-First-test-with-dynamic-routing.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="0001-First-test-with-dynamic-routing.patch"

From a122b9cfc5962e6fc3591e57a59599381a6d278c Mon Sep 17 00:00:00 2001
From: shundertmark <hundertmark@...1377...>
Date: Mon, 7 Jun 2010 13:58:38 +0200
Subject: [PATCH] First test with 'dynamic routing'

Signed-off-by: shundertmark <hundertmark@...1377...>
---
 Makefile.am  |    4 +
 configure.ac |   12 +++
 dynroute.c   |  285 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 dynroute.h   |   24 +++++
 multi.c      |   10 ++
 5 files changed, 335 insertions(+), 0 deletions(-)
 create mode 100644 dynroute.c
 create mode 100644 dynroute.h

diff --git a/Makefile.am b/Makefile.am
index 2980dac..84e10d9 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -152,3 +152,7 @@ openvpn.8.html: $(srcdir)/openvpn.8
 else
 dist_man_MANS = openvpn.8
 endif
+
+if ENABLE_DYNROUTE
+	openvpn_SOURCES += dynroute.c
+endif
diff --git a/configure.ac b/configure.ac
index 5575705..c7da5ff 100644
--- a/configure.ac
+++ b/configure.ac
@@ -212,6 +212,12 @@ AC_ARG_ENABLE(selinux,
    [SELINUX="yes"]
 )
 
+AC_ARG_ENABLE(dynroute,
+   [  --enable-dynroute       Enable dynamic routing],
+   [DYNROUTE="$enableval"],
+   [DYNROUTE="no"]
+)
+
 AC_ARG_WITH(ssl-headers,
    [  --with-ssl-headers=DIR  Crypto/SSL Include files location],
    [CS_HDR_DIR="$withval"]
@@ -869,6 +875,12 @@ if test "$PASSWORD_SAVE" = "yes"; then
    AC_DEFINE(ENABLE_PASSWORD_SAVE, 1, [Allow --askpass and --auth-user-pass passwords to be read from a file])
 fi
 
+dnl enable dynroute
+if test "$DYNROUTE" = "yes"; then
+   AC_DEFINE(ENABLE_DYNROUTE, 1, [Enable dynamic routing])
+fi
+AM_CONDITIONAL(ENABLE_DYNROUTE, test "${DYNROUTE}" = "yes")
+
 dnl
 dnl check for SELinux library and headers
 dnl
diff --git a/dynroute.c b/dynroute.c
new file mode 100644
index 0000000..f9a3ca8
--- /dev/null
+++ b/dynroute.c
@@ -0,0 +1,285 @@
+#include "dynroute.h"
+
+struct dynroute dr;
+
+static struct multi_instance *
+multi_learn_in_addr_t (struct multi_context *m,
+           struct multi_instance *mi,
+           in_addr_t a,
+           int netbits, /* -1 if host route, otherwise # of network bits in address */
+           bool primary);
+
+static void netlink_parse_rtattr (struct rtattr **tb, int max, struct rtattr *rta, int len)
+{
+  while (RTA_OK (rta, len))
+  {
+    if (rta->rta_type <= max)
+      tb[rta->rta_type] = rta;
+    rta = RTA_NEXT (rta, len);
+  }
+}
+
+static uint32_t endian_swap (uint32_t x)
+{
+  x = (x>>24) | 
+    ((x<<8) & 0x00FF0000) |
+    ((x>>8) & 0x0000FF00) |
+    (x<<24);
+  return x;
+}
+
+static bool dynroute_init (struct dynroute *dr)
+{
+  if (!dr->initialized)
+  {
+    dr->last_error = 0;
+    dr->action = DRA_NONE;
+    dr->initialized = false;
+    dr->nope = true;
+    dr->sock = socket (AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
+    if (dr->sock < 0)
+    {
+#ifdef DYNROUTE_DEBUG
+      dr->last_error = dr->sock;
+      fprintf (stderr, "dynroute_init: ERROR socket() : %d\n", dr->last_error);
+#endif
+      return false;
+    }
+    struct sockaddr_nl addr;
+    memset ((void *) &addr, 0, sizeof (addr));
+    addr.nl_family = AF_NETLINK;
+    addr.nl_pid = getpid ();
+    addr.nl_groups = RTMGRP_IPV4_ROUTE;
+    dr->last_error = bind (dr->sock, (struct sockaddr *) &addr, sizeof (addr));
+    if (dr->last_error < 0)
+    {
+#ifdef DYNROUTE_DEBUG
+      fprintf (stderr, "dynroute_init: ERROR bind() : %d\n", dr->last_error);
+#endif
+      return false;
+    }
+    dr->last_error = fcntl (dr->sock, F_SETFL, O_NONBLOCK);
+    if (dr->last_error < 0)
+    {
+#ifdef DYNROUTE_DEBUG
+      fprintf (stderr, "dynroute_init: ERROR fcntl() : %d\n", dr->last_error);
+#endif
+      return false;
+    }
+#ifdef DYNROUTE_DEBUG
+    fprintf (stderr, "dynroute_init: OK\n");
+#endif
+    dr->initialized = true;
+  }
+#ifdef DYNROUTE_DEBUG
+  else
+  {
+    fprintf (stderr, "dynroute_init: allready initialised, skipped.\n");
+  }
+#endif
+  dr->nope = !dr->initialized;
+  return dr->initialized;
+}
+
+static bool dynroute_read (struct dynroute *dr)
+{
+  dr->action = DRA_NONE;
+  if (!dr->initialized)
+  {
+#ifdef DYNROUTE_DEBUG
+    fprintf (stderr, "dynroute_read: not ready, trying dynroute_init().\n");
+#endif
+    if (!dynroute_init (dr))
+      return false;
+  }
+    
+  struct nlmsghdr *nlh;
+  struct rtmsg *rtm;
+  struct sockaddr_nl addr;
+  struct rtattr *tb[RTA_MAX + 1];
+  
+  char buf [4096];
+  struct iovec iov = { buf, sizeof (buf) };
+  struct msghdr msg;
+  int len;
+
+  msg.msg_name = (void *) &addr;
+  msg.msg_namelen = sizeof (addr);
+  msg.msg_iov = &iov;
+  msg.msg_iovlen = 1;
+
+  dr->last_error = recvmsg (dr->sock, &msg, 0);
+  if (dr->last_error < 0)
+  {
+#ifdef DYNROUTE_DEBUG
+    if (DYNROUTE_DEBUG == DYNROUTE_DEBUG_CHATTY)
+      fprintf (stderr, "dynroute_read: recvmsg() : %d\n", dr->last_error);
+#endif
+    return false;
+  }    
+  nlh = (struct nlmsghdr *) buf;
+  rtm = NLMSG_DATA(nlh);
+
+  if (rtm->rtm_protocol != RTPROT_ZEBRA)
+  {
+#ifdef DYNROUTE_DEBUG
+  if (DYNROUTE_DEBUG == DYNROUTE_DEBUG_CHATTY)
+    fprintf (stderr, "dynroute_read: no zebra\n");
+#endif
+    return false;
+  }    
+
+  len = nlh->nlmsg_len - NLMSG_LENGTH (sizeof (struct rtmsg));
+  dr->last_error = len;
+  if (dr->last_error < 0)
+  {
+#ifdef DYNROUTE_DEBUG
+    fprintf (stderr, "dynroute_read: ERROR nlh->nlmsg_len : %d\n", dr->last_error);
+#endif
+    return false;
+  }    
+
+  memset (tb, 0, sizeof tb);
+  netlink_parse_rtattr (tb, RTA_MAX, RTM_RTA (rtm), len);
+
+  in_addr_t *dstp;
+  in_addr_t *gw;
+
+  if (tb[RTA_GATEWAY])
+    gw = RTA_DATA (tb[RTA_GATEWAY]);
+  if (tb[RTA_DST])
+    dstp = RTA_DATA (tb[RTA_DST]);
+
+  in_addr_t *srcp;
+  if (tb[RTA_SRC])
+    srcp = RTA_DATA (tb[RTA_SRC]);
+  if (tb[RTA_MULTIPATH])
+  {
+    struct rtnexthop *rtnh = (struct rtnexthop *) RTA_DATA (tb[RTA_MULTIPATH]);
+    len = RTA_PAYLOAD (tb[RTA_MULTIPATH]);
+
+    if (len < (int) sizeof (*rtnh))
+      return 0;
+    if (rtnh->rtnh_len > len)
+      return 0;
+
+    int index = rtnh->rtnh_ifindex;
+    if (rtnh->rtnh_len > sizeof (*rtnh))
+    {
+      memset (tb, 0, sizeof (tb));
+      netlink_parse_rtattr (tb, RTA_MAX, RTNH_DATA (rtnh), rtnh->rtnh_len - sizeof (*rtnh));
+      if (tb[RTA_GATEWAY])
+        gw = RTA_DATA (tb[RTA_GATEWAY]);
+    }
+  }
+
+  switch (nlh->nlmsg_type)
+  {
+    case RTM_NEWROUTE:
+      switch (nlh->nlmsg_flags)
+      {
+        case 0:
+        case NLM_F_CREATE:
+          dr->action = DRA_NEW;
+          break;
+        case NLM_F_REPLACE:
+          dr->action = DRA_REP;
+          break;
+        default:
+          dr->action = DRA_NONE;
+          break;
+      }
+      break;
+    case RTM_DELROUTE:
+      dr->action = DRA_DEL;
+      break;
+  }
+  dr->gateway = endian_swap (*gw);
+  dr->ir.network = endian_swap (*dstp);
+  dr->ir.netbits = rtm->rtm_dst_len;
+#ifdef DYNROUTE_DEBUG
+  if (DYNROUTE_DEBUG == DYNROUTE_DEBUG_CHATTY)
+    fprintf (stderr, "dynroute_read: OK\n");
+#endif
+  return dr->initialized;
+}
+
+static bool dynroute_route_exists (struct multi_context *m, struct iroute ir)
+{
+  bool ret = false;
+  struct openvpn_sockaddr remote_si;
+  struct mroute_addr addr;
+  struct hash_element *he;
+
+  CLEAR (remote_si);
+  remote_si.sa.sin_family = AF_INET;
+  remote_si.sa.sin_addr.s_addr = htonl (ir.network);
+  ASSERT (mroute_extract_openvpn_sockaddr (&addr, &remote_si, false));
+  if (ir.netbits >= 0)
+  {
+    addr.type |= MR_WITH_NETBITS;
+    addr.netbits = (uint8_t) ir.netbits;
+  }
+  const uint32_t hv = hash_value (m->vhash, &addr);
+  struct hash_bucket *bucket = hash_bucket (m->vhash, hv);
+  struct multi_route *oldroute = NULL;
+
+  hash_bucket_lock (bucket);
+  /* if route currently exists, get the instance which owns it */
+  he = hash_lookup_fast (m->vhash, bucket, &addr, hv);
+  if (he)
+    oldroute = (struct multi_route *) he->value;
+  hash_bucket_unlock (bucket);
+  ret = (oldroute && multi_route_defined (m, oldroute));
+  return ret;
+}
+
+static bool dynroute_eval (struct multi_context *m, struct dynroute *dr)
+{
+  bool ret = true;
+  if (dr->action > DRA_NONE)  // route added / deleted
+  {
+    struct hash_iterator hi;
+    struct hash_element *he;
+    hash_iterator_init (m->hash, &hi, true);
+    while ((he = hash_iterator_next (&hi)))
+    {
+      struct gc_arena gc = gc_new ();
+      struct multi_instance *mi = (struct multi_instance *) he->value;
+      struct openvpn_sockaddr remote_si;
+      struct mroute_addr addr;
+      if (!mi->halt)
+      {
+        if (mi->reporting_addr == dr->gateway)  // route gateway matches instance ip
+        {
+          switch (dr->action)
+          {
+            case DRA_NEW:
+              msg (D_MULTI_LOW, "DYNROUTE: New: %s/%d -> %s",
+                print_in_addr_t (dr->ir.network, IA_EMPTY_IF_UNDEF, &gc),
+                dr->ir.netbits,
+                multi_instance_string (mi, false, &gc));
+              mroute_helper_add_iroute (m->route_helper, (struct iroute *) &dr->ir);
+              multi_learn_in_addr_t (m, mi, dr->ir.network, dr->ir.netbits, false);
+              break;
+            case DRA_DEL:
+              if (dynroute_route_exists(m, dr->ir))
+              {
+                mroute_helper_del_iroute (m->route_helper, (struct iroute *) &dr->ir);
+                msg (D_MULTI_LOW, "DYNROUTE: Delete: %s/%d -> %s",
+                  print_in_addr_t (dr->ir.network, IA_EMPTY_IF_UNDEF, &gc), dr->ir.netbits,
+                  print_in_addr_t (dr->gateway, IA_EMPTY_IF_UNDEF, &gc));
+              }
+              break;
+            default:
+              msg (D_MULTI_LOW, "DYNROUTE: UNKNOWN ACTION: %d", dr->action);
+              break;
+          }
+        }  // if (mi->reporting_addr == dr->gateway)
+      }  // if (!mi->halt)
+      gc_free (&gc);
+    }  // while ((he = hash_iterator_next (&hi)))
+    hash_iterator_free (&hi);
+  }  // if (dr->action > DRA_NONE)
+  return ret;
+}
diff --git a/dynroute.h b/dynroute.h
new file mode 100644
index 0000000..6dd5694
--- /dev/null
+++ b/dynroute.h
@@ -0,0 +1,24 @@
+#include <linux/rtnetlink.h>
+
+#ifndef DYNROUTE_H
+#define DYNROUTE_H
+
+//#define DYNROUTE_DEBUG_CHATTY 2
+//#define DYNROUTE_DEBUG DYNROUTE_DEBUG_CHATTY-1
+
+#define DRA_NONE 0
+#define DRA_NEW 1
+#define DRA_REP 2
+#define DRA_DEL 3
+
+struct dynroute
+{
+  int sock;  
+  int last_error;
+  bool initialized;
+  bool nope;
+  int action;
+  in_addr_t gateway;
+  struct iroute ir;
+};
+#endif /* DYNROUTE_H */
diff --git a/multi.c b/multi.c
index 5c80c46..e1da1f6 100644
--- a/multi.c
+++ b/multi.c
@@ -37,6 +37,10 @@
 #include "forward-inline.h"
 #include "pf-inline.h"
 
+#ifdef ENABLE_DYNROUTE
+#include "dynroute.c"
+#endif
+
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
 #ifdef MULTI_DEBUG_EVENT_LOOP
@@ -2273,6 +2277,12 @@ multi_process_timeout (struct multi_context *m, const unsigned int mpp_flags)
 {
   bool ret = true;
 
+#ifdef ENABLE_DYNROUTE
+  if (!dr.nope)
+    if (dynroute_read (&dr))
+      dynroute_eval (m, &dr);
+#endif
+
 #ifdef MULTI_DEBUG_EVENT_LOOP
   printf ("%s -> TIMEOUT\n", id(m->earliest_wakeup));
 #endif
-- 
1.7.0.2.msysgit.0


--------------060507030901030602010607--

