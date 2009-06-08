MIME-Version: 1.0
Date: Mon, 8 Jun 2009 18:38:23 +0200
Message-ID: <2ece24860906080938l79bf67av8aa5d6591d334c0a@...278...>
From: jonathan openvpn <jonathan.openvpn@...277...>
Content-Type: multipart/alternative; boundary=001636e91010ecaee6046bd8def4
Subject: [Openvpn-devel] Cannot find TAP adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001636e91010ecaee6046bd8def4
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hello.

I'm triying to execute a Windows CE port of OpenVPN in a custom hardware.

First of all, let me say that I cannot use the connection manager due to the
plattform i am using.

I've been succesfull on open the socket and retrieve initial information
from the OpenVPN server. I also have added a TAP interface to the Windows CE
registry via the "AddTAPAdapterRegistration" function in "taputil.cpp".

My problem comes when it's time to open the just registered TUN adapter.
When it searches for the adapters on the device by the "GetAdaptersInfo"
function, the TUN adapter is not present. Only the physical ethernet
interface is present.
I've compared the resgistry entries with a pocket PC running an OpenVPN
client and they are identical! I've searched in internet looking for someone
with a similar problem but i have found nothing. Have you any idea?
What are the requirements for an adapter to be found by the
"GetAdaptersInfo" function?

Here are my registry entries:

[HKEY_LOCAL_MACHINE\Comm\TAP Device]
"ImagePath"="tap-ce.dll"
"Group"="NDIS"
"DisplayName"="TAP Virtual Ethernet Device"

[HKEY_LOCAL_MACHINE\Comm\TAP Device\Linkage]
"Route"=hex(7):\

54,41,50,20,44,65,76,69,63,65,20,31,00,54,41,50,20,44,65,76,69,63,65,20,32,\
      00,00

[HKEY_LOCAL_MACHINE\Comm\TAP Device 1]
"ImagePath"="tap-ce.dll"
"Group"="NDIS"
"DisplayName"="TAP1: Virtual Ethernet Device"

[HKEY_LOCAL_MACHINE\Comm\TAP Device 1\Parms]
"StreamIndex"=dword:00000001
"StreamName"="TAP"
"BusType"=dword:00000000
"BusNumber"=dword:00000000



Another doubt.
In the tun.c file, in function "do_ifconfig", there is no entry for WIN32 or
WIN_CE, instead of this it is an "elif 0" entry. Because of this, in WIN_CE
systems no ifconfig is done. Isn't it necessary?

Thank you very much.

Jonathan.

--001636e91010ecaee6046bd8def4
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hello.<br><br>I&#39;m triying to execute a Windows CE port of OpenVPN in a =
custom hardware.<br><br>First of all, let me say that I cannot use the conn=
ection manager due to the plattform i am using.<br><br>I&#39;ve been succes=
full on open the socket and retrieve initial information from the OpenVPN s=
erver. I also have added a TAP interface to the Windows CE registry via the=
 &quot;AddTAPAdapterRegistration&quot; function in &quot;taputil.cpp&quot;.=
<br>
<br>My problem comes when it&#39;s time to open the just registered TUN ada=
pter. When it searches for the adapters on the device by the &quot;GetAdapt=
ersInfo&quot; function, the TUN adapter is not present. Only the physical e=
thernet interface is present.<br>
I&#39;ve compared the resgistry entries with a pocket PC running an OpenVPN=
 client and they are identical! I&#39;ve searched in internet looking for s=
omeone with a similar problem but i have found nothing. Have you any idea?<=
br>
What are the requirements for an adapter to be found by the &quot;GetAdapte=
rsInfo&quot; function?<br><br>Here are my registry entries:<br><br>[HKEY_LO=
CAL_MACHINE\Comm\TAP Device]<br>&quot;ImagePath&quot;=3D&quot;tap-ce.dll&qu=
ot;<br>
&quot;Group&quot;=3D&quot;NDIS&quot;<br>&quot;DisplayName&quot;=3D&quot;TAP=
 Virtual Ethernet Device&quot;<br><br>[HKEY_LOCAL_MACHINE\Comm\TAP Device\L=
inkage]<br>&quot;Route&quot;=3Dhex(7):\<br>=A0=A0=A0=A0=A0 54,41,50,20,44,6=
5,76,69,63,65,20,31,00,54,41,50,20,44,65,76,69,63,65,20,32,\<br>
=A0=A0=A0=A0=A0 00,00<br><br>[HKEY_LOCAL_MACHINE\Comm\TAP Device 1]<br>&quo=
t;ImagePath&quot;=3D&quot;tap-ce.dll&quot;<br>&quot;Group&quot;=3D&quot;NDI=
S&quot;<br>&quot;DisplayName&quot;=3D&quot;TAP1: Virtual Ethernet Device&qu=
ot;<br><br>[HKEY_LOCAL_MACHINE\Comm\TAP Device 1\Parms]<br>
&quot;StreamIndex&quot;=3Ddword:00000001<br>&quot;StreamName&quot;=3D&quot;=
TAP&quot;<br>&quot;BusType&quot;=3Ddword:00000000<br>&quot;BusNumber&quot;=
=3Ddword:00000000<br><br><br><br>Another doubt. <br>In the tun.c file, in f=
unction &quot;do_ifconfig&quot;, there is no entry for WIN32 or WIN_CE, ins=
tead of this it is an &quot;elif 0&quot; entry. Because of this, in WIN_CE =
systems no ifconfig is done. Isn&#39;t it necessary?<br>
<br>Thank you very much.<br><br>Jonathan.<br>

--001636e91010ecaee6046bd8def4--

