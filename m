MIME-Version: 1.0
In-Reply-To: <2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
	<2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 13 Jul 2017 11:34:57 +0500
Message-ID: <CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
Content-Type: multipart/alternative; boundary="001a11468752aa9c4205542d2155"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>
Cc: Antonio Quartulli <a@...2181...>, ValdikSS <valdikss@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11468752aa9c4205542d2155
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-07-13 11:16 GMT+05:00 Samuli Sepp=C3=A4nen <samuli@...515...>:

> On 13/07/2017 09:05, Antonio Quartulli wrote:
> > On 13/07/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >> Should we add --disable-multi to some travis-ci build ?
> >
> > Might be a good idea. It was actually broken since 2013, therefore it
> > seems like not many people are using it....either we drop it or yes, we
> > should have some automated test.
>
> There were no bugs reports about --disable-multi in Trac. I say scrap
> that option altogether and make the code slightly cleaner and less
> entangled.
>


was it broken in 2.3 as well ?
I'm afraid, not many people are using 2.4 since 2013


>
> --
> Samuli Sepp=C3=A4nen
> Community Manager
> OpenVPN Technologies, Inc
>
> irc freenode net: mattock
>

--001a11468752aa9c4205542d2155
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-13 11:16 GMT+05:00 Samuli Sepp=C3=A4nen <span dir=3D"ltr">&lt;<=
a href=3D"mailto:samuli@...515..." target=3D"_blank">samuli@...515...</a>&g=
t;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;=
border-left:1px #ccc solid;padding-left:1ex"><span class=3D"">On 13/07/2017=
 09:05, Antonio Quartulli wrote:<br>
&gt; On 13/07/17 14:02, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:<br>
&gt;&gt; Should we add --disable-multi to some travis-ci build ?<br>
&gt;<br>
&gt; Might be a good idea. It was actually broken since 2013, therefore it<=
br>
&gt; seems like not many people are using it....either we drop it or yes, w=
e<br>
&gt; should have some automated test.<br>
<br>
</span>There were no bugs reports about --disable-multi in Trac. I say scra=
p<br>
that option altogether and make the code slightly cleaner and less<br>
entangled.<br></blockquote><div><br><br></div><div>was it broken in 2.3 as =
well ?<br></div><div>I&#39;m afraid, not many people are using 2.4 since 20=
13<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"mar=
gin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Samuli Sepp=C3=A4nen<br>
Community Manager<br>
OpenVPN Technologies, Inc<br>
<br>
irc freenode net: mattock<br>
</font></span></blockquote></div><br></div></div>

--001a11468752aa9c4205542d2155--

