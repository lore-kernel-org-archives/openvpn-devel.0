Date: Fri, 9 Dec 2016 08:42:50 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161209074250.GQ78624@...1296...>
References: <1ffbd3a5-8fa8-8992-2c3d-d353898d74f9@...2080...>
	<8000a47e-979c-3afc-1a7a-5f8afab85634@...1856...>
	<CAKuzo_ga48WDGd-g8Xp=L1NbXf0Naez1ZRN3FhcyL247bK72Rg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uWA6ivsFTdIbDdzo"
Content-Disposition: inline
In-Reply-To: <CAKuzo_ga48WDGd-g8Xp=L1NbXf0Naez1ZRN3FhcyL247bK72Rg@...278...>
Subject: Re: [Openvpn-devel] Coding style clean-up ... phase 1
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

--uWA6ivsFTdIbDdzo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 08, 2016 at 05:04:53PM -0500, Selva Nair wrote:
> if (xxxx)
> {
>    ...
> }
> followed by
> else if (xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx) {
>  ....
> }
>=20
> looks inconsitent and not pretty.=20

Thanks, so I'm not alone with this :-)

> Why not just stick to:
>=20
> if (carefree())
> {
>    follow_me();
> }
> else if (cautious())
> {
>    as_you_wish();
> }
> else
> {
>    abort();
> }
>=20
> Looks easier to read.

This!

Maybe it's just my OCD speaking, but=20

  if (something)
  {
      this();
  } else {
      that();
  }

really makes my skin crawl - I need the "i"s dotted, the "t"s crossed,
and braces aligned - vertically or horizontally, but not "diagonally".

So this would work for me, for "trivial conditionals" (=3D short condition,
non-crammed single-line statements):

  if (a>0)
     { do_this(); }
  else
     { do_that(); }

but since we agred on "braces get their own line", it's out as well.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--uWA6ivsFTdIbDdzo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYSmB6AAoJEB2Cnv7KVigS8UwMAJ7FC0p9fosCWMSvgNDbb0Y8
4xj5rdnfMUSRnhmYASzjwBGvDJgtfQtTfYmwnNAUbuEwF6BcKW9qTwUZsK6h9gMD
aMhd7DEpYR8yQAZII6QPg4Z5U7Vyohn9Ig3fEkDo20Mbhu8JpttAqdfVfP4k+gnr
0HtI1+/3Lwris2OMYEeF3y5QZubHSZu5F/R5m1EkDQhPld+r+4gH+ML1cpdSE4v/
FjgO73xh2zeFcroE3Chd8xeFsKGs6e6UVUtNFrqsUMaeNdtjfc45zEmmiirq581m
wM5sHhzpSWN6pgNDnbz5Mev0k6eGZMI9/PauSmJnysg2ol9tX5mwibyDW46lNCQu
MeUu0Mn9+8KnvAf/iOCUsMbF8AgwVwYbcgWONsTOMSc7jMKKf7H5zR7+vaWKIpfM
fncXO6CeFIeoZu7SbXFUO9qVX4bM199hI4/8XcvdX8mNnu1w5AudXDFdETsIDeb+
UrZCOS6yajSYurwRuVEH0O4DK6PxBfH6ulZ01GWuow==
=MRyt
-----END PGP SIGNATURE-----

--uWA6ivsFTdIbDdzo--

