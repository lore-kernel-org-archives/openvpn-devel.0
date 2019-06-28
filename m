MIME-Version: 1.0
References: <CAFHpkQFOUB6hq4rQjCGLvbXprjvUL0aD3y107oYj15t6CSMxTg@...278...>
 <20190626063502.GS1097@...1296...>
 <9f92ae0a-cae6-39bd-932b-fa977686f27a@...1227...>
 <CAFHpkQFn0Yn8dWya9H=EgC4MLugvrpHLkA=-eqyscQWZy_eDCw@...278...>
 <2d1c2e8a-7f60-6a40-164e-f8657d6f2103@...1227...>
 <20190627073924.GB1097@...1296...>
In-Reply-To: <20190627073924.GB1097@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 28 Jun 2019 12:14:40 +0500
Message-ID: <CAFHpkQEuGSh+7Mn1F17Ri7sqnhprnygAMpK3sXL19M-fHMHBbA@...278...>
Content-Type: multipart/alternative; boundary="000000000000daca62058c5d08a9"
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

--000000000000daca62058c5d08a9
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

by "high level" compression doc I mean something like that

a) road warrior scenario (remote access for enterprise users) - should we
enable compression ? or traffic usually is compressed ? RDP is compressed ?
any way to estimate compression (like $gzip_ratio in nginx)
b) lz4, lzo, ... which one to choose ?
c) how to push compression settings, best practices on that

@mattock, what do you think, should some such documentation present on
https://openvpn.net ?



=D1=87=D1=82, 27 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 12:39, Gert Doerin=
g <gert@...1296...>:

> Hi,
>
> On Wed, Jun 26, 2019 at 11:14:34PM +0200, Arne Schwabe wrote:
> > My patch that enables asymmetrical compression by default adds a bit of
> > documentation in that regard iirc.
>
> Where did that get stuck?  Still in limbo between David and you?
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

--000000000000daca62058c5d08a9
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>by &quot;high level&quot; compression doc I mean some=
thing like that</div><div><br></div><div>a) road warrior scenario (remote a=
ccess for enterprise users) - should we enable compression ? or traffic usu=
ally is compressed ? RDP is compressed ? any way to estimate compression (l=
ike <code>$gzip_ratio in nginx)</code></div><div><code>b) lz4, lzo, ... whi=
ch one to choose ?</code></div><div><code>c) how to push compression settin=
gs, best practices on that</code></div><div><code><br></code></div><div><co=
de>@mattock, what do you think, should some such documentation present on <=
a href=3D"https://openvpn.net">https://openvpn.net</a> ?</code></div><div><=
code><br></code></div><div><code><br></code></div></div><br><div class=3D"g=
mail_quote"><div dir=3D"ltr" class=3D"gmail_attr">=D1=87=D1=82, 27 =D0=B8=
=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 12:39, Gert Doering &lt;<a href=3D"mailto=
:gert@...1296...">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">Hi,<br>
<br>
On Wed, Jun 26, 2019 at 11:14:34PM +0200, Arne Schwabe wrote:<br>
&gt; My patch that enables asymmetrical compression by default adds a bit o=
f<br>
&gt; documentation in that regard iirc.<br>
<br>
Where did that get stuck?=C2=A0 Still in limbo between David and you?<br>
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
</blockquote></div>

--000000000000daca62058c5d08a9--

