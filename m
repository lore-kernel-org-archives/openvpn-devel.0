References: <6b3b8a029cd8761642ac3f8174238aa2.squirrel@...2260...>
	<063244418e0b88138db5b490037cb7a4.squirrel@...2257...>
	<267890da-2186-dddb-d4c4-d6374da7e086@...277...>
	<049b9d27-d6a4-41cf-9742-bed02b2cc39b@...2080...>
	<18a96a72-4778-22b3-8a57-ce87d3f7060b@...2080...>
	<11253b26-cb11-8b7a-02e0-d5b1ad89e199@...277...>
	<2465b076-35e8-6144-f1b8-085ad5a016f0@...277...>
	<e09e9fbc1ce629510c439bbc06569b1a.squirrel@...2260...>
	<f6a87e19-4ac0-4ea2-69f3-2f424cbe8891@...1227...>
	<86ef0241-5144-206a-4691-6713434fdaa4@...277...>
	<20170405204236.GM93896@...1296...>
	<ec5b45716d7fad0f492b19e6c54b82fe.squirrel@...2260...>
	<e6e53a2e-55ff-656d-4eb1-1c4a31403dbc@...2080...>
	<CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
From: debbie10t <debbie10t@...277...>
Message-ID: <3092a563-61dd-9240-b288-190b6f5fc259@...277...>
Date: Thu, 6 Apr 2017 13:49:04 +0100
MIME-Version: 1.0
In-Reply-To: <CAA1AbxLMr+vxxNqbmQ3OmJzL2ph9SWq=Snwspy9bJSbkPT0eJg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2] Add per session pseudo-random
 component to --reneg-sec intervals
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



On 06/04/17 12:52, Steffan Karger wrote:
> Hi,
>
> On 6 April 2017 at 12:26, David Sommerseth
> <openvpn@...2080...> wrote:
>> On 06/04/17 11:45, Simon Matter wrote:
>>>
>>>> I like Arne's and David's suggestion - the existing option "as is" will
>>>> enable X% jitter, while a second parameter can specify a more specific
>>>> range.  Following Arne's argument about users and percent math, it might
>>>> indeed be better to have "min max" here ("3500 3600"), because that is
>>>> really easy to understand and explain.
>>>
>>> After all the discussion I prefer the simple solution. I've changed my
>>> systems to the reduced 10% jitter and I'm wondering if it has to be made
>>> more complicated than this? I works very well and after some hours the
>>> renegs have spread very well. If you ask me it's perfectly fine that way
>>> as long as the docs clearly state that a pseudo random 10% us deducted
>>> from reneg-sec automatically to spread renegs.
>>
>> It must be configurable, based on many years experience with helping out
>> on configuring OpenVPN tunnels.  There are millions of OpenVPN
>> configurations out in the world (and I don't even think I'm exaggerating
>> that much even), many small ones and quite some large ones.  There are
>> VPN service providers with several hundred thousands paying customers,
>> and there are an enormous amount of VPN service providers in addition.
>> In addition to all the private and corporate deployments.
>>
>> So enforcing a good feature equally on all these configurations will
>> backfire at us.
>>
>> And the more I think about the 10% randomness vlaue (or any percentage),
>> I really wonder how clever that is.  If a site uses --reneg-sec 1800 (I
>> have seen that), that means a 3 minute window.  If a site uses 14400 (4
>> hours, I've seen that too), that gives a 24 minute window.  These window
>> sizes may be perfectly fine.  But depending on the amount of connected
>> users, this may be troublesome too.
>>
>> Last night I chatted with krzee on #openvpn-devel about this.  He does
>> quite some cool stuff with OpenVPN and have lots of IP phones connecting
>> to VPN servers.  He said that randomness by default may not be ideal for
>> some of the setups he manages.   But he loves the idea behind this
>> feature.
>>
>> Krzee argued that configurations explicitly setting --reneg-sec 3600
>> should not have any randomness.  If a configuration does _not* set
>> --reneg-sec, it may have randomness with 1 hour as the base.  And those
>> wanting better control of the time window should use:
>>   --reneg-sec min max
>>
>> I initially was of the opinion --reneg-sec 3600 should have randomness
>> (the 10-17% base).  But after having slept on it, I think Krzee have a
>> good point.  Setting --reneg-sec explicitly with only a single value
>> should not have any randomness.
>>
>> With the 1 hour default, not setting --reneg-sec gives a time window of
>> 6 minutes with 10%.  That is a reasonable default unless explicitly
>> overridden by either --reneg-sec 3600 (no randomness) or --reneg-sec
>> 3000 4000 (with a 1000 seconds large time window)
>
> Wow, this discussion suddenly caught some attention!  I'll chip in too.
>
> I was fine with not making this configurable, but the discussion
> convinced me that people really want to be able to configure this, so
> I agree we should.
>
> As for the option, I think Arne's proposal is the best:
>   --reneg-sec max [min]
> where <nothing> == --reneg-sec 3600 == --reneg-sec 3600 3240 (assuming
> 10% default randomization)

The Initial proposal was --reneg-sec [min] max (horrible)

>
> Why? Because this
> 1) doesn't change the meaning of the first argument based on whether
> the second is present.  That's just confusing.
> 2) does by default what we expect is best for most users: randomize
> the reneg-sec value
> 3) still allows administrators to disable randomization
> 4) 'max' and 'min' are hard to misinterpret ('window', 'jitter' or
> 'offset' are much easier to misinterpret)
>
> As for 'first time only' or 'always': go for always.

If it is set to always, you are permanently changing the function of 
--reneg-sec to always use random *or* no random at all, which the user 
cannot modify.  This randomise is only required for the first period
and subsequent periods should return to normal.

People are accustomed to a one hour period, I feel sure that randomising
the period permanently will drive people insane!

The point of putting this "into" openvpn binary is in order to break up
the "renegging" clients on the first reneg *only*, then changing back
to normal behaviour.  This "changing back" cannot be done via a script
because no scripts are called on --reneg-sec, therefore it *must* be
done by the binary.

As you can see, the current proposal does not allow for first random,
followed by expected/normal/regular renegs. It is either *always* random
or *never* random .. I believe this is a poor decision.


> That will slowly
> spread out the clients over the entire reneg-sec window, instead of
> over just xx% of the window. The odds that 'all periods line up' that

Even you find the term "window" accurate ..

I maintain my position.
Regards


