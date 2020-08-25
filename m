References: <20200821062443.69245-1-eric@...1918...>
 <bd154015-3f5f-6035-c4ff-fae5abc7857c@...1227...>
 <3df6fedd-f30a-4e08-0e82-b31a7728f21d@...1918...>
 <446bb2a7-7597-1c89-b4eb-543abf4e6e3f@...1227...>
 <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f2ddadee-f969-2bcb-5b19-ad2273a17b18@...1227...>
Date: Tue, 25 Aug 2020 09:25:10 +0200
MIME-Version: 1.0
In-Reply-To: <2f192d4f-fa69-20d3-f9a2-90329d308b53@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zMcwdwTCcAWljhXee3TzWsGTTnjzG1NyK"
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
--zMcwdwTCcAWljhXee3TzWsGTTnjzG1NyK
Content-Type: multipart/mixed; boundary="PPEFLVXRHUjvpceSv3FQFzkEqd8nvomJQ"

--PPEFLVXRHUjvpceSv3FQFzkEqd8nvomJQ
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.08.20 um 01:58 schrieb Eric Thorpe:
> Hi Arne,
>=20
>> - to avoid the 256 byte management limit and multiple commands use maybe
>> the same approach as client-auth that allows a longer frame, you can
>> still limit that to 1024.
> To be clear here, it isn't so much the limitation of the management or
> control channel, it's situations where a tun-mtu may be set to say 750
> for example, meaning the data size can only realistically be about 730
> minus INFO_PRE, flags, etc, or OpenVPN or the network will drop the
> control channel message. I would not recommend making any changes to
> management or the control channel here, simply just have the ability to
> send the data in smaller parts.
>=20
>> CR_TEXT is challenge response text and those clients that currently
>> implement it only allow a single line. I would suggest the following to
>> get the patch in a acceptable state:
>>
>> - Document your authentication method also in management.txt and also
>> what IV_SSO flag indicates this authentication method.
> Are you suggesting that I do not use CR_TEXT, and instead introduce a
> new Challenge Response type (CR_DATA for example)?

IV_SSO=3Dcrtext is a basically the AUTH_PENDING variant of presenting the
user the text of CR_TEXT and responding with the answer.

What you doing seems to be different. And if we add something that is
different we should it its own IV_SSO flag to announce itself. And if
you need "just" a multiline or longer text than current crtext can give
to the user, we still need a flag for this new method, so we can signal
if the client supports this.

I am just asking that if we add new methods to AUTH_PENDING to properly
document them.

Arne


--PPEFLVXRHUjvpceSv3FQFzkEqd8nvomJQ--

--zMcwdwTCcAWljhXee3TzWsGTTnjzG1NyK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9EvNYACgkQFRhsZwKx
RFTe3w//fLxRSwta4ffFMjUClNm516VLa8M6QY+D+TJynfXs2XVCPsrcEfpvKkQ6
NNVlBJWdzqe2Zhp5Ri6flxr6gURv3LUR1aKUTdxYrkCQuCFvXn5lZhNYDCWKDbge
cCeDCFI03MpZ6xgxcesRdQ69Fy6dZfQT3BLeuEvC4OPaQ+vdxtVkOJnRZqPmWO7T
Dsy+TzcVVenSVIF4k3hVp4pj40hOkc3B3HVsRAmVskvKCoi97tDkwyg5krp9e4+w
xl0d5NeWi/2cerNOlN+dVP87V+zuFW4MVeKP5/bKQWaCjEOCPRHS4Ur+7NqHD8zh
G9FlzpS98pU590VBDxch+Q+srj2rUq3iEmoWA4s3waTKL7FP1umZDYMyQ4sz18gm
nM2Kj6/VJFhvxJp/K3I+vmgYcgVJliQ7kyPW55eimLE9kAbRJLmI/XXm8kFhO5h9
qZwtQmfOOYGhTGEK9FDX7KiXzlsev23XUJds/lyTiDxNMSoYEIwKINCvUkD/89fv
PJn1nFZzvMCQ8zseajqOYor6+ItkNKq0RMzP/YOJuoOuifLo88q901kFo/vJdLHx
PLwxBWh1FkPEIlIiDZ3XTY3J2CtuXeCE96CPGBWxRN62BnHjA4JL2djOjP8qEiVw
rIFu7DPe3JCbGq4ln2qYQ2O7+2XFxADxECxnBTzW3ycbIhraabI=
=pVry
-----END PGP SIGNATURE-----

--zMcwdwTCcAWljhXee3TzWsGTTnjzG1NyK--

