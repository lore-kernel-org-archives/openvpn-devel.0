From: "dave" <dev@...575...>
Date: Tue, 9 Jun 2009 00:15:00 -0500
Message-ID: <C8A652422C014B2788B100CED4C8EB54@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0000_01C9E897.54D3C440"
In-Reply-To: <2ece24860906080938l79bf67av8aa5d6591d334c0a@...278...>
Subject: Re: [Openvpn-devel] Cannot find TAP adapter
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'jonathan openvpn' <jonathan.openvpn@...277...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0000_01C9E897.54D3C440
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

are you sure the driver is loaded?  GetAdaptersInfo uses iphlpapi, if
I'm not mistaken.  For there to be visibilty from taht lib's
perspective, all the NDIS stuff will have needed to happen (it's not
just plundering registry entries).  (There are a couple methods in
taputil that generate lists of TAP adapters according to various
heuristics, including iphlpapi, and registry plundering -- you can see
the difference, and are welcome to try but I don't think it will get you
closer to the solution).
 
A quicky alternative test to see if the driver is loaded is to open the
file TAP1: with CreateFile, and check the result (and GetLastError() if
needed).  This is the user-mode interface into the TAP device, and is a
little easier that fiddling with NDIS (though you can do that too).
 
I don't know your platform.  It's possibly not relevant, but for Window
Mobile 5 and up, the driver cannot be loaded automatically at system
startup, as it can on WM 4.2 and lower.  The reason has to do with the
policy that the platform is built with, and on those platforms, the
driver has to be signed with a 'priviledged certificate', which is
ruinously expensive (and you pay per signing), and a bit bureaucratic to
obtain.  It is signed with a regular code signing certificate (or it
wouldn't load at all), but not one of those special ones.
 
Anyway, that is platform (not OS) specific and may not be pertinent for
you.  If it is the case, there is a work-around via
StartAllTAPAdpaters(), which does some NDIS ioctls to cause the driver
to be loaded.
 
-dave
 
-----Original Message-----
From: jonathan openvpn [mailto:jonathan.openvpn@...277...] 
Sent: Monday, June 08, 2009 11:38 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] Cannot find TAP adapter



Hello.

I'm triying to execute a Windows CE port of OpenVPN in a custom
hardware.

First of all, let me say that I cannot use the connection manager due to
the plattform i am using.

I've been succesfull on open the socket and retrieve initial information
from the OpenVPN server. I also have added a TAP interface to the
Windows CE registry via the "AddTAPAdapterRegistration" function in
"taputil.cpp".

My problem comes when it's time to open the just registered TUN adapter.
When it searches for the adapters on the device by the "GetAdaptersInfo"
function, the TUN adapter is not present. Only the physical ethernet
interface is present.
I've compared the resgistry entries with a pocket PC running an OpenVPN
client and they are identical! I've searched in internet looking for
someone with a similar problem but i have found nothing. Have you any
idea?
What are the requirements for an adapter to be found by the
"GetAdaptersInfo" function?

Here are my registry entries:

[HKEY_LOCAL_MACHINE\Comm\TAP Device]
"ImagePath"="tap-ce.dll"
"Group"="NDIS"
"DisplayName"="TAP Virtual Ethernet Device"

[HKEY_LOCAL_MACHINE\Comm\TAP Device\Linkage]
"Route"=hex(7):\
 
54,41,50,20,44,65,76,69,63,65,20,31,00,54,41,50,20,44,65,76,69,63,65,20,
32,\
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
In the tun.c file, in function "do_ifconfig", there is no entry for
WIN32 or WIN_CE, instead of this it is an "elif 0" entry. Because of
this, in WIN_CE systems no ifconfig is done. Isn't it necessary?

Thank you very much.

Jonathan.



------=_NextPart_000_0000_01C9E897.54D3C440
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>are=20
you sure the driver is loaded?&nbsp; GetAdaptersInfo uses iphlpapi, if I'm =
not=20
mistaken.&nbsp; For there to be visibilty from taht lib's perspective, all =
the=20
NDIS stuff will have needed to happen (it's not just plundering registry=20
entries).&nbsp; (There are a couple methods in taputil that generate lists =
of=20
TAP adapters according to various heuristics, including iphlpapi, and regis=
try=20
plundering -- you can see the difference, and are welcome to try but I don'=
t=20
think it will get you closer to the solution).</FONT></SPAN></DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>A=20
quicky alternative test to see if the driver is loaded is to open the file =
<FONT=20
face=3D"Times New Roman" color=3D#000000 size=3D3>TAP1:</FONT> with CreateF=
ile, and=20
check the result (and GetLastError() if needed).&nbsp; This is the user-mod=
e=20
interface into the TAP device, and is a little easier that fiddling with ND=
IS=20
(though you can do that too).</FONT></SPAN></DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>I=20
don't know your platform.&nbsp; It's possibly not relevant, but for Window=
=20
Mobile 5 and up, the driver cannot be loaded automatically at system startu=
p, as=20
it can on WM 4.2 and lower.&nbsp; The reason has to do with the policy that=
 the=20
