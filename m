References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-7-a@...2181...> <YT9GjxtLencLAZlr@...1296...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <68b66441-4247-32d5-ebef-fc7da751ec8b@...2181...>
Date: Mon, 13 Sep 2021 21:21:21 +0200
MIME-Version: 1.0
In-Reply-To: <YT9GjxtLencLAZlr@...1296...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH 6/7] set TLS 1.2 as minimum by default
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 13/09/2021 14:39, Gert Doering wrote:
> Hi,
> 
> On Sat, Sep 04, 2021 at 11:56:28AM +0200, Antonio Quartulli wrote:
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index f2fb6d64..6f6eb73d 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -850,6 +850,7 @@ init_options(struct options *o, const bool init_gc)
>>      o->use_prediction_resistance = false;
>>  #endif
>>      o->tls_timeout = 2;
>> +    o->ssl_flags = (TLS_VER_1_2 << SSLF_TLS_VERSION_MIN_SHIFT);
>>      o->renegotiate_bytes = -1;
>>      o->renegotiate_seconds = 3600;
>>      o->renegotiate_seconds_min = -1;
> 
> This code confuses me.  We now unconditionally initialize ssl_flags to
> "TLS_VER_1_2"...

Good catch!
I think this hunk should just go.

> 
>> @@ -3140,6 +3141,21 @@ need_compatibility_before(const struct options *o, int version)
>>  static void
>>  options_set_backwards_compatible_options(struct options *o)
>>  {
>> +    /* TLS min version is not set */
>> +    if ((o->ssl_flags & SSLF_TLS_VERSION_MIN_MASK) == 0)
>> +    {
> 
> ... and then we check if that happens to be "0", so we can invoke the
> compat handler...
> 
> The first hunk looks wrong.

It does. The "new default" is set in the else branch of this hunk.
Therefore there is no need to "preset" a default value in init_options().

Cheers,

-- 
Antonio Quartulli

