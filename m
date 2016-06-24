References: <20160624140526.GV79504@...1296...>
	<CAFHpkQEtXO1aWSF5v=ivNCx2TzK870tm_StjComxrNWLp1_9LQ@...278...>
	<20160624152932.GW79504@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <576D59FE.90507@...2080...>
Date: Fri, 24 Jun 2016 18:04:14 +0200
MIME-Version: 1.0
In-Reply-To: <20160624152932.GW79504@...1296...>
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
To: Gert Doering <gert@...1296...>, chipitsine@...277...
Cc: openvpn-devel@lists.sourceforge.net

On 24/06/16 17:29, Gert Doering wrote:
> Hi,
> 
> On Fri, Jun 24, 2016 at 07:44:18PM +0500, ???????? ?????????????? wrote:
>> I would suggest powershell instead of perl. I can write powershell stuff
> 
> Fine with me, if someone else writes and maintains it...  I can do a
> bit of .bat scripts, but no powershell.  
> 
> Perl has the advantage of being available on all platforms (or at least
> "you can install it", I know it's not there out of the box everywhere)
> so maybe we can do a common test driver implementation that runs on
> windows and unix, so less maintenance...

That argument can be said about Python as well.  And there's a lot of
different testing resources for Python, a lot of them are unittest
oriented (so not so directly interesting for us) but there are others
which also "drives" external test cases.  Beaker [1] is the one I've
worked most with, but that is overkill in this scenario.  But there are
most likely lots of stuff we can extract and reuse too.  And there are
several others which I don't recall right now.

[1] <https://beaker-project.org/>
    Beaker is the framework Red Hat uses for testing everything which
    ends up being released for RHEL.

We might also consider if there are possibilities for us to integrate
such tests with Travis or similar stuff for platforms where that is
possible.  Often these solutions have Python or Ruby modules available too.


-- 
kind regards,

David Sommerseth


