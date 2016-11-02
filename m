References: <2987ae32-9a53-1888-11af-bf7d9741eecd@...2080...>
	<981f9961-a72f-727a-37de-a2741c8d73c9@...1227...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <4c5d5326-1ebe-95d0-9e0e-d3d6f1ef06d6@...515...>
Date: Wed, 2 Nov 2016 10:12:59 +0200
MIME-Version: 1.0
In-Reply-To: <981f9961-a72f-727a-37de-a2741c8d73c9@...1227...>
Subject: Re: [Openvpn-devel] OpenVPN v2.4 release progress
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net, David Sommerseth <openvpn@...2080...>

Il 02/11/2016 00:52, Arne Schwabe ha scritto:
> On 01.11.2016 23:47, David Sommerseth wrote:
>>
>> I'm splitting of the originating thread to a new one, to refocus the
>> discussion.
>>
>> On 01/11/16 15:56, Samuli Sepp=E4nen wrote:
>>> Il 01/11/2016 16:05, David Sommerseth ha scritto:
>>>> [...snip...]
>>>>
>>>>>> I still think the timeline "end of 2016" should be doable -
>>>>>> there's some reasoning to meet that: it will make the next
>>>>>> Debian release.
>>>>>
>>>>> If Debian 9 is frozen by the end of the year, then that is a
>>>>> good goal.
>>>>
>>>> Yes, that is a good goal.  And we *must* reach that one, IMO.
>>>>
>>
>>> Agreed. I don't see any major blockers there. We just have to push
>>> out 2.4 beta/rc releases out in quick succession to reach that
>>> goal.
>>
>> Samuli and I have had a little side-channel dialogue in regards to the
>> release schedule today.
>>
>> According to this [1] overview, Debian 9 (Stretch) have the soft-freeze
>> deadline January 5, 2017.  That is the date we must have released the
>> final 2.4 to be in the Debian game.
>>
>> [1] <https://wiki.debian.org/DebianStretch>
>>
>> That doesn't sound too bad.  But it is a very short deadline - 9 weeks!
>> Including a Christmas holiday (roughly 2 weeks), where we can't expect
>> too much to happen.  And we should have at least one week slack to catch
>> critical emergencies before the final release.  Which means we have 6
>> weeks to go from alpha2 to 2.4.0.
>>
>> My opinion is that we do not have time for the complete alpha/beta/rc
>> cycles.  We need to skip either beta or RC, unless we decide to release
>> the first beta this week.
>>
>> I _/*SUGGEST*/_ a schedule like this:
>>
>>
>> * November 1st - "TODAY" (for roughly 20 more minutes)
>>   2.4_alpha2 has been out for almost 2 weeks (13 days, if I'm not
>>   mistaken).  We have 11 patches queued up in master since that release.
>>
>>
>> * November 7th
>>   Developers meeting.  Agree on what goes into the beta/rc release
>>   and not.   Also agree on if we simplify the release cycle.
>>
>>
>> * November 8th
>>   If we agree to have 3 stages, alpha3 must be released.  After this
>>   date we start to be stricter about the patches for a while.
>>
>>   Patches which should go into this or the next release:
>>   - [PATCH] struct argv overhaul
>>     <http://bit.ly/2ebnhKz>
>>
>>   - [PATCH] Refactor CRL handling
>>     <http://bit.ly/2eYUMkK>
>>     Also look at the CRL patches from Antonio as well.
>>
>>   - [PATCH 0/2] auth-gen-token: Inform client why auth-token was
>>                rejected
>>     <http://bit.ly/2f7GEJ3>
>>
>>   - [PATCH] systemd: Improve the systemd unit files
>>     <http://bit.ly/2eboMIq>
>>
>>
>> * November 16th
>>   Release first beta.  No new features allowed, stabilising
>>   starts for real.  Some minor "nice to have patches" might be
>>   accepted after evaluation/discussion on IRC.
>>
>>   Patch to consider:
>>   - Add --bind-dev option (Linux VRF + *BSD IP_SENDIF)
>>     <http://bit.ly/2e02v5f>  (Patch on github)
>>     <http://bit.ly/2ebo2mU>  (Mail-archive.com thread)
>>
>>
>> * November 23rd (optional)
>>   Release second beta.  Only patches related to stabilising and
>>   important bug-fixes are allowed after this point.  No more "nice to
>>   have patches" after this point.
>>
>>
>> * December 1st
>>   First pre-release (3rd beta or 1st rc)
>>   Only really needed and critical bug fixes allowed.  This is also the
>>   time where we change to a unified coding style across the whole
>>   source code.
>>
>>
>> * December 15th
>>   Final pre-release (beta/rc) before v2.4.0.
>>   Branching out release/2.4 happens here.
>>
>>   Reason: We need to ensure people will have at least _some_ time to
>>           test before Christmas and some have the ability to run tests
>>           during the last weeks of December.
>>
>>
>> * January 4th, 2017
>>   Final release of v2.4.0
>>
>>
>> The list of patches are the most recent ones I spotted on the mailing
>> list which seems relevant.  We might consider other patches too, my
>> patch list is just a proposal.
>>
>> One remark to one the patches: The VRF patches I consider for v2.4 just
>> because this seems very useful and doesn't add a very complicated patch.
>>  Considering that 2.4 will live in Debian for a long while, that
>> platform can make most out of this patch as well.  In addition, the
>> feature is well isolated from the rest of the code.
>>
>> To manage such a schedule, we really need to ensure patches gets
>> reviewed and ACKed ASAP to be sure things gets included.  It will
>> require some efforts from everyone.
>>
>>
>> Any thoughts or comments?
>>
> We should talk with the debian maintainer and ask what we have to do to
> get 2.4.0 into the new debian. Obviously if he/she does not package
> OpenVPN in time we still loose.
>
> Arne

I already did. I mentioned that on the IRC yesterday evening. No=20
response from Alberto so far.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

