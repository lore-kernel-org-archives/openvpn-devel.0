References: <011701d6858cyandex-team.ru>
 <20200908123625.23179-1-themiron@...2010...>
 <33df2e45-ebd9-fbd5-1fac-e43c4d9090ca@...2080...>
From: Antonio Quartulli <a@...2181...>
Message-ID: <ff1ab111-3b3a-b99a-c99f-ad55c426c61e@...2181...>
Date: Tue, 8 Sep 2020 15:24:57 +0200
MIME-Version: 1.0
In-Reply-To: <33df2e45-ebd9-fbd5-1fac-e43c4d9090ca@...2080...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] [PATCH v3] Fix best gateway selection over
 netlink
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: David Sommerseth <openvpn@...2080...>, Vladislav Grishenko <themiron@...2010...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/09/2020 15:08, David Sommerseth wrote:
> On 08/09/2020 14:36, Vladislav Grishenko wrote:
>> On kernels earlier than 2.6.38 default routes are the last ones,
>> so arbitrary host/net route w/o gateway is likely be returned as
>> first, causing gateway to be invalid or empty.
>> After refactoring in 2.6.38 kernel default routes are on top, so
>> the problem with older kernels was hidden.
> 
> I haven't paid too much attention here, but I don't think I've seen this point
> being brought up.  But do we really care about such old kernels at all?
> 
> AFAIK, RHEL-6 (which goes EOL in November this year and which is not planned
> to be supported in OpenVPN 2.5+) is the only distro carrying such an old
> kernel release (2.6.32 baseline).  Even an internal OpenWRT 19.07 box of mine
> (which should be upgraded, I know!) ships with 4.14.  Unless I'm completely
> clueless (which is a possibility), 2.4 and 2.6 kernels are mostly interesting
> for boards with 4MB flash memory.  And I would suspect such boards with that
> little flash memory to belong to that past.  (And OpenVPN 2.4 is perfectly
> fine too for some time forward anyhow, which should work just fine).

Well, this is an actual flaw in the sitnl code.
It now works, but it may break at some point (it is apparently relying
on a self-made assumption which may not hold true in the future).

For this reason sitnl *needs* fixing.

On the other hand, helping out people that are stuck on old platforms to
upgrade to modern (aka more secure) OpenVPN versions is also not a bad idea.

Since the fix is relatively small, I'd consider it for inclusion.

I'll try to review it ASAP so that it can be considered for going into
the next beta (2.5 compiles with sitnl by default - this is how this
issue was exposed)


Regards,

-- 
Antonio Quartulli

