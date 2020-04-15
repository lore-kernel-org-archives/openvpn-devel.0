Date: Wed, 15 Apr 2020 19:53:45 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20200415175345.GJ1431@...1296...>
References: <20200220181951.7603-1-davids@...515...>
 <20200220181951.7603-7-davids@...515...>
 <CAKuzo_gHWD_NZgvFimbJaGjv3MKksaFYRZZ+8UUmmVq9o7csQg@...278...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="ZzUOW8XMJcqpOSAo"
Content-Disposition: inline
In-Reply-To: <CAKuzo_gHWD_NZgvFimbJaGjv3MKksaFYRZZ+8UUmmVq9o7csQg@...278...>
Subject: Re: [Openvpn-devel] [PATCH applied] Fix possible access of
 uninitialized pipe handles
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: David Sommerseth <davids@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZzUOW8XMJcqpOSAo
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Thu, Feb 20, 2020 at 07:21:24PM -0500, Selva Nair wrote:
> On Thu, Feb 20, 2020 at 1:20 PM David Sommerseth <davids@...515...> wrote:
> >
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA512
> >
> > Your patch has been applied to the master branch
> >
> > commit 32723d29b2775d63d3fe329d017e7a08e0cdcb72
> > Author: Selva Nair
> > Date:   Wed Feb 19 20:56:43 2020 -0500
>=20
> I think this and next one could also go into 2.4.
>=20
> Here are the commits, in case
> .
> 32723d29b2775d63d3fe329d017e7a08e0cdcb72
> e1f7d7885752ac3a0279ecc7e31ccee2af40fbe4

And so it has been done - sorry for the delay (and feel free to remind
me occasionally if things seem to get stuck).

I have test built both on Ubuntu/MinGW, and also done a cursory "does
the commits look reasonable?" check - trivial enough.


commit df5ea7f1b87012414d2625d1562715887ad1686d (HEAD -> release/2.4)
Author: Selva Nair <selva.nair@...277...>
Date:   Wed Feb 19 20:56:43 2020 -0500

    Fix possible access of uninitialized pipe handles
    (cherry picked from commit 32723d29b2775d63d3fe329d017e7a08e0cdcb72)

commit 1d9e0be2a7733b0efb0556d187a36912606a9d97
Author: Selva Nair <selva.nair@...277...>
Date:   Wed Feb 19 19:49:37 2020 -0500

    Fix possibly uninitialized return value in GetOpenvpnSettings()
    (cherry picked from commit e1f7d7885752ac3a0279ecc7e31ccee2af40fbe4)

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--ZzUOW8XMJcqpOSAo
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJel0ooAAoJEB2Cnv7KVigSnmUL/2FuC7xamhlYPNDnaMYGRSmF
tkRYNAX+oubTj8ZGKqJ3az74+XnEu8uqlvXY+V3JRtLjiLgHAsGP2oiRl8U9Koda
P0vUAjMWes2bGUOwuEx+IIT4566Hjo0g6cQy2GR6DBCdS3HKzz3SSGy66LrL9E5m
Ig+fN3WBRBacuLNOIiohj5+8ayKoAkYcNgKrioW5s+VGbq7S1pj07PZhUdnLqICF
yB+Fyjhn9xgcUL9xuY/qFOmlXl0fBm6Sr3H5WnHrdoSkgbjP79oM402b0dhU8swa
OvRLmxnIhUj1SESvi6oOYRXrHFxvma9yxXr1soKZ2+PGEYUepNHCtmf7JOIN9vNM
aKHqsyexvrML1jPtsXIfBKqMPsE57kOCvskJwgPH8a3uiqkuam0p8lbMEfEd34ki
JuFS/CA86fS9uTfuZyFUcEUg1MkwsS+EoDA0KXlpf/ARkw48pnDxiiBu3nhWodmd
hQKe5chTuGyAcUhwmuDfu5TAOkrfam50DpNWQNapJg==
=AUsi
-----END PGP SIGNATURE-----

--ZzUOW8XMJcqpOSAo--

