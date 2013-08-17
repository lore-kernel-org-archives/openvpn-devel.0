Date: Sat, 17 Aug 2013 12:30:07 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20130817103007.GA16543@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="DcnznOculh5cIxbp"
Content-Disposition: inline
Subject: [Openvpn-devel] RFD - block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--DcnznOculh5cIxbp
Content-Type: multipart/mixed; boundary="ZlyDGGI/Hohreivc"
Content-Disposition: inline

--ZlyDGGI/Hohreivc
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

there's situation where you have a dual-stack IPv4+IPv6 client (like "most=
=20
new end user connections in Germany these days"), and an IPv4-only OpenVPN
setup - for whatever reason, like "running on an commercial system that
is not using 2.3 yet" or the like.

Trying to access corporate resources in such an environment can be problema=
tic
if the resource has IPv4+IPv6, but your tunnel only has IPv4 and your
client prefers IPv6 - it will try to connect "around" the tunnel, leading
to a number of undesirable effects.

For the commercial OpenVPN client, I've hacked together something that=20
mitigates this effect, by effectively breaking IPv6 connectivity while
OpenVPN is running (so clients fall back to IPv4, which works through the
tunnel).  The option is called "block-ipv6", and currently works by setting
up "reject" routes that immediately cause an ICMP unreachable to be sent
when a client tries to connect to an IPv6 destination.=20=20

This works nicely on Linux, MacOS and Windows, and should work on other=20
BSDs as well (not implemented yet).  It does not work on Android or iOS,=20
as you have no control over the real routing table, just the "routes into=20
the VPN" - while those would prevent IPv6 communication "around" the VPN
tunnel, it will have the not-so-nice property of causing client *timeouts*,
instead of fast aborts due to immediate ICMP errors.

So, what I'm hoping to hear from you...

 - should we include this in 2.3.3?
    - if yes, are changes needed?

 - should we try to implement something for 2.4/master that will work=20
   by pointing the IPv6 routes into the tunnel, and then synthesize the
   IPv6 ICMP errors inside OpenVPN?  That would work on Android and iOS
   as well, and remove the extra per-platform logic for the "reject" routes

 - any clever ideas how to achieve "full" IPv6 blocking (right now, it only
   kills the default route, but all more specific routes continue working -
   this is by design to keep the implementation simple, and was considered
   "good enough" by the end customer asking for it)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ZlyDGGI/Hohreivc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Add-block-ipv6-functionality-and-option.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 124e6c460e1bd42537c3e85753573176b4397d20 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Fri, 16 Aug 2013 23:47:49 +0200
Subject: [PATCH] Add block-ipv6 functionality and option.

Block IPv6 traffic for situations when talking to an IPv4-only
OpenVPN server, where IPv6 traffic must not "leak around" the
VPN tunnel.

All we do is install a few more-specific IPv6 routes that
result in block all "off-site" IPv6 traffic - no attempt
is made to block LAN-local or link-local traffic or work
around existing more specific routes.

Routes installed are: 2000::/4, 3000::/4, fc00::/7
(to cover default routes which might be installed as 2000::/3,
plus ULA).

To use, simply push "block-ipv6" directive to client.

(Merged from OpenVPN SVN r8410, OpenVPN 2.1.22)

Signed-off-by: Gert Doering <gert@...1296...>
---
 doc/openvpn.8         |   4 ++
 src/openvpn/init.c    |   8 ++++
 src/openvpn/options.c |   6 +++
 src/openvpn/options.h |   1 +
 src/openvpn/route.c   | 101 ++++++++++++++++++++++++++++++++++++++++++++++=
++++
 src/openvpn/route.h   |   2 +
 6 files changed, 122 insertions(+)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a8d1832..eb692f2 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -794,6 +794,10 @@ if no specific IPv6 TUN support for your OS has been c=
ompiled into OpenVPN.
 See below for further IPv6-related configuration options.
 .\"*********************************************************
 .TP
+.B \-\-block-ipv6
+Block IPv6 traffic towards the Internet while VPN is up.
+.\"*********************************************************
+.TP
 .B \-\-dev-node node
 Explicitly set the device node rather than using
 /dev/net/tun, /dev/tun, /dev/tap, etc.  If OpenVPN
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2420216..c3319ab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1465,6 +1465,10 @@ do_open_tun (struct context *c)
 	do_route (&c->options, c->c1.route_list, c->c1.route_ipv6_list,
 		  c->c1.tuntap, c->plugins, c->c2.es);
