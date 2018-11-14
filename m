References: <20181007215837.489-1-arne@...1227...>
 <20181031165954.6139-1-arne@...1227...>
 <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <c1ef90b8-27e9-6580-227f-b8684b5f905f@...1227...>
Date: Wed, 14 Nov 2018 15:32:06 +0100
MIME-Version: 1.0
In-Reply-To: <CAKuzo_hHO-3sb8oXybSe--kEj4xS96PSG+LDjuUTUjByE8JRdA@...278...>
Content-Language: de-DE
Subject: Re: [Openvpn-devel] [PATCH v5 2/2] Add support for OpenSSL TLS 1.3
 when using management-external-key
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

>> For TLS 1.0 to 1.2 and OpenSSL 1.1.0 calls us and requires a PKCS1
>> padded response. As TLS 1.3 mandates RSA-PSS padding support and also
>> requires an TLS 1.3 implementation to support RSA-PSS for older TLS
>> version, OpenSSL will query us to sign an already RSA-PSS padded
>> string.
>>
>> This patch adds an 'unpadded' and 'pkcs1' parameter to the
>>
>> management-external-key option to signal that the client is
>> able to support pkcs1 as well as unpadded signature requests.
> 
> 
> "unpadded" in past tense is confusing -- I suggest "nopadding" or "raw" or
> "rsa-raw" to indicate that what it expects to do is a raw signature
> (or no padding will be added) which means the caller should do the padding.
> In  such cases the input will be invariably of the same size as the modulus
> and there is no room for padding anyway.
> 
> (NB: in the code proper, you do use "nopadding" and not "unpadded"
> which is better -- but also see below)

Note, will use nopadding consistently in the next patch.


> That said, I still fail to warm up to the idea of adding a parameter to
> management-external-key. First, even with this precaution, signing can
> fail in two cases:
> 
> (i) the config file has "--management-external-key nopadding" but the
> client version is <= 2. In such cases no warning will be printed but
> management will get prepadded data with no ALG indicator which the
> external signer will definitely fail to treat as PKCS1. Either signing will fail
> (not sure how an existing  client would handle that) or connection
> will restart with verification error.

I can add an extra warning to print if the client will not announce a
new version. But I think that config will not really happen (the tightly
coupled argument)


> 
> So, in short,  I suggest to just leave the management-external-key option alone
> and only add a new parameter to PK_SIGN (more on that below) and make sure
> the external sign dispatcher does not error out when padding is not PKCS1
> (ie. support at least RSA_PADDING_NONE and RSA_PADDING_PKCS1  in
> rsa_priv_enc() for now)
> 
> The early erroring out is only marginally useful as it does not catch
> all cases as argued above. Also a user may try to deal with the error by setting
> tls version max to 1.2 but that will also fail when openssl 1.1.1 is use -- this
> time without triggering the early error-out. So we gain little by
> mutilating this
> option and all the complications it brings.
> 
> The patch will be considerably simple once this change is taken out.

I get what you saying here but that breaks compability with management
clients that are on the old pkcs1/mangement interface.

> In any case, both here (if we retain this) and in PK_SIGN a more generic
> signalling is required. Else we wont be able to support external PSS
> padding later -- just padding = PSS is not enough to do that, the hash
> algorithm is
> also required. The same is true for PKCS1 too but currently we do not support
> external signer to add digest info for PKCS1 signatures. But going forward,
> some external signers would need that option.
> 
> I would suggest: PKS_SIGN <base64data>,ALG
> where
> ALG = RSA_NONE_PKCS1 (current default),
>           RSA_RAW (or RSA_NONE_NOPADDING)
>          RSA_<hash-alg>_PKCS1
>          ECDSA (current default if key is EC)
> with ALG missing to be interpreted as current defaults (PKCS1
> with digest info already prepended for RSA and ECDSA for EC).
> 

My patch adds exactly that but with slightly different names for the
algorithms.


>>
>> Using the management api client version instead might seem like the
>> more logical way but since we only now that version very late,
>> it would extra logic and complexity to deal with this asynchronous
>> behaviour. Instead just give an error early if OpenSSL 1.1.1 and
>> management-external-key without nopadding is detected.
>>
>> The interface is prepared for signalling PCKS1 and RSA-PSS support
>> instead of signalling unpadded support.
> 
> "instead of" --> "in addition to" ?
> unpadded support --> "signature algorithm to use"
> 
>>
>>
>> Patch v3: fix overlong lines and few other style patches. Note
>>       two overlong lines concerning mbedtls are not fixed as they
>>       are removed/shortend by the mbed tls patch to avoid conflicts
>>
>> Patch v4: Setting minimum TLS version proved to be not enough and
>>       instead of implementing a whole compability layer we require
>>       mangement-clients to implement the new feature when they want
>>       to use OpenSSL 1.1.1
>>
>>       Add a padding=ALGORITHM argument to pk-sig to indicate the
>>       algorithm. Drop adding PKCS1 ourselves.
> 
> The code below adds ",ALG" to PK_SIGN, not padding=ALG to pk-sig.
> Better make the above consistent with that.

