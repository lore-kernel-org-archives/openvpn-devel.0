From: Arne Schwabe <arne@...1227...>
References: <20200717171036.20687-1-davids@...515...>
 <6062d64c-14ef-0e0d-4e83-925b79b4900b@...1227...>
Message-ID: <7030cf8b-d047-107d-21b8-f02c8a1338c9@...1227...>
Date: Sun, 26 Jul 2020 15:31:24 +0200
MIME-Version: 1.0
In-Reply-To: <6062d64c-14ef-0e0d-4e83-925b79b4900b@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="OiCxWH2BLziKePW12AQTLqOyMqutfM9x3"
Subject: Re: [Openvpn-devel] [PATCH] Remove --no-replay
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
--OiCxWH2BLziKePW12AQTLqOyMqutfM9x3
Content-Type: multipart/mixed; boundary="P0XKd6fnSAkou4v7q1iModQG4cajZLWjF"

--P0XKd6fnSAkou4v7q1iModQG4cajZLWjF
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 26.07.20 um 02:01 schrieb Arne Schwabe:
> Am 17.07.20 um 19:10 schrieb David Sommerseth:
>> The --no-replay feature is considered to be a security weakness, which
>> was also highlighed during the OpenVPN 2.4 security audit [0].  This
>> option was added to the DeprecatedOptions[1] list and has been reported
>> as deprecated since OpenVPN 2.4.
>=20
> As a side note, removing this feature weakens the ability to use OpenVPN
> is a pure tunnel without crypto (--auth none, --cipher none and
> no-replay) since this removes the ability to disable replay proctection
> when no authentication is enabled. (replay protection without auth is
> silly as a attacker can just fake the replay id too.)
>=20
> Acked-By: Arne Schwabe

I given that a bit of a thought. But we need to decide if we to support
unencrypted transport only session or not in future. If we do not want
to support them, then applying this patch is fine, otherwise we should
restrict disabling no-replay to --auth none and also --auth none to
--cipher none basically:

--cipher !=3D none =3D> auth none and no-replay forbidden

--cipher =3D=3D none =3D> allows auth none and also no-replay

--cipher none and auth none, warn if no-replay is used that it does not
prevent replay attacks. But do not fail since we would break a lot of
setups.


--P0XKd6fnSAkou4v7q1iModQG4cajZLWjF--

--OiCxWH2BLziKePW12AQTLqOyMqutfM9x3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8dha0ACgkQFRhsZwKx
RFQ4VA/+Ih3jPDK0/quSmHjWHK7o/QDikEMDtALbNDmNErxHrQEpZy8jsTsj6Fdi
6CNsVEPbtpFagjbQvLsYetzfKO5fz84n1LEldYkvATueEPNlcbdiaEFnB4eJo2UG
6eBHCzSH7HsNhYs5EzCggsaNaBd9KYAKHj7VScyGnD5vjGgQa5VcZvNE55BSINfO
8qzP+yT7yY33k1jqRyUXe/FtV/RzQc+dX+IkNzsrt8LMEfcI7bm8vAcYHSkaBOGR
Wdg6q97VCps1QEOrXBXzdpO252duJQy9S4DNfxfqUitq6Q5GC4Wv2xKPGftElrPW
AKtPsvqfxZ8HsoeBTPml9N0qwuB1KgbvlC/WVRBg9Zi7g7GUZ8OOf9UC/RVddeCa
H14M0j/F4u/pSdTJ7UcnSsCHYIRu12/oye4OyJKJbBh2itZ6vyl7UQnvriKUYiZQ
0hQF5s31J9GP5b1TSA+aYqnW5JwCApdGaYy8G//Y3dx37qldZerzeLVMDGWr9aRl
7Y98HVng8Cuck95bXHVrZLmPxmBEbM/tnnYtvUUL1OfMYt6Ysdiu4pFdY0nyMFOT
2bA9C7xhX+QvzPbbAJvu3YrWmeLg0pJhkrIblowNtwQXBq0sjFm3ZOWbF94HNlFV
Df0Z9GRFMLApmiKnxiqE44hW6frYbyPpHvwYq81V3QQr0u3ZHNM=
=oX3I
-----END PGP SIGNATURE-----

--OiCxWH2BLziKePW12AQTLqOyMqutfM9x3--

