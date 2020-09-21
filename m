Date: Mon, 21 Sep 2020 09:50:40 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200921075040.GO976@...1296...>
References: <20200920090929.8321-1-gert@...1296...>
 <d682d99e-1c9a-6832-cb04-6f3d5d45f13f@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="PEkEgRdBLZYkpbX2"
Content-Disposition: inline
In-Reply-To: <d682d99e-1c9a-6832-cb04-6f3d5d45f13f@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Fix line number reporting on config
 file errors after <inline> segments
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--PEkEgRdBLZYkpbX2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Sep 21, 2020 at 09:22:38AM +0200, Antonio Quartulli wrote:
> Sorry for not chiming in earlier, but honestly I believe your other
> option would be "cleaner". The other option being "return int instead of
> bool, where the returned value is the number of lines of the inline'd
> material.
>
> If 0, we know there was no inline'd material, thus we can treat that
> result as "not inline'd".

We could do that, indeed.  I was torn between both variants - this one
is a bit more intrusive (because it adds a new argument to so many
functions), but on the other hand, the bool stays a bool and is not
magically overloaded - which would make the call to add_option()=20
either "even longer", or if you rely on magic "we just pass the integer
to a bool-expecting function" much harder to understand.

> Anyway, this is just my opinion. If you believe this is a better
> approach, I am fine with it too.

I wasn't sure.  In the end, this one didn't feel so bad, so this is
what we have.

Maybe I'll do the other one as well, for fun, and to compare :-)

> > @@ -4692,7 +4696,7 @@ check_inline_file(struct in_src *is, char *p[], s=
truct gc_arena *gc)
> >              p[0] =3D string_alloc(arg + 1, gc);
> >              close_tag =3D alloc_buf(strlen(p[0]) + 4);
> >              buf_printf(&close_tag, "</%s>", p[0]);
> > -            p[1] =3D read_inline_file(is, BSTR(&close_tag), gc);
> > +            p[1] =3D read_inline_file(is, BSTR(&close_tag), num_lines,=
 gc);
>=20
> am I wrong or here we should add 1 to num_lines to include the opening
> tag that was parsed *before* entering read_inline_file()?

The opening tag is parsed as "regular" line in read_config_file(), and as=20
such, the "++line_num" in there applies.

(I have tested this :-) - nothing more embarrassing than a patch to fix
line numbers actually still printing wrong line numbers)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--PEkEgRdBLZYkpbX2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfaFtPAAoJEB2Cnv7KVigSpCML/2yynIvGvtjW+4wGOXvs1R7Z
8ct2FSQjbmC6ufeAbxMjajWp93OSVIRID9XJy7IOIla3Ay/HAgZzCqsUXn2MyH51
QbgbDYvAwQQbBna6vJYwkEKx1zlkgftIejpCTin6NXd1v8gqezjobv3cOINzHQb5
lAUIMUVuaYlV32o7y/3hlW2XzACY3AGgNcybgsudxJ0D0jzFO752+PEheQVODNmc
Vt+66Y8jkHxKbCSa9xehEufMGPeThGZPDst9WFtWw2b5PcPKJbpYmQLmxj84RXq5
anJhjfvw3k73I2QUcFUYjWzkkpQwwxGu1F7cus81QJwNZC1JJm3xY4ydJRIZRRvJ
8WyQxmClCvSKNeijM9jYzqrvl5qDWpGfENQrd7+XWXwwpDtkgfMj7QSoycmdFhsm
HU/pQvMjJ7SSGhpvGRWlOmcfxlSb+7kZjwHmyCN2ljIGNUo5mpj1BMPy0b8Ydird
8XK4mwYRDoUulQB45E2SbcjjyPnLsE+/JOHRjob9SA==
=Csw3
-----END PGP SIGNATURE-----

--PEkEgRdBLZYkpbX2--

