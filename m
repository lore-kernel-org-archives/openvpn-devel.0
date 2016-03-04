References: <1456993146-63968-1-git-send-email-james@...515...>
	<1456993146-63968-2-git-send-email-james@...515...>
	<56D8CD3E.2070403@...1227...> <56D93976.1090906@...515...>
	<56D95A46.9060802@...1227...>
From: James Yonan <james@...515...>
Message-ID: <56D9DE33.2050806@...515...>
Date: Fri, 4 Mar 2016 12:12:51 -0700
MIME-Version: 1.0
In-Reply-To: <56D95A46.9060802@...1227...>
Subject: Re: [Openvpn-devel] [PATCH 02/10] Added PIP_OPT_MASK for
 process_ip_header fast exit path.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net



On 04/03/2016 02:49, Arne Schwabe wrote:
>
> Am 04.03.16 um 08:29 schrieb James Yonan:
>> On 03/03/2016 16:48, Arne Schwabe wrote:
>>> Am 03.03.16 um 09:18 schrieb James Yonan:
>>>> Define PIP_OPT_MASK to represent all flags of interest to
>>>> process_ip_header, so that it can have a fast exit path
>>>> if no flags are set.
>>> Basically what this patch does is to change the condition to
>>>
>>> if (flags)
>>>
>>> and if for example PASSTOS_CAPABILITY is not 1, the following path will
>>> always be taken:
>>>
>>>         process_ip_header (c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT,
>>> &c->c2.buf);
>>>
>>> flags mean that possible passtos, mssfix and client_nat should be
>>> applied here.
>>>
>>> #if PASSTOS_CAPABILITY
>>>     if (!c->options.passtos)
>>>       flags &= ~PIPV4_PASSTOS;
>>> #endif
>>>
>>> is not compiled in. So flags is at least PIPV4_PASSTOS
>>>
>>> So if (flags & 0xffff) is still true.
>>>
>>> So NACK from me butthe code is very confusing...
>>>
>>> Arne
>> I think what makes this patch confusing is that it's really a patch
>> that facilitates another patch that we've used in the past at OpenVPN
>> Tech. for some custom NAT algs.  This patch reduces the footprint of
>> the second patch, making it easier to maintain.
>>
> Yes. I think I get the intention of the patch. But if this patch should
> work in OpenVPN now we need to replace
>
> #if PASSTOS_CAPABILITY
>    if (!c->options.passtos)
>      flags &= ~PIPV4_PASSTOS;
> #endif
>
> with
>
> #if PASSTOS_CAPABILITY
>    if (!c->options.passtos)
> #endif
>   flags &= ~PIPV4_PASSTOS;
>
> to have the correct behaviour if PASSTOS_CAPABILITY is missing.

Actually, I'm fine to withdraw this patch for now -- it's probably more 
trouble than it's worth.

James


