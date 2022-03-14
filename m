Date: Mon, 14 Mar 2022 18:25:02 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yi96btgdrMdWYlWB@...1296...>
References: <20220314162048.22955-1-a@...2181...>
 <404808391.276382.1647276886162@...2642...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IcpWCfg9UYHHfRvn"
Content-Disposition: inline
In-Reply-To: <404808391.276382.1647276886162@...2642...>
Subject: Re: [Openvpn-devel] [PATCH] remove unused sitnl.h file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Frank Lichtenheld <frank@...2641...>
Cc: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--IcpWCfg9UYHHfRvn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 14, 2022 at 05:54:46PM +0100, Frank Lichtenheld wrote:
> > Antonio Quartulli <a@...2181...> hat am 14.03.2022 17:20 geschrieben:
> > sitnl.h must have slipped in when implementing the networking AI and the
> > SITNL backend. However it is unused and should simply be removed.
>=20
> We have an AI? ;)
> (I assume this should read API?)

OpenVPN Code is full of industrial light and magic.

Might as well call the config parser an AI :-)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IcpWCfg9UYHHfRvn
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJiL3puAAoJEB2Cnv7KVigS20oMAKEFnrtXGLVdQ4KkHHbEHQJ1
K6LaIxNcKbcsLxmsoeC81eI7ddo4pZsAjlAr/Pu6CQMwZKLy6/yQNSkd+cHCEQyY
b7Lvbk9jyg6a0vk8hHNDKjNrrAsEh6AjwL6DZLHj6QtQXUQut3X89rEcTrbp+uQ/
2CfFO+3TyHjH0iU+1AVL542isNzDaXj6kr35OxpnZmxP716g25uq5gIeVyQrNaPL
ln0Isdf2XzryNtALx2/QVAd85uSaNLSiPmadgXfnZbmYoHr3otusI4y23UxUxvIl
Qa9wqloUCG3mNk3BngRESvO9O4JtXlIbVEks6YqdS8i67O8bwp7/CO3UyR8bhI73
5VfURVB5OjpcO0B6mTV4MyCUl3G1h7WtZEZJlTLvL9P8R6tdvkgqBrGlsGCjy9Z+
U+hinUXhCwT5rgIu+Uh6rih0sGVhFGahg06mYczo1yyF1bfrok4ztE9vDf8j6eaA
GXc5k1Q4ils70UNLI01rRQwRYWInAvZhZBzckYarjg==
=oblQ
-----END PGP SIGNATURE-----

--IcpWCfg9UYHHfRvn--

