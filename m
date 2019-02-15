References: <1549917961-632-1-git-send-email-selva.nair@...277...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <44fea524-53ef-8125-5d81-cd8aaac0ad16@...2080...>
Date: Fri, 15 Feb 2019 21:26:50 +0100
MIME-Version: 1.0
In-Reply-To: <1549917961-632-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="A3dMV7lgPy9RYZfxPpQmcIyLS6P0RZhCq"
Subject: Re: [Openvpn-devel] [PATCH] Exit early when external scripts are
 specified with script-security < 2
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
--A3dMV7lgPy9RYZfxPpQmcIyLS6P0RZhCq
Content-Type: multipart/mixed; boundary="JLpcjUqk3amQgP7vuhD57u2pkBDMmtRPy";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <44fea524-53ef-8125-5d81-cd8aaac0ad16@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Exit early when external scripts are
 specified with script-security < 2
References: <1549917961-632-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1549917961-632-1-git-send-email-selva.nair@...277...>

--JLpcjUqk3amQgP7vuhD57u2pkBDMmtRPy
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 11/02/2019 21:46, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> Currently this raises a warning only. A fatal error is triggered
> later with a confusing message that script failed to execute.
>=20
> This helps the Windows GUI to show a relevant error message when
> script-security is over-ridden as a security measure.
>=20
> Signed-off-by: Selva Nair <selva.nair@...277...>
> ---
>  src/openvpn/init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 3c44967..5863828 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -3206,7 +3206,7 @@ do_option_warnings(struct context *c)
>          }
>          else
>          {
> -            msg(M_WARN, "NOTE: starting with " PACKAGE_NAME " 2.1, '--sc=
ript-security 2' or higher is required to call user-defined scripts or exec=
utables");
> +            msg(M_FATAL, "ERROR: starting with " PACKAGE_NAME " 2.1, '--=
script-security 2' or higher is required to call user-defined scripts or ex=
ecutables");

Generally speaking, I am fine with this (so Feature-ACK).

What I am struggling with though is that this may break existing
configurations for users who do have an invalid configuration file.  In this
case trying to use scripts without --script-security *and* ignoring that th=
eir
scripts does not work.  The cynical me says "scr** them, they need to fix
their configs".

But I also got lots of complaints from Fedora users when we changed
_incorrect_ configurations to fail in similar ways.  It's just amazing how =
few
users who really *read* their log files.  So with this in mind, I think this
behavioural change should go in 2.5 only.

So I can give this a full ACK for git master only.


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--JLpcjUqk3amQgP7vuhD57u2pkBDMmtRPy--

--A3dMV7lgPy9RYZfxPpQmcIyLS6P0RZhCq
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJcZyCLAAoJEIbPlEyWcf3y7PoQAKjdNu56ppiol8w54n8IDT4f
Q+WAyzYca+m7h7V1Vw38o3Dw/UxNAov3zek3/hMJoa66ufHK7x1IOr2qSpt3gN+5
3e5dkCv1LfW1iNOTdWiUI1ZAbwQYia9cWQMG0CQJKa/rYZA3ijNu9/FWrgMbmPDe
NKJL0g7gezXWl11nPJNKyoGgdI0Bs1ionZpW6ObjMcRZMAxNAZX4DpQesdmdImzg
EacTzts1V0OnPyiOZNhUkjca+eRI0Z/9J+jDle8C70jiUIqspOjHY+W9V8a2BaI4
Ep1cz8SxPrrAHpC+dNDfVc/YUkWTNz4dZxYh56UQT6RzRtGS3ABnYRP2NtP3O0j7
Y+2k7ksSpJVY7Y4YEGIQcAKMdz2WYRoc5m6Eg+VS7Op54TKw9JHa1DMfpeRM4uIm
Wztp151ve5MztsnDvCON4tOmDfUrd7cY+mPPjrfuuiKtXmcyzbxp3lJ342Rx5NdT
48CIRuN6JsQikkr0Cg0dlzH7U3tblNmVeqfE8K26yB/lfp/hX2pWWfJWKN1j224L
F5AHHusA8b0CpErez9NtLnO1I59JkrO6TL/3kZ9uYYwn14U7fUhHTLO8YzfGaJWt
tCBY5LQiXj4BfuDQvh7bJeDe17iNq8UUFfxqPx9vdkGJ7zqgM+yFlKBwe7wpMVG8
rySH+XL9SGRuzYdU5yVF
=Z3TJ
-----END PGP SIGNATURE-----

--A3dMV7lgPy9RYZfxPpQmcIyLS6P0RZhCq--

