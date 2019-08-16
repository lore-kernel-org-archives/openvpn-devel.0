Date: Fri, 16 Aug 2019 20:38:52 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190816183852.GP1349@...1296...>
References: <20190805092529.9467-1-a@...2181...>
 <20190805092529.9467-4-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <20190805092529.9467-4-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/6] networking: extend API for better
 memory management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Aug 05, 2019 at 11:25:26AM +0200, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> Networking backend implementations may need to allocate dynamic
> resources that require an explicit free/release.
> Since these cleanup are perfomed not very often, and only at specific
> times, it makes sense to have the upper layer signal when it's the right
> time to do so, by means of a new API call.

While I generally like this patch ("0.9 ACKs"), there is one thing that
rubs me totally the wrong way and that must go:

> +    char *addr_str =3D (char *)print_in_addr_t(*addr, 0, &ctx->gc);
> +    char *brd_str =3D (char *)print_in_addr_t(*broadcast, 0, &ctx->gc);

These casts - print_in_addr_t() returns a "const char *", it gets=20
assigned to a temporary variable of type "char *", and handed over to
a printf() variant.  Such code should never ever have a cast.

If the compiler warns about loss of const (in which case I would
ask the question why the return value of print_in_addr_t() is declared
const at all, if it's a gc_malloc()ed string which *could* be written
to just fine...), then let's make "addr_str" and "brd_str" a const
as well.

But no casts in for "basic types assigned to single-use variables", ever.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdVvg7AAoJEB2Cnv7KVigSDsQL/Rtwa3KNwrUMKQDwHDJ3TR/T
gZCh6sNbOKteKId5UMUfIQUshA9G8dtIdP7y7+xKgSk2+oAvYLxXOq9PkbfFwgXo
5xff7ZfRN4e19JdEQIPDBjTsqe3xo8ZpB6PTbZrCbA4XdCssGsMJ1HngC7NttEeB
r0OW8hE1L3x/7qlcxW/RAC+4iL0L1YmS8aA3TOJ1BQV97dinsXHIocI5id80rtUJ
QQnX484+bn4iox3xGxWG3wTlQpKn04ivVHQ0Y8XwR0BNYSmQFugCcIobSy9QLkS/
3HPrJWoe3rKimGrwSG+2SeNiS2NNFMX0G6TgDo855iFRhoUsDvqNfwEgO5jikZH3
rRlI0JW0D/v6DdNGN+vDawKHA0A6AoCcSWaEOWrww6k+trrC7q62j4LTAEd3r2jf
YYcwJDnAfaJ5tKLPfnqLPb4QmTTJ78vxIwTFPkNRlRqFKeb6Wgc2k9VAsFWPFsZT
8mNN6BDk1aw5BR8av1Nio4lfQa3CwMQgiYwdCvc7GQ==
=yN31
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--

