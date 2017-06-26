Reply-To: openvpn-devel@lists.sourceforge.net
From: David Sommerseth <openvpn@...2080...>
References: <1498475606-8337-1-git-send-email-arne@...1227...>
	<99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
	<73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
	<96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
Message-ID: <a486ae43-afd7-5066-5f32-459c90c7a976@...2080...>
Date: Mon, 26 Jun 2017 15:34:16 +0200
MIME-Version: 1.0
In-Reply-To: <96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="HmiUvefiUxmUgiPtNjwGksSU1toDnhmrA"
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before
 loading certificates
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--HmiUvefiUxmUgiPtNjwGksSU1toDnhmrA
Content-Type: multipart/mixed; boundary="MN97IGipan3VVn9DHjvHKKoR4jPse9mQD";
 protected-headers="v1"
From: David Sommerseth <openvpn@...2080...>
Reply-To: openvpn-devel@lists.sourceforge.net
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <a486ae43-afd7-5066-5f32-459c90c7a976@...2080...>
Subject: Re: [Openvpn-devel] [PATCH] Set tls-cipher restriction before loading
 certificates
References: <1498475606-8337-1-git-send-email-arne@...1227...>
 <99e7102e-8b4a-6b42-3095-40fcfada8c28@...2080...>
 <73f851af-608e-7a15-1021-82cb0b05dada@...1227...>
 <96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>
In-Reply-To: <96916139-fed0-fae9-1c36-b4e2417eb26a@...2080...>

--MN97IGipan3VVn9DHjvHKKoR4jPse9mQD
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On 26/06/17 15:21, David Sommerseth wrote:
> On 26/06/17 14:12, Arne Schwabe wrote:
>> Am 26.06.17 um 13:51 schrieb David Sommerseth:
>>> On 26/06/17 13:13, Arne Schwabe wrote:
>>>> OpenSSL 1.1 does not allow MD5 signed certificates by default anymore.=
 This can be enabled again by settings tls-cipher "DEFAULT:@SECLEVEL=3D0" b=
ut only if the cipher list is set before loading the certificates. This pat=
ch changes the order of loading.
>>>
>>> I'm not fully convinced of the argumentation for this feature - unless
>>> something have changed in OpenSSL 1.1.  I believe the same can be
>>> achieved by setting an environment variable before starting OpenVPN.
>>>
>>>   $ OPENSSL_ENABLE_MD5_VERIFY=3D1 /usr/sbin/openvpn ....
>>>
>>> I know several Fedora users have deployed this, even when systemd is
>>> involved.  This is needed on systems with OpenSSL 1.0 as well when they
>>> connect to a server having an MD5 based certificate or signed by a CA
>>> with an MD5 based certificate.
>>>
>>> So unless OpenSSL 1.1 have changed this behaviour from OpenSSL 1.0, I'm
>>> not really convinced we need this.
>>>
>>>
>>
>> See this also a bugfix. Since tls-cipher options affect certificate
>> loading, it is good to set it before certificate loading. E.g. you might
>> want to use @SECLEVEL=3D5 to only allow loading of SHA256 based certific=
ates.
Oh, btw ... We need to align this with another patch-set from Steffan.
There is a feature we have in OpenVPN 3 and the proposed patches from
Steffan which adds --tls-cert-profile.  This is aimed at controlling
what kind of TLS security parameters which is required.

Currently there is an agreement of the following profiles:

  - legacy: SHA1 and newer, RSA 2048-bit+, any elliptic curve.
  - preferred: SHA2 and newer, RSA 2048-bit+, any elliptic curve.
               (default in v2.5)
  - suiteb: SHA256/SHA384, ECDSA with P-256 or P-384.

The mbed TLS definition of these profiles in OpenVPN 3 is like this.

  const mbedtls_x509_crt_profile crt_profile_legacy =3D // CONST GLOBAL
        {
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA1 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_RIPEMD160 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA224 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
          0xFFFFFFF, /* Any PK alg    */
          0xFFFFFFF, /* Any curve     */
          1024,      /* Minimum size for RSA keys */
        };

  const mbedtls_x509_crt_profile crt_profile_preferred =3D // CONST GLOBAL
        {
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA256 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA384 ) |
          MBEDTLS_X509_ID_FLAG( MBEDTLS_MD_SHA512 ),
          0xFFFFFFF, /* Any PK alg    */
          0xFFFFFFF, /* Any curve     */
          2048,      /* Minimum size for RSA keys */
        };


The suiteb profile is just reusing the mbed TLS definition directly.

With that said ... The legacy profile does not include MD5.  So either
we allow MD5 into the legacy profile; or we need legacy-md5.


--=20
kind regards,

David Sommerseth
OpenVPN Technologies, Inc



--MN97IGipan3VVn9DHjvHKKoR4jPse9mQD--

--HmiUvefiUxmUgiPtNjwGksSU1toDnhmrA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBCgAGBQJZUQ1YAAoJEIbPlEyWcf3yi7sP/1LOBWp4JRdbI/fit8WeYguR
VB+k6wvqaR0ckvbZ3tB9zZqoDp8cauo4/i1zpe+fGmQTU4oPkF8lpc06tlUVQRm5
RA4lPichmtM2GfNOFctOD4qe/Wr/QFSZz8xX3F9Of0se5LXkBs26jMoUyOO+hJ1f
yms2MV9zOIkJWjK4gUjTIfRIq1ahRXa3HZ38pUNbs15bIuL3cmBsN3r/7xZCsUPM
4KDbtj9+fRHF/Y9x4N+xaPoc6xnvKZujodtW1pbGRhd+u2zenx/6BqickxQpsFXI
U6RzSdttYdbW+ODPKdq8/dk26EDCG8REKUPfaA/RC3rvsRaJCEJMN5VNPDNfOHUX
NKDhdo23PSZtoaommfWI2hMeGzjcmvuqLUtLW5fsL4iYFAUgaRg/wujIuN/BO+bK
mifbdxlEKF+dRe7UYVCtNxa9ixNQEgo7MWyEWbM2LBEQDKZAAHyEi5n/1SWlqNAT
WvTkpbz4KXrzuz3Et+nUqUmHam3CBhqtECZ6mzobgjusu6whCmpSmCEszo+TqnoT
EdZyS8sOYIjQvuY32KSk0JOKmMYMMErTLHPFotvsRv2cm9nUOrtLPJpWyR87cNIS
Fw7uJyHD2BpoUyPQ25K1/9WOlgxnr3H5o8des+5eFISnrfRB9WyV0kZp8/q3BBO7
5yt5e3jWjV+DMYWuk5Mx
=GCO1
-----END PGP SIGNATURE-----

--HmiUvefiUxmUgiPtNjwGksSU1toDnhmrA--

