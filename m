MIME-Version: 1.0
In-Reply-To: <d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
References: <1464883738-904-1-git-send-email-openvpn@...2080...>
	<1464976163-6162-1-git-send-email-openvpn@...2080...>
	<20160603181404.GM53051@...1296...>
	<CAKuzo_hyz1g_VqiU_AR-Q69FiXA_9K+MmPYsE=J3M41iKjyDeA@...278...>
	<CAKuzo_geGTkH_d42-xnx7NJUXBRFyahajJAdW8+eZ0eYn2HRpg@...278...>
	<0EB7FB8D-1A08-4320-A587-435B0B280071@...2127...>
	<c9f39c1c-918b-843d-9a9b-220908198a90@...515...>
	<CAFHpkQEncM1BS_tCa_uVvbvkJZ+C850KHUui3-6pC3ECZQQJLA@...278...>
	<d1009561-03cb-3ea9-ab38-fce585f56f5f@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 7 Jun 2016 13:23:55 +0500
Message-ID: <CAFHpkQF-Xr5zH=LuC5rkZz8qkde1nvm1G85fM4kXkWB2KVPrTw@...278...>
Content-Type: multipart/alternative; boundary=047d7b5d31c8fbffae0534abe878
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

--047d7b5d31c8fbffae0534abe878
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

mingw is an official way of building windows packages. I guess something
like that appliable for ARM as well (I haven't heard about compilers
running on those machines)


so, if we can catch an issue during such compile, it is good.

2016-06-07 12:58 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> I stand corrected. However, cross-building is not a replacement for
> building on the actual OS.
>
> Do cross-builds generally catch useful issues, or do they tend to catch
> issues related to the cross-building environment itself?
>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>
> it is not true that Travis-CI is limited to Linux/Ubuntu, at least
>> there's Mac OS X.
>> and we can set up (later) cross builds for MIPS/ARM/Windows/whatever
>> (not sure about "make check")
>>
>> cross build would be good starting point, if there was such thing
>> already, we could notice that mingw build got broken
>>
>> 2016-06-07 12:30 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...
>> <mailto:samuli@...515...>>:
>>
>>
>>
>>     > =E2=80=A6
>>     >
>>     >> IMO, the unit testing patches shouldn't have been merged into the
>>     >> release branch
>>     >
>>     > I agree. This patch was in retrospective clearly not ready for a
>>     release
>>     > branch. A lot of people spend time to hot fix a broken build.
>>     >
>>     > My root cause analysis boils down to:
>>     >
>>     >    Developers cannot detect multi-platform (build/run) issues with
>> an
>>     > appropriate effort (or at all).
>>
>>     This is probably correct: the codebase is complex enough to cause
>>     breakage on many types of changes, no matter how carefully the code =
is
>>     reviewed. This is often because of the sheer number of options and
>> their
>>     invisible interplay. A recent example is the recent persist-tun / WFP
>>     filtering issue, which slipped through all testing and review.
>>
>>     Regression testing using unit tests could possibly help us prevent
>> this
>>     type of breakages.
>>
>>     > We already have discussed solutions to this:
>>     >
>>     > 1) Enable developers to run the =E2=80=9Cauthoritative=E2=80=9D bu=
ildslave tests
>>     before
>>     > submitting patches
>>
>>     The buildmaster can trigger manual builds from a different branch
>> (e.g.
>>     "staging/somebody"). Access to the buildmaster can be granted
>>     selectively to trusted core developers. Non-trivial patches from oth=
er
>>     people should probably be tested by one of these core developers
>> before
>>     pushing them to "master". Or we can just accept the fact that "maste=
r"
>>     might be broken occasionally and fix the problems promptly.
>>
>>     > 2) Provide developers tooling to quickly (preferred: locally) run
>>     > iterations while developing
>>
>>     The Vagrant approach is nice because it will eventually allow
>> developers
>>     to run a fairly extensive smoketests on several various operating
>>     systems with minimal effort:
>>
>>     <https://github.com/OpenVPN/openvpn/pull/45>
>>
>>     Right now the OS coverage is fairly minimal, but more variants can be
>>     added easily, and we're not limited to Linux/Ubuntu like with Travis.
>>
>>     > #1 will need some processes & tooling by the current  maintainers.
>>     > #2 will be taken care of with the Vagrant based integration tests.
>>     >
>>     > Opinions?
>>
>>     In addition to #1 and #2 we have Travis-CI smoke-testing in the
>>     pipeline:
>>
>>     <https://github.com/OpenVPN/openvpn/pull/52>
>>
>>     Travis-CI gives us some confidence on the quality of GitHub PRs, but
>>     it's test matrix is much narrower than that of Buildbot, so it's
>>     definitely not a panacea.
>>
>>     The only real way to test the more tricky corner-cases is to make it
>> as
>>     easy as possible to use Git "master" -based builds. For Windows this
>> is
>>     already covered by the Windows "buildslave" and the snapshots it
>>     generates. I can setup apt repositories with Debian/Ubuntu builds
>> based
>>     on Git "master", but right now I don't have enough time to commit to
>>     that.
>>
>>     --
>>     Samuli Sepp=C3=A4nen
>>     Community Manager
>>     OpenVPN Technologies, Inc
>>
>>     irc freenode net: mattock
>>
>>
>> ------------------------------------------------------------------------=
------
>>     What NetFlow Analyzer can do for you? Monitors network bandwidth and
>>     traffic
>>     patterns at an interface-level. Reveals which users, apps, and
>>     protocols are
>>     consuming the most bandwidth. Provides multi-vendor support for
>> NetFlow,
>>     J-Flow, sFlow and other flows. Make informed decisions using capacity
>>     planning reports.
>>     https://ad.doubleclick.net/ddm/clk/305295220;132659582;e
>>     _______________________________________________
>>     Openvpn-devel mailing list
>>     Openvpn-devel@lists.sourceforge.net
>>     <mailto:Openvpn-devel@lists.sourceforge.net>
>>     https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>>
>>
>>
>
>

