References: <20200706163516.11390-1-arne@...1227...>
 <20200706184313.GJ1431@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8d332150-52e9-a357-9ab5-7478d1afdcaf@...1227...>
Date: Mon, 6 Jul 2020 22:28:29 +0200
MIME-Version: 1.0
In-Reply-To: <20200706184313.GJ1431@...1296...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ne2MYcH7LY138ErC8wZN8PZFa8APS4YXS"
Subject: Re: [Openvpn-devel] [PATCH 1/2] Remember if we have seen a push
 request without async push
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ne2MYcH7LY138ErC8wZN8PZFa8APS4YXS
Content-Type: multipart/mixed; boundary="fRR0qjt3y3TQZTKzrgHcl8x7BlFcBkjwi"

--fRR0qjt3y3TQZTKzrgHcl8x7BlFcBkjwi
Content-Language: en-GB
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable

Am 06.07.20 um 20:43 schrieb Gert Doering:
> Hi,
>=20
> On Mon, Jul 06, 2020 at 06:35:15PM +0200, Arne Schwabe wrote:
>> The logic if we already have seen a push request is still
>> correct/useful without async push. I am not entirely sure if also
>> deferred management authentication can trigger this code path but
>> it should be able to. The other benefit is removing a number of
>> ifdefs.
>=20
> NAK.
>=20
> In combination with async-auth (plugin) this triggers some sort of
> key inconsistency - the client does get the proper PUSH_REPLY, but=20
> key state is kaput

I will double check the patch but this might be that this code path is
broken with async push too, when you do write status to file and do not
close but wait for openvpn to pick up the state itself.

Arne


--fRR0qjt3y3TQZTKzrgHcl8x7BlFcBkjwi--

--ne2MYcH7LY138ErC8wZN8PZFa8APS4YXS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8DiW4ACgkQFRhsZwKx
RFTmLg//ZwabjArE8m//FSxIA4Km/44nSWCfUOu1sqJj5d27OXvNAigrnlAlLRlY
I2DuxhXM97I7SiuS2FwcdzNJCU+kTBRZNkpdcdkYdcej3R2F+331xufz/gz32dW5
qof/AyT3rmwn6J8R2sZsoSaYO62DGdbkXDwYHl7o/xGI1SEX8mdUw9QRVky5DeQe
SdGtl+yIx23XSj29ZWC1VYZFMy9vX6VapAXi0MVlpQbrsDdeTMZHYZGKJLO2FTo4
RVhVpOuL8m3pv1FklOGZ4DIjieCmSJKabDkiLd0spLvYK/cyFlt3/l0n3u+Y55v1
5kYhetpopxaPFJabzTfnUsE2uml4w7Dc2Kt7CHcnYoHgOa/BQ1OMbQlCQDEo8T/W
aX+Z1m/vOAVhPcl1cQKKd3UNWqhxMkYUxNZLsUQgMawtfCMQrRF7opUYDaSj9AbP
fh+8T0IZErHBavqwC7s4TGmbDjL16mQpEeegKU0otj3jf9dhbJN9MDUfViw3fEwV
qoxC1uJyrWDvMQmvYjVTK8c4zeQzzUsI3WOIrjmZ0C2h8+Rk9RR5BVAHasoXbmX6
udLu8/w39/WSE3OuMIJHd0It3Zno/sr9kFKoY//QEH3vvMBO5cl82AFIYaHtn7Da
2XcRTYGNXpCQzelG+9S0rkUkXyXI7KPjh6roLvzz/TRZSmE+ZSE=
=SPzZ
-----END PGP SIGNATURE-----

--ne2MYcH7LY138ErC8wZN8PZFa8APS4YXS--

