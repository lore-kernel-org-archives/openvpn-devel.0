Date: Sat, 30 Oct 2010 21:15:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20101030191532.GX10703@...1296...>
References: <AANLkTiko6XdjTaNL_y5=+mAXUjHE4A22tPQcc14tqu-s@...278...>
	<20101029122554.GQ10703@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="GH3qgo5c4/nsO7bB"
Content-Disposition: inline
In-Reply-To: <20101029122554.GQ10703@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] TAP driver for Solaris patch
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kazuyoshi Aizawa <admin2@...628...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GH3qgo5c4/nsO7bB
Content-Type: multipart/mixed; boundary="9PuahwfVIEEnr0Lg"
Content-Disposition: inline

--9PuahwfVIEEnr0Lg
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

back to the list after some private e-mails...

On Fri, Oct 29, 2010 at 02:25:54PM +0200, Gert Doering wrote:
> On Mon, Sep 06, 2010 at 11:13:09PM +0900, Kazuyoshi Aizawa wrote:
> > I attached a patch for OpenVPN 2.1.3 to support TAP driver for Solaris.
> > Also, you can find the patch as well as TAP driver here.
> >      http://www.whiteboard.ne.jp/~admin2/tuntap/
>=20
> One oddity remains: "--mode tun" + "--topology subnet" (not using=20
> point-to-point but "broadcast" tun interfaces) does not work.  I'm not=20
> sure whether this is a known limitation of the Solaris tun drivers, or=20
> of the way we currently access the interface - but it would be great=20
> if that could made to work - it's part of my set of regression tests...=
=20=20
> (this is *not* a problem introduced by your patch, it does not work for=20
> stock 2.2-beta3 either).

This works now, thanks to Kazuyoshi-san figuring out how to do "ifconfig"
in this case, and for adding the metric setting on Solaris.

I have patched 2.2-beta3 with the patch appended below, and successfully
tested the following cases on OpenSolaris/i386:

  - point-to-multipoint tun via UDP and TCP, "topology net30"
  - point-to-multipoint tun "topology subnet" (*new*)
  - point-to-multipoint tap (*new*)

all test cases pass, including fragmented large packets (fping).  I have
appended OpenVPN.log files for "topology subnet" and "tap" cases.

Since it works on OpenSolaris, doesn't break existing functionality, and
does not touch code for other platforms at all, I'd consider this a=20
useful addition to OpenVPN 2.2.  ACK from me for Kazuyoshi-san's changes,
and if someone else would want to review and ACK this for "obvious"=20
errors (mem leakage, etc), you're welcome, of course.

David: patches below for integration into the "2.2beta" branch.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--9PuahwfVIEEnr0Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Integrate-support-for-TAP-mode-on-Solaris-written-by.patch"
Content-Transfer-Encoding: quoted-printable

=46rom c1d75d70006dc2c1cac10249abf7e0cf3d90553a Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Fri, 29 Oct 2010 17:41:53 +0200
Subject: [PATCH 1/2] Integrate support for TAP mode on Solaris, written by =
Kazuyoshi Aizawa
 <admin2@...628...>.

See also http://www.whiteboard.ne.jp/~admin2/tuntap/

Signed-off-by: Gert Doering <gert@...1296...>
---
 tun.c |  120 +++++++++++++++++++++++++++++++++++++++++++++++++++++--------=
----
 1 files changed, 98 insertions(+), 22 deletions(-)

diff --git a/tun.c b/tun.c
index 10dde6b..f001a64 100644
--- a/tun.c
+++ b/tun.c
@@ -63,6 +63,7 @@ static const char *netsh_get_id (const char *dev_node, st=
ruct gc_arena *gc);
=20
 #ifdef TARGET_SOLARIS
 static void solaris_error_close (struct tuntap *tt, const struct env_set *=
es, const char *actual);
+#include <stropts.h>
 #endif
=20
 bool
@@ -701,7 +702,13 @@ do_ifconfig (struct tuntap *tt,
 			    );
 	}
       else
