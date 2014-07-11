Date: Fri, 11 Jul 2014 14:35:41 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140711123541.GG1118@...1296...>
References: <53BF9998.5020906@...1921...> <53BFA5AA.4070305@...1147...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="RYLajQ58OAnL4YcY"
Content-Disposition: inline
In-Reply-To: <53BFA5AA.4070305@...1147...>
Subject: Re: [Openvpn-devel] [PATCH] Add topology in sample server
	configuration file
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

--RYLajQ58OAnL4YcY
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jul 11, 2014 at 10:51:54AM +0200, Jan Just Keijser wrote:
> On 11/07/14 10:00, Philipp Hagemeister wrote:
> >On modern systems, topology subnet should always be set, but it's
> >missing in the configuration file.
> >Add it with a short explanation.
> NACK
> There are a few annoying issues with
>   topology subnet
> esp when using server side things like
>   route <remote subnet> <mask>
>=20
> that will *fail* with 'topology subnet' ; until this is fixed this=20
> should NOT be considered the default.

Well, it's on the roadmap, and Arne has already sent a patch.

So, what other issues exist?  This is the only one I'm aware of...=20
(and the recent trac ticket about "topology subnet not working on
FreeBSD 10" turned out to be local confusion...)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--RYLajQ58OAnL4YcY
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQCVAwUBU7/aHKkuBuNlUUl1AQLD5wP6A4vP3lL9H/4ABx204QUYlKmsAG8LPuG5
3S/6xHhWD+NHx01cHXrTIBROgp24fXF4ABKZNOUSH0bJPW00iF34abOhaYEJXkdn
4EepHnb/VcWQokSO1Wea1u51v4OIYnzpxQQfV1asBfsIA0YFseidUd2UzHrCXxt/
J12T/LyFYtA=
=L56E
-----END PGP SIGNATURE-----

--RYLajQ58OAnL4YcY--

