MIME-Version: 1.0
References: <CAFHpkQE04DVnpbMmHxFPgcv93h1=2eyOJV0pA-dUBvC0OEV6zw@...278...>
 <4fd6e292-3e6a-b87c-191b-cd16ab2f7488@...277...>
 <20201223174115.GU976@...1296...>
 <CAFHpkQFkrGbLJCCD1aEObhCOMvR76FLgEZ2iTAamvAUSG4K3xA@...278...>
 <f1c200d9-d10b-ebf6-154a-38685c0c5dee@...277...>
In-Reply-To: <f1c200d9-d10b-ebf6-154a-38685c0c5dee@...277...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Thu, 24 Dec 2020 14:41:02 +0500
Message-ID: <CAFHpkQFhF-+5jH=jGj0PKtw8hwua5K6C_vhdb-Wjmnf9SXw7+Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000c9af6505b7329b98"
Subject: Re: [Openvpn-devel] Travis-ci is changing billing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: tincanteksup <tincanteksup@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--000000000000c9af6505b7329b98
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

we can move to Github Actions.
or to Azure Pipelines

both support amd64 linux / osx / windows, very versatile setup.

unfortunately, no support for s390, arm64, ppc64le (unless own build agents
attached)


=D1=87=D1=82, 24 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 06:42, tincanteksu=
p <tincanteksup@...277...>:

>
>
> On 23/12/2020 18:03, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > On Wed, Dec 23, 2020, 10:42 PM Gert Doering <gert@...1296...> wrote:
> >
> >> Hi,
> >>
> >> On Wed, Dec 23, 2020 at 04:06:26PM +0000, tincanteksup wrote:
> >>> This may help shed some light:
> >>>
> >>> https://blog.travis-ci.com/2020-11-02-travis-ci-new-billing
> >>
> >> I'm more confused than before.  So is what we do still free?  Do we
> >> need to apply somewhere?
> >>
> >
> > It is one time 1000 minutes free tier.
> > Once it is used the free game is over.
> >
> > In theory we can contact and ask for permanent OSS free limit, but Trav=
is
> > did not reply to anybody
> >
> >
>
> Travis did claim "abuse" as their reasoning, which sounds feasible.
>
> On the up-side, builds do seem to be faster :-)
>
>
>
>
>
> >
> >> Do we do MacOS builds?  If yes, we might consider removing them (we
> >> do have a MacOS buildslave)...
> >>
> >> gert
> >> --
> >> "If was one thing all people took for granted, was conviction that if
> you
> >>   feed honest figures into a computer, honest figures come out. Never
> >> doubted
> >>   it myself till I met a computer with a sense of humor."
> >>                               Robert A. Heinlein, The Moon is a Harsh
> >> Mistress
> >>
> >> Gert Doering - Munich, Germany
> >> gert@...1296...
> >> _______________________________________________
> >> Openvpn-devel mailing list
> >> Openvpn-devel@lists.sourceforge.net
> >> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
> >>
> >
>

--000000000000c9af6505b7329b98
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>we can move to Github Actions.</div><div>or to Azure =
Pipelines</div><div><br></div><div>both support amd64 linux / osx / windows=
, very versatile setup.</div><div><br></div><div>unfortunately, no support =
for s390, arm64, ppc64le (unless own build agents attached)<br></div><div><=
br></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_att=
r">=D1=87=D1=82, 24 =D0=B4=D0=B5=D0=BA. 2020 =D0=B3. =D0=B2 06:42, tincante=
ksup &lt;<a href=3D"mailto:tincanteksup@...277...">tincanteksup@...277...</=
a>&gt;:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px =
0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex"><br>
<br>
On 23/12/2020 18:03, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:<br>
&gt; On Wed, Dec 23, 2020, 10:42 PM Gert Doering &lt;<a href=3D"mailto:gert=
@...1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br>
&gt; <br>
&gt;&gt; Hi,<br>
&gt;&gt;<br>
&gt;&gt; On Wed, Dec 23, 2020 at 04:06:26PM +0000, tincanteksup wrote:<br>
&gt;&gt;&gt; This may help shed some light:<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; <a href=3D"https://blog.travis-ci.com/2020-11-02-travis-ci-new=
-billing" rel=3D"noreferrer" target=3D"_blank">https://blog.travis-ci.com/2=
020-11-02-travis-ci-new-billing</a><br>
&gt;&gt;<br>
&gt;&gt; I&#39;m more confused than before.=C2=A0 So is what we do still fr=
ee?=C2=A0 Do we<br>
&gt;&gt; need to apply somewhere?<br>
&gt;&gt;<br>
&gt; <br>
&gt; It is one time 1000 minutes free tier.<br>
&gt; Once it is used the free game is over.<br>
&gt; <br>
&gt; In theory we can contact and ask for permanent OSS free limit, but Tra=
vis<br>
&gt; did not reply to anybody<br>
&gt; <br>
&gt; <br>
<br>
Travis did claim &quot;abuse&quot; as their reasoning, which sounds feasibl=
e.<br>
<br>
On the up-side, builds do seem to be faster :-)<br>
<br>
<br>
<br>
<br>
<br>
&gt; <br>
&gt;&gt; Do we do MacOS builds?=C2=A0 If yes, we might consider removing th=
em (we<br>
&gt;&gt; do have a MacOS buildslave)...<br>
&gt;&gt;<br>
&gt;&gt; gert<br>
&gt;&gt; --<br>
&gt;&gt; &quot;If was one thing all people took for granted, was conviction=
 that if you<br>
&gt;&gt;=C2=A0 =C2=A0feed honest figures into a computer, honest figures co=
me out. Never<br>
&gt;&gt; doubted<br>
&gt;&gt;=C2=A0 =C2=A0it myself till I met a computer with a sense of humor.=
&quot;<br>
&gt;&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0Robert A. Heinlein, The Moon i=
s a Harsh<br>
&gt;&gt; Mistress<br>
&gt;&gt;<br>
&gt;&gt; Gert Doering - Munich, Germany<br>
&gt;&gt; <a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1725...=
..</a><br>
&gt;&gt; _______________________________________________<br>
&gt;&gt; Openvpn-devel mailing list<br>
&gt;&gt; <a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_=
blank">Openvpn-devel@lists.sourceforge.net</a><br>
&gt;&gt; <a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-de=
vel" rel=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lis=
ts/listinfo/openvpn-devel</a><br>
&gt;&gt;<br>
&gt; <br>
</blockquote></div></div>

--000000000000c9af6505b7329b98--

