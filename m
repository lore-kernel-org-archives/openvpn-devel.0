References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
Date: Thu, 19 Jan 2017 15:41:10 +0100
MIME-Version: 1.0
In-Reply-To: <1484772172-19758-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="omDSiGMKADvqwMICj72pP7PVNJ4kwFM7s"
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl,
 --wrap support in linker
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--omDSiGMKADvqwMICj72pP7PVNJ4kwFM7s
Content-Type: multipart/mixed; boundary="99Etob4KoW1DgMWPt9eOVXEBSfQnARcip";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <3e2e63ed-99fb-e880-11dc-b0748f501567@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Add a check for -Wl, --wrap support in
	linker
References: <1484772172-19758-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1484772172-19758-1-git-send-email-selva.nair@...277...>

--99Etob4KoW1DgMWPt9eOVXEBSfQnARcip
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 18/01/17 21:42, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Also make tests that require --wrap option to be
>   conditional on this support
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  configure.ac                         | 26 ++++++++++++++++++++++++++
>  tests/unit_tests/openvpn/Makefile.am |  6 +++++-
>  2 files changed, 31 insertions(+), 1 deletion(-)

This looks like a very good approach to me, and I believe it is done
correctly.  One comment though, below ...

> diff --git a/configure.ac b/configure.ac
> index 43487b0..0b7fea9 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -582,6 +582,31 @@ AC_COMPILE_IFELSE(
[...snip...]
> +		AC_DEFINE([HAVE_LD_WRAP_SUPPORT], [1], [Define to 1 if linker supports=
 -Wl,--wrap option])

Any reason to have this AC_DEFINE?  That puts HAVE_LD_WRAP_SUPPORT into
config.h, which I don't think makes much sense.  If we don't have --wrap
support, would we have #ifdef HAVE_LD_WRAP_SUPPORT in the C code at all?

[...snip...]
> +AM_CONDITIONAL([HAVE_LD_WRAP_SUPPORT], [test "${have_ld_wrap_support}" =
=3D "yes"])

This however is the clue of it all, to ensure we can do the proper check
in Makefile.am files, as you've done below

> +if HAVE_LD_WRAP_SUPPORT
> +check_PROGRAMS +=3D argv_testdriver buffer_testdriver
> +endif

It would be great if macOS/OSX users with LLVM compilers installed could
run some tests with this patch by EOB tomorrow (Friday Jan 20).

If I don't hear any objects by then, I am going to give this an ACK
without the AC_DEFINE line (unless good arguments having this in
config.h surfaces).

Selva, if you don't mind ... I can use this patch and just take out the
AC_DEFINE line at commit time.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--99Etob4KoW1DgMWPt9eOVXEBSfQnARcip--

--omDSiGMKADvqwMICj72pP7PVNJ4kwFM7s
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYgNAGAAoJEIbPlEyWcf3yuzkP/irnVV0dLnYfAYWabOTsyAR9
BkqcPMlsmAk81z3Tdw6H+wWRXEwfhiiFAc6TXXTRkoC5NUw/RlSHqvP7X1rlz3lB
z0poQShx/rT5DSAbqekS/8D40LbkPQgVGqr7N7MrTB4yyuHgtoCkoLFaljTANA0/
9xQB4Ctg7tESi6ckhAhn6VZ3wssDBN7gQpc54tbTImcgCdJOhElgttQb5TXlYXLq
XMhbjCfNHW18JU/fu8Juy+PkSloHXfNlCfacRN0O+Ajpf9Q4ldXpwVZluE+fIJIq
aEEF0tLKEVpp5lRjh0ddaoPVIdCw6J+PQ2jyBLjtoIrZyBI1ds+QTfsUNNeN9VQm
AJ1DZRqSm1XW3eO1jaitCDxnAyNZvhABDhILGx4AvcThKM1QUCXJc8RDET6qszon
Wsm1HBeI/coIvLnvebfHCqyuau/4dHINoOZcHQg8tiHjqqnt31m/3YIFOVuGSgji
BFsdmItSDz+QZPo2mtKVLTXizA4rb807m8+MON5N+nO8rXrYV0bF6a/rKesPzSCe
5srdgkZZ33MvVWO36aixGLj73rbQAy/k56ibbP454trWqR+BnYuBuzh3mPH1lB6B
Tr5ngpD9ur2iAc4sFayXmR522wwo27P15pX9cqealZfOW8Y2uMXVPJrpDE8zLjH2
89gg3xQhhP3P2hZU8Ewr
=cUiA
-----END PGP SIGNATURE-----

--omDSiGMKADvqwMICj72pP7PVNJ4kwFM7s--

