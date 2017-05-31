Reply-To: openvpn-devel@lists.sourceforge.net
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
Date: Wed, 31 May 2017 02:31:40 +0200
MIME-Version: 1.0
In-Reply-To: <1496177444-18373-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="4QVqUtKQXihVja1esDqQDiTIb9ccuRpuB"
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4QVqUtKQXihVja1esDqQDiTIb9ccuRpuB
Content-Type: multipart/mixed; boundary="j7G4JJgdKv5SdLM2o48oIsUsvtPnxhtMP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net
Message-ID: <29f51139-a525-fd92-0fe1-195d308d2924@...2080...>
Subject: Re: [Openvpn-devel] [PATCH release/2.4] configure.ac: fix building
 against static openssl
References: <1496177444-18373-1-git-send-email-steffan@...1856...>
In-Reply-To: <1496177444-18373-1-git-send-email-steffan@...1856...>

--j7G4JJgdKv5SdLM2o48oIsUsvtPnxhtMP
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 30/05/17 22:50, Steffan Karger wrote:
> Instead of searching for both libssl and libcrypto, just search for
> openssl as a whole (which depends on libssl and libcrypto).  The previous
> discovery order would result in "-lcrypto -lssl" link flags, while we
> need "-lssl -lcrypto".
>=20
> Trac: #863
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
> This patch is for release/2.4 only, because this is already fixed in
> master by commit 79ea67f77ca3afe91222f62e17df885a30409285.
>=20
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/configure.ac b/configure.ac
> index 2406ad8..854634a 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -859,7 +859,7 @@ if test "${enable_crypto}" =3D "yes" -a "${with_crypt=
o_library}" =3D "openssl"; then
>  		# if the user did not explicitly specify flags, try to autodetect
>  		PKG_CHECK_MODULES(
>  			[OPENSSL],
> -			[libcrypto >=3D 0.9.8, libssl >=3D 0.9.8],
> +			[openssl >=3D 0.9.8],
>  	        [have_openssl=3D"yes"],
>  			[have_openssl=3D"no"] # Provide if-not-found to prevent erroring out
>  		)
>=20

I vaguely remember we discussed the OpenSSL versions.  On the Linux
side, we shouldn't need to worry about anything older than 1.0.1.

I do however vaguely remember someone mentioning some BSD distros still
being on 0.9.8 ... or was it some other OS?  ... Anyhow, do we need to
care for them?  This is release/2.4 we're talking about after all.

If we really do care for supporting 0.9.8, in release/2.4 - I can give
this an ACK.  Otherwise, I think it might be better to backport
039a89c331e9b7998d804 + 79ea67f77ca3afe91222f.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--j7G4JJgdKv5SdLM2o48oIsUsvtPnxhtMP--

--4QVqUtKQXihVja1esDqQDiTIb9ccuRpuB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCAAGBQJZLg76AAoJEIbPlEyWcf3ypd4P/jz6IHaO5pBuG9xupK6ww29D
ne9HttJaNsDytpRwFQr0S/5s149cMDsZ+l2l/begs/UDBscRv5y49U+JhRCnvlW7
0ejDhQwHIPUaLCeWvTjz6eMtJxlki7EHjtFVWUxmX1vR8WXx5Ewbhxhp02fFnb16
i1QQGQqIKMTDp3c9rNGSRoBWQphplxXtBz+Q+S5/7R41m2g7SoJMtIZOV5rmtQ91
ij//0EEd2tTl1uBfva7gd5gM9QKv5ITDcr3IDm6ePoT6xvxHEs//ARu6W51lWhfA
fbiIu7sgUIVN9YGYmj8gtZ+sUUCrjnrBXMjgLO7mFcaQYFHK4YT9wgfP72MgmzfK
PSKbu9qqawp5b9N8AD1Cuv7tb7GC+CRXz5jfwIj7Qytxf6bKj40d4U/PGMNGgvln
jIGrB59koSRxrOvHqc5AR6vXtAPN/k/dVPTMHIJoOkt4AjgpiAWo0mp9IN0BlnhZ
cArHEem0LF+/gpCoZgZ1RUGM43hld2nF70uKApMQZJrmRAaR7eIafDRVorTsU4Qo
2ZR0y/3lHhZgq6+dU642KOSqpkGp3zQot1MMAvf6b582T3C9Xfb5VFi9aI4lzVoW
GeUz734o8eRhmlGiQx+a2v3mbHrSZZFRRzqFiQdoIWlcwe86MEeB5YGp+RFwH5gY
3FbtSKPzfpE4SXxNg2f8
=mDvF
-----END PGP SIGNATURE-----

--4QVqUtKQXihVja1esDqQDiTIb9ccuRpuB--

