Content-Type: multipart/alternative;
 boundary="Apple-Mail=_7DA96932-1A77-4206-8008-2169AF046180"
Mime-Version: 1.0 (Mac OS X Mail 9.3 \(3124\))
From: Karl Mueller <ewiley@...277...>
In-Reply-To: <CAKuzo_hc9zr_f4K8ePgNGRk8wQ=ONnv+WDEe9R+SjTdwL5K3Mg@...278...>
Date: Thu, 27 Jul 2017 15:21:06 -0400
Message-Id: <D417D4A2-7D8F-462A-842E-0D017D807839@...277...>
References: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
 <20170726143612.GJ70062@...1296...>
 <870CFEC0-4040-4DA0-A56B-E7CF835765A7@...277...>
 <CAKuzo_iwaB2cAWqd8xFuod5fLnDS8tUrSm-5SoEmz6F83-sMXg@...278...>
 <7A47FC49-E60F-4703-A093-80802FDB9B1C@...277...>
 <CAKuzo_hc9zr_f4K8ePgNGRk8wQ=ONnv+WDEe9R+SjTdwL5K3Mg@...278...>
Subject: Re: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Selva Nair <selva.nair@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--Apple-Mail=_7DA96932-1A77-4206-8008-2169AF046180
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable



> On Jul 27, 2017, at 2:55 PM, Selva Nair <selva.nair@...277...> wrote:
>=20
> Hi,
>=20
> On Thu, Jul 27, 2017 at 2:01 PM, Karl Mueller <ewiley@...277... <mailto:e=
wiley@...277...>> wrote:
>=20
> I think it is due to the redirect-gateway, and def1 does not change the b=
ehavior. I believe it=E2=80=99s because Windows sends NCSI internet probes =
to determine if an adapter has =E2=80=9CInternet=E2=80=9D access. If you=E2=
=80=99re not redirecting your gateway, those probes will probably fail via =
the VPN interface so it won=E2=80=99t consider the VPN interface as a viabl=
e alternative.
>=20
> If so just redirecting msftncsi.com <http://msftncsi.com/> through VPN wi=
ll trigger this?=20

Possibly, but I think there=E2=80=99s more (undocumented) complexity to it.=
 I tried blocking msftncsi.com IP=E2=80=99s on VPN and it had no effect.
>=20=20
>=20
> A frustrating part of the problem is that Windows overrides the routing t=
able by *silently* directing new connections to the =E2=80=9Cbetter=E2=80=
=9D Ethernet interface (in anticipation of the WiFi losing signal altogethe=
r, I suppose).  The only way to observe this is to use the powershell comma=
nd =E2=80=98find-netroute -remote <ip>=E2=80=99 which tells you where Windo=
ws will *really* send the packet. Also the effect of the redirection isn=E2=
=80=99t immediate, Windows waits from 30-120 seconds to start redirecting t=
raffic to the VPN interface once it detects weak WiFi signal.
>=20
> So to reproduce this the wifi signal has to go weak as well?

Yes, the connection is perfectly stable until wifi drops below some interna=
l signal setting, or possibly until it drops a packet or two. get-netadapte=
r shows that when the wifi speed drops below 7mb/s it almost always trigger=
s the behavior. There=E2=80=99s no logging associated with the behavior tha=
t I can find, which makes it difficult to troubleshoot too.

>=20=20
>=20
> Some more details of my setup: I use the Windows service-based VPN connec=
tion rather than user-initiated by way of openvpnserv2.exe.  We are using b=
uild 1511 of Windows 10. I posted my configs here: https://forums.openvpn.n=
et/viewtopic.php?f=3D4&t=3D24499 <https://forums.openvpn.net/viewtopic.php?=
f=3D4&t=3D24499>
>=20
> I suppose you mean the opposite: that is the connection is started at boo=
t using OpenVPNService (i.e., openvpnserv2.exe). User initiated connections=
 (using the GUI) are started by OpenVPNServiceInteractive (i.e., openvpnser=
v.exe).=20

Yes, sorry I said that backwards.
>=20
> Will try to reproduce, but being affected only when auto-started at boot =
is puzzling. In both cases the routes are set up the same way so it should =
not matter.  Except for --redirect-gateway: the interactive service will fo=
rce the use of def1, but again your config specifies def1 so the behaviour =
should be the same.

I am not sure about autostart being the culprit, but I think it=E2=80=99s a=
nother calculation in MS=E2=80=99s decision to drop the connection and mayb=
e why this isn=E2=80=99t so widely reported.

The page below describes the decision making logic in Windows, but it=E2=80=
=99s obviously missing some specifics:
https://docs.microsoft.com/en-us/windows-hardware/drivers/mobilebroadband/u=
nderstanding-and-configuring-windows-connection-manager

Karl Mueller
ewiley@...277...



--Apple-Mail=_7DA96932-1A77-4206-8008-2169AF046180
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><meta http-equiv=3D"Content-Type" content=3D"text/html charset=
=3Dutf-8"></head><body style=3D"word-wrap: break-word; -webkit-nbsp-mode: s=
pace; -webkit-line-break: after-white-space;" class=3D""><br class=3D"">
<br class=3D""><div><blockquote type=3D"cite" class=3D""><div class=3D"">On=
 Jul 27, 2017, at 2:55 PM, Selva Nair &lt;<a href=3D"mailto:selva.nair@...1665...=
