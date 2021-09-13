MIME-Version: 1.0
References: <20210904095629.6273-1-a@...2181...>
 <20210904095629.6273-8-a@...2181...>
 <YT9F8nPtG1Xh2adu@...1296...>
 <CAEsd45S+QnNQo_aL5JrSSeWxo1v-kJVD9wD3SH4ss7Wt7RApCw@...278...>
In-Reply-To: <CAEsd45S+QnNQo_aL5JrSSeWxo1v-kJVD9wD3SH4ss7Wt7RApCw@...278...>
From: Selva Nair <selva.nair@...277...>
Date: Mon, 13 Sep 2021 12:51:20 -0400
Message-ID: <CAKuzo_hSs54xeU4z0oP5zqysraR8_ghSwGiMPuvjKNxEkv+LUg@...278...>
Content-Type: multipart/alternative; boundary="000000000000a264b505cbe34f01"
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
To: "Jonathan K. Bullard" <jkbullard@...277...>
Cc: Gert Doering <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, Antonio Quartulli <a@...2181...>

--000000000000a264b505cbe34f01
Content-Type: text/plain; charset="UTF-8"

Hi

On Mon, Sep 13, 2021 at 10:22 AM Jonathan K. Bullard <jkbullard@...277...>
wrote:

> Hi,
>
> On Mon, Sep 13, 2021 at 8:37 AM Gert Doering <gert@...1296...> wrote:
> >
> > Hi,
> >
> > On Sat, Sep 04, 2021 at 11:56:29AM +0200, Antonio Quartulli wrote:
> > > Add warning at startup to notify users about the change.
> > [..]
> > > +    /* Give a general warning at the end of initialisation that
> defaults
> > > +     * have changed */
> > > +    msg(M_WARN, "Note that modernisation of defaults in OpenVPN 2.6
> limits "
> > > +                "compatibility with old versions. See Changes.rst and
> "
> > > +                "--compat-mode in the manual for details.");
> > >  }
> >
> > I have my doubts if this is a good way forward.
> >
> > This warning will be printed on *every single startup* on OpenVPN now.
> >
> > Is this useful?  Or will people just ignore it.  Like, "all of a sudden
> > my Tunnelblick shows some giberrish in red at me, but the VPN is working,
> > so let's just ignore all warnings now".
>
> ( Actually, Tunnelblick will show it in **yellow** : )
>
> I don't think the warning will be very useful. Most Tunnelblick users
> don't look at the log. Those who do usually ignore warnings. Those who
> look at the log and don't ignore warnings often focus on ones which
> sound scary but whose benefits usually outweigh the risks or ask why
> the VPN works even though there are warnings. (Maybe there's less of a
> distinction between warning and error in other languages than there is
> in English? Or our translations aren't as clear about the
> distinction?)
>

+1


>
> Tunnelblick warnings usually include a "do not warn about this again"
> option, which the OpenVPN log can't include.
>

OpenVPN-GUI for windows will show this in red (I find yellow too hard to
read on light backgrounds). Looks like we also will have to implement this
"do not show this again (or ever?)" feature.

Ideally, this warning should be targeted to cases like a mismatched option
is detected. But that may be hard. What about printing this only when an
"old" client connects (on server) or when an "old" server responds (on
client)? Where "old" = 2.5 or older?

Selva

--000000000000a264b505cbe34f01
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi</div><br><div class=3D"gmail_quote"><div dir=3D"lt=
r" class=3D"gmail_attr">On Mon, Sep 13, 2021 at 10:22 AM Jonathan K. Bullar=
d &lt;<a href=3D"mailto:jkbullard@...277...">jkbullard@...277...</a>&gt; wr=
ote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px=
 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On Mon, Sep 13, 2021 at 8:37 AM Gert Doering &lt;<a href=3D"mailto:gert@...493...=
1296..." target=3D"_blank">gert@...1296...</a>&gt; wrote:<br>
&gt;<br>
&gt; Hi,<br>
&gt;<br>
&gt; On Sat, Sep 04, 2021 at 11:56:29AM +0200, Antonio Quartulli wrote:<br>
&gt; &gt; Add warning at startup to notify users about the change.<br>
&gt; [..]<br>
&gt; &gt; +=C2=A0 =C2=A0 /* Give a general warning at the end of initialisa=
tion that defaults<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0* have changed */<br>
&gt; &gt; +=C2=A0 =C2=A0 msg(M_WARN, &quot;Note that modernisation of defau=
lts in OpenVPN 2.6 limits &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;co=
mpatibility with old versions. See Changes.rst and &quot;<br>
&gt; &gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 &quot;--=
compat-mode in the manual for details.&quot;);<br>
&gt; &gt;=C2=A0 }<br>
&gt;<br>
&gt; I have my doubts if this is a good way forward.<br>
&gt;<br>
&gt; This warning will be printed on *every single startup* on OpenVPN now.=
<br>
&gt;<br>
&gt; Is this useful?=C2=A0 Or will people just ignore it.=C2=A0 Like, &quot=
;all of a sudden<br>
&gt; my Tunnelblick shows some giberrish in red at me, but the VPN is worki=
ng,<br>
&gt; so let&#39;s just ignore all warnings now&quot;.<br>
<br>
( Actually, Tunnelblick will show it in **yellow** : )<br>
<br>
I don&#39;t think the warning will be very useful. Most Tunnelblick users<b=
r>
don&#39;t look at the log. Those who do usually ignore warnings. Those who<=
br>
look at the log and don&#39;t ignore warnings often focus on ones which<br>
sound scary but whose benefits usually outweigh the risks or ask why<br>
the VPN works even though there are warnings. (Maybe there&#39;s less of a<=
br>
distinction between warning and error in other languages than there is<br>
in English? Or our translations aren&#39;t as clear about the<br>
distinction?)<br></blockquote><div><br></div><div>+1</div><div>=C2=A0</div>=
<blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-=
left:1px solid rgb(204,204,204);padding-left:1ex">
<br>
Tunnelblick warnings usually include a &quot;do not warn about this again&q=
uot;<br>
option, which the OpenVPN log can&#39;t include.<br></blockquote><div>=C2=
=A0<br></div><div>OpenVPN-GUI for windows will show this in=C2=A0red (I fin=
d yellow too hard to read on light backgrounds). Looks like we also will ha=
ve to implement this &quot;do not show this again (or ever?)&quot; feature.=
</div><div><br></div><div>Ideally, this warning should be targeted to cases=
 like a mismatched option is detected. But that may be hard. What about pri=
nting this only when an &quot;old&quot; client connects (on server) or when=
 an &quot;old&quot; server responds (on client)? Where &quot;old&quot; =3D =
2.5 or older?</div><div><br></div><div>Selva</div></div></div>

--000000000000a264b505cbe34f01--

