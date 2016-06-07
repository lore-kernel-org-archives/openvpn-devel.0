MIME-Version: 1.0
In-Reply-To: <c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Jun 2016 12:40:37 +0500
Message-ID: <CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d31c81bf03a0534ab4e15
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
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--047d7b5d31c81bf03a0534ab4e15
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

it is not true that Travis-CI is limited to Linux/Ubuntu, at least there's
Mac OS X.
and we can set up (later) cross builds for MIPS/ARM/Windows/whatever (not
sure about "make check")

cross build would be good starting point, if there was such thing already,
we could notice that mingw build got broken

2016-06-07 12:30 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

>
> > =E2=80=A6
> >
> >> IMO, the unit testing patches shouldn't have been merged into the
> >> release branch
> >
> > I agree. This patch was in retrospective clearly not ready for a release
> > branch. A lot of people spend time to hot fix a broken build.
> >
> > My root cause analysis boils down to:
> >
> >    Developers cannot detect multi-platform (build/run) issues with an
> > appropriate effort (or at all).
>
> This is probably correct: the codebase is complex enough to cause
> breakage on many types of changes, no matter how carefully the code is
> reviewed. This is often because of the sheer number of options and their
> invisible interplay. A recent example is the recent persist-tun / WFP
> filtering issue, which slipped through all testing and review.
>
> Regression testing using unit tests could possibly help us prevent this
> type of breakages.
>
> > We already have discussed solutions to this:
> >
> > 1) Enable developers to run the =E2=80=9Cauthoritative=E2=80=9D buildsl=
ave tests before
> > submitting patches
>
> The buildmaster can trigger manual builds from a different branch (e.g.
> "staging/somebody"). Access to the buildmaster can be granted
> selectively to trusted core developers. Non-trivial patches from other
> people should probably be tested by one of these core developers before
> pushing them to "master". Or we can just accept the fact that "master"
> might be broken occasionally and fix the problems promptly.
>
> > 2) Provide developers tooling to quickly (preferred: locally) run
> > iterations while developing
>
> The Vagrant approach is nice because it will eventually allow developers
> to run a fairly extensive smoketests on several various operating
> systems with minimal effort:
>
> <https://github.com/OpenVPN/openvpn/pull/45>
>
> Right now the OS coverage is fairly minimal, but more variants can be
> added easily, and we're not limited to Linux/Ubuntu like with Travis.
>
> > #1 will need some processes & tooling by the current  maintainers.
> > #2 will be taken care of with the Vagrant based integration tests.
> >
> > Opinions?
>
> In addition to #1 and #2 we have Travis-CI smoke-testing in the pipeline:
>
> <https://github.com/OpenVPN/openvpn/pull/52>
>
> Travis-CI gives us some confidence on the quality of GitHub PRs, but
> it's test matrix is much narrower than that of Buildbot, so it's
> definitely not a panacea.
>
> The only real way to test the more tricky corner-cases is to make it as
> easy as possible to use Git "master" -based builds. For Windows this is
> already covered by the Windows "buildslave" and the snapshots it
> generates. I can setup apt repositories with Debian/Ubuntu builds based
> on Git "master", but right now I don't have enough time to commit to that.
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
>
> -------------------------------------------------------------------------=
-----
> What NetFlow Analyzer can do for you? Monitors network bandwidth and
> traffic
> patterns at an interface-level. Reveals which users, apps, and protocols
> are
> consuming the most bandwidth. Provides multi-vendor support for NetFlow,
> J-Flow, sFlow and other flows. Make informed decisions using capacity
> planning reports. https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--047d7b5d31c81bf03a0534ab4e15
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div>it is not true that Travis-CI is limited to Linu=
x/Ubuntu, at least there&#39;s Mac OS X.<br></div>and we can set up (later)=
 cross builds for MIPS/ARM/Windows/whatever (not sure about &quot;make chec=
k&quot;)<br><br></div>cross build would be good starting point, if there wa=
s such thing already, we could notice that mingw build got broken<br></div>=
<div class=3D"gmail_extra"><br><div class=3D"gmail_quote">2016-06-07 12:30 =
GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samu=
li@...515..." target=3D"_blank">samuli@...515...</a>&gt;</span>:<br><blockq=
uote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc =
solid;padding-left:1ex"><br>
&gt; =E2=80=A6<br>
&gt;<br>
&gt;&gt; IMO, the unit testing patches shouldn&#39;t have been merged into =
the<br>
&gt;&gt; release branch<br>
&gt;<br>
&gt; I agree. This patch was in retrospective clearly not ready for a relea=
se<br>
&gt; branch. A lot of people spend time to hot fix a broken build.<br>
&gt;<br>
&gt; My root cause analysis boils down to:<br>
&gt;<br>
&gt;=C2=A0 =C2=A0 Developers cannot detect multi-platform (build/run) issue=
s with an<br>
&gt; appropriate effort (or at all).<br>
<br>
This is probably correct: the codebase is complex enough to cause<br>
breakage on many types of changes, no matter how carefully the code is<br>
reviewed. This is often because of the sheer number of options and their<br>
invisible interplay. A recent example is the recent persist-tun / WFP<br>
filtering issue, which slipped through all testing and review.<br>
<br>
Regression testing using unit tests could possibly help us prevent this<br>
type of breakages.<br>
<br>
&gt; We already have discussed solutions to this:<br>
&gt;<br>
&gt; 1) Enable developers to run the =E2=80=9Cauthoritative=E2=80=9D builds=
lave tests before<br>
&gt; submitting patches<br>
<br>
The buildmaster can trigger manual builds from a different branch (e.g.<br>
&quot;staging/somebody&quot;). Access to the buildmaster can be granted<br>
selectively to trusted core developers. Non-trivial patches from other<br>
people should probably be tested by one of these core developers before<br>
pushing them to &quot;master&quot;. Or we can just accept the fact that &qu=
ot;master&quot;<br>
might be broken occasionally and fix the problems promptly.<br>
<br>
&gt; 2) Provide developers tooling to quickly (preferred: locally) run<br>
&gt; iterations while developing<br>
<br>
The Vagrant approach is nice because it will eventually allow developers<br>
to run a fairly extensive smoketests on several various operating<br>
systems with minimal effort:<br>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn/pull/45" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/45</a>&gt;<br>
<br>
Right now the OS coverage is fairly minimal, but more variants can be<br>
added easily, and we&#39;re not limited to Linux/Ubuntu like with Travis.<b=
r>
<br>
&gt; #1 will need some processes &amp; tooling by the current=C2=A0 maintai=
ners.<br>
&gt; #2 will be taken care of with the Vagrant based integration tests.<br>
&gt;<br>
&gt; Opinions?<br>
<br>
In addition to #1 and #2 we have Travis-CI smoke-testing in the pipeline:<b=
r>
<br>
&lt;<a href=3D"https://github.com/OpenVPN/openvpn/pull/52" rel=3D"noreferre=
r" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/52</a>&gt;<br>
<br>
Travis-CI gives us some confidence on the quality of GitHub PRs, but<br>
it&#39;s test matrix is much narrower than that of Buildbot, so it&#39;s<br>
definitely not a panacea.<br>
<br>
The only real way to test the more tricky corner-cases is to make it as<br>
easy as possible to use Git &quot;master&quot; -based builds. For Windows t=
his is<br>
already covered by the Windows &quot;buildslave&quot; and the snapshots it<=
br>
generates. I can setup apt repositories with Debian/Ubuntu builds based<br>
on Git &quot;master&quot;, but right now I don&#39;t have enough time to co=
mmit to that.<br>
<br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
---------------------------------------------------------------------------=
---<br>
What NetFlow Analyzer can do for you? Monitors network bandwidth and traffi=
c<br>
patterns at an interface-level. Reveals which users, apps, and protocols ar=
e<br>
consuming the most bandwidth. Provides multi-vendor support for NetFlow,<br>
J-Flow, sFlow and other flows. Make informed decisions using capacity<br>
planning reports. <a href=3D"https://ad.doubleclick.net/ddm/clk/305295220;1=
32659582;e" rel=3D"noreferrer" target=3D"_blank">https://ad.doubleclick.net=
/ddm/clk/305295220;132659582;e</a><br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div><br></div>

--047d7b5d31c81bf03a0534ab4e15--

