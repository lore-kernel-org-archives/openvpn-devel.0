References: <20160624140526.GV79504@...1296...>
	<CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
	<20160624152932.GW79504@...1296...>
	<576D59FE.90507@...2080...>
	<20160624173327.GX79504@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <576DA4D1.1040909@...2080...>
Date: Fri, 24 Jun 2016 23:23:29 +0200
MIME-Version: 1.0
In-Reply-To: <20160624173327.GX79504@...1296...>
Subject: Re: [Openvpn-devel] brainstorming: t_client system test equivalent
 for windows?
Reply-To: openvpn-devel@lists.sourceforge.net
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 24/06/16 19:33, Gert Doering wrote:
>> > We might also consider if there are possibilities for us to integrate
>> > such tests with Travis or similar stuff for platforms where that is
>> > possible.  Often these solutions have Python or Ruby modules available too.
>
> While totally interesting, how is this going to help with *Windows* 
> testing (which is what this thread is about)?

Having a standardised testing framework makes it possible to run a
similar set of tests (comparable to what t_client.sh does today) in an
automated way across multiple platforms, and can report these results to
a shared hub.  This way we can run automated tests and catch regressions
which is not caught by our current buildbots ... such as the Windows
platform.

These test cases can then be extended too, to test even more of the
feature sets.  With a good test framework you can for example define
that you have 1 server and 10 clients doing various work in parallel.
Other scenarios can be performance testing, if performance drops below a
predefined limit, we will get alerts ... and so on ... and I did mention
cross platform testing?

But!  Building such a framework takes a lot of time, which is why it is
good to build on what others have already done.  Of those things I've
seen, much of them have been written in Python or Ruby to some degree -
but also a lot of things in bash too for Linux based testing.


-- 
kind regards,

David Sommerseth

