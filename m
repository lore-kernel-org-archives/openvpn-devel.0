References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
Date: Tue, 7 Jun 2016 10:30:57 +0300
MIME-Version: 1.0
In-Reply-To: <0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
Subject: Re: [Openvpn-devel] [PATCH] Another fix related to unit test
 framework
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
To: Jens Neuhalfen <openvpn-devel@...2127...>, Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>


> =85
>
>> IMO, the unit testing patches shouldn't have been merged into the
>> release branch
>
> I agree. This patch was in retrospective clearly not ready for a release
> branch. A lot of people spend time to hot fix a broken build.
>
> My root cause analysis boils down to:
>
>    Developers cannot detect multi-platform (build/run) issues with an
> appropriate effort (or at all).

This is probably correct: the codebase is complex enough to cause=20
breakage on many types of changes, no matter how carefully the code is=20
reviewed. This is often because of the sheer number of options and their=20
invisible interplay. A recent example is the recent persist-tun / WFP=20
filtering issue, which slipped through all testing and review.

Regression testing using unit tests could possibly help us prevent this=20
type of breakages.

> We already have discussed solutions to this:
>
> 1) Enable developers to run the =93authoritative=94 buildslave tests befo=
re
> submitting patches

The buildmaster can trigger manual builds from a different branch (e.g.=20
"staging/somebody"). Access to the buildmaster can be granted=20
selectively to trusted core developers. Non-trivial patches from other=20
people should probably be tested by one of these core developers before=20
pushing them to "master". Or we can just accept the fact that "master"=20
might be broken occasionally and fix the problems promptly.

> 2) Provide developers tooling to quickly (preferred: locally) run
> iterations while developing

The Vagrant approach is nice because it will eventually allow developers=20
to run a fairly extensive smoketests on several various operating=20
systems with minimal effort:

<https://github.com/OpenVPN/openvpn/pull/45>

Right now the OS coverage is fairly minimal, but more variants can be=20
added easily, and we're not limited to Linux/Ubuntu like with Travis.

> #1 will need some processes & tooling by the current  maintainers.
> #2 will be taken care of with the Vagrant based integration tests.
>
> Opinions?

In addition to #1 and #2 we have Travis-CI smoke-testing in the pipeline:

<https://github.com/OpenVPN/openvpn/pull/52>

Travis-CI gives us some confidence on the quality of GitHub PRs, but=20
it's test matrix is much narrower than that of Buildbot, so it's=20
definitely not a panacea.

The only real way to test the more tricky corner-cases is to make it as=20
easy as possible to use Git "master" -based builds. For Windows this is=20
already covered by the Windows "buildslave" and the snapshots it=20
generates. I can setup apt repositories with Debian/Ubuntu builds based=20
on Git "master", but right now I don't have enough time to commit to that.

--=20
Samuli Sepp=E4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

