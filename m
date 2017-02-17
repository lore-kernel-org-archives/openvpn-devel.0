MIME-Version: 1.0
Sender: emmanueldeloget53@...277...
In-Reply-To: <20170217174223.GV93896@...1296...>
References: <CAKh=nwGz-NSEcSY9KhQ12gC1GNXP6XOBTEO3FdP8gyJN5VTggg@...278...>
	<20170217164131.GU93896@...1296...>
	<CAKh=nwFeHQ5DaCeRHnYswwfMiNMyysvsx=RHg9kDLZuLw=GwGg@...278...>
	<20170217174223.GV93896@...1296...>
From: Emmanuel Deloget <logout@...260...>
Date: Fri, 17 Feb 2017 22:59:14 +0100
Message-ID: <CAKh=nwF4VJSDAE-fb0my1r64UUjXZjugj6ERfmNKnzgeZ_1_Jw@...278...>
Subject: Re: [Openvpn-devel] build against openssl 1.1.0
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello,

On Fri, Feb 17, 2017 at 6:42 PM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Fri, Feb 17, 2017 at 06:37:04PM +0100, Emmanuel Deloget wrote:
>> I guess the answer to the riddle is: "how long will the 2.4 branch
>> live?". v2.3 shipped in May 2013. If we assume that v2.4 will be the
>> stable branch for two more years (I cannot find any roadmap, so this
>> is pure speculation) then it might make sense for 2.5 to at least
>> remove support for OpenSSL v0.9.8 (it would have been EoL'd for 3
>> years by then).
>
> We have *plans* to release 2.5 faster than "it takes another 3 years",
> but we said so when planning 2.4 as well.

That's good to know :) Is there any roadmap available to the general public?

> Since David pointed out already that RHEL5 is going to be EOLed soon,
> I do not thing 0.9.8 is an important target anymore.  Depending on the
> amount of #ifdef etc., it might make sense to drop 0.9.8 support in
> 2.4, but only add 1.1 support to master/2.5 - we're early in the 2.4
> cycle, which allows "somewhat larger" changes, but 500+ insertions
> sounds like a bit too intrusive.

I'm not targetting 2.4 -- my work is done on the current master. Adding
hundreds of lines to the current 2.4 for the purpose of supporting a library
which is not yet present on the user systems does not make much sense :)

BR,

-- Emmanuel Deloget

