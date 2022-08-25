Date: Thu, 25 Aug 2022 22:43:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <Ywfe8/IeHJvaBVpY@...1296...>
References: <20220824165718.102002-1-arne@...1227...>
 <YwfdRXTtp91VfJYd@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="z5ci493mpt45/oa2"
Content-Disposition: inline
In-Reply-To: <YwfdRXTtp91VfJYd@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix delcarion of pubkeys in
 test_provider.c in MSVC builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--z5ci493mpt45/oa2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Aug 25, 2022 at 10:36:21PM +0200, Gert Doering wrote:
> On Wed, Aug 24, 2022 at 06:57:18PM +0200, Arne Schwabe wrote:
> >   Error: test_provider.c(74): error C2099: initializer is not a constant
> >=20
> > Fix this issue by making the const char* to const char[]. This is proba=
bly
> > of one the weird array decay corner cases
>=20
> Out of curiosity - does the error go away if you just remove all these
> "const" from the declaration?  Making this just a "static char *"?

Ah, I see the problem.  Unrelated to those "consts", but technically,

char * a =3D "foo"

is a pointer variable initialized with the memory location of "foo",
while

char b[] =3D "foo"

is an array.  *Usage* in C is synonymous, because "a" will get the
address stored in the pointer variable, while "b" will just give us
the memory location, both being "the memory location where "foo" is
stored".

Usage in a compile time initialization is indeed different, as

char *c[] =3D { a, b };

would strictly speaking need to load the value of "a" here...  which
should work at runtime, inside a function, but seemingly not with all
compilers at compile time for a static global.

Interesting :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--z5ci493mpt45/oa2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjB97zAAoJEB2Cnv7KVigSNVwL/iASUFTyVUTGd56elLKxhnC2
EwXszb1EB0FS1D5WuWws8kdp5u7LlTffdh5ygVbshZo4x/k/LcyGkhCyCL4n1bWP
T1YN89ensTpG995eo/RsYm+6YVMnHuUoq37lkWNscO/XNAhjA9bRheQkdddJJNXO
EjWBnqaqFVC37x47GClbH/7tHSBDGbRytGk0u9VsEckqtblRTBtyRRwOtqwg2jsT
ioGFOS4UsNncwWBdssBNQFWroIYdZVqKCbshIAxz4iQEgMn3fW7zRAsP9oYcdRq1
bD7/JGeDYBosMtFk+tF5LdkaAptjOMuI3nuotlwBuPA/I4M+NYnUxIyWcvyf2dJ/
wGw2GtJCTl7XpY6Wz6vKjo394Zx36yvkzazuE9CmSZMtf3uAZwPMI9K6zHkwUgT9
25fbBoHMLSTMvp/y+UbQul+x011ZqYK1I+Vl5uOqiZFjRdfDBElB2D/sLOkVFjRC
DWVGSI3fG15WY+snd29VwCOyLRmZLr+9biszktk9yQ==
=WtYv
-----END PGP SIGNATURE-----

--z5ci493mpt45/oa2--

