MIME-Version: 1.0
References: <20220107145359.311-1-lstipakov@...277...>
 <CAGyAFMXNQnQ_jeoQXJSkW8xXn8QM0nqeJHYB5xL288U6t+TcJw@...278...>
 <CAFHpkQFwO0qMqWhtUidv0TNWyGrsnMHqYVib12yCzowBgL1KtQ@...278...>
 <CAFHpkQE-LBkt-Lyz97vLdgQFt7VPLmedw8ogNojVy2p3GsdaiQ@...278...>
 <CAGyAFMWQLs2=BoF6fhUcG6gLN5LvPA9xHZ8JRocdH5-DL5LW_w@...278...>
 <CAFHpkQHURwN2x=AC_RK38tjwD8kGgHhSbq==espXJHSM33L6ZA@...278...>
 <CAGyAFMWN-4rLAjPEwUbDqE79gs3bUWWSFLSnzz9QaTgiQSKQHA@...278...>
 <YhJKbnyZYeuTk0Fd@...1296...>
In-Reply-To: <YhJKbnyZYeuTk0Fd@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 20 Feb 2022 19:07:15 +0500
Message-ID: <CAFHpkQFBr0-0j89q77pHFkc26LrcBGfA+T1qvHsW24hCK6vKtg@...278...>
Content-Type: multipart/alternative; boundary="000000000000d2bdbc05d873a2c6"
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
To: Gert Doering <gert@...1296...>
Cc: Lev Stipakov <lstipakov@...277...>, Lev Stipakov <lev@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000d2bdbc05d873a2c6
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

pdb patch

On Sun, Feb 20, 2022, 7:04 PM Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Thu, Feb 17, 2022 at 01:55:35PM +0200, Lev Stipakov wrote:
> > > can you please apply "pdb" patch to your branch ?
> > > CI: github actions: keep "pdb" in artifacts =C2=B7 OpenVPN/openvpn@...1186...=
.2653...
> >
> > Done! https://github.com/lstipakov/openvpn/actions/runs/1858390624
> >
> > > BinSkim uses pdb for analysis.
> > >
> > > probably, it makes sense to apply this patch to release/2.5 branch as
> well
> >
> > I agree. /me looks at Gert.
>
> I'm a bit confused on what exactly you want applied where now.
>
> What is "this patch"?  This one, or "the pdb patch", or yet something
> else mentioned in this thread?
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

--000000000000d2bdbc05d873a2c6
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">pdb patch</div><br><div class=3D"gmail_quote"><div dir=3D=
"ltr" class=3D"gmail_attr">On Sun, Feb 20, 2022, 7:04 PM Gert Doering &lt;<=
a href=3D"mailto:gert@...1296...">gert@...1296...</a>&gt; wrote:<br></div><=
blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px=
 #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Thu, Feb 17, 2022 at 01:55:35PM +0200, Lev Stipakov wrote:<br>
&gt; &gt; can you please apply &quot;pdb&quot; patch to your branch ?<br>
&gt; &gt; CI: github actions: keep &quot;pdb&quot; in artifacts =C2=B7 Open=
VPN/openvpn@...2653...<br>
&gt; <br>
&gt; Done! <a href=3D"https://github.com/lstipakov/openvpn/actions/runs/185=
8390624" rel=3D"noreferrer noreferrer" target=3D"_blank">https://github.com=
/lstipakov/openvpn/actions/runs/1858390624</a><br>
&gt; <br>
&gt; &gt; BinSkim uses pdb for analysis.<br>
&gt; &gt;<br>
&gt; &gt; probably, it makes sense to apply this patch to release/2.5 branc=
h as well<br>
&gt; <br>
&gt; I agree. /me looks at Gert.<br>
<br>
I&#39;m a bit confused on what exactly you want applied where now.<br>
<br>
What is &quot;this patch&quot;?=C2=A0 This one, or &quot;the pdb patch&quot=
;, or yet something<br>
else mentioned in this thread?<br>
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
o:gert@...1296..." target=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>=
<br>
</blockquote></div>

--000000000000d2bdbc05d873a2c6--

