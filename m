Date: Tue, 11 Oct 2022 21:11:25 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Y0W/3bWLuTuYZvxs@...1296...>
References: <20220812134154.16729-3-kprovost@...2661...>
 <202208201401.27KE12Cm014083@...2054...>
 <YwDwvG++hK0nJI2F@...1296...>
 <21B552DE-38FE-41F0-8FC7-606EA4C06093@...1376...>
 <Yz72rrCsJCjBgE4T@...1296...>
 <3B9F182D-0936-4799-B1B0-D269DBB3C2E6@...1376...>
 <Yz/35K6JddVNg9F9@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="8N6mHaQCCpBGpMMF"
Content-Disposition: inline
In-Reply-To: <Yz/35K6JddVNg9F9@...1296...>
Subject: Re: [Openvpn-devel] route/iroute handling on FreeBSD
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristof Provost <kp@...1249...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--8N6mHaQCCpBGpMMF
Content-Type: multipart/mixed; boundary="nyxAIoxNGpPDWa4M"
Content-Disposition: inline

--nyxAIoxNGpPDWa4M
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Oct 07, 2022 at 11:56:52AM +0200, Gert Doering wrote:
> I'll dig into the POINTTOPOINT issue... configure a real MULTIPOINT
> interface for --topology subnet (which is something I've always avoided
> so far, because "we know the other stuff works")

This is... an interesting problem.

Changing the tun(4) stuff to do IFF_BROADCAST for "topology subnet"
is straightforward, and makes the whole code much simpler actually
(and you can do "ifconfig tun7 1.2.3.4/24" and have it actually do
what you expect "here is a subnet, with 255 different next-hop IPs
available for routing").  Patch is attached so you can see what
I'm talking about :-)

Butbut... ovpn(4) does not support the TUNSIFMODE ioctl() to set
something that is not IFF_POINTOPOINT, so we fail with

    2022-10-11 20:58:28 ioctl(TUNSIFMODE): Can't assign requested address (=
errno=3D49)
    2022-10-11 20:58:28 DCO device tun14 opened
    2022-10-11 20:58:28 /sbin/ifconfig tun14 10.194.3.56/24 mtu 1500 up
    ifconfig: ioctl (SIOCAIFADDR): Destination address required
    2022-10-11 20:58:28 FreeBSD ifconfig failed: external program exited wi=
th error status: 1
    2022-10-11 20:58:28 Exiting due to fatal error


@kp, not sure how to move forward.  What we need is a "true on-link
subnet", so installation of iroutes to "peer #4" works (which it
doesn't today), and I think that means "ovpn(4) needs to learn=20
IFF_BROADCAST".


OTOH, in "not peer2peer mode", we only support topology subnet anyway,
so maybe it should autoconfigure that, depending on the mode OpenVPN
requests (p2p mode -> IFF_POINTOPOINT, p2mp mode -> IFF_BROADCAST),
so we don't even need TUNSIFMODE.

Looking into if_ovpn.c, this is a bit beyond my understanding of the
code, though...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--nyxAIoxNGpPDWa4M
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-FreeBSD-for-topology-subnet-put-tun-interface-into-I.patch"
Content-Transfer-Encoding: quoted-printable

=46rom 02f74941b29532f977be58205202eb2ccb21b12e Mon Sep 17 00:00:00 2001
=46rom: Gert Doering <gert@...1296...>
Date: Tue, 11 Oct 2022 19:54:23 +0200
Subject: [PATCH] FreeBSD: for topology subnet, put tun interface into
 IFF_BROADCAST mode

For reasons unknown, OpenVPN has always put FreeBSD tun(4) interfaces
into point-to-point mode (IFF_POINTOPOINT), which means "local and
remote address, no on-link subnet".

"--topology subnet" was emulated by adding a subnet-route to the "remote"
(which was just picking a free address from the subnet).

This works well enough for classic tun(4) interfaces that have no
next-hop resolution, and routes pointing to "that fake remote" only
(because all routing is done inside OpenVPN and it does not matter how
packets get there) - but for ovpn(4) interfaces, it breaks iroute setup,
where the route next-hop must be an on-link address.

Thus, change interface to IFF_BROADCAST mode, and get rid of all the
special code needed to "fake" subnet mode.

Tested with tun(4) and ovpn(4) on FreeBSD 14, client and server, and
with tun(4) on FreeBSD 12 and 7.4

Signed-off-by: Gert Doering <gert@...1296...>
---
 Changes.rst       |  5 +++++
 src/openvpn/tun.c | 28 ++++++++++------------------
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index df56f76a..0397cb94 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -163,6 +163,11 @@ User-visible Changes
 - :code:`link_mtu` parameter is removed from environment or replaced with =
0 when scripts are
   called with parameters. This parameter is unreliable and no longer inter=
