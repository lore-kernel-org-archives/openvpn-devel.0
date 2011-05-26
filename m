Date: Thu, 26 May 2011 15:54:54 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20110526135454.GV8496@...1296...>
References: <1306416185-4901-1-git-send-email-samuli@...515...>
	<1306416185-4901-4-git-send-email-samuli@...515...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="TbvQLmyOl28t66Jz"
Content-Disposition: inline
In-Reply-To: <1306416185-4901-4-git-send-email-samuli@...515...>
Subject: Re: [Openvpn-devel] [PATCH 3/4] Fix a Visual Studio 2008 build
	error in tun.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Samuli =?iso-8859-1?Q?Sepp=E4nen?= <samuli@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--TbvQLmyOl28t66Jz
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, May 26, 2011 at 04:23:04PM +0300, Samuli Sepp=E4nen wrote:
> diff --git a/tun.c b/tun.c
> index 895409a..8cdd248 100644
> --- a/tun.c
> +++ b/tun.c
> @@ -572,7 +572,7 @@ init_tun_post (struct tuntap *tt,
>  #endif
>  }
>=20=20
> -#if defined(TARGET_WIN32) || \
> +#if defined(WIN32) || \
>      defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_O=
PENBSD)

ACK.  TARGET_WIN32 is not defined in MS VS (no autoconf), and the rest
of the code uses WIN32 everywhere - and as this is the single place where
TARGET_WIN32 is used, changing it to WIN32 is the way of least pain.

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--TbvQLmyOl28t66Jz
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBTd5brqkuBuNlUUl1AQJ2XgP8Cduhw3xo0Y1boPfblobXEhUBKf1kjdZg
oXV5tNXmr1xrcJjc45Y31I9H4RqwVa6KVpzKlN1BC7nK2SM2o+4+mxlJGLwzCxRy
cvlHehZSEkozsQXqdSiSwHA6AIo14lWxKhz7UiKiIlF2PrFuyFX6a4B7MvJNcOnC
wpSQ2XGHvac=
=ohFx
-----END PGP SIGNATURE-----

--TbvQLmyOl28t66Jz--

