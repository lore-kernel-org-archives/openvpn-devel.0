References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<5755C95E.9080401@...2080...>
	<CAKuzo_jivce2XsfJeJaY2n+NqRqUWSPkWejyHZMNuqHxGZUCcg@...278...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <5755DF70.8050406@...2080...>
Date: Mon, 6 Jun 2016 22:39:12 +0200
MIME-Version: 1.0
In-Reply-To: <CAKuzo_jivce2XsfJeJaY2n+NqRqUWSPkWejyHZMNuqHxGZUCcg@...278...>
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
To: Selva Nair <selva.nair@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

On 06/06/16 22:08, Selva Nair wrote:
> Hi,
> 
> On Mon, Jun 6, 2016 at 3:05 PM, David Sommerseth
> <openvpn@...2080...
> <mailto:openvpn@...2080...>> wrote:
> 
> 
>     > IMO, the unit testing patches shouldn't have been merged into the
>     > release branch
> 
>     I did think consider this, but ended up applying them to release/2.3 as
>     well.  My thought is that once we start having more unit tests included,
>     we should be able to at least add some of those tests to the release/2.3
>     branch too.  There are code which is refactored so much it won't be easy
>     to do, but there are also plenty of code which haven't changed that
>     dramatically.
> 
>     I see these first patches from Jens as framework (or infrastructure)
>     patches, it doesn't mean we commit ourselves to adding unit-testing to
>     release/2.3, but it gives the possibility to do so.  Our 2.3 releases
>     will continue to live in parallel with the future 2.4 release for quite
>     some time.
> 
> 
> I'm of the view that "unit tests" aid development but not much useful
> for maintenance. So why add unit tests to a stable code-base that should
> only get bug fixes (i.e., fixes for bugs that show up in real use).

True.  But sometimes we will need to adjust the backport too.  In those
cases then we loose the unit-test result from the master branch.

> On top of that, adding unit tests into an existing code like openvpn
> will involve a lot of refactoring. The ROI on backporting any such tests
> to 2.3 does not look worth the effort. 

Yes, lots of the code may need to be refactored.  But I am not currently
convinced everything will need refactoring.

I am especially having the SSL abstraction layer in my mind.  That did
already go through a massive amount of refactoring to make it possible
to swap between OpenSSL and mbedTLS/PolarSSL.  Those code paths I see
great value of having tested with unit tests, also in 2.3.  Without
having dug too much into the buffer.[ch] code lately - so my memory may
be corrupted, but I think that is also code which can be adopted without
too much refactoring - and these code paths are also quite crucial.  But
yes, the unit test coverage will not be as massive as it hopefully will
develop to in master and 2.4.

From my point of view, having good unit tests on the security/privacy
related code paths in 2.3 would be a good goal.

-- 
kind regards,

David Sommerseth


