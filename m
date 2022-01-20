Date: Thu, 20 Jan 2022 08:45:42 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <YekTJg/IE3otjY6R@...1296...>
References: <20220119232743.16779-1-a@...2181...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="F0grf1X4atYaGN43"
Content-Disposition: inline
In-Reply-To: <20220119232743.16779-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] GitHub Actions: add other config
 flavours
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

--F0grf1X4atYaGN43
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Jan 20, 2022 at 12:27:43AM +0100, Antonio Quartulli wrote:
> * --disable-lzo
> * --disable-lz4

Not sure having them individually does much good, but we definitely
want a config with "disable all compression" (--disable-lzo --disable-lz4).

This was what we broke last time :-)

(And it might actually still be broken at run time... MaxF?)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--F0grf1X4atYaGN43
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJh6RMmAAoJEB2Cnv7KVigS3EcL/2+FSVnN87FFxu1PaMH++l7A
64JzHihNPZ9mI9vnzl6om92asX/dE1znMYFHtAjAaa/lvXvEiBMkmy/o+B1xLXWr
yd4i1EPdyOsah0ceHLY6tToeMXILvzxPsCPapVIioPVtyM9b+Dk7cWNmSa5Es9rK
O2s5YrBAYCEntHRukDc4nB/Y+mWoBqB2QhSILW1LJTzlZ4OArP+NA6VYy3z66vdD
9blgjwvruK/2dlUpv1oGgMvzyCPKjTptfmuCR49M5MG5kaXDi7u5P904vm3vLGU1
OB1RjXeBorhHAtFARgjDz1RpS1BV1RADx4pfWz5PWPje4H+fvSyZ+8z5A6Ei4AXa
xZwzhIV5O15iqVj3PkBlkecBgjqA16YDbGcf21r0oQw1zDmliOVZVafbtRCjbJNb
pYJef/+gLHo6aUm2dq2ijX03Gkxq91+WUFkyZuss1urUZopTNIUj/fuINGEUWEBb
qFdbgRxITx+gB6RXJLgN/8M3gBoNyC9UjbwTk343ZQ==
=LTkv
-----END PGP SIGNATURE-----

--F0grf1X4atYaGN43--

