Date: Fri, 23 Jun 2017 00:08:05 +0800
From: Antonio Quartulli <a@...2181...>
Message-ID: <20170622160805.GD31123@...2287...>
References: <62da7142-d087-7d89-5974-7533b1be0713@...1856...>
	<20170621211043.6490-1-steffan@...1856...>
	<20170622133102.GC31123@...2287...>
	<CAKh=nwF7UfzoDaUWM1RNfx8tULmMVyP_wn69ZGORztx6qMYWWQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="fXStkuK2IQBfcDe+"
Content-Disposition: inline
In-Reply-To: <CAKh=nwF7UfzoDaUWM1RNfx8tULmMVyP_wn69ZGORztx6qMYWWQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Move adjust_power_of_2() to integer.h
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Emmanuel Deloget <logout@...260...>
Cc: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

--fXStkuK2IQBfcDe+
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Thu, Jun 22, 2017 at 05:33:44PM +0200, Emmanuel Deloget wrote:
> Hi Antonio, Steffan,
>=20
> On Thu, Jun 22, 2017 at 3:31 PM, Antonio Quartulli <a@...2181...> wrote:
>=20
> > Thanks for sending v2 Steffan,
> >
> > On Wed, Jun 21, 2017 at 11:10:43PM +0200, Steffan Karger wrote:
> > > From: Steffan Karger <steffan.karger@...1435...>
> > >
> > > misc.c is a mess of incoherent functions, and is therefore included by
> > > virtually all our source files.  That makes testing harder than it sh=
ould
> > > be.  As a first step of cleaning up misc.c, move adjust_power_of_2() =
to
> > > integer.h, which is a more suitable place for a function like this.
> > >
> > > This allows us to remove the duplicate implementation from test_argv.=
c.
> > >
> > > Signed-off-by: Steffan Karger <steffan.karger@...1435...>
> >
> >
> > This change is quite simple and passes basic tests.
> > Thanks also for adding explicit #include statements.
> >
> > Acked-by: Antonio Quartulli <antonio@...515...>
> >
> >
> Since the code is moved, would it be interesting to use a less greedy
> algorithm to do the same thing? I know the function is not used very ofte=
n,
> so it does not look like it's necessary (it's a suggestion, not a
> commentary on your patch Steffan :))

My personal opinion: *never* mix code refactoring with functional changes (=
like
what you are suggesting).

Therefore we'd still need another patch.

>=20
> For example, this code:
>=20
> size_t
> adjust_power_of_2(size_t v)
> {
> if (!v)
> return 1;
> v--;
> v |=3D v >> 1;
> v |=3D v >> 2;
> v |=3D v >> 4;
> v |=3D v >> 8;
> v |=3D v >> 16;
> if (sizeof(size_t) =3D=3D 8)
> v |=3D v >> 32;
> v++;
>=20
> return v;
> }
>=20
> does the exact same work on a 64 size_t but will be far faster than the
> loop-based one on many situation (the sizeof() test should be optimized
> away if it's never true, so the code will work even with a 32 bit size_t).
>=20
> Why it works:
> * if (v - 1) has 0 bits set, then v =3D 1 and the function will return 1 =
((0
> | 0 | ... | 0) + 1)
> * if (v - 1) has at least one bit set (let's say it's bit n), then the
> first iteration will set bit (n-1). The next iteration will set bits (n-2)
> and (n-3). We goes on for a few steps. Before the last iteration, v has
> bits (n...(n-32)) set (with sizeof(size_t) =3D=3D 8), so the very last
> operation fills the remaining bits and v has bits (n...0) set. Adding one
> to this value will yield the desired result.
>=20
> Again, the function is not used extensively, so you can ignore this
> suggestion as it will not speed up openvpn at all :)

yeah...not sure we need to make some code a bit "obscure" if there is reall=
y no
need.

Still, I'd suggest to prepare a second patch and propose it over the list.

Cheers,


--=20
Antonio Quartulli

--fXStkuK2IQBfcDe+
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllL62IACgkQ0+HICM1s
oFA/6Q//dSDNe/0B53kq8YLnZHOhyvE74y6MoOrJBbxMxtKTdQ7UsOKgM29TBsPe
8T70+iIj8qA1THNrA+MBXmoFmqdtj6nShTp52V0bhsht30cNwhHAZGSPAwdQzPAA
Gbj/d9SF5QtmK0j4MicpgNGlDaLrez9UICryq4tD9RXBuYRU5NRXbLWhg6rVgnf0
Viike8ZFpUm54GgaxaNHI8e34sT+O4Qe/rW1Xpb1G7WqF2yFSWrQsp0FpIWyQNP0
zb222yTQqwMM1H4/f0gDTZP3u4NoUd6ciV3HKzBZgK50OLlIc4NeuX/lXNQcMMzm
tIUFiHuHkae1NFnfjwvwyFCsIODRPgw0pclKT/U+rQ+BpuyxddWlK0l2SOewbdcN
arILYTzwSG+6w7UfGem20e1arKNVlxek8ULD+pEFJaTj9QzXnaZYdQkuGNvZeKFH
+qiyEPZ7+u/qavKTK4W7IRohaz+GSTlbwCZattpIQVE8kuT4gAOfFTCL0rwZIjBc
Hzz4dvofLwfM+tWBjEMnxc/6Uk5MIRoL2LmYcTM4x9UVb0z+WPyO00Fb8b/5Bejo
JDqCUqS2idwQa0Mks2exgjrejHq4SsBGqS1xBTcipkrO1BVME8Fb6fX/EhWFGSWK
49KyOs53EGkNWp42eZsIpDkrHUZy0XVBGGQyPxNioGYA8TbVGBY=
=Fgu7
-----END PGP SIGNATURE-----

--fXStkuK2IQBfcDe+--

