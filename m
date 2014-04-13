From: Kevin Cernekee <cernekee@...277...>
Date: Sat, 12 Apr 2014 22:16:55 -0700
Message-Id: <1397366216-657-3-git-send-email-cernekee@...277...>
In-Reply-To: <1397366216-657-1-git-send-email-cernekee@...277...>
References: <1397366216-657-1-git-send-email-cernekee@...277...>
Subject: [Openvpn-devel] [PATCH 2/3] Move MTU field into struct tuntap
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

open_tun() will need to access this value, so we'll store it alongside
the IP/netmask addresses.

Signed-off-by: Kevin Cernekee <cernekee@...277...>
---
 src/openvpn/init.c |    5 +++--
 src/openvpn/tun.c  |    2 +-
 src/openvpn/tun.h  |    2 +-
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c2907cd..139c625 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1448,6 +1448,7 @@ do_open_tun (struct context *c)
 	do_init_route_ipv6_list (&c->options, c->c1.route_ipv6_list, false, c->c2.es);
 
       /* do ifconfig */
+      c->c1.tuntap->mtu = TUN_MTU_SIZE (&c->c2.frame);
       if (!c->options.ifconfig_noexec
 	  && ifconfig_order () == IFCONFIG_BEFORE_TUN_OPEN)
 	{
@@ -1457,7 +1458,7 @@ do_open_tun (struct context *c)
 						c->options.dev_type,
 						c->options.dev_node,
 						&gc);
-	  do_ifconfig (c->c1.tuntap, guess, TUN_MTU_SIZE (&c->c2.frame), c->c2.es);
+	  do_ifconfig (c->c1.tuntap, guess, c->c2.es);
 	}
 
       /* possibly add routes */
@@ -1482,7 +1483,7 @@ do_open_tun (struct context *c)
       if (!c->options.ifconfig_noexec
 	  && ifconfig_order () == IFCONFIG_AFTER_TUN_OPEN)
 	{
-	  do_ifconfig (c->c1.tuntap, c->c1.tuntap->actual_name, TUN_MTU_SIZE (&c->c2.frame), c->c2.es);
+	  do_ifconfig (c->c1.tuntap, c->c1.tuntap->actual_name, c->c2.es);
 	}
 
       /* run the up script */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4df271d..31bb583 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -631,10 +631,10 @@ void delete_route_connected_v6_net(struct tuntap * tt,
 void
 do_ifconfig (struct tuntap *tt,
 	     const char *actual,    /* actual device name */
-	     int tun_mtu,
 	     const struct env_set *es)
 {
   struct gc_arena gc = gc_new ();
+  int tun_mtu = tt->mtu;
 
   if (tt->did_ifconfig_setup)
     {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 631b53c..1b510d0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -150,6 +150,7 @@ struct tuntap
   in_addr_t local;
   in_addr_t remote_netmask;
   in_addr_t broadcast;
+  int mtu;
 
   struct in6_addr local_ipv6;
   struct in6_addr remote_ipv6;
@@ -243,7 +244,6 @@ void init_tun_post (struct tuntap *tt,
 
 void do_ifconfig (struct tuntap *tt,
 		  const char *actual,    /* actual device name */
-		  int tun_mtu,
 		  const struct env_set *es);
 
 bool is_dev_type (const char *dev, const char *dev_type, const char *match_type);
-- 
1.7.9.5


