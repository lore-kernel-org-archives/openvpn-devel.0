MIME-Version: 1.0
References: <20190623185408.GQ1097@...1296...>
 <CAFHpkQEi=Y0K3hXOqt2z_g+K8xD=Qu4iQ-fdo-zAc10C+0ZK3Q@...278...>
 <CAFHpkQFaOA9W9KBcU4iTFFvq88=OHnn9qpgx2cnVb20TWXPT_g@...278...>
 <20190630074624.GZ1097@...1296...>
In-Reply-To: <20190630074624.GZ1097@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 30 Jun 2019 13:15:14 +0500
Message-ID: <CAFHpkQGKmmmCFvXOxaXJX3ASRxXpnTB5JfWkQ-dDEKd0BfKJSA@...278...>
Content-Type: multipart/alternative; boundary="0000000000002d5cec058c861d09"
Subject: Re: [Openvpn-devel] [builds@...2512...: Still Failing:
 OpenVPN/openvpn#874 (master - 7473f32)]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000002d5cec058c861d09
Content-Type: text/plain; charset="UTF-8"

Documentation lacks. The reason of failure is caching homebrew. It is not
common practice, we should either drop cache or enforce update

On Sun, Jun 30, 2019, 12:46 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Sun, Jun 30, 2019 at 02:53:18AM +0500, ???????? ?????????????? wrote:
> > I submitted a fix
> >
> > https://patchwork.openvpn.net/project/openvpn2/list/?series=506
>
> I've seen the fix, thanks.
>
> Do you have documentation somewhere (which I did not find) how this
> stuff works?  That is, why is this the right fix?
>
> (I have no idea about travis-ci but would like to understand things
> better)
>
> gert
>
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

--0000000000002d5cec058c861d09
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Documentation lacks. The reason of failure is caching hom=
ebrew. It is not common practice, we should either drop cache or enforce up=
date</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_at=
tr">On Sun, Jun 30, 2019, 12:46 PM Gert Doering &lt;<a href=3D"mailto:gert@=
...1296...">gert@...1296...</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-le=
ft:1ex">Hi,<br>
<br>
On Sun, Jun 30, 2019 at 02:53:18AM +0500, ???????? ?????????????? wrote:<br>
&gt; I submitted a fix<br>
&gt; <br>
&gt; <a href=3D"https://patchwork.openvpn.net/project/openvpn2/list/?series=
=3D506" rel=3D"noreferrer noreferrer" target=3D"_blank">https://patchwork.o=
penvpn.net/project/openvpn2/list/?series=3D506</a><br>
<br>
I&#39;ve seen the fix, thanks.<br>
<br>
Do you have documentation somewhere (which I did not find) how this<br>
stuff works?=C2=A0 That is, why is this the right fix?<br>
<br>
(I have no idea about travis-ci but would like to understand things<br>
better)<br>
<br>
gert<br>
<br>
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
o:gert@...1296..." target=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>=
<br>
</blockquote></div>

--0000000000002d5cec058c861d09--