--047d7b5d31c8fbffae0534abe878
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>mingw is an official way of building windows packages=
. I guess something like that appliable for ARM as well (I haven&#39;t hear=
d about compilers running on those machines)<br><br><br></div>so, if we can=
 catch an issue during such compile, it is good.<br></div><div class=3D"gma=
il_extra"><br><div class=3D"gmail_quote">2016-06-07 12:58 GMT+05:00 Samuli =
Sepp=C3=A4nen <span dir=3D"ltr">&lt;<a href=3D"mailto:samuli@...515..." tar=
get=3D"_blank">samuli@...515...</a>&gt;</span>:<br><blockquote class=3D"gma=
il_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-lef=
t:1ex">I stand corrected. However, cross-building is not a replacement for =
building on the actual OS.<br>
<br>
Do cross-builds generally catch useful issues, or do they tend to catch iss=
ues related to the cross-building environment itself?<span class=3D""><br>
<br>
-- <br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
<br>
</span><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-=
left:1px #ccc solid;padding-left:1ex"><span class=3D"">
it is not true that Travis-CI is limited to Linux/Ubuntu, at least<br>
there&#39;s Mac OS X.<br>
and we can set up (later) cross builds for MIPS/ARM/Windows/whatever<br>
(not sure about &quot;make check&quot;)<br>
<br>
cross build would be good starting point, if there was such thing<br>
already, we could notice that mingw build got broken<br>
<br>
2016-06-07 12:30 GMT+05:00 Samuli Sepp=C3=A4nen &lt;<a href=3D"mailto:samul=
i@...515..." target=3D"_blank">samuli@...515...</a><br></span>
&lt;mailto:<a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...493...=
515...</a>&gt;&gt;:<div><div class=3D"h5"><br>
<br>
<br>
=C2=A0 =C2=A0 &gt; =E2=80=A6<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;&gt; IMO, the unit testing patches shouldn&#39;t have bee=
n merged into the<br>
=C2=A0 =C2=A0 &gt;&gt; release branch<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; I agree. This patch was in retrospective clearly not rea=
dy for a<br>
=C2=A0 =C2=A0 release<br>
=C2=A0 =C2=A0 &gt; branch. A lot of people spend time to hot fix a broken b=
uild.<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; My root cause analysis boils down to:<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt;=C2=A0 =C2=A0 Developers cannot detect multi-platform (bu=
ild/run) issues with an<br>
=C2=A0 =C2=A0 &gt; appropriate effort (or at all).<br>
<br>
=C2=A0 =C2=A0 This is probably correct: the codebase is complex enough to c=
ause<br>
=C2=A0 =C2=A0 breakage on many types of changes, no matter how carefully th=
e code is<br>
=C2=A0 =C2=A0 reviewed. This is often because of the sheer number of option=
s and their<br>
=C2=A0 =C2=A0 invisible interplay. A recent example is the recent persist-t=
un / WFP<br>
=C2=A0 =C2=A0 filtering issue, which slipped through all testing and review=
.<br>
<br>
=C2=A0 =C2=A0 Regression testing using unit tests could possibly help us pr=
event this<br>
=C2=A0 =C2=A0 type of breakages.<br>
<br>
=C2=A0 =C2=A0 &gt; We already have discussed solutions to this:<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; 1) Enable developers to run the =E2=80=9Cauthoritative=
=E2=80=9D buildslave tests<br>
=C2=A0 =C2=A0 before<br>
=C2=A0 =C2=A0 &gt; submitting patches<br>
<br>
=C2=A0 =C2=A0 The buildmaster can trigger manual builds from a different br=
anch (e.g.<br>
=C2=A0 =C2=A0 &quot;staging/somebody&quot;). Access to the buildmaster can =
be granted<br>
=C2=A0 =C2=A0 selectively to trusted core developers. Non-trivial patches f=
rom other<br>
=C2=A0 =C2=A0 people should probably be tested by one of these core develop=
ers before<br>
=C2=A0 =C2=A0 pushing them to &quot;master&quot;. Or we can just accept the=
 fact that &quot;master&quot;<br>
