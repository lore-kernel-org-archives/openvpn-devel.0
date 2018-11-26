References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-2-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <f9bc4804-b75a-ec1d-fbc3-f2f09376b387@...1227...>
Date: Mon, 26 Nov 2018 13:55:02 +0100
MIME-Version: 1.0
In-Reply-To: <20181011184200.22175-2-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="f69SntdxfEn4xU2YANKvspJus3B1qrKaY"
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] implement platform generic
 networking API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--f69SntdxfEn4xU2YANKvspJus3B1qrKaY
Content-Type: multipart/mixed; boundary="9j2iIPdIrit9lN3lGpXEcE0qFTFZd0dXh";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net"
 <openvpn-devel@lists.sourceforge.net>
Message-ID: <f9bc4804-b75a-ec1d-fbc3-f2f09376b387@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/7] implement platform generic
 networking API
References: <20181011184200.22175-1-a@...2181...>
 <20181011184200.22175-2-a@...2181...>
In-Reply-To: <20181011184200.22175-2-a@...2181...>

--9j2iIPdIrit9lN3lGpXEcE0qFTFZd0dXh
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.10.18 um 20:41 schrieb Antonio Quartulli:
> tun.c and route.c contain all the code used by openvpn
> to manage the tun interface and the routing table on all
> the supported platforms.
>=20
> Across the years, this resulted in a longer functions
> and series of ifdefs.
>=20
> This patch introduces a new "networking API" which aims at
> creating a simple abstraction between the tun/route logic
> and the platform dependent code.
>=20
> The is API expected to be implemented outside of tun.c/route.c
> by using platform specific functionalities.

If I understand it right, the goal is to create a platform independent
API, Android needs either still hacks in the non platform specific code
or the API needs to communicate also

- route/adding addr before interface up
- type of route to add (android wants to ignores the host route to VPN
server and wants to isntall a 0.0.0.0/0 instead of two /1 even with def1
in place, the last one to workaround buggy Samsung code that special
cases 0.0.0.0/0 but sadly still needed.

Should we try to design the API right from the start to allow also for
these specifics?

Arne



--9j2iIPdIrit9lN3lGpXEcE0qFTFZd0dXh--

--f69SntdxfEn4xU2YANKvspJus3B1qrKaY
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlv77SYACgkQFRhsZwKx
RFTcsRAAgPaD7besGYGkomYkv7VtQ0DWaFoKm0q4mxCYqpn1VYnT5V4YS1hSciTO
tW4tdFE7wn9iUT4CkqmVR54sPD1oRFL2qgoosrz1YKzNT/YZkl1tpvWo6r5CLhNh
07lDPpgolqbwpU6NP/Bvj9EQ6XTfwgoNOXH8sSPW1I041tLVoe9qb8dPGSD4Th8s
Y0ju2dq6Lum4y9zzifpQygboclpjnDCvp43lzcb+snPObRTRPCglaLAwrLI4umM2
7p4CT9j28h9lzEhWO4DGwX2RDSvj5RpM4kzlTBVe2mk20XwDjvW9eABmauzeO732
hzVgfAjxkGfXePQcIT1oxHoYOmbzih9h0HFb5GY8LHKizna4k6cvDsLLvDjV33NM
7X/TYIQR+Nj3zM2sEddmouEahQDDCUW0639DiVL3Re46kqC7UVwjOA3ZPINdJc1+
q4QWlqJeg+vMmOX4g3oAKawQjkkZacKLHhSL0gGJZ39tKNMhxTSDrRNqOa4HHipW
VDf9xppSedvpoj05TdkKaDqhYNzLWX69v23KcScoVDdhQ5FX4aqlofIi/yksI3fF
dBKFT3U3ksTdbyPP3/NsE4rLM7iANsc8v22LNGH8J2UCPjpoPh6bIpEUMn+qr3yh
9qrA7CEa7UA+FdjvkqfnMOS/ZP/lSDXjmqpfHxLAJlun1lRgQMo=
=AK5q
-----END PGP SIGNATURE-----

--f69SntdxfEn4xU2YANKvspJus3B1qrKaY--

