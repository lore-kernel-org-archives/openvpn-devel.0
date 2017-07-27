MIME-Version: 1.0
In-Reply-To: <7A47FC49-E60F-4703-A093-80802FDB9B1C@...277...>
References: <334D9817-7B72-4E78-B0CB-BC65EC004037@...277...>
 <20170726143612.GJ70062@...1296...>
 <870CFEC0-4040-4DA0-A56B-E7CF835765A7@...277...>
 <CAKuzo_iwaB2cAWqd8xFuod5fLnDS8tUrSm-5SoEmz6F83-sMXg@...278...>
 <7A47FC49-E60F-4703-A093-80802FDB9B1C@...277...>
From: Selva Nair <selva.nair@...277...>
Date: Thu, 27 Jul 2017 14:55:25 -0400
Message-ID: <CAKuzo_hc9zr_f4K8ePgNGRk8wQ=ONnv+WDEe9R+SjTdwL5K3Mg@...278...>
Content-Type: multipart/alternative; boundary="001a113ce2bcbd84f20555511c5e"
Subject: Re: [Openvpn-devel] TAP-adapter iftype question
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Karl Mueller <ewiley@...277...>
Cc: Gert Doering <gert@...1296...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

--001a113ce2bcbd84f20555511c5e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, Jul 27, 2017 at 2:01 PM, Karl Mueller <ewiley@...277...> wrote:

>
> I think it is due to the redirect-gateway, and def1 does not change the
> behavior. I believe it=E2=80=99s because Windows sends NCSI internet prob=
es to
> determine if an adapter has =E2=80=9CInternet=E2=80=9D access. If you=E2=
=80=99re not redirecting
> your gateway, those probes will probably fail via the VPN interface so it
> won=E2=80=99t consider the VPN interface as a viable alternative.
>

If so just redirecting msftncsi.com through VPN will trigger this?


>
> A frustrating part of the problem is that Windows overrides the routing
> table by *silently* directing new connections to the =E2=80=9Cbetter=E2=
=80=9D Ethernet
> interface (in anticipation of the WiFi losing signal altogether, I
> suppose).  The only way to observe this is to use the powershell command
> =E2=80=98find-netroute -remote <ip>=E2=80=99 which tells you where Window=
s will *really*
> send the packet. Also the effect of the redirection isn=E2=80=99t immedia=
te,
> Windows waits from 30-120 seconds to start redirecting traffic to the VPN
> interface once it detects weak WiFi signal.
>

So to reproduce this the wifi signal has to go weak as well?


>
> Some more details of my setup: I use the Windows service-based VPN
> connection rather than user-initiated by way of openvpnserv2.exe.  We are
> using build 1511 of Windows 10. I posted my configs here:
> https://forums.openvpn.net/viewtopic.php?f=3D4&t=3D24499


I suppose you mean the opposite: that is the connection is started at boot
using OpenVPNService (i.e., openvpnserv2.exe). User initiated connections
(using the GUI) are started by OpenVPNServiceInteractive (i.e.,
openvpnserv.exe).

Will try to reproduce, but being affected only when auto-started at boot is
puzzling. In both cases the routes are set up the same way so it should not
matter.  Except for --redirect-gateway: the interactive service will force
the use of def1, but again your config specifies def1 so the behaviour
should be the same.

Selva

--001a113ce2bcbd84f20555511c5e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><div class=3D"gmail_extra"><br><div class=3D"gmail_=
quote">On Thu, Jul 27, 2017 at 2:01 PM, Karl Mueller <span dir=3D"ltr">&lt;=
<a href=3D"mailto:ewiley@...277..." target=3D"_blank">ewiley@...277...</a>&=
gt;</span> wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 =
0 .8ex;border-left:1px #ccc solid;padding-left:1ex"><span><br>
</span>I think it is due to the redirect-gateway, and def1 does not change =
the behavior. I believe it=E2=80=99s because Windows sends NCSI internet pr=
obes to determine if an adapter has =E2=80=9CInternet=E2=80=9D access. If y=
ou=E2=80=99re not redirecting your gateway, those probes will probably fail=
 via the VPN interface so it won=E2=80=99t consider the VPN interface as a =
viable alternative.<br></blockquote><div><br></div><div>If so just redirect=
ing <a href=3D"http://msftncsi.com" target=3D"_blank">msftncsi.com</a> thro=
ugh VPN will trigger this?=C2=A0</div><div>=C2=A0</div><blockquote class=3D=
"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding=
-left:1ex">
<br>
A frustrating part of the problem is that Windows overrides the routing tab=
le by *silently* directing new connections to the =E2=80=9Cbetter=E2=80=9D =
Ethernet interface (in anticipation of the WiFi losing signal altogether, I=
 suppose).=C2=A0 The only way to observe this is to use the powershell comm=
and =E2=80=98find-netroute -remote &lt;ip&gt;=E2=80=99 which tells you wher=
e Windows will *really* send the packet. Also the effect of the redirection=
 isn=E2=80=99t immediate, Windows waits from 30-120 seconds to start redire=
cting traffic to the VPN interface once it detects weak WiFi signal.<br></b=
lockquote><div><br></div><div>So to reproduce this the wifi signal has to g=
o weak as well?</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" sty=
le=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padding-left:1ex">
<br>
Some more details of my setup: I use the Windows service-based VPN connecti=
on rather than user-initiated by way of openvpnserv2.exe.=C2=A0 We are usin=
g build 1511 of Windows 10. I posted my configs here: <a href=3D"https://fo=
rums.openvpn.net/viewtopic.php?f=3D4&amp;t=3D24499" rel=3D"noreferrer" targ=
et=3D"_blank">https://forums.openvpn.net/vie<wbr>wtopic.php?f=3D4&amp;t=3D2=
4499</a></blockquote><div><br></div><div>I suppose you mean the opposite: t=
hat is the connection is started at boot using OpenVPNService (i.e., openvp=
nserv2.exe). User initiated connections (using the GUI) are started by Open=
VPNServiceInteractive (i.e., openvpnserv.exe).=C2=A0</div><div><br></div><d=
iv>Will try to reproduce, but being affected only when auto-started at boot=
 is puzzling. In both cases the routes are set up the same way so it should=
 not matter.=C2=A0 Except for --redirect-gateway: the interactive service w=
ill force the use of def1, but again your config specifies def1 so the beha=
viour should be the same.</div><div><br></div><div>Selva</div></div></div><=
/div>

--001a113ce2bcbd84f20555511c5e--

