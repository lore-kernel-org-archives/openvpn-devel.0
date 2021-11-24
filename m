MIME-Version: 1.0
References: <20210922095756.1929-1-chipitsine@...277...>
 <4654662a-587a-ca90-6678-5c5ff71e9c66@...1227...>
 <CAGyAFMWXBpvo-mxOkNsFrYR9oB9MVRcFEQ6SBs7rP0A6LeNu6Q@...278...>
 <CAFHpkQECg=UVywGzXXBeA1V5R7M5zSr8QkCT=Mj7ThBFB5c+yg@...278...>
 <CAGyAFMVXK16xNkBDbsb_VTC9qrYSAWTxnc=iOXOzUBGH_LqPhw@...278...>
In-Reply-To: <CAGyAFMVXK16xNkBDbsb_VTC9qrYSAWTxnc=iOXOzUBGH_LqPhw@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 24 Nov 2021 19:31:07 +0500
Message-ID: <CAFHpkQFhkNQ5E=ZKqQh_hkRQR_ssUDrjfGWA=jFQa9fNtywHhA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002bb16205d189b6f2"
Subject: Re: [Openvpn-devel] [PATCH v2] BUILD: enable CFG and Spectre
 mitigation for MSVC
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Lev Stipakov <lstipakov@...277...>
Cc: Gert Doering <gert@...1296...>, Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002bb16205d189b6f2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Performance report was delayed due to oversize. It was only delivered to
Lev and Gert.

Thank you Lev for bringing this up:)


Performance was captured by WPT. I'd like to make some similar
investigation if needed (to compare other perf impact)

On Wed, Nov 24, 2021, 7:21 PM Lev Stipakov <lstipakov@...277...> wrote:

> Since we're preparing the next 2.5 release, let's take this in. The
> performance numbers, reported in different thread, look good.
>
> ma 27. syysk. 2021 klo 13.06 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=
=D0=B8=D1=86=D0=B8=D0=BD (chipitsine@...277...)
> kirjoitti:
> >
> > I'll setup test stand similar to this one
> https://community.openvpn.net/openvpn/wiki/PerformanceTestingOpenVPN
> > hopefully in next 1-2 weeks
> >
> > I also believe that spectre mitigation is neglectable, but it is good to
> have numbers
> >
> > =D0=BF=D0=BD, 27 =D1=81=D0=B5=D0=BD=D1=82. 2021 =D0=B3. =D0=B2 12:58, L=
ev Stipakov <lstipakov@...277...>:
> >>
> >> I didn't, but here
> >>
> >> https://devblogs.microsoft.com/cppblog/spectre-mitigations-in-msvc/
> >>
> >> it says that
> >>
> >> "On the MSVC team, we=E2=80=99ve reviewed information in detail and co=
nducted
> >> extensive tests, which showed the performance impact of the new
> >> /Qspectre switch to be negligible."
> >> --
> >> -Lev
>
>
>
> --
> -Lev
>

--0000000000002bb16205d189b6f2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Performance report was delayed due to oversize. It was on=
ly delivered to Lev and Gert.<div dir=3D"auto"><br></div><div dir=3D"auto">=
Thank you Lev for bringing this up:)</div><div dir=3D"auto"><br></div><div =
dir=3D"auto"><br></div><div dir=3D"auto">Performance was captured by WPT. I=
&#39;d like to make some similar investigation if needed (to compare other =
perf impact)</div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" cla=
ss=3D"gmail_attr">On Wed, Nov 24, 2021, 7:21 PM Lev Stipakov &lt;<a href=3D=
"mailto:lstipakov@...277...">lstipakov@...277...</a>&gt; wrote:<br></div><b=
lockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px =
#ccc solid;padding-left:1ex">Since we&#39;re preparing the next 2.5 release=
, let&#39;s take this in. The<br>
performance numbers, reported in different thread, look good.<br>
<br>
ma 27. syysk. 2021 klo 13.06 =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=
=B8=D1=86=D0=B8=D0=BD (<a href=3D"mailto:chipitsine@...277..." target=3D"_b=
lank" rel=3D"noreferrer">chipitsine@...277...</a>) kirjoitti:<br>
&gt;<br>
&gt; I&#39;ll setup test stand similar to this one <a href=3D"https://commu=
nity.openvpn.net/openvpn/wiki/PerformanceTestingOpenVPN" rel=3D"noreferrer =
noreferrer" target=3D"_blank">https://community.openvpn.net/openvpn/wiki/Pe=
rformanceTestingOpenVPN</a><br>
&gt; hopefully in next 1-2 weeks<br>
&gt;<br>
&gt; I also believe that spectre mitigation is neglectable, but it is good =
to have numbers<br>
&gt;<br>
&gt; =D0=BF=D0=BD, 27 =D1=81=D0=B5=D0=BD=D1=82. 2021 =D0=B3. =D0=B2 12:58, =
Lev Stipakov &lt;<a href=3D"mailto:lstipakov@...277..." target=3D"_blank" r=
el=3D"noreferrer">lstipakov@...277...</a>&gt;:<br>
&gt;&gt;<br>
&gt;&gt; I didn&#39;t, but here<br>
&gt;&gt;<br>
&gt;&gt; <a href=3D"https://devblogs.microsoft.com/cppblog/spectre-mitigati=
ons-in-msvc/" rel=3D"noreferrer noreferrer" target=3D"_blank">https://devbl=
ogs.microsoft.com/cppblog/spectre-mitigations-in-msvc/</a><br>
&gt;&gt;<br>
&gt;&gt; it says that<br>
&gt;&gt;<br>
&gt;&gt; &quot;On the MSVC team, we=E2=80=99ve reviewed information in deta=
il and conducted<br>
&gt;&gt; extensive tests, which showed the performance impact of the new<br>
&gt;&gt; /Qspectre switch to be negligible.&quot;<br>
&gt;&gt; --<br>
&gt;&gt; -Lev<br>
<br>
<br>
<br>
-- <br>
-Lev<br>
</blockquote></div>

--0000000000002bb16205d189b6f2--

