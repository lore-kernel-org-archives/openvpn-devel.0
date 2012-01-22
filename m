Date: Sun, 22 Jan 2012 22:32:47 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20120122213247.GI5060@...1296...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Zp4J6pIOF3L3ZAe7"
Content-Disposition: inline
Subject: [Openvpn-devel] FreeBSD platform cleanup
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--Zp4J6pIOF3L3ZAe7
Content-Type: multipart/mixed; boundary="HE8xRhbuhm5Vuapo"
Content-Disposition: inline

--HE8xRhbuhm5Vuapo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

the current "master" code on FreeBSD has two problems:

 - tun or tap devices are not removed at program end, so a "dead"=20
   interface is left behind - not critical, but we should not do that
   -> call "ifconfig destroy" in tun_close().

 - "topology subnet" for IPv4 causes failure for IPv6 (because the
   interface is ioctl()'ed to IFF_BROADCAST mode, which changes the
   IPv6 behaviour to "use neighbour discovery", which would have to
   be implemented by the OpenVPN server - and isn't, as of today).

   With my change, the interface is left as "point to point" interface
   (which it really is), but routing and ifconfig is setup with the=20
   proper netmask, so all interesting packets are still sent down the
   tun if to OpenVPN.

Patch below, auto-tested for tun and tap devices on FreeBSD 7.4 and
FreeBSD 8.2 on amd64.=20=20

(There's one catch for FreeBSD 8.2 if you use pf(4): it will block IPv6=20
fragments by default, so the standard t_client.sh test sets fail unless=20
you specifically add "pass in on tun1 fragment" rules - but there's=20
nothing OpenVPN can do about it.  I'm just mentioning it here for the
sake of the archives, in case someone else falls over it)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--HE8xRhbuhm5Vuapo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-Platform-cleanup-for-FreeBSD.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 1b9e8c58bebde6be369859078d41ef48001a35d5 Mon Sep 17 00:00:00 2001
From: Gert Doering <gert@...1540...>
Date: Sun, 22 Jan 2012 23:21:22 +0200
Subject: [PATCH] Platform cleanup for FreeBSD

- cleanup TUN/TAP devices at program end ("ifconfig ... destroy")
- make TUN device setup for "topology subnet" work together with IPv6
  (setup correct netmask and route, but do not use IFF_BROADCAST)

Tested with IPv4 and IPv6 on 7.4-RELEASE/amd64 and 8.2-RELEASE/amd64

Signed-off-by: Gert Doering <gert@...1296...>
---
 tun.c |   37 ++++++++++++++++++++++++++++++++++---
 1 files changed, 34 insertions(+), 3 deletions(-)

diff --git a/tun.c b/tun.c
index ea0e226..5285b86 100644
--- a/tun.c
+++ b/tun.c
@@ -1098,6 +1098,18 @@ do_ifconfig (struct tuntap *tt,
 			  ifconfig_remote_netmask,
 			  tun_mtu
 			  );
+      else if ( tt->topology =3D=3D TOP_SUBNET )
+	{
+	    argv_printf (&argv,
+			  "%s %s %s %s mtu %d netmask %s up",
+			  IFCONFIG_PATH,
+			  actual,
+			  ifconfig_local,
+			  ifconfig_local,
+			  tun_mtu,
+			  ifconfig_remote_netmask
+			  );
+	}
       else
 	argv_printf (&argv,
 		      "%s %s %s netmask %s mtu %d up",
@@ -2246,10 +2258,8 @@ open_tun (const char *dev, const char *dev_type, con=
st char *dev_node, struct tu
=20
   if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
     {
-      int i =3D 0;
+      int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
=20
-      i =3D tt->topology =3D=3D TOP_SUBNET ? IFF_BROADCAST : IFF_POINTOPOI=
NT;
-      i |=3D IFF_MULTICAST;
       if (ioctl (tt->fd, TUNSIFMODE, &i) < 0) {
 	msg (M_WARN | M_ERRNO, "ioctl(TUNSIFMODE): %s", strerror(errno));
       }
@@ -2260,12 +2270,33 @@ open_tun (const char *dev, const char *dev_type, co=
nst char *dev_node, struct tu
     }
 }
=20
+/* tun(4): "These network interfaces persist until the if_tun.ko module is=
=20
+ *          unloaded, or until removed with the ifconfig(8) command."
+ *          (verified for FreeBSD 6.3, 7.4, 8.2 and 9, same for tap(4))
+ *
+ * so, to avoid lingering tun/tap interfaces after OpenVPN quits,=20
+ * we need to call "ifconfig ... destroy" for cleanup
+ */
 void
 close_tun (struct tuntap *tt)
 {
   if (tt)
     {
+      struct gc_arena gc =3D gc_new ();
+      struct argv argv;
+
+      /* setup command, close tun dev (clears tt->actual_name!), run comma=
nd
+       */
+
+      argv_init (&argv);
+      argv_printf (&argv, "%s %s destroy",
+                          IFCONFIG_PATH, tt->actual_name);
+
       close_tun_generic (tt);
+
+      argv_msg (M_INFO, &argv);
+      openvpn_execve_check (&argv, NULL, 0, "FreeBSD 'destroy tun interfac=
e' failed (non-critical)");
+
       free (tt);
     }
 }
--=20
1.7.3.5


--HE8xRhbuhm5Vuapo--

--Zp4J6pIOF3L3ZAe7
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTxyAf6kuBuNlUUl1AQJB1gQAwYW9+jhTB2IHV7OCyUDaYXT9VXTkkGRs
fEYhdl3AqVXqkvXfTU4TTv/Eecn8APAq+qTgJkMO8WOuor9dV/+G2FStohW54mmJ
tMjrNzWS6gdU9P22p0uqteN75nUT0bzaekypPW5u95bA2HwcljqdgzyvILvzowXL
9cWkhxaXCCE=
=iSat
-----END PGP SIGNATURE-----

--Zp4J6pIOF3L3ZAe7--

