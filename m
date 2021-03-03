References: <a4ad13e6-dfbe-2b1f-c818-10f2c87218a6@...2080...>
 <20210226134829.3589-1-arne@...1227...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <954a714f-6840-773f-6b02-260a39f5636a@...2080...>
Date: Wed, 3 Mar 2021 22:04:26 +0100
MIME-Version: 1.0
In-Reply-To: <20210226134829.3589-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j7ERCZYcR4iApq3bRePjzNINNZjJkP74b"
Subject: Re: [Openvpn-devel] [PATCH v3] Implement deferred auth for scripts
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j7ERCZYcR4iApq3bRePjzNINNZjJkP74b
Content-Type: multipart/mixed; boundary="8wPZCFwOpftCYPhxZPKEtTZugtxBEIjDP";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <954a714f-6840-773f-6b02-260a39f5636a@...2080...>
Subject: Re: [Openvpn-devel] [PATCH v3] Implement deferred auth for scripts
References: <a4ad13e6-dfbe-2b1f-c818-10f2c87218a6@...2080...>
 <20210226134829.3589-1-arne@...1227...>
In-Reply-To: <20210226134829.3589-1-arne@...1227...>

--8wPZCFwOpftCYPhxZPKEtTZugtxBEIjDP
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable

On 26/02/2021 14:48, Arne Schwabe wrote:
> This patch also refactors the if condition that checks the result of
> the authentication since that has become quite unreadable. It renames
> s1/s2 and extracts some parts of the condition into individual variables
> to make the condition better understandle
>=20
> Patch V2: add refactoring of the if condition
>=20
> Signed-off-by: Arne Schwabe <arne@...1227...>
> ---
>   Changes.rst                         | 12 +++++
>   doc/man-sections/script-options.rst | 14 ++++-
>   src/openvpn/ssl.c                   |  2 -
>   src/openvpn/ssl_verify.c            | 84 +++++++++++++++++++++--------
>   4 files changed, 87 insertions(+), 25 deletions(-)

I've just looked at the code/diff this time.  One good and one ugly.

The good one: The C code looks fine, and is good to go.  ENABLE_DEF_AUTH=20
is goe, which was my only complaint.

The ugly one: Documentation is still incorrect.  From the diff:

+=C2=B7=C2=B7When=C2=B7deferred=C2=B7authentication=C2=B7is=C2=B7in=C2=B7us=
e,=C2=B7the=C2=B7script=C2=B7can=C2=B7also=C2=B7request
+=C2=B7=C2=B7pending=C2=B7authentication=C2=B7by=C2=B7writing=C2=B7to=C2=B7=
the=C2=B7file=C2=B7specified=C2=B7by=C2=B7the
+=C2=B7=C2=B7:code:`auth_pending_file`.=C2=B7The=C2=B7first=C2=B7line=C2=B7=
must=C2=B7be=C2=B7the=C2=B7timeout=C2=B7in
+=C2=B7=C2=B7seconds=C2=B7and=C2=B7the=C2=B7second=C2=B7line=C2=B7the=C2=B7=
EXTRA=C2=B7as=C2=B7documented=C2=B7in=C2=B7the
+=C2=B7=C2=B7``client-pending-auth``=C2=B7section=C2=B7of=C2=B7`doc/managem=
ent.txt`.

This does not match what the TOTP auth-pending demo code does:

+def=C2=B7write_auth_pending(timeout,=C2=B7method,=C2=B7extra):
+=C2=B7=C2=B7=C2=B7=C2=B7with=C2=B7open(os.environ['auth_pending_file'],=C2=
=B7'w')=C2=B7as=C2=B7auth_pending:
+=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7=C2=B7auth_pending.write("%d\n%s=
\n%s"=C2=B7%=C2=B7(timeout,=C2=B7method,=C2=B7extra))

The documentation does not mention the "method" part.


There are also a few nitpicks in the patch 11/11 which I did not see on=20
the ML so far.
<https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21528.=
html>
Message-Id: <d5a5d7b8-662f-ef51-4081-027fcb8cefd8@...2080...>

--=20
kind regards,

David Sommerseth
OpenVPN Inc



--8wPZCFwOpftCYPhxZPKEtTZugtxBEIjDP--

--j7ERCZYcR4iApq3bRePjzNINNZjJkP74b
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEgDq5E1p1aZrNLFFkhs+UTJZx/fIFAmA/+doACgkQhs+UTJZx
/fJJwRAAwzxV3EFBdp4rQr+iU8sQlGoMb4Z91spB/WZn2WZs89/f4qk8Z1lgBP53
a6Bb2Xce3JI/S8ZFpSsu1bZyLJKE+OYjraBbw2HbOPSXOyvqSlghwbBf5vazMHxD
4XqeYMKisUmt95C42NbwgrOclHB1NtFV4NrhZPpDBGhksqFFsn3hW485SwRwHMjK
hjOcIWdDErXS9SjhDvhDfgmoLhrzwZePUO4ruk85n7Q0GlER95DA2PH58CEhf1uU
CV3dxMfAbWHsRyaWMtfh3PQx1RF4rgQkE5crZWbaFhHYDRvynWTLJT7kwAxQyT/O
qmb82NWUMj0yG0yTu4zpga9VMvLcudPjCybKGYeLXmnaiAoejGglnIOj2QyL2qc0
WihdrLPjdfBSoYwsxXjSvYPvdODLBkAKVhUQ9ebYO/+Er8jbm+hbkizLRgprDGcw
NLs+/0N8F65+lMUFGduGxCePpkXZHC9HC5tKiyG6qNRlaFQlsRxF7ireS9uEtr3g
InP5SvmSRssl3YMfTfXUJ/oqzp8GSX28l8q1bEM6QsXkovtZCknuOxgUlq6OLM1V
welXfr+e8Paui9haHZXy8F/zMCtBo5CH2kKoudDTWLZ7/O9ov49MtTafrq+qf0fK
LSQfIUvrZ3ODSdwiegy4P8IGtknnGMNbCQhzSOEUMhKFHlxR8bU=
=hkcj
-----END PGP SIGNATURE-----

--j7ERCZYcR4iApq3bRePjzNINNZjJkP74b--

