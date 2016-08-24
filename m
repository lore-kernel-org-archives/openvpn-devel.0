References: <1471284156-2324-1-git-send-email-steffan@...1856...>
From: Matthias Andree <matthias.andree@...68...>
Message-ID: <1c1faba6-f673-1c14-57ba-0fba32d674eb@...68...>
Date: Thu, 25 Aug 2016 00:52:22 +0200
MIME-Version: 1.0
In-Reply-To: <1471284156-2324-1-git-send-email-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="3ERl3XliBccngbshJs9XCF4LTMeKAIOfW"
Subject: Re: [Openvpn-devel] [PATCH] Fix unittests for out-of-source builds
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
--3ERl3XliBccngbshJs9XCF4LTMeKAIOfW
Content-Type: multipart/mixed; boundary="qBr0GLnn6inWV5KEVJNeNhDcTSLEmF6r3"
From: Matthias Andree <matthias.andree@...68...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <1c1faba6-f673-1c14-57ba-0fba32d674eb@...68...>
Subject: Re: [Openvpn-devel] [PATCH] Fix unittests for out-of-source builds
References: <1471284156-2324-1-git-send-email-steffan@...1856...>
In-Reply-To: <1471284156-2324-1-git-send-email-steffan@...1856...>

--qBr0GLnn6inWV5KEVJNeNhDcTSLEmF6r3
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 15.08.2016 um 20:02 schrieb Steffan Karger:
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  configure.ac | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/configure.ac b/configure.ac
> index 4f14ebd..9189c94 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -1215,7 +1215,7 @@ AC_SUBST([TEST_CFLAGS])
>  # needed for unit testing
>  AC_CHECK_PROGS([CMAKE], [cmake])
>  if test -n "${CMAKE}"; then
> -   if test -f vendor/cmocka/CMakeLists.txt; then
> +   if test -f "${srcdir}/vendor/cmocka/CMakeLists.txt"; then
>        AM_CONDITIONAL([CMOCKA_INITIALIZED], [true])
>     else
>        AM_CONDITIONAL([CMOCKA_INITIALIZED], [false])

Required and effective.

ACK.




--qBr0GLnn6inWV5KEVJNeNhDcTSLEmF6r3--

--3ERl3XliBccngbshJs9XCF4LTMeKAIOfW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIcBAEBCgAGBQJXviUnAAoJEOQSsVbv84VaQVUP+wTZi0Zod+yG24++qAk4/lXB
UpEHNeM07nvlSHo2mwpUBwd+4P3H1IUDWI0jOv6o7LQ7Sogvns8YM6Hjk3py6aH5
N4tfcM0E0f8NxdbF81sQpUoNBXS9DwyUc9vpLEB/0O1MYuqsfLacbIzS2E94/jA0
QbHIoAwMyKXal2hDLif4Q8DRziITIsEzjfXmX9jGZwt6mDRw12caSqO6twcD1qtF
gaGWWYcF/CM/Ir+a75I7cmp9faezMKb2cSrWxCQad7BafEvb3yMcBCJemAGYjLMC
fRogdrMtCa5Y1nvUBz+0JK0mRhQCsWuaM3Lt00cGxBYjxaCPoxFewg02OnG7koxI
rxoTOGnW4TgWZ2+kdpR5eL8TitpK3fo2dQn/4QBCjM7h4dE073vzHtquFkBDTkjt
9ERbrbI80Xu6BVCJDL42Y1xMCoKkiRP+tAhvo51KnhM3FgO3QEtV+clBt/R+epBf
VcCVSRX0emDewaWbhgsYw/JIOjibYPt14blk/zYqBmbUrPzDrugPwxdgc/im+HkM
O0eKIQAK/CySLgVPsq9dADibc13c5bxaON46/Y9nIKgSewd7KXSuV8fgwrXsffAg
YP5ShmW8uRFLO57XrE4PBvFudMkQe+a59qPqAYz+2yJXixCm47pTs4hXGURYaJVH
wNJcFpnvXes+xKTesRr5
=5r9D
-----END PGP SIGNATURE-----

--3ERl3XliBccngbshJs9XCF4LTMeKAIOfW--

