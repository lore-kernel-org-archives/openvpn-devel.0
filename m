Date: Wed, 13 Jun 2018 13:29:12 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20180613112912.GQ57262@...1296...>
References: <20180613081218.1834-1-a@...2181...>
 <20180613081218.1834-5-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="rFIYBvGcpYHPpb9I"
Content-Disposition: inline
In-Reply-To: <20180613081218.1834-5-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH 3/3] tun: get rid of tt->did_ifconfig
 member
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net, Antonio Quartulli <antonio@...515...>

--rFIYBvGcpYHPpb9I
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Wed, Jun 13, 2018 at 04:12:18PM +0800, Antonio Quartulli wrote:
> From: Antonio Quartulli <antonio@...515...>
>=20
> tt->did_ifconfig is currently only read by the Linux platform, but
> it is currently iuselessly set also by every other system.
                  ^
If you're respinning v2 of this set, there is a small typo here :-)

Otherwise, ACK.  Thanks.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--rFIYBvGcpYHPpb9I
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJbIQAHAAoJEB2Cnv7KVigShEsL/27YkTwH1WyfCstftNyhGQpI
ovtIIEAGa1DXfvfF2fKs/x1ilQYjQYJwV6uEp4GSsrvZJMRJl9pANCquqnwffFZg
7xilfRUzY7qmY1G+CZwbM3qPTkwTGsFcgUOLDlYSvA+Cd9f2gYhGWigvWVZjonvk
h6oFoRq3TKp7bmWzSBoICnHpOPYK0GCfEAtUPtdBu3RenKOtQxXEhTRtncWIPbEc
AYSSCTv5X2oLB0b1SQ9Dbb3ITTCZpIlgcb1a6fJ/hW/XApRIdtX5Ywf5trTTzWVd
FZ4SCNWt2A5o3GwoEGPJVsXcf/pyZ4X2X4P+m7eYQL7irFekn4xzdQDzVpXbvyvm
byuAIMcf82A1z9DL1fZiHq9WwA7uKnvbETqF89nYQoMLyShA7sAIZz+QwWbkx6hO
fidIXNrewiRrYVDwc173bX59QmUa0w1gQz/v4qysCUDECE1IlcLu0UhEfg45b8zo
NpwMDeIwMiYj2QKK5BHIfQD/unCfLexc5qdDJnpzZA==
=FKSg
-----END PGP SIGNATURE-----

--rFIYBvGcpYHPpb9I--

