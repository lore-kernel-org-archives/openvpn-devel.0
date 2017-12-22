Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
Message-ID: <b261efe6-c16e-5780-86a9-ec361b353c0d@...2080...>
Date: Fri, 22 Dec 2017 11:48:28 +0100
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="0jckvAKSB3y7Mcdgm1CYAErQ7TWJm0KT7"
Subject: [Openvpn-devel] OpenVPN 3 Linux client
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0jckvAKSB3y7Mcdgm1CYAErQ7TWJm0KT7
Content-Type: multipart/mixed; boundary="kvDWNCs15gnrcDp6rZSfEX4D5MmK4ortL";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <b261efe6-c16e-5780-86a9-ec361b353c0d@...2080...>
Subject: OpenVPN 3 Linux client

--kvDWNCs15gnrcDp6rZSfEX4D5MmK4ortL
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


Hi,

We are starting Christmas a few days early with a bigger present.

We are now releasing a brand new OpenVPN 3 based client for Linux.  This mi=
ght
build on other platforms which can provide the needed dependencies, but
currently Linux is the main target.

This is a very different client from what you are used to with OpenVPN 2.x.
It aims to target several of the issues found in modern Linux distributions
and have in particular a different approach to privilege separation between
the various steps a VPN tunnel setup depends on.

This new client consists of three backend services, a logger and front-ends.
The communication between them are entirely based on D-Bus, so this is a ha=
rd
dependency now.  We might look into making it possible to swap out D-Bus wi=
th
other types of IPC alternatives (zeroMQ might interesting) - but D-Bus has =
the
advantage of providing a good way to automatically start services as needed=
 as
well as authorization controls.

More details can be found in the README file in the git repos, and I have e=
ven
more documentation describing the implementation in far more details in the
pipe.  I plan to release that documentation once I've had a chance to review
it once again.

This project is quite a bit from being production ready, but is functional.
I've used this new client both against OpenVPN Access Server (with and with=
out
dynamic challenge activated) as well as Private Tunnel.  There will be sharp
edges many places and bugs to be discovered.  But I hope more users and
developers are interested enough to try this out and help out wherever poss=
ible.

Feel free to grab me on IRC (#openvpn-devel @ FreeNode, nick: dazo) or send=
 an
e-mail to me or this mailing list - and we'll figure out how to improve thi=
ngs.

So to the sources .... (I bet quite some of you scrolled down here first ..=
..)

<https://gitlab.com/openvpn/openvpn3-linux/>
<https://github.com/OpenVPN/openvpn3-linux/>

In regards to patch contribution ... Patches need to go this mailing list.
Pull requests can only be used during the discussion phase and the final
patches *MUST* go to this mailing list.


Enjoy!  And Merry Christmas!


--=20
kind regards,

David Sommerseth
davids .{at}. openvpn.net
OpenVPN Inc



--kvDWNCs15gnrcDp6rZSfEX4D5MmK4ortL--

--0jckvAKSB3y7Mcdgm1CYAErQ7TWJm0KT7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJaPOL8AAoJEIbPlEyWcf3yUlsQALL/F1UXb0P4ATjeH0tXOi4v
ki3WW7rmC0UPWKTKekhimidII2Gd7ZvfAUkOUVk9gE0d5CTMQAljjkgj/dw8onYF
rFR3SOc4rEj9bDofXMOAfAVatzPLHQu1lQ8+6fAunyoN/qlt/WDHDk6HKHEj6WXa
fGurgKsry2k5pY4NuSH2882u/X3byXuV/zSwgrR5ykSd/lPntm9ddKs4cMzT/iZH
iOPLcBctHUN0xdXT1UOhmeFz4TytB2oKvaD5UMF+zCFiTA3Pfa2fDwpQLh9Bb8v2
NCXO/LJBYx+aI7dFV9/QmpVkSk8dnK4SEQjaWTQXFhM7nXFQh4EYtsRin88LrWKk
2ursWLNwHfTsZXyAqKYKreqGdNVgDjjoLUTilkFI7irAwD2/UbMWVgh7GgDjOYkY
Y5Y7tMc7n7GbXfRoLYDKAJ5PVYaEs5Y2kYBuK9+VgceT7DH7ry5poODV99vont49
BfdmRBZfIluClR8cXOhjJDIfR5QoarjHaueXrMp4R8HeWD/J8/pcPDSpGtCssf0Z
FW4bTzk2bi+QfkHnMsk1hwslKHBmY7/hB3WIJwb7b5261aQh+ZAyU4emjB8OLAmc
VVQjgVZsJeO7EFMw8rNlad7WRSIvHV5Yx+OO05eR4Jisg4x1zoG7QWKi6lyBYXC7
+mTdqaZg4/fJcbkLChaF
=R0nZ
-----END PGP SIGNATURE-----

--0jckvAKSB3y7Mcdgm1CYAErQ7TWJm0KT7--

