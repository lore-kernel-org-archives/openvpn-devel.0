References: <20181219050118.6568-1-a@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <eb47b6f4-0f40-77e2-7bce-c0bb95c69dad@...1227...>
Date: Tue, 22 Jan 2019 16:45:30 +0100
MIME-Version: 1.0
In-Reply-To: <20181219050118.6568-1-a@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Nw2cxtLHT3n6mV5qpo6HhcqgLsbRUZeNF"
Subject: Re: [Openvpn-devel] [PATCH v3 0/7] introduce networking API and add
 netlink support for Linux
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
--Nw2cxtLHT3n6mV5qpo6HhcqgLsbRUZeNF
Content-Type: multipart/mixed; boundary="Mtnp4CgvFQokGCKzznfOmX7PBHS32HjsO";
 protected-headers="v1"
From: Arne Schwabe <arne@...1227...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <eb47b6f4-0f40-77e2-7bce-c0bb95c69dad@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v3 0/7] introduce networking API and add
 netlink support for Linux
References: <20181219050118.6568-1-a@...2181...>
In-Reply-To: <20181219050118.6568-1-a@...2181...>

--Mtnp4CgvFQokGCKzznfOmX7PBHS32HjsO
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 19.12.18 um 06:01 schrieb Antonio Quartulli:
> From a high level description of this patchset, please refer to
> "[PATCH 0/4] add netlink support for Linux" sent to the mailing list on
> Apr, 20th 2018.
>

This patch set seem to be missing the commit

implement platform generic networking API

from the v1 of the patch set, so I will review the v1 instead again as
it looks it is still identical in your git tree.

Arne


--Mtnp4CgvFQokGCKzznfOmX7PBHS32HjsO--

--Nw2cxtLHT3n6mV5qpo6HhcqgLsbRUZeNF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAlxHOpoACgkQFRhsZwKx
RFQvTRAAnzlXGw/QK6j8M7USPBiRgq/wbc/wWxDZBaYalQT6Ufz1DJaEK59ujQBQ
86qyjIzAP58p1jXFuuU8HVovTwYACpFD1L0tBleZguE75DG1V+x7VrGxVcXSwfSK
MFR6GJP/dxLh3843m9pWtFpah+1OW6SORoEwlZh9dwJFIbruGp5fpUf3N9QmxCvY
nlpzKhbyPdeh4B42f5Tww3rSglrE7YbyKTO5jUde+d3FkwWReIez0tQn9PlyDtxp
oB4utWEuXBF/WQI6JNOaPAl3Apm1bcfzINQxIZXGmHuizkG7zqO/Dexf60158w9R
LTaQAVgGQzKJH4MrqKkZbJViH2Jhovhasg4TJaXbNVn+yWS82DOVVc7JvDDZ6Bvq
YzwOr4eT64Gt1IqwL9MCL1ivDDax3OMFUyW9RDzUStMSRXm7FzW/r0L134JgQmjT
ko9ccSBQcrr7UN0Z2Wm7YYqAJ/bmFNfsfAmMggEMa2s+Dgy4KQeYCn4pX+5RKtGN
kVS8K7IfukPbkrYw/WyjqjqbnQUnDvKaxlQx8293OuDcznlg/92QOAhHyDz9hTND
bePSpN9ln5yXvp7AX9jb/jobTNAPlp5IeDCVcKxQYtAe4NcpSv1Y8U42MwjDCy9b
RXOt+YRcg8HsYaFu5tKAE94Wqjk+6kJGgHdDt9XR4isgNFAgROM=
=LnS4
-----END PGP SIGNATURE-----

--Nw2cxtLHT3n6mV5qpo6HhcqgLsbRUZeNF--

