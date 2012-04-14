MIME-Version: 1.0
In-Reply-To: <4F84562E.3020208@...1114...>
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
	<CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
	<4F84562E.3020208@...1114...>
Date: Sat, 14 Apr 2012 22:23:25 +0300
Message-ID: <CAOazyz1oxqCt-4UVyc71YhMq04bQY9+TrTJyGqa4Sjfe0-sykQ@...278...>
From: Alon Bar-Lev <alon.barlev@...277...>
Subject: Re: [Openvpn-devel] ACK system review finished
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: David Sommerseth <openvpn.list@...1114...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Hello,

On Tue, Apr 10, 2012 at 6:47 PM, David Sommerseth
<openvpn.list@...1114...> wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA1
>
>
> Thanks a lot for sharing your thoughts. =C2=A0Many good comments, and I've
> added my thoughts inline as well (and stripped out text too).
>
> On 07/04/12 18:30, Alon Bar-Lev wrote:
>> What is the submission event? Yes, this event is important... It
>> implies that the author think he had reached to a point he either
>> thinks work is ready to be merge or he asks review before merge.
>> In no way this event means more than this. People can find issues,
>> the author it-self can find issues, even in the strict Linux kernel
>> development every one, including the author can reject a patchset
>> at any time during the discussion, and submit a different one.
>>
>> When people state that "A patch must not be changed once
>> submitted", they claim either: a) Bad/malformed/invalid patches
>> may be committed into mainline. b) Only perfect patches are
>> accepted, rest are rejected, casing the above statement to be
>> incorrect, as once submitted again these are modified patch
>> anyway.
>
> I think that the proper statement would be "Once ACKed, the patch
> being ACKed on the ML should not be modified". =C2=A0That's the signal I
> take for inclusion.

Well, as I wrote, this is first time I encounter this approach.
When human publish his code, at least for the first time, the first
state people should be in is REVIEW mode, then if all is OK, people
should switch into APPLY state. A simple deterministic-automate
machine.

Let's make a long story short... I give up. I have no time to invest
in unproductive discussions... I much prefer to invest time in
productive changes. The amount of energy I invested here in just
discussion is reducing the amount of time I can invest in creating
perfect patches.

Current active developers are interested in specific features which
are never complete.

For example Gert cares about the IPv6 implementation, but did not take
all the routing and tun handling on him self as a whole.

Adriaan added the PolarSSL support, but did not take all the crypto
interfaces of OpenVPN.

Heiko took the MSVC build + unicode support, bit did not take the
windows (non-tun none-routing) subsystem.

People are doing a great work, adding more features into the code base, but=
...

The approach of maintaining a feature and not the subsystem,
introduces, in most cases, a more complex implementation.

The current ACK system encourages this approach, by accepting these
incremental additions of features without a project leader who can
dictate implementation standards.

What I basically claiming is: to have a sane code base, the price of
maintaining a major feature is to maintain the complete subsystem as
well, unless we have clear interface.

So instead of maintaining IPv6, we need a maintainer of tun and
routing. I already invested the time to clean up the tun code to help
reaching this goal[1], this approach allows sub-maintainer of windows
tun and routing to exists. Someone who takes charge of the complete
tun and routing will have a complete different state of mind.

If we create a similar implementation crypto interface, we can have
one maintainer to Core+OpenSSL (james?) and one maintainer to PolarSSL
(Adriaan).

We definitely need a Windows platform maintainer, as the amount of
windows specific code is huge!

I can maintain the build and PKCS#11 and ACK various interface changes.

But I am accepting that my view is far from yours, I guess where
current path will take the project to, I will be very happy if I am
wrong, but without core developers this project will reach a crises.

[1] https://github.com/alonbl/openvpn/compare/master...tun

>> As a result I really do not understand this statement... Either we
>> =C2=A0committing low quality solution or we lie to our-selves.
>>
>> I also don't understand the great fear of perfecting patches before
>> commit, as the mission of all developers is improving the project,
>> changes to the patchset is for the good of the community, improving
>> the quality of the work to be committed. Usually the changes
>> during/after review are minor, and will be reviewed anyway, as
>> author will state what change and simple diff may be used to
>> delta-review.
>
> Perfecting patches is great! =C2=A0I like that. =C2=A0But in the round wi=
th the
> build tools, it was not clearly understood that this was a preview of
> the patches. =C2=A0I can sure take that blame on my part. =C2=A0And we st=
arted
> ACKing patches, which is our methodology. =C2=A0And then I begin to proce=
ss
> this.

Yes, and at this point we discovered that there is a gap between the
OpenVPN way and the Linux kernel way... in which ACK is part of review
process.

> I have no problem with a "forked" git branch which are modified for a
> long time, it may also stay outside the official tree. =C2=A0And when the
> patches are ready for the prime-time inclusion, doing an official
> review with public ACKs locks the patches - and I'll pull them in.

