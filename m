Date: Wed, 24 Apr 2019 19:05:16 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190424170516.GC31008@...1296...>
References: <62A0A577-3DAF-428A-ABC1-D6E062DA1D68@...1834...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="i57Ucs80xkCVE1Ce"
Content-Disposition: inline
In-Reply-To: <62A0A577-3DAF-428A-ABC1-D6E062DA1D68@...1834...>
Subject: Re: [Openvpn-devel] [Openvpn-users] Windows Service does not pick
 up config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Gstir <david@...1834...>
Cc: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

--i57Ucs80xkCVE1Ce
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

HI,

On Wed, Apr 24, 2019 at 01:52:45PM +0200, David Gstir wrote:
> After a lot of digging I found this merge request [1] that changes the re=
gistry
> entry the service looks for from "config_dir" to "autostart_config_dir"!
> Manually adding the "autostart_config_dir" and setting the value to
> C:\Program Files\OpenVPN\config got it finally working again!

"oops, sorry"

(We were told over on the openvpn-devel list already - in the end, the=20
wrong openvpnserv2 branch was packaged - this is intended to be used=20
with the MSI installers, which will handle the directory renaming,=20
config file moving, etc.)

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--i57Ucs80xkCVE1Ce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGbBAEBAgAGBQJcwJdLAAoJEB2Cnv7KVigSkxoL+IWSQAfuCqCUbhia+A4XOvh7
u0HeiK6FWY7OQg6HbGzGwkbj4nhNwS/BmOl6LxWlW1CZbUbVVYsNfTx+PUfQSlX2
K18qycmEA6FD3BbEe12i0ScddXb/GdU/RFh4QgxiyXWyRYc+qlHl4vcYOPCKjvM6
x4ASskpiB5Kbo/+32pdC/T3MVGToUSWvMj3kdZvgBP56KiJ/TICqkmG+iC22x9/A
ek6CaNY6J+VF5MAU7Ww8mcHfg5OXae7A5dQ+46nvSVlrRL/r05lc7YsJD9BkLibf
ICWadu7IeHZC23HfolkWr7vVo5rWCKab/1wqNw8Pis+Ow5z+tTf9JPxFlG+uZoCN
qsn1o+muehG1dWc4KlYbkYYkvz1HWCAfrkHTG7LRRzrN3S+24y9bepjBwYp4YhJ3
7Jb5QKwcWXV+fto3BDnBld4yQK7+F8cEVTpr7M4RocoJSznFY0zGZ7lY2S3/Rk0L
e1XCOLF1P0XFTad475SaejKk3O+DZ+Lrnb5kAHyy
=Ynn5
-----END PGP SIGNATURE-----

--i57Ucs80xkCVE1Ce--

