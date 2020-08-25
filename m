References: <20200813072923.24385-1-eric@...1918...>
 <1fb10dd1-8ddf-c467-21a5-a93e21e6a8ac@...1227...>
 <0a634481-cf3b-de2f-5e34-8f5c5ef16fdc@...1918...>
 <CAKuzo_h_xWf-Jbkow=H3sL_CQw5CC23pw3DxH0Nsydj2f57usg@...278...>
 <dc800745-efe3-0f10-d08f-046fc041c96a@...1918...>
 <CAKuzo_heHMcpRd31Lc=ZHDjPAb3GsQoBQB4iQvXCd7EPTnGEug@...278...>
 <294d779c-44a1-7f4c-c506-5f21dc76e8ac@...1918...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9e1e0324-45a1-d6ab-068a-eff8bb75aef1@...1227...>
Date: Tue, 25 Aug 2020 08:24:33 +0200
MIME-Version: 1.0
In-Reply-To: <294d779c-44a1-7f4c-c506-5f21dc76e8ac@...1918...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nf8thz1BxNTSCHl4oeQ40ScaKqHDXgkCX"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Send auth-fail messages to clients
 on renegotiation failures via auth-token or user-pass expiry
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Eric Thorpe <eric@...1918...>, Selva Nair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nf8thz1BxNTSCHl4oeQ40ScaKqHDXgkCX
Content-Type: multipart/mixed; boundary="rZ9qrNN8vQHPwSZ50WLtypKbOKdDY1hNo"

--rZ9qrNN8vQHPwSZ50WLtypKbOKdDY1hNo
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 25.08.20 um 01:51 schrieb Eric Thorpe:
> Hi Selva,
>=20
>> In multi_connection_estableished, we have
>>
>> #ifdef MANAGEMENT_DEF_AUTH
>> =C2=A0 =C2=A0 if (management)
>> =C2=A0 =C2=A0 {
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 management_connection_established(management,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 &mi->context.c2.mda_context,
>> mi->context.c2.es <http://context.c2.es>);
>> =C2=A0 =C2=A0 }
>> #endif
>> I do not see why this requires --management-client-auth or any
>> management related options to be in use.=20
>=20
> management is set to NULL unless a management address is defined
> (--management), so the above is not called for a plugin or script
>=20
> bool
> open_management(struct context *c)
> {
> =C2=A0=C2=A0=C2=A0 /* initialize management layer */
> =C2=A0=C2=A0=C2=A0 if (management)
> =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 if (c->options.management_addr=
) <----
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ....
> =C2=A0=C2=A0=C2=A0 =C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 else
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 close_=
management(); <----
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 }
>=20
> I'm not trying to be resistant in finding another way here to avoid this
> extra state you guys don't want, this is a real bug in re-auth/reneg
> that we have seen occur multiple times in various setups that we want to
> see fixed, and it effects management,=20

Management goes another code path and management_client_auth directly
calls send_auth_failed.

> script and plugin authentication,
> however I have had a good walk through the code and I can't see another w=
ay.
>
> The other alternative here is to refactor up the call chain so the
> context_2 is passed to each of these functions instead of just multi &
> session, however this is about a 500 line refactor that I really don't
> want to do.

Well the tls session should basically only care about its own session
and the outer logic that ties the tls session together should handle
this. The current code is not as clean as it could be/should be. But I
also haven't digged deep enough to actually understand if your is
actually fixing the problem correctly. We have a working scenario (I
assume) with management and client-auth

- Do we send the AUTH_FAILED over the new or the old tls session?
- Do we establish the data channel (key_method_2_write) before writing
the key?

(and the same for the new approach)

You haven't described the bug/symptons you are seeing yet but I assume
you get desynced keys etc?

I understand that is frustrating from your end since you have a quite
simple fix and fixes your problem but I am here maintaining OpenVPN and
it took me 1-2 weeks to get rid of 2-3 similar variables to the one you
want to introduce.

Arne


--rZ9qrNN8vQHPwSZ50WLtypKbOKdDY1hNo--

--nf8thz1BxNTSCHl4oeQ40ScaKqHDXgkCX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl9ErqIACgkQFRhsZwKx
RFSzZw//QCphc5HC9fVxgHmYFz4Eahy8Upi5mXHR8QZiLwCU6GmSsYpLqfLAARm1
JckG+iMDH3jK98OBkXFY6VB1s+Y9cQ09F56NAoKioGFv36hlODHyLjmUKFvj3g1v
SOQn2b4Qv2/YesGI0r0ECjdPBV2kcP2c8AVFLx+7b7LEEGBW144DdWkxM+J0b8j1
xem2l07y+1TCM5PUtgF/InNrq/ZhEJS7ON/RbFWMCuv7cymPjn6N2KZfLaLXmsRq
oBvVxY1fnqhtWQQmBqLamLwEKzVibF4EYbezGaGHDA/DRFOwHeEZDaW03vKn38Y6
GJZ2+OR5Jny07Uu/d/OKSP7xRjCCC9jfVnHYennkaEpoB864FEyVSCPsp1tsv/kk
2gQLZAHIV1YYV9+N06cqGorWFEhxkaz+wEvQGJdT/esZq2hOzkDhx59hi//OVUZ6
Zb0AKiUUZHs9+DpvIwLal0A4jSRVi8LLiRH9y9UP7zZrHiea1Ss/dvTbGrle2l1a
NAfPHppabpaVzYvFI8Ku9QxFgfPachPUMwmzCcLKYBJAeB2ITuokQcmZ8XT+kx1T
c6LIaos7s8t0to8dgkWtKQUyqRK8kmO3c5s1kBDDMjp/y0nKRo/Kmexnhto10x5q
u/XWlPNP2UsX37PNWWZ6ublP0wSx7WqPUnEXZT1xyDtnnNvyKB4=
=c+t1
-----END PGP SIGNATURE-----

--nf8thz1BxNTSCHl4oeQ40ScaKqHDXgkCX--

