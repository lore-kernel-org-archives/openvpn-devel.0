Message-ID: <52875786.2080806@...68...>
Date: Sat, 16 Nov 2013 12:31:18 +0100
From: Matthias Andree <matthias.andree@...68...>
MIME-Version: 1.0
References: <1384597423-11136-1-git-send-email-dazo@...384...>
In-Reply-To: <1384597423-11136-1-git-send-email-dazo@...384...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="KmCraxW3H10tJFpdVhKwmMrRFIEWEUOJD"
Subject: Re: [Openvpn-devel] [PATCH] t_client.sh: Write errors to stderr and
 document requirements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--KmCraxW3H10tJFpdVhKwmMrRFIEWEUOJD
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

ACK.

Am 16.11.2013 11:23, schrieb David Sommerseth:
> From: David Sommerseth <davids@...1347...>
>=20
> Signed-off-by: David Sommerseth <davids@...1347...>
> ---
>  INSTALL              | 4 ++++
>  tests/t_client.sh.in | 4 ++--
>  2 files changed, 6 insertions(+), 2 deletions(-)
>=20
> diff --git a/INSTALL b/INSTALL
> index 61dc975..2ef7904 100644
> --- a/INSTALL
> +++ b/INSTALL
> @@ -87,6 +87,10 @@ OPTIONAL (for developers only):
>        -- available from http://www.gnu.org/software/software.html
>    (2) Dmalloc library
>        -- available from http://dmalloc.com/
> +  (3) If using t_client.sh test framework, fping/fping6 is needed
> +      -- Available from http://www.fping.org/
> +      Note: t_client.sh needs an external configured OpenVPN server.
> +      See t_client.rc-sample for more info.
>=20=20
>  *************************************************************************
>=20=20
> diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
> index af12e2d..b13c802 100755
> --- a/tests/t_client.sh.in
> +++ b/tests/t_client.sh.in
> @@ -27,12 +27,12 @@ fi
>  # Check for external dependencies
>  which fping > /dev/null
>  if [ $? -ne 0 ]; then
> -    echo "$0: fping is not available in \$PATH"
> +    echo "$0: fping is not available in \$PATH" >&2
>      exit 77
>  fi
>  which fping6 > /dev/null
>  if [ $? -ne 0 ]; then
> -    echo "$0: fping6 is not available in \$PATH"
> +    echo "$0: fping6 is not available in \$PATH" >&2
>      exit 77
>  fi
>=20=20
>=20



--KmCraxW3H10tJFpdVhKwmMrRFIEWEUOJD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlKHV4YACgkQvmGDOQUufZUlNQCdEDvZzxDfsu2wBR8M+UfEgjCV
tVsAnjbCAgdKPs4saMmSrXIBJqmMFlr9
=FzbT
-----END PGP SIGNATURE-----

--KmCraxW3H10tJFpdVhKwmMrRFIEWEUOJD--

