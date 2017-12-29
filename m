MIME-Version: 1.0
In-Reply-To: <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
References: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
 <CAFHpkQG56wpZzN2KD3BYmcSDFFLi8Jpq0e-ZN-=9yJH4VWybiQ@...278...>
 <f6271a6e-0a17-a678-05c8-9b3b7912766d@...1435...>
 <5d048ecc-a9db-b448-71e7-ec874b5fb15f@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Fri, 29 Dec 2017 16:16:11 +0500
Message-ID: <CAFHpkQE+d1Nj-DM_YhTk9r0BZdXdh=WUhhvPdv4Qqku73X96TQ@...278...>
Content-Type: multipart/alternative; boundary="001a113ecd9e969d9a056178c2a0"
Subject: Re: [Openvpn-devel] --with-mem-check, what to do with it?
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Steffan Karger <steffan.karger@...1435...>, openvpn-devel@lists.sourceforge.net

--001a113ecd9e969d9a056178c2a0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-12-29 16:02 GMT+05:00 Antonio Quartulli <a@...2181...>:

> Hi,
>
> On 29/12/17 18:23, Steffan Karger wrote:
> > Hi,
> >
> > On 29-12-17 11:11, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> >> thank for the patch.
> >>
> >> not directly related to the patch itself, but openvpn is shipped with
> >> several memory debugging options
> >>
> >> --with-mem-check=3DTYPE   build with debug memory checking
> >>
> >>
> >> should we get rid of them (in favour of sanitizers) ? or, maybe add to
> >> tests instead ?
> >
> > I've tried to use those in the past, but found them hard to use.  I
> > think they're a remnant of the past.  I would personally prefer to get
> > rid of them and use the (nowadays much better) fully external memory
> > checking tools instead (sanitizers, valgrind, etc).
>
> As Selva pointed out, we don't use --with-mem-check in any test,
> therefore I am not even sure it still works as expected.
>
> I am also in favour in of getting rid of our custom made check and use
> compilers provided sanitizers instead (also gcc provides interesting
> sanitizers, thus everybody should be bale to enable them).
>

I played with those sanitizers, they are nice. But memory sanitizers are
noisy on openssl.
seem to need some work (either resolving issues on openssl side or muting
them)


>
> Cheers,
>
> --
> Antonio Quartulli
>
>

--001a113ecd9e969d9a056178c2a0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-12-29 16:02 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left=
:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On 29/12/17 18:23, Steffan Karger wrote:<br>
&gt; Hi,<br>
&gt;<br>
&gt; On 29-12-17 11:11, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=
=D1=86=D0=B8=D0=BD wrote:<br>
&gt;&gt; thank for the patch.<br>
&gt;&gt;<br>
&gt;&gt; not directly related to the patch itself, but openvpn is shipped w=
ith<br>
&gt;&gt; several memory debugging options<br>
&gt;&gt;<br>
&gt;&gt; --with-mem-check=3DTYPE=C2=A0=C2=A0 build with debug memory checki=
ng<br>
&gt;&gt;<br>
&gt;&gt;<br>
&gt;&gt; should we get rid of them (in favour of sanitizers) ? or, maybe ad=
d to<br>
&gt;&gt; tests instead ?<br>
&gt;<br>
&gt; I&#39;ve tried to use those in the past, but found them hard to use.=
=C2=A0 I<br>
&gt; think they&#39;re a remnant of the past.=C2=A0 I would personally pref=
er to get<br>
&gt; rid of them and use the (nowadays much better) fully external memory<b=
r>
&gt; checking tools instead (sanitizers, valgrind, etc).<br>
<br>
</span>As Selva pointed out, we don&#39;t use --with-mem-check in any test,=
<br>
therefore I am not even sure it still works as expected.<br>
<br>
I am also in favour in of getting rid of our custom made check and use<br>
compilers provided sanitizers instead (also gcc provides interesting<br>
sanitizers, thus everybody should be bale to enable them).<br></blockquote>=
<div><br></div><div>I played with those sanitizers, they are nice. But memo=
ry sanitizers are noisy on openssl.</div><div>seem to need some work (eithe=
r resolving issues on openssl side or muting them)<br></div><div>=C2=A0</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br>
Cheers,<br>
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
--<br>
Antonio Quartulli<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a113ecd9e969d9a056178c2a0--

