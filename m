Message-ID: <3EAD6DC9.7030502@...7...>
From: bishop <bishop@...7...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] Fwd: Re: comp-lzo and licensing issues
References: <20030428142748.GA826@...30...> <Pine.LNX.4.50.0304281058060.7360-100000@...48...>
In-Reply-To: <Pine.LNX.4.50.0304281058060.7360-100000@...48...>
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
Date: Mon Apr 28 11:10:09 2003
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: Aaron Sethman <androsyn@...45...>
Cc: Alberto Gonzalez Iniesta <agi@...5...>, OpenVPN devel <openvpn-devel@lists.sourceforge.net>

>> Of course another option here is to consider getting OpenVPN to play nice
>> with gnutls, though I am not familiary with the maturity of that piece of
>> software.

Does anyone else here consider this to be entirely the wrong way to go?

First off, the problem appears to be one that's present in all cases 
where GPL-licensed software is linked with non-GPL-licensed software 
(I'm lazy, and assuming OpenSSL is `BSD).  The OpenSSL people are only 
stating a commonly-overlooked problem that will eventually bite every 
single one of us.

So, what do we do?  We write an exeption in a GPL-licensed project's 
software license?  That only seems shady on the surface, like one's 
trying to exempt oneself from someone else's licensing - -I'd like to do 
that with MS.  In fact, the only problem is that, soon, maintainers of 
GPL-licensed projects will need to maintain an entire list of 
exemptions, and it may eventually be larger than the GPL boilerplate - 
no mean feat, but as time_t->oo ...

I think that this is another example of how the GPL1 license is really 
not intended for a world that is not either entirely GPL or entirely 
non-GPL.  It's perhaps meant to eventually edge-out the non-GPL 
licenses, something we'd normally consider a bit more difficult if it 
weren't the much-loved GNU doing it.  The motives are similar to any 
other empire-builder (Oh yes, and please let us remora the name of your 
operating system).

I would suggest, for our sanity and not for the sake of any freedom we 
require to link with whatever projects we choose, that we do NOT 
consider adding any more GPL-covered projects to this one.  In case we 
run into any more snags, the remaining GPL bits can be pulled more easily.

Is this an issue that should be Asked of Slashdot?

  - bish

DISCLAIMERS:

This message is only half-formed, having been the product of a mere hour 
of thought and discussion on the issue with co-workers, none of whom 
were lawyers.  It is neither logically complete nor sound.

I am biased.  Normally I'm an annoying, opinionated, proselytizing 
grouchy recluse, emerging from my cave only to yell "Dooooom" in a James 
Earl Jones voice.

I work for a company that works with linux and tries to make a profit; 
that's two distinct halves of a company that do not often mix due to 
legal reasons.  Ironically, many free vendors trying to make money on 
'free' software employ full-time legal teams whose sole job is to 
prevent the company running afoul of the GPL and other licenses;  I'm 
not a member of that part of my company, thankfully (IANAL).



Aaron Sethman wrote:
> On Mon, 28 Apr 2003, Alberto Gonzalez Iniesta wrote:
> 
> 
>>Hi all,
>>
>>Sorry for the huge forward, but everything needed to understand this
>>problem should be there :)
>>
>>GPL software does not mix well with OpenSSL, and that's giving me some
>>headaches lately. As you me see in my mail to Markus (liblzo author) and
>>James (we all know who he is :) linking liblzo with OpenSSL may be a GPL
>>violation [1].
>>
>>So this is a call for comments on this issue.
>>Can anybody reach Markus and comment him about this?
>>Should we switch to another compression library? In that case, which one
>>would be suitable? zlib?
>>Should we ignore this and let RMS jump on us? [2]
> 
> 
> Well zlib could be suitable, considering that OpenVPN does implement some
> reliable UDP stuff for SSL/TLS type streams to work correctly.  Of course
> it might be a performance hit.  On the other hand, if you are linking it
> yourself and not redistributing the binaries you are probably okay.  This
> means though that prebuilt binaries linked to liblzo could be a no-no.
> 
> Of course the slope gets slippery if OpenSSL is shipped with the OS by
> default and is considered a 'system library'.  In such case it might not
> necessarly be a violation, otherwise linking GPL software on a system like
> Solaris and distribution the resulting binaries would be forbidden as
> well.
> 
> Of course another option here is to consider getting OpenVPN to play nice
> with gnutls, though I am not familiary with the maturity of that piece of
> software.
> 
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


