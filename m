Date: Tue, 21 Oct 2014 11:11:59 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20141021091159.GY396@...1296...>
References: <54450921.30501@...515...> <54461F20.5060908@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sB5q8U+2Z60V3VP3"
Content-Disposition: inline
In-Reply-To: <54461F20.5060908@...1147...>
Subject: Re: [Openvpn-devel] New OpenVPN Windows installers (I004 and I604)
	released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>, "openvpn-users@lists.sourceforge.net" <openvpn-users@lists.sourceforge.net>

--sB5q8U+2Z60V3VP3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Oct 21, 2014 at 10:53:52AM +0200, Jan Just Keijser wrote:
> Running the gui with elevated privileges fixes this issue. Shouldn't the=
=20
> installer have created this registry key?

The GUI need to run with elevated privileges anyway, because otherwise=20
OpenVPN cannot install routes...

This will hopefully be fixed in 2.4 with the interactive service, we just
need to find time for Heiko to find the code and send it to us :-) (but
I've already seen it last year)

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--sB5q8U+2Z60V3VP3
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBVEYjXqkuBuNlUUl1AQIZAQP9FvjBkrOcyHGxCozGmVyRTbHp8lIyOLnj
igHAPEq0XyzU9r2QILkTWRu2Jl8iFwVh/Sb01xI9mV1B9iK2dKADmsGMVqGyJt7m
yWjPIh3mf7ha+9d57eWtQAioxQxCDEt0UqlcqGqOhIBo4aGbbW3RsEgrQLbcQWsu
Si9PEhg1W/c=
=bHwr
-----END PGP SIGNATURE-----

--sB5q8U+2Z60V3VP3--

