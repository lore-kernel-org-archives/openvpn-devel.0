From: Gert Doering <gert@...1296...>
Date: Sat,  4 Apr 2026 22:36:09 +0200
Message-ID: <20260404203615.30863-1-gert@...1296...>
In-Reply-To: <gerrit.1775321000000.I46499ff1f40dbdb94b84d58d17457d0ccdd75288@...2715...>
References: <gerrit.1775321000000.I46499ff1f40dbdb94b84d58d17457d0ccdd75288@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove various unused structs
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

Change-Id: I46499ff1f40dbdb94b84d58d17457d0ccdd75288
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1607
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1607
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index b7bef46..2eab7b7 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -37,14 +37,6 @@
 #include <sys/inotify.h>
 #endif
 
-struct ta_iow_flags
-{
-    unsigned int flags;
-    unsigned int ret;
-    unsigned int tun;
-    unsigned int sock;
-};
-
 struct multi_instance *
 multi_create_instance_tcp(struct multi_context *m, struct link_socket *sock)
 {
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index f484fe2..e6f4e9c 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -46,14 +46,6 @@
 #define MULTI_IO_FILE_CLOSE_WRITE ((void *)5)
 #define MULTI_IO_DCO              ((void *)6)
 
-struct ta_iow_flags
-{
-    unsigned int flags;
-    unsigned int ret;
-    unsigned int tun;
-    unsigned int sock;
-};
-
 #ifdef ENABLE_DEBUG
 static const char *
 pract(int action)
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index b88f03c..baf6f89 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -124,15 +124,6 @@
 typedef int (*sitnl_parse_reply_cb)(struct nlmsghdr *msg, void *arg);
 
 /**
- * Object returned by route request operation
- */
-struct sitnl_route_data_cb
-{
-    unsigned int iface;
-    inet_address_t gw;
-};
-
-/**
  * Helper function used to easily add attributes to a rtnl message
  */
 static int
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 1cfbf80..3b18f74 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3257,12 +3257,6 @@
  * netlink(3), netlink(7), rtnetlink(7)
  * https://www.virtualbox.org/svn/vbox/trunk/src/VBox/NetworkServices/NAT/
  */
-struct rtreq
-{
-    struct nlmsghdr nh;
-    struct rtmsg rtm;
-    char attrbuf[512];
-};
 
 void
 get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6, const struct in6_addr *dest,

