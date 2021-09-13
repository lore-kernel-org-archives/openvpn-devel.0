MIME-Version: 1.0
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-8-a@...2181...>
 <YT9F8nPtG1Xh2adu@...1296...>
 <CAEsd45S+QnNQo_aL5JrSSeWxo1v-kJVD9wD3SH4ss7Wt7RApCw@...278...>
 <CAKuzo_hSs54xeU4z0oP5zqysraR8_ghSwGiMPuvjKNxEkv+LUg@...278...>
 <504f0c45-0090-325d-b80a-73376679e13a@...2181...>
In-Reply-To: <504f0c45-0090-325d-b80a-73376679e13a@...2181...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 13 Sep 2021 19:28:14 -0400
Message-ID: <CAKuzo_g1yitzHbvo5HMfbj7ucMMwsaHMybORJCzk-qbiS8kz2w@...278...>
Content-Type: multipart/alternative; boundary="0000000000000ed74705cbe8db50"
Subject: Re: [Openvpn-devel] [PATCH 7/7] add message about changing default
 values
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Antonio Quartulli <a@...2181...>
Cc: Gert Doering <gert@...1296...>, "Jonathan K. Bullard" <jkbullard@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0000000000000ed74705cbe8db50
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Sep 13, 2021 at 3:23 PM Antonio Quartulli <a@...2181...> wrote:

> Hi,
>
> On 13/09/2021 18:51, Selva Nair wrote:
> > Hi
> >
> > On Mon, Sep 13, 2021 at 10:22 AM Jonathan K. Bullard
> > <jkbullard@...277... <mailto:jkbullard@...277...>> wrote:
> >
> >     Hi,
> >
> >     On Mon, Sep 13, 2021 at 8:37 AM Gert Doering <gert@...1296...
> >     <mailto:gert@...1296...>> wrote:
> >     >
> >     > Hi,
> >     >
> >     > On Sat, Sep 04, 2021 at 11:56:29AM +0200, Antonio Quartulli wrote:
> >     > > Add warning at startup to notify users about the change.
> >     > [..]
> >     > > +    /* Give a general warning at the end of initialisation that
> >     defaults
> >     > > +     * have changed */
> >     > > +    msg(M_WARN, "Note that modernisation of defaults in OpenVPN
> >     2.6 limits "
> >     > > +                "compatibility with old versions. See
> >     Changes.rst and "
> >     > > +                "--compat-mode in the manual for details.");
> >     > >  }
> >     >
> >     > I have my doubts if this is a good way forward.
> >     >
> >     > This warning will be printed on *every single startup* on OpenVPN
> now.
> >     >
> >     > Is this useful?  Or will people just ignore it.  Like, "all of a
> >     sudden
> >     > my Tunnelblick shows some giberrish in red at me, but the VPN is
> >     working,
> >     > so let's just ignore all warnings now".
> >
> >     ( Actually, Tunnelblick will show it in **yellow** : )
> >
> >     I don't think the warning will be very useful. Most Tunnelblick users
> >     don't look at the log. Those who do usually ignore warnings. Those
> who
> >     look at the log and don't ignore warnings often focus on ones which
> >     sound scary but whose benefits usually outweigh the risks or ask why
> >     the VPN works even though there are warnings. (Maybe there's less of
> a
> >     distinction between warning and error in other languages than there
> is
> >     in English? Or our translations aren't as clear about the
> >     distinction?)
> >
> >
> > +1
> >
> >
> >
> >     Tunnelblick warnings usually include a "do not warn about this again"
> >     option, which the OpenVPN log can't include.
> >
> >
> > OpenVPN-GUI for windows will show this in red (I find yellow too hard to
> > read on light backgrounds). Looks like we also will have to implement
> > this "do not show this again (or ever?)" feature.
> >
> > Ideally, this warning should be targeted to cases like a mismatched
> > option is detected. But that may be hard. What about printing this only
> > when an "old" client connects (on server) or when an "old" server
> > responds (on client)? Where "old" = 2.5 or older?
> >
>
> IMHO this warning should just not be added.
> It creates noise and confusion.
>
> On top of that, we will need an even longer discussion to figure out
> when to remove it, even though we know it is not really benefiting users.
>
> I vote for just dropping this patch.


+1 to that. My "targeted warnings" comment was meant as a soft way of
saying please drop this.. That said, had not Gert picked this up, I
wouldn't have noticed until the GUI started showing red lines in the logs...

Cheers,

Selva

