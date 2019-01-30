References: <1544210258-8754-2-git-send-email-selva.nair@...277...>
 <1548265738-11004-1-git-send-email-selva.nair@...277...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <7fb244f4-674a-ce0d-ed3f-8601d75df5e5@...1227...>
Date: Wed, 30 Jan 2019 14:09:16 +0100
MIME-Version: 1.0
In-Reply-To: <1548265738-11004-1-git-send-email-selva.nair@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f757w7L0pb14vQOi3hluYkYiLHJU6GE8F"
Subject: Re: [Openvpn-devel] [PATCH 2/2 v2] Handle PSS padding in
 cryptoapicert
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
--f757w7L0pb14vQOi3hluYkYiLHJU6GE8F
Content-Type: multipart/mixed; boundary="8yxDARp062aVBfYEnvZVSNZ2UIskaCa8J";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <7fb244f4-674a-ce0d-ed3f-8601d75df5e5@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 2/2 v2] Handle PSS padding in
 cryptoapicert
References: <1544210258-8754-2-git-send-email-selva.nair@...277...>
 <1548265738-11004-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1548265738-11004-1-git-send-email-selva.nair@...277...>

--8yxDARp062aVBfYEnvZVSNZ2UIskaCa8J
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 23.01.19 um 18:48 schrieb selva.nair@...277...:
> From: Selva Nair <selva.nair@...277...>
>=20
> For PSS padding, CNG requires the digest to be signed
> and the digest algorithm in use, which are not accessible
> via the rsa_sign and rsa_priv_enc callbacks of OpenSSL.
> This patch uses the EVP_KEY interface to hook to
> evp_pkey_sign callback if OpenSSL version is > 1.1.0.
>=20
> To test this code path, both the server and client should
> be built with OpenSSL 1.1.1 and use TLS version >=3D 1.2
>=20
> Tested on Windows 7 client against a Linux server.
>=20

Normally, I not always expect patches to always cleanly apply but in
this case I cannot get git to apply this thing.

git am <~/dl/Openvpn-devel-2-2-v2-Handle-PSS-padding-in-cryptoapicert.patch
Applying: Handle PSS padding in cryptoapicert
error: patch failed: src/openvpn/cryptoapi.c:320
error: src/openvpn/cryptoapi.c: patch does not apply
Patch failed at 0001 Handle PSS padding in cryptoapicert
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


git am --3way
Applying: Handle PSS padding in cryptoapicert
error: sha1 information is lacking or useless (src/openvpn/cryptoapi.c).
error: could not build fake ancestor
Patch failed at 0001 Handle PSS padding in cryptoapicert
hint: Use 'git am --show-current-patch' to see the failed patch
When you have resolved this problem, run "git am --continue".
If you prefer to skip this patch, run "git am --skip" instead.
To restore the original branch and stop patching, run "git am --abort".


Since Gert/David will also face the same problems later it might be
easier to resend this patch in a form that applies to master without
manually resolving conflicts.

Arne


--8yxDARp062aVBfYEnvZVSNZ2UIskaCa8J--

--f757w7L0pb14vQOi3hluYkYiLHJU6GE8F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxRofwACgkQFRhsZwKx
RFQe4Q/8CQ2ymXHgcoQMKkGC1VKpHHT7vuigNN5aozuorRhirzgmE5+s4+6mcy39
mBp4hxt2OYA5TGVNNw0bIkmZKGroEA8uUvrtAfKmQ9meLa506SQwxUrxXKSNVTn+
egihJJqsORsOQdR2SC2afkoGigTIo/F1IgSN6fzQYfxIkI79YBQXGtUkKyRz8ljv
C7e+gASsjLC+kvws3qLfgL96R/aeBtcwdPqs72LrPOQWA7LmccYVt9R43TUfjBCY
NgQz3VgnMCYlReYU0Tl2h2Xp+B0PVAYNfhYa1a43A28zXFi6RMLaT7E1Gp8ZyIlA
oQIU2+gE5nKLhuEksX6VFf/VHWwGttXIWX6vDFfT658uHIbAtjUPWEP9GV1JoxOO
Apc81StxY55uD0zypPH7nLxYYjklVvlj3cQOnNl37lyo47T1k3q8bmkpnp+HNFhz
i+1TPKfsG5kdSkcriDHXNZhu3Y7nO0ll0fO9ZfUmEp2TFEpjFWsV+PMzZImQZ0Mr
Nw3XFgRnDWyMiQXX2d8fHb+n7kx9nxvBCVtagcayvngev8ncgmbjXxwSt3LPPKmg
lYdULBkKU401TBmGLmN7PPD3GJodHffP7pvTSKeqPGW6T/IqueTkzYKNfilY5KGx
QODhWu9dqYLENYXqrGjof3OihWFxZuzsiklqZgesUNmvaNUNuJw=
=F9QS
-----END PGP SIGNATURE-----

--f757w7L0pb14vQOi3hluYkYiLHJU6GE8F--

