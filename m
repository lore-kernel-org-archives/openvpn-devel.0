Date: Wed, 30 Jul 2014 11:37:48 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140730093748.GH1118@...1296...>
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
	<53D803BE.1040500@...1926...>
	<20140729210527.GY1118@...1296...>
	<53D84749.6060601@...1926...>
	<20140730054253.GC1118@...1296...>
	<53D8BAEE.7030402@...1926...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Ay5ZYbEuU6AKGwz0"
Content-Disposition: inline
In-Reply-To: <53D8BAEE.7030402@...1926...>
Subject: Re: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6
	transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Julien Muchembled <jm@...1926...>
Cc: openvpn-devel@lists.sourceforge.net

--Ay5ZYbEuU6AKGwz0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 30, 2014 at 11:29:18AM +0200, Julien Muchembled wrote:
> > I know that part, but the ICMP packets are seen by the kernel, not by
> > OpenVPN.  So how does the information arrive in OpenVPN?  sendto() fail=
s,
> > but how does OpenVPN know which max message size will be acceptable?
>=20
> Although I didn't try all MTU-related options of OpenVPN, it seems to=20
> ignore EMSGSIZE.=20

Well, handling that error will not lead anywhere, as it just tells us
"the packet got lost, because it was too big".  More interesting is the
information "so, how big is 'not too big'" and that won't be in the=20
error code, but most likely in ancilliary socket data.

I'll go and find out...

> It's not something I planned to study immediately and I don't know how to=
 get the maximum message size programmatically (I could look at the code of=
 ping).
>=20
> What I can say is by only adding '--mtu-disc yes' option, the MTU of the =
tun/tap interface remains 1500 and does not change automatically to anythin=
g else. If a packet is small enough for mtu=3D1500 but too big for the unde=
rlying network, then it's simply dropped.

We won't change the interface MTU (because on half the platforms, we can't,
or it won't have an effect), but OpenVPN is likely to fragment internally.=
=20=20
So "--mtu-disc yes" would need to go along with "--fragment".

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--Ay5ZYbEuU6AKGwz0
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9i87KkuBuNlUUl1AQKQAQP/UlCPwe0l4U5steuXvKsmXBoVirPGFCs6
rU4tilzkdmiBHBvhfo1gDbHTGXV619vv3KqWRiUVMUx5iosQmD1zFJzXelTrAj71
/TTSPWdgU9tj/CQ8aZd33z6CxDvY8RvIqQopYoJlkqg2adp9c43XLb6y47bnDmIg
KEKKCxQYSKs=
=cm+g
-----END PGP SIGNATURE-----

--Ay5ZYbEuU6AKGwz0--

