MIME-Version: 1.0
In-Reply-To: <20140820092928.GX1118@...1296...>
References: <CAFLxGvy77WaHhrsqSfm2Va4fbD_y5Ta5ykMsczCQ=-Z9AkNjnQ@...278...>
	<20140820081530.GW1118@...1296...>
	<CAFLxGvwEEVZvpkR446Ye+aPLFw0YW=MJivYZsL2e9h2gKDrPzA@...278...>
	<20140820092928.GX1118@...1296...>
Date: Wed, 20 Aug 2014 11:51:52 +0200
Message-ID: <CAFLxGvy9yyxRnuwAAcLxPp+ZzyP42CXWQLDpzr34pH3XNsBoXg@...278...>
From: Richard Weinberger <richard.weinberger@...277...>
Subject: Re: [Openvpn-devel] Ongoing Windoes 8 issues
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
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On Wed, Aug 20, 2014 at 11:29 AM, Gert Doering <gert@...1296...> wrote:
> Hi,
>
> On Wed, Aug 20, 2014 at 10:17:01AM +0200, Richard Weinberger wrote:
>> On Wed, Aug 20, 2014 at 10:15 AM, Gert Doering <gert@...1296...> wrote:
>> > On Wed, Aug 20, 2014 at 09:32:46AM +0200, Richard Weinberger wrote:
>> >> This bug exists for almost 14 months (!!) without a solution.
>> >> Some hacks work some not.
>> >> https://community.openvpn.net/openvpn/ticket/316
>> >>
>> >> I really wonder why this issue is ignored by the OpenVPN developers.
>> >
>> > We'll send you a refund for the money you've paid.
>>
>> Nice attempt to be funny.
>
> I wasn't trying to be funny.  Complaining about "it's not happening fast
> enough" with lots of expclamation marks about something you didn't pay
> anything for isn't really motivating volunteers to spend their free time
> on your issues.

Okay, let's come down a bit and have a cup of coffee first.
Sorry for being rude, this was not my intention.

I don't expect people to solve problems for free and I'm well aware how
free software development works. There is a good chance that you
currently use free software
where I did some work.

But if there is an issue with almost no reaction from developers
within 14 months
I begin to wonder WTF is going on.
A simple "We're working on it..." would not harm.

>> > Seriously: because the amount of free time people can invest is limited,
>> > and Windows RT isn't high on the personal pain list for one of the Community
>> > developers.  If it bothers you so much, take the source and fix the issue,
>> > we're happy to review and merge the fixes.
>>
>> Windows RT != Windows 8.
>
> Last thing I saw in the ticket was about Windows RT on a tablet.
>
> OTOH, for regular Win 8, this has been fairly tricky to reproduce - I use
> OpenVPN in a commercial environment with users on Win 8 and 8.1 (64bit),
> and have received no single complaint from any of them.  So it's not like
> "it does not work on Win 8, period" but "something is different here".

The original bug report came from we.
I'm facing the issue on many Windows 8.x clients.

> Plus, you nicely overlooked this bit here:
>
>> > OTOH, OpenVPN Tech *has* started tackling the issue and funded work for a
>> > NDIS6 tap driver (which is more than "just recompile") - which nobody
>> > tested for about half a year, so the remaining bugs have only been
>> > uncovered recently when Samuli started to ship all the windows installers
>> > "for Vista and up" with the NDIS6 driver by default.
>
> ... so, you might want to give this a try.

I did not know about the new NDIS6 drivers. Now there is a comment
mentioning it. Thanks for
that. This is all I wanted.

-- 
Thanks,
//richard

