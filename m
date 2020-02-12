From: Arne Schwabe <arne@...1227...>
References: <20200206132103.15977-1-davids@...515...>
 <20200206132103.15977-3-davids@...515...>
Message-ID: <560150c2-26d6-669a-ad3f-fb41d7f4b42e@...1227...>
Date: Wed, 12 Feb 2020 13:58:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200206132103.15977-3-davids@...515...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="6QMcLGnFk3SQVkMAJclqqmaIZh6YJDKOB"
Subject: Re: [Openvpn-devel] [PATCH 2/4] argv: do fewer memory re-allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: David Sommerseth <davids@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6QMcLGnFk3SQVkMAJclqqmaIZh6YJDKOB
Content-Type: multipart/mixed; boundary="3Jl7WzCc1IAiZAQcpZaxkr3OtIzDSEj4Z"

--3Jl7WzCc1IAiZAQcpZaxkr3OtIzDSEj4Z
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.02.20 um 14:21 schrieb David Sommerseth:
> From: Heiko Hund <heiko.hund@...1489...>
>=20
> Prevent the re-allocations of memory when the internal argv grows
> beyond 2 and 4 arguments by initially allocating argv to hold up to
> 7 (+ trailing NULL) pointers.
>=20
> While at it rename argv_reset to argv_free to actually express
> what's going on. Redo the argv_reset functionality so that it can
> be used to actually reset the argv without re-allocation.
>=20
> Signed-off-by: Heiko Hund <heiko.hund@...1489...>
> Signed-off-by: David Sommerseth <davids@...515...>
> ---

Acked-By: Arne Schwabe <arne@...1227...>




--3Jl7WzCc1IAiZAQcpZaxkr3OtIzDSEj4Z--

--6QMcLGnFk3SQVkMAJclqqmaIZh6YJDKOB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl5D9n4ACgkQFRhsZwKx
RFQClg/8Dgp2c2gBWxTtF9q1joACpik/6Dc6zRTsNreMFqxBv8nMGgj1OBTiW7Mw
88afGsgkVzBimAzbazfp9btYwcqUWY/aBOkntPohGy7CSvP5xgnbeS1BcrUb3c+C
xSLCXM3vocwxI254ho3KZ1aykVI830UzwHEoY7dmldhbeJMZwpBH9yfVoyM535k2
RK0r90E6yu2XSzQsc8WxuyKmiqOU2A2XzE/pRKDpfhwdjwav2+WAkkcglb1Gp1A7
Qjn2RO6xBAq4N38ko05SHQ0AW0igwYgyfIpjDlM5BSNt78bJEOSOsJjrJdVZuQ3h
F/a8EDKmxMb76HKQQjFU91EIDrbN1U0DxtFL7PP2xqcnBjcn2Yw92s9QVKbwqYx7
+4SEZvKFb/1GORLD/2ryExYSnrrqzwaoZfurQJxCyvHGMd8+Y4XKsFjS1mOy+pQC
HmwpoyRj5BXlkDK7WxfRkT4zdNWoL3bpGAFeKa2P5e4hB5iVfhiQLpVvfZa9yLNG
XHavuBUAZ8Jo9Nsh34Rr/ol3iyl299MFPpih+muDzhZXuVXeGPBWxSKxgzmi35jb
Mi4RS4DO09EzVjSjfeJTGA8GOx8v9+MWeBxI1kY2iDpzju5Bl3ISGVuYilf8vdoh
HECw13pNHFK1hOf6Z9Z4IkbgEj/ceJVQTYEsj/nc104TLucb9Og=
=m6sI
-----END PGP SIGNATURE-----

--6QMcLGnFk3SQVkMAJclqqmaIZh6YJDKOB--

