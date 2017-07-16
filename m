References: <20170716082207.23646-1-coroner@...2290...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
Date: Sun, 16 Jul 2017 16:47:10 +0800
MIME-Version: 1.0
In-Reply-To: <20170716082207.23646-1-coroner@...2290...>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="1VoFNpQvAlwOI6SvUSvPxWWC1wg6jHpbD"
Subject: Re: [Openvpn-devel] [PATCH] Support server cipher preference
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Szil=c3=a1rd_Pfeiffer?= <coroner@...2290...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--1VoFNpQvAlwOI6SvUSvPxWWC1wg6jHpbD
Content-Type: multipart/mixed; boundary="InuLtPNoJGoeqRgcGgNokHxobMuuscpCg";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: =?UTF-8?Q?Szil=c3=a1rd_Pfeiffer?= <coroner@...2290...>,
 openvpn-devel@lists.sourceforge.net
Message-ID: <53e22340-d528-13b8-8ed2-2954bef71557@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] Support server cipher preference
References: <20170716082207.23646-1-coroner@...2290...>
In-Reply-To: <20170716082207.23646-1-coroner@...2290...>

--InuLtPNoJGoeqRgcGgNokHxobMuuscpCg
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi Szil=C3=A1rd,


On 16/07/17 16:22, Szil=C3=A1rd Pfeiffer wrote:
> ---
>  doc/openvpn.8             |  4 ++++
>  src/openvpn/options.c     | 17 +++++++++++++++++
>  src/openvpn/ssl_common.h  |  7 ++++---
>  src/openvpn/ssl_openssl.c |  6 ++++++
>  4 files changed, 31 insertions(+), 3 deletions(-)
>=20

how about adding some text in the commit message explaining what the
patch is doing and *why* it would be helpful? casual reader not into TLS
(like me) may miss the benefit of this changes.

And why making it a compile time option?
Another question: may this option lead the client to an incompatible
configuration?

Cheers,



--=20
Antonio Quartulli


--InuLtPNoJGoeqRgcGgNokHxobMuuscpCg--

--1VoFNpQvAlwOI6SvUSvPxWWC1wg6jHpbD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEbd2mMhAXbmSCipS40+HICM1soFAFAllrKBIACgkQ0+HICM1s
oFBC1g/9HIJie8cvnBs0h02/X065M08LtxmyktLsOaqS1FpDUHWBXxOhrVNjIPk5
CsIFWvWJP0RjMRkSPWP0h0RBiUkYPd86nNl0Y+sB7KO8rNC4qD0atCxlNLA3JpjZ
spqepy8oTzcKoGOI48DHfAmJnCR6A04ECNaiNOsd28nKWDVtQuEEBKCuO2VJuvhW
sZBCVh7TP86AsvRyxRntPmYJZ1xVMclrXdwA9jMOleIVLYWy1MG9OXVBUwZTHAdU
ZFW8qUW/sKINi/kT2H8JJxSUpKidJdGixO3XRw7NGuu8IuX6vpIGbQQpjQS+beoi
DigjDgp36+FAbXumZ5WvrgctUC5QVG4aW8hT4vM0zpAN6jbPePeu2KulrYAnrZbQ
ep3uQfAMDBeFjCj+t9C7QoI/xRJI/DZdcph8webmrd+TYIh+06+EMLwYcTeAVdnK
lReaiHvGX5oTIZIGB/kNM5f7Yxaf506lRbQAPhRKzowDk8jTwqC78rsu5nQfXvfZ
BF09lxIYS3ySNIS60k94RUqrJvBhLBHpGDNu8SyxgAwNmWVZtU71Ri6v/r9jY8Bs
eUoy9RyHD7qA94XYJFb3wS/JPmw9zrdrE+kCqbefkO5LTbqJpadJjjGROjHeLCf8
cmik8FpTH5RHXmoGFmJRk9MvOHpZDk3BfCK+ydimvvUXM6qciz8=
=KtwT
-----END PGP SIGNATURE-----

--1VoFNpQvAlwOI6SvUSvPxWWC1wg6jHpbD--

