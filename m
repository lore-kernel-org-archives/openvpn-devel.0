MIME-Version: 1.0
In-Reply-To: <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
References: <1515959073-10376-1-git-send-email-selva.nair@...277...>
 <1515959073-10376-3-git-send-email-selva.nair@...277...>
 <e059b07e-5684-1dbe-cfdf-1271efc594dc@...1227...>
From: Selva Nair <selva.nair@...277...>
Date: Tue, 16 Jan 2018 18:51:31 -0500
Message-ID: <CAKuzo_jN9EOK5aPr2dn+m+ynarY-Snt2pwOmz9cV32BpKSFq=w@...278...>
Subject: Re: [Openvpn-devel] [PATCH 2/3] Allow external EC key through
 --management-external-key
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
To: Arne Schwabe <arne@...1227...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Hi,

Wow that was fast :)

Thanks for the review. I'll provide a v2, but some quick remarks/rfc

On Tue, Jan 16, 2018 at 5:40 PM, Arne Schwabe <arne@...1227...> wrote:
> Am 14.01.18 um 20:44 schrieb selva.nair@...277...:
>> From: Selva Nair <selva.nair@...277...>
>>
>> - This automatically supports EC certificates through
>>   --management-external-cert
>> - EC signature request from management has the same format
>>   as for rsa with >RSA_SIGN replaced by >ECDSA_SIGN
>>   Response should be of the form 'ecdsa-sig' followed
>>   by DER encoded signature as base64 followed by 'END'
>>
>
>
> Thanks for the code. I implemented and tested this on my Android client.
> It works very well. However I found some minor issues (see below).
>
> Tested-By: Arne Schwabe <arne@...1227...>
>
> But first a high level issue. I think if you enable manange-external-key
> with an "old" ui that only understand rsa keys the OpenVPN client will
> hang after ECDSA prompt since the ui will never reply with anything.
>
> We might need an argument to management-external-key to say "yes I am
> ecdsa ready".

This needs some thought  as config option is not really a way of indicating
client capabilities, or so it seems.

I can see this could pose a problem for clients that currently support
external key.
If there are only a few such known clients we can handle this transparently by
looking at IV_GUI_VER?

>>
>>  static void
>> +man_ecdsa_sig(struct management *man)
>> +{
>> +    struct man_connection *mc = &man->connection;
>> +    if (mc->ext_key_state == EKS_SOLICIT)
>> +    {
>> +        mc->ext_key_state = EKS_INPUT;
>> +        mc->in_extra_cmd = IEC_ECDSA_SIGN;
>> +        in_extra_reset(mc, IER_NEW);
>> +    }
>> +    else
>> +    {
>> +        msg(M_CLIENT, "ERROR: The ecdsa-sig command is not currently available");
>> +    }
>> +}
>> +
>
> This function is almost identical to man_rsa_sign. I would like to have
> them both combined into one and then called by man_ecdsa_sig/man_rsa_sig.

Could combine these into one function named man_external_sig with
an extra parameter, say, cmd = IEC_ECDSA_SIGN or IEC_RSA_SIGN

>
>>
>>
>> +char *
>> +management_query_ecdsa_sig(struct management *man,
>> +                           const char *b64_data)
>> +{
>> +    return management_query_multiline_flatten(man, b64_data, "ECDSA_SIGN", "ecdsa-sign",
>> +                                              &man->connection.ext_key_state, &man->connection.ext_key_input);
>> +}
>
> Hm, could be merged with management_query_rsa_sig but since it a one
> liner I have no strong preference.
>
>
>> +#if OPENSSL_VERSION_NUMBER >= 0x10100001L && !defined(OPENSSL_NO_EC)
>> +
>> +/* called when EC_KEY is destroyed */
>> +static void
>> +openvpn_extkey_ec_finish(EC_KEY *ec)
>> +{
>> +    /* release the method structure */
>> +    const EC_KEY_METHOD *ec_meth = EC_KEY_get_method(ec);
>> +    EC_KEY_METHOD_free((EC_KEY_METHOD *) ec_meth);
>> +}
>> +
>> +/* EC_KEY_METHOD callback: sign().
>> + * Sign the hash using EC key and return DER encoded signature in sig,
>> + * its length in siglen. Return value is 1 on success, 0 on error.
>> + */
>> +static int
>> +ecdsa_sign(int type, const unsigned char *dgst, int dgstlen, unsigned char *sig,
>> +           unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r, EC_KEY *ec)
>> +{
>> +    char *in_b64 = NULL;
>> +    char *out_b64 = NULL;
>> +    int ret = 0;
>> +    int len;
>
> len could just as well be done als inline C99 decleration. But no
> problem. (Also I am not so firm on our new style here)
>
>> +
>> +    /* convert 'from' to base64 *
>> +    if (openvpn_base64_encode(dgst, dgstlen, &in_b64) <= 0)
>> +    {
>> +        goto done;
>> +    }
>> +
>> +    /* call MI for signature */
>> +    if (management)
>> +    {
>> +        out_b64 = management_query_ecdsa_sig(management, in_b64);
>> +    }
>> +    if (!out_b64)
>> +    {
>> +        goto done;
>> +    }
>> +
>> +    /* decode base64 signature to binary */
>> +    len = ECDSA_size(ec);
>> +    *siglen = openvpn_base64_decode(out_b64, sig, len);
>> +    if (*siglen > 0)
>> +    {
>> +        ret = 1;
>> +    }
>> +
>> +done:
>> +    if (in_b64)
>> +    {
>> +        free(in_b64);
>> +    }
>> +    if (out_b64)
>> +    {
>> +        free(out_b64);
>> +    }
>> +    return ret;
>> +}
>
>
> This method has a bit code duplication to rsa_priv_enc but I think it is
> still okay here since you have an rather ugly looking function that is
> hard to read.

