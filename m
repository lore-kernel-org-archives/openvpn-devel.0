Message-ID: <4F84562E.3020208@...1114...>
Date: Tue, 10 Apr 2012 17:47:58 +0200
From: David Sommerseth <openvpn.list@...1114...>
MIME-Version: 1.0
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
	<CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
In-Reply-To: <CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
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
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1


Thanks a lot for sharing your thoughts.  Many good comments, and I've
added my thoughts inline as well (and stripped out text too).

On 07/04/12 18:30, Alon Bar-Lev wrote:
> What is the submission event? Yes, this event is important... It=20
> implies that the author think he had reached to a point he either=20
> thinks work is ready to be merge or he asks review before merge.
> In no way this event means more than this. People can find issues,=20
> the author it-self can find issues, even in the strict Linux kernel
> development every one, including the author can reject a patchset
> at any time during the discussion, and submit a different one.
>=20
> When people state that "A patch must not be changed once=20
> submitted", they claim either: a) Bad/malformed/invalid patches
> may be committed into mainline. b) Only perfect patches are
> accepted, rest are rejected, casing the above statement to be
> incorrect, as once submitted again these are modified patch
> anyway.

I think that the proper statement would be "Once ACKed, the patch
being ACKed on the ML should not be modified".  That's the signal I
take for inclusion.

> As a result I really do not understand this statement... Either we
>  committing low quality solution or we lie to our-selves.
>=20
> I also don't understand the great fear of perfecting patches before
> commit, as the mission of all developers is improving the project,
> changes to the patchset is for the good of the community, improving
> the quality of the work to be committed. Usually the changes
> during/after review are minor, and will be reviewed anyway, as
> author will state what change and simple diff may be used to=20
> delta-review.

Perfecting patches is great!  I like that.  But in the round with the
build tools, it was not clearly understood that this was a preview of
the patches.  I can sure take that blame on my part.  And we started
ACKing patches, which is our methodology.  And then I begin to process
this.

I have no problem with a "forked" git branch which are modified for a
long time, it may also stay outside the official tree.  And when the
patches are ready for the prime-time inclusion, doing an official
review with public ACKs locks the patches - and I'll pull them in.

And I see you did a good thing in one of your later patch-sets, where
you said explicitly that this is not ready for inclusion yet.  I'll
take those hints, and stay clear of reviewing for ACKs.

But of course, I'll run some tests from your git tree if time permits
it and/or the features are interesting enough to catch my attention.
And I think this is an approach more people uses here as well.  We
can't dictate when and how people will test development code.  But I
do know that when things hit the master branch, that is tested much
more - as we have automatic snapshot builds, and I believe there's
even an FreeBSD port which is released regularly based upon this code
as well.  So that's why I'm trying my best to push things which looks
ready into the master branch as soon as possible.

> On Sat, Apr 7, 2012 at 6:31 PM, Adriaan de Jong=20
> <adriaan@...1475...> wrote:
>> 2012/4/5 Alon Bar-Lev <alon.barlev@...277...>
>>> 2012/4/5 Samuli Sepp=C3=A4nen <samuli@...515...>:
>>=20
>> Tools like crucible and gerrit would allow code reviews to be=20
>> more formal, which might make discussions a little clearer. The=20
>> question remains whether they will really speed things up.
>=20
> Well, I find gerrit very difficult to manage and cooperate at.=20
> Until I see this actually work in project I know, I prefer the=20
> plain old mailing list / pull request method.

To be very honest, I don't care much which tools we use.  As long as
we have something which fits and works for us, that the review
comments can be kept under a control which makes it as difficult as
possible to modify them and that these comments will not "survive
eternity" based upon the grace of a third party (which might disappear
over night, get hacked and/or shutdown).  The reason for this is that
we can then have references in our commits to discussions regarding
the patch - and being fairly sure that these data will be retrievable
also in the future.

In this perspective, I'm a supporter of the ML approach despite not as
intuitive as other models.  But it is not a centralised service which
will make all references we already have in our git tree.  In
retrospect, using Message-ID would probably be fairly better than URLs
to specific mailing list viewers on the net.

>>>> Although the ACK system _does_ catch some problems and is=20
>>>> clearly useful, it also slows down flow of code into Git.=20
>>>> This has the side-effect that new code does not get
>>>> real-life testing from users as soon as it could. I think the
>>>> key is apply each method (push quickly into testing vs.
>>>> formal review) where it makes most sense.
>>>>=20
>>>> Also, one idea would be to review patches _after_ they've=20
>>>> been merged to Git, provided they make sense, i.e. nobody=20
>>>> loudly complains about them. For example, in PolarSSL's
>>>> case, this would have allowed us to test the code for ~4
>>>> months while the patches were being reviewed.
>>=20
>> True, but in PolarSSL's case it was very important to have a=20
>> thorough ack process, out-of-band. I came in as a new developer,=20
>> and the code is mostly security-critical. Both of those points=20
>> should always trigger a good review process.
>>=20
>> The build patches are different in that sense. Non-code changes=20
>> should still be checked, but they're less critical than, say,=20
>> x509 verification code changes.

Fully agree!

