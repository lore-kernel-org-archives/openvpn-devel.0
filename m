MIME-Version: 1.0
In-Reply-To: <CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
References: <4F7DA7EF.1010709@...515...>
	<CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
	<CAHyOtRmSpUxdtGeFYbu=CQ-erZMS54hXG9zxOC=cDO9vXnBn0A@...278...>
Date: Sat, 7 Apr 2012 19:30:42 +0300
Message-ID: <CAOazyz0WbwVO4QGDomZWycfwhmb_eHHVZpyQqpD0FDOqpt+1Xg@...278...>
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
To: Adriaan de Jong <adriaan@...1475...>, "openvpn-devel@lists.sourceforge.net" <Openvpn-devel@lists.sourceforge.net>

Thank you Adrian,

It seems we need to discuss the major item...

What is "patch" submission?
What effect has the "submission" event?

This is first time I find my-self so far from others' perspective...
really don't know what happened to the old plain software
engineering... Seems like I am getting obsolete.

Let's see... the extreme patch methodology can be traced back to Linux
kernel development. Now like a fashion all people like to mimic this
process if it is suitable or not.

The Linux kernel has been divided into subsystems, and sub-subsystems,
each has maintainers and community. Each has each own core developers
and own release cycle. These communities are working in their own pace
perfecting the features they consider important, then pushing branches
to upstream. It is not uncommon for getting rejects, causing the
subsystem maintainer to fix patches and resubmit, this process is done
until accepted. The same goes to guest developer who wish to apply a
change in code, his patch will be rejected until all parties agrees it
is perfected to a point in can be merged into mainline.

So if we want to mimic, at least let's mimic correctly.

The patch system mission is to allow a work of community of HUMANS
together as a team while perfecting the work of each other without
effecting the stabilization/standard of the main branch. It is a way
to communicate with each other doing peer review and discussion, to
allow reaching the best solution before merge.

After the release of git, people started to forget what the review
process is all about, and especially the above mission. They started
to treat the "[PATCH] ..." message as something similar to religious
event. I guess this is where we at at the OpenVPN project. I think
this is sad, as the HUMAN approach is gone, and like machine we have
two outputs of someone, either 0 - reject or 1 - commit, while people
have 2, 3,4 and even 100.

What is the submission event? Yes, this event is important... It
implies that the author think he had reached to a point he either
thinks work is ready to be merge or he asks review before merge. In no
way this event means more than this. People can find issues, the
author it-self can find issues, even in the strict Linux kernel
development every one, including the author can reject a patchset at
any time during the discussion, and submit a different one.

When people state that "A patch must not be changed once submitted",
they claim either:
a) Bad/malformed/invalid patches may be committed into mainline.
b) Only perfect patches are accepted, rest are rejected, casing the
above statement to be incorrect, as once submitted again these are
modified patch anyway.

As a result I really do not understand this statement... Either we
committing low quality solution or we lie to our-selves.

I also don't understand the great fear of perfecting patches before
commit, as the mission of all developers is improving the project,
changes to the patchset is for the good of the community, improving
the quality of the work to be committed. Usually the changes
during/after review are minor, and will be reviewed anyway, as author
will state what change and simple diff may be used to delta-review.

I really seeking for explanation... really... I am around in this
world for quite long time...

Some more in-line.

