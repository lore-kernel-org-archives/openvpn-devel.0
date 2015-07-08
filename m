Date: Wed, 8 Jul 2015 20:59:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150708185945.GV382@...1296...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
	<20150703131545.GZ382@...1296...>
	<5596980F.6010600@...1147...> <559D4F39.5000603@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="BAg9oNK6HGMLOT7v"
Content-Disposition: inline
In-Reply-To: <559D4F39.5000603@...1147...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: openvpn-devel@lists.sourceforge.net

--BAg9oNK6HGMLOT7v
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 08, 2015 at 06:26:33PM +0200, Jan Just Keijser wrote:
> >AFAICT windows does support that option (that's what I was referring=20
> >to with options 121 or 249) . OTOH, I am *not* sure if it allows you=20
> >to set a 0.0.0.0/1 route using that option, but I guess there's only=20
> >one way to find out.
>=20
> FWIW: I've patched openvpn to set routes using DHCP on Windows and yes,=20
> it works: I can add any route to the system routing tables, including=20
> 0.0.0.0/1 and 128.0.0.1/1 ; this could be used as an alternative to=20
> requiring elevated privileges.

Unless you can also set the host route for the VPN gateway (point to=20
a gateway on a *different* interface), this is not really helping...=20=20
just adding 2x /1 will just cause recursion as packets to the VPN server=20
will be happily routed into the tap interface again.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--BAg9oNK6HGMLOT7v
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZ1zIKkuBuNlUUl1AQLJiAP/XLtpPmD1XrcuUvTiPLba8Nehrqu6RTGO
yqHCIRZve0oUyd1midKZsMLpokeWmwppCeDEKWIKiaNRR7QNGSKnAMMWum410+yf
irbJwHh1Ungy53xOql9dr/GwLfgQ5eu6JvmhXOPk8s9ksawEZ3Ixiw5EPanaswLG
4yiIaSXaAzU=
=gdgF
-----END PGP SIGNATURE-----

--BAg9oNK6HGMLOT7v--

