References: <20200406130001.6860-1-arne@...1227...>
 <E1jLTvv-0002lj-Da@...2508...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <271c5460-ee61-5a7a-1638-6dfb0afc8e9c@...1227...>
Date: Mon, 6 Apr 2020 18:00:42 +0200
MIME-Version: 1.0
In-Reply-To: <E1jLTvv-0002lj-Da@...2508...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="629Jk71OPF8JsKrp4rRSxabAwXWI4sLfJ"
Subject: Re: [Openvpn-devel] [PATCH] Do not write extra 0 byte for --gen-key
 with auth-token/tls-crypt-v2
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
--629Jk71OPF8JsKrp4rRSxabAwXWI4sLfJ
Content-Type: multipart/mixed; boundary="p45qOf6Ul7ayrSjwGUIls759QewVnTWEG"

--p45qOf6Ul7ayrSjwGUIls759QewVnTWEG
Content-Language: en-GB
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Am 06.04.20 um 17:44 schrieb Steffan Karger:
> Hi,
>=20
> On 06-04-2020 15:00, Arne Schwabe wrote:
>> crypto_pem_encode put a nul-terminated terminated string into the
>> buffer. This is useful for printf but should not be written into
>> the file.
>>
>> Also for static keys, we were missing the nul termination when priting
>> it to stadout but since the buffer was cleared before, there was always
>> a NULL byte in the right place. Make it explicit instead.
>>
>> Signed-off-by: Arne Schwabe <arne@...1227...>
>> ---
>>  src/openvpn/crypto.c    | 11 +++++++++--
>>  src/openvpn/tls_crypt.c | 10 ++++++++--
>>  2 files changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
>> index 453cb20a..7af48df0 100644
>> --- a/src/openvpn/crypto.c
>> +++ b/src/openvpn/crypto.c
>> @@ -1477,6 +1477,7 @@ write_key_file(const int nkeys, const char *filena=
me)
>>      /* write key file to stdout if no filename given */
>>      if (!filename || strcmp(filename, "")=3D=3D0)
>>      {
>> +        buf_null_terminate(&out);
>>          printf("%s\n", BPTR(&out));
>>      }
>>      /* write key file, now formatted in out, to file */
>> @@ -1888,9 +1889,15 @@ write_pem_key_file(const char *filename, const ch=
ar *pem_name)
>>      {
>>          printf("%s\n", BPTR(&server_key_pem));
>>      }
>> -    else if (!buffer_write_file(filename, &server_key_pem))
>> +    else
>>      {
>> -        msg(M_ERR, "ERROR: could not write key file");
>> +        /* crypto_pem_encode null terminates the buffer, do
>> +         * not write this to the file */
>> +        buf_inc_len(&server_key_pem, -1);
>> +        if (!buffer_write_file(filename, &server_key_pem))
>> +        {
>> +            msg(M_ERR, "ERROR: could not write key file");
>> +        }
>>          goto cleanup;
>>      }
>>=20=20
>> diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
>> index e9f9cc2a..85f2862b 100644
>> --- a/src/openvpn/tls_crypt.c
>> +++ b/src/openvpn/tls_crypt.c
>> @@ -706,9 +706,15 @@ tls_crypt_v2_write_client_key_file(const char *file=
name,
>>          client_filename =3D INLINE_FILE_TAG;
>>          client_inline =3D (const char *)BPTR(&client_key_pem);
>>      }
>> -    else if (!buffer_write_file(filename, &client_key_pem))
>> +    else
>>      {
>> -        msg(M_FATAL, "ERROR: could not write client key file");
>> +        /* crypto_pem_encode null terminates the buffer, do
>> +         * not write this to the file */
>> +        buf_inc_len(&client_key_pem, -1);
>> +        if (!buffer_write_file(filename, &client_key_pem))
>> +        {
>> +            msg(M_FATAL, "ERROR: could not write client key file");
>> +        }
>>          goto cleanup;
>>      }
>>=20=20
>>
>=20
> Fix is correct, but I'm not too happy with changing the buffer from
> being null-terminated to not-null-terminated. This change itself is
> correct, but it feels like a recipe for mistakes in the future.
>=20
> What would you think about adding a length parameter to
> buffer_write_file() instead, so that the API there changes to "write len
> bytes of data to file"?

So there are three alternatives how to things:

a) make pem_encode behave more like other similar functions in OepnVPN
and do not null terminate. Then we would need to call buf_null_terminate
like in the static key path

b) do what this patch does

c) have buffer_write_file take a length argument.

I considered c) but it felt wrong because the function currently just
does a very simple job.

I did not do a) because that would make printing the buffer etc more
complicated since either pem_encode needs to allocate a bigger buffer
than it needs to or we need to copy the buffer into one that allows an
extra null byte.

That being said I don't feel stronlgy about this and can send an updated
patch that is a) or c)

Arne



--p45qOf6Ul7ayrSjwGUIls759QewVnTWEG--

--629Jk71OPF8JsKrp4rRSxabAwXWI4sLfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEE88wmPb+Azu8xbws3FRhsZwKxRFQFAl6LUisACgkQFRhsZwKx
RFTDrBAAgRIPiihTAYQvnFAky4AGhbogLuPrlo90wX1vQtKnLDNzmbPty55iBO3a
T9PH+PM+LZdLpOhrVfg+s/GLRWLYtDk06tvZWpTwXDtTGEGAWNNm9ONBorOr89dx
C/LUoiis9arZ13HxYiKSedoZ4b6Psh8wVbX+vbV1m7/xRkRuYVkSSjvrYyTvGEet
VdhgsfrmZsRFi8HNpuOUEkFUMvI5oyxPKQ2L0LBu4h5FtwLP0OE66SevYaQmZHw/
ESEDQC4c4MCZG4S/dh/pcFS9Scz9DaOpKMsiUMd/dTeAkQcvHNrBAZD9MhYXBy3m
9mzoDsx7jGkZnxil5E3HE+Zymnc0Ipew3LHoa20VIchePUHgZzZg5a2LKMtyMvgN
lCAmzkidGIajeitWKhhIL7jmstkTqf9m0jvQEe4lqDauNLfJHg7WPVTRJj3tpCgD
lXUS+8rEnreA2H1hpDvh9OAobKklrcMfEwZIdBgaof2gf8n2w6L+SBv2T2dv5f/x
zodlZYXwOT4kqWl6wIaydndhUcdMvNpCxPdoTNJxL2GLXRMGd2oc7GQ69hpOU3tO
X5S51uMBFxvC4fqQAmIQwz2+EmRCoeKrgskg7GLMtS+nmw1vPSqlluD+QBgUfoPq
ZXrmKvg1yr+UBjxxVA7uBop3cYDbfNnucpUlNQyWKcU4iz7DS3M=
=HOad
-----END PGP SIGNATURE-----

--629Jk71OPF8JsKrp4rRSxabAwXWI4sLfJ--

