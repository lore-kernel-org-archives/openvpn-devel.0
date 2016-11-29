Date: Tue, 29 Nov 2016 08:32:09 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20161129073209.GB1013@...1296...>
References: <68d50540-ec71-5564-99a7-7bb24ae05d17@...1856...>
	<1480371252-3880-1-git-send-email-steffan@...1856...>
	<13ea5e26-9628-ef57-13b7-50b4041745ca@...2080...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="IiVenqGWf+H9Y6IX"
Content-Disposition: inline
In-Reply-To: <13ea5e26-9628-ef57-13b7-50b4041745ca@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce and use secure_memzero()
 to erase secrets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--IiVenqGWf+H9Y6IX
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 29, 2016 at 12:36:25AM +0100, David Sommerseth wrote:
> If we "do not care" if a memory region is wiped or not (just that it's
> nice if it happens), then I'd say these are code paths which *do* *not*
> require CLEAR() at all.

"wiping" and "clearing a structure before using, so everything is=20
well-defined" are two very different things.

> If we *know* a certain memory region *must* be cleared, then we do the
> proper call which does what it promises us.

CLEAR() will also do what it promises: that the block in question is
zeroed *for subsequent use*.

What it does not promise is "if we never use it again, it is cleared
nevertheless" - that's what secure_memzero() is for.

One thing is "initialization before use", one is "scrubbing so secret
material doesn't leak *after* use".


Different requirements, different functions.  Reasonable approach.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--IiVenqGWf+H9Y6IX
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJYPS75AAoJEB2Cnv7KVigSc7AL/i+rmm6B7pIqHhJWzLxklcXS
Z3xd8D6LF5Q7g4cMDOUdS0xG/ZErLYGh/WRy8+2A0Ng08o+jpVP08SvF52j6SXoz
269C27k2sgl1SJiiBelpXrCnRa2MbcSZxot4yigpeiBOqVxpip4iUmv5b/aEkt5G
ej3EEqTU6a0H4K5pVer2+8F7JvNre5gQxBQngwkWzkbBHM0C3KIuCWzHRaYnqXut
H1+ACkKnMlnJnM5D09oBtYOqRCGxC8M8vjMYyjDZsBnll4+Pbjsh+jYOBgRH91zU
ysbXq4+wUYSTrfqqT1vP6k0ZiwmGbY6njjKJK94I+LhTqLpOYZ0OXSpftP4GDHaH
pDGljNve/dUNococ23V7CYl6Sm5HRJWnHwlzvxZ7DQ77GZIdXNBcaOLTgrsedijr
RSZYN+J+NAO+fbuV1/k77qFIiJ0L5BSKJoPfEXwSOsIBVx0/K+noMTU1Fy4ZqKE4
Chcxw/AdqHABSLQI2x465NCEyPs0laN6v7DYIqedZA==
=kpIS
-----END PGP SIGNATURE-----

--IiVenqGWf+H9Y6IX--

