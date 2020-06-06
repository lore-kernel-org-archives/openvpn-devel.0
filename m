Date: Sat, 6 Jun 2020 10:41:10 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200606084110.GY1431@...1296...>
References: <20200528225920.6983-1-James.Bottomley@...2316...>
 <20200528225920.6983-4-James.Bottomley@...2316...>
 <31d467d4-59da-08b2-166b-13f62a59b82f@...1227...>
 <1591374528.4728.53.camel@...2316...>
 <1591377595.4728.67.camel@...2316...>
 <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="UdFih+Jx4cOX0lAR"
Content-Disposition: inline
In-Reply-To: <47ddb948-d12f-6372-1ca9-34b70dee3f25@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v6 3/3] Add unit tests for engine keys
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: James Bottomley <James.Bottomley@...2317...>, openvpn-devel@lists.sourceforge.net

--UdFih+Jx4cOX0lAR
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 06, 2020 at 12:48:36AM +0200, Arne Schwabe wrote:
> > So if this works, with the eval above and full path substitution in the
> > openssl.cnf.in I think I might have a solution.
>=20
> Unfortunately not. Still creates the .so file.  If everything fails we
> might just do a if mac then cp from .so to .dylib as part of the test
> run. It is ugly but might be better than to wait forever on this patch.

Naive question - can we not just use a .so on Mac?  Like, consistent,
build .so, request .so from openssl.cnf?

(Haven't dug into shlib weirdness on MacOS yet.  But if you want, I can
tell stories about shlib on AIX.  Which will make you ask for lots of=20
alcoholic beverages so you can forget again...)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--UdFih+Jx4cOX0lAR
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJe21amAAoJEB2Cnv7KVigSA0wMAIiwDXOGMNNZBicALZNLE2+T
yJCsZiuISv+j9p6whxoYG+LG0HPt5LBF9Fxo0GNXNUl+s9MFK1o1jzomnfoiQPdb
Qv9ZJQkDq+6IvM5SIcLlug+H3AKJompo2ikqtS2xHH/MigZdtu2FIWG4+gSpyl07
nDHE9qQmm9caXZbU8LnaeDdNq5qZD8Z0RtGp5HRU1EtJOgr/g3GdIGtWyt/HiYJb
FuJBYXCRLJnU4L7P2zzLmlhKlfBkILEK5UxE9kM9d0SXwTL7gUg4snTAd+Xq+5D5
evDl3ijYDtohS0BWuCUiVh7QFOH/tOPdCPlzTJlZj4nP/p7khHJm3nWgMXGoDTpX
LcJBrN0+ev6U3bAzoFIiIsByABTweo/tAa9duMXl/U36Tv0HT2xcQOJIKOBHF9NM
7c0d5ltB24a4ShL71xTl1ocdzzpFdEMoLQ0OpI+eVp+3juTlwdSR//KPNu+dEL8I
NDmpWShpJyrE2NioMsa6Ax8DQ168wcgYqP2gATRh+A==
=ym/q
-----END PGP SIGNATURE-----

--UdFih+Jx4cOX0lAR--

