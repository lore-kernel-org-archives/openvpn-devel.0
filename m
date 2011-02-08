MIME-Version: 1.0
Date: Mon, 7 Feb 2011 17:12:16 -0800
Message-ID: <AANLkTi=r_utzB7C8AOpOdYB5MsH72og5PmTPBa3fKC3a@...278...>
From: anjini shukla <anjinishukla@...277...>
Content-Type: multipart/alternative; boundary=20cf3054a7370b4bd3049bbb0ac1
Subject: [Openvpn-devel] setting up routes after connecting to via openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Openvpn-devel@lists.sourceforge.net

--20cf3054a7370b4bd3049bbb0ac1
Content-Type: text/plain; charset=ISO-8859-1

I need some help in setting up routes, once i have a point to point
connection between two computers using openVpn.

-Computer A:      10.8.0.1
 ( windows xp)    10.10.15.39

-Computer B:    10.8.0.2
  ( windows xp)  10.208.54.100

I can ping 10.8.0.1 from computerB and 10.8.0.2 from computer A.

I want  to connect computerB to the 10.10.15.x subnet. I explicitly added
route using command :

ComputerB: "route add 10.10.15.0 mask 255.255.255.255 10.10.8.2"
and  modified
HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\IPEnableRouter
1

I expect all the traffic for 10.10.15.x subnet to be routed through
10.8.0.2, but that is never the case. I observed in tracert and wireshark a
ping 10.10.15.39 always has source as 10.208.54.100. Anyone has seen
a similar issue? I also tried adding push route parameter as openVpn
documentation suggests, but that did not help.

Thank you for all help in advance,
Anjini

ps:
command used to connect to openvpn

ComputerA: "openvpn.exe --dev tun --proto tcp-server --ifconfig 10.8.0.1
10.8.0.2"

Computer V: "openvpn.exe --dev tun --proto tcp-client --remote
computerBIPAddress --ifconfig 10.8.0.2 10.8.0.1 "

--20cf3054a7370b4bd3049bbb0ac1
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div>I need some help in setting up routes, once i have a=A0point to point =
connection between two computers using openVpn.</div><div><br></div><div>-C=
omputer A: =A0 =A0 =A010.8.0.1</div><div>=A0( windows xp) =A0 =A010.10.15.3=
9</div><div>

<br></div><div>-Computer B: =A0 =A010.8.0.2</div><div>=A0=A0( windows xp) =
=A010.208.54.100=A0</div><div><br></div><div>I can ping 10.8.0.1 from compu=
terB and 10.8.0.2 from computer A.</div><div><br></div><div>I want =A0to co=
nnect computerB to the 10.10.15.x subnet. I explicitly added route using co=
mmand :=A0</div>

<div><br></div><div>ComputerB: &quot;route add 10.10.15.0 mask 255.255.255.=
255 10.10.8.2&quot;</div><div>and =A0modified=A0</div><div><span style=3D"f=
ont-family:Verdana, Arial, Helvetica, sans-serif;font-size:11px;line-height=
:17px">HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\Tcpip\Parameter=
s\</span><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;f=
ont-size:11px;line-height:17px">IPEnableRouter 1</span></div>

<div><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;font-=
size:11px;line-height:17px"><br></span></div><div><font face=3D"Verdana, Ar=
ial, Helvetica, sans-serif"><span style=3D"font-size:11px;line-height:17px"=
>I expect all the traffic for 10.10.15.x subnet to be routed through 10.8.0=
.2, but that is never the case. I observed in tracert and wireshark a ping =
10.10.15.39 always has source as 10.208.54.100. Anyone has seen a=A0similar=
 issue? I also tried adding push route parameter as openVpn documentation s=
uggests, but that did not help.=A0</span></font></div>

<div><font face=3D"Verdana, Arial, Helvetica, sans-serif"><span style=3D"fo=
nt-size:11px;line-height:17px"><br></span></font></div><div><font face=3D"V=
erdana, Arial, Helvetica, sans-serif"><span style=3D"font-size:11px;line-he=
ight:17px">Thank you for all help in advance,</span></font></div>

<div><font face=3D"Verdana, Arial, Helvetica, sans-serif"><span style=3D"fo=
nt-size:11px;line-height:17px"></span></font><span style=3D"font-family:Ver=
dana, Arial, Helvetica, sans-serif;font-size:11px;line-height:17px">Anjini=
=A0</span></div>

<div><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;font-=
size:11px;line-height:17px"><br></span></div><div><span style=3D"font-famil=
y:Verdana, Arial, Helvetica, sans-serif;font-size:11px;line-height:17px">ps=
:=A0</span></div>

<div><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;font-=
size:11px;line-height:17px">command used to connect to openvpn</span></div>=
<div><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;font-=
size:11px;line-height:17px"><br>

</span></div><div><span style=3D"font-family:Verdana, Arial, Helvetica, san=
s-serif;font-size:11px;line-height:17px">ComputerA: &quot;openvpn.exe --dev=
 tun --proto tcp-server --ifconfig 10.8.0.1 10.8.0.2&quot;</span></div>
<div><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;font-=
size:11px;line-height:17px"><br></span></div><div><span style=3D"font-famil=
y:Verdana, Arial, Helvetica, sans-serif;font-size:11px;line-height:17px">Co=
mputer V: &quot;openvpn.exe --dev tun --proto tcp-client --remote computerB=
IPAddress --ifconfig 10.8.0.2 10.8.0.1 &quot;</span></div>

<div><span style=3D"font-family:Verdana, Arial, Helvetica, sans-serif;font-=
size:11px;line-height:17px"><br></span></div>

--20cf3054a7370b4bd3049bbb0ac1--

