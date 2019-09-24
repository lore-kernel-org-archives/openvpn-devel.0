Date: Tue, 24 Sep 2019 23:36:49 +0200
From: Gert Doering <gert@...1296...>
Message-ID: <20190924213649.GH40538@...1296...>
References: <20190906174458.14975-1-matthias.andree@...68...>
 <20190906174458.14975-2-matthias.andree@...68...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="o7gdRJTuwFmWapyH"
Content-Disposition: inline
In-Reply-To: <20190906174458.14975-2-matthias.andree@...68...>
Subject: Re: [Openvpn-devel] [PATCH] tests/t__lpback.sh: Switch sed(1) to
 POSIX-compatible regex.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Matthias Andree <matthias.andree@...68...>
Cc: openvpn-devel@lists.sourceforge.net, kevans@...1249...

--o7gdRJTuwFmWapyH
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Fri, Sep 06, 2019 at 07:44:59PM +0200, Matthias Andree wrote:
> --- a/tests/t_lpback.sh
> +++ b/tests/t_lpback.sh
> @@ -26,7 +26,7 @@ trap "rm -f key.$$ log.$$ ; exit 1" 0 3
>=20
>  # Get list of supported ciphers from openvpn --show-ciphers output
>  CIPHERS=3D$(${top_builddir}/src/openvpn/openvpn --show-ciphers | \
> -            sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^\s*$/d')
> +            sed -e '/The following/,/^$/d' -e s'/ .*//' -e '/^[[:space:]=
]*$/d')
>=20

I wanted to test this across our zoo of funny platforms - namely stuff
like "OpenSolaris" or "AIX", and did not find the time yet.

To my amazement, all platforms seem to support the [[:space:]] notation
correctly, at least the output of

  openvpn --show-ciphers | sed -e '/^[[:space:]]*$/d'

is correctly relieved of all empty lines.  Even AIX.

Thus:

Acked-By: gert@...1296...

will merge tomorrow

gert


--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--o7gdRJTuwFmWapyH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJdioxxAAoJEB2Cnv7KVigSFMcMAILPAeDMEU7Fl4ZCK2XbVeXc
NOKN8xKtT4IF/wHn3XNqOAIkiCcFl2cm+PsVydEOc9pEjXqw8zR3sDKwU9riXctG
amnO+rOl/Fv/rQn1GQokklaQ5NELR58/0xCUj0/k3qEvuUAjM264TkPOgb1++/X1
NXfVi5fEjaIo5TyNbgVy5PzcnmYZlUbk/+KMM92iriGRn4lt7dfDzKjPnrn62vWs
mtwyNA1p21Kq2xPUpyojt/QgNCufeLM+JRbSLkPMhSWj4qjmzc7ay5Kdp+6PQic3
2LynP/wlRw2FSwOyx75/XKpHZal7vbtDP7weCl5n3HiLpYMaW0Z6yfF3cFb57NzL
aQFxvpNdVkYZKGVz2OcNN/eg5+d6kWRph9vN2IR9sRdF8S8dOuIVp4sKwYmcb9OS
hHBiRHD/IyoKm5+xQ7ri/niwyy+QXHL8xB7JHugxFo7ia9t6R5Iu3ZEzqdE+2WE9
s3mJ9j+fEaV5KLRqMJQWQIs01NepROKqg1iGsME+zg==
=sHYh
-----END PGP SIGNATURE-----

--o7gdRJTuwFmWapyH--

