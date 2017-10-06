Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
Date: Fri, 6 Oct 2017 13:23:31 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="bgqcoAPRAWiB1g8qQmkSJEF7HRnBAiO7w"
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
--bgqcoAPRAWiB1g8qQmkSJEF7HRnBAiO7w
Content-Type: multipart/mixed; boundary="3uSQ4VavXeo6mj7soff70fPx1bSqIjQgW";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <7bc9701e-b5dd-f9cb-7edf-76e38e36f6a2@...2080...>
Subject: Re: [Openvpn-devel] better handling of revoked certs
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
 <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
 <CAFHpkQEcyz9q=kYx6CM_kT9Jm3YFG9EZRe08NZnLm-G+knDktA@...278...>
 <e6c5f73e-2920-3e30-2539-702632d30e43@...2080...>
 <CAFHpkQHPpkb2GfsV4y7B3GntpoQ0JzZz2X+rWffYqexbiJzgYg@...278...>
 <9561c64d-3c54-b65b-9fce-f99b4ef9c3b3@...2080...>
 <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>
In-Reply-To: <CAFHpkQHZXbMDBPXV=dGWYs0M2B4C9AU-FY4KE2pCZqsxe5iJbw@...278...>

--3uSQ4VavXeo6mj7soff70fPx1bSqIjQgW
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 06/10/17 11:52, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
[...snip...]
>     >
>     >=C2=A0 =C2=A0 =C2=A0In addition, what happens when you try to use a =
revoked *client*
>     >=C2=A0 =C2=A0 =C2=A0certificate when connecting to an HTTPS server d=
emanding client
>     >=C2=A0 =C2=A0 =C2=A0certificates to be present?
>     >
>     >
>     > 403
>     >
>     > (with customizable error message)
>     Really?=C2=A0 That shouldn't be possible, as you don't have an establ=
ished
>     TLS connection to provide the HTTP 403 response.=C2=A0 Because the se=
rver
>     should reject the connection as the *client* certificate is invalid.
>=20
>=20
>=20
> I did test on IIS with "certificate required", when you connect without
> cert, you can see 403.
> ok, I'll test with revoked cert as well

Okay, I've done some testing with my own Nginx server.  HTTPS is
actually different from the plain SSL/TLS protocol.

In HTTPS, the client certificate transfer is handled differently, where
it exists an unauthenticated TLS connection when invalid certificates
are sent to the server.  This allows the server to respond with HTTP 40*
messages over HTTPS.

When trying the same using openssl s_client and s_server, the server
side instantly dumps a "certificate verify failed" message and it
disconnects.

This latter behaviour is the approach implemented in OpenVPN.  And I
doubt this can easily be changed, to have an unauthenticated response
channel, without breaking backwards compatibility with older clients.
We need to facilitate a few other approaches which ensures the clients
won't get confused.

Since both these HTTPS and the s_client/s_server tests happens over TCP
(as SSL/TLS is strictly designed for TCP only; which is why OpenVPN
encapsulates the SSL/TLS packets to allow it to use UDP), the client
will also disconnect when the TCP socket gets closed.  This is not
possible with UDP sockets, and is why why have --explicit-exit-notify
for UDP connections, to simulate the TCP FIN behaviour.

I hope this makes sense.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--3uSQ4VavXeo6mj7soff70fPx1bSqIjQgW--

--bgqcoAPRAWiB1g8qQmkSJEF7HRnBAiO7w
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZ12ezAAoJEIbPlEyWcf3yJuAQAI0jJv6yY6HAmZs3nXCXc04o
ksxLCnyl3tLGMBQkuw/7tzMXWPFazXFIaw1tTXJrisl6EhdKDP/wyOWBOswroPu5
M3yfBkUYXiwSkQh52JfSN1Xes6rJneEae8QDvE0XzQcvYabmhmidVQEKZ+r36mr6
OOIV8HBQt7BflzwlkHgko0VTKpv4zs8BBbYZXy3xuDCiEtsUHUe3BpdrKM3zFCIm
xA9UjkIJ315bMYGTf0QJUJCXXZ/DM8cXp4BlHYCQmGsj0hvGtidTg+/woK2aIWa8
u/Xj8pwvVjFldW33rC7wYAf769cPD2NWeJa6VhIbFL7dODt1tvTmox3Q27m2G17Y
nKWK+a/rM2GrEzbz4vArcY3lEHxF08RB4Ko03Glts7mwGEHdVUkr6zt8ESS/Rois
Z7SfcXvA1I/pFL40BkjwScZ44W0S9I8sSUUY5DUQ0Lsx4at2CgIUUrxihX0mZJUh
RZEhNn6LMqDyQuIZh2yKb0KcJNLfsmSOGaDa55lrSjy9ginepwBLU16HJtsB+ykR
VPOmozUqv6+dpM8QxbjxLISgS2smIg78BqD857PWua9mtES2DZ2SEVyln+LHyBIe
xOSSxyxQEPqrWvkuyh6gIUbLtjRso8OEGf+BT5n29JpvzA8qxY4FZiSG1IVD+0J5
Bfh3xjd2MDwBjkJ5Egt8
=AdPx
-----END PGP SIGNATURE-----

--bgqcoAPRAWiB1g8qQmkSJEF7HRnBAiO7w--

