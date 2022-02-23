Message-ID: <57f29bfd-75bf-313d-6a7e-a3009ca20233@...2181...>
Date: Wed, 23 Feb 2022 11:12:07 +0100
MIME-Version: 1.0
Content-Language: en-US
From: Antonio Quartulli <a@...2181...>
References: <20220222132824.18935-1-kprovost@...2661...>
 <5dc75b83-51ac-fd7d-1188-cb5b1aa6187a@...2181...>
In-Reply-To: <5dc75b83-51ac-fd7d-1188-cb5b1aa6187a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH DCO]: cleanups prior to FreeBSD DCO
 support
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Kristof,

On 22/02/2022 15:07, Antonio Quartulli wrote:
> Hi Kristof,
> 
> On 22/02/2022 14:28, Kristof Provost via Openvpn-devel wrote:
>> Hi,
>>
>> As said in my e-mail (from kp@...1376..., Feb 17th), I'm working on
>> adding DCO support for FreeBSD.
>> I ran into a few minor issues that are not directly related, but should
>> be addressed anyway.
>>
>> These patches are all against https://github.com/OpenVPN/ovpn-dco
>>
> 
> Thanks a lot for these fixes!
> 
> Since the ovpn-dco branch is not yet merged, I will squash your patches 
> with the offending code directly.

Patches have been squashed with some modification.
In particular, I remodeled a bit patch 3/3 to make the ifdef logic the 
same as in socket.h (where the link_socket_actual struct is defined).

Please have a look :-)


Regards,

-- 
Antonio Quartulli

