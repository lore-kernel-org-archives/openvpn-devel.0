Date: Tue, 1 Sep 2020 22:14:28 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200901201428.GH75094@...1296...>
References: <22a91a88-9555-ef6a-2941-22adfc7f9788@...515...>
 <2545808.mvXUDI8C0e@...2258...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="kh0gS47ASyprwiQo"
Content-Disposition: inline
In-Reply-To: <2545808.mvXUDI8C0e@...2258...>
Subject: Re: [Openvpn-devel] OpenVPN 2.5-beta3 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Thomas =?iso-8859-1?Q?Sch=E4fer?= <tschaefer@...75...>
Cc: openvpn-devel@lists.sourceforge.net

--kh0gS47ASyprwiQo
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Sep 01, 2020 at 08:07:20PM +0200, Thomas Sch=E4fer wrote:
> >     - IPv4-only VPN
> Typo?

We can do that!

(The line slipped... this is part of the "--block-ipv6" functionality
to prevent client requests from leaking out over IPv6 if you have
a --redirect-default VPN that is IPv4-only)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--kh0gS47ASyprwiQo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfTqukAAoJEB2Cnv7KVigSkRUL/R0efzCpIY0IfWPKg8gNw/Ba
1Vz6oN/iqgUVvLRjjGZg6mCuGPtwji9y7PVjslOeMlFDq/HTOnke9hyLKgYpzUe5
YER+IqBy833I/nTaj/ANnXs9NesLxOVTi26qJMk7HBjufu2GYCGJpXP9zRjtfXKs
5CjF+7F9P6u9od3q9cOcNBrk/oGpyq2GzHTXqmx3AiFjCIxlhbyC6Q26kLwvByBx
m14L5CJjvSNRDtGkc+0mZLiWHKw69KtxTxI6vIJoGM66w6+bcTCzhYTwUwuD1e/o
nd6opTZ3bBpsLmsajjAz5X4PoEogZU5CaBNvX6yzifZDjGm8QmMXKDBQRzY458tV
exKp9N1ijMkGO+Omkn9yUKASCW/6DU8YstvTZTXArYh42Y/ie6buZCxuJVx8L2nT
AxIZTm0hoJRluDBg/QVKVaoE90Mr0SvZf+7C6z38IrBmsQFYi55Tu2VF0XaS6K+l
gqjn40WcWn1V+bfmxtdIqBDm4gR7EYfZGbI9DIvK+Q==
=kqV5
-----END PGP SIGNATURE-----

--kh0gS47ASyprwiQo--

