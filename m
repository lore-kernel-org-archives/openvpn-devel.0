Message-ID: <eeacddfd-0819-0afb-4767-0dcc011f8c11@...1227...>
Date: Sun, 5 Dec 2021 03:57:55 +0100
MIME-Version: 1.0
Content-Language: en-GB
References: <20211202125455.2593763-1-arne@...1227...>
 <2116536034.296245.1638548339523@...2642...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <2116536034.296245.1638548339523@...2642...>
Subject: Re: [Openvpn-devel] [PATCH] Make --nobind default for --pull
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
To: Frank Lichtenheld <frank@...2641...>, openvpn-devel@lists.sourceforge.net

Am 03.12.21 um 17:18 schrieb Frank Lichtenheld:
>> Arne Schwabe <arne@...1227...> hat am 02.12.2021 13:54 geschrieben:
>>   
>> -    if (ce->proto == PROTO_TCP_CLIENT && !ce->local
>> -        && !ce->local_port_defined && !ce->bind_defined)
>> -    {
>> -        ce->bind_local = false;
>> -    }
>>   
>> -    if (ce->proto == PROTO_UDP && ce->socks_proxy_server && !ce->local
>> -        && !ce->local_port_defined && !ce->bind_defined)
>> +    bool need_bind = ce->local || ce->local_port_defined || ce->bind_defined;
>> +    bool uses_socks = ce->proto == PROTO_UDP && ce->socks_proxy_server;
>> +
>> +    if (!need_bind && (ce->proto == PROTO_TCP_CLIENT || uses_socks || o->pull))
>>       {
>>           ce->bind_local = false;
>>       }
> 
> The refactoring makes it very hard to see what the actual change is. Maybe it would be better to split this in two commits?
> 
> The only actual change in behavior is the "|| o->pull", right?
> 

Yes. But should I really split up this 5 line patch into two patches? 
That feels a bit excessive.

Arne