77..." class=3D"">selva.nair@...277...</a>&gt; wrote:</div><br class=3D"App=
le-interchange-newline"><div class=3D""><div dir=3D"ltr" class=3D"">Hi,<br =
class=3D""><div class=3D"gmail_extra"><br class=3D""><div class=3D"gmail_qu=
ote">On Thu, Jul 27, 2017 at 2:01 PM, Karl Mueller <span dir=3D"ltr" class=
=3D"">&lt;<a href=3D"mailto:ewiley@...277..." target=3D"_blank" class=3D"">=
ewiley@...277...</a>&gt;</span> wrote:<br class=3D""><blockquote class=3D"g=
mail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-l=
eft:1ex"><span class=3D""><br class=3D"">
</span>I think it is due to the redirect-gateway, and def1 does not change =
the behavior. I believe it=E2=80=99s because Windows sends NCSI internet pr=
obes to determine if an adapter has =E2=80=9CInternet=E2=80=9D access. If y=
ou=E2=80=99re not redirecting your gateway, those probes will probably fail=
 via the VPN interface so it won=E2=80=99t consider the VPN interface as a =
viable alternative.<br class=3D""></blockquote><div class=3D""><br class=3D=
""></div><div class=3D"">If so just redirecting <a href=3D"http://msftncsi.=
com/" target=3D"_blank" class=3D"">msftncsi.com</a> through VPN will trigge=
r this?&nbsp;</div></div></div></div></div></blockquote><div><br class=3D""=
></div>Possibly, but I think there=E2=80=99s more (undocumented) complexity=
 to it. I tried blocking <a href=3D"http://msftncsi.com" class=3D"">msftncs=
i.com</a> IP=E2=80=99s on VPN and it had no effect.<br class=3D""><blockquo=
te type=3D"cite" class=3D""><div class=3D""><div dir=3D"ltr" class=3D""><di=
v class=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"">&nbsp;</=
div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-lef=
t:1px #ccc solid;padding-left:1ex">
<br class=3D"">
A frustrating part of the problem is that Windows overrides the routing tab=
le by *silently* directing new connections to the =E2=80=9Cbetter=E2=80=9D =
Ethernet interface (in anticipation of the WiFi losing signal altogether, I=
 suppose).&nbsp; The only way to observe this is to use the powershell comm=
and =E2=80=98find-netroute -remote &lt;ip&gt;=E2=80=99 which tells you wher=
e Windows will *really* send the packet. Also the effect of the redirection=
 isn=E2=80=99t immediate, Windows waits from 30-120 seconds to start redire=
cting traffic to the VPN interface once it detects weak WiFi signal.<br cla=
ss=3D""></blockquote><div class=3D""><br class=3D""></div><div class=3D"">S=
o to reproduce this the wifi signal has to go weak as well?</div></div></di=
v></div></div></blockquote><div><br class=3D""></div>Yes, the connection is=
 perfectly stable until wifi drops below some internal signal setting, or p=
ossibly until it drops a packet or two. get-netadapter shows that when the =
wifi speed drops below 7mb/s it almost always triggers the behavior. There=
=E2=80=99s no logging associated with the behavior that I can find, which m=
akes it difficult to troubleshoot too.</div><div><br class=3D""><blockquote=
 type=3D"cite" class=3D""><div class=3D""><div dir=3D"ltr" class=3D""><div =
class=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D"">&nbsp;</di=
v><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:=
1px #ccc solid;padding-left:1ex">
<br class=3D"">
Some more details of my setup: I use the Windows service-based VPN connecti=
on rather than user-initiated by way of openvpnserv2.exe.&nbsp; We are usin=
g build 1511 of Windows 10. I posted my configs here: <a href=3D"https://fo=
rums.openvpn.net/viewtopic.php?f=3D4&amp;t=3D24499" rel=3D"noreferrer" targ=
et=3D"_blank" class=3D"">https://forums.openvpn.net/vie<wbr class=3D"">wtop=
ic.php?f=3D4&amp;t=3D24499</a></blockquote><div class=3D""><br class=3D""><=
/div><div class=3D"">I suppose you mean the opposite: that is the connectio=
n is started at boot using OpenVPNService (i.e., openvpnserv2.exe). User in=
itiated connections (using the GUI) are started by OpenVPNServiceInteractiv=
e (i.e., openvpnserv.exe).&nbsp;</div></div></div></div></div></blockquote>=
<div><br class=3D""></div>Yes, sorry I said that backwards.<br class=3D""><=
blockquote type=3D"cite" class=3D""><div class=3D""><div dir=3D"ltr" class=
=3D""><div class=3D"gmail_extra"><div class=3D"gmail_quote"><div class=3D""=
><br class=3D""></div><div class=3D"">Will try to reproduce, but being affe=
cted only when auto-started at boot is puzzling. In both cases the routes a=
re set up the same way so it should not matter.&nbsp; Except for --redirect=
-gateway: the interactive service will force the use of def1, but again you=
r config specifies def1 so the behaviour should be the same.</div></div></d=
iv></div></div></blockquote><div><br class=3D""></div>I am not sure about a=
utostart being the culprit, but I think it=E2=80=99s another calculation in=
 MS=E2=80=99s decision to drop the connection and maybe why this isn=E2=80=
=99t so widely reported.</div><div><br class=3D""></div><div>The page below=
 describes the decision making logic in Windows, but it=E2=80=99s obviously=
 missing some specifics:</div><div><a href=3D"https://docs.microsoft.com/en=
-us/windows-hardware/drivers/mobilebroadband/understanding-and-configuring-=
windows-connection-manager" class=3D"">https://docs.microsoft.com/en-us/win=
dows-hardware/drivers/mobilebroadband/understanding-and-configuring-windows=
-connection-manager</a></div><div><br class=3D""></div><div><div class=3D""=
>Karl Mueller</div><div class=3D""><a href=3D"mailto:ewiley@...277..." clas=
s=3D"">ewiley@...277...</a></div><div class=3D""><br class=3D""></div></div=
><br class=3D""></body></html>=

--Apple-Mail=_7DA96932-1A77-4206-8008-2169AF046180--

