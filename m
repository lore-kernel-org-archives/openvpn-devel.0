Date: Mon, 6 Mar 2023 11:26:21 +0100
From: Gert Doering <gert@...1296...>
Message-ID: <ZAW/zTnBkuDrHxPB@...1296...>
References: <20220909195902.2011798-1-arne@...1227...>
 <20230131135248.3574741-1-arne@...1227...>
 <ZAWxSEpBIEEM5Uys@...1296...>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="k9U2Tde7DwjVB9Y3"
Content-Disposition: inline
In-Reply-To: <ZAWxSEpBIEEM5Uys@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v7] Dynamic tls-crypt for secure
 soft_reset/session renegotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

--k9U2Tde7DwjVB9Y3
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi,

On Mon, Mar 06, 2023 at 10:24:24AM +0100, Gert Doering wrote:
> 2023-03-06 10:20:04 Assertion failed at tls_crypt.c:83 (key->n =3D=3D 2 &=
& other->n =3D=3D 2)

Splitting these into two ASSERT()s, it says key->n is fine, while
other->n is not

2023-03-06 11:24:00 Assertion failed at tls_crypt.c:84 (other->n =3D=3D 2)

adding some more msg() it seems that "other" is undefined here

2023-03-06 11:25:44 xor_key2(): key=3D0x7fffffffd258, key->n=3D2
2023-03-06 11:25:44 xor_key2(): other=3D0x80122062c, other->n=3D3009016

gert
--=20
"If was one thing all people took for granted, was conviction that if you=20
 feed honest figures into a computer, honest figures come out. Never doubte=
d=20
 it myself till I met a computer with a sense of humor."
                             Robert A. Heinlein, The Moon is a Harsh Mistre=
ss

Gert Doering - Munich, Germany                             gert@...1296...

--k9U2Tde7DwjVB9Y3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQGcBAEBAgAGBQJkBb/NAAoJEB2Cnv7KVigSN78L/19YhSSIZ5fXgnwiYnH/jPTX
i2GNLRgEbrGHzAvWR3B7MLZ5jdPYOpT1V2Jo5FXGodOJgBFIHqSoV4+XTzlRpmBk
wg/ufnWxa7HkJROxnxPHxziAkmCFusdOI/Kztz0qFnCVB6pUcDgg8Kfz3TuqXZTj
L8V6NHiK+t8JiiahrYLUj5KvgDngzvtseOM7uWLYwr3eTGwWt6RdBojmDj2VIPmz
kHt9oK6d2Ipa/YZJZE3PPPYOSj/epRYLOEd9ki1sCvnwhXjql769KIGpnjyNo4Ht
zaNMMmhneEzrOOUuPBqc1btgKGA798kxUNNN1RZLNscOSsadCXu+9dfJYcFd/Ro8
Qdf314lzrOkgSCp7xpQpWlwCwiJH0eNsaVjf+AIGE3YsIxm4tJzMbhOGDPU6eFUt
KZPYscHI8nPGOpURgGeM+no6ZMZxtvBEdbwREvqYdm6C4w21Y51elZoIKV+Yrl6b
iX24FndkSBNMhmOChPnrvLbZl0bzKNunRliiVVVXAQ==
=NqVQ
-----END PGP SIGNATURE-----

--k9U2Tde7DwjVB9Y3--

