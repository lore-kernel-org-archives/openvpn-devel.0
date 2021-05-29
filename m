Date: Sat, 29 May 2021 09:16:11 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210529071611.GB976@...1296...>
References: <20210529013516.767555-1-sergio@...2617...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ENpqsvBIEPGm1s2S"
Content-Disposition: inline
In-Reply-To: <20210529013516.767555-1-sergio@...2617...>
Subject: Re: [Openvpn-devel] [PATCH] resolvconf fails with -p
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: sergio <sergio@...2617...>
Cc: openvpn-devel@lists.sourceforge.net

--ENpqsvBIEPGm1s2S
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, May 29, 2021 at 04:35:16AM +0300, sergio wrote:
> From: "Sergio E. Nemirowski" <sergio@...2617...>
>=20
> resolvconf -p
> resolvconf: Error: Command not recognized

Which platform does this fail on?  The fact that the -p is currently there
hints at "on some other platforms this works and is useful"...

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ENpqsvBIEPGm1s2S
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJgseo7AAoJEB2Cnv7KVigSfb8L/iYzrpxzXwWUcb8m50Gypgc0
VRgaNfdMgoLAKmbRD86LlgnZnEDq4qV407eJ0xu3hzS60oZW1CdUpxQPrXLnSjVl
sh2pD4h10agWj9W0xndKyHSwKgaf0+Y66ODGMWELwRG17hr++N3+Dclm/UNc5JQA
Qsv3xkthXEi0pNhG5P1t3AwR8z7A4ZxOb10kdrN+hyHBklk7+AirGAc4JuhXob3d
odgNQDggePzNIcHEpM41/HJSCQmTZv40+rnboAVzALLzYVF2xAjMyUv9O738flgq
mDvIpKH3rA3M0qa8PlnnCcwCERLE8qCAvNWL3COCVl0RuAFQn/SIQAlqgSNPGd4J
9vD8NMarmx+S9eTwrOQ+N+itAaZ39YDVe7tQUzH4XQFLqVQUtfSIKgWESiwTNoRb
0DiuP+EjWx/blng9Jes9L9+JRRLHC/Pl5kbftGSM+dVxXeyxSvZgbcrrZdwMBGaU
o2UUjKYnEwix7SKOFr3raFgKl7RcRgJDSil9AV71Kg==
=m23z
-----END PGP SIGNATURE-----

--ENpqsvBIEPGm1s2S--

