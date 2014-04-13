Date: Sun, 13 Apr 2014 12:40:46 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20140413104046.GK16637@...1296...>
References: <12223459.75082.1397360537380.JavaMail.root@...1893...>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="fsa4OW4MtKwB4lU6"
Content-Disposition: inline
In-Reply-To: <12223459.75082.1397360537380.JavaMail.root@...1893...>
Subject: Re: [Openvpn-devel] Openvpn 2.3.3 (community edition) and "Socks V5
	method selection"
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lisa Minogue <lminogue@...1892...>
Cc: openvpn-devel@lists.sourceforge.net

--fsa4OW4MtKwB4lU6
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Apr 13, 2014 at 05:42:17AM +0200, Lisa Minogue wrote:
> I would like to know if the latest version of Openvpn 2.3.3 (community ed=
ition) has incorporated the fix for "Socks V5 method selection" flaw?=20

Does the release notes indicates so?

> If not, when does Openvpn plan to incorporate it?
>=20
> For more information please click the following links:
>=20
> https://lists.torproject.org/pipermail/tor-dev/2014-March/006427.html
> https://github.com/Yawning/openvpn/commit/7474f1acfc

I think it just dropped in my priority list a bit...

Reporting this in lots of places that are fully inappropriate, like
the *users* list (instead of the devel list), the *security* list=20
(it is not a security vulnerability, just two silly programs not=20
talking properly to each other), and the forum (which is also primarily
targeted to *users*) is not exactly the way to get the sort of attention
that you want.

(You're lucky insofar as someone more reasonable has opened a trac ticket
for that already, trac#377)

gert

--=20
USENET is *not* the non-clickable part of WWW!
                                                           //www.muc.de/~ge=
rt/
Gert Doering - Munich, Germany                             gert@...1296...
fax: +49-89-35655025                        gert@...1297...

--fsa4OW4MtKwB4lU6
Content-Type: application/pgp-signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.13 (NetBSD)

iQCVAwUBU0pprqkuBuNlUUl1AQJMowP8C5q8/5CDjswDaZ1HtLo+DHxUjYdfN+s0
0+WQsIcSB0WB5UH9PQw6biwFV1Z6pk6iWyfLPkVjwr1zd+uVdYtA+RA50Eo9ah4c
CyQtSoI3G6TgwWVyP5Nydobu80toYgBA22nWj/oUdBQPJUfqC+qhsjtddIlwO6yl
ffImUFpgPHk=
=Q8gv
-----END PGP SIGNATURE-----

--fsa4OW4MtKwB4lU6--

