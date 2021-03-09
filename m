References: <20210308142113.24208-1-arne@...1227...>
 <4db25e12-a9e7-b093-45c5-723642994716@...2181...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <34c9ad17-95e7-c2d1-b2cf-f839b918f087@...1227...>
Date: Tue, 9 Mar 2021 11:54:36 +0100
MIME-Version: 1.0
In-Reply-To: <4db25e12-a9e7-b093-45c5-723642994716@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Avoid a crash in mbed TLS 2.25 with
 --verb < 8
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 09.03.21 um 10:09 schrieb Antonio Quartulli:
> Hi,
> 
> On 08/03/2021 15:21, Arne Schwabe wrote:
> [cut]
> 
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index 0eb049d8..6d908e15 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -5883,6 +5883,12 @@ add_option(struct options *options,
>>      {
>>          VERIFY_PERMISSION(OPT_P_MESSAGES);
>>          options->verbosity = positive_atoi(p[1]);
>> +        if (options->verbosity > 7)
>> +        {
>> +            /* We pass this flag to the SSL library to avoid a bug
>> +             * in mbed TLS 2.5.0 with high log level */
>> +            options->ssl_flags |= SSLF_TLS_DEBUG_ENABLED;
>> +        }
> 
> (2.5.0 is probably a typ0?)

Yes.

> 
> If we know that a certain combination of options + the right mbedTLS
> version will lead to a crash, shouldn't we catch it here (or somewhere
> else) and error out right away?

This one that we know of. But if we do a warning I would rather do a
generic one. The debug logging of mbed TLS seems to be not very well
tested. normally we don't explciitly try to detect and warn about every
obscure bug that we know of. But we could do for this bug:

#if mbed version >= 2.25.0
msg(M_INFO, "Note: mbed TLS 2.25.0 is known to crash on trying too
output x25519 and x448 parameters in debug. If you see mbed TLS crash
after printing out ECDH curve: x25519 you can workaround this bug by
using '--tls-groups secp521r1:secp384r1:secp256r1'");
#endif

>>  #if !defined(ENABLE_DEBUG) && !defined(ENABLE_SMALL)
>>          /* Warn when a debug verbosity is supplied when built without debug support */
>>          if (options->verbosity >= 7)
>> diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
>> index bbb8135d..f821c654 100644
>> --- a/src/openvpn/ssl_common.h
>> +++ b/src/openvpn/ssl_common.h
>> @@ -350,6 +350,7 @@ struct tls_options
>>  #define SSLF_TLS_VERSION_MIN_MASK     0xF  /* (uses bit positions 6 to 9) */
>>  #define SSLF_TLS_VERSION_MAX_SHIFT    10
>>  #define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13) */
>> +#define SSLF_TLS_DEBUG_ENABLED        (1<<14)
>>      unsigned int ssl_flags;
>>  
>>  #ifdef ENABLE_MANAGEMENT
>> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
>> index b30b6b9d..a7b6c2c6 100644
>> --- a/src/openvpn/ssl_mbedtls.c
>> +++ b/src/openvpn/ssl_mbedtls.c
>> @@ -1058,7 +1058,16 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
>>      mbedtls_ssl_config_defaults(ks_ssl->ssl_config, ssl_ctx->endpoint,
>>                                  MBEDTLS_SSL_TRANSPORT_STREAM, MBEDTLS_SSL_PRESET_DEFAULT);
>>  #ifdef MBEDTLS_DEBUG_C
>> -    mbedtls_debug_set_threshold(3);
>> +    /* This works around a crash in mbed TLS 2.25 if Curve25591 is selected
>> +     * for DH (https://github.com/ARMmbed/mbedtls/issues/4208)*/
>> +    if (session->opt->ssl_flags & SSLF_TLS_DEBUG_ENABLED)
>> +    {
>> +        mbedtls_debug_set_threshold(3);
> 
> If a user is on mbedTLS 2.25 and specifies verb = 8 we will then crash
> (assuming the right combination of options was chosen).
> 
> Isn't it better to just always use 2 as threshold when the mbedTLS
> version is known to be buggy (regardless of verb)?
> An ifdef around this invocation would do it, without the need of
> introducing another SSL flag.

I am strongly against removing the possibility to debug mbed TLS
completely just because it *might* crash on a setting that is not used
outside of debugging (verb >= 8).

Also seeing that this bug, it seems that requesting level 3 logging from
mbed TLS is not a good idea in general as the code seems not to be well
tested and there might other high debug print crashes lurking. Also even
though it does not seem to affect performance, currently we generate a
number of debug prints for each packet by requesting level logging from
mbed TLS (crypto operation debug prints).

Arne

