References: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
 <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
From: Steffan Karger <steffan.karger@...1435...>
Message-ID: <6701d87c-4037-e1ea-5475-bb8ad90512d5@...1435...>
Date: Sat, 12 Aug 2017 11:53:23 +0200
MIME-Version: 1.0
In-Reply-To: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="oviSnIxWSRgjlOPnlkMIs4LbxTHv15TIp"
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: introduce tls_crypt_kt()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

--oviSnIxWSRgjlOPnlkMIs4LbxTHv15TIp
Content-Type: multipart/mixed; boundary="3X9dWsmohf0V1h3te8GFbWaOafN0GXggg";
 protected-headers="v1"
From: Steffan Karger <steffan.karger@...1435...>
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net
Message-ID: <6701d87c-4037-e1ea-5475-bb8ad90512d5@...1435...>
Subject: Re: [Openvpn-devel] [PATCH] tls-crypt: introduce tls_crypt_kt()
References: <1500993182-24246-1-git-send-email-steffan.karger@...1435...>
 <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>
In-Reply-To: <b9bc7932-83e9-b044-b049-504b73ab3a36@...2181...>

--3X9dWsmohf0V1h3te8GFbWaOafN0GXggg
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On 12-08-17 06:36, Antonio Quartulli wrote:
> On 25/07/17 22:33, Steffan Karger wrote:
>> @@ -60,23 +60,9 @@ setup(void **state) {
>>      struct test_context *ctx =3D calloc(1, sizeof(*ctx));
>>      *state =3D ctx;
>>=20=20
>> -    ctx->kt.cipher =3D cipher_kt_get("AES-256-CTR");
>> -    ctx->kt.digest =3D md_kt_get("SHA256");
>> -    if (!ctx->kt.cipher)
>> -    {
>> -        printf("No AES-256-CTR support, skipping test.\n");
>> -        return 0;
>> -    }
>> -    if (!ctx->kt.digest)
>> -    {
>> -        printf("No HMAC-SHA256 support, skipping test.\n");
>> -        return 0;
>> -    }
>> -    ctx->kt.cipher_length =3D cipher_kt_key_size(ctx->kt.cipher);
>> -    ctx->kt.hmac_length =3D md_kt_size(ctx->kt.digest);
>> -
>>      struct key key =3D { 0 };
>>=20=20
>> +    ctx->kt =3D tls_crypt_kt();
>=20
> Now we don't have the NULL checks on ctx->kt.digest and ctx->kt.cipher
> anymore.
> I understand this there is no variable involved as we statically search
> for "AES-256-CTR" and "SHA256", however, shouldn't we at least assert
> for them being not NULL ? Somebody may mess up the main code and the
> unitest should properly detect the wrong condition instead of segfaulting.

Actually, we do, because tls_crypt_kt() exits through msg(M_FATAL, ...)
if kt.cipher or kt.cipher is NULL.

But thanks to this remark, I realized that this will again break the
unit tests on platform without AES-256-CTR or HMAC-SHA256 (like SLES11).
 So I'll send a v2 with improved error handling shortly.

-Steffan


--3X9dWsmohf0V1h3te8GFbWaOafN0GXggg--

--oviSnIxWSRgjlOPnlkMIs4LbxTHv15TIp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJZjtAXAAoJEEEwndWOY1w55rQH/jMdGhYi1PW3CWfCLhYQf7FT
yDB7gLh+0HfU0O50DiafzTXSGkYxxqnGEM/Uyv3OJtMjwN37XHpc4prgsJG7t01m
RMLYhiDtmqrgFYp9PI4fWmy0S84LCUWzeiLhBsSzyMgQSKqUnFvLanNbzSwLPibW
2Yxmjy/JhVUNZNIqjmZBtdiGaSTVMFw9KmFidkgysoeT+Ut+czkpJWEVW9VoAxiw
XqN6PGBHjmWuHGBLky8Q1AHReyLN2VvdXKim2vTpEsG+yjNlV7zSzLbCs5vT0GQy
DmM9HctqAelAWUzPY9ZUVL1Oqw+AGs0b0hEjb7KLTOPFcP3/i2UxqPyyN3w0uVI=
=hn94
-----END PGP SIGNATURE-----

--oviSnIxWSRgjlOPnlkMIs4LbxTHv15TIp--