Yeah, the commit message is wrong. Noted.


>>  .
>> @@ -833,6 +834,12 @@ END
>>  Base 64 encoded output of RSA_private_encrypt for RSA or ECDSA_sign()
>>  for EC using OpenSSL or mbedtls_pk_sign() using mbed TLS will provide a
>>  correct signature.
>> +The rsa-sig interfaces expects PKCS1 padded signatures for RSA keys
>> +(RSA_PKCS1_PADDING). EC signatures are always unpadded.
>>
>> +
>> +The padding field is only present when pk-sig is used and
>> +currently the following values can be requested PCKS1 and NOPADDING for RSA
>> +certificates and NOPADDING for EC certificates.
> 
> This is totally confusing. There is no reason to distinguish between
> rsa-sig and pk-sig as used by the client although we should encourage all new
> clients to use pk-sig only. These added lines may be replaced by:

That comes from the inflexibility of our management code. I only accepts
pk-sig when quering PKSIG and only accepts rsa-sig when querying RSSIG.


> "For RSA keys, if signature algorithm is "RSA_NONE_PKCS1" or
> unspecified, the data to sign contains the hash with digest info
> header added. If
> the algorithm is RSA_RAW, a raw RSA sign operation should be performed. Base 64
> encoded output of OpenSSL function RSA_private_encrypt() with
> padding=RSA_PADDING_PKCS1 for the first case and
> padding=RSA_PADDING_NONE in the second case creates the correct signature.
> In case of EC keys Base 64 encoded output of ECDSA_sign() provides the correct
> signature."
> 
> And remove those references to ECDSA_sign() and RSA_private_encrypt() earlier.

>>  This capability is intended to allow the use of arbitrary cryptographic
>>  service providers with OpenVPN via the management interface.
>> @@ -840,6 +847,10 @@ service providers with OpenVPN via the management interface.
>>  New and updated clients are expected to use the version command to announce
>>  a version > 1 and handle '>PK_SIGN' prompt and respond with 'pk-sig'.
>>
>> +The older rsa-sig and pk-sig interfaces hav no capability to indidicate the
>> +requested padding algorithm. When the 'nopadding' using version >= 2 is required.
>> +To support TLS 1.3 with OpenSSL 1.1.1 supporting unpadded signatures is required.
>> +
> 
> 
> Again, confusing. If you want to reiterate this what about:
> "The signature algorithm is indicated in the PK_SIGN request only if the
> or management client-version is > 2.  In particular, to support TLS1.3 and
> TLS1.2 using OpenSSL 1.1.1, non-pkcs1 padded signature support is required
> and this can be indicated in the signing request only if the client
> version is > 2."

Yes, your wording is better.

>>  char *
>>  /* returns allocated base64 signature */
>> -management_query_pk_sig(struct management *man,
>> -                         const char *b64_data)
>> +management_query_pk_sig(struct management *man, const char *b64_data,
>> +                        const char *padding)
> 
> 
> Suggest to change padding -> sign_alg

Okay.

