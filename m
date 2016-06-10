References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<5755C95E.9080401@...2080...>
	<CAKuzo_jivce2XsfJeJaY2n+NqRqUWSPkWejyHZMNuqHxGZUCcg@...278...>
	<5755DF70.8050406@...2080...>
	<20160607081413.GP53051@...1296...>
From: David Sommerseth <openvpn@...2080...>
Message-ID: <575A9E8B.4010301@...2080...>
Date: Fri, 10 Jun 2016 13:03:39 +0200
MIME-Version: 1.0
In-Reply-To: <20160607081413.GP53051@...1296...>
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
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 07/06/16 10:14, Gert Doering wrote:
> Hi,
> 
> On Mon, Jun 06, 2016 at 10:39:12PM +0200, David Sommerseth wrote:
>>> On top of that, adding unit tests into an existing code like openvpn
>>> will involve a lot of refactoring. The ROI on backporting any such tests
>>> to 2.3 does not look worth the effort. 
>>
>> Yes, lots of the code may need to be refactored.  But I am not currently
>> convinced everything will need refactoring.
>>
>> I am especially having the SSL abstraction layer in my mind.  That did
>> already go through a massive amount of refactoring to make it possible
>> to swap between OpenSSL and mbedTLS/PolarSSL.  Those code paths I see
>> great value of having tested with unit tests, also in 2.3.  
> 
> This all sounds nice on paper, but please look more closely at what
> we are supposed to *do* in the release/2.3 branch
> 
>  - add bug fixes
>  - add security relevant changes, if they are small and localized
>  - aim for maximum stability
> 
> there is no "refactoring" here (the SSL refactoring happened in git
> master before 2.3 was forked).

Exactly.  The unit-test code is not intrusive code at all, it lives
perfectly fine on its own in parallel.  And you're right about the SSL
refactoring, that was my bad memory.

> Unit tests in git master are good and welcome, and if we discover bugs
> there, we will backport the bug fixes to 2.3 (or at least look carefully
> if 2.3 is affected by the same bugs at all).
> 
> Given that we do not have plenty of developer time around, we should focus
> *development* time on git master / 2.4 - and that includes adding testing
> frameworks.
> 
> Ceterum censo: please reconsider whether having that stuff in 2.3 is
> beneficial, or just eats up highly valuable developer time without 
> bringing enough benefits to compensate.

It only eats up developer resources if we put energy into it.  The
current state of the unit-test framework is done in a very modular way
so I think what we end up maintaining in 2.3 will not be as bad as you fear.

As the 2.3 code base will fall behind 2.4 and git master over time, it
only gets more important to have some unit-tests on the crucial code
paths.  I do not say we will put enormous resources backporting all unit
tests to 2.3, but those which can be backported with reasonable efforts
should be considered to be backported.  This kind of evaluation of what
to backport or not is not that much different to what enterprise Linux
distributions already does when providing 10+ years support across some
thousand packages (where rebasing to newer versions are mostly avoided).

I have personal interest in the unit-test framework, as after the last
hackathon I started a similar approach for the plug-ins API.  For the
plugin.c there needs to be done some "untangling", but that should not
cost much review efforts, as it is mostly to re-arrange the order
include files are loaded - in the worst case some functions are moved
from one file to another.  That isn't overly complicated.  But I'd
presume that once that job is done, the rest of the code will be even
easier to instrument with unit tests.

I do *not* say that 2.3 will carry all unit-tests from 2.4 or master.
But I do not see the efforts needed to instrument 2.3 in addition as
complicated as you fear.  And especially now when the core unit-test
framework is cleaned up and works fine in 2.3 too.

My point is: Leave the unit tests in 2.3, keeping it there doesn't cause
any big maintenance issues - it is well confined, it not is enabled by
default and only enabled if the person(s) building openvpn takes extra
explicit steps.  And this enables us to make use of it in 2.3 when the
unit-test backport efforts are reasonable.

> Since I'm usually the one who gets to debug such fallout, I'm absolutely
> opposed to doing any sort of "this should not change anything" or "just
> a bit of cleanup" changes in release/2.3.  Bug-fixes, and long-term 
> compatibility changes (if localized).

This only tells me that we are doing something very wrong.  Then we need
to find better ways to catch these issues at an earlier stage, so they
can be found before it hits our git official repos.  Vagrant and having
documented ways how to run tests in Travis (or similar CIs) on your own
comes to mind.

Opposing efforts to improve our current situation due to our own faulty
processes are just wrong.


-- 
kind regards,

David Sommerseth


