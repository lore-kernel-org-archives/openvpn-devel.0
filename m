References: <1590709611.3515.22.camel@...2316...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <8aea6171-f862-ca03-dbce-fc03da38d3b2@...1227...>
Date: Fri, 5 Jun 2020 00:37:35 +0200
MIME-Version: 1.0
In-Reply-To: <1590709611.3515.22.camel@...2316...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="K2k9545IkFfefm6i1SkEdL5ZjvNBBZtq2"
Subject: Re: [Openvpn-devel] [BUG] test_ncp.c failing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: James Bottomley <James.Bottomley@...2316...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--K2k9545IkFfefm6i1SkEdL5ZjvNBBZtq2
Content-Type: multipart/mixed; boundary="qJnCCYG4EqFM17zcVO1cNoQBT5BfCwuxv"

--qJnCCYG4EqFM17zcVO1cNoQBT5BfCwuxv
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 29.05.20 um 01:46 schrieb James Bottomley:
> I'm getting this failure of test_ncp.c
>=20
> [ RUN      ] test_check_ncp_ciphers_list
> [  ERROR   ] --- 0x7d67e8 !=3D 0
> [   LINE   ] --- test_ncp.c:65: error: Failure!
> [  FAILED  ] test_check_ncp_ciphers_list
>=20
> I'm building under openssl-1.1.0i
>=20
> The problem seems to be openssl uses a mixed case name for the cipher
> and EVP_CIPHER_name() is case sensitive.  Applying the patch below
> fixes this for openssl and gets make check to pass all tests, but I
> rather wonder why this isn't part of cipher_kt_name() to prevent this
> type of problem?

Without double checking if I remember correctly OpenSSL 1.1.0 is a
corner case in this regard. OpenSSL 1.1.1 accepts mixed and non mixed case.

I want to fix this oddity in a proper way and write at least a small
unit test to ensure that always end up with the same cipher on the wire
protocol (in IV_CIPHERS and in the options string).

Arne


--qJnCCYG4EqFM17zcVO1cNoQBT5BfCwuxv--

--K2k9545IkFfefm6i1SkEdL5ZjvNBBZtq2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl7Zd68ACgkQFRhsZwKx
RFRf/w/+M6DTq5Z64gSr5gJ+0P+vO8ww7SY4X8q+/khV2CtY2dFanTzkgjf5FebD
Ku034TMmkMzTghPjmUoRn/5iNbb3iurwOkUimm3/oxbsPv3fwjGy2XggB4eT+nM4
uK0zmSvAB4DPpA5aPYZ6kf64Nb9qgTAvnEGz+JUMEuj5ZzUwlDQX8VlLLDcONA+9
Mf3bUOkTHjs50kOg4ZdTR/PSItv1Vvi4Ipw8F7ebreKZ2Si57aBjh+s5PeTBijyX
JBPzVjdWzanrgi4carJu9uA8aEzelQu7PC8XPooF/nhUrIN2mN4eTi+NtsXfLxyN
rtfDuljoxh0UXvv03YGzZU8hXCYIhhgVajCfrdrnYb3/raG1RS+3Z306XPB/rqH0
YcDWbtbG2Xn2ozQFXavE2cYK/9Qe6+eePKDvhZdvvp8hiSSOcafDcqgJDfi8kuvb
PWg/Za2AitNRsFxXP6ZFN8jXo4mZlciQEIV7hkmtgPDpW2aYE6yMI8OQGzft80+m
GThobhcF7C/dNjAQgSwAIFq3rMOhqoRBWojcHiNP1p1p1S+x+eHZFVCSq6qMtg7U
NhNQ+tOmr6ZBFMzroR8TQbeB0XA4Ffk2kVDx03NGTr29ECd4nwtTRZZOgasYz4B0
p3q1GC3QlmJtZl9DZvnOrTV4lll8gwnGFpZRA285uZFFOwKXYeU=
=DdGC
-----END PGP SIGNATURE-----

--K2k9545IkFfefm6i1SkEdL5ZjvNBBZtq2--

