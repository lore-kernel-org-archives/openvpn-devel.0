Date: Mon, 13 Jul 2020 16:42:50 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713144250.GD1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-8-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="dFjFFAA9rl99soCh"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-8-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 08/14] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
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

--dFjFFAA9rl99soCh
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:49AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch moves the state, that was previously tracked within the
> multi_connection_established() function, into struct client_connect_state=
.  The
> multi_connection_established() function can now be exited and re-entered =
as
> many times as necessary - without losing the client-connect handling stat=
e.
[..]

Server side test succeeded...

23...
Test sets succeeded: none.
Test sets failed: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b.
Test sets failed: none.


Didn't look too closely at the patch yet.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--dFjFFAA9rl99soCh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDHLpAAoJEB2Cnv7KVigSx7ML/jy5MgL39HzVedtLS9zlNuCT
vtMqn8HHwYnOPXHYrfozj8RY5nHfroDHOGLRnEeTBqbbEhvw8ao2Dmgc9YIGBECI
n3Q63o8e74DuGYdiC1SW9krnc8yMlHsWc0YKT7p6CkJLGkKJzZ3/mECdCSX5vBU5
lEnEHy3WGKs0fOWKXs67ydiMhc8vZqP2kjS3sMODEvOs62KxJGVXSSFuweKIJz1f
g/IDEAvlrG0DbjRwP8iiTLf9Or788M2K5biWGJk81yztFa29Ok2mkW/rTJlkAPYi
pCp6DtkHCPubPBC+t33PYq3mMRmJxcQKfW8Ibeue0UN8HUgxbB/PYWjkai3in1hH
u2PdyF+oR2y63vPl8cV3W8g/xNTGOpFGjKstW1xNgfe5RinpZn3OrD9mFU6T23yK
XsvKFodZ9SpO39spTpv3UTLGiyK8XWhxuPf3WN8c2Q3LjaQqKIyynTC9n9Ze0WP8
27npTQMWE2XX0vOtgFnW9w+TJW4R4mGchxMVZBiCJQ==
=2cOU
-----END PGP SIGNATURE-----

--dFjFFAA9rl99soCh--

