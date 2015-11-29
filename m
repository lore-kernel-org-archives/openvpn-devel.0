Date: Sun, 29 Nov 2015 14:50:15 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20151129135015.GI24952@...1296...>
References: <20151124083944.GY24952@...1296...>
	<5654A314.3080607@...2070...>
	<20151124201135.GM24952@...1296...>
	<CAKuzo_jdcOjunyVmpT8er3HqWG7yh6pr+i8Tn8kD3omj=G_Pqw@...278...>
	<565547AB.9030607@...2070...>
	<20151125075416.GR24952@...1296...>
	<CAKuzo_iUzeYSWWvbpyV5RY_FwoNMm=97cfo0-uzeMFQKki3sWg@...278...>
	<5655C387.40805@...1227...>
	<20151125145439.GV24952@...1296...>
	<052201d127a1$a07c65a0$e17530e0$@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uAus+51RoTEkR1XP"
Content-Disposition: inline
In-Reply-To: <052201d127a1$a07c65a0$e17530e0$@gmail.com>
Subject: Re: [Openvpn-devel] [PATCH v4-master] Add Windows DNS Leak fix
 using WFP ('block-outside-dns')
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Fish Wang <fish.thss@...277...>
Cc: 'openvpn-devel' <openvpn-devel@lists.sourceforge.net>

--uAus+51RoTEkR1XP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Nov 25, 2015 at 08:52:09AM -0800, Fish Wang wrote:
> Just a small suggestion: I think the following will work:
>=20
> - Check the version of the current operating system.
> - Dynamically loading related DLLs (in this case, should be WFP-related
> libraries) using LoadLibrary() only if OpenVPN is running Windows Vista+,
> and pops a warning for XP users who has that option enabled.
> - On Vista+, get addresses of those APIs that we want to call (via
> GetProcAddress() ), and then use them as function pointers.
>=20
> Pros: one binary works for all Windows.
> Cons: the code is a bit messier.=20
>=20
> I've done this before for my own projects that must be running on both XP
> and later versions of Windows, and it works reliably. I can look into this
> later this week (if ValdikSS doesn't have cycles).

This would definitely be something I'd like to have a look at.

Depending how *much* messier the code gets (especially: what settings does
it need to get built?  WINXP or VISTA?) this might be a good way to avoid
having to build two different openvpn.exe executables.

OTOH, we need two installers anyway as the NDIS6 tap driver does not work
on XP - so if we bundle openvpn-xp.exe with the old tap driver and
openvpn-vista+.exe with the ndis6 tap driver, it's not that much worse than
what we have now...

And yes, time to get 2.4 out :-)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uAus+51RoTEkR1XP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVlsClqkuBuNlUUl1AQJrkAP/brO6KBpZl42k6sPVN0TW54EANojkKIxG
sXBO6Asric6gnSa4bQ9ADaz8tzpapkeuaXiJZu1E5idAkF7DmgDWL5gqyUWwiAxN
yBb78HukwLuasO8MWmusfDLf5TFUSW6vSLUcqdSORMgVYGfhYZM0YJRPXWBnE+G7
N5KwUbV14R8=
=f+TG
-----END PGP SIGNATURE-----

--uAus+51RoTEkR1XP--

