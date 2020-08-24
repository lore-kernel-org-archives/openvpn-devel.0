References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
Date: Mon, 24 Aug 2020 17:02:54 +0200
MIME-Version: 1.0
In-Reply-To: <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="LOlvCbqKkRdq8j2kGtn0moGmumvbzKSf5"
Subject: Re: [Openvpn-devel] [PATCH] Adds client-auth-pending-extra
 management functionality.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LOlvCbqKkRdq8j2kGtn0moGmumvbzKSf5
Content-Type: multipart/mixed; boundary="WzOVpXxdtA2gsmMcRZetMbWsQXvWoQnnr"

--WzOVpXxdtA2gsmMcRZetMbWsQXvWoQnnr
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 24.08.20 um 09:59 schrieb Eric Thorpe:
> Hi Arne,
>=20
> The main scenario this addresses is 2FA authentication which needs to
> transmit very long responses such as those requiring keys. In these
> cases, the responses can be upwards of 1500 bytes. Management is
> restricted (currently) to 256 bytes and the control channel I believe to
> 1024, however the larger problem is low MTU connections or poorly
> configured connection with fragmentation problems would refuse to
> transmit packets of this size over the control channel, so we need the
> ability to break these up.
>=20
> At the moment I'm experimenting with the following layout which has
> shown success:
>=20
> client-auth-pending <CID> CR_TEXT:R,C:2
> client-auth-pending-extra <CID> CR_TEXT:CN,1:<data>
> client-auth-pending-extra <CID> CR_TEXT:CN,2:<data>
>=20
> Where flag C=3DChunked data and 2 is the number of chunks to expect. Then
> CN,<chunk number>:<data>.
>=20
> The other issue this addresses is there are scenario where more than one
> challenge reply is required. A simple example of this is resident key
> registration, where the username is pulled from the clients certificate,
> a password is queried, then attestation is queried, and then
> authentication is queried.

Depends on if these should asked sequentially, the  you just send
another CR_TEXT challenge after the first is answer or in parallel.

> client-auth-pending-extra is a bit of a catch-all addition where it
> effectively opens up the client-auth-pending spec to allow the control
> channel to be used without having to constantly drop the connection like
> the current AUTH_DENY method pre-2.5, but without spamming the user with
> AUTH_PENDING notifications, and allows a connected management script to
> handle it without adding further complexity internally to OpenVPN.

CR_TEXT is challenge response text and those clients that currently
implement it only allow a single line. I would suggest the following to
get the patch in a acceptable state:

- Document your authentication method also in management.txt and also
what IV_SSO flag indicates this authentication method.

- to avoid the 256 byte management limit and multiple commands use maybe
the same approach as client-auth that allows a longer frame, you can
still limit that to 1024.

Otherwise I think this the right direction.

Arne


--WzOVpXxdtA2gsmMcRZetMbWsQXvWoQnnr--

--LOlvCbqKkRdq8j2kGtn0moGmumvbzKSf5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9D1p4ACgkQFRhsZwKx
RFRgnA/+PiXtjq7eQWC3XuQq96z1dNePAbd3cBLXo5sjWoyZtubLLGpsJyT5BpOs
mnXGn2PLpWVIkJSY6sBq/GgqjVLB8CqyKP6JJ25g22FAD08LZwjHWmSQnufKxJn3
04V+zW4M74XxBDn0FjOu2hL5PbZJnGgKeuBLr5qtcjidCfuy8jnZ7rC4bf9BQT1K
E+qW5zx+Gd6jv0ta6bPAEu6xLrze1t50qECK43JqKiD0YUnb6pzl/E3GWjO5gWLx
Ev5La+tvI7xypU5OjwSa1nHv5OClQ/LYAakcJ+XIgLvu3YchKVN6Kkhv1mPOblhm
5bdOvrK28+BWU7CV7IlX2L8P3sfUnRNPVqg1vkd4ECHfmjjqj7HtfYzDU/YDjnOF
lTn7It9WDNv2jNjYFXQx4IQLN/aBVz0/nIEx+sN6NjEfILgeRPw11LH9aVfkxHIA
sTOILsBRUpGTe9iXQmAzt361huyt/Jw1oGj2YloJZGVayRss9xY60P0yY21aidco
TIwQGx2RbNPtodxA+d/4D3qie7onzQr6CKPfbhOhMKz8AtyfpHG/9HrPSCrr6r4R
dFcKPUal9f6AZowGejW08hBei15DlWBZqNOC4Md8q0bEw/7u1tyTGYfnrOkW3X2Y
RlXawBRZ6ZsCCYBm6zA+pikywPkyzePcWlckpr2RPL4Efo0qUq8=
=X2tP
-----END PGP SIGNATURE-----

--LOlvCbqKkRdq8j2kGtn0moGmumvbzKSf5--

