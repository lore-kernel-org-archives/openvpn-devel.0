Date: Fri, 17 Apr 2020 17:36:05 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200417153605.GD1431@...1296...>
References: <20200416113930.15192-1-arne@...1227...>
 <20200417085159.GC1431@...1296...>
 <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="/bcALokiWR3y46GP"
Content-Disposition: inline
In-Reply-To: <4a4c73df-6771-8862-2ae0-274a98ee2158@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Use crypto library functions for
 const time memcmp when possible
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--/bcALokiWR3y46GP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Apr 17, 2020 at 03:42:49PM +0200, Antonio Quartulli wrote:
> >> -static inline int
> >> -memcmp_constant_time(const void *a, const void *b, size_t size)
> >> -{
> >=20
> > Not sure I understand the motivation for this change.  "Just so uncrust=
ify
> > stops trying to change this" is not really strong.
>=20
> well, sometimes to adhere to the codestyle, you have to re-arrange code :)

"rearrange" and "rewrite in a not easy to understand way" (which looks
a bit overthought to me, TBH - unlike "secure memzero" I cannot see an
obvious reason why all that volatile would be relevant).

> On top of that, this is basically allowing us to re-use an existing
> openssl API when possible.

True, but if that turns out to be a code complication and reduces
efficiency, I'm not convinced it's the right way to spend our cycles.

> > Also, keeping the "inline" part would be good...  this is in the per-pa=
cket
> > path.
>=20
> I am not sure it would work in this case, because the function is
> defined in a .c file now - it's not inlineable anymore outside of the
> mbedtls code.....

This is why I'm not exactly happy with the change.

We could do it "openvpn style" all in header files, or we could just
leave the function alone.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--/bcALokiWR3y46GP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJemczkAAoJEB2Cnv7KVigSRGsL/0VXkyjSIxM5bSexKoNIqWSe
Oi5gzWTxoXgLJw6vQVYzJTT1/oFr9ttEaEnVONBFIonGcv3zAOU/RR5iljftsHr1
3MKsAqtNq5RWe3hH2bZUrEDqqZ4ISRBDKyauCjvuyt4wgYjMCkLn0tA6HbZQ6dvG
zWrjpIE5CKME/v0stxWaWx/YNCSpp/IRsZUyV1WoaEP0kmFoH/p1Om6MBYgzevWx
xMZl8MKsll7aNcR1MHvcTTSVnaLriedHMYBN9jqyuPuwOIUpUCD9pUIsz2Aldp4k
cESy4sViMAJm9VItbINAvnfXQ0MXdv+j+sTqv+NJJLr542aACcGnFjk7h9BCHvsZ
JqYnTsnekR94onGA9pLxXdqcbAyI/Un0Qqav3UZ/CKPJgceZdBgJGkrZphX4QQ4k
/rVJzDh2cHC6HPPzsZgHxWM7OpNvzqGogIpqFLgU1rA1/qSxOueI836oyoDcSxYG
aIL4hPCRgQbm2SMk0CQMtkNFtYPpZZV00E13zfB2WA==
=RZ3z
-----END PGP SIGNATURE-----

--/bcALokiWR3y46GP--

