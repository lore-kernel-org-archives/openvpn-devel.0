Date: Wed, 18 Apr 2012 08:54:18 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120418065418.GG1359@...1296...>
References: <4F8D6C6F.3080403@...1698...> <20120417141612.GF1359@...1296...>
	<4F8DA6C8.60809@...1698...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="r5UKZFo5ar5Icv+k"
Content-Disposition: inline
In-Reply-To: <4F8DA6C8.60809@...1698...>
Subject: Re: [Openvpn-devel] adding ipv6 routes wrong for tap
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Sergey Matveychuk <sem@...1698...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

--r5UKZFo5ar5Icv+k
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 17, 2012 at 09:22:16PM +0400, Sergey Matveychuk wrote:
> Rough changing route command works for me:
>=20
> argv_printf (&argv, "%s add -inet6 %s/%d %s",
> 		ROUTE_PATH,
> 	        network,
> 	        r6->netbits,
> 	        gateway );
>=20
> But I understand it should be done correctly.

On TAP interfaces, in IPv4 you can have the route actually pointing to=20
*other* hosts, not only to the OpenVPN server - and that needs more
infrastructure which isn't fully there yet.

It *is* on my TODO list :)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--r5UKZFo5ar5Icv+k
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT45lGqkuBuNlUUl1AQK3xwP+IPGKvIHgmwP0WU2tkZ/aBf/RB53ZQJAT
SizP2BuG/vlRutayqG1o4+lP+iPW6u4j9kQHlZS9dRIsZilkVaZ52Oqm7uJN+MS5
Gonsyo7YunJZh9zfqvXp5c3H4vTPYpqhFulBmidA1vz7xFh1gihVbL0lgT2ej4Di
fPd4gUaHu8w=
=A3pD
-----END PGP SIGNATURE-----

--r5UKZFo5ar5Icv+k--

