Date: Tue, 23 Nov 2021 12:59:49 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YZzXtauc1RuVvCGr@...1296...>
References: <CAGyAFMUHqDObKdOPD37T-Qau+CXyb-oCQu-NLHYtJKnwhse80g@...278...>
 <CAKuzo_hv8H6zRbvCx_g680TNhHEvoP=OvB_FbGOZAy=jmHvPvQ@...278...>
 <CAGyAFMXpBRGHsTZQjRsr2ByoGx2G2isoqUwaZnwYX6NWWwZBpA@...278...>
 <CAKuzo_ggddGKgDewDWbjv3pNGAC-SK0dmD+Ay-c2HOHcVX5psA@...278...>
 <YZwNiBRC+V/E9OeI@...1296...>
 <CAKuzo_jicUu50x-CxGYE2DJjW0pwf06DCfMkhFn5vKz1AHCrcA@...278...>
 <YZyPoyofdC4M1CqU@...1296...>
 <CAGyAFMXE61tbhW=74jvoQLwegU2SjbFi8V-5JFGcEgO5=7OK2w@...278...>
 <YZzCbiezMd/zkrAO@...1296...>
 <CAGyAFMXZ9OJQJXxkOm6qVDEN4a9ZiMufgX5FTF2Bg9GtHrq4hA@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="xLyWl6BebxU8C7Ez"
Content-Disposition: inline
In-Reply-To: <CAGyAFMXZ9OJQJXxkOm6qVDEN4a9ZiMufgX5FTF2Bg9GtHrq4hA@...278...>
Subject: Re: [Openvpn-devel] OpenSSL build on Windows: OPENSSLDIR and
 MODULESDIR
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xLyWl6BebxU8C7Ez
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Nov 23, 2021 at 01:39:16PM +0200, Lev Stipakov wrote:
> > Can our installer use "custom locations", like "install all our software
> > to "d:\mystuff\openvpn\"?
> Yes.

OK.

> > In that case, built-in paths won't work well (as was pointed out in the=
 PR, to my dismay).
>=20
> We could use something like C:\Windows\System32\SSL ?

We could, but then "special openssl.cnf for openvpn" might get in the
way of "special openssl.cnf for someone else's OpenSSL binary", so maybe
not such a good idea...

> One could install Windows to a different drive, but the first line of def=
ence
> could be a path defined by env variables.
>=20
> > >  2) use env variables for openvpn and openvpn-gui ?
> >
> > I think that this might be the most flexible and robust approach.
>=20
> On startup we could read the installation path from
> HKLM\SOFTWARE\OpenVPN and assume
> something like <installation-path>\ssl\openssl.cnf ?

To me, this feels like the least annoying way forward... and then we can
also stop worrying about any future changes on the vcpkg side (even if=20
they accept the PR now, they might rebuild their build script, breaking=20
things again).

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--xLyWl6BebxU8C7Ez
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhnNe1AAoJEB2Cnv7KVigS5HUL/0JFq6JODrgD/ZZeLxzT/5MX
A9vsxOvNwMB/NcXNefS9yeezflZ9VU1rTNVOhpLxoW2heC+B/RZ9lllGuyyGjBtf
cV6jz7O1FcaFoerYde4F3Mo+JLQZaaKBs+3pdPCJwvOfw9Uuf7O4Dv5czosXf5wy
Od4tErhroguxL9KylQEVlerDwsnCOssWGCzr1nLp0xzTOwa6bARR2zCxQMoVS3Rg
MCF3RpCAdFSOTURX7eUCFGLXfSxqkHuwa8zGpmdFqqDP+NJOwEC2WcgxQtqwAKud
lEaZ1AX8ZxnQYeYsKqkHaptd4iUpxlWSN7NRY2TwjCZn7FfdYpurbdvQUgcvNSlR
9RaJ+HvWjdgGZRCMzCRm8iWItwtFDmO9+1FDR1+cIXNaalIZY6YnAhFp3ZfRjNDt
+l80GXSg4mYbAIsNV0jKANuffjOF0HYE1xLSQFUBIxhM4vHtJcGKvF7pbuU9YRRC
2I/0mfQmcXjR+SvgBXaJV25lFN/DuaodzpbRLgOk6g==
=JiAl
-----END PGP SIGNATURE-----

--xLyWl6BebxU8C7Ez--

