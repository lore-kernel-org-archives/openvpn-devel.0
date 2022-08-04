Message-ID: <9761477a-73d9-9ec9-6c00-ecb5e8ef5f0b@...2181...>
Date: Thu, 4 Aug 2022 14:07:19 +0200
MIME-Version: 1.0
Content-Language: en-US
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-22-a@...2181...>
 <CAGyAFMV3ZpoDRbwSGWLkPeNNNaP2+Rn87D2Mafa91bEde856cw@...278...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <CAGyAFMV3ZpoDRbwSGWLkPeNNNaP2+Rn87D2Mafa91bEde856cw@...278...>
Subject: Re: [Openvpn-devel] [PATCH 21/25] do_open_tun: restyle "can
 preserve TUN" check
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
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 04/08/2022 13:49, Lev Stipakov wrote:
> Hi,
> 
>> +static bool
>> +can_preserve_tun(struct tuntap *tt)
>> +{
>> +#ifdef TARGET_ANDROID
>> +    return false;
>> +#elif _WIN32
>> +    return tt && tt->dco.real_tun_init;
> 
> Looks like dco.real_tun_init has been added in the very next patch, 22/25.

Darn - must have missed this during the patch split up.

Thanks for pointing this out.

Cheers,

> 

-- 
Antonio Quartulli

