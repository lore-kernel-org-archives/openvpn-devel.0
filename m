MIME-Version: 1.0
References: <20220504111802.1050648-1-arne@...1227...>
 <202205051409.245E9kaU040678@...2054...>
In-Reply-To: <202205051409.245E9kaU040678@...2054...>
From: Penn Thitsar <pennthitsar@...277...>
Date: Thu, 5 May 2022 21:19:12 +0700
Message-ID: <CAGdfZSOijAHciP26hoSRdX4igqkcVxUqWJy_F5WFv4REGQVCZA@...278...>
Content-Type: multipart/alternative; boundary="000000000000c1e21a05de446dfb"
Subject: Re: [Openvpn-devel] [PATCH applied] Re: Remove workaround for
 Android 4.4
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

--000000000000c1e21a05de446dfb
Content-Type: text/plain; charset="UTF-8"

Re: Remove workaround for Android 4.4

On Thu, 5 May 2022, 21:11 Gert Doering, <gert@...1296...> wrote:

> Acked-by: Gert Doering <gert@...1296...>
>
> I have not actually investigated this in more detail - but this is
> something the Android GUI controls, so if you say "it will never send
> this message anymore" we can remove the code from openvpn core.
>
> I did wonder (on IRC) if we can get rid of ANDROID_OPEN_BEFORE_CLOSE at
> the same time - but looking more close, I see that we still have two
> variants, ANDROID_KEEP_OLD_TUN and ANDROID_OPEN_BEFORE_CLOSE.  So, yes,
> as long as the GUI can send both, we need both in the core...
>
> Your patch has been applied to the master branch.
>
> commit 44517fd7694012502318975173b1d0c05045d388
> Author: Arne Schwabe
> Date:   Wed May 4 13:18:02 2022 +0200
>
>      Remove workaround for Android 4.4
>
>      Signed-off-by: Arne Schwabe <arne@...1227...>
>      Acked-by: Gert Doering <gert@...1296...>
>      Message-Id: <20220504111802.1050648-1-arne@...1227...>
>      URL:
> https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg24276.html
>      Signed-off-by: Gert Doering <gert@...1296...>
>
>
> --
> kind regards,
>
> Gert Doering
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000c1e21a05de446dfb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Re: Remove workaround for Android 4.4</div><br><div class=
=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Thu, 5 May 2022, =
21:11 Gert Doering, &lt;<a href=3D"mailto:gert@...1296...">gert@...1296...<=
/a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0=
 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">Acked-by: Gert Doeri=
ng &lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank" rel=3D"noreferr=
er">gert@...1296...</a>&gt;<br>
<br>
I have not actually investigated this in more detail - but this is <br>
something the Android GUI controls, so if you say &quot;it will never send<=
br>
this message anymore&quot; we can remove the code from openvpn core.<br>
<br>
I did wonder (on IRC) if we can get rid of ANDROID_OPEN_BEFORE_CLOSE at<br>
the same time - but looking more close, I see that we still have two<br>
variants, ANDROID_KEEP_OLD_TUN and ANDROID_OPEN_BEFORE_CLOSE.=C2=A0 So, yes=
, <br>
as long as the GUI can send both, we need both in the core...<br>
<br>
Your patch has been applied to the master branch.<br>
<br>
commit 44517fd7694012502318975173b1d0c05045d388<br>
Author: Arne Schwabe<br>
Date:=C2=A0 =C2=A0Wed May 4 13:18:02 2022 +0200<br>
<br>
=C2=A0 =C2=A0 =C2=A0Remove workaround for Android 4.4<br>
<br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Arne Schwabe &lt;<a href=3D"mailto:arne@=
...1227..." target=3D"_blank" rel=3D"noreferrer">arne@...1227...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Acked-by: Gert Doering &lt;<a href=3D"mailto:gert@...1711...=
96..." target=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0Message-Id: &lt;<a href=3D"mailto:20220504111802.105064=
8-1-arne@...1227..." target=3D"_blank" rel=3D"noreferrer">20220504111802.10=
50648-1-arne@...1227...</a>&gt;<br>
=C2=A0 =C2=A0 =C2=A0URL: <a href=3D"https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg24276.html" rel=3D"noreferrer noreferrer" targ=
et=3D"_blank">https://www.mail-archive.com/openvpn-devel@...290...=
net/msg24276.html</a><br>
=C2=A0 =C2=A0 =C2=A0Signed-off-by: Gert Doering &lt;<a href=3D"mailto:gert@=
...1296..." target=3D"_blank" rel=3D"noreferrer">gert@...1296...</a>&gt;<br>
<br>
<br>
--<br>
kind regards,<br>
<br>
Gert Doering<br>
<br>
<br>
<br>
_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank" re=
l=3D"noreferrer">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000c1e21a05de446dfb--