nally calculated.
=20
+- FreeBSD tun interfaces with ``--topology subnet`` are now put into real
+  subnet mode (IFF_BROADCAST instead of IFF_POINTOPOINT) - this might upset
+  software that enumerates interfaces, looking for "broadcast capable?" and
+  expecting certain results.  Normal uses should not see any difference.
+
 Overview of changes in 2.5
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
=20
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ddee49f9..ede65cbe 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1479,8 +1479,6 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifnam=
e, int tun_mtu,
=20
 #elif defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY)
=20
-    in_addr_t remote_end;           /* for "virtual" subnet topology */
-
     /* example: ifconfig tun2 10.2.0.2 10.2.0.1 mtu 1450 netmask 255.255.2=
55.255 up */
     if (tun)
     {
@@ -1490,10 +1488,9 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifna=
me, int tun_mtu,
     }
     else if (tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SUBNE=
T)
     {
-        remote_end =3D create_arbitrary_remote( tt );
-        argv_printf(&argv, "%s %s %s %s mtu %d netmask %s up", IFCONFIG_PA=
TH,
-                    ifname, ifconfig_local, print_in_addr_t(remote_end, 0,=
 &gc),
-                    tun_mtu, ifconfig_remote_netmask);
+        int netbits =3D netmask_to_netbits2(tt->remote_netmask);
+        argv_printf(&argv, "%s %s %s/%d mtu %d up", IFCONFIG_PATH,
+                    ifname, ifconfig_local, netbits, tun_mtu );
     }
     else
     {
@@ -1504,18 +1501,6 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifna=
me, int tun_mtu,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, S_FATAL, "FreeBSD ifconfig failed");
=20
-    /* Add a network route for the local tun interface */
-    if (!tun && tt->type =3D=3D DEV_TYPE_TUN && tt->topology =3D=3D TOP_SU=
BNET)
-    {
-        struct route_ipv4 r;
-        CLEAR(r);
-        r.flags =3D RT_DEFINED;
-        r.network =3D tt->local & tt->remote_netmask;
-        r.netmask =3D tt->remote_netmask;
-        r.gateway =3D remote_end;
-        add_route(&r, tt, 0, NULL, es, NULL);
-    }
-
 #elif defined(TARGET_AIX)
     {
         /* AIX ifconfig will complain if it can't find ODM path in env */
@@ -2949,12 +2934,19 @@ open_tun(const char *dev, const char *dev_type, con=
st char *dev_node, struct tun
=20
         if (tt->fd >=3D 0 && tt->type =3D=3D DEV_TYPE_TUN)
         {
+            /* see "Interface Flags" in ifnet(9) */
             int i =3D IFF_POINTOPOINT | IFF_MULTICAST;
+            if (tt->topology =3D=3D TOP_SUBNET)
+            {
+                i =3D IFF_BROADCAST | IFF_MULTICAST;
+            }
=20
             if (ioctl(tt->fd, TUNSIFMODE, &i) < 0)
             {
                 msg(M_WARN | M_ERRNO, "ioctl(TUNSIFMODE)");
             }
+
+            /* multi_af mode for v4+v6, see "tun(4)" */
             i =3D 1;
             if (ioctl(tt->fd, TUNSIFHEAD, &i) < 0)
             {
--=20
2.37.3


--nyxAIoxNGpPDWa4M--

--8N6mHaQCCpBGpMMF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjRb/dAAoJEB2Cnv7KVigSkbwL/36Z3Kgrxb68mrYgQ93XCan2
q/ilGIAP7oxHxWerTPFxWDaR3JpocXVw21AZhOkCK0OM4ht+Cy99xjpbhQQGcNj/
Ep2MCSEdcg+YkmY7VZ8NmIw9YlFlFvmdw0j/U7bgl2A8hn93bFPcmsNIu7+D7XvC
dlfwhp8R0M1sVtDnODvX5WDtv9EDcrNZ0KWm+tWOBYqDE49AXq+BwulwcYVOK2X3
v0bsMjAKZSiEMK4I70owChMAteHoR0+4W/poUg/UCfhTHVC5bSG0M5ZHBRany2ol
jJBzWlXl0djTkgCUbJbbINftbdDrv5uAdv4YPVYbbE+NfDFYFe6NiBHVyMn3WOjc
PyiAEaIB0Z1IO17bUlbvWgi+iHWoVE5FGA5bI8vkaKSp2L4f3bgxzATlCZ6CoKUB
68OzJ2yAKGUTjLVOQ93LyKPLy3h2nsUinz3CexYK1Yh4AISBZbbow6zGsv6lCrU/
JQfA2AKGpu92dIShLXyMw9/XhhdwIZ+tAGBDvz20tw==
=1WXT
-----END PGP SIGNATURE-----

--8N6mHaQCCpBGpMMF--

