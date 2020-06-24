MIME-Version: 1.0
References: <cde19afd-b6cb-3b99-b346-1cfcdcebbbe2@...515...>
 <c31ed4c7-5451-cca7-1ba2-6a7a0eeecb59@...515...>
In-Reply-To: <c31ed4c7-5451-cca7-1ba2-6a7a0eeecb59@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 25 Jun 2020 00:52:30 +0500
Message-ID: <CAFHpkQHRHV5h6LyWxM73-dLcHLvxUFBnpPMNuMtU2R13a+kyJA@...278...>
Content-Type: multipart/alternative; boundary="000000000000a2d3e805a8d9d1b7"
Subject: Re: [Openvpn-devel] Summary of the community meeting (24th June
 2020)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000a2d3e805a8d9d1b7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

there's quite an interesting patchset
https://patchwork.openvpn.net/project/openvpn2/list/?series=3D230
is it scheduled for 2.5 release ?

or I've missed something and all patches are scheduled for 2.5 ?

=D1=81=D1=80, 24 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 16:11, Samuli Sepp=
=C3=A4nen <samuli@...515...>:

> Hi,
>
> Here's the summary of the IRC meeting.
>
> ---
>
> COMMUNITY MEETING
>
> Place: #openvpn-meeting on irc.freenode.net
> Date: Wed 24th June 2020
> Time: 11:30 CEST (9:30 UTC)
>
> Planned meeting topics for this meeting were here:
>
> <https://community.openvpn.net/openvpn/wiki/Topics-2020-06-24>
>
> Your local meeting time is easy to check from services such as
>
> <http://www.timeanddate.com/worldclock>
>
> SUMMARY
>
> cron2, dazo, lev, mattock, plaisthos and uip participated in this meeting.
>
> ---
>
> Talked about the status of OpenVPN 2.5:
>
> <https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25>
>
> Ordex promised to have a look at the async-cc patches this week.
> Plaisthos, dazo and cron2 will follow-up on the review comments to get
> them resolved quickly.
>
> OpenVPN 2.5 MSI looks surprisingly good. Mattock was able to produce
> tap-windows6 MSM ("merge module") which he then used to produce OpenVPN
> 2.5-based MSI installer. The only significant challenge is adding
> code-signing support to openvpn-build/generic.
>
> Automating MSI builds also seems easier than expected, given that the
> existing openvpn-build buildslave can perform the actual build and push
> the artifacts to the Windows packager, which can then build and push the
> results to build.openvpn.net.
>
> Code-vise 2.5-alpha1 is in a good shape, mainly missing
>
> - compression
> - async cc
> - VRF (which is quite trivial)
>
> The auth-token fixes are corner-cases and it was agreed that that can be
> resolved between 2.5-alpha1 and 2.5-beta1.
>
> ---
>
> Talked about moving 2.3 into "oldstable" support mode. Previously we had
> agreed to do that when 2.3.19 was released. However, 2.3.18 was released
> a long while ago and there's nothing queued for 2.3.19. So it was
> decided to move 2.3 to "oldstable" now instead of later.
>
> ---
>
> Talked about starting the deprecation of "--ncp-disable". The idea is
> that --ncp-disable has been mostly a debug feature and as we move
> forward and want to be able to manage VPN security more from server
> side, we want to abandon the possibility to ignore NCP.
>
> This is tied with deprecation of --cipher for everything except p2p:
>
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg20062=
.html
>
> Uip will bring these topics up with syzzer a.s.a.p.
>
> ---
>
> Talked about OpenVPN 2.6. There are several things that are 2.6 material:
>
> - Kernel acceleration module (client-side only beta ~next week)
> - Work related to "making DNS handling nice"
>
> It is possible that we'd also need to postpone the --ncp-disable and
> --cipher changes.
>
> However, it was agreed that doing a "quick" 2.6 release in, say, early
> 2021 is doable. It was also agreed that supporting both 2.5 and 2.6 as
> "stable" for a while would be acceptable, as the changes would be mostly
> in OpenVPN and the same release and automation tooling could be used for
> both.
>
> ---
>
> Talked about our use of IV_*. Agreed that rather than having tons of
> IV_FOO=3D1 options IV_PROTO should be considered a wire-protocol-only
> 64-bit mask field and IV_FEAT would be a new 64-bit mask field
> indicating which features the local side supports.
>
> OpenVPN will need to handle a remote side not providing IV_FEAT.
> Default behaviour when this field is missing must be documented.
> IV_FEAT should be sent by OpenVPN 2.6 and newer. This approach allows
> easier deprecation of features as well.
>
> --
>
> Full chatlog attached
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000a2d3e805a8d9d1b7
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>there&#39;s quite an interesting patchset <a href=3D"=
https://patchwork.openvpn.net/project/openvpn2/list/?series=3D230">https://=
patchwork.openvpn.net/project/openvpn2/list/?series=3D230</a></div><div>is =
it scheduled for 2.5 release ?</div><div><br></div><div>or I&#39;ve missed =
something and all patches are scheduled for 2.5 ?<br></div></div><br><div c=
lass=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=81=D1=80, 24=
 =D0=B8=D1=8E=D0=BD. 2020 =D0=B3. =D0=B2 16:11, Samuli Sepp=C3=A4nen &lt;<a=
 href=3D"mailto:samuli@...515...">samuli@...515...</a>&gt;:<br></div><block=
