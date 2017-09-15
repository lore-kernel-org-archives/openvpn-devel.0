MIME-Version: 1.0
In-Reply-To: <20170915154011.GM70062@...1296...>
References: <1505450463-459-1-git-send-email-selva.nair@...277...>
 <20170915154011.GM70062@...1296...>
From: Selva <selva.nair@...277...>
Date: Fri, 15 Sep 2017 11:53:59 -0400
Message-ID: <CAKuzo_iHmRi9t2fANHy+GBZsLPWZzgXyBBgmsF9hJeToOvAh0g@...278...>
Content-Type: multipart/alternative; boundary="001a113ce2b6e7d67a05593c67e5"
Subject: Re: [Openvpn-devel] [PATCH] Check whether in pull_mode before
 warning about previous connection blocks
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ce2b6e7d67a05593c67e5
Content-Type: text/plain; charset="UTF-8"

On Fri, Sep 15, 2017 at 11:40 AM, Gert Doering <gert@...1296...> wrote:

> Hi,
>
> On Fri, Sep 15, 2017 at 12:41:03AM -0400, selva.nair@...277... wrote:
> > From: Selva Nair <selva.nair@...277...>
> >
> > Eliminate the confusing message that says "explicit-exit-notify is
> ignored by
> > previous <connection> blocks" when the option is pushed.
> > Reported by: Eike Lohmann e.lohmann@...1294...
> > https://www.mail-archive.com/openvpn-users@...1199...
> sourceforge.net/msg04052.html
>
> Not sure I understand that patch.  If I read it right (and I might not),
> won't this just make this option non-pushable, thus suppressing the error
> message by disabling the option?
>

No it doesn't change any functionality. By not including OPT_P_CONNECTION
in the mask sent to verify permission the previous connection blacks check
is disabled.  And this is done only when pull_mode is True.

So the only effect is just to suppress the message about previous
connection blocks when this option is parsed as a pushed option.

The key here is that check pull_mode to know that we are processing a
pushed option.

Selva

>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025                        gert@...1816...
> muenchen.de
>

--001a113ce2b6e7d67a05593c67e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">On Fri, Sep 15, 2017 at 11:40 AM, Gert Doering <span dir=3D"ltr">&lt;<a=
 href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...</a>&gt;<=
/span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8=
ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<br>
On Fri, Sep 15, 2017 at 12:41:03AM -0400, <a href=3D"mailto:selva.nair@...1665...=
77...">selva.nair@...277...</a> wrote:<br>
&gt; From: Selva Nair &lt;<a href=3D"mailto:selva.nair@...277...">selva.nai=
r@...277...</a>&gt;<br>
&gt;<br>
&gt; Eliminate the confusing message that says &quot;explicit-exit-notify i=
s ignored by<br>
&gt; previous &lt;connection&gt; blocks&quot; when the option is pushed.<br>
&gt; Reported by: Eike Lohmann <a href=3D"mailto:e.lohmann@...1294...">e.lo=
hmann@...1294...</a><br>
&gt; <a href=3D"https://www.mail-archive.com/openvpn-users@...1483...=
e.net/msg04052.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-=
archive.com/<wbr>openvpn-users@...1199...<wbr>sourceforge.net/msg04052.html=
</a><br>
<br>
Not sure I understand that patch.=C2=A0 If I read it right (and I might not=
),<br>
won&#39;t this just make this option non-pushable, thus suppressing the err=
or<br>
message by disabling the option?<br></blockquote><div><br></div><div>No it =
doesn&#39;t change any functionality. By not including OPT_P_CONNECTION in =
the mask sent to verify permission the previous connection blacks check is =
disabled.=C2=A0 And this is done only when pull_mode is True.=C2=A0</div><d=
iv><br></div><div>So the only effect is just to suppress the message about =
previous connection blocks when this option is parsed as a pushed option.</=
div><div><br></div><div>The key here is that check pull_mode to know that w=
e are processing a pushed option.</div><div><br></div><div>Selva</div><bloc=
kquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #cc=
c solid;padding-left:1ex">
<span class=3D"HOEnZb"><font color=3D"#888888"><br>
gert<br>
--<br>
USENET is *not* the non-clickable part of WWW!<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//<a href=3D"=
http://www.muc.de/~gert/" rel=3D"noreferrer" target=3D"_blank">www.muc.de/~=
gert/</a><br>
Gert Doering - Munich, Germany=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0<a href=3D"mailt=
o:gert@...1296...">gert@...1296...</a><br>
fax: <a href=3D"tel:%2B49-89-35655025" value=3D"+498935655025">+49-89-35655=
025</a>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1816...<wbr>mu=
enchen.de</a><br>
</font></span></blockquote></div><br></div></div>

--001a113ce2b6e7d67a05593c67e5--

