Message-ID: <c5b31e34-1b72-438a-8483-b9fce2c00eba@...2181...>
Date: Tue, 19 Jul 2022 00:50:51 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-7-a@...2181...> <YtAn53rzl8hUkECA@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YtAn53rzl8hUkECA@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 06/25] dco: initialize context and save
 pointer in TLS object
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

On 14/07/2022 16:27, Gert Doering wrote:
> Hi,
> 
> On Fri, Jun 24, 2022 at 10:37:50AM +0200, Antonio Quartulli wrote:
>> Signed-off-by: Antonio Quartulli <a@...2181...>
>> ---
>>   src/openvpn/init.c       | 49 ++++++++++++++++++++++++++++++++--------
>>   src/openvpn/ssl_common.h | 23 +++++++++++++++++++
>>   2 files changed, 63 insertions(+), 9 deletions(-)
> 
> Without trying to understand the code flow in init.c, is there a
> deeper reason why this happens twice?
> 
>> @@ -1708,6 +1717,12 @@ do_open_tun(struct context *c)
>>       /* initialize (but do not open) tun/tap object */
>>       do_init_tun(c);
>>   
>> +    /* inherit the dco context from the tuntap object */
>> +    if (c->c2.tls_multi)
>> +    {
>> +        c->c2.tls_multi->dco = &c->c1.tuntap->dco;
>> +    }
>> +

client code path. The server has no tls-multi object when passing here.

> [..]
> 
>> @@ -2979,12 +2999,20 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
> [..]
>>       /*
>>        * Initialize OpenVPN's master TLS-mode object.
>>        */
>>       if (flags & CF_INIT_TLS_MULTI)
>>       {
>>           c->c2.tls_multi = tls_multi_init(&to);
>> +        /* inherit the dco context from the tuntap object */
>> +        if (c->c1.tuntap)
>> +        {
>> +            c->c2.tls_multi->dco = &c->c1.tuntap->dco;
>> +        }
>>       }
> 
> ... and here again, but only sometimes?

server code path. The client has no tuntap object when passing here 
(it's done quite early, so we need the previous snippet).
The server executes this code for each new client.

I hope this clarifies.

Cheers,

-- 
Antonio Quartulli

