Message-ID: <32aae0d4-d225-a5c1-3ee2-2b03b184d324@...2181...>
Date: Tue, 20 Sep 2022 21:25:48 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220818084825.187755-1-a@...2181...>
 <20220918220618.31112-1-a@...2181...> <YyntXHQMcmih8aLE@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YyntXHQMcmih8aLE@...1296...>
Subject: Re: [Openvpn-devel] [PATCH v4] push-peer-info: rearrange function
 generating peer info
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

On 20/09/2022 18:42, Gert Doering wrote:
> Hi,
> 
> On Mon, Sep 19, 2022 at 12:06:18AM +0200, Antonio Quartulli wrote:
>> +    switch (session->opt->push_peer_info_detail)
>>       {
>> -        /* push version */
>> -        buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
>> +        case 3:
>> +        {
> ...
>> +        }
>>   
>> +        /* fall through */
> 
> These {} brackets are not needed by C or our style guide.

they are required when the first instruction after a case label is a 
variable declaration. So this is needed for case 3, but could be avoided 
for the other 2.

Cheers,

-- 
Antonio Quartulli

