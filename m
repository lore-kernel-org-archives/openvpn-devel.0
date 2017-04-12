Date: Wed, 12 Apr 2017 08:24:37 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20170412062437.GZ93896@...1296...>
References: <20170411173133.18060-1-davids@...515...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ypW9Hd+IdONQkcOt"
Content-Disposition: inline
In-Reply-To: <20170411173133.18060-1-davids@...515...>
Subject: Re: [Openvpn-devel] [PATCH] Require minimum OpenSSL 1.0.1
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>
Cc: openvpn-devel@lists.sourceforge.net

--ypW9Hd+IdONQkcOt
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Tue, Apr 11, 2017 at 07:31:33PM +0200, David Sommerseth wrote:
> --- a/configure.ac
> +++ b/configure.ac
> @@ -859,9 +859,9 @@ if test "${enable_crypto}" =3D "yes" -a "${with_crypt=
o_library}" =3D "openssl"; then
>  		# if the user did not explicitly specify flags, try to autodetect
>  		PKG_CHECK_MODULES(
>  			[OPENSSL],
> -			[libcrypto >=3D 0.9.8, libssl >=3D 0.9.8],
> -	        [have_openssl=3D"yes"],
> -			[have_openssl=3D"no"] # Provide if-not-found to prevent erroring out
> +			[libcrypto >=3D 1.0.1, libssl >=3D 1.0.1],
> +	                [have_openssl=3D"yes"],
> +			[AC_MSG_ERROR([Minimum supported OpenSSL version is 1.0.1])]

While this *looks* harmless, it has non-obvious side effects - from what
I observe, it breaks compilation on all platforms that do not have
pkg_config for OpenSSL, which was not a requirement earlier (and there
even was a comment to that extent, "to prevent erroring out").

In other words: all BSDs are broken now, no matter which openssl version
they have.

gert
--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--ypW9Hd+IdONQkcOt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJY7cglAAoJEB2Cnv7KVigS+0IL/iCPsLT+Exjwu0jU93eX8eN/
pily0B4lbmGcG10OdIbYz/c1v0j+K4G+75U+nc9HOka9BiiEdqkoAnZycqjuORTo
e5KbkpqYUkbgO/x29wL6X2am/LIOG9A6r0RX4TsKoqOyVGTbW7Iwfcp4pX3v0Xj4
Oc33O3aExIzEA0ZjXcArMl5fofNsb1adHYIDQqNuFVh7W0GlvdyvYxVwtsY4kVt9
PzhO5OlYmtRNRggGsYdQUwzCF5w0GGq2o6ef0YyUfrlZygvnQVzSXCqZFjXRZOaP
iRn2jYEG4akDc/vmJqC2kcL5VArRCyYrvry4ltjR5aPw92HpTukkJNHozHHnLd1C
l9xM4ZvODItq37kGkbYJ59Gx5h+0LM7ktD6uLVBY+7mGTzuLahqCp6IBE9rVrJL9
D50igUK6767RsK8s3qtGXL8dKOmYuPmX8y2wTuOLislIgdiFGiTVjI/w01eO90aY
VnXnepqBVXeVollfQQo98oo+OmlNFXFULxvcEAClCA==
=fEO0
-----END PGP SIGNATURE-----

--ypW9Hd+IdONQkcOt--

