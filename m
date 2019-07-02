MIME-Version: 1.0
References: <20190628194637.5038-2-chipitsine@...277...>
 <201907020707.x6277i05056035@...2054...>
 <CAFHpkQHCEYqig-dWvHQbrhdUndndHVdG7sA7KsvWVmU7XfsOFw@...278...>
 <20190702071122.GQ1097@...1296...>
In-Reply-To: <20190702071122.GQ1097@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 2 Jul 2019 12:12:40 +0500
Message-ID: <CAFHpkQGJbX5C0yfiju9pcVaos_LK9ngz5o59vHrQA7NKvZOdLg@...278...>
Content-Type: multipart/alternative; boundary="0000000000000950c2058cad7986"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: travis-ci: fix osx builds
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

--0000000000000950c2058cad7986
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 12:11, Gert Doering=
 <gert@...1296...>:

> Hi,
>
> On Tue, Jul 02, 2019 at 12:09:48PM +0500, ???????? ?????????????? wrote:
> > ????, 2 ??????. 2019 ??. ?? 12:07, Gert Doering <gert@...1296...>:
> >
> > > Acked-by: Gert Doering <gert@...1296...>
> > >
> > > (I have no idea what this does, specifically, but it is not a code
> > > change and if it fixes our Travis builds, I'm happy - and the
> explanation
> > > given says "it will fix things")
> > >
> > > Your patch has been applied to the master branch.
> >
> > should we apply to 2.4 as well ?
>
> Good point.  Should have the same brokenness & needs the same fix - so
> here we go
>
>
thank you!



> commit 5e695c7786259049ea2eb4ac78101e3d7edd8280 (HEAD -> release/2.4)
> Author: Ilya Shipitsin <chipitsine@...277...>
> Date:   Sat Jun 29 00:46:36 2019 +0500
>
>     travis-ci: fix osx builds
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

--0000000000000950c2058cad7986
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=B2=D1=82, 2 =D0=B8=D1=8E=D0=BB. 2=
019 =D0=B3. =D0=B2 12:11, Gert Doering &lt;<a href=3D"mailto:gert@...2132...=
.">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" styl=
e=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddin=
g-left:1ex">Hi,<br>
<br>
On Tue, Jul 02, 2019 at 12:09:48PM +0500, ???????? ?????????????? wrote:<br>
&gt; ????, 2 ??????. 2019 ??. ?? 12:07, Gert Doering &lt;<a href=3D"mailto:=
gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;:<br>
&gt; <br>
&gt; &gt; Acked-by: Gert Doering &lt;<a href=3D"mailto:gert@...1296..." tar=
get=3D"_blank">gert@...1296...</a>&gt;<br>
&gt; &gt;<br>
&gt; &gt; (I have no idea what this does, specifically, but it is not a cod=
e<br>
&gt; &gt; change and if it fixes our Travis builds, I&#39;m happy - and the=
 explanation<br>
&gt; &gt; given says &quot;it will fix things&quot;)<br>
&gt; &gt;<br>
&gt; &gt; Your patch has been applied to the master branch.<br>
&gt; <br>
&gt; should we apply to 2.4 as well ?<br>
<br>
Good point.=C2=A0 Should have the same brokenness &amp; needs the same fix =
- so<br>
here we go<br>
<br></blockquote><div><br></div><div>thank you!<br></div><div><br></div><di=
v>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
commit 5e695c7786259049ea2eb4ac78101e3d7edd8280 (HEAD -&gt; release/2.4)<br>
Author: Ilya Shipitsin &lt;<a href=3D"mailto:chipitsine@...277..." target=
=3D"_blank">chipitsine@...277...</a>&gt;<br>
Date:=C2=A0 =C2=A0Sat Jun 29 00:46:36 2019 +0500<br>
<br>
=C2=A0 =C2=A0 travis-ci: fix osx builds<br>
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

--0000000000000950c2058cad7986--

