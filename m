References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <1574183023-6136-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <939cd2df-7cef-1d03-d0ff-e244fc65414e@...2080...>
Date: Tue, 19 Nov 2019 19:27:30 +0100
MIME-Version: 1.0
In-Reply-To: <1574183023-6136-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="crWYxtxYyxTViielmdREjnHgLOESHaAxN"
Subject: Re: [Openvpn-devel] [PATCH v2] Fix ACL_CHECK_ADD_COMPILE_FLAGS to
 work with clang
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--crWYxtxYyxTViielmdREjnHgLOESHaAxN
Content-Type: multipart/mixed; boundary="neNPPZePbeH0IVXWoKYNnJ3B8m6ebgnEo";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <939cd2df-7cef-1d03-d0ff-e244fc65414e@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v2] Fix ACL_CHECK_ADD_COMPILE_FLAGS to
 work with clang
References: <1573760407-20662-1-git-send-email-selva.nair@...277...>
 <1574183023-6136-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1574183023-6136-1-git-send-email-selva.nair@...277...>

--neNPPZePbeH0IVXWoKYNnJ3B8m6ebgnEo
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 19/11/2019 18:03, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Some compilers (e.g., clang) only issue a warning for
> unsupported options unless an additional flag such
> as -Werror is used to convert the warning to an error.
>=20
> The behaviour is unchanged when using gcc as it either
> errors or ignores unknown options whether or not -Werror
> is present.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
> v2: Do not extend the macro to take an extra argument.
> Instead, add -Werror while doing the test.
>=20
> The commit message and comment changed to match this.
>=20
>  configure.ac | 9 ++++++---
>  1 file changed, 6 insertions(+), 3 deletions(-)
>=20

Tested running ./configure and 'make' using gcc-4.3.8, gcc-8.3.1 and
clang-5.0.1.  With patch applied, everything works as expected and no
unexpected halts during these two steps.   Without this patch, clang-5.0.1
spits out lots of warnings related to -Wno-stringop-truncation.

Acked-By: David Sommerseth <davids@...515...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--neNPPZePbeH0IVXWoKYNnJ3B8m6ebgnEo--

--crWYxtxYyxTViielmdREjnHgLOESHaAxN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJd1DQSAAoJEIbPlEyWcf3ydYkP/2ZNAMdXw6qHAQzAYPLMxo7b
6ZfbRov3qgq91ZGY8gSJRK4n/Tnpvu16O8639/IG+eWshiF89pnUPtAGg1laSP/g
xUS/VVQ7CBiI0m8CFCK9OkpNSU1Qzjgd7Xf6elByD12q09v/056egwrOS/U6Eixd
Fyfrf7IyR0tX/nLoFjEaON7AeKYD/vMHtHL4Bxklh4YaqSKhiqPdoZkwCFaRs8tV
ChUPBEUrX0fCyNvDmSJ0NnnS4PF7hUUtW0CUgG/cqVo6UFdttiCnQ9rPRWU2Et37
/pU5SEZCRAhJPtGnNMAfpNT0wIcN84QWfovqZa4Ap8jVZ07blH/T7+cScDFwCoCJ
38qdlgd9It/4vy/zbnnf8ivdxF5skeB9humKKZhD67X72qjeaBSqDK8onmdotQzl
wFNko0KQo9tQuZejQyeHBm0x/XWwvd6GS2iQ8Akv1UulkgknkPmTHbco00fhLCq4
GQFozQqfVQ9W5Uq0O4dmHZmQ4Y4z12DZsXT0ziOfneuyfcb61kt1s30AmiySDtAp
5Sy1xbcBXm8T9H/9tnT8TmgIB7kGn3H+8mswiqWjT3DQ3nud0n7lsqq1h/uYhcWi
tuRdNx21zzK+QjstCa7E1cn/mS294hywo4jZaZyIv/kYECMz5wFV6wvSog1kKGaR
mqWb0ZajKffeNne3FEUo
=rJuF
-----END PGP SIGNATURE-----

--crWYxtxYyxTViielmdREjnHgLOESHaAxN--

