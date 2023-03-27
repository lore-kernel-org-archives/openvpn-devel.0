Date: Mon, 27 Mar 2023 20:53:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <ZCHmP+Jd/AXNOXz0@...1296...>
References: <20230327171236.51771-1-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="a9+av4zeMcYvEPTU"
Content-Disposition: inline
In-Reply-To: <20230327171236.51771-1-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Bug-fix: segfault in
 dco_get_peer_stats()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--a9+av4zeMcYvEPTU
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 27, 2023 at 01:12:36PM -0400, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
>   We persist peer-stats when restarting, but an early restart
>   before open_tun results in a segfault in dco_get_peer_stats().
>   To reproduce, trigger a TLS handshake error due to lack of common
>   protocols, for example.

This definitely looks like a good catch, and the "TLS handshake error"
is part of what is needed to trigger it - "just having a connection
failure" (TCP refused) is *not*, but "--tls-version-max 1.0" *in
connection with* --management + "bytecount" is...

2023-03-27 20:52:41 TCP connection established with [AF_INET6]2607:fc50:100=
1:5200::4:51194
2023-03-27 20:52:41 TCPv6_CLIENT link local: (not bound)
2023-03-27 20:52:41 TCPv6_CLIENT link remote: [AF_INET6]2607:fc50:1001:5200=
::4:51194
Segmentation fault

interesting combination of features.  Need to extend my test rig to
add management-driven tests, and also TLS failure tests (*using management*=
).

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--a9+av4zeMcYvEPTU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkIeY+AAoJEB2Cnv7KVigSnL8L/3/RN6UW3pfKlZap+tBBULx6
SFtXCFclgnY8liKBzTbs7iekC6QnMPQsDK3vNPMI7ZYUab/dWxFUblrs7zisrMFJ
CGa/4CPQRbKNr0PwCZVvDbizD/VoMMJeHJpRf/K7k0XmQvgD4ACbgdGHypijwNnl
9xCfxzMnT3JzlkydjM6WYKsLmUaA3AGAHNfUiRJD6ds3oAceAwi3wQYwG0V/N6pk
BVvp/9m3M/cMkcZI4LW0JMsDYqVQSV3SDyPZp4upsXCFNmOLqZhaLtHfQOE3NsP1
naCEKtxWy9BI8243XXr3oLy86Xjw09L+qI2h3UUH8rS3FObI3liMtHRWzUnlRtGX
rDuhNGAGTcJDUZp79O1GKbAm8AMl+AQd+dsa0O6LPGmPTMTS6rYA4Ct1QIm7/Dcu
k1Z7E1uw+W8N/v6aMKKW21p7bcHZ6BI0ZW3sBSX9GBWe7NFOFES2HpP6ax69g5A6
L0bGcqCsnugf/th7kC2/ZCwh3ecUQ5ZJvpzl/DfYLA==
=A/+A
-----END PGP SIGNATURE-----

--a9+av4zeMcYvEPTU--

