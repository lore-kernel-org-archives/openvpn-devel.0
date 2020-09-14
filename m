From: Antonio Quartulli <a@...2181...>
References: <20200909120707.8663-1-gert@...1296...>
 <20200909122223.9222-1-gert@...1296...>
 <75cfa18c-f0a7-66a1-d329-3c64da69062a@...2181...>
Message-ID: <dcc1eb5c-3f48-c4d1-bb2e-aad2fe0aed2c@...2181...>
Date: Mon, 14 Sep 2020 11:27:17 +0200
MIME-Version: 1.0
In-Reply-To: <75cfa18c-f0a7-66a1-d329-3c64da69062a@...2181...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] socks.c: fix alen for DOMAIN type
 addresses, bump up buffer sizes
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

Hi,

On 14/09/2020 11:04, Antonio Quartulli wrote:
> Hi,
> 
> On 09/09/2020 14:22, Gert Doering wrote:
>> When a SOCKS5 server sends back a reply, it encodes an "address",
>> which can be IPv4 (4 bytes), IPv6 (16 bytes) or "a domain name",
>> which has a lenght (1 byte) and "a string of length <length>" - so
>> when copying bytes, we need to hande "length +1" bytes.
>>
>> Our code totally doesn't use this variant of addresses on reception,
>> but since this has been pointed out by "tpw_rules" in Trac, fix it,
>> so if/when someone works on this again, the foundation is correct.
>>
>> While at it, increase buffer size used for sending to handle domain
>> names longer than 122 characters (length was already checked, so a
>> longer name would not overflow but just "not work").
>>
>> v2: increase buf[] len in recv_socks_reply() from 22 to 270 so it
>>     is large enough to actually copy a domain name
>>
>> v3: increase buf[] len in establish_socks_proxy_passthru() from 128 to
>>     270, to handle long domain names in queries
>>
>> Reported-By: tpw_rules in Trac
>> Trac: #848
>>
>> Signed-off-by: Gert Doering <gert@...1296...>
> 
> After a quick discussion on IRC I am fine with this patch, assuming the
> whitespace is added after the '+' operator.
> 
> Further refactoring of this code will be carried on in later patches.

forgot to add:

Acked-by: Antonio Quartulli <a@...2181...>

-- 
Antonio Quartulli

