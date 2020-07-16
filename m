Date: Thu, 16 Jul 2020 19:28:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200716172851.GD1431@...1296...>
References: <20200716134315.17742-1-arne@...1227...>
 <20200716134315.17742-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="NOjcAefgc2NehQQj"
Content-Disposition: inline
In-Reply-To: <20200716134315.17742-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v7 2/6] client-connect: Add deferred
 support to the client-connect script handler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--NOjcAefgc2NehQQj
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jul 16, 2020 at 03:43:11PM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch introduces the concept of a return value file for the client-c=
onnect
> handlers. (This is very similar to the auth value file used during deferr=
ed
> authentication.)  The file name is stored in the client_connect_state str=
uct.
[..]

The test rig found no explosions :-)

start client jobs...
22...
Test sets succeeded: 1 2 3 4 6 8.
Test sets failed: none.
23.small...
Test sets succeeded: 1 2 3 4.
Test sets failed: none.
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 5x 6 7 7x 8 8a=
 9 2f 4b.
Test sets failed: none.


... but the new code is not excercised yet, of course.

Will see if I have something ready with async-ccs when Antonio has
stared-at-code this :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--NOjcAefgc2NehQQj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfEI5SAAoJEB2Cnv7KVigSi30MALHdhFyGJbsr+aoF6d3XiSpA
OY4wize5Sjj8kBSYCU9IVso7jvMA+cPO22k4v131m3VjZd5smskGrPHR/fMm8VL8
mDPttG5B0A3SCYicmZXx5hCvoP+BfBeMAHLwV2L/1/x9kcncuA2/+konTWxf804z
SbofZaaFhvLBwFUGMkP4/fVksOihguqm169vHzZ347Kv6/cBVIzq7PWE6pqcOw+6
LH0mtsj5eTUgee2n9Gm9uk3IiyiDmdi/eoFef1zVoqGqUBQACbl6D0rpIT/NElF6
+ndwHx9HvybRaeL7WBbBvATavpN2VjGdGR+HLyQzxLAfmBrEODICvqKwoKzGBR7G
0G0RjCLWnCdkZAOc2RBGVd4maJapi13DuFytVx7NbeoBuP9tBha988lzwD3QUiQo
AoJwY5e3Qir34m756IAf0hCLVrrfX6FM8OkrXNeDXMUjKgqi+jjEQHTK21zX+gCa
sYu7Xe6t+9vo05xidY+WBbZJJkX1av7rpAm8E4prXA==
=GAaU
-----END PGP SIGNATURE-----

--NOjcAefgc2NehQQj--

