References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
From: =?UTF-8?Q?Samuli_Sepp=c3=a4nen?= <samuli@...515...>
Message-ID: <d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
Date: Tue, 7 Jun 2016 10:58:42 +0300
MIME-Version: 1.0
In-Reply-To: <CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
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
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: quoted-printable
To: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

I stand corrected. However, cross-building is not a replacement for=20
building on the actual OS.

Do cross-builds generally catch useful issues, or do they tend to catch=20
issues related to the cross-building environment itself?

--=20
Samuli Sepp=C3=A4nen
Community Manager
OpenVPN Technologies, Inc

irc freenode net: mattock

> it is not true that Travis-CI is limited to Linux/Ubuntu, at least
> there's Mac OS X.
> and we can set up (later) cross builds for MIPS/ARM/Windows/whatever
> (not sure about "make check")
>
> cross build would be good starting point, if there was such thing
> already, we could notice that mingw build got broken
>
> 2016-06-07 12:30 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
> <mailto:samuli@...515...>>:
>
>
>     > =E2=80=A6
>     >
>     >> IMO, the unit testing patches shouldn't have been merged into the
>     >> release branch
>     >
>     > I agree. This patch was in retrospective clearly not ready for a
>     release
>     > branch. A lot of people spend time to hot fix a broken build.
>     >
>     > My root cause analysis boils down to:
>     >
>     >    Developers cannot detect multi-platform (build/run) issues with =
an
>     > appropriate effort (or at all).
>
>     This is probably correct: the codebase is complex enough to cause
>     breakage on many types of changes, no matter how carefully the code is
>     reviewed. This is often because of the sheer number of options and th=
eir
>     invisible interplay. A recent example is the recent persist-tun / WFP
>     filtering issue, which slipped through all testing and review.
>
>     Regression testing using unit tests could possibly help us prevent th=
is
>     type of breakages.
>
>     > We already have discussed solutions to this:
>     >
>     > 1) Enable developers to run the =E2=80=9Cauthoritative=E2=80=9D bui=
ldslave tests
>     before
>     > submitting patches
>
>     The buildmaster can trigger manual builds from a different branch (e.=
g.
>     "staging/somebody"). Access to the buildmaster can be granted
>     selectively to trusted core developers. Non-trivial patches from other
>     people should probably be tested by one of these core developers befo=
re
>     pushing them to "master". Or we can just accept the fact that "master"
>     might be broken occasionally and fix the problems promptly.
>
>     > 2) Provide developers tooling to quickly (preferred: locally) run
>     > iterations while developing
>
>     The Vagrant approach is nice because it will eventually allow develop=
ers
>     to run a fairly extensive smoketests on several various operating
>     systems with minimal effort:
>
>     <https://github.com/OpenVPN/openvpn/pull/45>
>
>     Right now the OS coverage is fairly minimal, but more variants can be
>     added easily, and we're not limited to Linux/Ubuntu like with Travis.
>
>     > #1 will need some processes & tooling by the current  maintainers.
>     > #2 will be taken care of with the Vagrant based integration tests.
>     >
>     > Opinions?
>
>     In addition to #1 and #2 we have Travis-CI smoke-testing in the
>     pipeline:
>
>     <https://github.com/OpenVPN/openvpn/pull/52>
>
>     Travis-CI gives us some confidence on the quality of GitHub PRs, but
>     it's test matrix is much narrower than that of Buildbot, so it's
>     definitely not a panacea.
>
>     The only real way to test the more tricky corner-cases is to make it =
as
>     easy as possible to use Git "master" -based builds. For Windows this =
is
>     already covered by the Windows "buildslave" and the snapshots it
>     generates. I can setup apt repositories with Debian/Ubuntu builds bas=
ed
>     on Git "master", but right now I don't have enough time to commit to
>     that.
>
>     --
>     Samuli Sepp=C3=A4nen
>     Community Manager
>     OpenVPN Technologies, Inc
>
>     irc freenode net: mattock
>
>     ---------------------------------------------------------------------=
---------
>     What NetFlow Analyzer can do for you? Monitors network bandwidth and
>     traffic
>     patterns at an interface-level. Reveals which users, apps, and
>     protocols are
>     consuming the most bandwidth. Provides multi-vendor support for NetFl=
ow,
>     J-Flow, sFlow and other flows. Make informed decisions using capacity
>     planning reports.
>     https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
>     _______________________________________________
>     Openvpn-devel mailing list
>     Openvpn-devel@lists.sourceforge.net
>     <mailto:Openvpn-devel@lists.sourceforge.net>
>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>



