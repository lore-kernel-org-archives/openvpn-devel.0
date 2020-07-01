Date: Wed, 1 Jul 2020 17:01:03 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200701150103.GD1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="q4NW1l+XkLAVal4L"
Content-Disposition: inline
Subject: [Openvpn-devel] users of --single-session?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

--q4NW1l+XkLAVal4L
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

is one of you using the openvpn option "--single-session"?

If yes, what for?

(This is one of the weird ones that brings quite a bit of extra state
checking, and hard-to-test special-case code - so we want to get rid=20
of it)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--q4NW1l+XkLAVal4L
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe/KUuAAoJEB2Cnv7KVigS4WUL/j/QN4gNg0Znh2GtCF48koRC
SnQDpswr7BYfgzRiKs7pbDYbQ5SgASp5U2M4hJXCzAkMVZUKYHr48TThaFZSLGp+
p+g7h6B8Kdr5UyhMId8KkWXuwLilh3aZP6bsClmkiwjvCcZRYy/d3RIo/hGRhVLM
Kt6yiDD4ITt2xxUQgCKTrf1lD9QvUGEMj9renOwMRmUUiHXUTSiDq+9RggbshhkI
s14j8cPwgvbTwlmeYpJ5rq12dJdPG967eXE96yYr3GM/A073aAcn86nO6CTO3DiU
Db8Vgj3yALMX3wi4ISUQGX/VpLbUmiD249SX9gsmf83slA7V7+B0W7znLrOhQUot
h9MrF6jBQYrSlUIe/XqgjzpYZJDqcf7KusjR9MXQwAGLIcChSBWHCF4bZsxG+UDV
GNY9cxkyc55fclGdqQjB2d6IVBoGTGzl103OXfKbk2nlE6NTnjEWrpZNGbDMTbSX
iBAMA0RD6hHBDu5EYFcrUOVGTsdHI39Do9P79lbV7w==
=55Zv
-----END PGP SIGNATURE-----

--q4NW1l+XkLAVal4L--

