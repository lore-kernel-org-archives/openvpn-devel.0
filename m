References: <f98cdb16-55ce-b4e6-13de-163c5f352cdf@...2553...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9adbbf1d-0f9f-ef78-a7fc-2d54974d12a5@...1227...>
Date: Wed, 8 Apr 2020 23:37:29 +0200
MIME-Version: 1.0
In-Reply-To: <f98cdb16-55ce-b4e6-13de-163c5f352cdf@...2553...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="sBSajNN9qo1e2yJJmTZILx7BvoYFvHkBk"
Subject: Re: [Openvpn-devel] Openvpn3: hardware address of connecting client
 not being reported on Linux ?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Bruno_Tr=c3=a9guier?= <bruno-sourceforge@...2553...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sBSajNN9qo1e2yJJmTZILx7BvoYFvHkBk
Content-Type: multipart/mixed; boundary="m0e489mwa0fNqx9sLvmxFytOG86x9cvzR"

--m0e489mwa0fNqx9sLvmxFytOG86x9cvzR
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable


> But it seems that on a Linux platform, the different #if, #elif and
> #endif statements lead to a situation where almost all code is excluded
> from compilation, and an empty string is returned at the end of the
> function. So in short, nothing seems to be done on the Linux side, and
> so the whole thing simply cannot work.
>=20
> Is my assumption right ? Any clues regarding this ?

Yes. Mac address reporting on Linux has never been implemented. If you
look at hwaddr.hpp you see that there is no code for Linux.

IV_PLAT_VER needs to set by the UI, same as IV_GUI_VER. The UI can also
override the mac address that is being. This for example done on android
as implementation for the MAC address.

Arne


--m0e489mwa0fNqx9sLvmxFytOG86x9cvzR--

--sBSajNN9qo1e2yJJmTZILx7BvoYFvHkBk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6ORBkACgkQFRhsZwKx
RFQRTQ//ZtVuk/sIY0GnXPaqfAKPuE1RaZBsmLZTGBEHTv2g1oyfGSwLiEX8vhGm
wIal58o5IuDRPEPERABRDgNxF+vJTKdZ6h4SFWG89ef0oy5YN8lYBJttGNjy84gh
KTx1/qurjBQ0YAEMp9dv9nMNxWb1rC5WjetxfUMARWy1CtXW/9MbjNqnUXjWC/gR
/K9i2ZtAmtr3Zs9+sHHnd5lqEM+HHUtpSI4cD/I1w4Mdvt8QjBPBI7wx8GknWcxE
Liu+FLTz4ehmgSn1aZm7TFCbaJ4wgAM5TtYk6xlkgAVN3Nh2c5T4QYtahiaBkiaZ
G+bXtDRfyqSQ9c6ir6G3NGivVZDOMyb+4AEe8yBB3sHTf8L5P7hGguNih3k/Ic3i
rcXmbd7AndQw4FoVGtUV9d6T7r37XfsjpTfFesu/lZ8w2sUx/N2nn2+sH9KYB+qo
8lBqwdoIUYV3UluhpU+Ck34e+2G3r20SJRjb4N9rG8ZqQBQnxB0FkSnfn9+q/Srt
kBitnnDeFytzwG79xcB/R2SV+oW5TWDBqqvJiWWqf6nSF0wQeMGohi/j4/siL0bf
CnRNg9Ca6cy9CDeMGZQ4Fy7hGtQVALGE2UmGE/saGBo+6Po+Fguzrh4tGpAwjcwM
8BDqetN6UR/GHwJTsRcomYD4CtkzmdvZyKCVTo9tn/yQ7NZJFPg=
=m5dL
-----END PGP SIGNATURE-----

--sBSajNN9qo1e2yJJmTZILx7BvoYFvHkBk--

