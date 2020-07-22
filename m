References: <20200616180046.8069-1-juliusz@...2525...>
 <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <4f5787ef-fa03-f7d1-db9a-52fe61caf281@...1227...>
Date: Wed, 22 Jul 2020 15:37:20 +0200
MIME-Version: 1.0
In-Reply-To: <c926d584-471b-c66e-21f8-4c31410b5e4f@...2525...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="u7stEuIFiwm9XRkOlVEQ8BnrSiDjrVcbQ"
Subject: Re: [Openvpn-devel] [PATCH] Support for wolfSSL in OpenVPN
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Juliusz Sosinowicz <juliusz@...2525...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u7stEuIFiwm9XRkOlVEQ8BnrSiDjrVcbQ
Content-Type: multipart/mixed; boundary="3j2O4XpbklMytQFt5cpRVlEzuhrIs5oUK"

--3j2O4XpbklMytQFt5cpRVlEzuhrIs5oUK
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 15.07.20 um 10:26 schrieb Juliusz Sosinowicz:
> Hi Everyone,
>=20
> do you have an update on the latest patch I sent? There have been
> updates to wolfSSL to fix the remaining issues brought up last time.
>

Yes. I looked at this today in the expectation that I just compile test,
do a few quick tests and the ACK+merge it:

However during our preperation for the next OpenVPN release, we
reevaluated the minimum OpenSSL version and decided that OpenSSL 1.0.2
is our minimum target for the next release and removed the OpenSSL 1.0.1
compatibility defines. I was not aware that WolfSSL depended on the
compatibility to 1.0.1 but rather surprised since we added all the tests
compatibility in autoconf that made the OpenSSL 1.1.0+ API checks also
work for WolfSSL. We also removed the option to compile OpenVPN without
AEAD support and since WolfSSL supports TLS 1.3, I also did not expect
that this would be problematic for WolfSSL.


The missing functions that I can see quickly are:

SSL_CTX_set1_curves/SSL_CTX_set1_groups
SSL_CTX_get0_certificate
X509_get0_notBefore
X509_get0_notAfter
SSL_CTX_set_ecdh_auto (Would not be need if WolfSSL declared >=3D 1.1.0
version)
CRYPTO_memcmp

Also EVP_CIPH_FLAG_AEAD_CIPHER was undefined. It looks that in the older
version/patch the use of the define was ifdef'ed under the assumption
that support of AEAD implies existence of the macro, which is seems not
to have been true in the case of WolfSSL.

None of the offending functions looks particularly bad. The get0 are
just the more modern name of older identical OpenSSL version. The set
groups is probably already somehow support but not exposed and I would
be surprised if a constant time memcmp does not already exist in WolfSSL.

Reverting the patch that removed 1.0.1 feel like a bad option at this
point and will also raise (rightfully) eyebrows and questions.

Arne



--3j2O4XpbklMytQFt5cpRVlEzuhrIs5oUK--

--u7stEuIFiwm9XRkOlVEQ8BnrSiDjrVcbQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl8YQRAACgkQFRhsZwKx
RFTjFxAAjFxXPefLJyYogEqxY+CAea/r48e1PcyQ98E7UjPuIRSTfAepexXCwWCE
yOnizm1b4tu0/Bv6ASoYv7Oz5/tTfvMjzIPPhE4Tv3kDvuSBng3sPi4Unr0ymZQh
5CFQvfJ6S+Z1UuvV2JCJYMCq8+MvFWB0Bu/8NSku5R6al5WenPM4CwJuXLLKXGwN
yUbi54NX5M3E1q7zy2FlCIXOojAX+Gy0LwvVKdRu54h3Yv6ALjxfbMvpH+Z53Ndt
UDQaWCI2yaWs4EFUEB4tyVjyW5WNT6EuTlN+Ff8Ta8N7+tcEOdsAGkc2zgEWPMpp
IuHN4rDfLVKFULlJCA4j2Ng4FtXQ2QPHAFDveI3vj7haCcZI/Pui0PKC4CI/jaxK
2uvLWA7eSxtBHeD9NXxp89K29B4pTOJ+Zf89toWv1iM6F6hPoNdlDg+f/syhnbbH
hFRMF7wiCeCHxo4FUlK1qm97Nk8Uz2uKSFHL7PiFgqayiHenmFFqRXu13lk1wjdO
lz5u45IyRngah3BmnXsq9y9cauN58de7IaN5mrkfZxvQ8MYU3t21uPQrkv1dKBxb
PVVfZDVtFPETkcjE1PgCM/WV+zNL9Q4ZPwE/LYR4/jyC4yrlc4YMMz9zlRugUJP4
4wRbINRapf+DiM0eFNhAQVhHpvDDQnYNhtfnQJL9Slw99q2crrE=
=+Vn0
-----END PGP SIGNATURE-----

--u7stEuIFiwm9XRkOlVEQ8BnrSiDjrVcbQ--

