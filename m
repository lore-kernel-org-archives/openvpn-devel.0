References: <20150830002336.32791c7b.movrax-dev@...2061...>
	<20150830115444.GU34798@...1296...>
	<20150830162534.4ee0c9f2.movrax-dev@...2061...>
	<20150830203749.GW34798@...1296...>
	<20150903221836.04306e51.movrax-dev@...2061...>
From: Steffan Karger <steffan@...1856...>
Message-ID: <5612D2DB.8090007@...1856...>
Date: Mon, 5 Oct 2015 21:43:23 +0200
MIME-Version: 1.0
In-Reply-To: <20150903221836.04306e51.movrax-dev@...2061...>
Subject: Re: [Openvpn-devel] [PATCH] Privileges not being dropped if the
 first connection is not successful
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
To: openvpn-devel@lists.sourceforge.net


On 03-09-15 22:18, Lukasz K. wrote:
>> While the patch is designed to only fix the problem I was thinking if
>> it wouldn't be perhaps better to rename "context_0.uid_gid_set" to
>> something more function related like "context_0.uid_gid_chroot_set",
>> to make it more obvious for people who would look at the code in the
>> future that this member is actually meant for the function in general,
>> not only a certain part of it (UID/GID).
>
> With above in mind I decided to introduce this change to the patch.
>
> I also included few other "improvements" to make the function appear
> more consistent and more obvious (like "c0->uid_gid_chroot_set = true"
> separated and put at the end of the block).
>
> At this point I'm leaving it up to you guys, this is just my another
> suggestion, compiled & tested with latest git ([2.3_git
> [git:master/291c227d2ccecaa9+]).

Thanks.  This version looks good to me, but the patch won't apply.  Most 
likely your MUA messed up line wrapping.  Could you resend the patch 
using 'git send-email', or alternatively as an attachment?

-Steffan

