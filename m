MIME-Version: 1.0
References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
 <20190626063502.GS1097@...1296...>
 <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
 <CAFHpkQFn0Yn8dWya9H=EgC4MLugvrpHLkA=-eqyscQWZy_eDCw@...278...>
 <2d1c2e8a-7f60-6a40-164e-f8657d6f2103@...1227...>
 <20190627073924.GB1097@...1296...>
 <CAFHpkQEuGSh+7Mn1F17Ri7sqnhprnygAMpK3sXL19M-fHMHBbA@...278...>
 <20190628074952.GS1097@...1296...>
In-Reply-To: <20190628074952.GS1097@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 28 Jun 2019 13:26:23 +0500
Message-ID: <CAFHpkQGK6Z1FxPiL_V-=FNddREm4MTuRR5LOnDwkcC6+vxFs_w@...278...>
Content-Type: multipart/alternative; boundary="00000000000053f051058c5e0914"
Subject: Re: [Openvpn-devel] how to migrate users to "no compression" config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--00000000000053f051058c5e0914
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D1=82, 28 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 12:49, Gert Doerin=
g <gert@...1296...>:

> Hi,
>
> On Fri, Jun 28, 2019 at 12:14:40PM +0500, ???????? ?????????????? wrote:
> > by "high level" compression doc I mean something like that
> >
> > a) road warrior scenario (remote access for enterprise users) - should =
we
> > enable compression ? or traffic usually is compressed ? RDP is
> compressed ?
> > any way to estimate compression (like $gzip_ratio in nginx)
> > b) lz4, lzo, ... which one to choose ?
> > c) how to push compression settings, best practices on that
> >
> > @mattock, what do you think, should some such documentation present on
> > https://openvpn.net ?
>
> The high level document should propably specify "do not use compression
> at all, unless you have a specific need".
>

I agree with that. It might not be very obvious.


>
> I'm fairly sure we did publish something along that lines already, but
> have no idea where to look for it.
>
> gert
> --
> "If was one thing all people took for granted, was conviction that if you
>  feed honest figures into a computer, honest figures come out. Never
> doubted
>  it myself till I met a computer with a sense of humor."
>                              Robert A. Heinlein, The Moon is a Harsh
> Mistress
>
> Gert Doering - Munich, Germany
> gert@...1296...
>

--00000000000053f051058c5e0914
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D1=82, 28 =D0=B8=D1=8E=D0=BD. =
2019 =D0=B3. =D0=B2 12:49, Gert Doering &lt;<a href=3D"mailto:gert@...1725...=
..">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi,<br>
<br>
On Fri, Jun 28, 2019 at 12:14:40PM +0500, ???????? ?????????????? wrote:<br>
&gt; by &quot;high level&quot; compression doc I mean something like that<b=
r>
&gt; <br>
&gt; a) road warrior scenario (remote access for enterprise users) - should=
 we<br>
&gt; enable compression ? or traffic usually is compressed ? RDP is compres=
sed ?<br>
&gt; any way to estimate compression (like $gzip_ratio in nginx)<br>
&gt; b) lz4, lzo, ... which one to choose ?<br>
&gt; c) how to push compression settings, best practices on that<br>
&gt; <br>
&gt; @mattock, what do you think, should some such documentation present on=
<br>
&gt; <a href=3D"https://openvpn.net" rel=3D"noreferrer" target=3D"_blank">h=
ttps://openvpn.net</a> ?<br>
<br>
The high level document should propably specify &quot;do not use compressio=
n<br>
at all, unless you have a specific need&quot;.<br></blockquote><div><br></d=
iv><div>I agree with that. It might not be very obvious.<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8e=
x;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
I&#39;m fairly sure we did publish something along that lines already, but<=
br>
have no idea where to look for it.<br>
<br>
gert<br>
-- <br>
&quot;If was one thing all people took for granted, was conviction that if =
you <br>
=C2=A0feed honest figures into a computer, honest figures come out. Never d=
oubted <br>
=C2=A0it myself till I met a computer with a sense of humor.&quot;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon is a Harsh Mist=
ress<br>
<br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>

--00000000000053f051058c5e0914--

