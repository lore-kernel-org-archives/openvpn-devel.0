MIME-Version: 1.0
In-Reply-To: <20160207215605.GC24952@...1296...>
References: <CAKuzo_gX4qwZg01UR2k=_g1yEY93z3wc1LiyqTXn=WBm3aZvwQ@...278...>
	<20160207215605.GC24952@...1296...>
Date: Mon, 8 Feb 2016 08:35:54 +0500
Message-ID: <CAFHpkQEzCUDpHgRZhxYqTBUkvSe7ra5-CiS06Auzke+6vB=dkg@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Content-Type: multipart/alternative; boundary=001a11406bbef4fd5e052b39e53e
Subject: Re: [Openvpn-devel] GUI repo
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Gert Doering <gert@...1296...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a11406bbef4fd5e052b39e53e
Content-Type: text/plain; charset=UTF-8

I saw that PR.

I have one question regarding that.
when we deployed openvpn, we used to supply our users a config file without
"nobind" keyword.

it worked for most of our users, however, those who needed 2 or more vpn
connections complained that "port already bind". so, we added "nobind" to
client config files and people become happy.

what about that PR. there might be cases when

1) interactive service installed
2) user is administrator


how many openvpn processes will be running ? how many of them will attempt
to bind to 1194 ?

2016-02-08 2:56 GMT+05:00 Gert Doering <gert@...1296...>:

> Hi,
>
> On Sun, Feb 07, 2016 at 03:25:51PM -0500, Selva Nair wrote:
> > So the idea is to keep the current manifest  in the GUI distributed with
> > 2.3 and remove the HigestAvailable from that to be distributed with 2.4.
> > This change is also required to let admin users (with UAC) use
> interactive
> > service, as the plan is to make the GUI not connect to the service if run
> > with higher privileges (see my pending pull request).
>
> +1
>
> (just for the record) :-)
>
> gert
> --
> USENET is *not* the non-clickable part of WWW!
>                                                            //
> www.muc.de/~gert/
> Gert Doering - Munich, Germany
> gert@...1296...
> fax: +49-89-35655025
> gert@...1297...
>
>
> ------------------------------------------------------------------------------
> Site24x7 APM Insight: Get Deep Visibility into Application Performance
> APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month
> Monitor end-to-end web transactions and take corrective actions now
> Troubleshoot faster and improve end-user experience. Signup Now!
> http://pubads.g.doubleclick.net/gampad/clk?id=272487151&iu=/4140
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>
>

--001a11406bbef4fd5e052b39e53e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div><div><div>I saw that PR.<br><br><=
/div>I have one question regarding that.<br></div>when we deployed openvpn,=
 we used to supply our users a config file without &quot;nobind&quot; keywo=
rd.<br><br></div>it worked for most of our users, however, those who needed=
 2 or more vpn connections complained that &quot;port already bind&quot;. s=
o, we added &quot;nobind&quot; to client config files and people become hap=
py.<br><br></div>what about that PR. there might be cases when <br><br></di=
v>1) interactive service installed<br></div>2) user is administrator<br><br=
><br></div>how many openvpn processes will be running ? how many of them wi=
ll attempt to bind to 1194 ?<br></div><div class=3D"gmail_extra"><br><div c=
lass=3D"gmail_quote">2016-02-08 2:56 GMT+05:00 Gert Doering <span dir=3D"lt=
r">&lt;<a href=3D"mailto:gert@...1296..." target=3D"_blank">gert@...1296...=
</a>&gt;</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">Hi,<br>
<span class=3D""><br>
On Sun, Feb 07, 2016 at 03:25:51PM -0500, Selva Nair wrote:<br>
&gt; So the idea is to keep the current manifest=C2=A0 in the GUI distribut=
ed with<br>
&gt; 2.3 and remove the HigestAvailable from that to be distributed with 2.=
4.<br>
&gt; This change is also required to let admin users (with UAC) use interac=
tive<br>
&gt; service, as the plan is to make the GUI not connect to the service if =
run<br>
&gt; with higher privileges (see my pending pull request).<br>
<br>
</span>+1<br>
<br>
(just for the record) :-)<br>
<div class=3D"HOEnZb"><div class=3D"h5"><br>
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
fax: +49-89-35655025=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 <a href=3D"mailto:gert@...1297...">gert@...1826...=
7...</a><br>
</div></div><br>-----------------------------------------------------------=
-------------------<br>
Site24x7 APM Insight: Get Deep Visibility into Application Performance<br>
APM + Mobile APM + RUM: Monitor 3 App instances at just $35/Month<br>
Monitor end-to-end web transactions and take corrective actions now<br>
Troubleshoot faster and improve end-user experience. Signup Now!<br>
<a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D272487151&amp;iu=
=3D/4140" rel=3D"noreferrer" target=3D"_blank">http://pubads.g.doubleclick.=
net/gampad/clk?id=3D272487151&amp;iu=3D/4140</a><br>_______________________=
________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1199...=
sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/lists/listi=
nfo/openvpn-devel</a><br>
<br></blockquote></div><br></div>

--001a11406bbef4fd5e052b39e53e--

