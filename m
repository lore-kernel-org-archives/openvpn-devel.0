References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5755C95E.9080401@...2080...>
Date: Mon, 6 Jun 2016 21:05:02 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 04/06/16 07:17, Selva Nair wrote:
> 
> 
> On Fri, Jun 3, 2016 at 2:37 PM, Selva Nair <selva.nair@...277...
> <mailto:selva.nair@...277...>> wrote:
> 
> 
>     On Fri, Jun 3, 2016 at 2:14 PM, Gert Doering <gert@...1296...
>     <mailto:gert@...1296...>> wrote:
> 
>         On Fri, Jun 03, 2016 at 07:49:23PM +0200, David Sommerseth wrote:
>         > From: David Sommerseth <dazo@...2145...
>         <mailto:dazo@...2145...>>
>         >
>         > Continuing to fix breakage caused by commit 40cb4cfc5d011102.
>         [..]
> 
>         Not having actually tested this, looking at it seems to properly
>         quote
>         the bits that caused buildbot explosion and "make dist" fails
>         (also as
>         discussed between David and Samuli on IRC).
> 
>         So - ACK!  Please apply and let's make the buildbots all green
>         again :-)
> 
> 
>     Don't know about bots, at least one human cross-compiling for
>     windows is happy now..
> 
> 
> The joy was short-lived. mingw cross-compile from release/2.3 tarball is
> also broken:
> 
>     error: cannot find input file: `vendor/Makefile.in'
> 
> Thankfully, cherry-pick 41ab12f06253c fixes it.

Whoops!  I completely forgot to include this fix into the release/2.3
branch.

> IMO, the unit testing patches shouldn't have been merged into the
> release branch

I did think consider this, but ended up applying them to release/2.3 as
well.  My thought is that once we start having more unit tests included,
we should be able to at least add some of those tests to the release/2.3
branch too.  There are code which is refactored so much it won't be easy
to do, but there are also plenty of code which haven't changed that
dramatically.

I see these first patches from Jens as framework (or infrastructure)
patches, it doesn't mean we commit ourselves to adding unit-testing to
release/2.3, but it gives the possibility to do so.  Our 2.3 releases
will continue to live in parallel with the future 2.4 release for quite
some time.


-- 
kind regards,

David Sommerseth