quote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1=
px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
Here&#39;s the summary of the IRC meeting.<br>
<br>
---<br>
<br>
COMMUNITY MEETING<br>
<br>
Place: #openvpn-meeting on <a href=3D"http://irc.freenode.net" rel=3D"noref=
errer" target=3D"_blank">irc.freenode.net</a><br>
Date: Wed 24th June 2020<br>
Time: 11:30 CEST (9:30 UTC)<br>
<br>
Planned meeting topics for this meeting were here:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/Topics-2020-06-24=
" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/openvp=
n/wiki/Topics-2020-06-24</a>&gt;<br>
<br>
Your local meeting time is easy to check from services such as<br>
<br>
&lt;<a href=3D"http://www.timeanddate.com/worldclock" rel=3D"noreferrer" ta=
rget=3D"_blank">http://www.timeanddate.com/worldclock</a>&gt;<br>
<br>
SUMMARY<br>
<br>
cron2, dazo, lev, mattock, plaisthos and uip participated in this meeting.<=
br>
<br>
---<br>
<br>
Talked about the status of OpenVPN 2.5:<br>
<br>
&lt;<a href=3D"https://community.openvpn.net/openvpn/wiki/StatusOfOpenvpn25=
" rel=3D"noreferrer" target=3D"_blank">https://community.openvpn.net/openvp=
n/wiki/StatusOfOpenvpn25</a>&gt;<br>
<br>
Ordex promised to have a look at the async-cc patches this week.<br>
Plaisthos, dazo and cron2 will follow-up on the review comments to get<br>
them resolved quickly.<br>
<br>
OpenVPN 2.5 MSI looks surprisingly good. Mattock was able to produce<br>
tap-windows6 MSM (&quot;merge module&quot;) which he then used to produce O=
penVPN<br>
2.5-based MSI installer. The only significant challenge is adding<br>
code-signing support to openvpn-build/generic.<br>
<br>
Automating MSI builds also seems easier than expected, given that the<br>
existing openvpn-build buildslave can perform the actual build and push<br>
the artifacts to the Windows packager, which can then build and push the<br>
results to <a href=3D"http://build.openvpn.net" rel=3D"noreferrer" target=
=3D"_blank">build.openvpn.net</a>.<br>
<br>
Code-vise 2.5-alpha1 is in a good shape, mainly missing<br>
<br>
- compression<br>
- async cc<br>
- VRF (which is quite trivial)<br>
<br>
The auth-token fixes are corner-cases and it was agreed that that can be<br>
resolved between 2.5-alpha1 and 2.5-beta1.<br>
<br>
---<br>
<br>
Talked about moving 2.3 into &quot;oldstable&quot; support mode. Previously=
 we had<br>
agreed to do that when 2.3.19 was released. However, 2.3.18 was released<br>
a long while ago and there&#39;s nothing queued for 2.3.19. So it was<br>
decided to move 2.3 to &quot;oldstable&quot; now instead of later.<br>
<br>
---<br>
<br>
Talked about starting the deprecation of &quot;--ncp-disable&quot;. The ide=
a is<br>
that --ncp-disable has been mostly a debug feature and as we move<br>
forward and want to be able to manage VPN security more from server<br>
side, we want to abandon the possibility to ignore NCP.<br>
<br>
This is tied with deprecation of --cipher for everything except p2p:<br>
<br>
<a href=3D"https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg20062.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg20062.html</a><br>
<br>
Uip will bring these topics up with syzzer a.s.a.p.<br>
<br>
---<br>
<br>
Talked about OpenVPN 2.6. There are several things that are 2.6 material:<b=
r>
<br>
- Kernel acceleration module (client-side only beta ~next week)<br>
- Work related to &quot;making DNS handling nice&quot;<br>
<br>
It is possible that we&#39;d also need to postpone the --ncp-disable and<br>
--cipher changes.<br>
<br>
However, it was agreed that doing a &quot;quick&quot; 2.6 release in, say, =
early<br>
2021 is doable. It was also agreed that supporting both 2.5 and 2.6 as<br>
&quot;stable&quot; for a while would be acceptable, as the changes would be=
 mostly<br>
in OpenVPN and the same release and automation tooling could be used for<br>
both.<br>
<br>
---<br>
<br>
Talked about our use of IV_*. Agreed that rather than having tons of<br>
IV_FOO=3D1 options IV_PROTO should be considered a wire-protocol-only<br>
64-bit mask field and IV_FEAT would be a new 64-bit mask field<br>
indicating which features the local side supports.<br>
<br>
OpenVPN will need to handle a remote side not providing IV_FEAT.<br>
Default behaviour when this field is missing must be documented.<br>
IV_FEAT should be sent by OpenVPN 2.6 and newer. This approach allows<br>
easier deprecation of features as well.<br>
<br>
--<br>
<br>
Full chatlog attached<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank">Op=
envpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000a2d3e805a8d9d1b7--

