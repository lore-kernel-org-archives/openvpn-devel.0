References: <20210415230545.22317-1-themiron@...2010...>
 <20210416120708.1532-1-themiron@...2010...>
 <022e18d6-67ae-8975-9d41-49d19c41a0be@...2181...>
 <01ed01d732ce$ed39d100$c7ad7300$@yandex-team.ru>
From: Antonio Quartulli <a@...2181...>
Message-ID: <5544ff78-e0ef-927f-b581-dbd73282686f@...2181...>
Date: Fri, 16 Apr 2021 17:01:24 +0200
MIME-Version: 1.0
In-Reply-To: <01ed01d732ce$ed39d100$c7ad7300$@yandex-team.ru>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3 1/2] Fix IPv4 default gateway with
 multiple route tables
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

Hi,

On 16/04/2021 16:43, Vladislav Grishenko wrote:
> Hi,
> 
>> However, to prevent the next casual reader from asking the same question,
>> wouldn't it make sense to change this comparison with:
>>
>> if (res->table != RT_TABLE_UNSPEC && res->table != table)
> 
> I don’t think it's necessary for following reasons:
> 1. Readability. "if (res->table)" reads as "if filter table is set ". Changing it to "if (res->table != RT_TABLE_UNSPEC)" gives the same reading imho.
> 2. RT_TABLE_UNSPEC was and will be always zero, because zillion of software incl. iproute2 depends on zeroed structs with 0 == UNSPEC
> 3. Comparing with RT_TABLE_UNSPEC here will require additional code to explicitely init res.table with RT_TABLE_UNSPEC, which in fact is will be noop after CLEAR(res) and have little sense, since there's no chance to have RT_TABLE_UNSPEC != 0.
> Anyway, if you still thinks it's required, I can do change.

No, it's ok. You are right that 0 is just assumed to be the UNSPEC
filter (i.e. don't filter). Let's keep it as it is.

> 
>> Another question: why restricting the research to the MAIN table only for IPv4
>> and only when searching a default route?
> 
> For real dst, incl ::/128 we do the right thing - perform "ip route get" that will get real gateway for specified dst no matter what table or anything else is.
> And we performs "ip route show" dump only to get gateway for "0.0.0.0" destination by a reason.
> Getting default gateway for "0.0.0.0/0" destination is not logically possible at all, for example what is default gateway for this case:
> 	0.0.0.0/1 via a.a.a.a
> 	128.0.0.0/1 via b.b.b.b
> Therefore for 0.0.0.0/0 case heuristic is used, if there's  a default route, if it's in main table and so on, that’s why only dumping needs it.
> Any other - don't.
>  
>> Otherwise we are fixing this problem only for the ipv4/default search, but the
>> function remains "buggy" for the other cases.
> 
> Buggy here is searching default gateway for 0.0.0.0/0 itself. Other cases are right from the scratch :)
> 

Right. The problem I was seeing is simply that we are not providing all
info to the kernel as we should.
This requires further improvement later, but not as part of this fix :-)

So the patch is fine as it is, thanks!

Acked-by: Antonio Quartulli <antonio@...515...>

@Gert: this should go to 2.5 too. Thanks!


Regards,

-- 
Antonio Quartulli

