Date: Mon, 18 Feb 2019 15:24:26 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <20190218142426.GC962@...1296...>
References: <1550368541-10402-1-git-send-email-selva.nair@...277...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IRz9Vl8ucjVxogOP"
Content-Disposition: inline
In-Reply-To: <1550368541-10402-1-git-send-email-selva.nair@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Better error message when script fails
 due to script-security setting
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selva.nair@...277...
Cc: openvpn-devel@lists.sourceforge.net

--IRz9Vl8ucjVxogOP
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Feb 16, 2019 at 08:55:41PM -0500, selva.nair@...277... wrote:
> From: Selva Nair <selva.nair@...277...>
>=20
> - Add a new return value (-2) for openvpn_execve() when external
> program execution is not allowed due to a low script-security
> setting.
>=20
> - Add a corresponding error message

I find this a useful way forward (because it will not introduce new FATALs
where we had none before, just make the errors more clear).=20=20

Since David had reservations on the other patch, I want to have explicit
agreement from him before going on - and will poke on IRC to make sure I
get attention.

Nevertheless, as we agreed to tag 2.4.7 *today* to make the release tomorrow
and meet the Debian deadline, I will not include this in 2.4.7.

We can always do a 2.4.8 release "really soon", and include this (plus
other potential 2.4 material which is important for Windows, like the=20
OpenSSL 1.1.1 / cryptoapi stuff).


"Release early, release often" used to be the mantra... :-)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IRz9Vl8ucjVxogOP
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJcasAZAAoJEB2Cnv7KVigS8X8L/jYLeoe3YhPijgtzs7lwBpRK
bM/a1CLLE7EjouI7sDTNKMiGRwIzihebo/nPVr5DRSbYV2+6xmZCz3MMbIYn+lv1
qjAcdBCsjpjvzlbPxHa6Ck1OT4j9M0QJtqGEXfJcl7mDu/d5up/6q1uh1QP9vTDG
YSzQ3hNGN8Ud/1n7AP//HybtMshEFXmEG4CoUaeWSjn0Hf99FmToI5CuT4giiClm
+nRZx0EoRG7d3FOFPVQO2ppkgUAz+2WTXOSZ4Y080s4k6CpBcuOIJ833RFvUbvTA
oItoONunDweLHqolmqJLGljT++AZ7SJR2UjRDcxumGrYmbYjH/tCLj1F32Y8XnI7
GfoEHc2i3bIk1uhZUqH9P5F+ebjUOYDhGw3CyfX0MbkGgGhxJQChJeKLO0QiAL8C
rQaTpcE6WRm6Pnn0irpmRYmrNATYLP6cTtdBjp3YcL0GmIp1v9ZXF0zfDhLXgJZv
dYmlUEXZh6Aj69WIElNyoC/zM879kQFJ4dqCqbhjTg==
=AFa3
-----END PGP SIGNATURE-----

--IRz9Vl8ucjVxogOP--

