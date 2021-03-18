References: <20210318161609.76073-1-juliusz@...2525...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <749924e0-5927-ba54-9e09-e722d53ae8ef@...2080...>
Date: Thu, 18 Mar 2021 18:25:13 +0100
MIME-Version: 1.0
In-Reply-To: <20210318161609.76073-1-juliusz@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hEPdBLp3BKA4u3hER5g2vpxwBpJO5gCc5"
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hEPdBLp3BKA4u3hER5g2vpxwBpJO5gCc5
Content-Type: multipart/mixed; boundary="5MgWaAdv7sQUz5Rrot1AtuMenm3n3ExWj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Juliusz Sosinowicz <juliusz@...2525...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <749924e0-5927-ba54-9e09-e722d53ae8ef@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add PKG_CHECK_VAR compatibility
 definition for old autoconf versions
References: <20210318161609.76073-1-juliusz@...2525...>
In-Reply-To: <20210318161609.76073-1-juliusz@...2525...>

--5MgWaAdv7sQUz5Rrot1AtuMenm3n3ExWj
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 18/03/2021 17:16, Juliusz Sosinowicz wrote:
> Signed-off-by: Juliusz Sosinowicz <juliusz@...2525...>
> ---
>   compat.m4 | 16 ++++++++++++++++
>   1 file changed, 16 insertions(+)
>=20
> diff --git a/compat.m4 b/compat.m4
> index e54a7203..47650f6d 100644
> --- a/compat.m4
> +++ b/compat.m4
> @@ -64,6 +64,22 @@ ifdef(
>   		AC_DEFUN([AC_TYPE_UINT64_T], [])
>   	]
>   )
> +ifdef(
> +	[PKG_CHECK_VAR],
> +	,
> +	[
> +		AC_DEFUN([PKG_CHECK_VAR],
> +		[AC_REQUIRE([PKG_PROG_PKG_CONFIG])
> +		AC_ARG_VAR([$1], [value of $3 for $2, overriding pkg-config])
> +
> +		_PKG_CONFIG([$1], [variable=3D"][$3]["], [$2])
> +		AS_VAR_COPY([$1], [pkg_cv_][$1])
> +
> +		AS_VAR_IF([$1], [""], [$5], [$4])
> +		])
> +	]
> +)
> +
>   if test -z "${docdir}"; then
>   	docdir=3D"\$(datadir)/doc/\$(PACKAGE_NAME)"
>   	AC_SUBST([docdir])


I'm not seeing the rationale to why we need this; can you explain that?

The TL;DR version of Chris Beams "How to write a git commit message" [1] is:

git subject        --->>  _What_ this patch is about
git body message   --->>  _Why_  the change is needed
git diff           --->>  _How_  the change is solved

[1] <https://chris.beams.io/posts/git-commit/>


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--5MgWaAdv7sQUz5Rrot1AtuMenm3n3ExWj--

--hEPdBLp3BKA4u3hER5g2vpxwBpJO5gCc5
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmBTjPoACgkQhs+UTJZx
/fIdIw//fdfq//MdcF4GtGKp+KIlYkCNzIeVyMZOm2Qon6sLoxhJkaau352hsCIr
LFgZ7QpLUO3abKwV1Rok3lZGTx6euXGk5hEY6fXRjke5rPmhVUNBw/cEcsSgj/ax
zzt6vl5Ib8mw6p5KZbjJljkGvEwTFKlxEeotpU8z/2/0M789o9NpaGzjJP+ScxPf
rfU9YHemmiy5aUfS8d/SgTR2KXbrBb7whr7PdIy8MDYOlXR///LTALZaGGA6BeZG
QlN4bpbE7BbgN0Pe+LgT5xxg1Pu7gui6epk5Y4iA+C6ugTAlnCS2t9K4fsHwwBjO
7oUcTLgo831VYNGSXTLSF8XOvFFaq0X2JacMSzObePFV43v90IruQKEODThYCcAj
DsIANHU5asSXzlOzQTq23VhtdS1vXRLFFRpfIrtTtAYzxpNAA9ZmqjHASqnZVUyD
NBXmT3Xs43sukwt8WfU/kWREJCGMUrrT37BE9x+XbxIAx4dHFE7ewjnS9vGdT/sh
c0w1pK/e5m/8lgIkTgToKlRC4SM7B91fc2w5bQKjTo9enC4SyrKY2NoZPxHBctSe
Ow3TXWAXMK/JstXl7/ahPnH1nkI2IDSBlXny5sTYm3Og9iZYsp81wUYEhgRAGA+D
4IVGAhxukKJqb+jJiPRV9u/e8RdfYK8QAZSR1aurj8bbvmDUb5k=
=JBJV
-----END PGP SIGNATURE-----

--hEPdBLp3BKA4u3hER5g2vpxwBpJO5gCc5--

