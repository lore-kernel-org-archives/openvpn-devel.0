Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
Date: Fri, 6 Oct 2017 11:11:13 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="9lUEOdbiuw0jnmBsCO9PGu6F11t24viMJ"
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
--9lUEOdbiuw0jnmBsCO9PGu6F11t24viMJ
Content-Type: multipart/mixed; boundary="SfIL9x0R6aFb2RK9NxB3AhS8MABwinRoc";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
Subject: Re: [Openvpn-devel] better handling of revoked certs
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
In-Reply-To: <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>

--SfIL9x0R6aFb2RK9NxB3AhS8MABwinRoc
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 06/10/17 11:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
>=20
>=20
> 2017-10-06 13:43 GMT+05:00 David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>>:
>=20
>     On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:
>     > Hello,
>     >
>     > I used to run openvpn in login/password mode for years.
>     > now, I'm getting working certificate setup.
>     >
>     >
>     > what I found strange about revoked certificates ... from client poi=
nt of
>     > view it looks like any other "tls key negotiation timeout"
>     >
>     > is there a way to signal user "hey, you key is revoked" ?
>=20
>     Nope, not in the current implementation and design.=C2=A0 To be able =
to
>     signal that, you need to have some established a connection.=C2=A0 An=
d that
>     cannot be done unless the client provides a valid certificate.=C2=A0 =
If the
>     certificate is invalid (issued by wrong CA, expired, revoked), the
>     server just drops the ball.
>=20
>     Perhaps we could look into adding a new OPCODE which could signal
>     connection errors.=C2=A0 But that needs to be very carefully implemen=
ted so
>     we don't open up for various DoS attacks or more effective bruteforce
>     attacks.=C2=A0 Such a message would also need to be verifiable too, o=
therwise
>     it would be too easy for a filtering firewall or gateway to just resp=
ond
>     back with such a rejection message instead of passing the packet
>     further; effectively shutting down clients with the wrong presumption=
s.
>     Plus it needs to be implemented in the OpenVPN 3 Core library as well
>     (which OpenVPN Connect clients uses).=C2=A0 So this isn't even a quic=
k-fix.
>=20
>     But I would also be very cautious about providing reasons back to
>     clients though.=C2=A0 For all these various invalid certificate scena=
rios we
>     definitely should not give a too fine grained explanation.=C2=A0 IMO,=
 only a
>     "Invalid certificate" message should be considered.
>=20
>=20
> taking all the above into account, I would compare things in "https" worl=
d.
> both "server cert error" and "client cert error" are handled in somewhat
> friendly way (without considering such additional information as a
> security breach)

But the OpenVPN wire protocol is anything similar to standard SSL/TLS
protocols.  The SSL/TLS protocol is wrapped into an OpenVPN container,
where the SSL/TLS specifics packets happens in a limited set of of the
OpenVPN wire protocol, most commonly referred to as the control channel.

In addition, what happens when you try to use a revoked *client*
certificate when connecting to an HTTPS server demanding client
certificates to be present?


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--SfIL9x0R6aFb2RK9NxB3AhS8MABwinRoc--

--9lUEOdbiuw0jnmBsCO9PGu6F11t24viMJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZ10ixAAoJEIbPlEyWcf3yVRwP/iTJg7jmXSyxJ+lopenxQ69S
sryzzoKc4ny2Eaaopz2SBOehzjDK1LX111iQihCBhcQTgiT7GWJ+Rv3FnY4x2UKu
MyhFrszIzWUVljK1JW0Mux5YA70LRR8T4p1bzL8F2Lgw1e4vktGGs1v/RHL0HS4C
aeFe4L52cahv2y3Oo/WkhV5iCsW5SrsbB9p2uszAAMAFOpzk7zPFymDsZ0c9kUMS
uQCP77gfIwWh7GvKSi+LJCwsGVGJg2k/AxD4jOrDpQZml+Gp9XJNe1xxHg4WT+uR
kOaC/gBhNKFPIkzRJ3DqwyyU11LaQJtmeYAXwSO9KGZpsxHZsktnJGB2yegX6VO/
V90wjZwV6cG+p8oyxcQYWRJU6631QhVNs+Ul+qRkOlD4eecrKmNpOVExqFW0Y47q
h2Ev4S1bPWxfWyWaA0Zdf+d+yEUU3w28dUSBc6VqgraF+/RkbWWzWCa7S5o6KuON
opSqT5b2WfWnc8zcXhMz9L5I1ybW1neIuHl+AqNNWJPbj68udrtC+jiuFo75I6nI
Na/23elfeuQd2VPtPXrFeXpMsatCEWaJtUa69t3TrgSQEVF3ELYlVPtTijBbTXTf
3/Lx99mx/SOr8OC9v+nhl1J7Ji9Y6l9rshgIHN3Qic0t2OZtvJf3Ia5U1mEHJPXD
oeyGpsp9Cbltti4cHBag
=ZXdi
-----END PGP SIGNATURE-----

--9lUEOdbiuw0jnmBsCO9PGu6F11t24viMJ--

