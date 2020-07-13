Date: Mon, 13 Jul 2020 12:48:51 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713104851.GR1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-2-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="AYlbFeKgIgez0tzv"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-2-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 02/14] client-connect: Split
 multi_connection_established into separate functions
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

--AYlbFeKgIgez0tzv
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:43AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch splits up the multi_connection_established() function.  Each n=
ew
> helper function does a specific job.  Functions that do a similar job rec=
eive a
> similar calling interface.

Tested on the server test rig, it seems to be happy with all test cases
I have

start client jobs...
23...
Test sets succeeded: 1 1a 1b 1d 2 2a 2b 2c 2d 3 4 5 6 8 8a 9.
Test sets failed: none.
24...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 4a 5 6 8 8a 9.
Test sets failed: none.
master...
Test sets succeeded: 1 1a 1b 1c 1d 1e 2 2a 2b 2c 2d 2e 3 4 5 6 7 7a 8 8a 9 =
2f 4b.
Test sets failed: none.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--AYlbFeKgIgez0tzv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDDwTAAoJEB2Cnv7KVigSo3UL/0UjMf/C9Nirkmr506fA0mrW
jXu1mme5oComs/RiCzz9z+oxfINVTI5jjiBcBD2icHLwhebzVRK4GsDhHaBSN/Ol
59W9KW5wxUhJNuaZiHSec95b/w7HKv7MNKPjvGQNEgV3I8h6b85+bL6m0Zyq/PNE
Jt13P2Jz2odOavCTJfr2mbOVgRXXeLGoqg1kDFWloDFMovTNMOs8Ai0ZAJqb2RMc
gx70BYr4nEfcjZSqKs4UqjcQE6MCjmKNT7ju5sDzghA9J0Zo3sOUs/MVrYsFkaQL
6IGwp1iKODFhYDRofVzVuxBVKzx/fhr44biHQ6tg4fgINyG30FvECxRpIUHHprsd
JwtmF6jkR92zDTCFGC80vOkLJm1Tf7cFF1LDXuiOGgF5pp+hi+q6quPmoiDlI022
CyOrsHUFXFSpEPmyurLGnm2hU2nHlRepd/JkJK9bi6zdYUJMyrcGvajXMZCM56pb
8sYJsWe01H15QDgH0BuYRQQzjQk7GLqrghS3nqndzg==
=xB/y
-----END PGP SIGNATURE-----

--AYlbFeKgIgez0tzv--

