References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-5-git-send-email-heiko.hund@...1489...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <6b75fc5b-a002-7804-63a5-085a7286e826@...2080...>
Date: Tue, 8 Nov 2016 14:18:39 +0100
MIME-Version: 1.0
In-Reply-To: <1477672963-5724-5-git-send-email-heiko.hund@...1489...>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="3XWm6MNVRgj6069T9UWKEAV6th81VdJnc"
Subject: Re: [Openvpn-devel] [PATCH 4/7] Factor out %sc handling from
 argv_printf()
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3XWm6MNVRgj6069T9UWKEAV6th81VdJnc
Content-Type: multipart/mixed; boundary="hIHVmshNX8xW0Ie8s3Jl2m4nMpRsUROkW";
	protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Heiko Hund <heiko.hund@...1489...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6b75fc5b-a002-7804-63a5-085a7286e826@...2080...>
Subject: Re: [Openvpn-devel] [PATCH 4/7] Factor out %sc handling from
	argv_printf()
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
	<1477672963-5724-5-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-5-git-send-email-heiko.hund@...1489...>

--hIHVmshNX8xW0Ie8s3Jl2m4nMpRsUROkW
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

On 28/10/16 18:42, Heiko Hund wrote:
> Move functionality to parse command strings into argv_parse_cmd().
> That is a preparation for the upcoming refactoring of argv_printf().
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> ---
>  src/openvpn/argv.c                   | 47 +++++++++++++++++-------------=
------
>  src/openvpn/argv.h                   |  1 +
>  src/openvpn/errlevel.h               |  2 +-
>  src/openvpn/init.c                   |  2 +-
>  src/openvpn/misc.c                   | 10 +++-----
>  src/openvpn/multi.c                  | 13 ++++------
>  src/openvpn/options.c                |  2 +-
>  src/openvpn/socket.c                 |  7 +++---
>  src/openvpn/ssl_verify.c             |  6 +++--
>  tests/unit_tests/openvpn/test_argv.c | 18 +++++++++++---
>  10 files changed, 56 insertions(+), 52 deletions(-)

ACK.  This is a bit more invasive, but all testing looks good.  Code
changes are reasonable.  Tested with 'make check', separate tests using
--auth-user-pass-verify on server side and a couple of valgrind checks.
In addition, 'ip route' was executed.

The argv_parse_cmd() is also generic and used all places where %sc was
used before, I consider this smoke-testing good enough for now.

As for the prior patches in this series, I will wait with applying this
patch to the git tree until all the other patches in this series have
been reviewed and ACKed.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--hIHVmshNX8xW0Ie8s3Jl2m4nMpRsUROkW--

--3XWm6MNVRgj6069T9UWKEAV6th81VdJnc
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJYIdCvAAoJEIbPlEyWcf3yOIcP/0K0kOTccCGd6WjAfjZmyGIZ
3ljV+ljL/R6mEDG5m6zWI2b207TG58J+TXCSeD+mCZ8NmXdTMTIZFDjpIoLcQ8/I
7Bb/xLy4IQNbdi08h4fA/QCoLstMgCt13RZVQZMOgHXe+UBQXte4Jaw9PEsVD0O9
tPVgS/VjohCiqUNTFQSAU9cMLaso6HunXAV9Elz+fufuK3MIkdifV+Nt4J6maNgH
69S/kZMf8rB1EmTs16OdnvfZqxVC33FkPUnZWk8JuUGMNpMpVa0/jKlLSWHC7mmV
HwhAUVlLuKrYTrDuLA/7g1CFuRS4siuWbxK05JIEMwlg8bSq/XKEMNyGrAGWlE2G
92ovNPBdSMLtQQVFWWGV+EViyPGSpkp8FzamCaKNJnohsfbx494Orj/AJ4MWNWY5
FQy2goXhw3UUZX7j0Uz90bXdLexgujE1+CiO7gAOvAdRyC4sZcOiaxlXFoYQJiDw
tQ9Ut9hPFPuF4VE+9BI/UDOX+hO/zbl63fuUm8ANxXxmeq4ncz5+MegWmWF584S+
DatArNBI11fmHfDAG8YH3cVrPs4WPBRr4vFfIKh/DS1BXFx/9lZFFLDx/BNeeFp0
IqeKJOK0zb3Rk22l8j26CAYeblKBveMUW6xkQ3a4tH2UNSKY5owr1ejWYhY1Ev56
5CNaxDyLORUeF9VBAN4P
=asxf
-----END PGP SIGNATURE-----

--3XWm6MNVRgj6069T9UWKEAV6th81VdJnc--

