References: <20180104193710.23778-1-chipitsine@...277...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <b0da9d47-38e7-af16-22c6-6d0c3ed63c62@...2181...>
Date: Sun, 7 Jan 2018 16:03:41 +0800
MIME-Version: 1.0
In-Reply-To: <20180104193710.23778-1-chipitsine@...277...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="0wj2tBsV9wYS43RqpMwnBd3Ow3lZTkIP0"
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add brew cache,
 remove ccache
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--0wj2tBsV9wYS43RqpMwnBd3Ow3lZTkIP0
Content-Type: multipart/mixed; boundary="oXeM7XBKPYH7vbb5YUmur1wqbiWycTZfm";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Ilya Shipitsin <chipitsine@...277...>, openvpn-devel@lists.sourceforge.net
Message-ID: <b0da9d47-38e7-af16-22c6-6d0c3ed63c62@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] travis-ci: add brew cache, remove
 ccache
References: <20180104193710.23778-1-chipitsine@...277...>
In-Reply-To: <20180104193710.23778-1-chipitsine@...277...>

--oXeM7XBKPYH7vbb5YUmur1wqbiWycTZfm
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 05/01/18 03:37, Ilya Shipitsin wrote:
> 1-2 minutes speedup osx builds by using brew cache.
> Also, ccache was removed for a while (builds fail
> after travis-ci upgraded clang to version 5.0.0)

you missed the Signed-off-by line.
But other than that:

Acked-by: Antonio Quartulli <a@...2181...>


--=20
Antonio Quartulli


--oXeM7XBKPYH7vbb5YUmur1wqbiWycTZfm--

--0wj2tBsV9wYS43RqpMwnBd3Ow3lZTkIP0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpR1F0ACgkQB6U8WA7y
zXTXOg//T8ZEIDrs+5JJCWxLJJQQjWYe32edRSzIpmp0mkOJj69O9Gwi6Eul79tE
imIGsTW9i4lrLEOi2pSDPDVb2C25XWdEOR1ekudF4BzkQ4DpAfB8FthRbS0F16f8
2e0YhRkKnTGaXE9joTGnBjczTotWquodooLwV9dgtbVK84UREb2wzzpELa4N8m16
/mr1T2iNmECDD8veouWYwqx8bwPLLA5ZFCcSXfQAlS6Mu681ZW8kulylnZQRJqT5
EPkfhccXCu40KZO+ThSRyD/l4g9NdSONUC1miKgFEBN8fbvfmYo54RldXKbHD4Ky
RHRTSNoKlsHeC3PseMTTwztcuH7+9kQdlts6KPs0hAGVe8EtnSaVKPKU5WuT0XQG
IpufNB2PWe8UPpmhMn8ugCHqdw/gcnCw4i41VRZyBOLoxMKnQ3R0wv5n1Lz0hKcT
hkftR2sjS0yYDlvG7cSXsgAqtXVnEjeexj7eFrFkMlJtlgz+93ATYK5doOw6TXVz
fBkJpqLjXfXPmxC+Pzqq+T5nfGBT/2tw1plNTg6I35zR4XPLhUAy+JMl5L3AgC0E
iED2ui6OOLnikfVQWdU41HiYRkg4lZQhXngGA0wF3VGWELVN7bdTEo2iu4BOOPHV
oWQ0v34FhHzGM4OX6kgY+DRnaopKei6nppuMorUkblRj5y1xQ6c=
=J/A7
-----END PGP SIGNATURE-----

--0wj2tBsV9wYS43RqpMwnBd3Ow3lZTkIP0--