>>> Question3: When patch series is merged into tree?
>>>=20
>>> General note: In no way do I see the fast responsive of=20
>>> submit-ack-commit a goal! It can take week or a month,=20
>>> depending on need/complexity/quality. The goal is to merge=20
>>> mature patchsets that we feel comfortable with.
>>>=20
>>=20
>> Agreed, code quality and security should be paramount.

If not doing this, we surely are doing something not right.

>>> A patch series is a set of patches seeking to achieve some=20
>>> goal. Usually, there is no sense in merging partial patchset.=20
>>> Review process is iterative, it is human process, when
>>> patchset is submitted for review, the mission is perfecting
>>> the patchset, both in term of functionality and code quality.
>>> It is only logical that a patchset will  be submitted several
>>> times, as feedback is gathered. After the review process, and=20
>>> ACK/whatever, the author of the patchset should submit merge=20
>>> request with the final work, that may differ (improved) from=20
>>> last submission. Best to submit merge request using pull=20
>>> request from public git repository to avoid any error.
>>>=20
>>=20
>> Here I partially disagree. I think changes to patches should be=20
>> avoided once they are in a review process, especially for large=20
>> patch sets. There's no harm in adding an extra patch that fixes=20
>> an issue found during the review process, other than perhaps=20
>> hurting the ego of the submitter :).

I partly agree with Adriaan here.  Once we review for ACK, patches
should not be modified at all afterwards.  But as long as it's clearly
a preview of something, I have no problems with patches being
modified.  And in this case, it must be clear that a reviewing for ACK
process should not start.

>> For single patches, or small sets this is different, as=20
>> resubmissions take less time to process, and are less confusing.=20
>> Confusion should be avoided at all times.

Agreed!

>>> If patchset is complex developers should be encouraged to test=20
>>> it within the author's repository *BEFORE* merge, to allow
>>> more or less stable master branch, and higher quality of
>>> patchset.

That is the idea behind the 'experimental' branch.  As we've not had
any critical patches which touches OpenVPN features, it's mostly been
a copy of 'master'.  But we can surely use the 'experimental' branch
for including remote git branches into a upstream test branch.  This
branch would then have to be rebuilt everything the upstream branches
are rebuilt.  Which makes the management of this branch somewhat
harder, but not impossible.  But we can surely bring that branch more
to live again.

>>> Difference from current process: Current process somewhat=20
>>> assume that if some work receive ACK of random people it can
>>> be committed to main tree, even without testing or even if
>>> someone else, may be the author has some rejects/improvements.
>>> This makes the commit history complex without any reason, as
>>> known issues can be fixed in the patchset before the merge.
>>=20
>> Again, I disagree about changing patches once they've been=20
>> submitted.

I'm agreeing with Adriaan here as well.  Fixing things, even silly
mistakes, in separate commits are not a bad thing - as long as the
commit message is clear about why.  I don't believe in only top-notch
perfect patches at all, I don't believe such things exist - even after
100 iterations.  There's always something you can fix.  You need to
draw the line somewhere.

>>> Question2: Does ACK has same weight?
>>>=20
>>> Although we like to live in democracy, democracy has its down=20
>>> sides... A professional community is assembled by people of=20
>>> different skills at different levels, hence there should be=20
>>> different weight for ACK of different people.

This is probably not clear to all, but do I weight the ACKs when
applying patches.  If a random John Doe ACKs a patch which is not
clear to me, I don't consider that ACK much at all.  If it's a
trivial/obvious patch, I have no problem granting the ACK fame to that
John Doe, as I believe it is important to include people into this
process.

And if you, Alon, give an ACK or NACK to a patch related to the build
system or something related to PKCS#11 layers, I'll weight that far
more than others.  And the same is for SSL stuff, I listen more
carefully to Adriaan, and for IPv6 or networking related I care much
about what Gert has to say.  And these are also people I've seen in
good discussions with James, where I feel that James are not terrified
of what they're doing.

>>> There should be maintainer for each component, this component=20
>>> maintainer ACK for patchset is *REQUIRED* for patchset that=20
>>> touches his subsystem. Of course component maintainer should
>>> be relatively responsive, otherwise a core developer may
>>> replace.
>>>=20
>>> Significant changes should also be ACKed by core developers,=20
>>> usually based on roadmap or ability to maintain this in
>>> future. There should be more than a single core developer.
>>>=20
>>> Core developer can merge his own work after review process is=20
>>> exhausted.
>>>=20
>>=20
>> Do you think the dev team is big enough to need component-based=20
>> maintainers? OpenVPN, despite its many features, isn't huge, and=20
>> hasn't got that many devs. Is adding such a system not just
>> extra overhead?
>=20
> I don't care about having 3 maintainers... or 2... or 1... as long=20
> as we know who these are and what they in charge of.

This would be an ideal situation.  But the fact is that of developers
who are really active and where I feel I can trust the persons
ultimately, doesn't really fill up one single hand.  And then these
persons also need to gain James' trust as well.

We simply don't have access to enough people currently, and then I
think it is far better that those which are active can choose freely
what they want to do inside OpenVPN.

