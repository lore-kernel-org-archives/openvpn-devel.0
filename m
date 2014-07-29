Date: Tue, 29 Jul 2014 23:05:27 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140729210527.GY1118@...1296...>
References: <1406654929-6079-1-git-send-email-jm@...1926...>
	<20140729185713.GX1118@...1296...>
	<53D803BE.1040500@...1926...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="jgbxkEQ9DfXt1AKk"
Content-Disposition: inline
In-Reply-To: <53D803BE.1040500@...1926...>
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

--jgbxkEQ9DfXt1AKk
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Jul 29, 2014 at 10:27:42PM +0200, Julien Muchembled wrote:
> > Is there documentation for that socket option somewhere?
>=20
> 'man 7 ip' and 'man 7 ipv6'

Thanks, will read up.

> For example:
>   A --[mtu=3D1500]-- B --[mtu=3D1400]-- C
>=20
> Given a UDP6 socket on A with IPV6_MTU_DISCOVER=3DIP_PMTUDISC_DO,
>     sendto(1452 bytes, B) will succeed
> but sendto(1452 bytes, C) will return EMSGSIZE (except for the first send=
 to C)
> Yes, at some point, there are icmp packets.

So (being lazy again, sorry) how is the maximum message size communicated
back to OpenVPN?  Ancilliary data again?

> > (Last not least, because I'm too lazy to look: is that patch against
> > git master or against release/2.3?)
>=20
> master

Thanks.  I'll need to look at the code paths, but I think it warrants
inclusion in 2.3 as well - it's not affecting anything that is IPv4,=20
and fixes a bug for IPv6.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--jgbxkEQ9DfXt1AKk
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU9gMl6kuBuNlUUl1AQISPwP/U7ySeNCbjRsQ4KzSCAO2qIlRMj8L8r5C
9voJ8jaN82PfS25g5Yv1Lr6mXUChMC+5gOwPJegnBn0FJ5UqVeQkK/+PmZVq48r1
c1UNGdG95/19mOf+uz6h1I+j3mehX2XxOmeS2wUtZE1wzrfmI5F3Kljgsy0tRrdQ
Z/KaRYbG+4Q=
=9Ien
-----END PGP SIGNATURE-----

--jgbxkEQ9DfXt1AKk--

