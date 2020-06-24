Date: Wed, 24 Jun 2020 10:11:36 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200624081136.GA48056@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <20200621085315.GN1431@...1296...>
 <1592752234.3694.3.camel@...2316...>
 <20200622162326.GX1431@...1296...>
 <1592845604.3719.11.camel@...2316...>
 <20200622172815.GY1431@...1296...>
 <1592850496.3719.16.camel@...2316...>
 <20200622184015.GZ1431@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="5mCyUwZo2JvN/JJP"
Content-Disposition: inline
In-Reply-To: <20200622184015.GZ1431@...1296...>
Subject: Re: [Openvpn-devel] engine-test on FreeBSD still not working
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2317...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

--5mCyUwZo2JvN/JJP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Jun 22, 2020 at 08:40:15PM +0200, Gert Doering wrote:
> so
>=20
> $(builddir)/openvpn.cnf: $(srcdir)/openvpn.cnf.in
> 	sed "s|ABSBUILDDIR|$(abs_builddir)|" < $< > $@
>=20
> should work.

It doesn't :-(

It worked for my tests of that patch, because the openssl.cnf generated
with "gmake test" was still in that directory - but today I created new
build directories to test --enable-small, and it doesn't - seems it
is not understanding $(builddir)/openvpn.cnf: as destination, nor does
"< $<" work.

What works is this:

openssl.cnf: $(srcdir)/openssl.cnf.in
        sed "s|ABSBUILDDIR|$(abs_builddir)|" < $(srcdir)/openssl.cnf.in > $@

(tested both for clean in-tree and out-of-tree builds)

Can we have a new (LAST!!!) patch, please...

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--5mCyUwZo2JvN/JJP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe8wq4AAoJEB2Cnv7KVigSUdwL/0XJ57SHUQMthKQ/4IqMXpHR
nTnc+TyawmHwtrsic1aYAuKuHRgebbDAw4Hn6KG11N03kYhbmxnuqUT/WPCf1cVG
KiNxlcDbmgTcjfBr85zJRlhIyt6dqYCzLOIFa80eK/6ABugyxZRgh/eiUY9qArw3
7UOPILEbdesES1qyyb10CjQGX9d+7TbqFXvEJEz4JWDtcbNIJZk9+5W20JhlwTWi
72GHvjGum8xxnPf/KFbR9ySxTFQpJDCZ0XrC4EcWfjHaXcJBtPMpupzimN0D/X3y
nw8bJtz4wN0vtl63xHk9kX6CAEknRuYpi3OdKcGAPWKslxZ3PvCxQPhd9g63rJDY
MheziruRYuW5rxJMLZzSfsWmqTkH+prWSIIXiTAmfCO1kKBeZd27VjI/xbABxBjD
N4HbzM0zgMBy+Fbi2OHHxV0sLJyIQ8h2wzrViD21bvhikC/vPv1PIr1AX0nwWYUH
acYy0AgVhdrAEY6dMkoWQAmxaOFmV+j3DtLLTeWKJA==
=IO5L
-----END PGP SIGNATURE-----

--5mCyUwZo2JvN/JJP--

