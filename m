Date: Mon, 25 May 2020 16:50:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200525145045.GG1431@...1296...>
References: <20200524203322.15885-1-James.Bottomley@...2316...>
 <20200524203322.15885-3-James.Bottomley@...2316...>
 <20200525060415.GY1431@...1296...>
 <1590417371.4938.6.camel@...2316...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="HsGRB+GJ0ovZxbNN"
Content-Disposition: inline
In-Reply-To: <1590417371.4938.6.camel@...2316...>
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--HsGRB+GJ0ovZxbNN
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, May 25, 2020 at 07:36:11AM -0700, James Bottomley wrote:
> > >  configure.ac                                  |   5 +
> > >  src/openvpn/crypto_openssl.c                  |   1 +
> >=20
> > These two hunks should go to the first patch.
>=20
> The configure.ac one adds the test Makefile ... it can't move.  The
> other pieces figure out what the dynamic extension is, which is only
> used by the test, so I think everything in the configure.ac change is
> in the right place.

Yeah, I misread the part about

+AM_CONDITIONAL([OPENSSL_ENGINE], [test "${have_openssl_engine}" =3D "yes"])

and assumed it's needed for the #ifdef in the openvpn code.

> The second is a bit more problematic:  Right at the moment openvpn is
> blind to local openssl configuration files.  To make the test work, it
> needs to be able to add an engine, which requires a local file, so it's
> only function is to enable the test, but it does add to openvpn
> capabilities, I suppose.

I think it should go to the first patch - so "all changes to openvpn
behaviour" are caused by this patch, and the test patch will only add
testing, not change behaviour.

On the actual patch itself, I do not understand enough of the engine
stuff to fully ACK it.  Arne or Steffan understand OpenSSL better.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--HsGRB+GJ0ovZxbNN
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJey9tFAAoJEB2Cnv7KVigSoY8MAKcETIkIHgsq3EHu1GnA17dP
pbJ/4kT6P9O2x3Fc0a5gTYsCEpVkK4CzGVqRLy9ZpsyFcGnO7NirzbJFfggVOuDZ
uN7sUZE+bwYJfXpD4t7PGO7R+GulR6WLjS/Ds/sKK3q/1RMD1AjJXlnldrgXeBN8
nfWdQgAGC6dKQ429HSD7bp8r1ZnnElUR/Xyqrc92jlT2a43a8uG6qx7wKsGWmfZ3
cP4SrQ+hTzZ6TxlcZLyq6OHcyyxZ+IGezIjaM4ylTApSl4I0PFDAWyXVDdcK0J7K
zTJa1j9cVSvcuIU5k12uSkr6MhI+WpFXQ/w3JCIJdfBNS7CUlL//KI5QR1sOC3tF
m2i47UO8JjHnrK75n2HNbyoNJfNs2M4XryqDzopFkHX9/kqyygxwidGEqyKR5rgP
A/VKRcF1mo1DXkV5qhzlWDt0b0N3W6exSWL/SjYV/CokRz1eRuSZeoTsRuw463gp
GAmOXQZTWe2pkxkEBkA3po2a/rD6j5yKLI7xkaiwWA==
=5DEk
-----END PGP SIGNATURE-----

--HsGRB+GJ0ovZxbNN--