If any developer turns up, are part of constructive dialogues on ML
and/or IRC, provides useful ideas and patches which gains community
trust, gains James' and my trust and suddenly states "Would anyone
mind if I take more care of patches related to the XYZ-module?", I
would gladly accept that developer as a submaintainer working under
such a regime you suggested.  But I don't believe in pushing towards
such a regime, it needs to be initiated from a developer.

>>> Question1: What the desire number of people that may commit=20
>>> into OpenVPN repository?
>>>=20
>>> I don't think that 1 is a good number for core tasks. If we=20
>>> want to achieve community work, the core developers should
>>> work as a team with exact same privileges, this will encourage
>>> ideas and progress, without hierarchy within the core team.

Here it is important to see the history, where openvpn-testing.git
came into play.  It was a dissatisfaction about the development model,
especially among people on the IRC.  At that point Samuli got involved
into the community side of OpenVPN too, and in co-operation with James
we agreed that the -testing tree would be a tree of community patches,
where I would prepare a git tree on behalf of the community so that
James could include them into his tree.  Providing testing and
stability works for community provided patches.

Unfortunately, James workload is insanely high, and his time doesn't
cover to do much core OpenVPN stuff.  I personally would wish it would
be different, but it is not.  And as time went by, the responsibility
for the -testing tree grew.  It was later decided to do a 2.1.4
release based on the git tree instead of the SVN tree, as the James'
development tree had so many new features which would require much
more testing.  And the 2.1.4 needed a single patch to fix a critical
issue in 2.1.3.  When this happened, the openvpn.git tree was "born",
and development was shifted towards James' SVN branch being a
"sub-maintainer" tree.  While the plan was that the
opengpn-testing.git tree would a sub-tree to James' SVN (or whatever
he would move to in the future).  And all these decisions were made in
discussions with James.

> Gate keeper of what? See the recent merge of polarssl, unicode and
>  IPv6, these are all none clean in term of implementation, David=20
> done his work, merging whatever ACK, but this ACK system lead to=20
> even more complex OpenVPN implementation, not that the legacy=20
> OpenVPN was perfect, but I would have expected new functionality
> to not make things more complex. This system is not working, it is
> not too late to realize that and decide how to proceed.

Well, IPv6 stuff had been in the 'allmerged' branch (predecessor of
'experimental') for quite some time, all since the 2.1 releases - and
I believe Gert was waiting for both testing and reviewing.  In the
end, it was agreed that these patches would be merged into the 2.3
release without ACK reviews due to 1) Gert is really active in the
community and responds promptly to any issues discovered and 2) it had
been in the allmerged branch for a long time, being used for FreeBSD
snapshots for a long time and myself and others had been using the
'allmerged' branch for heavy testing.

Clean or not implementation ... that can be fixed; and for the future,
reading the commit history you can learn about good and bad
implementations.  So in this regard, the commit history can be
educational.  You see what was done and what was fixed and why.

However, it's more important in my perspective that the code works and
is as bugfree as possible, than being religiously correct about how a
program or function should be written.  It's not easy to have a
general description how an implementation should be done.  Especially
not in a project which is over 10 years old, with a lot of history.
Rewriting that before including the new feature would of course be an
ideal goal, but very few will have the courage to change working code.
 That would also to some go against recommended development cycles.

For the PolarSSL patches ... they were done through public reviews on
the mailing list, and Adriaan had a github tree with his stuff too.
If you didn't like anything there, why didn't you comment on that
before it was included?  In fact, it was lingering on the ML for a
long time before actually being included.

And this fact is what is a core problem in our model.  We hope that
developers reading this ML are passionate about the OpenVPN code, and
will scream out if they dislike something or ACK stuff they like.  But
it so seldom happens.  Reviews mostly happens by one of us who are
already heavily involved, and who end up doing it in IRC meetings.

> Once James was around, although people complained project is=20
> progressing slowly, at least there was someone in charge of the=20
> quality, feature set, conventions and standards. I prefer slow=20
> progressing project than a project that getting more and more=20
> complex while people poll to different directions while there is=20
> someone that manages the process but nobody actually manages the=20
> project.

I trust that James would step up if there is a direction happening
which he disapproves.  And he knows where he can reach most of us who
are most active, both via mail and IRC.  In addition we have somewhat
semi-regular meetings on IRC too, where we do discuss the direction of
things as well.

The only thing which has happened in this regard is that community
patches gets a much more public attention now than before - which
results in an increased traffic to the mailing list.  And if you look
at the mailing list traffic, you see when the community itself got
more involved than before:
<http://dir.gmane.org/gmane.network.openvpn.devel>

It is not the same project management as when James was the only
developer actively adding code to OpenVPN.  And including and
encouraging community involvement means that OpenVPN will need to be
allowed to move faster forward - as most developers who submits
patches are not willing to wait years to see their code included.


kind regards,

David Sommerseth
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAk+EVi0ACgkQDC186MBRfrq6NgCeJU/NAA5x7XNmDMZWI7Ihy+Bc
IzwAnjw2xl60Y40mEmT9N7RZBTYasLbZ
=3DvzqZ
-----END PGP SIGNATURE-----

