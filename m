Date: Sat, 29 Jun 2019 20:32:33 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190629183233.GX1097@...1296...>
References: <CAKuzo_j6F2+_JxosdVF3iB4kzWsR7Wq2FT8Vgi9Cg3yvT_A1JQ@...278...>
 <20190628210334.GU1097@...1296...>
 <CAKuzo_ji9qNyc1vtQRhuuuYXgmpb6Qey2+L7GRqbhLNqbSwx9A@...278...>
 <20190629095732.GV1097@...1296...>
 <CAGyAFMVxD3+jZ+RR_U-x46Z89DV-feqyXcV599=SaogW-0Qgsw@...278...>
 <CAGyAFMX8247tuQB7eaKFJiOJS+tXOiu3eMv5RJU6ZZmkugjeNg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="XmBYJ+PaUOdJeGy2"
Content-Disposition: inline
In-Reply-To: <CAGyAFMX8247tuQB7eaKFJiOJS+tXOiu3eMv5RJU6ZZmkugjeNg@...278...>
Subject: Re: [Openvpn-devel] Using AllowNonAdmin in the advanced options of
 tap adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Selva Nair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--XmBYJ+PaUOdJeGy2
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Sat, Jun 29, 2019 at 05:50:24PM +0300, Lev Stipakov wrote:
> That --allow-nonadmin functionality was included into commit 3c7f2f553 fr=
om
> yeah 2005. Here is code from tap-win32/tapdrv.c from the same commit:

Sounds like these bits were lost in the port from tap5 to tap6 - which
changed quite a lot.  So possibly a "what does this #ifdef do? nobody
enables it" effect caused the code to be lost.

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--XmBYJ+PaUOdJeGy2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdF67AAAoJEB2Cnv7KVigS1QkL/3wbo1IbhcGuFCfBTujRkUdL
VluNJS84qwG7RdyubVjjrRjSgRT55E8qXzXiAp+OBP8sC88jtb01mZrgPvKAK9/x
5nrEMdzBiWsuS61a5CgR84cs83UULRdPtZD8l0pUfXxODkNbPqoBFc+Xhc+HgFFH
miHhKFxI4qdbALFQmejgFoyHkGyTEjuVTHZOgtsBkUReWYAsM04vYBORbo4X1GFU
3aurfwMnbqbhVA2EEsW4d7TP1LDYEeWaxeyfyA/Zwe8idF21+o+Arx8J+XLxB6sA
+NJhVk6mBGf0fH32/41q/piCSuID+FP85E+i0vCr1QTfs4tLuhWtbVR5fx5LwTgW
jyXo8k+Nt9G+FeWJ9gNb52bqwngBP9uko3nLyg/cmRyXbFh1EUbVpFil4N89gj0w
EOID7ZNaJQvTUI7Vgzb8IGOJ0CF6eP1rc+/ZLlktgsEXNsYZVH6gUnyUiKJ4kzge
tfHwYxbi8izTIDhYVVt39XMmkR/6mQFy3Jgf9Peb/Q==
=S5EO
-----END PGP SIGNATURE-----

--XmBYJ+PaUOdJeGy2--

