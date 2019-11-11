References: <20191110231018.30621-1-steffan@...1856...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c297e78a-7e0a-dd6a-bc79-69fe297a8e67@...1227...>
Date: Mon, 11 Nov 2019 14:12:04 +0100
MIME-Version: 1.0
In-Reply-To: <20191110231018.30621-1-steffan@...1856...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="QOWCNRZ7PRxDrusoEAaG8JSphGdv56k8p"
Subject: Re: [Openvpn-devel] [PATCH] mbedtls: add RFC 5705 keying material
 exporter support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--QOWCNRZ7PRxDrusoEAaG8JSphGdv56k8p
Content-Type: multipart/mixed; boundary="cRkuVf14rLOlsSXOGqKtO4oujtkF3KmOj"

--cRkuVf14rLOlsSXOGqKtO4oujtkF3KmOj
Content-Language: de-DE
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 11.11.19 um 00:10 schrieb Steffan Karger:
> Since mbed TLS 2.18, mbed TLS can also implement RFC 5705. As a first
> step towards using the keying material exporter as a method to generate
> key material for the data channel, implement the
> --keying-material-exporter function we already have for OpenSSL also for
> mbed TLS builds.
>=20
> Implementing RFC 5705 for mbed TLS is a bit more cumbersome, because the
> library itself only provides a callback that is called during connection
> setup, which enables us to implement RFC 5705 ourselves. To protect
> ourselves against mistakes, we immediately perform the required key
> derivation to generate the exporterd keying material, and only cache the
> derived key material until we can actually export it to the environment
> (similar to the OpenSSL builds).
>=20
> To test this, I found it easiest to temporarily move the call to
> key_state_export_keying_material outside the if statement, and use a
> script that runs after connection setup (e.g. --ipchange) that prints
> the environment. E.g.
>=20
>   #!/bin/sh
>   env | sort
>=20
> This should show the same value for the exported_keying_material env
> variable for both mbed TLS and OpenSSL builds. Of course you can also
> use the code as-is, and write a plugin to verify the same thing.
>=20
> Signed-off-by: Steffan Karger <steffan@...1856...>


If we do a v2 of the patch could we rename HAVE_EKM to something better
like HAVE_EXPORT_KEYMATERIAL? EKM is a bit a too short for my taste.


Otherwise it looks good to me. I cannot really test it because I
currently do not have anything that uses export keymaterial.

As background why we want/need this patch. We currently use a fixed PRF
for determining the data channel key. While what we use (SHA1 +MD5 like
TLS 1.0) is perfectly fine, it would nice to instead use a more modern
approach. And using RFC 5705 for something like key-method 3 avoids
reinventing the wheel.

So from me point of view:

Acked-By: Arne Schwabe <arne@...1227...>

Arne



--cRkuVf14rLOlsSXOGqKtO4oujtkF3KmOj--

--QOWCNRZ7PRxDrusoEAaG8JSphGdv56k8p
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl3JXiUACgkQFRhsZwKx
RFRmhg//fI16Qsj20QAH3+tGkOpflbtV3vqTVwSwUGCebqhnoNSapJHJ1qc6IyWB
gfRjkUJHWzxccb4/egyEVHsZHOWMHt4wRxfeZQLO+KSHG8715JGUonTvf+KjS22C
9bmcsMI+JVJhpmLj6DEm+5TXBfGYah/YciM5+WzCixPOCjxU3mVR/MIW2dTLwHWi
4HIpncbxj8+9p/AzrkD/FeoCzlmTY8cPBGwRLOL/MqHaKMOq0lWc61taJQuVA4kE
0oz5ww+rEFSoSrknQBQtkieg0LE2XZUNx62iv8TTcVk1LfDD2m0dn8o22s3ifO8e
RxBDtY6m5hE3bQQQl2Y4KTM3WHuocKLcc3gWdM5IZm/y5Ugf4sAl/fg6a5DUge2+
XkJzPTNjwRWt0Xs+YsYpqg0In7LyF8ZXBycpTj2aXjKHTZX/55SS/oZslr/vXsEB
2zA9q/2i5p4NYy9n89XfmqeqsLQ0Qb59p1GY3aPzuNlMr0xNoT8QU/WzgdXbf5oq
VEXKrjk7S+Ggj6bWpPVR9wDNRAj3PKzsHl+45acgw5m/ojWz858ia+v1R4LkYxB7
Zk55OU1x4WQp1F7Q3ChyeWbN83RuwHBVcf5lY/JMobTiUdE7sjpTEQbKaU3LCYY/
3s0nTT2+TIhz6A63WXrrvAItdpHTDIHRnK6HW5EHiR1LxauHlNE=
=c1/2
-----END PGP SIGNATURE-----

--QOWCNRZ7PRxDrusoEAaG8JSphGdv56k8p--

