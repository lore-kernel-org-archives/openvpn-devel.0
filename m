MIME-Version: 1.0
In-Reply-To: <4F7DA7EF.1010709@...515...>
References: <4F7DA7EF.1010709@...515...>
Date: Thu, 5 Apr 2012 23:47:03 +0300
Message-ID: <CAOazyz2K0RDYv-zgVt+FUb9Egwykj0Aft9KvxUuQoF0WEf=xKw@...278...>
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: James Yonan <james@...515...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

2012/4/5 Samuli Sepp=C3=A4nen <samuli@...515...>:
> Hi all,
>
> As promised I did a brief review of our current ACK system:
>
> <https://community.openvpn.net/openvpn/wiki/ACKSystemReview>
>
> One thing that surprised me was that only on 2 occasions (out of ~60
> "real" patches) a patch was modified during the review process. For
> comparison, let's look at two big patchsets:
>
> - PolarSSL support [1], ~115 patches
> =C2=A0- total of 8 changes were asked for
> =C2=A0- 3 of these seem trivial stylistic issues/typos
>
> - Buildsystem revolution[2], 52 patches
> =C2=A0- a couple of changes were asked for (e.g. to enable lzo by default)
>
> There seems to be a fair amount of delay from patch introduction to the
> commit to Git repo. For individual patches the delay tends to be less
> than a week, which I think is ok. For patchsets, the delay is much
> longer (15-120 days). It's difficult to say whether we could reduce the
> delay with advanced tools... after all, somebody (=3Dhuman) has to review
> the patches, whatever tools we use.
>
> Due to a number of factors parsing the raw data was challenging...
> unlike I assumed, finding discussions related to the patches was often
> surprisingly difficult/impossible, although the "Acked-by" entries in
> Git clearly show that an ACK was given at some point. Also, quite a few
> patches (~20%) already go in without an ACK.
>
> My personal feeling based is that we should probably focus the ACK
> system to high-risk patches, e.g.
>
> - patches touching critical parts of the code (rationale: better safe
> than sorry)
> - patches from new contributors (rationale: fix stylistic issues and
> errors, ensure usefulness, educate)
>
> We might also want to experiment with better tools to see if that speeds
> up patch processing... that's definitely an issue with big patchsets.
> Merging patches without a formal review might also make sense in some
> scenarios, e.g. in low-risk areas which have an active maintainer.
>
> Although the ACK system _does_ catch some problems and is clearly
> useful, it also slows down flow of code into Git. This has the
> side-effect that new code does not get real-life testing from users as
> soon as it could. I think the key is apply each method (push quickly
> into testing vs. formal review) where it makes most sense.
>
> Also, one idea would be to review patches _after_ they've been merged to
> Git, provided they make sense, i.e. nobody loudly complains about them.
> For example, in PolarSSL's case, this would have allowed us to test the
> code for ~4 months while the patches were being reviewed.
>
> Anyways, let me know what you think... and please forgive me for not
> getting back to this topic before Tuesday... I've been forbidden to work
> during Easter by $fiancee :).
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> [1] <https://community.openvpn.net/openvpn/wiki/PolarSSLintegration>
> [2]
> <https://community.openvpn.net/openvpn/wiki/GenericBuildsystemIntegration=
#Buildrevolutionpatchset>
>

Hello Samuli,

Thank you for the analyze.

I think the discussion should be focus at different aspects.

Example:

Question1: What the desire number of people that may commit into
OpenVPN repository?

Question2: Does ACK has same weight?

Question3: When patch series is merged into tree?

Let's begin in reverse order... easier to discuss.

Question3: When patch series is merged into tree?

General note: In no way do I see the fast responsive of
submit-ack-commit a goal! It can take week or a month, depending on
need/complexity/quality. The goal is to merge mature patchsets that we
feel comfortable with.

A patch series is a set of patches seeking to achieve some goal.
Usually, there is no sense in merging partial patchset.
Review process is iterative, it is human process, when patchset is
submitted for review, the mission is perfecting the patchset, both in
term of functionality and code quality. It is only logical that a
patchset will  be submitted several times, as feedback is gathered.
After the review process, and ACK/whatever, the author of the patchset
should submit merge request with the final work, that may differ
(improved) from last submission. Best to submit merge request using
pull request from public git repository to avoid any error.

If patchset is complex developers should be encouraged to test it
within the author's repository *BEFORE* merge, to allow more or less
stable master branch, and higher quality of patchset.

Difference from current process: Current process somewhat assume that
if some work receive ACK of random people it can be committed to main
tree, even without testing or even if someone else, may be the author
has some rejects/improvements. This makes the commit history complex
without any reason, as known issues can be fixed in the patchset
before the merge.

Question2: Does ACK has same weight?

Although we like to live in democracy, democracy has its down sides...
A professional community is assembled by people of different skills at
different levels, hence there should be different weight for ACK of
different people.

There should be maintainer for each component, this component
maintainer ACK for patchset is *REQUIRED* for patchset that touches
his subsystem. Of course component maintainer should be relatively
responsive, otherwise a core developer may replace.

Significant changes should also be ACKed by core developers, usually
based on roadmap or ability to maintain this in future. There should
be more than a single core developer.

Core developer can merge his own work after review process is exhausted.

Question1: What the desire number of people that may commit into
OpenVPN repository?

I don't think that 1 is a good number for core tasks. If we want to
achieve community work, the core developers should work as a team with
exact same privileges, this will encourage ideas and progress, without
hierarchy within the core team.

Regards,
Alon.

