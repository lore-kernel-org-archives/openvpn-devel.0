MIME-Version: 1.0
In-Reply-To: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
References: <CAKuzo_jj4H3toE0JXp-HNKBH5=Y_iXqVPKOndkycFTYmQoL0=g@...278...>
From: =?UTF-8?B?0JjQu9GM0Y8g0KjQuNC/0LjRhtC40L0=?= <chipitsine@...277...>
Date: Sun, 4 Dec 2016 19:42:18 +0500
Message-ID: <CAFHpkQEj2h4wwV056vy3dk4BBE=LuOoRtSqwMFonstY8RPNLYA@...278...>
Content-Type: multipart/alternative; boundary=089e0102e3daa3444b0542d62d08
Subject: Re: [Openvpn-devel] The windows installer and interactive service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--089e0102e3daa3444b0542d62d08
Content-Type: text/plain; charset=UTF-8

2016-12-03 23:48 GMT+05:00 Selva Nair <selva.nair@...277...>:

> Hi,
>
> In the installer, interactive service is tied to the installation of
> automatic service (openvpnserv2) --- if you opt not to install
> openvpnserv2, interactive service is also disabled. You can install
> openvpnserv2 without installing the interactive service, but not the other
> way.
>
> I think we should consider interactive service as a requirement for
> properly running the GUI (note that we do not set the GUI to request admin
> rights anymore). So I suggest:
>
> 1. Always install the interactive service along with openvpn core (and set
> up the required HKLM registry entries) OR at least automatically select
> interactive service if the GUI is selected.
>
> I prefer the first option as that service doesn't do anything unless a
> client connects to its service pipe, and has some uses even without the GUI.
>
> 2. Make it possible to uncheck automatic service (openvpnserv2)  without
> unchecking interactive service.
>
> A vast majority of installations would need only openvpn core, the GUI and
> interactive service. Most users will not use the automatic service
> (openvpnserv2) at all. Given that the latter requires .NET 4.0 which means
> an additional 50MB+ download for some, a very slow installation and
> possible restarts, forcing it on to get interactive service is not good.
>
> That said we could still leave openvpnserv2 selected by default as
> changing that at this stage may be unwise. Hopefully many Windows users may
> already have .NET 4.0 or higher installed.
>

thank you very much for your efforts.

however, it seems to get more and more complicated ("what if we install new
version after old version ... and checkboxes are set in different ways...").

what do I suggest, is to simplify things, i.e.

1) add "send installation statistics anonymousely" (we will see checkboxes)

2) run some kind of questionary

@mattock ?

after we get that information, I hope we can either deprecate or even
remove some configuration options and make it more simple. in 2.5 probably ?


>
> Thanks,
>
> Selva
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

--089e0102e3daa3444b0542d62d08
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><br><div class=3D"gmail_extra"><br><div class=3D"gmail_quo=
te">2016-12-03 23:48 GMT+05:00 Selva Nair <span dir=3D"ltr">&lt;<a href=3D"=
mailto:selva.nair@...277..." target=3D"_blank">selva.nair@...277...</a>&gt;=
</span>:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bo=
rder-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><div><div>=
<div><div>Hi,<br><br></div>In the installer, interactive service is tied to=
 the installation of automatic service (openvpnserv2) --- if you opt not to=
 install openvpnserv2, interactive service is also disabled. You can instal=
l openvpnserv2 without installing the interactive service, but not the othe=
r way.<br><br></div>I think we should consider interactive service as a req=
uirement for properly running the GUI (note that we do not set the GUI to r=
equest admin rights anymore). So I suggest:<br><br></div>1. Always install =
the interactive service along with openvpn core (and set up the required HK=
LM registry entries) OR at least automatically select interactive service i=
f the GUI is selected. <br><br>I prefer the first option as that service do=
esn&#39;t do anything unless a client connects to its service pipe, and has=
 some uses even without the GUI.<br><br></div>2. Make it possible to unchec=
k automatic service (openvpnserv2)=C2=A0 without unchecking interactive ser=
vice.<br><br>A vast majority of installations would need only openvpn core,=
 the GUI and interactive service. Most users will not use the automatic ser=
vice (openvpnserv2) at all. Given that the latter requires .NET 4.0 which m=
eans an additional 50MB+ download for some, a very slow installation and po=
ssible restarts, forcing it on to get interactive service is not good. <br>=
</div><div><br>That said we could still leave openvpnserv2 selected by defa=
ult as changing that at this stage may be unwise. Hopefully many Windows us=
ers may already have .NET 4.0 or higher installed.<br></div></div></blockqu=
ote><div><br></div><div>thank you very much for your efforts.<br><br></div>=
<div>however, it seems to get more and more complicated (&quot;what if we i=
nstall new version after old version ... and checkboxes are set in differen=
t ways...&quot;).<br><br></div><div>what do I suggest, is to simplify thing=
s, i.e.<br><br></div><div>1) add &quot;send installation statistics anonymo=
usely&quot; (we will see checkboxes)<br><br></div><div>2) run some kind of =
questionary<br><br></div><div>@mattock ?<br><br></div><div>after we get tha=
t information, I hope we can either deprecate or even remove some configura=
tion options and make it more simple. in 2.5 probably ?<br></div><div>=C2=
=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;borde=
r-left:1px #ccc solid;padding-left:1ex"><div dir=3D"ltr"><div><br></div><di=
v>Thanks,<br><br></div><div>Selva<br></div></div>
<br>------------------------------<wbr>------------------------------<wbr>-=
-----------------<br>
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

--089e0102e3daa3444b0542d62d08--