>>
>>  {
>>      const char *prompt = "PK_SIGN";
>>      const char *desc = "pk-sign";
>> +    struct buffer buf_data = alloc_buf(strlen(b64_data) + strlen(padding) + 20);
>> +
>>      if (man->connection.client_version <= 1)
>>      {
>>          prompt = "RSA_SIGN";
>>          desc = "rsa-sign";
>>      }
>> -    return management_query_multiline_flatten(man, b64_data, prompt, desc,
>> +
>> +    buf_write(&buf_data, b64_data, (int) strlen(b64_data));
>> +    if (man->connection.client_version > 2)
>>
>> +    {
>> +        buf_write(&buf_data, ",", (int) strlen(","));
>> +        buf_write(&buf_data, padding, (int) strlen(padding));
>> +    }
>> +    char* ret = management_query_multiline_flatten(man,
>> +            (char *)buf_bptr(&buf_data), prompt, desc,
>>              &man->connection.ext_key_state, &man->connection.ext_key_input);
>> +    free_buf(&buf_data);
>> +    return ret;
>>  }
>>
>>  char *
>> diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
>> index d24abe09..4bfcfdbe 100644
>> --- a/src/openvpn/manage.h
>> +++ b/src/openvpn/manage.h
>> @@ -31,7 +31,7 @@
>>  #include "socket.h"
>>  #include "mroute.h"
>>
>> -#define MANAGEMENT_VERSION                      2
>> +#define MANAGEMENT_VERSION                      3
>>  #define MANAGEMENT_N_PASSWORD_RETRIES           3
>>  #define MANAGEMENT_LOG_HISTORY_INITIAL_SIZE   100
>>  #define MANAGEMENT_ECHO_BUFFER_SIZE           100
>> @@ -341,12 +341,18 @@ struct management *management_init(void);
>>  #ifdef MANAGEMENT_PF
>>  #define MF_CLIENT_PF         (1<<7)
>>  #endif
>> -#define MF_UNIX_SOCK       (1<<8)
>> -#define MF_EXTERNAL_KEY    (1<<9)
>> -#define MF_UP_DOWN          (1<<10)
>> -#define MF_QUERY_REMOTE     (1<<11)
>> -#define MF_QUERY_PROXY      (1<<12)
>> -#define MF_EXTERNAL_CERT    (1<<13)
>> +#define MF_UNIX_SOCK                (1<<8)
>> +#define MF_EXTERNAL_KEY             (1<<9)
>> +#define MF_EXTERNAL_KEY_NOPADDING   (1<<10)
>> +#define MF_EXTERNAL_KEY_PKCS1PAD    (1<<11)
>> +#define MF_UP_DOWN                  (1<<12)
>> +#define MF_QUERY_REMOTE             (1<<13)
>> +#define MF_QUERY_PROXY              (1<<14)
>> +#define MF_EXTERNAL_CERT            (1<<15)
>> +
>> +#define MF_RSA_PKCS1_PADDING       1
>> +#define MF_RSA_NO_PADDING          2
>> +
> 
> 
> These extra defines and associated code  can go if --management-external-key
> is not changed.
> 
>>
>>
>>  bool management_open(struct management *man,
>>                       const char *addr,
>> @@ -430,7 +436,8 @@ void management_learn_addr(struct management *management,
>>
>>  #endif
>>
>> -char *management_query_pk_sig(struct management *man, const char *b64_data);
>> +char *management_query_pk_sig(struct management *man, const char *b64_data,
>> +                              const char* pading);
> 
> 
> pading -> padding for consistency..
> But padding -> sign_alg is my preference.
> 
>>
>>
>>  char *management_query_cert(struct management *man, const char *cert_name);
>>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 406669a3..2291dd9d 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -2141,6 +2141,23 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
>>
>>  #endif
>>
>> +#if defined(ENABLE_CRYPTOAPI)
>> +    if (o->cryptoapi_cert && (tls_version_max() >= TLS_VER_1_3))
>> +    {
>> +        msg(M_ERR, "Cryptoapi support currently is incompatible "
>> +                   "with OpenSSL 1.1.1/TLS 1.3");
>> +    }
> 
> 
> TLS1.2 is also affected but for now ok like this.
> I have a fix to support PSS in cryptoapi, just have to find some time to test it
> thoroughly. Sigh..

I added these few lines as they quick to remove and point an error in
configuration at the moment. And what tls_version() does NOT report the
version that is currently enabled but the maximum TLS version that the
SSL library supports. So it will always error out on OpenSSL 1.1.1 and
crypto api use.

> 
>> +#endif
>> +#if  defined(ENABLE_MANAGEMENT)
>> +    if ((tls_version_max() >= TLS_VER_1_3) &&
>>
>> +        (options->management_flags & MF_EXTERNAL_KEY) &&
>> +        !(options->management_flags & (MF_EXTERNAL_KEY_NOPADDING))
>>
>> +        )
>> +    {
>> +        msg(M_ERR, "management-external-key with OpenSSL 1.1.1 requires "
>> +                   "the nopadding argument/support");
>> +    }
> 
> 
> Same as above but I think this check is not that useful..

The check can be translated as "If you use management-external-key with
OpenSSL 1.1.1 you need to support the new API"


I removed the rest of comment as I agree with them.

But in summary.

My patch basically amounts to: Support old style management-external-key
with <= OpenSSL 1.1.0 and use and require a new API if we have OpenSSL
1.1.1 and to really move and have external key have a sane API, we would
drop rsa-sig and support for older clients, even with <= OpenSSL 1.1.0
as you oppose my proposl for signalling that a new API should be used.
(version in managemnet protocol is too late and not feasible in my opinion)
Supporting a half working RSA_SIG option that breaks left and right is
not desirable in my opinion.

I would be really happy to drop the old support if no one objects.

Arne

