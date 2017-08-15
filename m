MIME-Version: 1.0
In-Reply-To: <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
References: <20170701112951.19119-1-steffan@...1856...>
 <b67daad4-362b-3605-5716-3e17c5f0c362@...2080...>
 <CAFHpkQFADMG50xb4UD_bAvT4a94EbLVstAuPEmhkxhUEnZoXQg@...278...>
 <480c51a7-a17d-c29f-1b8e-33c874ca9670@...2181...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Tue, 15 Aug 2017 14:17:23 +0500
Message-ID: <CAFHpkQGNS60dNn7eFED26A6ewVFNjw0eMome9CQZ=Tg=23Kmsw@...278...>
Content-Type: multipart/alternative; boundary="001a113b8e9848aa690556c73f5a"
Subject: Re: [Openvpn-devel] [PATCH] Deprecate --keysize
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113b8e9848aa690556c73f5a
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

2017-08-15 13:32 GMT+05:00 Antonio Quartulli <a@...2181...>:

>
>
> On 15/08/17 16:26, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=
=86=D0=B8=D0=BD wrote:
> > 2017-08-14 15:36 GMT+05:00 David Sommerseth <
> > openvpn@...2080...>:
> >
> >> On 01/07/17 13:29, Steffan Karger wrote:
> >>
> >> So I propose:
> >>
> >> - We add the warning about removing --keysize for both v2.4 and v2.5.
> >>
> >> - Add a warning in v2.4 and v2.5 that ciphers with block sizes < 128
> >>   bits will be *removed* in v2.6
> >>
> >> - When removing those ciphers in v2.6, we can remove --keysize together
> >>   with the ciphers, as it will no longer be valid.  But --keysize needs
> >>   to be a NOP for some time (with a warning it has no effect), to avoid
> >>   OpenVPN stopping to run on upgrades.
> >>
> >> - Ensure these changes are synchronised within OpenVPN 3 as well
> >>
> >> - Start a new wiki page: "How-To: Migrate to secure and modern
> >>   OpenVPN configurations" where we list all deprecated features/options
> >>   and their replacement (including examples).  We also need to have a
> >>   description on the reasoning for deprecating and removing these
> >>   options.
> >>
> >
> > there are special cases like Mikrotik openvpn (pretty popular), where
> > user simply use what hardware vendor installed (without possibility to
> > recompile).
> >
> > should we contact such hardware vendors as well ?
>
> there might be an non-predictable number of vendors shipping their own
> openvpn version. We can't contact them all. It's their responsibility to
> stay behind the changes in what they ship.
>
> If they don't, their users will complain aloud with them ;)
>
> On top of that, this does not prevent users from using their own config,
> right? So they can still configure the client to avoid deprecated options.
>

you cannot use regular openvpn config with Mikrotik
https://wiki.mikrotik.com/wiki/OpenVPN

you can use mikrotik configuration options


>
>
> Cheers,
>
> --
> Antonio Quartulli
>
>

--001a113b8e9848aa690556c73f5a
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2017-08-15 13:32 GMT+05:00 Antonio Quartulli <span dir=3D"ltr">&lt;<a h=
ref=3D"mailto:a@...2181..." target=3D"_blank">a@...2181...</a>&gt;</span>:<=
br><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;bord=
er-left:1px solid rgb(204,204,204);padding-left:1ex"><span class=3D"gmail-"=
><br>
<br>
On 15/08/17 16:26, =D0=98=D0=BB=D1=8C=D1=8F =D0=A8=D0=B8=D0=BF=D0=B8=D1=86=
=D0=B8=D0=BD wrote:<br>
&gt; 2017-08-14 15:36 GMT+05:00 David Sommerseth &lt;<br>
&gt; <a href=3D"mailto:openvpn@...2080...">openvpn@...2252...<wbr>net</a>&g=
t;:<br>
&gt;<br>
&gt;&gt; On 01/07/17 13:29, Steffan Karger wrote:<br>
&gt;&gt;<br>
</span><span class=3D"gmail-">&gt;&gt; So I propose:<br>
&gt;&gt;<br>
&gt;&gt; - We add the warning about removing --keysize for both v2.4 and v2=
.5.<br>
&gt;&gt;<br>
&gt;&gt; - Add a warning in v2.4 and v2.5 that ciphers with block sizes &lt=
; 128<br>
&gt;&gt;=C2=A0 =C2=A0bits will be *removed* in v2.6<br>
&gt;&gt;<br>
&gt;&gt; - When removing those ciphers in v2.6, we can remove --keysize tog=
ether<br>
&gt;&gt;=C2=A0 =C2=A0with the ciphers, as it will no longer be valid.=C2=A0=
 But --keysize needs<br>
&gt;&gt;=C2=A0 =C2=A0to be a NOP for some time (with a warning it has no ef=
fect), to avoid<br>
&gt;&gt;=C2=A0 =C2=A0OpenVPN stopping to run on upgrades.<br>
&gt;&gt;<br>
&gt;&gt; - Ensure these changes are synchronised within OpenVPN 3 as well<b=
r>
&gt;&gt;<br>
&gt;&gt; - Start a new wiki page: &quot;How-To: Migrate to secure and moder=
n<br>
&gt;&gt;=C2=A0 =C2=A0OpenVPN configurations&quot; where we list all depreca=
ted features/options<br>
&gt;&gt;=C2=A0 =C2=A0and their replacement (including examples).=C2=A0 We a=
lso need to have a<br>
&gt;&gt;=C2=A0 =C2=A0description on the reasoning for deprecating and remov=
ing these<br>
&gt;&gt;=C2=A0 =C2=A0options.<br>
&gt;&gt;<br>
&gt;<br>
&gt; there are special cases like Mikrotik openvpn (pretty popular), where<=
br>
&gt; user simply use what hardware vendor installed (without possibility to=
<br>
&gt; recompile).<br>
&gt;<br>
&gt; should we contact such hardware vendors as well ?<br>
<br>
</span>there might be an non-predictable number of vendors shipping their o=
wn<br>
openvpn version. We can&#39;t contact them all. It&#39;s their responsibili=
ty to<br>
stay behind the changes in what they ship.<br>
<br>
If they don&#39;t, their users will complain aloud with them ;)<br>
<br>
On top of that, this does not prevent users from using their own config,<br>
right? So they can still configure the client to avoid deprecated options.<=
br></blockquote><div><br></div><div>you cannot use regular openvpn config w=
ith Mikrotik<br><a href=3D"https://wiki.mikrotik.com/wiki/OpenVPN">https://=
wiki.mikrotik.com/wiki/OpenVPN</a><br><br></div><div>you can use mikrotik c=
onfiguration options<br></div><div>=C2=A0</div><blockquote class=3D"gmail_q=
uote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,2=
04);padding-left:1ex">
<br>
<br>
Cheers,<br>
<span class=3D"gmail-HOEnZb"><font color=3D"#888888"><br>
--<br>
Antonio Quartulli<br>
<br>
</font></span></blockquote></div><br></div></div>

--001a113b8e9848aa690556c73f5a--

