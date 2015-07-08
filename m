Date: Wed, 8 Jul 2015 21:01:29 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20150708190129.GW382@...1296...>
References: <55966BE0.5090400@...1147...> <55966F4A.7010008@...1114...>
	<559672D0.1030904@...1147...> <20150703115639.GC57772@...2041...>
	<20150703131545.GZ382@...1296...>
	<5596980F.6010600@...1147...> <559D4F39.5000603@...1147...>
	<CAKuzo_g91GRKGN=5vsztpifmhWDsOhy0UYGfesxEzPZowDJuMg@...278...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NZfcDBOYFQnnI1of"
Content-Disposition: inline
In-Reply-To: <CAKuzo_g91GRKGN=5vsztpifmhWDsOhy0UYGfesxEzPZowDJuMg@...278...>
Subject: Re: [Openvpn-devel] Adding routes on Windows using DHCP
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--NZfcDBOYFQnnI1of
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

hi,

On Wed, Jul 08, 2015 at 02:22:36PM -0400, Selva Nair wrote:
> On Wed, Jul 8, 2015 at 12:26 PM, Jan Just Keijser <janjust@...1147...> wr=
ote:
>=20
> > FWIW: I've patched openvpn to set routes using DHCP on Windows and yes,
> > it works: I can add any route to the system routing tables, including
> > 0.0.0.0/1 and 128.0.0.1/1 ; this could be used as an alternative to
> > requiring elevated privileges.
>
> This is excellent news. Is routing the only function that needs admin
> privileges on windows while starting openvpn?

It's less excellent than it might sound - anything IPv4-only is not good
enough in 2015 (and I have my doubts that it will be able to do the
redirect-gateway work needed in a large number of VPn cases - but might be
pleasantly surprised).

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--NZfcDBOYFQnnI1of
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVZ1ziakuBuNlUUl1AQKSggP7BCQCqh3q/6ZYAh08RKCM9d0ogVBTRynf
/z7VjtwBsulMYRw1zg9DYwSl4USLmA61jYTmSlU3YYmaOHlu3Xe13LviBNVoXjOh
UA0qSL1teiJZ1oKcNOBDrq3NIzufa6HuhIOkwDAVc8UGrsqjeRiUUYOv+tQ7s/mt
EeneBDOD0yc=
=I6qv
-----END PGP SIGNATURE-----

--NZfcDBOYFQnnI1of--