--0000000000000ed74705cbe8db50
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 13, 2021 at 3:23 PM Antonio Quartulli &=
lt;a@...2181...&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Hi,<br>
<br>
On 13/09/2021 18:51, Selva Nair wrote:<br>
&gt; Hi<br>
&gt; <br>
&gt; On Mon, Sep 13, 2021 at 10:22 AM Jonathan K. Bullard<br>
&gt; &lt;<a href=3D"mailto:jkbullard@...277..." target=3D"_blank">jkbullard=
@...277...</a> &lt;mailto:<a href=3D"mailto:jkbullard@...277..." target=3D"=
_blank">jkbullard@...277...</a>&gt;&gt; wrote:<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Hi,<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0On Mon, Sep 13, 2021 at 8:37 AM Gert Doering &lt;<a=
 href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a><br>
&gt;=C2=A0 =C2=A0 =C2=A0&lt;mailto:<a href=3D"mailto:gert@...1296..." targe=
t=3D"_blank">gert@...1296...</a>&gt;&gt; wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Hi,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; On Sat, Sep 04, 2021 at 11:56:29AM +0200, Anto=
nio Quartulli wrote:<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; Add warning at startup to notify users ab=
out the change.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; [..]<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 /* Give a general warning =
at the end of initialisation that<br>
&gt;=C2=A0 =C2=A0 =C2=A0defaults<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* have changed */<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 msg(M_WARN, &quot;Note tha=
t modernisation of defaults in OpenVPN<br>
&gt;=C2=A0 =C2=A0 =C2=A02.6 limits &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;compatibility with old versions. See<br>
&gt;=C2=A0 =C2=A0 =C2=A0Changes.rst and &quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 &quot;--compat-mode in the manual for details.&quot;);<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; &gt;=C2=A0 }<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; I have my doubts if this is a good way forward=
.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; This warning will be printed on *every single =
startup* on OpenVPN now.<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt;<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; Is this useful?=C2=A0 Or will people just igno=
re it.=C2=A0 Like, &quot;all of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0sudden<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; my Tunnelblick shows some giberrish in red at =
me, but the VPN is<br>
&gt;=C2=A0 =C2=A0 =C2=A0working,<br>
&gt;=C2=A0 =C2=A0 =C2=A0&gt; so let&#39;s just ignore all warnings now&quot=
;.<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0( Actually, Tunnelblick will show it in **yellow** =
: )<br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0I don&#39;t think the warning will be very useful. =
Most Tunnelblick users<br>
&gt;=C2=A0 =C2=A0 =C2=A0don&#39;t look at the log. Those who do usually ign=
ore warnings. Those who<br>
&gt;=C2=A0 =C2=A0 =C2=A0look at the log and don&#39;t ignore warnings often=
 focus on ones which<br>
&gt;=C2=A0 =C2=A0 =C2=A0sound scary but whose benefits usually outweigh the=
 risks or ask why<br>
&gt;=C2=A0 =C2=A0 =C2=A0the VPN works even though there are warnings. (Mayb=
e there&#39;s less of a<br>
&gt;=C2=A0 =C2=A0 =C2=A0distinction between warning and error in other lang=
uages than there is<br>
&gt;=C2=A0 =C2=A0 =C2=A0in English? Or our translations aren&#39;t as clear=
 about the<br>
&gt;=C2=A0 =C2=A0 =C2=A0distinction?)<br>
&gt; <br>
&gt; <br>
&gt; +1<br>
&gt; =C2=A0<br>
&gt; <br>
&gt; <br>
&gt;=C2=A0 =C2=A0 =C2=A0Tunnelblick warnings usually include a &quot;do not=
 warn about this again&quot;<br>
&gt;=C2=A0 =C2=A0 =C2=A0option, which the OpenVPN log can&#39;t include.<br>
&gt; <br>
&gt; =C2=A0<br>
&gt; OpenVPN-GUI for windows will show this in=C2=A0red (I find yellow too =
hard to<br>
&gt; read on light backgrounds). Looks like we also will have to implement<=
br>
&gt; this &quot;do not show this again (or ever?)&quot; feature.<br>
&gt; <br>
&gt; Ideally, this warning should be targeted to cases like a mismatched<br>
&gt; option is detected. But that may be hard. What about printing this onl=
y<br>
&gt; when an &quot;old&quot; client connects (on server) or when an &quot;o=
ld&quot; server<br>
&gt; responds (on client)? Where &quot;old&quot; =3D 2.5 or older?<br>
&gt; <br>
<br>
IMHO this warning should just not be added.<br>
It creates noise and confusion.<br>
<br>
On top of that, we will need an even longer discussion to figure out<br>
when to remove it, even though we know it is not really benefiting users.<b=
r>
<br>
I vote for just dropping this patch.</blockquote><div>=C2=A0</div><div>+1 t=
o that. My &quot;targeted warnings&quot; comment was meant as a soft way of=
 saying please drop this.. That said, had not Gert picked this up, I wouldn=
&#39;t have noticed until the GUI started showing red lines in the logs...<=
/div><div><br></div><div>Cheers,</div><div><br></div><div>Selva</div></div>=
</div>

--0000000000000ed74705cbe8db50--

