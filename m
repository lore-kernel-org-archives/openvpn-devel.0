From: Petre Rodan <kaiowas@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Stick routes to interfaces for Linux
Message-ID: <20060417172228.GB25449@...619...>
References: <200604072030.52833.uberlord@...594...> <443EB57C.2080801@...41...> <200604132201.18627.uberlord@...594...> <200604132240.07989.uberlord@...594...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="U+BazGySraz5kW0T"
Content-Disposition: inline
In-Reply-To: <200604132240.07989.uberlord@...594...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Apr 17 10:24:00 2006
To: openvpn-devel@lists.sourceforge.net

--U+BazGySraz5kW0T
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


hi,

On Thu, Apr 13, 2006 at 11:40:07PM +0100, Roy Marples wrote:
> On Thursday 13 April 2006 22:01, Roy Marples wrote:
> > On Thursday 13 April 2006 21:33, James Yonan wrote:
> > > Roy Marples wrote:
> > > > In some instances, Linux requires routes being stuck to interfaces
> > > > instead of floating. Mainly in virtual environments like Xen and Qe=
mu.
> > > >
> > > > Attached is a patch that addresses this issue.
> > >
> > > What about the case where you don't want to associate a route with the
> > > tun/tap interface, such as when you're doing the routing dance to make
> > > --redirect-gateway work?
> >
> > Not too sure to be truthfull as I don't use that option. I prefer to ha=
ve
> > both default routes separated by a metric instead. This works very well
> > when you have 3 interfaces, wired, wireless and vpn and they all provide
> > default routes. In this instance we need to give them metrics and tie t=
hem
> > to an interface using Linux.
>=20
> Initial testing shows that it has no adverse effects. Of course, it's my =
patch=20
> and I'm biased :P

I have the following on the server's setup:

push "route 10.0.0.0 255.255.255.0"
push "route 0.0.0.0 0.0.0.0"
push "redirect-gateway local"

this is intended so that the client would change his default gateway (even =
if one is not present at the time openvpn is started). it works with the un=
patched beta14:

Apr 17 19:56:02 [openvpn] PUSH: Received control message: 'PUSH_REPLY,route=
 10.0.0.0 255.255.255.0,route 0.0.0.0 0.0.0.0,redirect-gateway local,route =
10.0.2.0 255.255.255.0,topology net30,ping 10,ping-restart 120,ifconfig 10
Apr 17 19:56:02 [openvpn] /sbin/ifconfig tun0 10.0.2.6 pointopoint 10.0.2.5=
 mtu 1500
Apr 17 19:56:02 [openvpn] NOTE: unable to redirect default gateway -- Canno=
t read current default gateway from system
Apr 17 19:56:02 [openvpn] /sbin/route add -net 10.0.0.0 netmask 255.255.255=
.0 gw 10.0.2.5
Apr 17 19:56:02 [openvpn] /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 1=
0.0.2.5
Apr 17 19:56:02 [openvpn] /sbin/route add -net 10.0.2.0 netmask 255.255.255=
.0 gw 10.0.2.5

# route -n
[..]
0.0.0.0         10.0.2.5        0.0.0.0         UG    0      0        0 tun0

but with a patched beta14 version, I end up having 2 default gateways:

Apr 17 20:02:10 [openvpn] PUSH: Received control message: 'PUSH_REPLY,route=
 10.0.0.0 255.255.255.0,route 0.0.0.0 0.0.0.0,redirect-gateway local,route =
10.0.2.0 255.255.255.0,topology net30,ping 10,ping-restart 120,ifconfig 10.=
0.2.6 10.0.2.5'
Apr 17 20:02:10 [openvpn] /sbin/ifconfig tun0 10.0.2.6 pointopoint 10.0.2.5=
 mtu 1500
Apr 17 20:02:10 [openvpn] /sbin/route del -net 0.0.0.0 netmask 0.0.0.0 dev =
tun0
Apr 17 20:02:10 [openvpn] ERROR: Linux route delete command failed: shell c=
ommand exited with error status: 7
Apr 17 20:02:10 [openvpn] /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 1=
0.0.2.5 dev tun0
Apr 17 20:02:10 [openvpn] /sbin/route add -net 10.0.0.0 netmask 255.255.255=
.0 gw 10.0.2.5 dev tun0
Apr 17 20:02:10 [openvpn] /sbin/route add -net 0.0.0.0 netmask 0.0.0.0 gw 1=
0.0.2.5 dev tun0
Apr 17 20:02:10 [openvpn] ERROR: Linux route add command failed: shell comm=
and exited with error status: 7
Apr 17 20:02:10 [openvpn] /sbin/route add -net 10.0.2.0 netmask 255.255.255=
.0 gw 10.0.2.5 dev tun0

# route -n
[..]
0.0.0.0         10.0.2.5        0.0.0.0         UG    0      0        0 tun0
0.0.0.0         10.0.1.1        0.0.0.0         UG    0      0        0 wla=
n0

it basically fails to remove my old default gateway.

should I use a different push mechanism?

> Maybe someone else could test and chip in? Or enable it by default in the=
 next=20
> beta and see what breaks if anything. The patch is trivial and could easi=
ly=20
> be removed in any case.
>=20
> Thanks
>=20
> --=20
> Roy Marples <uberlord@...594...>
> Gentoo Linux Developer
>=20
>=20
> -------------------------------------------------------
> This SF.Net email is sponsored by xPML, a groundbreaking scripting langua=
ge
> that extends applications into web and mobile media. Attend the live webc=
ast
> and join the prime developer group breaking into this new coding territor=
y!
> http://sel.as-us.falkag.net/sel?cmd=3Dlnk&kid=3D110944&bid=3D241720&dat=
=3D121642
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

cheers,
peter

--=20
petre rodan
<kaiowas@...594...>
Developer,
Hardened Gentoo Linux=20

--U+BazGySraz5kW0T
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2-ecc0.1.6 (GNU/Linux)

iD8DBQFEQ87UGSBEIeh4AEYRAntNAJ9S/jFPRN/Zu90qPE0o9JBGEBh4wACfWFyD
kpyHLt+/zBSq+05TwDAc10o=
=37a1
-----END PGP SIGNATURE-----

--U+BazGySraz5kW0T--

