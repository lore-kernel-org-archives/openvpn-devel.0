From: Petre Rodan <kaiowas@...594...>
Subject: Re: [Openvpn-devel] [PATCH] Stick routes to interfaces for Linux
Message-ID: <20060428191757.GB6529@...619...>
References: <200604072030.52833.uberlord@...594...> <200604132240.07989.uberlord@...594...> <20060417172228.GB25449@...619...> <200604281128.46146.uberlord@...594...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RASg3xLB4tUQ4RcS"
Content-Disposition: inline
In-Reply-To: <200604281128.46146.uberlord@...594...>
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
Date: Fri Apr 28 16:23:02 2006
To: Roy Marples <uberlord@...594...>
Cc: openvpn-devel@lists.sourceforge.net

--RASg3xLB4tUQ4RcS
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline


Hi Roy,

On Fri, Apr 28, 2006 at 12:28:46PM +0100, Roy Marples wrote:
> On Monday 17 April 2006 18:22, Petre Rodan wrote:
> > I have the following on the server's setup:
> >
> > push "route 10.0.0.0 255.255.255.0"
> > push "route 0.0.0.0 0.0.0.0"
> > push "redirect-gateway local"
>=20
> .. snip ..
>=20
> >
> > but with a patched beta14 version, I end up having 2 default gateways:
> >
> > it basically fails to remove my old default gateway.
>=20
> I don't see that as an error as you're pusing a new gateway "route 0.0.0.=
0=20
> 0.0.0.0" and you're saying redirect local.
>=20
> So you would want to do either one or the other.

	if "redirect-gateway local" would have worked as expected, I would not be =
forced to also use "route 0.0.0.0 0.0.0.0". the thing is that if only "redi=
rect-gateway local" is used and the client does not have a default route, a=
 default route will NOT be added when openvpn is started [1].

	how does one end up not having a default gateway? simple. just stop the op=
envpn client, and you end up with no more default route. (only if that defa=
ult route was placed there by openvpn itself of course)

IMHO "redirect-gateway local" should either set a default route even if one=
 has not been found OR restore the default gateway he changed (on exit). ot=
herwise I find it's usefulness limited.

to summarize, the 'push "route 0.0.0.0 0.0.0.0"' is used to force the clien=
t to have a default route thru the tun device (whatever state the client is=
 in),
and 'push "redirect-gateway local"' is used to remove the old default gatew=
ay of the client, if one was present at the time openvpn was started. if I =
remove either of them, the client will be unable to use the network as expe=
cted. having a higher metric on the original default gateway fixes the prob=
lem, but not all clients have an elevated metric for the gateway.

[1]
Apr 28 21:33:21 [openvpn] /sbin/ifconfig tun0 10.0.2.6 pointopoint 10.0.2.5=
 mtu 1500
Apr 28 21:33:21 [openvpn] NOTE: unable to redirect default gateway -- Canno=
t read current default gateway from system
# route -n | grep '^0.0.0.0' &>/dev/null || echo 'no default here'
no default here

cheers,
petre rodan

--=20
petre rodan
<kaiowas@...594...>
Developer,
Hardened Gentoo Linux

--RASg3xLB4tUQ4RcS
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.3-ecc0.1.6 (GNU/Linux)

iD8DBQFEUmplGSBEIeh4AEYRAmSAAJ9+KI8P99bnXO9b5u+LcJgXKpZVXwCaA4id
76+6YQWN25VXWeh0YSOCVBQ=
=qNsT
-----END PGP SIGNATURE-----

--RASg3xLB4tUQ4RcS--

