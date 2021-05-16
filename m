References: <E1lSJph-0004I0-FL@...2479...>
 <8b081dd5-2c1d-c71b-8af0-d4c886e4260e@...1227...>
 <E1lTjOz-0003I1-MM@...2479...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <8d0af093-f901-e378-79e3-f377bbce5458@...1856...>
Date: Sun, 16 May 2021 15:48:26 +0200
MIME-Version: 1.0
In-Reply-To: <E1lTjOz-0003I1-MM@...2479...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH] Change CTR DRBG update function call to
 new mbedtls 2.16.0 API
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi,

On 06-04-2021 12:55, Maximilian Fillinger wrote:
>> Am 02.04.21 um 15:26 schrieb Max Fillinger:
>>> From: Uipko Berghuis <uipko.berghuis@...1435...>
>>>
>>> In mbedtls 2.16.0 mbedtls_ctr_drbg_update() changed to
>>> mbedtls_ctr_drbg_update_ret(). Change the function name and handle the
>>> new return value error code.
>>> ---
>>>  src/openvpn/ssl_mbedtls.c | 5 ++++-
>>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
>>> index 5d7af351..56e9f045 100644
>>> --- a/src/openvpn/ssl_mbedtls.c
>>> +++ b/src/openvpn/ssl_mbedtls.c
>>> @@ -950,7 +950,10 @@ tls_ctx_personalise_random(struct tls_root_ctx
>>> *ctx)
>>>
>>>          if (0 != memcmp(old_sha256_hash, sha256_hash,
>> sizeof(sha256_hash)))
>>>          {
>>> -            mbedtls_ctr_drbg_update(cd_ctx, sha256_hash, 32);
>>> +            if (!mbed_ok(mbedtls_ctr_drbg_update_ret(cd_ctx,
>> sha256_hash, 32)))
>>> +            {
>>> +                msg(M_WARN, "WARNING: failed to personalise random,
>> could not update CTR_DRBG");
>>> +            }
>>>              memcpy(old_sha256_hash, sha256_hash,
>> sizeof(old_sha256_hash));
>>>          }
>>>      }
>>>
>>
>> This change will break compilation with anything that is < 2.16.0.
> 
> This function is deprecated in 2.16. I don't mind keeping this change to
> OpenVPN-NL for now, but for future reference, what's the best solution
> when a new version of mbedtls removes the function?

I'd say add a compat-wrapper, like we have many for openssl. Possibly in
compat-mbedtls.h (mimicing the openssl code) or just in crypto_mbedtls.h
if we don't have many. Something like (untested/"pseudo"code):

#if MBEDTLS_VERSION < 2.16
static inline int mbedtls_ctr_drbg_update_ret(ctx, h, len)
{
    mbedtls_ctr_drbg_update(ctx, h, len);
    return 0;
}
#endif

-Steffan

