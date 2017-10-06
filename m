Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
Date: Fri, 6 Oct 2017 11:42:14 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bg18S89PtANrDWb0OxCmviHsddDOkWoAp"
Subject: Re: [Openvpn-devel] better handling of revoked certs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bg18S89PtANrDWb0OxCmviHsddDOkWoAp
Content-Type: multipart/mixed; boundary="U5XuI1DIcnDcoT1t3k9ovaFdhktO2hQrD";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
Subject: Re: [Openvpn-devel] better handling of revoked certs
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
In-Reply-To: <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>

--U5XuI1DIcnDcoT1t3k9ovaFdhktO2hQrD
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 06/10/17 11:37, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-10-06 14:11 GMT+05:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>=20
>     On 06/10/17 11:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     >
>     >
>     > 2017-10-06 13:43 GMT+05:00 David Sommerseth
>     > <openvpn@...2080...
>     <mailto:openvpn@...2080...>
>     > <mailto:openvpn@...2080...
>     <mailto:openvpn@...2080...>>>:
>     >
>     >=C2=A0 =C2=A0 =C2=A0On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=
=A8=D0=B8=D0=BF=D0=B8=D1=86=D0=B8=D0=BD wrote:
>     >=C2=A0 =C2=A0 =C2=A0> Hello,
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> I used to run openvpn in login/password mode f=
or years.
>     >=C2=A0 =C2=A0 =C2=A0> now, I'm getting working certificate setup.
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> what I found strange about revoked certificate=
s ... from
>     client point of
>     >=C2=A0 =C2=A0 =C2=A0> view it looks like any other "tls key negotiat=
ion timeout"
>     >=C2=A0 =C2=A0 =C2=A0>
>     >=C2=A0 =C2=A0 =C2=A0> is there a way to signal user "hey, you key is=
 revoked" ?
>     >
>     >=C2=A0 =C2=A0 =C2=A0Nope, not in the current implementation and desi=
gn.=C2=A0 To be able to
>     >=C2=A0 =C2=A0 =C2=A0signal that, you need to have some established a=
 connection.=C2=A0
>     And that
>     >=C2=A0 =C2=A0 =C2=A0cannot be done unless the client provides a valid
>     certificate.=C2=A0 If the
>     >=C2=A0 =C2=A0 =C2=A0certificate is invalid (issued by wrong CA, expi=
red, revoked), the
>     >=C2=A0 =C2=A0 =C2=A0server just drops the ball.
>     >
>     >=C2=A0 =C2=A0 =C2=A0Perhaps we could look into adding a new OPCODE w=
hich could signal
>     >=C2=A0 =C2=A0 =C2=A0connection errors.=C2=A0 But that needs to be ve=
ry carefully
>     implemented so
>     >=C2=A0 =C2=A0 =C2=A0we don't open up for various DoS attacks or more=
 effective
>     bruteforce
>     >=C2=A0 =C2=A0 =C2=A0attacks.=C2=A0 Such a message would also need to=
 be verifiable too,
>     otherwise
>     >=C2=A0 =C2=A0 =C2=A0it would be too easy for a filtering firewall or=
 gateway to
>     just respond
>     >=C2=A0 =C2=A0 =C2=A0back with such a rejection message instead of pa=
ssing the packet
>     >=C2=A0 =C2=A0 =C2=A0further; effectively shutting down clients with =
the wrong
>     presumptions.
>     >=C2=A0 =C2=A0 =C2=A0Plus it needs to be implemented in the OpenVPN 3=
 Core library
>     as well
>     >=C2=A0 =C2=A0 =C2=A0(which OpenVPN Connect clients uses).=C2=A0 So t=
his isn't even a
>     quick-fix.
>     >
>     >=C2=A0 =C2=A0 =C2=A0But I would also be very cautious about providin=
g reasons back to
>     >=C2=A0 =C2=A0 =C2=A0clients though.=C2=A0 For all these various inva=
lid certificate
>     scenarios we
>     >=C2=A0 =C2=A0 =C2=A0definitely should not give a too fine grained ex=
planation.=C2=A0
>     IMO, only a
>     >=C2=A0 =C2=A0 =C2=A0"Invalid certificate" message should be consider=
ed.
>     >
>     >
>     > taking all the above into account, I would compare things in
>     "https" world.
>     > both "server cert error" and "client cert error" are handled in
>     somewhat
>     > friendly way (without considering such additional information as a
>     > security breach)
>=20
>     But the OpenVPN wire protocol is anything similar to standard SSL/TLS
>     protocols.=C2=A0 The SSL/TLS protocol is wrapped into an OpenVPN cont=
ainer,
>     where the SSL/TLS specifics packets happens in a limited set of of the
>     OpenVPN wire protocol, most commonly referred to as the control chann=
el.
>=20
>     In addition, what happens when you try to use a revoked *client*
>     certificate when connecting to an HTTPS server demanding client
>     certificates to be present?
>=20
>=20
> 403
>=20
> (with customizable error message)
Really?  That shouldn't be possible, as you don't have an established
TLS connection to provide the HTTP 403 response.  Because the server
should reject the connection as the *client* certificate is invalid.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--U5XuI1DIcnDcoT1t3k9ovaFdhktO2hQrD--

--bg18S89PtANrDWb0OxCmviHsddDOkWoAp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZ10/2AAoJEIbPlEyWcf3yrx0P/3MI9hVZKiT7GH/gvCaZr5Kj
ckDU6udSLhLYdLNkp3tSZF5/Maa7mjyrvAQaLaC4TQYJ7TGC1RePbqD4cwau2wkF
8R3v9xoZGf2l4g3Y8OzMSnZhuInDrU7ksRRpYQmi7aXRLMTRridA27KoP9N3+Ept
LofCpxOcUNZ7QbsZoSQVzOAv9HaR+TfISKXRM+HudfPaZdfeLrnGy+C05rEhVAan
yxqTBtzqtxFc0oNSMlHh5mzjakYs6RGzrawbVfQrtYuNYBaU98L6sP6MRrPwONyG
oTSyRnE4hIreLYMLhEISqRpPM6oY2d3MQKd604o2epf/v4XV2qj7jVCNqBzL5dPk
guPEktDVVy8i3/CqoWWCwe9diy7YmAyaNqaiF7yslXVLnnJGTt92mMRBFzUFPFtW
8th/XLGNmjcQ4fxUOTr+Bn+esBLibgwUyodiXeSpIFRPjznmfheY+zP5WezRut+7
0vz8XoOXeF5nnzEtcdstiCKWawUjooP+p4nZNdAtbygssvnE77STUQ0gw0GwJO2U
2zSpCbwsAKhgLxT/bfCo+jTL1OO8y/yLuFWyQ/ddIHOTUJ4f2ngCAiV7cShFbXeN
VySlLcHR4F6J/y2aX+/0AJSCbHuDRbtIvyJewseCCjeYidBW3gW4Qhwb/uX+i8Vz
7Q34wHSLJZNS8P4GSkOx
=NIL5
-----END PGP SIGNATURE-----

--bg18S89PtANrDWb0OxCmviHsddDOkWoAp--

