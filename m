References: <414b5e76-c18d-5348-0d3c-84b121ca46bd@...2080...>
 <20190808145339.1265-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <925169bb-1f1c-3f18-b8c8-857cb3ed2b3c@...2080...>
Date: Fri, 13 Sep 2019 18:17:22 +0200
MIME-Version: 1.0
In-Reply-To: <20190808145339.1265-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="V0jnSPxkrwXxWKo3HDaY5YhbKqv0gSauA"
Subject: Re: [Openvpn-devel] [PATCH v6 6/7] Send indication that a session
 is expired to clients
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--V0jnSPxkrwXxWKo3HDaY5YhbKqv0gSauA
Content-Type: multipart/mixed; boundary="TdL6xuoyyR2wDqlMZ0BHVIe7aoH22b2TX";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: openvpn-devel@lists.sourceforge.net
Cc: Arne Schwabe <arne@...515...>
Message-ID: <925169bb-1f1c-3f18-b8c8-857cb3ed2b3c@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v6 6/7] Send indication that a session is
 expired to clients
References: <414b5e76-c18d-5348-0d3c-84b121ca46bd@...2080...>
 <20190808145339.1265-1-arne@...1227...>
In-Reply-To: <20190808145339.1265-1-arne@...1227...>

--TdL6xuoyyR2wDqlMZ0BHVIe7aoH22b2TX
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 08/08/2019 16:53, Arne Schwabe wrote:
> From: Arne Schwabe <arne@...515...>
>=20
> This allows OpenVPN 3 core to fall back to the original authentication
> method.
>=20
> This commit changes man_def_auth_set_client_reason to
> auth_set_client_reason since it now used in more contexts.
>=20
> Also remove a FIXME about client_reason not being freed, as it is freed
> in tls_multi_free with auth_set_client_reason(multi, NULL);
>=20
> Patch V4: Rebase on master
> ---
>  src/openvpn/auth_token.c |  3 +++
>  src/openvpn/ssl.c        |  6 ++----
>  src/openvpn/ssl_common.h | 10 +++++-----
>  src/openvpn/ssl_verify.c |  8 ++++----
>  src/openvpn/ssl_verify.h | 15 ++++++++++-----
>  5 files changed, 24 insertions(+), 18 deletions(-)
>=20
Acked-By: David Sommerseth <davids@...515...>

This looks reasonable and the code does what it says.  On my quick testing,=
 I
managed to trigger this to be sent to the client:

   AUTH: Received control message: AUTH_FAILED,SESSION: token expired


--=20
kind regards,

David Sommerseth
OpenVPN Inc



--TdL6xuoyyR2wDqlMZ0BHVIe7aoH22b2TX--

--V0jnSPxkrwXxWKo3HDaY5YhbKqv0gSauA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJde8EYAAoJEIbPlEyWcf3yW70P/juuOUo5+3BCVzj98RauoMP/
e84XwUvj3dLm6hQy4KmqdPbkwK4LzpSH5sAtrRse9MlbODsO8YxPEdVmNlAL+zZS
81qhC11nKxn73oyXzqYSfN14+hXU6aidkkcNwso40u3+VW8zd19uR25e1tc1KOlz
/l0H7Qhwpo4FlH5CX5ssMxYsfs9DMufSdPfQK+jFBAKV7Uu5gBMkaEn6WVnLvuUp
9eaJBYgBUgqIikgXxHgXczHfmWueoHZjfy5GhC+qQV4d2sGBzqDYAyk8t/P1mDdk
M1c2Jk2EB7XtRpN/B2+CZUepACEz/GeKoylo3zNxV6hj6Ai31w1D1YeRoUpYK9fO
uc7sRiHWWxTD5Ds8UwqVHma5I1JlI2+ZmQV+Q4ihMgdWuCIvzT6vm0BVXWzCtpID
nUgEJNSMTsT+oMuPBxpFkGAHWEFcZnYMo5LxFUpQGAU0ewXUG1/vv4L16kLjs6Ot
y7J1vtNWM6gJqGr8WWVhwM3sMTQdg1n/gK1pH8dDzSZJFeftiMUtggiLEUzif1Gg
1h04rwUOkUnEHPD3QI7cnv/E6FQHJni9r2f3AiXwZDpyrH8j6XxN3RBYYATnR3E6
SXozDvfGamklGTCpvVVP6jrg7QpxTAcY2rV0DedeI6sUA84g/o8G3XnrX8/eblDN
g5NzOk3JCN4xXvdL2l8Q
=Ulo6
-----END PGP SIGNATURE-----

--V0jnSPxkrwXxWKo3HDaY5YhbKqv0gSauA--