=20
+      /* block IPv6 connectivity not going to the tunnel */
+      if (c->options.block_ipv6)
+        route_block_ipv6(c->c2.es);
+
       /*
        * Did tun/tap driver give us an MTU?
        */
@@ -1562,6 +1566,10 @@ do_close_tun (struct context *c, bool force)
                              c->c1.tuntap, ROUTE_OPTION_FLAGS (&c->options=
), c->c2.es);
             }
=20
+	  /* unblock IPv6 */
+	  if (c->options.block_ipv6)
+	    route_unblock_ipv6(c->c2.es);
+
 	  /* actually close tun/tap device based on --down-pre flag */
 	  if (!c->options.down_pre)
 	    do_close_tun_simple (c);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index dcf60c6..244fa25 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1434,6 +1434,7 @@ show_settings (const struct options *o)
   SHOW_STR (lladdr);
   SHOW_INT (topology);
   SHOW_BOOL (tun_ipv6);
+  SHOW_BOOL (block_ipv6);
   SHOW_STR (ifconfig_local);
   SHOW_STR (ifconfig_remote_netmask);
   SHOW_BOOL (ifconfig_noexec);
@@ -4310,6 +4311,11 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_UP);
       options->tun_ipv6 =3D true;
     }
+  else if (streq (p[0], "block-ipv6"))
+    {
+      VERIFY_PERMISSION (OPT_P_UP);
+      options->block_ipv6 =3D true;
+    }
 #ifdef ENABLE_IPROUTE
   else if (streq (p[0], "iproute") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index c5f104f..47c0fac 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -257,6 +257,7 @@ struct options
   int ping_rec_timeout;         /* Expect a TCP/UDP ping from remote at le=
ast once every n seconds */
   bool ping_timer_remote;       /* Run ping timer only if we have a remote=
 address */
   bool tun_ipv6;                /* Build tun dev that supports IPv6 */
+  bool block_ipv6;		/* block all IPv6 not going to the tun */
=20
 # define PING_UNDEF   0
 # define PING_EXIT    1
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 044e6ac..37459cd 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -3300,3 +3300,104 @@ test_local_addr (const in_addr_t addr, const struct=
 route_gateway_info *rgi) /*
 }
=20
 #endif
+
+
+/* block IPv6 traffic
+ *
+ * to avoid IPv6 traffic circumventing a VPN when the server is (still)
+ * IPv4-only, IPv6 might need to be blocked.  All we do is install a few
+ * more-specific IPv6 routes that result in blocking all "off-site" IPv6
+ * traffic - no attempt is made to block LAN-local or link-local traffic
+ * or work around existing more specific routes
+ *
+ * Routes installed are: 2000::/4, 3000::/4, fc00::/7
+ * (to cover default routes which might be installed as 2000::/3, plus ULA)
+ */
+struct ipv6_block_entry { char prefix[20]; int len; }
+       ipv6_block_list[] =3D { { "2000::", 4},
+			     { "3000::", 4},
+			     { "fc00::", 7},
+			     { "", -1 }};
+void route_block_ipv6(const struct env_set *es)
+{
+  struct argv argv;
+  bool status;
+  struct ipv6_block_entry * ipv6_block_p =3D ipv6_block_list;
+
+  argv_init(&argv);
+
+  msg( M_INFO, "blocking IPv6 routing" );
+  while ( ipv6_block_p->len >=3D 0 )
+    {
+#if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+      argv_printf( &argv, "%s -6 route add unreachable %s/%d",
+		   iproute_path, ipv6_block_p->prefix, ipv6_block_p->len );
+#else
+      argv_printf( &argv, "%s add -6 %s/%d dev lo",
+		   ROUTE_PATH, ipv6_block_p->prefix, ipv6_block_p->len );
+#endif
+      argv_msg(M_INFO, &argv);
+      status =3D openvpn_execve_check( &argv, es, 0, "ERROR: Linux route a=
dd command failed" );
+#elif defined(TARGET_DARWIN)
+      argv_printf( &argv, "%s add -inet6 %s -prefixlen %d -reject ::1",
+		   ROUTE_PATH, ipv6_block_p->prefix, ipv6_block_p->len );
+      argv_msg(M_INFO, &argv);
+      status =3D openvpn_execve_check( &argv, es, 0, "ERROR: MacOS X route=
 add command failed" );
+#elif defined(WIN32)
+      argv_printf (&argv, "%s%sc interface ipv6 add route %s/%d interface=
=3D1 store=3Dactive",
+               get_win_sys_path(), NETSH_PATH_SUFFIX,
+               ipv6_block_p->prefix, ipv6_block_p->len );
+      argv_msg(M_INFO, &argv);
+      netcmd_semaphore_lock ();
+      status =3D openvpn_execve_check( &argv, es, 0, "ERROR: Windows route=
 delete command failed" );
+      netcmd_semaphore_release ();
+#else
+      msg(M_INFO, "can't block IPv6 routing on this platform");
+#endif
+      ipv6_block_p++;
+    }
+  argv_reset(&argv);
+}
+
+void route_unblock_ipv6(const struct env_set *es)
+{
+  struct argv argv;
+  bool status;
+  struct ipv6_block_entry * ipv6_block_p =3D ipv6_block_list;
+
+  argv_init(&argv);
+
+  msg( M_INFO, "unblocking IPv6 routing" );
+  while ( ipv6_block_p->len >=3D 0 )
+    {
+#if defined(TARGET_LINUX)
+#ifdef CONFIG_FEATURE_IPROUTE
+      argv_printf( &argv, "%s -6 route del unreachable %s/%d",
+		   iproute_path, ipv6_block_p->prefix, ipv6_block_p->len );
+#else
+      argv_printf( &argv, "%s delete -6 %s/%d dev lo",
+		   ROUTE_PATH, ipv6_block_p->prefix, ipv6_block_p->len );
+#endif
+      argv_msg(M_INFO, &argv);
+      status =3D openvpn_execve_check( &argv, es, 0, "ERROR: Linux route d=
elete command failed" );
+#elif defined(TARGET_DARWIN)
+      argv_printf( &argv, "%s delete -inet6 %s -prefixlen %d -reject ::1",
+		   ROUTE_PATH, ipv6_block_p->prefix, ipv6_block_p->len );
+      argv_msg(M_INFO, &argv);
+      status =3D openvpn_execve_check( &argv, es, 0, "ERROR: MacOS X route=
 delete command failed" );
+#elif defined(WIN32)
+      argv_printf (&argv, "%s%sc interface ipv6 del route %s/%d interface=
=3D1 store=3Dactive",
+               get_win_sys_path(), NETSH_PATH_SUFFIX,
+               ipv6_block_p->prefix, ipv6_block_p->len );
+      argv_msg(M_INFO, &argv);
+      netcmd_semaphore_lock ();
+      status =3D openvpn_execve_check( &argv, es, 0, "ERROR: Windows route=
 delete command failed" );
+      netcmd_semaphore_release ();
+#else
+      msg(M_INFO, "can't unblock IPv6 routing on this platform");
+#endif
+      ipv6_block_p++;
+    }
+  argv_reset(&argv);
+}
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index a40de32..4844397 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -278,6 +278,8 @@ bool is_special_addr (const char *addr_str);
=20
 void get_default_gateway (struct route_gateway_info *rgi);
 void print_default_gateway(const int msglevel, const struct route_gateway_=
info *rgi);
+void route_block_ipv6(const struct env_set *es);
+void route_unblock_ipv6(const struct env_set *es);
=20
 /*
  * Test if addr is reachable via a local interface (return ILA_LOCAL),
--=20
1.8.1.5


--ZlyDGGI/Hohreivc--

--DcnznOculh5cIxbp
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBUg9QrqkuBuNlUUl1AQK8FQP/W3fyZaVoEftoeY2QPGdNlE2J10/XQdXh
SiDJ2FeBUJ1lfPcPf2Mb1E9XMEieLVxPC84LWLsLPEO7RJx7u+xCHCbaOiI6Zyoc
ekoaOQYwyTKrhFEpGZlrEmZm6J7rC4Iph/4jIazBmOjkGRDOf1GsX0VIQsCbZ+tN
hrq8jeYRbx0=
=CEy/
-----END PGP SIGNATURE-----

--DcnznOculh5cIxbp--

