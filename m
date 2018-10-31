References: <20181031160124.26972-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <5ae92bd9-ccac-d4df-f27c-eb567464d145@...1227...>
Date: Wed, 31 Oct 2018 17:34:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181031160124.26972-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4cQCkZ7SQmLtihq6GAeE9rXC9u1tgDrJU"
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: properly cast time_t to
 uint64_t
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4cQCkZ7SQmLtihq6GAeE9rXC9u1tgDrJU
Content-Type: multipart/mixed; boundary="0KGMqcpVHGwyciNpPUUqL1HqtAoy0HJtU";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <5ae92bd9-ccac-d4df-f27c-eb567464d145@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: properly cast time_t to
 uint64_t
References: <20181031160124.26972-1-a@...2181...>
In-Reply-To: <20181031160124.26972-1-a@...2181...>

--0KGMqcpVHGwyciNpPUUqL1HqtAoy0HJtU
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 31.10.18 um 17:01 schrieb Antonio Quartulli:
> The exact type of time_t is platform dependent and therefore
> can't be assumed to be uint64_t all the time.
>=20
> For example, on 32bit platforms, where time_t is defined as long
> (32bit), the compiler will generate the following warning, due
> to the arithmetic used in the macro:
>=20
> tls_crypt.c:745:29: warning: shift count >=3D width of type [-Wshift-coun=
t-overflow]
>=20
> Force time_t to be parsed as uint64_t.
>=20
>

ACK. Fixes the warning on my Android build and looks correct.

Arne


--0KGMqcpVHGwyciNpPUUqL1HqtAoy0HJtU--

--4cQCkZ7SQmLtihq6GAeE9rXC9u1tgDrJU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvZ2awACgkQFRhsZwKx
RFSQ3RAApu+A1CATmg66N4Dbo4DLyO+cYxsmf7ZLGpapRHMVD9RKFTORiiSB7/VF
sV40uKM7DDDm4u2Vpf+2XSnAuFQTM6NW0q/k33UQOev+Rrsx0363ihtCMEHu/x/Q
aWAosOP690/GqOM7FYBI6B4ZA71x4Lspm670OhW5A6D5eh4FV/rZRbQ388ozoFm8
YLPwIYN7tyj1kUmLk+UwkFv6Q31Jg2xYh7lbQM4qXCjWGuGzmLubumNVsdBEZFHv
vDDK7eXdm/hKZXli9g266K28sz7iaQolO271bgUWQc64P8+XqWC5uoii+p6dRj50
TTsM+II63LJ6AwCYwA55lrq4ZfvYFIRQM7S71SsP+jzXsqQluNVhfJhf/R/yKY+S
UWB9zQIi5SvQKzXoca+fjNhDNenPjIS1eEzrwitPfuuJPgE2oPkZ/j6yYxdVMC80
IwnNw2EIEvE5V53ojy7c07n0bd6WaSonI/gWrN9i8r6HjvVOhQxBC/v5JicTwerc
hqJ5RGtWZaz/VGXXnb0xJSKUhQ+gaFiHjcPiVP0uaLc+6llb7w5jPC9pWBfeLqro
4cD4qEe1UjkMe9d78ATzdiZ7TVRT2MPqNRrpDMQWQFX++PUGdtExwuHgXnsF3XsI
oK6YWQuWf++NfUoXzbbR1IGxSBmPiC1lwuj9//c5EM+UAOs3S9g=
=mT6J
-----END PGP SIGNATURE-----

--4cQCkZ7SQmLtihq6GAeE9rXC9u1tgDrJU--

