References: <E1k011A-0002yw-6u@...2479...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c1ff0c23-f438-9033-1fe6-34ab5b73cc1f@...1227...>
Date: Mon, 27 Jul 2020 13:33:55 +0200
MIME-Version: 1.0
In-Reply-To: <E1k011A-0002yw-6u@...2479...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="BM6IBTz5J4yXWAjZkcJhTptvhiVSso1o0"
Subject: Re: [Openvpn-devel] [PATCH] Gently push users towards
 --data-ciphers in --show-ciphers output
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...2507...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BM6IBTz5J4yXWAjZkcJhTptvhiVSso1o0
Content-Type: multipart/mixed; boundary="jQaBs8S3ZI7PITF4gkltJfAPbEOQcmOz3"

--jQaBs8S3ZI7PITF4gkltJfAPbEOQcmOz3
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 27.07.20 um 13:09 schrieb Steffan Karger:
> Also:
>  * fix a typo in the openssl output ("may be use*d*")
>  * mention GCM before CBC (we prefer AEAD modes)

Looks good and we missed ncp-ciphers there, so I did not catch it in my
rename commit. Thanks

Acked-By: Arne Schwabe <arne@...1227...>




--jQaBs8S3ZI7PITF4gkltJfAPbEOQcmOz3--

--BM6IBTz5J4yXWAjZkcJhTptvhiVSso1o0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8eu6MACgkQFRhsZwKx
RFSQMxAAoBip3VaKRTUMjlXVM3CHltPSza+gNakKZ4ye78r1gkMtaxWctNAL/nNO
v2enfUffqMTbSjKtiJAO8H2ZNwyYcPfKU++0FFZL3VX6Ja5NvR0dnt4WOFuaIzsn
dg7TKNCNbT5ChQnxAhimnWJwT6QPUHqaadvl33ZAEmdYe4V3bRSx1B5RGrPOqh5t
ZmmJvoP/KoqYf7UnaQ5ATmLkH2lYT9DxTHSfyz7gFJrnlbj43FkNQuVfQ7u5Xrzt
UWVdcINY5rzgaVAdXn97Cmzvls73vaptbT8bC9jYQ/8IKxKkbP43XJoaAhPDckoD
EdI0PgXKCw56A1g/526hhjma56ikx7yQzNWrNyrKMEDdPkANiJXuk3i5kL6dJ3es
xjYdkBFap5upMNeicvme/Ou45SZQ15P+JRpb6xhChISQxpdnvQT8s6RE7NQ33NjQ
EMyXuyPbVclClPrQPbNc2KY5g+lTGXwKQL/yWeywXhWMsMrtXIrIS4tMapWLLzwR
dcdkYCG534RpN1sO1q/TYr2OnOcCsutCfTRdr+0VVt0G6bN3KIUwguZ8PFM7jfcL
qj9If35Tl47fyLAlHulS0P8wTF4GFiRGjSgaPCddiSszOX4E/TvYNGAFbutl4ors
TkbS2YyMOOoix4Tsext2Cgdtxv193PhIZr7wnAyPGriRKFJ/QAo=
=NRV2
-----END PGP SIGNATURE-----

--BM6IBTz5J4yXWAjZkcJhTptvhiVSso1o0--