On Sat, Apr 7, 2012 at 6:31 PM, Adriaan de Jong
<adriaan@...1475...> wrote:
>
> Hi,
>
> Thanks for the review, I only have a few comments which I'll make inline.
>
> Adriaan
>
> 2012/4/5 Alon Bar-Lev <alon.barlev@...277...>
>>
>> 2012/4/5 Samuli Sepp=C3=A4nen <samuli@...515...>:
>> > Hi all,
>> >
>> > As promised I did a brief review of our current ACK system:
>> >
>> > <https://community.openvpn.net/openvpn/wiki/ACKSystemReview>
>> >
>> > One thing that surprised me was that only on 2 occasions (out of ~60
>> > "real" patches) a patch was modified during the review process. For
>> > comparison, let's look at two big patchsets:
>> >
>> > - PolarSSL support [1], ~115 patches
>> > =C2=A0- total of 8 changes were asked for
>> > =C2=A0- 3 of these seem trivial stylistic issues/typos
>> >
>> > - Buildsystem revolution[2], 52 patches
>> > =C2=A0- a couple of changes were asked for (e.g. to enable lzo by defa=
ult)
>> >
>> > There seems to be a fair amount of delay from patch introduction to the
>> > commit to Git repo. For individual patches the delay tends to be less
>> > than a week, which I think is ok. For patchsets, the delay is much
>> > longer (15-120 days). It's difficult to say whether we could reduce the
>> > delay with advanced tools... after all, somebody (=3Dhuman) has to rev=
iew
>> > the patches, whatever tools we use.
>> >
>> > Due to a number of factors parsing the raw data was challenging...
>> > unlike I assumed, finding discussions related to the patches was often
>> > surprisingly difficult/impossible, although the "Acked-by" entries in
>> > Git clearly show that an ACK was given at some point. Also, quite a few
>> > patches (~20%) already go in without an ACK.
>> >
>> > My personal feeling based is that we should probably focus the ACK
>> > system to high-risk patches, e.g.
>> >
>> > - patches touching critical parts of the code (rationale: better safe
>> > than sorry)
>> > - patches from new contributors (rationale: fix stylistic issues and
>> > errors, ensure usefulness, educate)
>> >
>> > We might also want to experiment with better tools to see if that
>> > speeds
>> > up patch processing... that's definitely an issue with big patchsets.
>> > Merging patches without a formal review might also make sense in some
>> > scenarios, e.g. in low-risk areas which have an active maintainer.
>> >
>
>
> Tools like crucible and gerrit would allow code reviews to be more formal,
> which might make discussions a little clearer. The question remains wheth=
er
> they will really speed things up.

Well, I find gerrit very difficult to manage and cooperate at. Until I
see this actually work in project I know, I prefer the plain old
mailing list / pull request method.

>
>>
>> > Although the ACK system _does_ catch some problems and is clearly
>> > useful, it also slows down flow of code into Git. This has the
>> > side-effect that new code does not get real-life testing from users as
>> > soon as it could. I think the key is apply each method (push quickly
>> > into testing vs. formal review) where it makes most sense.
>> >
>> > Also, one idea would be to review patches _after_ they've been merged
>> > to
>> > Git, provided they make sense, i.e. nobody loudly complains about them.
>> > For example, in PolarSSL's case, this would have allowed us to test the
>> > code for ~4 months while the patches were being reviewed.
>> >
>
>
> True, but in PolarSSL's case it was very important to have a thorough ack
> process, out-of-band. I came in as a new developer, and the code is mostly
> security-critical. Both of those points should always trigger a good revi=
ew
> process.
>
> The build patches are different in that sense. Non-code changes should
> still be checked, but they're less critical than, say, x509 verification
> code changes.
>
>>
>> > Anyways, let me know what you think... and please forgive me for not
>> > getting back to this topic before Tuesday... I've been forbidden to
>> > work
>> > during Easter by $fiancee :).
>>
>
> Happy Easter!
>
>>
>> Hello Samuli,
>>
>> Thank you for the analyze.
>>
>> I think the discussion should be focus at different aspects.
>>
>> Example:
>>
>> Question1: What the desire number of people that may commit into
>> OpenVPN repository?
>>
>> Question2: Does ACK has same weight?
>>
>> Question3: When patch series is merged into tree?
>>
>> Let's begin in reverse order... easier to discuss.
>>
>> Question3: When patch series is merged into tree?
>>
>> General note: In no way do I see the fast responsive of
>> submit-ack-commit a goal! It can take week or a month, depending on
>> need/complexity/quality. The goal is to merge mature patchsets that we
>> feel comfortable with.
>>
>
> Agreed, code quality and security should be paramount.
>
>>
>> A patch series is a set of patches seeking to achieve some goal.
>> Usually, there is no sense in merging partial patchset.
>> Review process is iterative, it is human process, when patchset is
>> submitted for review, the mission is perfecting the patchset, both in
>> term of functionality and code quality. It is only logical that a
>> patchset will =C2=A0be submitted several times, as feedback is gathered.
>> After the review process, and ACK/whatever, the author of the patchset
>> should submit merge request with the final work, that may differ
>> (improved) from last submission. Best to submit merge request using
>> pull request from public git repository to avoid any error.
>>
>
> Here I partially disagree. I think changes to patches should be avoided
> once they are in a review process, especially for large patch sets. There=
's
> no harm in adding an extra patch that fixes an issue found during the rev=
iew
> process, other than perhaps hurting the ego of the submitter :).
>
> For single patches, or small sets this is different, as resubmissions take
> less time to process, and are less confusing. Confusion should be avoided=
 at
