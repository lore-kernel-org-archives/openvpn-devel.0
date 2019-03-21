From: tincanteksup <tincanteksup@...277...>
References: <1552943809-6367-1-git-send-email-selva.nair@...277...>
 <5a54b7c9-d466-c8c2-e468-42c16c88d1dd@...277...>
 <2bf767b9-8459-c0bf-3914-9afaee3093f8@...2181...>
 <CAKuzo_hbxCOTP_y1_4-i-=8WseuxbnjCEpTkgO5tF=oTcO+W_g@...278...>
 <6cfe67e9-4dff-bd34-129d-cb05a3321839@...277...>
 <CAKuzo_gyzh3qzG3skvv54jUvcgzSOx5LMf0B65cpEXEYgtjnVQ@...278...>
 <c2c61582-af55-fd91-7bcc-b15aa84b8c0c@...277...>
Message-ID: <0966e7f3-f9c3-4f4d-f435-a32d29a86712@...277...>
Date: Thu, 21 Mar 2019 05:00:26 +0000
MIME-Version: 1.0
In-Reply-To: <c2c61582-af55-fd91-7bcc-b15aa84b8c0c@...277...>
Content-Language: en-GB
Subject: Re: [Openvpn-devel] [PATCH] Improve the documentation for
 --dhcp-option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>



On 20/03/2019 18:12, tincanteksup wrote:
> bonjour
> 
> On 20/03/2019 17:25, Selva Nair wrote:
>> On Wed, Mar 20, 2019 at 10:52 AM tincanteksup <tincanteksup@...277...>
>> wrote:
>>>
>>>
>>>
>>> On 20/03/2019 13:25, Selva Nair wrote:
>>>> Hi,
>>>>
>>>> On Wed, Mar 20, 2019 at 4:02 AM Antonio Quartulli <a@...2181...> 
>>>> wrote:
>>>>>
>>>>> Hi,
>>>>>
>>>>> On 18/03/2019 22:30, tincanteksup wrote:
>>>>>> Hi,
>>>>>>
>>>>>> this situation has been hanging around for so long is this brief note
>>>>>> really enough? Considering that the manual has numerous other URLs 
>>>>>> why
>>>>>> not include this URL here:
>>>>>> https://community.openvpn.net/openvpn/wiki/Pushing-DNS-to-clients
>>>>>>
>>>>>> We already have this:
>>>>>> https://community.openvpn.net/openvpn/wiki/SWEET32
>>>>>>
>>>>>
>>>>> the problem with URLs is that they become obsolete and we need to
>>>>> re-patch the manual in order to update them (or ensure the URL always
>>>>> work/redirect to something).
>>>>
>>>>
>>>> I have the same opinion about URLs. On top of that the wiki
>>>> description is inadequate and inaccurate. But that's a different
>>>> topic.
>>>
>>> Inadequate:
>>> Compared to NOTHING, the page is at least a step toward documentation.
>>>
>>> Inaccurate:
>>> Please expand ..
>>
>> The wiki states that on Windows using version 2.4, 
>> OpenVPN-GUI+interactive
>> service required for processing this option. Not so.
> 
> I am actively promoting 2.4 use, I am not re-writing the manual.
> 
>> Just as in 2.3, it works if run as admin. In fact, several setups run
>> OpenVPN on boot using OpenVPNService, and --dhcp-option does work for 
>> them.
>> With 2.4, it also works as limited user if started using the interactive
>> service (for example, using OpenVPN-GUI).
> 
> I am actively demoting 2.3 use, I am not re-writing the manual.
> 
>> In both 2.3 and 2.4, the critical piece is not overriding --ipwin32 
>> method
>> (adaptive or dynamic is required and the latter is the
>> default).
>>
> 
> I am actively promoting the use of the Interactive Service.
> I am not rewriting the manual ..
> 
> If a problem arises from using Openvpn as the page describes then,
> depending on the cause, a resolution can be pursued ..
> 
> thanks
> tct
> 

This thread was _initially_ about pushing DNS to Linux clients.



