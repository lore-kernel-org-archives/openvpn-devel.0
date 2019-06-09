MIME-Version: 1.0
References: <CAFHpkQG=oJzBFcipDjTtJJs1Bvz=0jP2kV2M+zRwVZxnMxaiOA@...278...>
 <20190609203731.GC1097@...1296...>
 <CAFHpkQGUW8=vpSyX0YP=7AdRCayjx2BmwzjsJKCGOYG3DTrGBQ@...278...>
 <20190609211125.GD1097@...1296...>
In-Reply-To: <20190609211125.GD1097@...1296...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Mon, 10 Jun 2019 02:16:36 +0500
Message-ID: <CAFHpkQEHgD9G06EbOEoNYkXKCs-sARG39EwPv-4JbxHyedEYWg@...278...>
Content-Type: multipart/alternative; boundary="000000000000db16d9058aea9418"
Subject: Re: [Openvpn-devel] state of sitnl patchset ?
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

--000000000000db16d9058aea9418
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 10 =D0=B8=D1=8E=D0=BD. 2019 =D0=B3. =D0=B2 02:11, Gert Doerin=
g <gert@...1296...>:

> Hi,
>
> On Mon, Jun 10, 2019 at 02:06:47AM +0500, ???????? ?????????????? wrote:
> > > On Mon, Jun 10, 2019 at 12:05:52AM +0500, ???????? ??????????????
> wrote:
> > > > https://patchwork.openvpn.net/project/openvpn2/list/?series=3D428 s=
ays
> > > "new"
> > > > however, I see patchset is applied (and travis-ci is somewhat broke=
n)
> > > >
> > > > are all paches applied already ?
> > >
> > > Patch status is communicated via the list - and my comments can be
> > > nicely seen when clicking on each individual patch.
> >
> > it is complicated to view every patch and it's comments.
> > is there a way to change status to "applied" on patchwork ?
>
> I'm leaving them in their current state as a reminder that there is
> more work to do - clean up the code where needed, fix the regression
> in 5/7, fix the buildslave blowup in 7/7.
>


thank you, that's I wanted to hear.
"patches are still New, because it is not finished yet"



>
> (5/7 is actually fine in itself, the problem is an earlier patch which
> already got applied, but where the code was never activated - so when
> that code is fixed, 5/7 could be applied "as is".  OTOH there are code
> warts in 5/7, so maybe a v4 will come)
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

--000000000000db16d9058aea9418
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">=D0=BF=D0=BD, 10 =D0=B8=D1=8E=D0=BD. =
2019 =D0=B3. =D0=B2 02:11, Gert Doering &lt;<a href=3D"mailto:gert@...1725...=
..">gert@...1296...</a>&gt;:<br></div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);paddi=
ng-left:1ex">Hi,<br>
<br>
On Mon, Jun 10, 2019 at 02:06:47AM +0500, ???????? ?????????????? wrote:<br>
&gt; &gt; On Mon, Jun 10, 2019 at 12:05:52AM +0500, ???????? ??????????????=
 wrote:<br>
&gt; &gt; &gt; <a href=3D"https://patchwork.openvpn.net/project/openvpn2/li=
st/?series=3D428" rel=3D"noreferrer" target=3D"_blank">https://patchwork.op=
envpn.net/project/openvpn2/list/?series=3D428</a> says<br>
&gt; &gt; &quot;new&quot;<br>
&gt; &gt; &gt; however, I see patchset is applied (and travis-ci is somewha=
t broken)<br>
&gt; &gt; &gt;<br>
&gt; &gt; &gt; are all paches applied already ?<br>
&gt; &gt;<br>
&gt; &gt; Patch status is communicated via the list - and my comments can b=
e<br>
&gt; &gt; nicely seen when clicking on each individual patch.<br>
&gt; <br>
&gt; it is complicated to view every patch and it&#39;s comments.<br>
&gt; is there a way to change status to &quot;applied&quot; on patchwork ?<=
br>
<br>
I&#39;m leaving them in their current state as a reminder that there is<br>
more work to do - clean up the code where needed, fix the regression<br>
in 5/7, fix the buildslave blowup in 7/7.<br></blockquote><div><br></div><d=
iv><br></div><div>thank you, that&#39;s I wanted to hear.</div><div>&quot;p=
atches are still New, because it is not finished yet&quot;</div><div><br></=
div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px =
0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
(5/7 is actually fine in itself, the problem is an earlier patch which <br>
already got applied, but where the code was never activated - so when<br>
that code is fixed, 5/7 could be applied &quot;as is&quot;.=C2=A0 OTOH ther=
e are code<br>
warts in 5/7, so maybe a v4 will come)<br>
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
o:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
</blockquote></div></div>

--000000000000db16d9058aea9418--