> all times.
>
>>
>> If patchset is complex developers should be encouraged to test it
>> within the author's repository *BEFORE* merge, to allow more or less
>> stable master branch, and higher quality of patchset.
>>
>> Difference from current process: Current process somewhat assume that
>> if some work receive ACK of random people it can be committed to main
>> tree, even without testing or even if someone else, may be the author
>> has some rejects/improvements. This makes the commit history complex
>> without any reason, as known issues can be fixed in the patchset
>> before the merge.
>>
>
> Again, I disagree about changing patches once they've been submitted.
>
>>
>> Question2: Does ACK has same weight?
>>
>> Although we like to live in democracy, democracy has its down sides...
>> A professional community is assembled by people of different skills at
>> different levels, hence there should be different weight for ACK of
>> different people.
>>
>> There should be maintainer for each component, this component
>> maintainer ACK for patchset is *REQUIRED* for patchset that touches
>> his subsystem. Of course component maintainer should be relatively
>> responsive, otherwise a core developer may replace.
>>
>> Significant changes should also be ACKed by core developers, usually
>> based on roadmap or ability to maintain this in future. There should
>> be more than a single core developer.
>>
>> Core developer can merge his own work after review process is exhausted.
>>
>
> Do you think the dev team is big enough to need component-based
> maintainers? OpenVPN, despite its many features, isn't huge, and hasn't g=
ot
> that many devs. Is adding such a system not just extra overhead?

I don't care about having 3 maintainers... or 2... or 1... as long as
we know who these are and what they in charge of.

Example:
- Windows
- Build
- PolarSSL
- Interfaces
- Core

>
>>
>> Question1: What the desire number of people that may commit into
>> OpenVPN repository?
>>
>> I don't think that 1 is a good number for core tasks. If we want to
>> achieve community work, the core developers should work as a team with
>> exact same privileges, this will encourage ideas and progress, without
>> hierarchy within the core team.
>>
>
> I actually like the current system, with one gatekeeper, as long as David
> is willing to manage it. It makes things rather clear-cut.
>
> Adriaan

Gate keeper of what? See the recent merge of polarssl, unicode and
IPv6, these are all none clean in term of implementation, David done
his work, merging whatever ACK, but this ACK system lead to even more
complex OpenVPN implementation, not that the legacy OpenVPN was
perfect, but I would have expected new functionality to not make
things more complex. This system is not working, it is not too late to
realize that and decide how to proceed.

Once James was around, although people complained project is
progressing slowly, at least there was someone in charge of the
quality, feature set, conventions and standards. I prefer slow
progressing project than a project that getting more and more complex
while people poll to different directions while there is someone that
manages the process but nobody actually manages the project.

Regards,
Alon.

