Date: Sat, 26 Jun 2021 12:28:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20210626102816.GV976@...1296...>
References: <CAFHpkQEoWAMOzBP9Ra1ygp-8HpRxhB3kmQEvZYuRrBqrYV05qw@...278...>
 <CAFHpkQEOCAu9BvwJpN-DhiJPa+F5v7NrJM_aYtRZX0GgoXhdGQ@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="cIntUtG6ibELK2eb"
Content-Disposition: inline
In-Reply-To: <CAFHpkQEOCAu9BvwJpN-DhiJPa+F5v7NrJM_aYtRZX0GgoXhdGQ@...278...>
Subject: Re: [Openvpn-devel] is this expected when using "--dev null" ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ???????? ?????????????? <chipitsine@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cIntUtG6ibELK2eb
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 26, 2021 at 12:37:44PM +0500, ???????? ?????????????? wrote:
> I tried 2.4.7:
>=20
> Sat Jun 26 07:36:39 2021 /sbin/ip link set dev null up mtu 1500
> Cannot find device "null"
> Sat Jun 26 07:36:39 2021 Linux ip link set failed: external program exited
> with error status: 1

I seem to remember you want to use "--dev null --ifconfig-noexec" and
possibly "--route-noxec"

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--cIntUtG6ibELK2eb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJg1wE/AAoJEB2Cnv7KVigSZtEL+wfg/HzSa8i2qa9ojKOLaHCP
6aK5libz65QvdQmVYVz8/mOqWLiRSwSkGfwKWeltrNUrKukA2l85SsILiQKP5fel
HFzFYbGNttPOUGr6yTxZzrov1ApZo6Ci+BxxoJQ9x9ODwDNFcLAMiBC+Sq54zTpE
LFsPvzutZTcN94BG2urg3WkdVwTM87pr3UofDVZVl8Go6z3rreR/FsKvEX0X1Nny
YQsAVHNat7tYL0LIrw9aZbTgjwMS6by+XUaCGtqDrKazD+SmwBLVu3nB7HLD/7CX
9xzBAO28qHoVK+gId7AQO7gMQU3Qt4959fLKxtSuRL5NFdHw7sVHxFq2jEQOD5Mx
+xcXMVGIeh+w8mYkHSzv9jRUtsH2fa5I9BcdWM3N4IabCQ3v+iCkxkNxDNTj1al3
KD++fofclxLom8xtTt5N7KsFE7LZq1jFgkzw4RiUhlhI+CQIUDlyksrd+YXA4WBi
e6ygwphKF2x8/FRyzfeohePyW+tuFypP1gR2qHFZjA==
=6o0D
-----END PGP SIGNATURE-----

--cIntUtG6ibELK2eb--

