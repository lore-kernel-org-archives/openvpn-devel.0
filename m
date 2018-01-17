MIME-Version: 1.0
In-Reply-To: <d35efc0b-43f2-ff57-3ba3-88531813b35c@...1435...>
References: <1515378076-5774-1-git-send-email-selva.nair@...277...>
 <1515378076-5774-3-git-send-email-selva.nair@...277...>
 <d35efc0b-43f2-ff57-3ba3-88531813b35c@...1435...>
From: Selva Nair <selva.nair@...277...>
Date: Wed, 17 Jan 2018 10:28:55 -0500
Message-ID: <CAKuzo_iLU6a8C_w-KrO-qeMgW=Wunys50GOQkxGMYxvkZGBiGQ@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/2] TLS v1.2 support for cryptoapicert
 -- RSA only
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan.karger@...1435...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

Thanks for the comments

On Wed, Jan 17, 2018 at 9:20 AM, Steffan Karger
<steffan.karger@...1435...> wrote:
> Hi,
>
> Some preliminary comments:
>
> On 08-01-18 03:21, selva.nair@...277... wrote:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - If an NCRYPT handle for the private key can be obtained, use
>>   NCryptSignHash from the Cryptography NG API to sign the hash.
>>
>>   This should work for all keys in the Windows certifiate stores
>>   but may fail for keys in a legacy token, for example. In such
>>   cases, we disable TLS v1.2 and fall back to the current
>>   behaviour. A warning is logged unless TLS version is already
>>   restricted to <= 1.1
>>
>>

.. snipped..

>> +static int
>> +priv_enc_CNG(const CAPI_DATA *cd, const unsigned char *from, int flen,
>> +              unsigned char *to, int tlen, int padding)
>> +{
>> +    NCRYPT_KEY_HANDLE hkey = cd->crypt_prov;
>> +    DWORD len;
>> +    ASSERT(cd->key_spec == CERT_NCRYPT_KEY_SPEC);
>> +
>> +    msg(M_INFO, "Signing hash using CNG: data size = %d", flen);
>
> M_INFO is probably a bit verbose here.

Yeah, that was more for testing -- will use one of the TLS debug flags -- we
really need to make M_DEBUG print only at some high verbosity.

...


>>      /* Unfortunately, there is no "CryptSign()" function in CryptoAPI, that would
>>       * be way to straightforward for M$, I guess... So we have to do it this
>>       * tricky way instead, by creating a "Hash", and load the already-made hash
>> @@ -322,7 +373,14 @@ finish(RSA *rsa)
>>      }
>>      if (cd->crypt_prov && cd->free_crypt_prov)
>>      {
>> -        CryptReleaseContext(cd->crypt_prov, 0);
>> +        if (cd->key_spec == CERT_NCRYPT_KEY_SPEC)
>> +        {
>> +            NCryptFreeObject(cd->crypt_prov);
>> +        }
>> +        else
>> +        {
>> +            CryptReleaseContext(cd->crypt_prov, 0);
>> +        }
>>      }
>>      if (cd->cert_context)
>>      {
>> @@ -458,7 +516,9 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>>      }
>>
>>      /* set up stuff to use the private key */
>> -    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, CRYPT_ACQUIRE_COMPARE_KEY_FLAG,
>> +    /* We prefer to get an NCRYPT key handle so that TLS1.2 can be supported */
>> +    DWORD flags = CRYPT_ACQUIRE_COMPARE_KEY_FLAG|CRYPT_ACQUIRE_PREFER_NCRYPT_KEY_FLAG;
>> +    if (!CryptAcquireCertificatePrivateKey(cd->cert_context, flags,
>>                                             NULL, &cd->crypt_prov, &cd->key_spec, &cd->free_crypt_prov))
>
> Some rewrapping of the arguments to no longer exceed 80 chars would be
> nice if you touch this anyway.

done :)

>
>>      {
>>          /* if we don't have a smart card reader here, and we try to access a
>> @@ -470,6 +530,17 @@ SSL_CTX_use_CryptoAPI_certificate(SSL_CTX *ssl_ctx, const char *cert_prop)
>>      /* here we don't need to do CryptGetUserKey() or anything; all necessary key
>>       * info is in cd->cert_context, and then, in cd->crypt_prov.  */
>>
>> +    /* If we do not have an NCRYPT key handle disable TLS v1.2 */
>> +    if (cd->key_spec != CERT_NCRYPT_KEY_SPEC)
>> +    {
>> +        if (!(SSL_CTX_get_options(ssl_ctx) & SSL_OP_NO_TLSv1_2))
>> +        {
>
> This no longer works for OpenSSL 1.1, we'll need the patch from
> https://patchwork.openvpn.net/patch/160/ (awaiting review), and then use
> the SSL_CTX_{get,set}_max_proto_version functions instead.

Good point.

Strangely enough it works in some cases -- I had tested with a non-NCRYPT key in
a legacy token and got restricted to TLS1.1. But point noted. And,  anyway,
set_max_proto_version is better, as otherwise we'll have to touch this again
when TLS 1.3 is out.

Will take care of it in v2.

Selva