platform is built with, and on those platforms, the driver has to be signed=
 with=20
a 'priviledged certificate', which is ruinously expensive (and you=20
pay&nbsp;<EM>per signing)</EM>,&nbsp;and a bit bureaucratic to obtain.&nbsp=
; It=20
is signed with a regular code signing certificate (or it wouldn't load at a=
ll),=20
but not one of those special ones.</FONT></SPAN></DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2>Anyway, that is platform (not OS) specific and may not be pertinen=
t for=20
you.&nbsp; If it is the case, there is a work-around via StartAllTAPAdpater=
s(),=20
which does some NDIS ioctls to cause the driver to be=20
loaded.</FONT></SPAN></DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2>-dave</FONT></SPAN></DIV>
<DIV><SPAN class=3D702235203-09062009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN><SPAN class=3D702235203-09062009><FONT face=3DArial=
=20
color=3D#0000ff size=3D2></FONT></SPAN><SPAN class=3D702235203-09062009><FO=
NT=20
face=3DArial color=3D#0000ff size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV></DIV>
<DIV><FONT face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B=
>=20
jonathan openvpn [mailto:jonathan.openvpn@...277...] <BR><B>Sent:</B> Monda=
y,=20
June 08, 2009 11:38 AM<BR><B>To:</B>=20
openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> [Openvpn-devel] Cann=
ot=20
find TAP adapter<BR><BR></DIV></FONT>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">Hello.<BR><BR>I'm=20
  triying to execute a Windows CE port of OpenVPN in a custom=20
  hardware.<BR><BR>First of all, let me say that I cannot use the connectio=
n=20
  manager due to the plattform i am using.<BR><BR>I've been succesfull on o=
pen=20
  the socket and retrieve initial information from the OpenVPN server. I al=
so=20
  have added a TAP interface to the Windows CE registry via the=20
  "AddTAPAdapterRegistration" function in "taputil.cpp".<BR><BR>My problem =
comes=20
  when it's time to open the just registered TUN adapter. When it searches =
for=20
  the adapters on the device by the "GetAdaptersInfo" function, the TUN ada=
pter=20
  is not present. Only the physical ethernet interface is present.<BR>I've=
=20
  compared the resgistry entries with a pocket PC running an OpenVPN client=
 and=20
  they are identical! I've searched in internet looking for someone with a=
=20
  similar problem but i have found nothing. Have you any idea?<BR>What are =
the=20
  requirements for an adapter to be found by the "GetAdaptersInfo"=20
  function?<BR><BR>Here are my registry=20
  entries:<BR><BR>[HKEY_LOCAL_MACHINE\Comm\TAP=20
  Device]<BR>"ImagePath"=3D"tap-ce.dll"<BR>"Group"=3D"NDIS"<BR>"DisplayName=
"=3D"TAP=20
  Virtual Ethernet Device"<BR><BR>[HKEY_LOCAL_MACHINE\Comm\TAP=20
  Device\Linkage]<BR>"Route"=3Dhex(7):\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  54,41,50,20,44,65,76,69,63,65,20,31,00,54,41,50,20,44,65,76,69,63,65,20,3=
2,\<BR>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=20
  00,00<BR><BR>[HKEY_LOCAL_MACHINE\Comm\TAP Device=20
  1]<BR>"ImagePath"=3D"tap-ce.dll"<BR>"Group"=3D"NDIS"<BR>"DisplayName"=3D"=
TAP1:=20
  Virtual Ethernet Device"<BR><BR>[HKEY_LOCAL_MACHINE\Comm\TAP Device=20
  1\Parms]<BR>"StreamIndex"=3Ddword:00000001<BR>"StreamName"=3D"TAP"<BR>"Bu=
sType"=3Ddword:00000000<BR>"BusNumber"=3Ddword:00000000<BR><BR><BR><BR>Anot=
her=20
  doubt. <BR>In the tun.c file, in function "do_ifconfig", there is no entr=
y for=20
  WIN32 or WIN_CE, instead of this it is an "elif 0" entry. Because of this=
, in=20
  WIN_CE systems no ifconfig is done. Isn't it necessary?<BR><BR>Thank you =
very=20
  much.<BR><BR>Jonathan.<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0000_01C9E897.54D3C440--


