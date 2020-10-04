Date: Sun, 4 Oct 2020 17:35:32 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20201004153532.GM976@...1296...>
References: <20200930131317.1299-1-arne@...1227...>
 <20200930131317.1299-2-arne@...1227...>
 <20201004131457.GL976@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cX4WM3qIY/fHWHDu"
Content-Disposition: inline
In-Reply-To: <20201004131457.GL976@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Allow 'none' cipher being specified in
 --data-ciphers
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

--cX4WM3qIY/fHWHDu
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sun, Oct 04, 2020 at 03:14:57PM +0200, Gert Doering wrote:
> "Wat?"

Also, the unit test fails for me (on Linux):

[ RUN      ] test_poor_man
[  ERROR   ] --- Test failed with exception: Segmentation fault(11)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cX4WM3qIY/fHWHDu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJfeevDAAoJEB2Cnv7KVigSyCMMAJRvTgGiHCQi1DM2EsjXoOPT
VOIqfD6deUauENI39PrfL3CkgfJx8siQNNRKplVxaMIq2/DDob3S9RU3+fp8ARAc
B7SESoVijchdfv/4KCZKtAAra924+42SC+DyxxaTzCR3mRVqtdsXmKGYyds3nswT
ogqYoZW+Lnzu/GVfiGKg7OG+MCJsut9OtFPxirRTRvLt2fpNt3SBLOwujtGEHUV9
2XAIa4D5F5xNlbAUeT9oHjN7z4xi4DTZ2/PVdy+qh29Pr8nc71nMebUbx411vJgn
0xy9HHrApbyTYjA/KdFzrMHjXkIyfpl4qRR9bYuiiVB24zPZDgoxIzoxqyW91NnF
pE/cvIVeMl3VmwNZZKcxVzRO0U0RzT37fVX6ghadTdEk3PKoX9F/aAL5gtu+Ecdi
1hU0rRm/zFShVHBowsmUsFrAeb1F5BQt8tRDQED2gJO5Dfg5zj9Cbvc6BD/Zh/gZ
X2J9Qfl6PNCkhD/+rig6gB7GB3VPDPOlK1At3j176w==
=qntL
-----END PGP SIGNATURE-----

--cX4WM3qIY/fHWHDu--

