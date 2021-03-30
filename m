From: Antonio Quartulli <a@...2181...>
References: <CAAUX2SXSu=izbxjAiUNfuezsrv6NbQrrL7R7pQh8P4uumzQemw@...278...>
 <73707b45-c5fa-261e-2a7a-e7a03794c3ba@...1227...>
Message-ID: <14d7cf12-9863-6d1d-1134-0f80dc498d2d@...2181...>
Date: Tue, 30 Mar 2021 16:37:08 +0200
MIME-Version: 1.0
In-Reply-To: <73707b45-c5fa-261e-2a7a-e7a03794c3ba@...1227...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [ovpn-dco] try to port to kernel 4.14.76,
 but can not join AF_NETLINK group
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
To: Arne Schwabe <arne@...1227...>, Tony He <huangya90@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi Tony,

On 30/03/2021 12:23, Arne Schwabe wrote:
> Am 30.03.21 um 09:36 schrieb Tony He:
>> Hi Antonio, Arne,
>>
>> Sorry to bother you. I have a router based on Linux kernel
>> 4.14.76(4.14.x is LTS version). Because of some reasons, 
>> it's hard to upgrade to v5.x to play ovpn-dco. So I am porting ovpn-dco
>> to 4.14.76 kernel. After some hacking, it's almost done.
>> Now it seems that  only one issue needs to be resolved. The issue is
>> openvpn 2.6 dco fails to join AF_NETLINK group.
>>
> 
> Note that we currently do not intent to support or do active development
> on such old kernels.
> 

Even if not currently on the roadmap, please let us know if you
encounter particular issues with this kernel. I'd be interested in
hearing about those, if any.

Regards,



-- 
Antonio Quartulli
OpenVPN Inc.

-- 
Antonio Quartulli