Will give it another try to see whether those can be combined without uglifying
things further.

>
>> +
>> +/* EC_KEY_METHOD callback: sign_setup(). We do no precomputations */
>> +static int
>> +ecdsa_sign_setup(EC_KEY *ec, BN_CTX *ctx_in, BIGNUM **kinvp, BIGNUM **rp)
>> +{
>> +    return 1;
>> +}
>> +
>> +/* EC_KEY_METHOD callback: sign_sig().
>> + * Sign the hash and return the result as a newly allocated ECDS_SIG
>> + * struct or NULL on error.
>> + */
>> +static ECDSA_SIG *
>> +ecdsa_sign_sig(const unsigned char *dgst, int dgstlen, const BIGNUM *in_kinv,
>> +               const BIGNUM *in_r, EC_KEY *ec)
>> +{
>> +    ECDSA_SIG *ecsig = NULL;
>> +    int len = ECDSA_size(ec);
>> +    struct gc_arena gc = gc_new();
>> +
>> +    unsigned char *buf = gc_malloc(len, false, &gc);
>> +    if (1 != ecdsa_sign(0, dgst, dgstlen, buf, &len, NULL, NULL, ec))
>
> I am not sure about 1!= style here. Might be okay. I would try to avoid
> this.

Not my favourite either, but for some reason I thought that style was
preferred in ssl_xx files (may be so in ssl_mbedtls.c?). So much "easier"
to write that as xxx != 1 :) Will do.

>
> len should be size_t. My compiler agrees:
>
> ssl_openssl.c:1215:48: warning: passing 'int *' to parameter of type
> 'unsigned int *' converts between pointers to integer types with
> different sign [-Wpointer-sign]
>     if (1 != ecdsa_sign(0, dgst, dgstlen, buf, &len, NULL, NULL, ec))
>                                                ^~~~
>
> ssl_openssl.c:1152:26: note: passing argument to parameter 'siglen' here
>            unsigned int *siglen, const BIGNUM *kinv, const BIGNUM *r,
> EC_KEY *ec)
>                          ^
> 1 warning generated.

Yeah, it should be unsigned int. My bad.

>>  int
>>  tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>>                                   const char *cert_file, const char *cert_file_inline)
>> @@ -1156,11 +1310,26 @@ tls_ctx_use_external_private_key(struct tls_root_ctx *ctx,
>>              goto err;
>>          }
>>      }
>> +#if OPENSSL_VERSION_NUMBER >= 0x10100001L && !defined(OPENSSL_NO_EC)
>> +    else if (EVP_PKEY_get0_EC_KEY(pkey))
>> +    {
>> +        if (!tls_ctx_use_external_ec_key(ctx, pkey))
>> +        {
>> +            goto err;
>> +        }
>> +    }
>> +    else
>> +    {
>> +        crypto_msg(M_WARN, "management-external-key requires an RSA or EC certificate");
>> +        goto err;
>> +    }
>> +#else
>>      else
>>      {
>>          crypto_msg(M_WARN, "management-external-key requires a RSA certificate");
>
> If you touch that line you can as well fix the grammar in the existing
> string that you fixed in the new string :)
>
> Arne

Thanks again,

Selva

