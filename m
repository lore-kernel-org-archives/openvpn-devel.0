Date: Fri, 8 Feb 2019 20:50:11 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190208195011.GY962@...1296...>
References: <20190208194018.20325-1-gert@...1296...>
 <20190208194553.GX962@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="V3v4ZfinIQ/GzAkm"
Content-Disposition: inline
In-Reply-To: <20190208194553.GX962@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Add unknown-unicast flooding to p2mp
 tap bridge.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--V3v4ZfinIQ/GzAkm
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Feb 08, 2019 at 08:45:53PM +0100, Gert Doering wrote:
> On Fri, Feb 08, 2019 at 08:40:18PM +0100, Gert Doering wrote:
> > Enable flooding of "unknown-unicast" packets from the server to
> > all connected clients (+tap).
>=20
> Hrmph, this is incomplete.

And broken.

Packets coming in "from TAP" do not trigger MAC learning, so if you
ping "from client 1" to "out the tap", every single ping packet=20
client 1 -> tap will trigger an

Fri Feb  8 20:47:39 2019 us=3D707460 freebsd-82-amd64/2001:608:0:814::f000:=
2 MULTI: unknown unicast destination [00:bd:50:58:45:00], flood

... we do have a trac ticket regarding MAC learning and TAP interface,
so it seems I need to revisit this...

"Now I see why our code does not do UU flooding".

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--V3v4ZfinIQ/GzAkm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcXd1zAAoJEB2Cnv7KVigSw8MMAKIeIXiEBQAHHkzxhb2/xLeE
Xbl8BJgsEm9alDLcG+uILPrjb1V2ch1vUj8VE2El74C8jGOXdfXTrNL7U5n41a73
UjAjuSXH6QYis1cxUD6HdtPVbBHJ2Kv9dxUxat8jwBdwkL/CkPdGb9rDEa0VWuIK
AUkNDnUJ24he4zoX/0Z+4swy8v+X8uHrw9DBVQwXsIdEE2QscOfcb3LbsXotr+zH
aQqrHj58U7DZOrmiRVdJjgXpbAS9/t4shJXeDyEaigN+mQ9Pjch1fH39wPHbBU9a
efeT7mJ91De0cGo8hx/KFtSLrrlm0rRrWJQnsoogFGZPmwTMX2CHhoVrRzgbo3Rf
Lk3wfMe6Acpnbki3yZNSj57YRo46/lFnXNZSkDoSR1So8UA7ahUdukN8gRmN5VXj
1U/31q5WqX7snvn2Fx91ZnlseFeuDZaU9Ac2bc2AdxnqQl/b2XWnizB80h9MeEO0
efU1olrwKGlhS5FYOpXNXsYgyHYlH1lA9X21AdkjWw==
=0fcr
-----END PGP SIGNATURE-----

--V3v4ZfinIQ/GzAkm--

