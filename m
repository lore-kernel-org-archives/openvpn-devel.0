Date: Tue, 2 Aug 2022 14:27:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YukYNOwpaIeA7j80@...1296...>
References: <20211213162841.15763-1-frank@...2641...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="pGX+Q8ervBbkUoVn"
Content-Disposition: inline
In-Reply-To: <20211213162841.15763-1-frank@...2641...>
Subject: Re: [Openvpn-devel] [PATCH] Make build deterministic,
 remove __DATE__
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: openvpn-devel@lists.sourceforge.net

--pGX+Q8ervBbkUoVn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Dec 13, 2021 at 05:28:41PM +0100, Frank Lichtenheld wrote:
> The information provided by this is minimal
> and it makes it more difficult to provide
> deterministic builds. There are work-arounds
> for that but I think it is easier to just remove
> it completely.
>=20
> Allows the build to pass with -Wdate-time -Werror.
>=20
> Signed-off-by: Frank Lichtenheld <frank@...2641...>

I see that this patch has two ACKs, but I feel I'd lose visibility
into my heap of test binaries all over the place.

OTOH, I do see the argument about deterministic (release) builds.

What we already do today is to include the git commit ID *iff* this
is built from git into CONFIGURE_GIT_REVISION (version.h) - maybe
this could be done in a similar way?

 - if there is no .git around (and/or $condition?), build without
   commit ID and no build date

 - if there is, add build date + git revision to "openvpn --version"

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--pGX+Q8ervBbkUoVn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJi6Rg0AAoJEB2Cnv7KVigSkW8L/iL/EITuXyoR/TNyOpMCouED
3HLNH7x5/YMOrINzU5p8ShvIsomPYvxfUj4rwoc/RvCDbiLId3VylPs8T+mNnuJG
0zWOpe4iW2uWqYlSg6YnviypN7qnDIEm7Gqasu0+CAzD5JTMAICGBRhXCWUos2zP
LXzm+KwyFGtmTCwPoD13gIeWjDY4LZsXGDqk9xWuB0IWI2J6q+MFAztv5uvRBKRm
Wh5FB80EigALsv1fhLBJxchBNHM+Vb58ajvvMVIlBTUnLPwlA4nr31XSyohTFlLH
0c/LhsiqzNh9s3NOtmwDh9tpR0solUOSQESs6RKEpCkynf3Ppd4clUpOX6ZeclHL
DBXi9yXqPb+tAtyYyZT/P71dQoqIvhdBTUuPa2RvSyA2bsb4A0k2jQmq9ZdTdon0
FWphMDrvm5Uu7Y/s3thLxTClaD2iizvQt0IvGRVx3T9YNbM6Vz1wBSQNUYqZiYbM
riX5vGOVNubSaND3LWqK+KiZGj9SWYy4LhKxqJtAMg==
=ojeL
-----END PGP SIGNATURE-----

--pGX+Q8ervBbkUoVn--

