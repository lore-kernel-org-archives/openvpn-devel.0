Date: Sun, 18 Sep 2022 18:06:56 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <YydCIP5l0WwH5OX+@greenie.muc.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="JtWfgC047OP71yRL"
Content-Disposition: inline
Subject: [Openvpn-devel] --explicit-exit-notify and P2P mode (trac #1337)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--JtWfgC047OP71yRL
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

we have a long standing open ticket, #1337, about --explicit-exit-notify
together with peer-to-peer mode.

My understanding of --explicit-exit-notify comes from p2mp mode, where
it notifies the other end "I have been SIGINTR'ed, and will go away now",
so the other end can stop sending packets (multi-instance is killed on
the server, and client reconnects / goes to next server).

I have learned much later that --explicit-exit-notify in p2p mode does
something else - it kills the peer.  So you press ctrl-c on one end
of the OpenVPN connection, and *both* sides exit.

David tells me "it has always been that way", but I wonder if we should
keep it (=3D close #1337, do not change anything), or do something else,=20
like "ignore incoming EEN (control-channel EXIT or OCC_EXIT) if not
in server mode" (*)

gert

(*) p2mp server-to-client is not signaled as EXIT/OCC_EXIT but with
control-channel restart

(**) https://community.openvpn.net/openvpn/ticket/1337
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--JtWfgC047OP71yRL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJjJ0IgAAoJEB2Cnv7KVigS9V0L/1UDK6O02EDM6cBeAONViXe6
demCaKb+0hKQua2XWIDwsQHs8L3BeU3S/RFRQgYA+G911DUDNX6O/3tpCw8Z9L7G
2OFzQ15ZncLU24BMKwlbyyzZP8gfTQ0PB+bAHKUTEvIOgeORtG2dujTb7tzIZq/y
oNlPyBaS8v/Gm29SFgRWXx0OS21dOM49BrXP7pgf7cWvyoROmDbc16IQFYXKcrEt
w7j34ZbCmzb9vOerurT3GxzGoQpAwaKsLGXI5P+Je6r4h570isay4pcwyU/cG3tO
FDZz7j3ojZ95aoXYm8rIn1+nmBDIoXNkVDx9U15ZpwDooRycs9TT24QYredSL6JH
77ufLjvBzcph5bMw7QMfEb4qauuOHzc5ERVb4ZLIsdpd8cFvMgPG4xFg4O1o/XYH
3Ume4a2U8pvdNRmTTF1zhtLrk6IpTg1Z57rOFomIMjKVRmFNKrqoCumlWgO9gUst
MrjWEpewqgunA4XQLcdgxUrYTchGsONE1Do6KDVgxQ==
=QES6
-----END PGP SIGNATURE-----

--JtWfgC047OP71yRL--

