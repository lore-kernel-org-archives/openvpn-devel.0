Reply-To: openvpn-devel@lists.sourceforge.net
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
Date: Fri, 6 Oct 2017 10:43:29 +0200
MIME-Version: 1.0
In-Reply-To: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="6bBMvdM3crd7EOWJMnK7qOhgORNGxrJb0"
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
--6bBMvdM3crd7EOWJMnK7qOhgORNGxrJb0
Content-Type: multipart/mixed; boundary="w7awTdo5Iqb6JuCUGHv0fMPPtl68hg1rB";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <2764e29d-928d-a643-6fa7-0554ff7b7dfa@...2080...>
Subject: Re: [Openvpn-devel] better handling of revoked certs
References: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>
In-Reply-To: <CAFHpkQHuJmbYk2G58-VdexeUbrrYT1Qz+HdrZ9HZps3QuZD6ZA@...278...>

--w7awTdo5Iqb6JuCUGHv0fMPPtl68hg1rB
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 06/10/17 08:58, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:
> Hello,
>=20
> I used to run openvpn in login/password mode for years.
> now, I'm getting working certificate setup.
>=20
>=20
> what I found strange about revoked certificates ... from client point of
> view it looks like any other "tls key negotiation timeout"
>=20
> is there a way to signal user "hey, you key is revoked" ?

Nope, not in the current implementation and design.  To be able to
signal that, you need to have some established a connection.  And that
cannot be done unless the client provides a valid certificate.  If the
certificate is invalid (issued by wrong CA, expired, revoked), the
server just drops the ball.

Perhaps we could look into adding a new OPCODE which could signal
connection errors.  But that needs to be very carefully implemented so
we don't open up for various DoS attacks or more effective bruteforce
attacks.  Such a message would also need to be verifiable too, otherwise
it would be too easy for a filtering firewall or gateway to just respond
back with such a rejection message instead of passing the packet
further; effectively shutting down clients with the wrong presumptions.
Plus it needs to be implemented in the OpenVPN 3 Core library as well
(which OpenVPN Connect clients uses).  So this isn't even a quick-fix.

But I would also be very cautious about providing reasons back to
clients though.  For all these various invalid certificate scenarios we
definitely should not give a too fine grained explanation.  IMO, only a
"Invalid certificate" message should be considered.


--=20
kind regards,

David Sommerseth
OpenVPN, Inc



--w7awTdo5Iqb6JuCUGHv0fMPPtl68hg1rB--

--6bBMvdM3crd7EOWJMnK7qOhgORNGxrJb0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZ10I9AAoJEIbPlEyWcf3yYqEP/RMvmc9pCSca0Sw+3FVziFUu
V6yhgn0SMehyvW46NX5FvguSuC2/7qxY46F6XpmVa/9cwf5e3JX7PS26HvjTFxcg
D6tjZQf0gvlFXXtSsyexasgrAJ7921GOanixm9zB0NCNJwVvnEm9bsVppTC/WEHB
0JJ0Zf62LN4ywi/e1hVzruNuN04Fr4tUAY3M6fb7DAlHRK6ZdMDI4+Tw7dagvC3b
YeBI2Rh9LRKqDQeJkL+iAdiQ2H+48YbtVl/fHC2jWFW7um543b0D/ByQ6Ld6ikdZ
nD275tEkfdOdV7kJ6noSBD2pVxO6KG7u1dHFJCuWGjrzDSi9g3FRmIF+HPd0wNw6
MRKwHUufXEHRjxzCmvTEGTI7Nyos95ulYY5zU4rmdX2P5I4XNlEzpxea9EzdzI44
Aqh7n6QEPD5Ky4hOFF90UiqtvtlUwmk4Qb7kx2cnNTPlhj779on6G2Tn346xp7Ns
lyxr/PFczYj2HbsjP94r0Fx4oR+W4bo7wzHih86pSFhxKSsb71Kzmvxip63J8RBL
eFQuaUDnssrBClR9vyKe1C+h65nOgaB1u4AKdmMtk+IgE6whhLnJfoaKweJf6pHE
+zE3EDEyzV4lE8xMJBOj5wsEzQKDDr9bzBeWX1GApxzR0yRanso8Ibl7Ssv0AvT4
fPxdlAsVb075WWymfvvG
=aFVS
-----END PGP SIGNATURE-----

--6bBMvdM3crd7EOWJMnK7qOhgORNGxrJb0--

