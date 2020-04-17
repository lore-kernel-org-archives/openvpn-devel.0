References: <20200328040858.16505-1-arne@...1227...>
 <20200401102159.29157-1-arne@...1227...>
 <20200401102159.29157-2-arne@...1227...>
 <57775d47-ddd4-0581-aeaa-294c148a77fc@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <9b0ee1f1-79ab-1217-f68a-5bb7cdd4bfbd@...1227...>
Date: Fri, 17 Apr 2020 09:47:33 +0200
MIME-Version: 1.0
In-Reply-To: <57775d47-ddd4-0581-aeaa-294c148a77fc@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QNrTF2qBCzgXjieIqjOGFjz2aaxYgH11H"
Subject: Re: [Openvpn-devel] [PATCH 3/3] Implement tls-groups option to
 specify eliptic curves/groups
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
--QNrTF2qBCzgXjieIqjOGFjz2aaxYgH11H
Content-Type: multipart/mixed; boundary="Yi88RhHSEszdJFr6ZVuBICeNWXSlOy5dN"

--Yi88RhHSEszdJFr6ZVuBICeNWXSlOy5dN
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 16.04.20 um 00:31 schrieb Antonio Quartulli:
> is it really important to clone "groups" ? why just not chopping it ?
> It shouldn't be re-used any more I think.

Maybe but modifying a parameter as side effect does not feel right. I
rather have a clean API here instead of this unintended side stuff that
can lead to kind of interesting bugs.

> If we really really need to alloc this memory, can't we get a gc from
> outside? maybe from the option parser? We normally avoid explicit
> alloc/free in the code.

The problem with a gc from the outside is that we don't really want to
tie up the memory in options->gc as that would just be extra memory that
is allocated the whole session I will update the patch to use a local gc.


Arne


--Yi88RhHSEszdJFr6ZVuBICeNWXSlOy5dN--

--QNrTF2qBCzgXjieIqjOGFjz2aaxYgH11H
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6ZXxUACgkQFRhsZwKx
RFQFdRAAh1L5rr4HGpZOsGRl7P5UKAjaSbB/v/l+0miD0UjcbCy2x+MKXFikBJj2
xaknB5cdCXmg+xsKXYshM0lZ6z2a+6zZ1mLceBG1nSRfnSP+yaHVASUBUEKkKTxk
F6jVvONtjMASPwkaZ2VWmTsLHIsL+Kx9RDUtNaL+KwVYGtmrKguL3AqUkTn6TBvR
Xmk20wOZVHhnKlkLIZgRSUiDEw16teh/AP9twu69ROJ3A3dPa4FRuPgUs20a7E00
PpQlTeKKUdjzhadw15CiojN9xD23B86f/xoCqWog3TTq7ihP+iwLDz6TCdTjmnNg
siIQl/VHvpMDFNcpS1pfYrUua30GrRFDFWWp8FU2Sb2lb4j17D2iy6geBytje0Sa
xunkWv6K6DbXxxtrGAoPUffQM6D/7qcyLw02Vtb+ATghwBUDWwGt1Id1JTWCbkA9
tQ5B7QoO/4WQNOgMKVafbhqsoo4S4c0S26Y3IsJjxRYS2ccZy9Hy+WujRY12f9RG
YsKf71khGS1cKl2Et1ALAdi6mGVm8/Y2+ISqEpLHdZNQ6R5AyD2TMilxnoFwzTK1
UM6M7eRogb9fKsqsZYE9Cy9gVAdr+GvmaE4x9g0k4hd46FQ0/neQ7y+8KIVOAGUQ
IrKon0vgwkbBmy+8dxlZM9meFxpHKeE9E1/1Av7vSQxzrTGW3dk=
=z/Tf
-----END PGP SIGNATURE-----

--QNrTF2qBCzgXjieIqjOGFjz2aaxYgH11H--