This is not what I suggested.
The review process should be on this external patch, all active
developers should help in perfecting this branch in term of code
quality and testing, while after review process is done, it is merged
as-is.

Anyway, as I stated earlier, I am not going to invest any more
resources in this. I think I made my point that the OpenVPN way is
unique, while I cannot understand this, I have not enough resources to
continue this debate.

> And I see you did a good thing in one of your later patch-sets, where
> you said explicitly that this is not ready for inclusion yet. =C2=A0I'll
> take those hints, and stay clear of reviewing for ACKs.

This is exactly the problem, you should be encouraged to review! help
reaching a state in which these are ready for merging. If you and
others review only upon merge request we have no quality process at
all.

> But of course, I'll run some tests from your git tree if time permits
> it and/or the features are interesting enough to catch my attention.

So let me understand this...
All features are of interest of you when these are submitted for merge.
But only some are interesting enough before submission, during review reque=
st.

If this is correct, it should be best for you to comply with the
review request so that the merge process will be much easier.

> And I think this is an approach more people uses here as well. =C2=A0We
> can't dictate when and how people will test development code. =C2=A0But I
> do know that when things hit the master branch, that is tested much
> more - as we have automatic snapshot builds, and I believe there's
> even an FreeBSD port which is released regularly based upon this code
> as well. =C2=A0So that's why I'm trying my best to push things which looks
> ready into the master branch as soon as possible.

Again, out of resources... so the master is playground, that's should
be stated clearly.

>>>> Question3: When patch series is merged into tree?
>>>>
>>>> General note: In no way do I see the fast responsive of
>>>> submit-ack-commit a goal! It can take week or a month,
>>>> depending on need/complexity/quality. The goal is to merge
>>>> mature patchsets that we feel comfortable with.
>>>>
>>>
>>> Agreed, code quality and security should be paramount.
>
> If not doing this, we surely are doing something not right.
>

This exactly what I am claiming.

>>>> A patch series is a set of patches seeking to achieve some
>>>> goal. Usually, there is no sense in merging partial patchset.
>>>> Review process is iterative, it is human process, when
>>>> patchset is submitted for review, the mission is perfecting
>>>> the patchset, both in term of functionality and code quality.
>>>> It is only logical that a patchset will =C2=A0be submitted several
>>>> times, as feedback is gathered. After the review process, and
>>>> ACK/whatever, the author of the patchset should submit merge
>>>> request with the final work, that may differ (improved) from
>>>> last submission. Best to submit merge request using pull
>>>> request from public git repository to avoid any error.
>>>>
>>>
>>> Here I partially disagree. I think changes to patches should be
>>> avoided once they are in a review process, especially for large
>>> patch sets. There's no harm in adding an extra patch that fixes
>>> an issue found during the review process, other than perhaps
>>> hurting the ego of the submitter :).
>
> I partly agree with Adriaan here. =C2=A0Once we review for ACK, patches
> should not be modified at all afterwards. =C2=A0But as long as it's clear=
ly
> a preview of something, I have no problems with patches being
> modified. =C2=A0And in this case, it must be clear that a reviewing for A=
CK
> process should not start.

Same as above, if all will ignore the review request, we reach into
the current process anyway.

>>>> If patchset is complex developers should be encouraged to test
>>>> it within the author's repository *BEFORE* merge, to allow
>>>> more or less stable master branch, and higher quality of
>>>> patchset.
>
> That is the idea behind the 'experimental' branch. =C2=A0As we've not had
> any critical patches which touches OpenVPN features, it's mostly been
> a copy of 'master'. =C2=A0But we can surely use the 'experimental' branch
> for including remote git branches into a upstream test branch. =C2=A0This
> branch would then have to be rebuilt everything the upstream branches
> are rebuilt. =C2=A0Which makes the management of this branch somewhat
> harder, but not impossible. =C2=A0But we can surely bring that branch more
> to live again.

Well, I don't like the experimental branch, similar to what you wrote to Sa=
muli.
A single branch of experimental features causes a lot of overhead,
first each feature should be rebased on top of the other, while we do
not know what the correct order of features is to be merged to master,
second it is very difficult to merge a complete feature with all its
fixes to master when development is done.

One branch per feature is a lot easier to maintain, rebase, test and
merge. Thanks to git, one branch per feature is not something that
should be maintained in formal repository.

Using github will allow people that in the process of implementing
interesting features to get their own repository within the OpenVPN
organization, so developers and users will know what the roadmap is,
and can follow interesting features.

