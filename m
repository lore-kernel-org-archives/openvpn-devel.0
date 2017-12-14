References: <20171212134648.286e2416@...2368...>
 <fee81d29-13f8-a3a1-ef95-5ec1fdf2e479@...515...>
 <20171214111203.3a954204@...2368...>
 <f28bdb55-24cf-ed8f-9dc9-39205f282406@...515...>
 <20171214115311.43a7c9eb@...2368...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c1077ee2-cedf-2507-339a-55c560b18959@...515...>
Date: Thu, 14 Dec 2017 12:26:22 +0200
MIME-Version: 1.0
In-Reply-To: <20171214115311.43a7c9eb@...2368...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] openvpn web frontend, vpnsw
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
To: Borodin Oleg <borodin@...2368...>
Cc: openvpn-devel@lists.sourceforge.net

Il 14/12/2017 11:53, Borodin Oleg ha scritto:
> On Thu, 14 Dec 2017 11:36:46 +0200
> Samuli Seppänen <samuli@...515...> wrote:
> 
>> Il 14/12/2017 11:12, Borodin Oleg ha scritto:
>>> On Thu, 14 Dec 2017 10:41:37 +0200
>>> Samuli Seppänen <samuli@...515...> wrote:
>>>   
>>>> Il 12/12/2017 13:46, Borodin Oleg ha scritto:  
>>>>>
>>>>> Hi!
>>>>>
>>>>> I wrote a small web interface for managing openvpn services and obtaining detail network information. 
>>>>> http://wiki.unix7.org/vpnsw
>>>>>
>>>>> I wrote it to replace a legacy corporate vpn-crutch. 
>>>>> It is already quite working, we manage more 400 tunnels/1200 workplaces.
>>>>>
>>>>> I have a question: how interesting this product is for continue developing? 
>>>>> As opensource, of course.
>>>>>
>>>>> [Sorry, I sent this also to openvpn-users@]    
>>>>
>>>> Hi,
>>>>
>>>> What is the use-case for vpnsw? Is this meant for managing client
>>>> connections on an OpenVPN server?
>>>>  
>>>
>>> Hi, Samuli!
>>>
>>> We use it to disable/enable and monitor user/workstation/branch office groups.
>>> One VPN service on VPN concentrator related to 5-30 VPN "users", total to one
>>> VPNc ~ 100-300, total to company workstation uses VPN direct or indirect ~
>>> 1400. Disconnection use for routine maintenance (synchronization/exchange of
>>> application/corporate databases "into night" =) or urgently needed, and yet
>>> etc).
>>>
>>> I can of course write a control of each user but so far there was no such
>>> purpose. I also can write to show tail of any service log in runtime. 
>>> That's why I'm asking if there is an interest in development.  
>>
>> I'm sure there are others that could make use of vpnsw. I see that it is
>> already on GitHub:
>>
>> <https://github.com/onborodin/vpnsw>
>>
>> If you add a description (like what you have on your site) then people
>> might find it when doing searches. I also noticed that there are no
>> commit messages - is that intentional?
> 
> No-no, of course =) I was developing one, with own svn, quickly, not even thinking
> about publishing, and only today did export/transfer to git repos.
> 
>> I can also mention vpnsw this Trac page:
>>
>> <https://community.openvpn.net/openvpn/wiki/RelatedProjects>
>>
>> That should give vpnsw some additional visibility.
> 
> I agree. This is a good idea.
> 
> 

Hi,

I fixed a bunch of formatting errors on the RelatedProjects page and
added your projects there:

<https://community.openvpn.net/openvpn/wiki/RelatedProjects>

I suggest adding links from vpnsw and minica pages to GitHub so that
people know where they should send their contributions.

Any particular reason why you chose the "Creative Commons
Attribution-NoDerivs 3.0 Unported" license for you work? That is fairly
uncommon license for software projets.

-- 
Samuli Seppänen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

