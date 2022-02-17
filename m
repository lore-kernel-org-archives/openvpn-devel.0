MIME-Version: 1.0
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
 <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
 <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
 <CAGyAFMWQLs2=BoF6fhUcG6gLN5LvPA9xHZ8JRocdH5-DL5LW_w@...278...>
In-Reply-To: <CAGyAFMWQLs2=BoF6fhUcG6gLN5LvPA9xHZ8JRocdH5-DL5LW_w@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 17 Feb 2022 15:12:09 +0500
Message-ID: <CAFHpkQHURwN2x=AC_RK38tjwD8kGgHhSbq==espXJHSM33L6ZA@...278...>
Content-Type: multipart/alternative; boundary="00000000000072136c05d8340091"
Subject: Re: [Openvpn-devel] [PATCH 2.5] msvc: adjust build options to
 harden binaries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

--00000000000072136c05d8340091
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=87=D1=82, 17 =D1=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 13:53, Lev S=
tipakov <lstipakov@...277...>:

> Hi,
>
> Thanks for testing.
>
> > original patch does not apply
>
> Indeed it doesn't apply anymore since recent changes to vcxproj files.
> I have rebased it.
>
> > minor build issues still there: test =C2=B7 chipitsine/openvpn@...2654...=
.. (
> github.com)
>
> Those are likely because this was not applied
>
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg21774=
.html
> to your 2.5 branch.
> I have mentioned it in the patch email, but not in a commit message.
>
> > also, I have a question on <SDLCheck>true</SDLCheck>, in your patch it
> is not applied to all configurations, but to few of them. is it on purpos=
e ?
>
> For some reasons I missed debug configurations in some projects, I'll add
> those.
>
> Here are my GHa builds:
>
> master: https://github.com/lstipakov/openvpn/actions/runs/1857589993
> release/2.5
> <https://github.com/lstipakov/openvpn/actions/runs/1857589993release/2.5>:
> https://github.com/lstipakov/openvpn/actions/runs/1857547158


can you please apply "pdb" patch to your branch ?
CI: github actions: keep "pdb" in artifacts =C2=B7 OpenVPN/openvpn@...2655...=
..
<https://github.com/OpenVPN/openvpn/commit/9da733751ce80b2226ef19923365bd31=
02cfbd47>

BinSkim uses pdb for analysis.

probably, it makes sense to apply this patch to release/2.5 branch as well



>
>
> --
> -Lev
>

--00000000000072136c05d8340091
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 17 =D1=
=84=D0=B5=D0=B2=D1=80. 2022 =D0=B3. =D0=B2 13:53, Lev Stipakov &lt;<a href=
=3D"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt;:<br></div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:=
1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
Thanks for testing.<br>
<br>
&gt; original patch does not apply<br>
<br>
Indeed it doesn&#39;t apply anymore since recent changes to vcxproj files.<=
br>
I have rebased it.<br>
<br>
&gt; minor build issues still there: test =C2=B7 chipitsine/openvpn@...2656...=
... (<a href=3D"http://github.com" rel=3D"noreferrer" target=3D"_blank">git=
hub.com</a>)<br>
<br>
Those are likely because this was not applied<br>
<a href=3D"https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net=
/msg21774.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archi=
ve.com/openvpn-devel@lists.sourceforge.net/msg21774.html</a><br>
to your 2.5 branch.<br>
I have mentioned it in the patch email, but not in a commit message.<br>
<br>
&gt; also, I have a question on &lt;SDLCheck&gt;true&lt;/SDLCheck&gt;, in y=
our patch it is not applied to all configurations, but to few of them. is i=
t on purpose ?<br>
<br>
For some reasons I missed debug configurations in some projects, I&#39;ll a=
dd those.<br>
<br>
Here are my GHa builds:<br>
<br>
master: <a href=3D"https://github.com/lstipakov/openvpn/actions/runs/185758=
9993release/2.5" rel=3D"noreferrer" target=3D"_blank">https://github.com/ls=
tipakov/openvpn/actions/runs/1857589993<br>
release/2.5</a>: <a href=3D"https://github.com/lstipakov/openvpn/actions/ru=
ns/1857547158" rel=3D"noreferrer" target=3D"_blank">https://github.com/lsti=
pakov/openvpn/actions/runs/1857547158</a></blockquote><div><br></div><div>c=
an you please apply &quot;pdb&quot; patch to your branch ?</div><div><a hre=
f=3D"https://github.com/OpenVPN/openvpn/commit/9da733751ce80b2226ef19923365=
bd3102cfbd47">CI: github actions: keep &quot;pdb&quot; in artifacts =C2=B7 =
OpenVPN/openvpn@...2653...</a><br></div><div><br></div><div>BinSkim uses pd=
b for analysis.</div><div><br></div><div>probably, it makes sense to apply =
this patch to release/2.5 branch as well</div><div><br></div><div>=C2=A0</d=
iv><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
-- <br>
-Lev<br>
</blockquote></div></div></div>

--00000000000072136c05d8340091--

