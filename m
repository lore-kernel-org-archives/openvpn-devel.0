Date: Mon, 13 Jul 2020 15:23:21 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200713132321.GA1431@...1296...>
References: <20200711093655.23686-1-arne@...1227...>
 <20200711093655.23686-6-arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="EjiLnlbgNAuYg6jo"
Content-Disposition: inline
In-Reply-To: <20200711093655.23686-6-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5 06/14] client-connect: Refactor
 client-connect handling to calling a bunch of hooks in a loop
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

--EjiLnlbgNAuYg6jo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jul 11, 2020 at 11:36:47AM +0200, Arne Schwabe wrote:
> From: Fabian Knittel <fabian.knittel@...1547...>
>=20
> This patch changes the calling of the client-connect functions into an ar=
ray
> of hooks and a block of code that calls them in a loop.
>=20
> Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
> Signed-off-by: Arne Schwabe <arne@...1227...>

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


I dot not test all variants yet, though, so this is not a sufficient
test to say "everything works".

Generally speaking the patch looks quite reasonable.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--EjiLnlbgNAuYg6jo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfDGBIAAoJEB2Cnv7KVigS6XIL/RLC3e/1TgiuCaRICdbPhK6q
J0ChRlEFY0o6NNxB1YkaR4VHpPyp5GRxv6hecm0S0rx1i/NuptLHUgP6ki9N/rdY
xjREFc11jzmqIah1HdjZi6UUxNOifkYd0OPjsKxLsHcPTuR9NzQH1v9fjRn0+5q3
xTWxDDT+YO1ZfRLEa4/7O01X88/fIBt+OUPI9+tvR1CY3/ov5/GKd5M2Spc/5xB+
Zbrl5q+0fh5qhIZKmyYIPB+jPX9+xlvnQM3ZyForBvYqACFHWuPI7KaQujPQgVPU
jbTSTthXzp/za21Wj2jh30k9H1Yy6uqRS0MjG7WiRSL9KQuYOKxWKQ4XQvUqXOCi
VXV/WXUPRnbq1owIV69ggolY57K315dkTf7zNAaHlXKTnBEUWJ8bu8MQKrKYdhGD
Hr+bfdSih8nM9D+wN86W+rci/SxD8iqRi25EPOYCpXZUA9ATLTPXRt23Q4tN5Qyi
69D1mFYrQNPFJUZXPXGemKH/c/q/maKX1iqTkMXBrA==
=dGnP
-----END PGP SIGNATURE-----

--EjiLnlbgNAuYg6jo--

