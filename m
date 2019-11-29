From: David Sommerseth <openvpn@...2080...>
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
Message-ID: <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
Date: Fri, 29 Nov 2019 11:47:02 +0100
MIME-Version: 1.0
In-Reply-To: <20191128194320.GM40538@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="Ink1TVR7wzDaVrtJ5wmVkrS02NzK7jAsU"
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Ink1TVR7wzDaVrtJ5wmVkrS02NzK7jAsU
Content-Type: multipart/mixed; boundary="UDYK7xTgF0tMt7x7Lh7QDuImBzadpjnpj";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Message-ID: <2aa50cbc-cc17-81d5-ec9a-98fd5e8ba503@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] fix clang warning about missing braces
References: <20191128080631.117-1-lstipakov@...277...>
 <E1iaLck-0000Aj-5c@...2508...>
 <CAKuzo_jR6WYsM9QZhdyp8sW6avFGhDnFzx_dNN63JD4iiSmFag@...278...>
 <20191128194320.GM40538@...1296...>
In-Reply-To: <20191128194320.GM40538@...1296...>

--UDYK7xTgF0tMt7x7Lh7QDuImBzadpjnpj
Content-Type: multipart/mixed;
 boundary="------------FB0AA0E0E45E83D0FE0E4911"
Content-Language: en-US

This is a multi-part message in MIME format.
--------------FB0AA0E0E45E83D0FE0E4911
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/11/2019 20:43, Gert Doering wrote:
> hi,
>=20
> On Thu, Nov 28, 2019 at 11:56:34AM -0500, Selva Nair wrote:
>> I think the correct fix here is to remove -Werror from travis build.
>> I have tried and failed to lobby for this earlier, but one more try
>> can't hurt, I suppose :)
>=20
> Can we restrict -Werror to gcc builds, for the time being?
>=20
> If not, I agree with you, and it needs to go...
>=20
> Valid (and unambiguous) C statements shouldn't cause warnings, and we
> shouldn't add patches just because an old version of a certain compiler
> is silly.


With GCC-4.3.8, I see this warning:

crypto.c: In function =91write_pem_key_file=92:
crypto.c:1860:12: warning: missing braces around initializer [-Wmissing-bra=
ces]
     struct key server_key =3D { 0 };

Perhaps we should just add -Wno-missing-braces?  A quick patch is attached,
this silences this warning with GCC-4.3.8 at least.  That said, I'm not
sure this is the best approach; it may hide other missing braces warnings
we should see.


--=20
kind regards,

David Sommerseth
OpenVPN Inc




--------------FB0AA0E0E45E83D0FE0E4911
Content-Type: text/x-patch; charset=UTF-8;
 name="0001-build-Add-Wno-missing-braces-to-CFLAGS.patch"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: attachment;
 filename="0001-build-Add-Wno-missing-braces-to-CFLAGS.patch"

=46rom 1166081219e8623e32aeea93ddabd2937df36ef8 Mon Sep 17 00:00:00 2001
From: David Sommerseth <davids@...515...>
Date: Fri, 29 Nov 2019 11:43:34 +0100
Subject: [PATCH] build: Add -Wno-missing-braces to CFLAGS
MIME-Version: 1.0
Content-Type: text/plain; charset=3DUTF-8
Content-Transfer-Encoding: 8bit

Some older GCC and clang compilers complains about missing braces when
initaling structs.

crypto.c: In function =E2=80=98write_pem_key_file=E2=80=99:
crypto.c:1860:12: warning: missing braces around initializer
[-Wmissing-braces]
     struct key server_key =3D { 0 };

Use of the ACL_CHECK_ADD_COMPILE_FLAGS() macro to check if the compiler
support -Wno-missing-braces flag, which ends up in CFLAGS if the
compiler accepts it.

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index a47e0a06..0e98dfaa 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1289,6 +1289,7 @@ AC_DEFUN([ACL_CHECK_ADD_COMPILE_FLAGS], [
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-stringop-truncation])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-function])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-unused-parameter])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wno-missing-braces])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
=20
 if test "${enable_pedantic}" =3D "yes"; then
--=20
2.17.1


--------------FB0AA0E0E45E83D0FE0E4911--

--UDYK7xTgF0tMt7x7Lh7QDuImBzadpjnpj--

--Ink1TVR7wzDaVrtJ5wmVkrS02NzK7jAsU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJd4PcnAAoJEIbPlEyWcf3yf+wP/iFeIIqV4X3UhunbPNdZpze3
iEbwQ1S21mzTPcIgAx4eQlI7seqX4deXcJZ9NQCJa/raSHjjDDSguGINKOTa8QrK
DX6RmkKp5hOEYrXZo88bK8Pt7MZfzc6rch6BktsDNV2Q4taGb15c5eVleoC5ZPya
rexIuADf1H5gUpOk6+uLcPqDanIKp2Dlb0CDUlVtpVN6QEASzoF6ddLEZMVI0NhI
CuhRUl3lp4t19dfFYZ+NtXWiyZ8rK+u3pnlD8WBWqT+mCCfjFI7zHC9GyZiSmzFl
R9lAaItDziBopQkL4tAD8lHgaDi2dxmvNHOUspKyN5uSfwKZkr9ihuOWtlzPm9pz
deGQv/mYkn19P4NZy5/CE9CgUh5SSU9sKSIbduoPCZDyFbTFkPY47KRwDaJKir9w
O1mJLD18y2xsQ9Ay/iDNJwfnosn1mJFdDQkMhfTN26f2gEpZxNswh1HCvdcLEiZA
kdtNMEmiunlr49Cx8Nxue6ZdDorlpXlCY05+b7sE3zlrWI75VplkERs55HRsiqCp
Lr69FYYHB13tjK3YBRzhSatzx+XGkzqusOZBVbZEni3ldLrui5iMVKogE7EZBaaK
g6UIEXM880bUenLh/rNhlZewQde0Jd19z5aUjlzBM3HYYhiF26GzRtg0dxWQ8ww2
ITa5m6nx1dchyxsEG7aj
=7P0B
-----END PGP SIGNATURE-----

--Ink1TVR7wzDaVrtJ5wmVkrS02NzK7jAsU--

