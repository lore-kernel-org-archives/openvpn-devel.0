References: <20201001154658.9798-1-davids@...515...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <346aa358-47be-2563-a75c-3ef81b3a5e8f@...1227...>
Date: Fri, 2 Oct 2020 10:50:11 +0200
MIME-Version: 1.0
In-Reply-To: <20201001154658.9798-1-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rAp7u7mD9FhgQMbhB9FqBrdKqcJScCwPS"
Subject: Re: [Openvpn-devel] [PATCH] compat/lz4: Update to v1.9.2
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rAp7u7mD9FhgQMbhB9FqBrdKqcJScCwPS
Content-Type: multipart/mixed; boundary="YfuHqH0eVQ6oeNvYETZE4mF5TL0MVU9wG"

--YfuHqH0eVQ6oeNvYETZE4mF5TL0MVU9wG
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 01.10.20 um 17:46 schrieb David Sommerseth:
> It's a long while since the bundled lz4 library has received an update.
> It pulls in a lot of various fixes and enhancements, some of the changes
> fixes compiler warnings and hardens the code a bit too.
>=20

Ack for release/2.5. I double checked that the file is identical (modulo
compat defines) to the upsteam.

I think that this file is outdated so much shows that we do not really
care about compression so much. Also since we included it, lz4 libraries
have been available on all major distribution and not having lz4 is not
as problematic as before. For master I would like to see this
compat-lz4.* removed instead of being updated. For the 2.5.0 release it
is too late to remove, so okay for that.


Acked-By: Arne Schwabe <arne@...1227...>


--YfuHqH0eVQ6oeNvYETZE4mF5TL0MVU9wG--

--rAp7u7mD9FhgQMbhB9FqBrdKqcJScCwPS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl926cMACgkQFRhsZwKx
RFRxtRAAlyhXjkAXEM/SGzBJ77vc1T73Urkjt5PxHS6trAqn9ERl2D0CS9A8wmDH
WeMqdwLKUHxBPgUkNaA/51w95fvsFkHQlyzTKYHEddzXyzpE7q8P638Bc2ONJJM2
unHqcT9qinMQdSwSAGTmdSmHPoFYaShKK/vpUb8q4D63BXlXd0556P2iuKgKMH2f
Ax6DsoGi1aple0BQskNW1DAL1y/GsCncBDDzaToasulfca7yUGG4azla3xTmqYut
Twqe2Iuu8GnMYACFNS6kvJ3uaZ+AKQlLWRxnbFCe3R11AbYE9poAZXnPXWhtwzEP
tFZJSb/+QYCTgC+JHIWV8RC3A9qbceUHqALbitTpcdaVcb6wkDSKg0pfjphKmgwl
f0bLy+C9mtmc8AZZ3Jxv/lRQi4kM/td6Zhezbmru9QBNsuZEL/IDGtxrz94PBxAE
dCR032dU8nSUBuY46eJ4oSprKhXpaaj3vhfzlRUmlLiki0DzVdfS9ZZApo2bT/XA
VKApuNrqwmgby++qHUsU40V41OYN/r/JzL6qIAAVuBGh1f3LGmaCDA+DgjqoD67V
NpCE+fEs0lqu/0f0L/vPSYXFKYkv+7KEa/C1tH7P4rdleLysJYaONv53EKeLLRWO
5hK4odeP1NdzzudHOFgs22okNsGaUBLpypfwKlyHLOrlxB2QdNY=
=OQrD
-----END PGP SIGNATURE-----

--rAp7u7mD9FhgQMbhB9FqBrdKqcJScCwPS--

