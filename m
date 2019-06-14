Date: Fri, 14 Jun 2019 19:59:30 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190614175930.GH1097@...1296...>
References: <CAGyAFMV=HvOYDRSB7eRpBDp-47wX2vie8JPgp48in1fH+eXn=A@...278...>
 <CAFHpkQFVpN-+Uoc6QsLmD8hjwEC7Ba1Q2SP4SuS_EMu_PT=3nw@...278...>
 <7bdf712d-4e0c-0667-c9eb-1bdd862b1e40@...2080...>
 <bfead88f-3e91-6d49-ea70-e73f626468f1@...1147...>
 <CAGyAFMW10tUVswPa8NfVieUJMm1oX1BFQaa9a0GP3NmgWpRshg@...278...>
 <CAGyAFMWODccNnD+yby7HrOUfdDFaceC3AX70+jG9_hL9vF=q+A@...278...>
 <CAGyAFMUqqjF67DDdr+BQXvFU515_zK=fDehUJH1TF+zjyjuiAA@...278...>
 <CAGyAFMWaHBAR1fPVx5PUERg=JU9hg+mQMhtQExqpE_tHvevSAw@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="aSOv3uy5xJSQbCk1"
Content-Disposition: inline
In-Reply-To: <CAGyAFMWaHBAR1fPVx5PUERg=JU9hg+mQMhtQExqpE_tHvevSAw@...278...>
Subject: Re: [Openvpn-devel] Wintun performance results
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, wireguard@...2500...

--aSOv3uy5xJSQbCk1
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Jun 14, 2019 at 06:56:56PM +0300, Lev Stipakov wrote:
> ovpn3 wintun   1.90 Gbit/s
> ovpn3 tap6       890 Mbit/s

This is amazing indeed.  Now, if you do readmmsg() in openvpn3 for
the tap6 case - will that also speed up things significantly?

gert

--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--aSOv3uy5xJSQbCk1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdA+CCAAoJEB2Cnv7KVigS6BkMAJ0lMKm2Lm8JvLOm12/J5mrS
u+O48b8b4aZFl2PNIIEYHLJ1AG1/Ih80bC84mOyHJUxN0RqKL8h0QOOMfvvECgz7
q/7rxrduUnd7KPh46PTGcywjfZFnTEOoWL8NYk2BwZyHm0tOhQKuXr9Uq+U9o2O+
tXFfUKQjCxbAakaiwYtqnuZPRrdBZoLs833GXDxwjnJzUtMhvfisU1IZuilktT94
bPFW7bjrS1NIKmP/tuxErpO2l0/ffTBPJOLwe1lMoCH2Hq9bUWFzgwseZX4ffklx
Y06vSZVv3tuKamoFhuoJeSywJlQJ/8uocFrAnS6+SIc48XhKT4d1PUUg59k2HXe5
WJKRQ+N8mtyY0TDX8IRr3OdebfsQu6Wz2xcTRs7IklBGqOI9YAUom2gtAAiBsxuH
qFnc9t/nBkQC01ZoIT4Oe+50hc6yobt2ubdvA+y2ptlSfjs9VgfxJlkiOSJ81gSf
1FEDAUHYpvaNONW3viKDp49iZ1P6FbJBdRaN71zA9Q==
=Wx7L
-----END PGP SIGNATURE-----

--aSOv3uy5xJSQbCk1--

