Date: Thu, 30 Dec 2021 19:54:10 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <Yc4AUo1Nb64WYy8+@greenie.muc.de>
References: <20211214150901.4118886-1-arne@...1227...>
 <202112301638.1BUGcEMp081228@...2054...>
 <b421c495-f4ac-f85c-0493-32d4cc835978@...1227...>
 <a44c2a5c-8ed1-80a3-79c4-3131d6015963@...1856...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="IsMmUffVO4W/PCw1"
Content-Disposition: inline
In-Reply-To: <a44c2a5c-8ed1-80a3-79c4-3131d6015963@...1856...>
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Decouple MSS fix
 calculation from frame calculation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net

--IsMmUffVO4W/PCw1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Dec 30, 2021 at 07:16:25PM +0100, Steffan Karger wrote:
> On 30-12-2021 18:28, Arne Schwabe wrote:
> > That BF-CBC seems have an extra 8 bytes that I somehow missed. CBC is a
> > odd since it always gives you a multiple of the blocksize (64 bit or 8
> > byte) and if you evenly divide by the blocksize you get an extra block
> > just for the padding. I need to reinvestigate that code and send a fixup
> > patch for it.
>=20
> You probably know this, but for clarity: this is how CBC padding works,
> not just for BF. It is easier to trigger with BF though, because of the
> smaller (64-bit) block, compared to AES (128-bit block).

The comment in the code acknowledges this :-) - but the math seems to
be not quite right.

We've tested with a few different --mssfix values and BF-CBC + AES-CBC
and packets (UDP payload) are consistently up to 8 bytes larger than
ordered...

18:34 <@plaisthos> I think I am missing the rounding up to blocksize step=20
18:35 <@plaisthos> I basically handle the corner that you do NOT round up a=
nd=20
                   get an extra block but I completely forgot the rounding =
up=20
                   for all other values
18:40 <@plaisthos> I will look into that CBC thing later, that needs more=20
                   testing than just writing a small quick fix

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--IsMmUffVO4W/PCw1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJhzgBSAAoJEB2Cnv7KVigSY1YL/043Ly775ww4KNHn3rFw8qiF
hw/1VxeabznjOGS3dubV8a392OulFDCsAo0iD5xLHr/8sMTdXcK9tTkUWx7Wsaz8
w+l4EQonnr+xaHSgfQDPrCGe9PmR6T6nR33aAo7J6ChYhHathb5NajKPFM1t7iVl
2pmln1qfHd9xuvLn6RnFeHn80pcW3opp3oF+NORNOsgBcUt33rnoRK1rbCrEEFbj
oPJJ0hM9snpPvr4WnQbM5PikarcQpPz86cVXlVC/h3033QxkWa0A+94DQm+146PV
YT4J0eXpWlsg6uTTeCIJyY5VjJi+TX/PKEoRwJ+ZTO3+CGRoxLN6YZHEZ6XgOp3A
+5l9oY7ZLLyxUX5asfYr62ltyK3WZSjpMnrqc42HkGSx5SKMMof9YnS/Lmu/S2f3
DyTMwE/ddAuuj9HV8I3qBm0AE84vtM0vRcxidFYWiJ/Tu/QH96KL0OYHodvVjNFo
+YLJofZ5HOsxAjPAnxyhNokQen1gNMV7LRx5Pe4k4g==
=MC00
-----END PGP SIGNATURE-----

--IsMmUffVO4W/PCw1--

