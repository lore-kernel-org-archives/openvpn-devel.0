MIME-Version: 1.0
In-Reply-To: <50bec2e7-9f29-d36f-72fe-3b1d45fb0150@...2181...>
References: <20170713033848.11902-1-a@...2181...>
	<CAFHpkQG_gS9cZdfTDAJGHwApPzgpbCFS6923ysqjU6_AAaG7xQ@...278...>
	<a5f62ded-89be-7115-3f31-b4ee199bdad8@...2181...>
	<2de72e2e-5ccc-992f-505a-41cd00140844@...515...>
	<CAFHpkQHMUtx3ztQ5y6zAnPbPH4Gnf6kfwSJ6aatdOcxFdB219w@...278...>
	<17692092-d40d-72cb-381e-98177668250d@...2181...>
	<50bec2e7-9f29-d36f-72fe-3b1d45fb0150@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 13 Jul 2017 11:49:21 +0500
Message-ID: <CAFHpkQEQYw7MVasWjr24xn83MWuoiSL9=TOm-d7-9FGANq6s1Q@...278...>
Content-Type: multipart/alternative; boundary="94eb2c0d23321f6a7105542d5524"
Subject: Re: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, ValdikSS <valdikss@...277...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--94eb2c0d23321f6a7105542d5524
Content-Type: text/plain; charset="UTF-8"

2017-07-13 11:46 GMT+05:00 Antonio Quartulli <a@...2181...>:

>
>
> On 13/07/17 14:45, Antonio Quartulli wrote:
> > $ git tag --contains eed9b8eec911a26a952f07ad18d4397c334ac089
> > v2.3.10
> > v2.3.11
> > v2.3.12
> > v2.3.13
> > v2.3.14
> > v2.3.15
> > v2.3.16
> > v2.3.17
> > v2.3.2
> > v2.3.3
> > v2.3.4
> > v2.3.5
> > v2.3.6
> > v2.3.7
> > v2.3.8
> > v2.3.9
> >
> >
> > Hence, 2.3 is broken starting at v2.3.9. This is confirmed by the fact
> > that release/2.3 does not compile with --disable-multi.
> >
>
> typ0: I meant starting at 2.3.2.
>

so, if nobody care about something broken since 2.3.2, lets drop it



>
> Cheers,
>
> --
> Antonio Quartulli
>
>

--94eb2c0d23321f6a7105542d5524
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-07-13 11:46 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex"><span class=3D""><br>
<br>
On 13/07/17 14:45, Antonio Quartulli wrote:<br>
&gt; $ git tag --contains eed9b8eec911a26a952f07ad18d439<wbr>7c334ac089<br>
&gt; v2.3.10<br>
&gt; v2.3.11<br>
&gt; v2.3.12<br>
&gt; v2.3.13<br>
&gt; v2.3.14<br>
&gt; v2.3.15<br>
&gt; v2.3.16<br>
&gt; v2.3.17<br>
&gt; v2.3.2<br>
&gt; v2.3.3<br>
&gt; v2.3.4<br>
&gt; v2.3.5<br>
&gt; v2.3.6<br>
&gt; v2.3.7<br>
&gt; v2.3.8<br>
&gt; v2.3.9<br>
&gt;<br>
&gt;<br>
&gt; Hence, 2.3 is broken starting at v2.3.9. This is confirmed by the fact=
<br>
&gt; that release/2.3 does not compile with --disable-multi.<br>
&gt;<br>
<br>
</span>typ0: I meant starting at 2.3.2.<br></blockquote><div><br></div><div=
>so, if nobody care about something broken since 2.3.2, lets drop it<br></d=
iv><div><br>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Cheers,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Antonio Quartulli<br>
<br>
</font></span></blockquote></div><br></div></div>

--94eb2c0d23321f6a7105542d5524--