>>>> Difference from current process: Current process somewhat
>>>> assume that if some work receive ACK of random people it can
>>>> be committed to main tree, even without testing or even if
>>>> someone else, may be the author has some rejects/improvements.
>>>> This makes the commit history complex without any reason, as
>>>> known issues can be fixed in the patchset before the merge.
>>>
>>> Again, I disagree about changing patches once they've been
>>> submitted.
>
> I'm agreeing with Adriaan here as well. =C2=A0Fixing things, even silly
> mistakes, in separate commits are not a bad thing - as long as the
> commit message is clear about why. =C2=A0I don't believe in only top-notch
> perfect patches at all, I don't believe such things exist - even after
> 100 iterations. =C2=A0There's always something you can fix. =C2=A0You nee=
d to
> draw the line somewhere.

There is a huge difference between committing code with KNOWN issues,
and committing code and find issues later. There is no reason to
commit a code with KNOWN issues.

>>>> Question2: Does ACK has same weight?
>>>>
>>>> Although we like to live in democracy, democracy has its down
>>>> sides... A professional community is assembled by people of
>>>> different skills at different levels, hence there should be
>>>> different weight for ACK of different people.
>
> This is probably not clear to all, but do I weight the ACKs when
> applying patches. =C2=A0If a random John Doe ACKs a patch which is not
> clear to me, I don't consider that ACK much at all. =C2=A0If it's a
> trivial/obvious patch, I have no problem granting the ACK fame to that
> John Doe, as I believe it is important to include people into this
> process.
>
> And if you, Alon, give an ACK or NACK to a patch related to the build
> system or something related to PKCS#11 layers, I'll weight that far
> more than others. =C2=A0And the same is for SSL stuff, I listen more
> carefully to Adriaan, and for IPv6 or networking related I care much
> about what Gert has to say. =C2=A0And these are also people I've seen in
> good discussions with James, where I feel that James are not terrified
> of what they're doing.

I wrote above why I think the current approach is not right.

>>>> There should be maintainer for each component, this component
>>>> maintainer ACK for patchset is *REQUIRED* for patchset that
>>>> touches his subsystem. Of course component maintainer should
>>>> be relatively responsive, otherwise a core developer may
>>>> replace.
>>>>
>>>> Significant changes should also be ACKed by core developers,
>>>> usually based on roadmap or ability to maintain this in
>>>> future. There should be more than a single core developer.
>>>>
>>>> Core developer can merge his own work after review process is
>>>> exhausted.
>>>>
>>>
>>> Do you think the dev team is big enough to need component-based
>>> maintainers? OpenVPN, despite its many features, isn't huge, and
>>> hasn't got that many devs. Is adding such a system not just
>>> extra overhead?
>>
>> I don't care about having 3 maintainers... or 2... or 1... as long
>> as we know who these are and what they in charge of.
>
> This would be an ideal situation. =C2=A0But the fact is that of developers
> who are really active and where I feel I can trust the persons
> ultimately, doesn't really fill up one single hand. =C2=A0And then these
> persons also need to gain James' trust as well.
>
> We simply don't have access to enough people currently, and then I
> think it is far better that those which are active can choose freely
> what they want to do inside OpenVPN.

Yes we have at least some, I gave an example above.

> For the PolarSSL patches ... they were done through public reviews on
> the mailing list, and Adriaan had a github tree with his stuff too.
> If you didn't like anything there, why didn't you comment on that
> before it was included? =C2=A0In fact, it was lingering on the ML for a
> long time before actually being included.

Well, a few reasons...

1. I did not believe this will be merged. This is my bad. James was
not in favor of these stuff in the past. It took years to merge the
IPv6, as I guess James assumed he cannot maintain this.

Personally, I don't quite understand why making OpenVPN more complex
was required, as embedded Linux can run OpenSSL just fine.

2. It was way to complex for proper review, and as-is I could not
review this properly. When I ACK I sure I understand the
implementation and implication.

3. At that time I had less free time.

Looking back, I should have requested to implement crypto interface
first, but at that point in time had you listened to this request?

Did you listen to my request to split the unicode patch? [2].

[2] http://permalink.gmane.org/gmane.network.openvpn.devel/5381

> It is not the same project management as when James was the only
> developer actively adding code to OpenVPN. =C2=A0And including and
> encouraging community involvement means that OpenVPN will need to be
> allowed to move faster forward - as most developers who submits
> patches are not willing to wait years to see their code included.

I think you summarize all what I disagree.

1.

We have no core developers AT ALL! meaning no vision, to strategy, no
one that evaluate feature necessity, maintenance price, integration
method.

We do have someone who manages a process, that at the end almost every
feature that is presented getting included.

2.

We are making implementation more complex as every feature is included
as incremental minimal change, and due to (1) no check point.

We are indeed moving faster, but where to?

3.

We cannot evaluate the ability to maintain for years the code that is
growing, due to (2) and (1).

Developers indeed sees their code included after weeks.

Regards,
Alon.

