From: Adam <adam@...438...>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_958338A5-2569-4FF2-B4CB-D49727DE028E"
Mime-Version: 1.0 (Mac OS X Mail 12.0 \(3445.100.17\))
Message-Id: <B09CA954-FCB8-4362-912F-F43DDD7DC59C@...438...>
Date: Wed, 18 Jul 2018 16:33:13 +0200
Subject: [Openvpn-devel] Fix for NetBSD with subnet topology
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Apple-Mail=_958338A5-2569-4FF2-B4CB-D49727DE028E
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Greetings,

It turns out, NetBSD needs similar handling of subnet topology for tun inte=
rfaces as OpenBSD does.

Here is a patch to fix the issue (against OpenVPN 2.4.6):


--Apple-Mail=_958338A5-2569-4FF2-B4CB-D49727DE028E
Content-Disposition: attachment;
	filename=patch-src_openvpn_tun.c
Content-Type: application/octet-stream;
	x-unix-mode=0644;
	name="patch-src_openvpn_tun.c"
Content-Transfer-Encoding: 7bit

$NetBSD: patch-src_openvpn_tun.c,v 1.1 2018/06/24 09:26:12 adam Exp $

Fix for NetBSD with subnet topology.

--- src/openvpn/tun.c.orig	2018-06-24 07:38:24.000000000 +0000
+++ src/openvpn/tun.c
@@ -845,7 +845,7 @@ delete_route_connected_v6_net(struct tun
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
 
 #if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)  \
-    || defined(TARGET_OPENBSD)
+    || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)
 /* we can't use true subnet mode on tun on all platforms, as that
  * conflicts with IPv6 (wants to use ND then, which we don't do),
  * but the OSes want "a remote address that is different from ours"
@@ -1269,6 +1269,8 @@ do_ifconfig(struct tuntap *tt,
 
 #elif defined(TARGET_NETBSD)
 
+        in_addr_t remote_end;           /* for "virtual" subnet topology */
+
         if (tun)
         {
             argv_printf(&argv,
@@ -1282,12 +1284,13 @@ do_ifconfig(struct tuntap *tt,
         }
         else if (tt->topology == TOP_SUBNET)
         {
+            remote_end = create_arbitrary_remote( tt );
             argv_printf(&argv,
                         "%s %s %s %s mtu %d netmask %s up",
                         IFCONFIG_PATH,
                         actual,
                         ifconfig_local,
-                        ifconfig_local,
+                        print_in_addr_t(remote_end, 0, &gc),
                         tun_mtu,
                         ifconfig_remote_netmask
                         );
@@ -1312,6 +1315,18 @@ do_ifconfig(struct tuntap *tt,
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, es, S_FATAL, "NetBSD ifconfig failed");
 
+        /* Add a network route for the local tun interface */
+        if (!tun && tt->topology == TOP_SUBNET)
+        {
+            struct route_ipv4 r;
+            CLEAR(r);
+            r.flags = RT_DEFINED;
+            r.network = tt->local & tt->remote_netmask;
+            r.netmask = tt->remote_netmask;
+            r.gateway = remote_end;
+            add_route(&r, tt, 0, NULL, es);
+        }
+
         if (do_ipv6)
         {
             argv_printf(&argv,

--Apple-Mail=_958338A5-2569-4FF2-B4CB-D49727DE028E
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: 7bit



Kind regards,
Adam
--Apple-Mail=_958338A5-2569-4FF2-B4CB-D49727DE028E--

