Date: Wed, 20 Jan 2021 19:52:55 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20210120185255.GM976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="+eUe5/cUWamSiL/9"
Content-Disposition: inline
Subject: [Openvpn-devel] HEADS UP: removing --inetd support in 2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-users@lists.sourceforge.net
Cc: openvpn-devel@lists.sourceforge.net

--+eUe5/cUWamSiL/9
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hiya,

just so you have heard it: we're going to remove --inetd support from
OpenVPN for OpenVPN 2.6 - since we're assuming that this is hardly
used these days, and it complicates the code base quite a bit.

If you have a good use-case for --inetd that can not be solved otherwise,=20

 ** NOW IS THE TIME **

to tell us.

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--+eUe5/cUWamSiL/9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgCHwGAAoJEB2Cnv7KVigSX+AL/jhE9gUjIo0j2PFieoGk+bye
xceNvmbKAvLEAQjxATMAmcU5Qv2lt1yO4k6D8SDWDjvS8tVUQy1Msk1WuOyCKxM4
Z+r6tITMqyWJD422f07ndedX42D4flctDxZrJIZOqO2MiY8FwjQ2AgKTCW6uUas7
GQQSFizw+Vv7OS2p1Az1tHCBhjBOxL/RMuxKkdQccShRPKZrOM6BZ4F3+0vHgWP3
xSqS9H15/RqGSepSoil519vj6aiE2ll3Sj7CTSQpPA0RWY9wXOPEuaY9wYGjJZoM
//EcVBGyzx/AvQTwmVtiGJLyPRKABJFAIKtrQEjJ1odGocLMVWPO+avOWC0WYAi4
cLGJm6Ul3Hyh0M9bM9zekkRM5EBqs60dGQG9miUuX4ejTlIqs562Fw1BaC0pBPZ3
amciRmcDMOxODK0r1kx54Af+xqerMDePs2xlOvIXNbL11wkfJ+nM+IZjF3vabEaq
aP0KaCxu3ytMg+UEoSCFRTfb1+fiWR0Vr7ItgzpSXQ==
=O1A/
-----END PGP SIGNATURE-----

--+eUe5/cUWamSiL/9--

