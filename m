References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <192d8759-72ee-956a-55a8-e51f9104d552@...1435...>
Date: Tue, 8 Nov 2016 09:44:43 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-2-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="ovx1AKKmjerbIWqw61L8PP0AHjo114Kan"
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
 add unit tests
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--ovx1AKKmjerbIWqw61L8PP0AHjo114Kan
Content-Type: multipart/mixed; boundary="TJ6Wa3f3p0d71ncgnP2e6FLJfmMXEHKww";
	protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <192d8759-72ee-956a-55a8-e51f9104d552@...1435...>
Subject: Re: [Openvpn-devel] [PATCH 1/7] put argv_* functions into own file,
	add unit tests
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-2-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-2-git-send-email-heiko.hund@...1489...>

--TJ6Wa3f3p0d71ncgnP2e6FLJfmMXEHKww
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Hi,

I didn't look at the code itself (David already did), but two very minor
nitpicks I ran into while rebasing my src/openvpn/* unit tests on this
patch:

On 28-10-16 18:42, Heiko Hund wrote:
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1273,6 +1273,7 @@ AC_CONFIG_FILES([
>          tests/unit_tests/plugins/Makefile
>          tests/unit_tests/plugins/auth-pam/Makefile
>          tests/unit_tests/example_test/Makefile
> +        tests/unit_tests/openvpn/Makefile
>          vendor/Makefile

Could we keep this ordering alphabetical?  (And fix the example_test
occurrence as we go?)

> diff --git a/tests/unit_tests/Makefile.am b/tests/unit_tests/Makefile.am
> index 8868c1c..44ab26b 100644
> --- a/tests/unit_tests/Makefile.am
> +++ b/tests/unit_tests/Makefile.am
> @@ -1,5 +1,5 @@
>  AUTOMAKE_OPTIONS =3D foreign
>=20=20
>  if CMOCKA_INITIALIZED
> -SUBDIRS =3D example_test plugins
> +SUBDIRS =3D example_test plugins openvpn
>  endif

Here too alphabetical ordering would be a little nicer.

Maybe David can tackle this when applying?

-Steffan


--TJ6Wa3f3p0d71ncgnP2e6FLJfmMXEHKww--

--ovx1AKKmjerbIWqw61L8PP0AHjo114Kan
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJYIZB7AAoJEEEwndWOY1w5mkEH/00H6pX50F55kUW9cTaiblLO
jy7ZilQhpB5dPPp5gbIADC5+AZDkYQy/a0LU/w/J65Hzlxee1qV9KjyJFsbrSWAc
0CFpOKDS6kQnlHjNv03ZxiNdWEBffmjxys5csqvQuVeOPfW9xEOSvwZlUEumQX1Z
MUYwxbzocA3wUbOR5BabEvoSS3f7noNpBhcwhKZtUx55jZWEN0SD5H/kP2+nyfFj
zkJkDNZGRHnaQkrjVRPDN4CCDzU5ynmMaqPKy/MjlkDFSknBgum1/fMMcEiFfMZ4
Zydr0Nw9efq7kw6N3d65ttWI2l6dcSIJqHeuuMynLJsN1CWsnDmKzfJD7ywNz3k=
=I+Tj
-----END PGP SIGNATURE-----

--ovx1AKKmjerbIWqw61L8PP0AHjo114Kan--

