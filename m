Message-ID: <370b8058-0015-56e1-8760-916e48982d3d@...2181...>
Date: Tue, 19 Jul 2022 00:54:21 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-13-a@...2181...> <YtB5P7DEHkHdQwGK@...1296...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <YtB5P7DEHkHdQwGK@...1296...>
Subject: Re: [Openvpn-devel] [PATCH 12/25] dco: check that pulled options
 are compatible
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

On 14/07/2022 22:14, Gert Doering wrote:
> Hi,
> 
> On Fri, Jun 24, 2022 at 10:37:56AM +0200, Antonio Quartulli wrote:
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index b0a4b252..091cbd24 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -2219,6 +2219,19 @@ do_deferred_p2p_ncp(struct context *c)
>>       return true;
>>   }
>>   
>> +
>> +static bool
>> +check_dco_pull_options(struct options *o)
>> +{
> 
> Nitpicking a bit - the "other" DCO option check functions are in dco.c
> (not yet, but in the patches leading up to this), so why is this one in
> init.c?

good point. will move it to dco.c and send v2

Cheers,

> 
> gert

-- 
Antonio Quartulli