-	no_tap_ifconfig ();
+          argv_printf (&argv,
+                            " %s %s %s netmask %s broadcast + up",
+                            IFCONFIG_PATH,
+                            actual,
+                            ifconfig_local,
+                            ifconfig_remote_netmask
+                            );
=20
       argv_msg (M_INFO, &argv);
       if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig phase-2 f=
ailed"))
@@ -1372,15 +1379,17 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, boo=
l ipv6, struct tuntap *tt)
 {
-  int if_fd, muxid, ppa =3D -1;
-  struct ifreq ifr;
+  int if_fd, ip_muxid, arp_muxid, arp_fd, ppa =3D -1;
+  struct lifreq ifr;
   const char *ptr;
-  const char *ip_node;
+  const char *ip_node, *arp_node;
   const char *dev_tuntap_type;
   int link_type;
   bool is_tun;
+  struct strioctl  strioc_if, strioc_ppa;
=20
-  ipv6_support (ipv6, false, tt);
+  ipv6_support (ipv6, true, tt);
+  memset(&ifr, 0x0, sizeof(ifr));
=20
   if (tt->type =3D=3D DEV_TYPE_NULL)
     {
@@ -1399,9 +1408,10 @@ open_tun (const char *dev, const char *dev_type, con=
st char *dev_node, bool ipv6
     }
   else if (tt->type =3D=3D DEV_TYPE_TAP)
     {
-      ip_node =3D "/dev/ip";
+      ip_node =3D "/dev/udp";
       if (!dev_node)
 	dev_node =3D "/dev/tap";
+      arp_node =3D dev_node;
       dev_tuntap_type =3D "tap";
       link_type =3D I_PLINK; /* was: I_LINK */
       is_tun =3D false;
@@ -1428,7 +1438,11 @@ open_tun (const char *dev, const char *dev_type, con=
st char *dev_node, bool ipv6
     msg (M_ERR, "Can't open %s", dev_node);
=20
   /* Assign a new PPA and get its unit number. */
-  if ((ppa =3D ioctl (tt->fd, TUNNEWPPA, ppa)) < 0)
+  strioc_ppa.ic_cmd =3D TUNNEWPPA;
+  strioc_ppa.ic_timout =3D 0;
+  strioc_ppa.ic_len =3D sizeof(ppa);
+  strioc_ppa.ic_dp =3D (char *)&ppa;
+  if ((ppa =3D ioctl (tt->fd, I_STR, &strioc_ppa)) < 0)
     msg (M_ERR, "Can't assign new interface");
=20
   if ((if_fd =3D open (dev_node, O_RDWR, 0)) < 0)
@@ -1437,27 +1451,83 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, bool ipv6
   if (ioctl (if_fd, I_PUSH, "ip") < 0)
     msg (M_ERR, "Can't push IP module");
=20
+  if (tt->type =3D=3D DEV_TYPE_TUN)
+    {
   /* Assign ppa according to the unit number returned by tun device */
   if (ioctl (if_fd, IF_UNITSEL, (char *) &ppa) < 0)
     msg (M_ERR, "Can't set PPA %d", ppa);
-
-  if ((muxid =3D ioctl (tt->ip_fd, link_type, if_fd)) < 0)
-    msg (M_ERR, "Can't link %s device to IP", dev_tuntap_type);
-
-  close (if_fd);
+    }
=20
   tt->actual_name =3D (char *) malloc (32);
   check_malloc_return (tt->actual_name);
=20
   openvpn_snprintf (tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);
=20
+  if (tt->type =3D=3D DEV_TYPE_TAP)
+    {
+          if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) < 0)
+            msg (M_ERR, "Can't get flags\n");
+          strncpynt (ifr.lifr_name, tt->actual_name, sizeof (ifr.lifr_name=
));
+          ifr.lifr_ppa =3D ppa;
+          /* Assign ppa according to the unit number returned by tun devic=
e */
+          if (ioctl (if_fd, SIOCSLIFNAME, &ifr) < 0)
+            msg (M_ERR, "Can't set PPA %d", ppa);
+          if (ioctl(if_fd, SIOCGLIFFLAGS, &ifr) <0)
+            msg (M_ERR, "Can't get flags\n");
+          /* Push arp module to if_fd */
+          if (ioctl (if_fd, I_PUSH, "arp") < 0)
+            msg (M_ERR, "Can't push ARP module");
+
+          /* Pop any modules on the stream */
+          while (true)
+            {
+                 if (ioctl (tt->ip_fd, I_POP, NULL) < 0)
+                     break;
+            }
+          /* Push arp module to ip_fd */
+          if (ioctl (tt->ip_fd, I_PUSH, "arp") < 0)
+            msg (M_ERR, "Can't push ARP module\n");
+
+          /* Open arp_fd */
+          if ((arp_fd =3D open (arp_node, O_RDWR, 0)) < 0)
+            msg (M_ERR, "Can't open %s\n", arp_node);
+          /* Push arp module to arp_fd */
+          if (ioctl (arp_fd, I_PUSH, "arp") < 0)
+            msg (M_ERR, "Can't push ARP module\n");
+
+          /* Set ifname to arp */
+          strioc_if.ic_cmd =3D SIOCSLIFNAME;
+          strioc_if.ic_timout =3D 0;
+          strioc_if.ic_len =3D sizeof(ifr);
+          strioc_if.ic_dp =3D (char *)&ifr;
+          if (ioctl(arp_fd, I_STR, &strioc_if) < 0){
+              msg (M_ERR, "Can't set ifname to arp\n");
+          }
+   }
+
+  if ((ip_muxid =3D ioctl (tt->ip_fd, link_type, if_fd)) < 0)
+    msg (M_ERR, "Can't link %s device to IP", dev_tuntap_type);
+
+  if (tt->type =3D=3D DEV_TYPE_TAP) {
+          if ((arp_muxid =3D ioctl (tt->ip_fd, link_type, arp_fd)) < 0)
+            msg (M_ERR, "Can't link %s device to ARP", dev_tuntap_type);
+          close (arp_fd);
+  }
+
   CLEAR (ifr);
-  strncpynt (ifr.ifr_name, tt->actual_name, sizeof (ifr.ifr_name));
-  ifr.ifr_ip_muxid =3D muxid;
+  strncpynt (ifr.lifr_name, tt->actual_name, sizeof (ifr.lifr_name));
+  ifr.lifr_ip_muxid  =3D ip_muxid;
+  if (tt->type =3D=3D DEV_TYPE_TAP) {
+          ifr.lifr_arp_muxid =3D arp_muxid;
+  }
=20
-  if (ioctl (tt->ip_fd, SIOCSIFMUXID, &ifr) < 0)
+  if (ioctl (tt->ip_fd, SIOCSLIFMUXID, &ifr) < 0)
     {
-      ioctl (tt->ip_fd, I_PUNLINK, muxid);
+      if (tt->type =3D=3D DEV_TYPE_TAP)
+        {
+              ioctl (tt->ip_fd, I_PUNLINK , arp_muxid);
+        }
+      ioctl (tt->ip_fd, I_PUNLINK, ip_muxid);
       msg (M_ERR, "Can't set multiplexor id");
     }
=20
@@ -1475,18 +1545,24 @@ solaris_close_tun (struct tuntap *tt)
     {
       if (tt->ip_fd >=3D 0)
 	{
-	  struct ifreq ifr;
+          struct lifreq ifr;
 	  CLEAR (ifr);
-	  strncpynt (ifr.ifr_name, tt->actual_name, sizeof (ifr.ifr_name));
+          strncpynt (ifr.lifr_name, tt->actual_name, sizeof (ifr.lifr_name=
));
=20
-	  if (ioctl (tt->ip_fd, SIOCGIFFLAGS, &ifr) < 0)
+          if (ioctl (tt->ip_fd, SIOCGLIFFLAGS, &ifr) < 0)
 	    msg (M_WARN | M_ERRNO, "Can't get iface flags");
=20
-	  if (ioctl (tt->ip_fd, SIOCGIFMUXID, &ifr) < 0)
+          if (ioctl (tt->ip_fd, SIOCGLIFMUXID, &ifr) < 0)
 	    msg (M_WARN | M_ERRNO, "Can't get multiplexor id");
=20
-	  if (ioctl (tt->ip_fd, I_PUNLINK, ifr.ifr_ip_muxid) < 0)
-	    msg (M_WARN | M_ERRNO, "Can't unlink interface");
+          if (tt->type =3D=3D DEV_TYPE_TAP)
+            {
+                  if (ioctl (tt->ip_fd, I_PUNLINK, ifr.lifr_arp_muxid) < 0)
+                    msg (M_WARN | M_ERRNO, "Can't unlink interface(arp)");
+            }
+
+          if (ioctl (tt->ip_fd, I_PUNLINK, ifr.lifr_ip_muxid) < 0)
+            msg (M_WARN | M_ERRNO, "Can't unlink interface(ip)");
=20
 	  close (tt->ip_fd);
 	  tt->ip_fd =3D -1;
--=20
1.7.2.2


--9PuahwfVIEEnr0Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0002-Make-topology-subnet-work-on-Solaris-ifconfig-route-.patch"
Content-Transfer-Encoding: quoted-printable

=46rom f4e5ddbe83c1ccf90f40e3d614aa2d94458c5d8c Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1296...>
Date: Sat, 30 Oct 2010 21:03:16 +0200
Subject: [PATCH 2/2] Make "topology subnet" work on Solaris (ifconfig + rou=
te metric changes
 by Kazuyoshi Aizawa, adding of local "connected subnet" route by me)

Tested on OpenSolaris/i386, no impact for other TARGETs.

Signed-off-by: Gert Doering <gert@...1296...>
---
 route.c |    8 +++-----
 tun.c   |   27 +++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 5 deletions(-)

diff --git a/route.c b/route.c
index 20f62d5..c63eb41 100644
--- a/route.c
+++ b/route.c
@@ -952,16 +952,14 @@ add_route (struct route *r, const struct tuntap *tt, =
unsigned int flags, const s
   argv_printf (&argv, "%s add",
 		ROUTE_PATH);
=20
-#if 0
-  if (r->metric_defined)
-    argv_printf_cat (&argv, "-rtt %d", r->metric);
-#endif
-
   argv_printf_cat (&argv, "%s -netmask %s %s",
 	      network,
 	      netmask,
 	      gateway);
=20
+  if (r->metric_defined)
+    argv_printf_cat (&argv, "%d", r->metric);
+
   argv_msg (D_ROUTE, &argv);
   status =3D openvpn_execve_check (&argv, es, 0, "ERROR: Solaris route add=
 command failed");
=20
diff --git a/tun.c b/tun.c
index f001a64..0e4476e 100644
--- a/tun.c
+++ b/tun.c
@@ -702,6 +702,19 @@ do_ifconfig (struct tuntap *tt,
 			    );
 	}
       else
+        if (tt->topology =3D=3D TOP_SUBNET)
+	{
+          argv_printf (&argv,
+                              "%s %s %s %s netmask %s mtu %d up",
+                              IFCONFIG_PATH,
+                              actual,
+                              ifconfig_local,
+                              ifconfig_local,
+                              ifconfig_remote_netmask,
+                              tun_mtu
+                              );
+	}
+        else
           argv_printf (&argv,
                             " %s %s %s netmask %s broadcast + up",
                             IFCONFIG_PATH,
@@ -714,6 +727,20 @@ do_ifconfig (struct tuntap *tt,
       if (!openvpn_execve_check (&argv, es, 0, "Solaris ifconfig phase-2 f=
ailed"))
 	solaris_error_close (tt, es, actual);
=20
+      if (!tun && tt->topology =3D=3D TOP_SUBNET)
+	{
+	  /* Add a network route for the local tun interface */
+	  struct route r;
+	  CLEAR (r);     =20
+	  r.defined =3D true;      =20
+	  r.network =3D tt->local & tt->remote_netmask;
+	  r.netmask =3D tt->remote_netmask;
+	  r.gateway =3D tt->local; =20
+	  r.metric_defined =3D true;
+	  r.metric =3D 0;
+	  add_route (&r, tt, 0, es);
+	}
+
       tt->did_ifconfig =3D true;
=20
 #elif defined(TARGET_OPENBSD)
--=20
1.7.2.2


--9PuahwfVIEEnr0Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-solaris-topsubnet.log"

Sat Oct 30 21:00:43 2010 OpenVPN 2.2-beta3 i386-pc-solaris2.11 [SSL] [LZO2] [eurephia] built on Oct 29 2010
Sat Oct 30 21:00:43 2010 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables
Sat Oct 30 21:00:43 2010 WARNING: file '/rhome/gert/src/openvpn-test-ca/keys/client-test.key' is group or others accessible
Sat Oct 30 21:00:43 2010 LZO compression initialized
Sat Oct 30 21:00:43 2010 Control Channel MTU parms [ L:1542 D:138 EF:38 EB:0 ET:0 EL:0 ]
Sat Oct 30 21:00:43 2010 Socket Buffers: R=[57344->65536] S=[57344->65536]
Sat Oct 30 21:00:43 2010 Data Channel MTU parms [ L:1542 D:1450 EF:42 EB:135 ET:0 EL:0 AF:3/1 ]
Sat Oct 30 21:00:43 2010 Local Options hash (VER=V4): '41690919'
Sat Oct 30 21:00:43 2010 Expected Remote Options hash (VER=V4): '530fdded'
Sat Oct 30 21:00:43 2010 UDPv4 link local: [undef]
Sat Oct 30 21:00:43 2010 UDPv4 link remote: 195.30.36.4:51195
Sat Oct 30 21:00:43 2010 TLS: Initial packet from 195.30.36.4:51195, sid=3b148c85 056cd5da
Sat Oct 30 21:00:43 2010 VERIFY OK: depth=1, /C=DE/ST=Bavaria/L=Munich/O=Gert_Doering/CN=Gert_Doering_CA/emailAddress=gert@...1427...
Sat Oct 30 21:00:43 2010 VERIFY OK: nsCertType=SERVER
Sat Oct 30 21:00:43 2010 VERIFY OK: depth=0, /C=DE/ST=Bavaria/L=Munich/O=Gert_Doering/CN=server-test/emailAddress=gert@...1427...
Sat Oct 30 21:00:44 2010 WARNING: 'tun-ipv6' is present in remote config but missing in local config, remote='tun-ipv6'
Sat Oct 30 21:00:44 2010 Data Channel Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Sat Oct 30 21:00:44 2010 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Sat Oct 30 21:00:44 2010 Data Channel Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Sat Oct 30 21:00:44 2010 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Sat Oct 30 21:00:44 2010 Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Sat Oct 30 21:00:44 2010 [server-test] Peer Connection Initiated with 195.30.36.4:51195
Sat Oct 30 21:00:46 2010 SENT CONTROL [server-test]: 'PUSH_REQUEST' (status=1)
Sat Oct 30 21:00:46 2010 PUSH: Received control message: 'PUSH_REPLY,ifconfig-ipv6 2001:608:4:a052::1:0 2001:608:4:a052::1,route 10.100.0.0 255.255.0.0,route-ipv6 2001:608:4:a000::/56,tun-ipv6,route-gateway 10.100.52.1,topology subnet,ping 10,ping-restart 30,ifconfig 10.100.52.2 255.255.255.0'
Sat Oct 30 21:00:46 2010 Options error: Unrecognized option or missing parameter(s) in [PUSH-OPTIONS]:1: ifconfig-ipv6 (2.2-beta3)
Sat Oct 30 21:00:46 2010 Options error: Unrecognized option or missing parameter(s) in [PUSH-OPTIONS]:3: route-ipv6 (2.2-beta3)
Sat Oct 30 21:00:46 2010 OPTIONS IMPORT: timers and/or timeouts modified
Sat Oct 30 21:00:46 2010 OPTIONS IMPORT: --ifconfig/up options modified
Sat Oct 30 21:00:46 2010 OPTIONS IMPORT: route options modified
Sat Oct 30 21:00:46 2010 OPTIONS IMPORT: route-related options modified
Sat Oct 30 21:00:46 2010 ROUTE: default_gateway=UNDEF
Sat Oct 30 21:00:46 2010 TUN/TAP device tun0 opened
Sat Oct 30 21:00:46 2010 /usr/sbin/ifconfig tun0 10.100.52.2 10.100.52.2 netmask 255.255.255.0 mtu 1500 up
Sat Oct 30 21:00:46 2010 /usr/sbin/route add 10.100.52.0 -netmask 255.255.255.0 10.100.52.2 0
add net 10.100.52.0: gateway 10.100.52.2
Sat Oct 30 21:00:46 2010 /usr/sbin/route add 10.100.0.0 -netmask 255.255.0.0 10.100.52.1
add net 10.100.0.0: gateway 10.100.52.1
Sat Oct 30 21:00:46 2010 Initialization Sequence Completed
Sat Oct 30 21:01:11 2010 event_wait : Interrupted system call (code=4)
Sat Oct 30 21:01:11 2010 TCP/UDP: Closing socket
Sat Oct 30 21:01:11 2010 /usr/sbin/route delete 10.100.0.0 -netmask 255.255.0.0 10.100.52.1
delete net 10.100.0.0: gateway 10.100.52.1
Sat Oct 30 21:01:11 2010 Closing TUN/TAP interface
Sat Oct 30 21:01:11 2010 SIGTERM[hard,] received, process exiting

--9PuahwfVIEEnr0Lg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-solaris-tap.log"

Sat Oct 30 20:59:03 2010 OpenVPN 2.2-beta3 i386-pc-solaris2.11 [SSL] [LZO2] [eurephia] built on Oct 29 2010
Sat Oct 30 20:59:03 2010 NOTE: OpenVPN 2.1 requires '--script-security 2' or higher to call user-defined scripts or executables
Sat Oct 30 20:59:03 2010 WARNING: file '/rhome/gert/src/openvpn-test-ca/keys/client-test.key' is group or others accessible
Sat Oct 30 20:59:03 2010 LZO compression initialized
Sat Oct 30 20:59:03 2010 Control Channel MTU parms [ L:1574 D:138 EF:38 EB:0 ET:0 EL:0 ]
Sat Oct 30 20:59:03 2010 Socket Buffers: R=[57344->65536] S=[57344->65536]
Sat Oct 30 20:59:03 2010 Data Channel MTU parms [ L:1574 D:1450 EF:42 EB:135 ET:32 EL:0 AF:3/1 ]
Sat Oct 30 20:59:03 2010 Local Options hash (VER=V4): 'd79ca330'
Sat Oct 30 20:59:03 2010 Expected Remote Options hash (VER=V4): 'f7df56b8'
Sat Oct 30 20:59:03 2010 UDPv4 link local: [undef]
Sat Oct 30 20:59:03 2010 UDPv4 link remote: 195.30.36.4:51196
Sat Oct 30 20:59:03 2010 TLS: Initial packet from 195.30.36.4:51196, sid=f0602215 ab88dfc9
Sat Oct 30 20:59:03 2010 VERIFY OK: depth=1, /C=DE/ST=Bavaria/L=Munich/O=Gert_Doering/CN=Gert_Doering_CA/emailAddress=gert@...1427...
Sat Oct 30 20:59:03 2010 VERIFY OK: nsCertType=SERVER
Sat Oct 30 20:59:03 2010 VERIFY OK: depth=0, /C=DE/ST=Bavaria/L=Munich/O=Gert_Doering/CN=server-test/emailAddress=gert@...1427...
Sat Oct 30 20:59:03 2010 WARNING: 'tun-ipv6' is present in remote config but missing in local config, remote='tun-ipv6'
Sat Oct 30 20:59:03 2010 Data Channel Encrypt: Cipher 'BF-CBC' initialized with 128 bit key
Sat Oct 30 20:59:03 2010 Data Channel Encrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Sat Oct 30 20:59:03 2010 Data Channel Decrypt: Cipher 'BF-CBC' initialized with 128 bit key
Sat Oct 30 20:59:03 2010 Data Channel Decrypt: Using 160 bit message hash 'SHA1' for HMAC authentication
Sat Oct 30 20:59:03 2010 Control Channel: TLSv1, cipher TLSv1/SSLv3 DHE-RSA-AES256-SHA, 1024 bit RSA
Sat Oct 30 20:59:03 2010 [server-test] Peer Connection Initiated with 195.30.36.4:51196
Sat Oct 30 20:59:05 2010 SENT CONTROL [server-test]: 'PUSH_REQUEST' (status=1)
Sat Oct 30 20:59:05 2010 PUSH: Received control message: 'PUSH_REPLY,ifconfig-ipv6 2001:608:4:a053::1:0 2001:608:4:a053::1,route 10.100.0.0 255.255.0.0,route-ipv6 2001:608:4:a000::/56,tun-ipv6,route-gateway 10.100.53.1,ping 10,ping-restart 30,ifconfig 10.100.53.2 255.255.255.0'
Sat Oct 30 20:59:05 2010 Options error: Unrecognized option or missing parameter(s) in [PUSH-OPTIONS]:1: ifconfig-ipv6 (2.2-beta3)
Sat Oct 30 20:59:05 2010 Options error: Unrecognized option or missing parameter(s) in [PUSH-OPTIONS]:3: route-ipv6 (2.2-beta3)
Sat Oct 30 20:59:05 2010 OPTIONS IMPORT: timers and/or timeouts modified
Sat Oct 30 20:59:05 2010 OPTIONS IMPORT: --ifconfig/up options modified
Sat Oct 30 20:59:05 2010 OPTIONS IMPORT: route options modified
Sat Oct 30 20:59:05 2010 OPTIONS IMPORT: route-related options modified
Sat Oct 30 20:59:05 2010 ROUTE: default_gateway=UNDEF
Sat Oct 30 20:59:05 2010 TUN/TAP device tap0 opened
Sat Oct 30 20:59:05 2010 /usr/sbin/ifconfig tap0 10.100.53.2 netmask 255.255.255.0 broadcast + up
Sat Oct 30 20:59:05 2010 /usr/sbin/route add 10.100.0.0 -netmask 255.255.0.0 10.100.53.1
add net 10.100.0.0: gateway 10.100.53.1
Sat Oct 30 20:59:05 2010 Initialization Sequence Completed
Sat Oct 30 20:59:30 2010 event_wait : Interrupted system call (code=4)
Sat Oct 30 20:59:30 2010 TCP/UDP: Closing socket
Sat Oct 30 20:59:30 2010 /usr/sbin/route delete 10.100.0.0 -netmask 255.255.0.0 10.100.53.1
delete net 10.100.0.0: gateway 10.100.53.1
Sat Oct 30 20:59:30 2010 Closing TUN/TAP interface
Sat Oct 30 20:59:30 2010 SIGTERM[hard,] received, process exiting

--9PuahwfVIEEnr0Lg--

--GH3qgo5c4/nsO7bB
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTMxu06kuBuNlUUl1AQI4wAP/URHKM8yDfLAIwrsmFqH7RiZo92jfUkJU
FYGs6UfndVOYLuPgE1WnMSyLI0ENl9FTxdTabKMF8SfK4Z6fATjIj4uHk3Psvj9d
NLUprmPCd2xs9aJ1oYIxkJL/GKo79VV/needUQzRxAkv626PhLGfQwsvnfY2iL+b
QDub9RlKqcc=
=AFz1
-----END PGP SIGNATURE-----

--GH3qgo5c4/nsO7bB--

