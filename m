Date: Wed, 15 Jul 2020 12:49:13 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200715104913.GN1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="tzXjgrVXQ8jLP8+f"
Content-Disposition: inline
Subject: [Openvpn-devel] collecting info about openvpn plugins
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--tzXjgrVXQ8jLP8+f
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

my test rig today is not testing "client-connect" plugins yet, but
it better should do so (while Arne is busy rebuilding all that stuff).

Before I start writing something basic - does anyone of you happen to
use an existing plugin that provides client-connect functionality
(as in "create per-user configs on the server")?

While at it - what plugins *do* exist, and where are they to be found?

I know about

 - src/plugins/auth-pam - in our source tree
 - src/plugins/down-root - in our source tree
 - sample/sample-plugins/{defer,keying-material-exporter-demo,log,simple}
                         - in our source tree

 - radiusplugin  - do auth + config from raidius
    - this has been forked a few times, and I'm not sure which fork is
      the best-maintained and least-buggy versions - feedback welcome

 - Eurephia - David's "flexible OpenVPN authentication plug-in"
    - http://www.eurephia.net/
    (from a quick glance, this also only does "auth", not "client-connect")


Please provide feedback if you know about other plugins (or details about
radiusplugin) - so it's available in the list archive, and maybe I can=20
compile this into a proper Wiki page as well.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--tzXjgrVXQ8jLP8+f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDt8pAAoJEB2Cnv7KVigSY+0L/1xkeVx6183g4AoOAW4EahZA
KawANyLVjLwylqkFOXmJZB6iEDA/XnFIcZtgrjjvcur2lruGM6fJvCCOXwZ2yr72
A5NOo5jCUmUcLAKmUb93dgmdUCRhA9KcXUPeUOLfb/ZaT64eDQVb9N0yQUYYqIIX
oaFOIxbq1VrLGJIQbE9jhxSrA9xuLkE7+jsaTarepnexV4pR9YUNngNXgNauuZR8
ykEA/9YPdBgTyFjwWOGFFxYy2TDm0nxHszpdD4eD0N9ZA7xWDKfnzNUX1c7X197F
0WkGqajUP5lYDduaCiKVFBHDAwG2TZN3M3dzLBuY8Dvz0KaJfZUGAG9l4fjWX53x
Ez9uNe8H0xfubOePHByHlPcXiUVYEVHdsnPaSqWaGdSVjzectQbiZcYPbbGU0cFy
BEWnR2QLrBZB8MQqvww6ExhKSov8lS/Hnpi8S1Mluf8wq3ahBOk/i1EVN9wRCYea
BJFuiproKSiUR55szpMwFC7pQowyNprnpWmDZmt9kg==
=2yYK
-----END PGP SIGNATURE-----

--tzXjgrVXQ8jLP8+f--

