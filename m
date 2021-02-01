From: Arne Schwabe <arne@...1227...>
References: <20200825073643.15920-2-arne@...1227...>
 <20200907162221.20928-1-arne@...1227...>
 <20200907162221.20928-3-arne@...1227...>
 <1664a738-bde5-2a83-2171-8acfffaa9f6d@...2181...>
Message-ID: <4e2b0aef-dea5-9d75-b541-f33cf323dffc@...1227...>
Date: Mon, 1 Feb 2021 15:44:45 +0100
MIME-Version: 1.0
In-Reply-To: <1664a738-bde5-2a83-2171-8acfffaa9f6d@...2181...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH 5/5] Prefer TLS libraries TLS PRF
 function, fix OpenVPN in FIPS mode
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
To: Antonio Quartulli <a@...2181...>, openvpn-devel@lists.sourceforge.net

Am 29.01.21 um 15:09 schrieb Antonio Quartulli:
> Hi,
> 
> witht his review I want to open a broader discussion about the use of
> ASSERT in the OpenVPN code.
> 
> My comments below will get to the point.
> 
> On 07/09/2020 18:22, Arne Schwabe wrote:
>> This moves from using our own copy of the TLS1 PRF function to using
>> TLS library provided function where possible. This includes currently
>> OpenSSL 1.1.0+ and mbed TLS 2.18+.
>>
>> For the libraries where it is not possible to use the library's own
>> function, we still use our own implementation. mbed TLS will continue
>> to use our own old PRF function while for OpenSSL we will use a
>> adapted version from OpenSSL 1.0.2t code. The version allows to be
>> used in a FIPS enabled environment.
>>
> 
> Does this mean that a system that is FIPS enabled running mbedTLS <2.18
> will still not work? Or the old mbedTLS implementeation had no issue?

There is no special FIPS mode in mbed TLS. It just means that for
OpenSSL 1.1.0+ and mbed TLS 2.18+, we rely on a library provided
function instead of implementing the TLS1 PRF ourselves. When we drop
OpenSSL 1.0.2 and mbed TLS <2.18 support our own version can be removed.

For OpenSSL the library function has the additional advantage that it is
considered to be allowed in FIPS mode without special flags etc.

> 
>> The old OpenSSL and mbed TLS implementation could have shared some
>> more code but as we will eventually drop support for older TLS
>> libraries, the separation makes it easier it remove that code
>> invdidually.
>>
>> No FIPS conformitiy testing etc has been done, this is only about
>> allowing OpenVPN on a system where FIPS mode has been enabled system
>> wide (e.g. on RHEL derivates).
> 
> Could you add some description of why we need to change the PRF
> implementation for FISP-enabled systems?


V2 will include this paragraph:

In FIPS mode MD5 is normally forbidden, the TLS1 PRF1 function we
use, makes uses of MD5, which in the past has caused OpenVPN to segfault.
The new implementation for OpenSSL version of our custom implementation
has added the special flags that tell OpenSSL that this specific use
of MD5 is allowed in FIPS mode.


>> +{
>> +    struct gc_arena gc = gc_new();
>> +    uint8_t A1[MAX_HMAC_KEY_LENGTH];
>> +
>> +#ifdef ENABLE_DEBUG
>> +    const int olen_orig = olen;
>> +    const uint8_t *out_orig = out;
>> +#endif
> 
> I think this block above is not needed anymore.

The last line in the function uses it, I just inherited this code:

    dmsg(D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex(out_orig,
olen_orig, 0, &gc));



For the ASSERTs, I will send a follow up patch, which changes this code
path into something that can catch the failure.

Arne

