Date: Mon, 26 Mar 2012 13:52:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20120326115216.GU1359@...1296...>
References: <4F6D06C5.3030408@...1114...>
	<1332575918-3384-6-git-send-email-alon.barlev@...277...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="hkJ/XfKuQcNFcQvU"
Content-Disposition: inline
In-Reply-To: <1332575918-3384-6-git-send-email-alon.barlev@...277...>
Subject: Re: [Openvpn-devel] [PATCH 5/6] build: enable lzo by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: Openvpn-devel@lists.sourceforge.net

--hkJ/XfKuQcNFcQvU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

ACK, as per the discussion and majority of voices.

gert

On Sat, Mar 24, 2012 at 09:58:37AM +0200, Alon Bar-Lev wrote:
> Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
> ---
>  configure.ac |    4 ++--
>  1 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 9a6ff29..bd84c0f 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -41,9 +41,9 @@ AC_USE_SYSTEM_EXTENSIONS
>=20=20
>  AC_ARG_ENABLE(
>  	[lzo],
> -	[AS_HELP_STRING([--enable-lzo], [enable LZO compression support @<:@def=
ault=3Dno@:>@])],
> +	[AS_HELP_STRING([--disable-lzo], [disable LZO compression support @<:@d=
efault=3Dyes@:>@])],
>  	,
> -	[enable_lzo=3D"no"]
> +	[enable_lzo=3D"yes"]
>  )
>=20=20
>  AC_ARG_ENABLE(
> --=20
> 1.7.3.4
>=20
>=20
> -------------------------------------------------------------------------=
-----
> This SF email is sponsosred by:
> Try Windows Azure free for 90 days Click Here=20
> http://p.sf.net/sfu/sfd2d-msazure
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>=20

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--hkJ/XfKuQcNFcQvU
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (NetBSD)

iQCVAwUBT3BYb6kuBuNlUUl1AQIa+AP/Xf44JUoFuKO6hFz3d3QyFxbbmYPfmPkY
NuXY/+uuUIfy7lCRCqD/4DbTzOD63cltKSkQGZxLEU0Uqg8DNC5iV8tWhw3+UaIx
Y30wo1M1z272vFV2ffD3iymigFcn6+etq6qeT64Q6BjHznihW5IMjcY8W4LLuVGX
u5WIH65JUqo=
=KfMs
-----END PGP SIGNATURE-----

--hkJ/XfKuQcNFcQvU--

