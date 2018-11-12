From: Arne Schwabe <arne@...1227...>
References: <1d93843c-6fe8-1a60-28fc-c013a57877da@...2181...>
 <20181029172040.17034-1-arne@...1227...>
Message-ID: <cb0fcc63-f17a-1112-2b7f-a02ad77930b1@...1227...>
Date: Mon, 12 Nov 2018 14:35:27 +0100
MIME-Version: 1.0
In-Reply-To: <20181029172040.17034-1-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hMwobTNxJySd3KGrAh2P9D47HDBYnfROF"
Subject: Re: [Openvpn-devel] [PATCH v5] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hMwobTNxJySd3KGrAh2P9D47HDBYnfROF
Content-Type: multipart/mixed; boundary="AiR7bGoiRLyXlLtV4oqIVP9Ebzz7feogj";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: openvpn-devel@lists.sourceforge.net
Message-ID: <cb0fcc63-f17a-1112-2b7f-a02ad77930b1@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v5] Implement block-ipv6
References: <1d93843c-6fe8-1a60-28fc-c013a57877da@...2181...>
 <20181029172040.17034-1-arne@...1227...>
In-Reply-To: <20181029172040.17034-1-arne@...1227...>

--AiR7bGoiRLyXlLtV4oqIVP9Ebzz7feogj
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.10.18 um 18:20 schrieb Arne Schwabe:
> +#define MAX_ICMPV6LEN IPV6_MIN_MTU

This should be

#define MAX_ICMPV6LEN 1280

Antonios suggestion of using IPV6_MIN_MTU works on Android on my linux
test box but breaks on other Linux machines and FreeBSD does not even
have this define.

Arne


--AiR7bGoiRLyXlLtV4oqIVP9Ebzz7feogj--

--hMwobTNxJySd3KGrAh2P9D47HDBYnfROF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlvpgb0ACgkQFRhsZwKx
RFRgtw/+IkMqPAPhSMCxSNQMP/k4YwaamAw5Iob0bLnvBPXCsSlpPPpOslnm/F1l
nDT2zR4kXbtGylGrOqD8U7m9ZiNcqvWWM3ijVx9pc1iFHNci0kKy+lBeAO0pm1b6
bsiOz+F2JnqTIo20XCsjPrUqApyXfwGsQtTO+1jqP3Liv6rVmDcIzAyS0Sb1Heqy
dOLwbOD4yGxJUilNoC/nxMIuaz5oLpQjr4qVpabHDjSbHT+B4daqnjyCVAMhNX3R
kdMTMTB2qPvCSg7UKQlmL/QhlkQ0Y4IxZWzn3lXX+ykhuaNcXPWaPE1vhMhxfxso
ccIn9H3gje//u2Q6Mt+8zWT8T+Ap/EumEAKnN+ydt/KYXmOuamXPIrVlAU473cP6
R47VNW90ZOc7ktzp1RFUG0C9FboKfNDKlKs2ICQlpMcnPn1YYxglrKJpSYykeUJr
pc0BvkbPJBS/ajY1jIRFuzEWslkUevQ08X0c1oSxBkprdBcHagOeWB3lQ3L5QONy
F+hcqYev3hShXt0rWaXBoRTzJZ6NwTaHN5jXwBiIYO+uWhUGwgzP4LZaRQyEjKuD
OKe4qiLIf8eE8q71o8ofgjT6SmB/rYvoPgTBb9edqHyjT4kOZxGe++v/GAkxbQAA
uraRJlWhAWs5wNnKNEx3E0BJRaw3GUH6Ei+DxpgUzD3IjEhDvfk=
=zPp4
-----END PGP SIGNATURE-----

--hMwobTNxJySd3KGrAh2P9D47HDBYnfROF--