=C2=A0 =C2=A0 might be broken occasionally and fix the problems promptly.<b=
r>
<br>
=C2=A0 =C2=A0 &gt; 2) Provide developers tooling to quickly (preferred: loc=
ally) run<br>
=C2=A0 =C2=A0 &gt; iterations while developing<br>
<br>
=C2=A0 =C2=A0 The Vagrant approach is nice because it will eventually allow=
 developers<br>
=C2=A0 =C2=A0 to run a fairly extensive smoketests on several various opera=
ting<br>
=C2=A0 =C2=A0 systems with minimal effort:<br>
<br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/OpenVPN/openvpn/pull/45" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/=
45</a>&gt;<br>
<br>
=C2=A0 =C2=A0 Right now the OS coverage is fairly minimal, but more variant=
s can be<br>
=C2=A0 =C2=A0 added easily, and we&#39;re not limited to Linux/Ubuntu like =
with Travis.<br>
<br>
=C2=A0 =C2=A0 &gt; #1 will need some processes &amp; tooling by the current=
=C2=A0 maintainers.<br>
=C2=A0 =C2=A0 &gt; #2 will be taken care of with the Vagrant based integrat=
ion tests.<br>
=C2=A0 =C2=A0 &gt;<br>
=C2=A0 =C2=A0 &gt; Opinions?<br>
<br>
=C2=A0 =C2=A0 In addition to #1 and #2 we have Travis-CI smoke-testing in t=
he<br>
=C2=A0 =C2=A0 pipeline:<br>
<br>
=C2=A0 =C2=A0 &lt;<a href=3D"https://github.com/OpenVPN/openvpn/pull/52" re=
l=3D"noreferrer" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/=
52</a>&gt;<br>
<br>
=C2=A0 =C2=A0 Travis-CI gives us some confidence on the quality of GitHub P=
Rs, but<br>
=C2=A0 =C2=A0 it&#39;s test matrix is much narrower than that of Buildbot, =
so it&#39;s<br>
=C2=A0 =C2=A0 definitely not a panacea.<br>
<br>
=C2=A0 =C2=A0 The only real way to test the more tricky corner-cases is to =
make it as<br>
=C2=A0 =C2=A0 easy as possible to use Git &quot;master&quot; -based builds.=
 For Windows this is<br>
=C2=A0 =C2=A0 already covered by the Windows &quot;buildslave&quot; and the=
 snapshots it<br>
=C2=A0 =C2=A0 generates. I can setup apt repositories with Debian/Ubuntu bu=
ilds based<br>
=C2=A0 =C2=A0 on Git &quot;master&quot;, but right now I don&#39;t have eno=
ugh time to commit to<br>
=C2=A0 =C2=A0 that.<br>
<br>
=C2=A0 =C2=A0 --<br>
=C2=A0 =C2=A0 Samuli Sepp=C3=A4nen<br>
=C2=A0 =C2=A0 Community Manager<br>
=C2=A0 =C2=A0 OpenVPN Technologies, Inc<br>
<br>
=C2=A0 =C2=A0 irc freenode net: mattock<br>
<br>
=C2=A0 =C2=A0 -------------------------------------------------------------=
-----------------<br>
=C2=A0 =C2=A0 What NetFlow Analyzer can do for you? Monitors network bandwi=
dth and<br>
=C2=A0 =C2=A0 traffic<br>
=C2=A0 =C2=A0 patterns at an interface-level. Reveals which users, apps, an=
d<br>
=C2=A0 =C2=A0 protocols are<br>
=C2=A0 =C2=A0 consuming the most bandwidth. Provides multi-vendor support f=
or NetFlow,<br>
=C2=A0 =C2=A0 J-Flow, sFlow and other flows. Make informed decisions using =
capacity<br>
=C2=A0 =C2=A0 planning reports.<br>
=C2=A0 =C2=A0 <a href=3D"https://ad.doubleclick.net/ddm/clk/305295220;13265=
9582;e" rel=3D"noreferrer" target=3D"_blank">https://ad.doubleclick.net/ddm=
/clk/305295220;132659582;e</a><br>
=C2=A0 =C2=A0 _______________________________________________<br>
=C2=A0 =C2=A0 Openvpn-devel mailing list<br>
=C2=A0 =C2=A0 <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=
=3D"_blank">Openvpn-devel@lists.sourceforge.net</a><br></div></div>
=C2=A0 =C2=A0 &lt;mailto:<a href=3D"mailto:Openvpn-devel@...290...=
net" target=3D"_blank">Openvpn-devel@lists.sourceforge.net</a>&gt;<br>
=C2=A0 =C2=A0 <a href=3D"https://lists.sourceforge.net/lists/listinfo/openv=
pn-devel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.ne=
t/lists/listinfo/openvpn-devel</a><br>
<br>
<br>
</blockquote>
<br>
<br>
</blockquote></div><br></div>

--047d7b5d31c8fbffae0534abe878--

