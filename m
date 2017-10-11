References: <ff439b51-a63e-049c-afc6-56018e3b88b3@...515...>
 <acb8f237-9c4e-e545-a341-7e2daf585c4e@...1856...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d75c3f63-f0fd-af99-811e-6ed769b3386b@...515...>
Date: Wed, 11 Oct 2017 11:24:15 +0300
MIME-Version: 1.0
In-Reply-To: <acb8f237-9c4e-e545-a341-7e2daf585c4e@...1856...>
Content-Language: en-US
Subject: Re: [Openvpn-devel] How to manage code under the contrib/ directory?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
To: Steffan Karger <steffan@...1856...>, openvpn-devel@lists.sourceforge.net

Il 05/10/2017 17:04, Steffan Karger ha scritto:
> Hi,
>=20
> On 05-10-17 12:35, Samuli Sepp=C3=A4nen wrote:
>> In yesterday's community meeting we talked a bit about how to best
>> manage code under contrib/ directory:
>>
>> <https://github.com/OpenVPN/openvpn/tree/master/contrib>
>>
>> We agreed that code going there does not necessarily need to go through
>> our usual pretty strict review process. Accepting things without some
>> review, however, would definitely bite us back later.
>>
>> Getting more people involved in maintaining "contrib/" would be good, as
>> the brain-cycles of the core developers are fairly limited. We discussed
>> several options for encouraging participation from new people:
>>
>> 1) Allow GitHub pull requests for "contrib/"
>>
>> This is the least invasive approach. We would document this new policy
>> in GitHub, Trac and the Git repository. This would lower the barrier for
>> participation somewhat. Things under "contrib/" would still be
>> considered "official" OpenVPN code.
>=20
> Please don't mix contribution models within a single repo.  Accepting
> pull requests for contrib/, but rejecting them for other bits is going
> to be confusing for people.  Also, that would introduce merge commits in
> our git history, while our current workflow avoids those and results in
> a nice and clean history.

I tend to agree. Merge commits do make history look very messy (we use
them in some internal projects).

>> 2) Move "contrib/" to a separate "openvpn-contrib" Git repository
>>
>> Everything under "contrib/" would be in a single Git repository. Code in
>> that repository would be less "official" than for option #1.
>>
>>
>> 3) Create a separate Git repository for each contributed project
>>
>> In this model each contributed feature would become its own Git
>> repository. We've split things out of the main repository before and the
>> results have been a bit mixed. The OpenVPN GUI project has been a big
>> success with several developers contributing significant amounts of code:
>>
>> <https://github.com/OpenVPN/openvpn-gui/graphs/contributors>
>>
>> EasyRSA 3 has been surprisingly successful despite the fact that it has
>> not yet even become the "official" EasyRSA version:
>>
>> <https://github.com/OpenVPN/easy-rsa/graphs/contributors>
>>
>> The openvpn-build cross-compile buildsystem project has been moderately
>> successful, even though there are only a few regular contributors:
>>
>> <https://github.com/OpenVPN/openvpn-build/graphs/contributors>
>>
>> The EasyRSA 2 project could be considered a failure:
>>
>> <https://github.com/OpenVPN/easy-rsa-old/graphs/contributors>
>>
>> It was noted in the meeting, however, that EasyRSA 2 is mature and
>> probably there's not that much need to fix it. This could partly explain
>> why there have been very few contributions to EasyRSA 2.
>>
>> ---
>>
>> We do not wish to "drop the ball" on code under "contrib/". We would
>> also like to avoid the fate of the OpenVPN RADIUS plugin, which has been
>> forked several times in a row by individuals, leaving users with no idea
>> of which version is the least buggy one.
>>
>> Any thoughts on which of these options would be best if the goal is to
>> encourage participation in developing code under "contrib/"? Are there
>> other approaches which we have overlooked?
>>
>=20
> Why do we need to change anything at all?  I mean, the problem isn't the
> mailinglist, the problem is lack of reviewers, as far as I can tell.

The reason for changing the status quo is to get more people involved.
Based on our previous experience (openvpn-gui, openvpn-build, easy-rsa
3) splitting things out seems to attract new developers. I think this is
because of lower barrier of entry (GitHub) plus bigger feeling of ownership.

That said, I think we could argue this topic forever.

I suggest we start by making the RADIUS and LDAP plugins separate
subprojects under OpenVPN GitHub organization and see where that leads.
When/if a new development team has formed around the plugins we can
figure out what to do next. The new development teams will be able to
chime in at that point.

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

