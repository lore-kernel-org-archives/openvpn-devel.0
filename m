References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <dc74d6b7-1796-362b-bdc9-0be421df0459@...2181...>
Date: Sat, 7 Jul 2018 14:37:04 +0800
MIME-Version: 1.0
In-Reply-To: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="S5mcabNumMLusBuPuGJo75fBBrNtFqsoh"
Subject: Re: [Openvpn-devel] OpenVPN Connect App on IOS // Support for
 IPv6-only networks with DNS64/NAT64
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Kristian McColm <kristianmccolm@...160...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--S5mcabNumMLusBuPuGJo75fBBrNtFqsoh
Content-Type: multipart/mixed; boundary="FXRB4aRBs23UmI9cM7Wol86Xo18dOasXa";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Kristian McColm <kristianmccolm@...160...>,
 "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>
Message-ID: <dc74d6b7-1796-362b-bdc9-0be421df0459@...2181...>
Subject: Re: [Openvpn-devel] OpenVPN Connect App on IOS // Support for
 IPv6-only networks with DNS64/NAT64
References: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>
In-Reply-To: <BN6PR04MB088248FC428ABCF529D3CFD5DD460@...2438...>

--FXRB4aRBs23UmI9cM7Wol86Xo18dOasXa
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hello,

On 07/07/18 09:27, Kristian McColm wrote:
> Hello List,
>=20
> As you may be aware, the Internet is running/has run out of IPv4 address =
space. To that end, I am a part of a team at a national mobile network oper=
ator who are working on deploying IPv6-only mode to our Android and iPhone =
handsets, and deprecating the use of IPv4 on our netowrk. Since we have beg=
un migrations to IPv6-only mode, we have received a few complaints from use=
rs of the OpenVPN Connect app on IOS stating that their VPN tunnels are est=
ablishing but they are unable to pass and data inside the tunnel.
>=20
> We have been able to reproduce the issue=C2=A0using an OpenVPN server 2.4=
.6 on Fedora Linux 26 and an iPhone running IOS 11.3.1 and version 1.2.0 bu=
ild 0 (iOS 64-bit). The VPN server is IPv4 only and using UDP transport. Th=
e IOS device is on an IPv6-only network that provides DNS64/NAT64 for 6to4 =
translation. The Android device is running Android 6.0.1 and OpenVPN Connec=
t version 3.0.5 (1816). Using the same client profile (.ovpn file) on both =
the Android and and IOS clients, and the same cell network settings and VPN=
 server, we observe that the VPN tunnel is established OK on both devices, =
but only the Android is able to pass data traffic inside the VPN tunnel.
>=20
> Is anyone aware of whether the developers of this application have any ex=
perience testing the IOS version of the app on IOS devices on IPv6-only net=
works, and moreover are the developers aware of and ensuring the app is com=
pliant with Apple standards for IPv6-only networks as documented here: http=
s://developer.apple.com/support/ipv6?
>=20
> As per our understanding, Apple are actively pursuing apps which are not =
compliant with these standards, since IOS does not provide 464XLAT at the c=
urrent time and compliance with Apple's standard is the only way to ensure =
compatibility with IPv6-only networks such as ours.
>=20
> If anyone who has any feedback or would like me to test anything or provi=
de any further assistance I would be glad to assist.
>

I work for OpenVPN, Inc. and I have been responsible for pushing
"OpenVPN Connect for iOS" forward from 1.1.1 to 1.2.9.

First of all, thanks a lot for your feedback - we really appreciate when
people try to improve software used by the community.

I think I can safely say that until now the development and testing was
not focused on IPv6 only networks. Therefore it is very possible that
some cases do not work as expected.

However, IPv6-only setups (both inside and outside the tunnel) are on
our roadmap and we have already started working on it for what concerns
OpenVPN2.

OpenVPN3-core (the library at the core of OpenVPN Connect) should
happily support IPv6-only transport networks, therefore I don't have an
immediate answer to why this is not working for you.

Would you mind opening a ticket on https://community.openvpn.net (you
need to create an account) so that we can better track this issue and
ask you to provide more details?


Thanks!


Regards,

--=20
Antonio Quartulli


--FXRB4aRBs23UmI9cM7Wol86Xo18dOasXa--

--S5mcabNumMLusBuPuGJo75fBBrNtFqsoh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAltAX5AACgkQB6U8WA7y
zXSeVg//TH7SwQ2EpwBqDu5YFTDbcWqoowPsXQYUzTMRX56mMiLXulVmO+goRVAb
ZikdW9+LorfVSYY89veD4vTvoYkqM38cH3MkOSPkqGU/yC/ZB90kbrcB8Yu5uhQh
e3YQqtUr4gz0S1eEbsNT4//E7RT5ex0d/13ExgE7FS4LnOWXuIO+rPZVISTBJ2CH
oO/Jn/4u3GysuG7jGi9HB/i9mUItrcjf7B1YnmxWTq6Wp7BU3d+e6Ep5sws4R7pv
14/h8N5kTFbFumKr2s2ChLD96oNxNQYJYdzuqp7XHulgilzn5WXi7IIeOpVl+Ex6
s1WlOtEnOqayL66gBJX925FKuTvP2f3Oo15zFcktsJ5f0j8AKVX2Y7FYHQm5EVev
LQKJpiZRUIXZjScLo6krTnLMkd6LhLJdVHBtDzX7mY2dEwJV9WFkBW1swmaMKKzZ
5oQoFV5zlrbdfWwSFU1LnQumC9Gsxu9wwXou2uDY/iXBJvlMz94Cll5eE5rc7frO
w+vhIVaV5Xtny0l0kK4R+9AxSjt3CUGmlf2BjjueeBmElgI2OJYKgCd74YmqFlvD
mCIxHL6RfhdNyD5hVxXIl3XD7v719KT2txfgTICcayncBnDNCduWIXBqKSLX8kLK
OxY1lMwJl2SEO2XencIf7XYaZhjLkmlWCLaiGS3tVw7ejp24/Nc=
=Mh7u
-----END PGP SIGNATURE-----

--S5mcabNumMLusBuPuGJo75fBBrNtFqsoh--

