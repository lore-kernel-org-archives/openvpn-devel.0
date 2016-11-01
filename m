References: <5c4e3f93-c584-4a19-4081-9bf4adaf417a@...277...>
	<502e093a-cb39-c76d-27b5-ab86fd4bcfd6@...515...>
	<73352d7f-521e-b968-2990-8783955da5c9@...2080...>
	<04516948-204e-57c2-fb57-f355157ed5af@...515...>
	<CAKuzo_gRDm566EwD_qtrYNM5AOYHF8xgCzsi1FQ3emjYGDeGmw@...278...>
	<43094758-efda-c613-c51d-e7980dfa6b24@...2080...>
	<CAKuzo_iaEhhrVhRr_zPATsFHinFi=ECtDFofEB2_8zP7Z2+zSg@...278...>
	<90baad6a-25c5-2ecc-1ea8-b5a1febf1521@...2080...>
	<cadcd4fa-701e-2d35-4fe0-66707dae8b5b@...277...>
	<9ba106aa-7dc7-753b-d662-6a75c6d16314@...2080...>
	<20161101111010.GH28918@...1296...>
	<17b0a8f9-ebc5-d46a-b024-eb0bf57bafe2@...515...>
	<dbafdc8e-a383-4e38-1ddb-9adc349a7ccf@...2080...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <0f0210b8-bf2d-f031-75e2-2f94b6ebb94d@...515...>
Date: Tue, 1 Nov 2016 16:56:35 +0200
MIME-Version: 1.0
In-Reply-To: <dbafdc8e-a383-4e38-1ddb-9adc349a7ccf@...2080...>
Subject: Re: [Openvpn-devel] trac 757 --auth-user-pass up + GUI 2.3 vs 2.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net, Gert Doering <gert@...1296...>

Hi,

Il 01/11/2016 16:05, David Sommerseth ha scritto:
> On 01/11/16 13:20, Samuli Sepp=E4nen wrote:
>> Hi,
>>
>> Il 01/11/2016 13:10, Gert Doering ha scritto:
>>> Hi,
>>>
>>> On Mon, Oct 31, 2016 at 11:55:08PM +0100, David Sommerseth wrote:
>>>> How long will users be willing to wait?  I'd be really surprised if 2.4
>>>> is out the door before Christmas 2016.  When also considering we've sa=
id
>>>> that 2.4_alpha was soon ready for about 1 year or so before it really
>>>> got released, I'd even say I am overly optimistic.
>>>
>>> If we could spend our time on a somewhat focused work on 2.4, instead
>>> of exhausting ourselves discussing feature backports to 2.3, this could
>>> happen faster.
>>>
>>> And more *focused* work: less rounds of review, buildbot explosions, et=
c.,
>>> which eats up everyone else's precious time.
>>
>> It would be good to:
>>
>> 1) Catch the issues before buildbot
>>
>> In my recent INSTALL-win32.txt removal patch the breakage could have
>> been avoided if I had been less sloppy and had actually tried to build
>> the thing before sending in the patch.
>>
>> A basic "make check" goes a long way, but I intend to de-bashify the
>> Vagrant integration soonish, so that we can merge it. This should make
>> it easier for developers to catch runtime errors before sending in patch=
es:
>>
>> <https://github.com/OpenVPN/openvpn/pull/45>
>>
>> 2) Have buildbot catch issues before code is in Git "master"
>>
>> This could be solved by tracking an "experimental" or "buildslave"
>> branch in Git, which would be basically Git "master" preview with forced
>> update (history rewrite) option. Normal people should never use this
>> branch, as the history would get rewritten whenever a patch would have
>> to be rolled back. This would help ensure that Git "master" is always in
>> a good shape.
>>
>> That said, doing 1) properly should help mitigate the risk of Git
>> "master" breaking often. The less trivial issues will not be found on a
>> single developer machine anyways.
>
> I thought that we initially started with buildbot to *identify* such
> build errors before *release*; as we happened to have a few releases
> where we broke in similar ways during releases.  IIRC, the argument

Your most likely correct - I can't recall all the details anymore.=20
However, buildbot turned out to reveal errors way sooner than at release=20
time, and that is really good.

> which surfaced back then was something along the line that it is too
> much to expect developers to do builds with all reasonable configuration
> options.  So if that has changed over the year, I surely have missed
> that memo.

I don't think anything has changed on this front. That said, our usage=20
of Buildbot (or CI tool <n>) does not have to remain static.

> To avoid this, we *must* have this automated somehow; otherwise things
> either won't improve or people just avoid contributing due to too heavy
> process - which some already do complain about today.

+1 for automating the tests as much as possible. Vagrant will be another=20
tool that will help some developers, especially when doing invasive patches.

I don't think we should _mandate_ a very heavy testing process, as that=20
drives people away.

>
> From the topics for the meeting next week I see proposals for using
> patchwork (funny enough, I suggested this many years ago but it was
> considered too much back then).  Hook that up against something which
> runs some thorough tests on some buildbots (without spamming all
> failers) and report back to the patch - that can truly help.  On the
> other hand, we need to ensure we have some way of controlling whom can
> trigger such builds.  I don't think we should allow random patches from
> lesser known contributors to the ML to be kicked off automatically (for
> security reasons); those will need a quick review and a confirmation it
> is safe to test.  Once that process gives all green lights, we can do
> the proper review and apply if ACKed.

Yeah, this all sounds reasonable.

>
> With that said ... Having the master branch always run perfectly is a
> nice goal, but it is an utopia to believe we will reach that goal and it
> always will be perfect.  We will need to accept, whether we like or not,

Indeed. That is why I did not claim we would reach that goal :).

> that git master will explode from time to time.  When that happen, we
> fix it as soon as possible (preferably within the same working day) and
> move on.  No reasons to make more fuzz about that.
>

Yes, of course. But we can still reduce pointless explosions. I think=20
"OpenVPN must build on your development platform after your patch" is a=20
reasonable requirement. If I had followed that policy myself, there=20
would not have been any need for you to fix my explosion.

> All of us who I consider core developers have from time to time sent
> patches which have been applied and which exploded things in various
> ways.  So there's no need to point fingers at anyone particular, because
> this is how things have been and will continue to be.  Some periods
> better than others, some periods are worse.  But we do what we always
> do; we fix it and move on.
>

I don't think anyone is pointing any fingers at anyone. At most I'm=20
pointing my own finger at myself for the INSTALL-win32.txt patch.

> [...snip...]
>
>>> I still think the timeline "end of 2016" should be doable - there's
>>> some reasoning to meet that: it will make the next Debian release.
>>
>> If Debian 9 is frozen by the end of the year, then that is a good goal.
>
> Yes, that is a good goal.  And we *must* reach that one, IMO.
>

Agreed. I don't see any major blockers there. We just have to push out=20
2.4 beta/rc releases out in quick succession to reach that goal.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

