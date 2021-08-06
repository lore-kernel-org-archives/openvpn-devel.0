Date: Fri, 6 Aug 2021 18:04:31 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YQ1dj9UHa5cdSPGn@...1296...>
References: <20210716121848.67888-1-arne@...1227...>
 <20210728124103.565145-1-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="jm1JBR/p/u2jjFsw"
Content-Disposition: inline
In-Reply-To: <20210728124103.565145-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2] Introduce webauth auth pending
 method and deprecate openurl
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

--jm1JBR/p/u2jjFsw
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jul 28, 2021 at 02:41:03PM +0200, Arne Schwabe wrote:
> The experience with openurl/OPEN_URL has shown that just sending
> a URL to a client is not enough and we often need different
> behaviour of the client depending on circumstances. Replace
> OPEN_URL with a more flexible WEB_AUTH pending auth method.
>=20
> Patch v2: use WEB_AUTH instead WEBAUTH
[..]

I think this is mostly ready, except for a small oversight:

> -proxy_url
> -=3D=3D=3D=3D=3D=3D=3D=3D
> -This is a variant of openurl that allows opening a url via an
> +webauth with proxy
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> +This is a variant of webauth that allows opening a url via an
>  HTTP proxy. It could be used to avoid issues with OpenVPN connection's
>  persist-tun that may cause the web server to be unreachable.
>  The client should announce proxy_url in its IV_SSO and parse the
>  PROXY_URL message. The format of {EXTRA} in this case is

   ^^^^^^^^^ there is no PROXY_URL anymore, so this might read

   ... and parse the "proxy=3D..." part of the "flags" section.  The format
   of {EXTRA} in this case is:

Or something like this.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--jm1JBR/p/u2jjFsw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhDV2OAAoJEB2Cnv7KVigSzM4L/0j6nupEdDfvMtfaH8ivId9v
4dXDiUewMYzqzfmBLK8OioBJSc2ee24w85YsOal3X6daSkv5GJAUCJOf+hrWJo81
p71pk6+awLsTDt+81t3scTtP+4277g/Yjl/jqfL/cFYbnYjL4LX+qnipOeZnKQVH
rBRssNGQ0zCfH8xFzeATx/kyZRVkt7AsL4RB1MIIPtxSjwXPvW6a6GkZNrDwGrMT
wAwB6J2UJRUWkRJxO/LQAXVyV8xdSIrrnmUkErOguIO1ZTMJwPzGMCStVrzwiGWh
pNnTVLhtlWj5vTqlTo0FGz+SK1SE240A55El+ZhFGGdafdAl8Rwxf6LeemfQx3JU
4DkfwS4p5iARU6YTUCJRBguUNcfTI6GEXnPaTdn1g8uikbwBOe04n3BVQYiCL2lc
KtIeh3/iIqyJWjJ+87yciOplr5Xx2coaVLN05Oz9tBsgPwaAaOCjfAcj5Xz2KSf9
ECocvEuudDUs69Vq8L7BrnbJ8LWkoeTlya6RzccnSQ==
=dNn7
-----END PGP SIGNATURE-----

--jm1JBR/p/u2jjFsw--

