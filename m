Date: Tue, 26 Nov 2024 14:26:52 +0000
From: Alexander von Gluck <alex@...2837...>
Message-ID: <20241126142639.67446-1-alex@...2837...>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg=pgp-sha256;
 boundary="------5f946099762c5079e11c5cf6a5593d3baf259cab57b02d7d92174e35c7a8d5ee";
 charset=utf-8
Subject: [Openvpn-devel] [PATCH 1/2] Haiku: Introduce basic platform support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Alexander von Gluck IV <kallisti5@...2838...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------5f946099762c5079e11c5cf6a5593d3baf259cab57b02d7d92174e35c7a8d5ee
From: Alexander von Gluck <alex@...2837...>
To: openvpn-devel@lists.sourceforge.net
Cc: Alexander von Gluck IV <kallisti5@...2838...>
Subject: [PATCH 1/2] Haiku: Introduce basic platform support
Date: Tue, 26 Nov 2024 08:26:38 -0600
Message-ID: <20241126142639.67446-1-alex@...2837...>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Alexander von Gluck IV <kallisti5@...2838...>

---
 configure.ac        |  5 +++++
 src/openvpn/route.c | 15 +++++++++++++++
 src/openvpn/tun.c   | 17 +++++++++++++++++
 3 files changed, 37 insertions(+)

diff --git a/configure.ac b/configure.ac
index 0876a6a5..7f6e43dd 100644
--- a/configure.ac
+++ b/configure.ac
@@ -368,6 +368,11 @@ case "$host" in
 		have_tap_header="yes"
 		ac_cv_header_net_if_h="no"	# exists, but breaks things
 		;;
+	*-*-haiku*)
+		AC_DEFINE([TARGET_HAIKU], [1], [Are we running Haiku?])
+		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["H"], [Target prefix])
+		LIBS="${LIBS} -lnetwork"
+		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
 		have_tap_header="yes"
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 2e584c71..fa20d08f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1853,6 +1853,21 @@ add_route(struct route_ipv4 *r,
         status = ret ? RTA_SUCCESS : RTA_ERROR;
     }
 
+#el
if defined(TARGET_HAIKU)
+
+    {
+        /* ex: route add /dev/net/ipro1000/0 default gw 192.168.1.1 netmask 255.255.255.0 */
+        argv_printf(&argv, "route add %s inet default gw %s netmask %s",
+                    rgi->iface,
+                    gateway,
+                    netmask);
+
+        argv_msg(D_ROUTE, &argv);
+        bool ret = openvpn_execve_check(&argv, es, 0,
+                                        "ERROR: Haiku route add command failed");
+        status = ret ? RTA_SUCCESS : RTA_ERROR;
+    }
+
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'route' commands on this operating system.  Try putting your routes in a --route-up script");
 #endif /* if defined(TARGET_LINUX) */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 85fe01af..65e3b5ba 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1631,6 +1631,16 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,

     {
         windows_set_mtu(tt->adapter_index, AF_INET, tun_mtu);
     }
+#elif defined(TARGET_HAIKU)
+    {
+        /* example: ifconfig tun/0 inet 1.1.1.1 255.255.255.0 mtu 1450 up */
+        // Need to add ifconfig_remote_netmask since right now it is just NULL
+        argv_printf(&argv, "%s %s inet %s %s mtu %d up", IFCONFIG_PATH,
+            ifname, ifconfig_local, ifconfig_remote_netmask, tun_mtu);
+
+        argv_msg(M_INFO, &argv);
+        openvpn_execve_check(&argv, es, S_FATAL, "Haiku ifconfig failed");
+    }
 #else  /* if defined(TARGET_LINUX) */
     msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
@@ -1909,10 +1919,17 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
         {
             for (int i = 0; i < 256; ++i)
             {
+#if defined(TARGET_H
AIKU)
+                snprintf(tunname, sizeof(tunname),
+                         "/dev/%s/%d", dev, i);
+                snprintf(dynamic_name, sizeof(dynamic_name),
+                         "%s/%d", dev, i);
+#else
                 snprintf(tunname, sizeof(tunname),
                          "/dev/%s%d", dev, i);
                 snprintf(dynamic_name, sizeof(dynamic_name),
                          "%s%d", dev, i);
+#endif
                 if ((tt->fd = open(tunname, O_RDWR)) > 0)
                 {
                     dynamic_opened = true;
-- 
2.47.1


--------5f946099762c5079e11c5cf6a5593d3baf259cab57b02d7d92174e35c7a8d5ee
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: ProtonMail

wnUEARYIACcFAmdF2qwJEAcdh4cOBuc9FiEE1fDK75YVVUznKdb2Bx2Hhw4G
5z0AAH3JAP9mgara4Q+bfHkNHPRlv2z/Gs0T1REwP5sJK0J2fmWxCQEAxWem
mgUNtonAjcdVoScSkH+m/I3d+ph+XKrT/ZNATwU=
=iUwD
-----END PGP SIGNATURE-----


--------5f946099762c5079e11c5cf6a5593d3baf259cab57b02d7d92174e35c7a8d5ee--


