Message-ID: <3EAD802E.8050904@...7...>
From: bishop <bishop@...7...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
References: <20030428142748.GA826@...30...> <Pine.LNX.4.50.0304281058060.7360-100000@...48...> <3EAD6DC9.7030502@...7...> <Pine.LNX.4.50.0304281423090.25721-100000@...48...>
In-Reply-To: <Pine.LNX.4.50.0304281423090.25721-100000@...48...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Mon Apr 28 12:31:03 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Aaron Sethman <androsyn@...45...>
Cc: OpenVPN devel <openvpn-devel@lists.sourceforge.net>


Aaron Sethman wrote:
> 
> On Mon, 28 Apr 2003, bishop wrote:

>>So, what do we do?  We write an exeption in a GPL-licensed project's
>>software license?  That only seems shady on the surface, like one's
>>trying to exempt oneself from someone else's licensing - -I'd like to do
>>that with MS.  In fact, the only problem is that, soon, maintainers of
>>GPL-licensed projects will need to maintain an entire list of
>>exemptions, and it may eventually be larger than the GPL boilerplate -
>>no mean feat, but as time_t->oo ...
> 
> Well one simple solution is not to use liblzo.  We lose some functionality
> that could be replaced with the slightly slower but better compressing
> zlib.
> 
>>I think that this is another example of how the GPL1 license is really
>>not intended for a world that is not either entirely GPL or entirely
>>non-GPL.  It's perhaps meant to eventually edge-out the non-GPL
>>licenses, something we'd normally consider a bit more difficult if it
>>weren't the much-loved GNU doing it.  The motives are similar to any
>>other empire-builder (Oh yes, and please let us remora the name of your
>>operating system).
> 
> Please lets not have this into a license penis measuring war.  This
> doesn't solve anything for the problem at hand.

Sorry, yes:  The leaky boat isn't related.  Keep bailing.

>>I would suggest, for our sanity and not for the sake of any freedom we
>>require to link with whatever projects we choose, that we do NOT
>>consider adding any more GPL-covered projects to this one.  In case we
>>run into any more snags, the remaining GPL bits can be pulled more easily.
> 
> Just because its not simple, doesn't mean some software authors don't want
> to GPL their software.  Personally I think you can make a very strong
> argument that on a lot of systems openssl is considered a system library.
> The is a rather old discussion that has been brought up various times with
> regards to different pieces of software.

But, again, the exceptions don't support a rule.  The LSB itself, last 
time I looked, uses that 'system component' discriminator to determine 
the Correct install location.  In short, if the project is blessed and 
included by a distro, its location (and, apparently, licensing) follows 
a different set of rules.  No part of that really made sense, if we 
truly aim to avoid those measures that have been set up only to reduce 
churn potential.

Also, such a distinction fails inductive reasoning:  there's no 'base' 
case, to my quick inspection and admittedly aging math experience.

>>Is this an issue that should be Asked of Slashdot?
> 
> And this will help us how?  I think maybe somebody should ask a good
> lawyer, not /.

"Did you consider the linking nuances of your license" may not be one 
that applies to all lawyers, especially those that don't actually build 
software, and I know that the team at work just has no time for things 
not related to the products with which we work.  What company employs 
people at a lawyer's rate, but on a linux budget, just so they can sit 
around and wait for these questions?

But, hey, the discussion's already out of scope of the list, so it's 
nothing that can concern the average orwellian horse.  We can ust keep 
bailing, or take it offline.

> Regards,
> 
> Aaron
> 
> 
> -------------------------------------------------------
> This sf.net email is sponsored by:ThinkGeek
> Welcome to geek heaven.
> http://thinkgeek.com/sf
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel

-- 
	"Every well-bred petty crook knows -- the small concealable
	weapons always go to the far left of the place setting."
		-- Inara (Morena Baccarin), "Firefly"
		   (unaired - into production AFTER fox crushed it)


