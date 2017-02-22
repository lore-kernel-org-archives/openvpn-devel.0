MIME-Version: 1.0
In-Reply-To: <dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
References: <345db0ac-f6e8-8490-a80a-ffbd81972c07@...1856...>
	<20170221211205.GF93896@...1296...>
	<250998c4-9b20-dcc0-90eb-d432a911e7ba@...2080...>
	<20170222073910.GG93896@...1296...>
	<dc42f147-496f-1ea7-0fb3-a14197a697dd@...1435...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Wed, 22 Feb 2017 14:07:06 +0500
Message-ID: <CAFHpkQG4XgaBSq=N9OwO5Qiv2MZMERGcBDzWObX8TT28CUvKtA@...278...>
Content-Type: multipart/alternative; boundary=001a11469c542497b805491ad204
Subject: Re: [Openvpn-devel] [PATCH] Fix segfault when using crypto lib
 without AES-256-CTR or SHA256
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Steffan Karger <steffan.karger@...1435...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11469c542497b805491ad204
Content-Type: text/plain; charset=UTF-8

2017-02-22 13:30 GMT+05:00 Steffan Karger <steffan.karger@...1435...>:

> On 22-02-17 08:39, Gert Doering wrote:
> > On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:
> >>>> >From d97f526a2ddbf2abe60a64260601ebd742fc00cc Mon Sep 17 00:00:00
> 2001
> >>>> From: "Simon (simix)" <via-trac>
> >>>
> >>> Do we have a policy how to handle patches with missing author info?
> >>
> >> I see no reason at all why we should not give proper credit with full
> >> name.
> >
> > That was only half the question - of course I *want* to give full
> credits,
> > but is "not having this information available & no SoB line" a reason
> > for rejecting a patch?
> >
> > The patch in question is quite obvious, so this is not something to bring
> > in the lawyers - more a matter of general policy.
>
> Same here.
>
> For this specific patch:  I asked the reporter on trac for full name and
> email last night.  We can wait for a bit to see if he replies.
>
> In general: what do we do when we don't get a full name and email, but
> do want to apply the patch?  Wait forever?  Claim authorship (but refer
> to the trac ticket in the commit msg)?  Apply anyway?  ...?
>

if there are trac templates (I'm not very familiar with trac internals), we
can turn on the requirement of

1) full name
2) legacy agreements

on the trac side


>
> (While typing this, I realize this sounds like a topic for the meeting
> tonight.  I'll put it on the agenda.)


> -Steffan
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, SlashDot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a11469c542497b805491ad204
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-02-22 13:30 GMT+05:00 Steffan Karger <span dir=3D"ltr">&lt;<a href=
=3D"mailto:steffan.karger@...1435..." target=3D"_blank">steffan.karger@...1386...=
435...</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin=
:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">On 22-02-17 08:39,=
 Gert Doering wrote:<br>
&gt; On Wed, Feb 22, 2017 at 02:21:35AM +0100, David Sommerseth wrote:<br>
&gt;&gt;&gt;&gt; &gt;From d97f526a2ddbf2abe60a64260601eb<wbr>d742fc00cc Mon=
 Sep 17 00:00:00 2001<br>
&gt;&gt;&gt;&gt; From: &quot;Simon (simix)&quot; &lt;via-trac&gt;<br>
&gt;&gt;&gt;<br>
&gt;&gt;&gt; Do we have a policy how to handle patches with missing author =
info?<br>
&gt;&gt;<br>
&gt;&gt; I see no reason at all why we should not give proper credit with f=
ull<br>
&gt;&gt; name.<br>
&gt;<br>
&gt; That was only half the question - of course I *want* to give full cred=
its,<br>
&gt; but is &quot;not having this information available &amp; no SoB line&q=
uot; a reason<br>
&gt; for rejecting a patch?<br>
&gt;<br>
&gt; The patch in question is quite obvious, so this is not something to br=
ing<br>
&gt; in the lawyers - more a matter of general policy.<br>
<br>
Same here.<br>
<br>
For this specific patch:=C2=A0 I asked the reporter on trac for full name a=
nd<br>
email last night.=C2=A0 We can wait for a bit to see if he replies.<br>
<br>
In general: what do we do when we don&#39;t get a full name and email, but<=
br>
do want to apply the patch?=C2=A0 Wait forever?=C2=A0 Claim authorship (but=
 refer<br>
to the trac ticket in the commit msg)?=C2=A0 Apply anyway?=C2=A0 ...?<br></=
blockquote><div><br></div><div>if there are trac templates (I&#39;m not ver=
y familiar with trac internals), we can turn on the requirement of <br><br>=
</div><div>1) full name<br></div><div>2) legacy agreements<br><br></div><di=
v>on the trac side<br></div><div>=C2=A0</div><blockquote class=3D"gmail_quo=
te" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
(While typing this, I realize this sounds like a topic for the meeting<br>
tonight.=C2=A0 I&#39;ll put it on the agenda.)=C2=A0</blockquote><blockquot=
e class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc sol=
id;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
-Steffan<br>
<br>
</font></span><br>------------------------------<wbr>----------------------=
--------<wbr>------------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, SlashDot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>_________=
_____________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
<br></blockquote></div><br></div></div>

--001a11469c542497b805491ad204--

