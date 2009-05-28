From: "dave" <dev@...575...>
Date: Thu, 28 May 2009 08:27:47 -0500
Message-ID: <1DEBAC6728FF4F9E8B743981F029E1BC@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_001C_01C9DF6E.2EEE3710"
In-Reply-To: <2ece24860905272356l5234c224mcbd4b7c01553a983@...278...>
Subject: Re: [Openvpn-devel] CE port needed DLLs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: 'jonathan openvpn' <jonathan.openvpn@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_001C_01C9DF6E.2EEE3710
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Sure, you're welcome.  Thumb should not fundamentally be a problem
provided the platform and tools support it, and it sounds like in your
case it does.
 
Your assumptions about what you need are correct, I believe (i.e., you
don't need the gui).  You may want to inspect the code, however, because
there are routines for installing and loading the TAP driver that may be
of interest.  They are in taputil.h,.c
 
cellcore.dll is used to provide the Windows Connection Manager stuff,
and in openvpn.exe this in openvpn.c, around line 203, and around line
284.  I should have conditional-compiled that as an option, but I
didn't.  Similarly the support routines are in wince_portstuff.c at line
1631 through the end, and they can go, too (actually if you remove those
first and compile, the compile should fail and you can find if there was
anything I missed, but that should be it).
 
Generic CE platforms don't use the Windows Connection Manager and do
networking in the more conventional way, so you can probable do without
it, and remove the cellcore.lib from your link step.
 
Assuming your error message really means 'missing dlls' instead of
'invalid binary' then you should be better off.
 
Again, if you want to send me your compiled binary, I can inspect it
more closely if that is useful.
 
-Dave

-----Original Message-----
From: jonathan openvpn [mailto:jonathan.openvpn@...277...] 
Sent: Thursday, May 28, 2009 1:56 AM
To: dave
Cc: openvpn-devel@lists.sourceforge.net
Subject: Re: [Openvpn-devel] CE port needed DLLs


Hello.

First of all, thank you for the quick response.

We have other applications running on the Windows CE distribution and
the linker option "MACHINE" is set to "THUMB".
We are using a custom developed board, and we develop our applications
through Visual Studio 2005.

We only need to stablish a connection to a VPN server without need of a
GUI, all configuration must be transparent to the user. Therefore I
think we only need the openvpn executable and TAP_CE driver. If i'm not
wrong, the ovpncmgr module is to provide a GUI for the openVPN client.
Is that correct?

When no dll is provided, and I try to debug the application from Visual
Studio connected to the device, i get the message: "An error occurred
that usually indicates a corrupt installation (code 0x8007007e). If the
problem persists, repair your Visual Studio installation via 'Add or
Remove Programs' in control Panel"
Some webs refer to that error like some archives are missing. When I put
the dlls you have listed below, the error changes to: "openvpn is not a
valid WindowsCE application". I suspect that some of the dll may not be
correct for my platform. Could it be the source of my problem?

I have not been able to find the cellcore.dll for our platform. Does it
mean we cannot use the connection manager functionality? I have read in
some forums that this functionality is not present on Windows CE...

Sorry for my ignorance, I am pretty new on Windows CE.

Your help is so much appreciated. Thank you very much.

Jonathan.



2009/5/27 dave <dev@...575...>


That message usually means the binary is hosed, and I believe missing
dlls give a different message.
Are you sure Thumb is correct for your platform?  Are you using a
consumer device like a pocket pc phone, etc, or is it a custom board?
 
I ask that because the existing code does use some functionality
peculiar to the pocket pc (phone) that is not generally available on
other platforms, yet the SDKs ofen include the headers and import libs,
allowing you to successfully compile, but then you can't run it on the
target device.
 
When you say 'client application' are you meaning just the gui, or the
whole entire set of programs (i.e., the TAP driver, the openvpn
executable, and the gui).
 
You can use DUMPBIN to find the dlls from the exe, and also inspect the
header to see the cpu configuration.  Here is a short list, if it helps:
 
openvpn:
*  coredll.dll
*  w2s.dll
*  iphlpapi.dll
*  wininet.dll
*  ole32.dll
*  cellcore.dll
 
tap-ce:
*  ndis.dll
*  coredll.dll
 
ovpncmgr:
*  iphlpapi.dll
*  toolhelp.dll
*  cellcore.dll
*  ole32.dll
*  mfcce300.dll
*  coredll.dll
*  winsock.dll
 
Your build may (will) differ depending on your platform, because your
platform builder may have put some of these features in different dlls.
That list was for PocketPC.
 
Now, the cellcore.dll, you may not have on other platforms.  It is
needed for supporting Windows Connectin Manager, and you can surgically
cut out that functionality if your platform doesn't have it.  Most of
the rest is fairly standard.
 
Before doing surgery, you may wish to re-check your assumptions.  Also,
if you wish to zip up your problem binaries and send them to me
directly, I will do a quick inspection for you.
 

-dave

-----Original Message-----
From: jonathan openvpn [mailto:jonathan.openvpn@...277...] 
Sent: Wednesday, May 27, 2009 5:36 AM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] CE port needed DLLs


Hello.

I'm triying to execute a Windows CE 5.0 porting of openvpn client
application. I've been successful on compiling it but when i try to
execute i receive the message: "openvpn is not a valid WindowsCE
application".

I am compiling to ARM-Thumb architecture. I suspect there is a problem
with needed DLLs.

Could anyone tell me wich DLLs are needed and where could i get them?

Thank you very much.




------=_NextPart_000_001C_01C9DF6E.2EEE3710
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D431271713-28=
052009>Sure,=20
you're welcome.&nbsp; Thumb should not fundamentally be a problem provided =
the=20
platform and tools support it, and it sounds like in your case it=20
does.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D431271713-28=
052009>Your=20
assumptions about what you need are correct, I believe (i.e., you don't nee=
d the=20
gui).&nbsp; You may want to inspect the code, however, because there are=20
routines for installing and loading the TAP driver that may be of=20
interest.&nbsp; They are in taputil.h,.c</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009>cellcore.dll is used to provide the Windows Conn=
ection=20
Manager stuff, and in openvpn.exe this in openvpn.c, around line 203, and a=
round=20
line 284.&nbsp; I should have conditional-compiled that as an option, but&n=
bsp;I=20
didn't.&nbsp; Similarly the support routines are in wince_portstuff.c at li=
ne=20
1631 through the end, and they can go, too (actually if you remove those fi=
rst=20
and compile, the compile should fail and you can find if there was anything=
 I=20
missed, but that should be it).</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009>Generic CE platforms don't use the Windows Conne=
ction=20
Manager and do networking in the more conventional way, so you can probable=
 do=20
without it, and remove the cellcore.lib from your link step.</SPAN></FONT><=
/DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009>Assuming your error message really means 'missin=
g dlls'=20
instead of 'invalid binary' then you should be better off.</SPAN></FONT></D=
IV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN class=3D431271713-28=
052009>Again,=20
if you want to send me your compiled binary, I can inspect it more closely =
if=20
that is useful.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D431271713-28052009>-Dave</SPAN></FONT></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> jonatha=
n openvpn=20
  [mailto:jonathan.openvpn@...277...] <BR><B>Sent:</B> Thursday, May 28, 20=
09=20
  1:56 AM<BR><B>To:</B> dave<BR><B>Cc:</B>=20
  openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> Re: [Openvpn-devel=
] CE=20
  port needed DLLs<BR><BR></FONT></DIV>Hello.<BR><BR>First of all, thank yo=
u for=20
  the quick response.<BR><BR>We have other applications running on the Wind=
ows=20
  CE distribution and the linker option "MACHINE" is set to "THUMB".<BR>We =
are=20
  using a custom developed board, and we develop our applications through V=
isual=20
  Studio 2005.<BR><BR>We only need to stablish a connection to a VPN server=
=20
  without need of a GUI, all configuration must be transparent to the user.=
=20
  Therefore I think we only need the openvpn executable and TAP_CE driver. =
If=20
  i'm not wrong, the ovpncmgr module is to provide a GUI for the openVPN cl=
ient.=20
  Is that correct?<BR><BR>When no dll is provided, and I try to debug the=20
  application from Visual Studio connected to the device, i get the message=
: "An=20
  error occurred that usually indicates a corrupt installation (code=20
  0x8007007e). If the problem persists, repair your Visual Studio installat=
ion=20
  via 'Add or Remove Programs' in control Panel"<BR>Some webs refer to that=
=20
  error like some archives are missing. When I put the dlls you have listed=
=20
  below, the error changes to: "openvpn is not a valid WindowsCE applicatio=
n". I=20
  suspect that some of the dll may not be correct for my platform. Could it=
 be=20
  the source of my problem?<BR><BR>I have not been able to find the cellcor=
e.dll=20
  for our platform. Does it mean we cannot use the connection manager=20
  functionality? I have read in some forums that this functionality is not=
=20
  present on Windows CE...<BR><BR>Sorry for my ignorance, I am pretty new o=
n=20
  Windows CE.<BR><BR>Your help is so much appreciated. Thank you very=20
  much.<BR><BR>Jonathan.<BR><BR><BR>
  <DIV class=3Dgmail_quote>2009/5/27 dave <SPAN dir=3Dltr>&lt;<A=20
  href=3D"mailto:dev@...575...">dev@...575...</A>&gt;</SPAN><BR>
  <BLOCKQUOTE class=3Dgmail_quote=20
  style=3D"PADDING-LEFT: 1ex; MARGIN: 0pt 0pt 0pt 0.8ex; BORDER-LEFT: rgb(2=
04,204,204) 1px solid">
    <DIV>
    <DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>That message usu=
ally means=20
    the binary is hosed, and I believe missing dlls give a different=20
    message.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>Are you sure Thu=
mb is=20
    correct for your platform?&nbsp; Are you using a consumer device like a=
=20
    pocket pc phone, etc, or is it a custom board?</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2></FONT></SPAN>&n=
bsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>I ask that becau=
se the=20
    existing code does use some functionality peculiar to the pocket pc (ph=
one)=20
    that is not generally available on other platforms, yet the SDKs ofen=20
    include the headers and import libs, allowing you to successfully compi=
le,=20
    but then you can't run it on the target device.</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2></FONT></SPAN>&n=
bsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>When you say 'cl=
ient=20
    application' are you meaning just the gui, or the whole entire set of=20
    programs (i.e., the TAP driver, the openvpn executable, and the=20
    gui).</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2></FONT></SPAN>&n=
bsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>You can use DUMP=
BIN to find=20
    the dlls from the exe, and also inspect the header to see the cpu=20
    configuration.&nbsp; Here is a short list, if it helps:</FONT></SPAN></=
DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2></FONT></SPAN>&n=
bsp;</DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff=20
size=3D2>openvpn:</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
    coredll.dll</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
    w2s.dll</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
    iphlpapi.dll</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
    wininet.dll</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
    ole32.dll</FONT></SPAN></DIV>
    <DIV><SPAN><FONT face=3DArial color=3D#0000ff size=3D2>*&nbsp;=20
    cellcore.dll</FONT></SPAN></DIV>
    <DIV><FONT face=3DTahoma><FONT size=3D2><SPAN><FONT face=3DArial=20
    color=3D#0000ff></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN>tap-ce:</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    ndis.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    coredll.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN>ovpncmgr:</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    iphlpapi.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    toolhelp.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    cellcore.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    ole32.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    mfcce300.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    coredll.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN>=
*&nbsp;=20
    winsock.dll</SPAN></FONT></FONT></DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>Your=20
    build may (will) differ depending on your platform, because your platfo=
rm=20
    builder may have put some of these features in different dlls.&nbsp; Th=
at=20
    list was for PocketPC.</SPAN></FONT></FONT></DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>Now, the=20
    cellcore.dll, you may not have on other platforms.&nbsp; It is needed f=
or=20
    supporting Windows Connectin Manager, and you can surgically cut out th=
at=20
    functionality if your platform doesn't have it.&nbsp; Most of the rest =
is=20
    fairly standard.</SPAN></FONT></FONT></DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><S=
PAN>Before=20
    doing surgery, you may wish to re-check your assumptions.&nbsp; Also, i=
f you=20
    wish to zip up your problem binaries and send them to me directly, I wi=
ll do=20
    a quick inspection for you.</SPAN></FONT></FONT></DIV>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN></SPAN></FONT></FONT>&nbsp;</DIV><FONT color=3D#888888>
    <DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff=20
    size=3D2><SPAN>-dave</SPAN></FONT></FONT></DIV></FONT></DIV>
    <DIV>
    <DIV></DIV>
    <DIV class=3Dh5>
    <BLOCKQUOTE=20
    style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: rgb(0,0,255)=
 2px solid; MARGIN-RIGHT: 0px">
      <DIV></DIV>
      <DIV lang=3Den-us dir=3Dltr align=3Dleft><FONT face=3DTahoma size=3D2=
>-----Original=20
      Message-----<BR><B>From:</B> jonathan openvpn [mailto:<A=20
      href=3D"mailto:jonathan.openvpn@...277..."=20
      target=3D_blank>jonathan.openvpn@...277...</A>] <BR><B>Sent:</B> Wedn=
esday,=20
      May 27, 2009 5:36 AM<BR><B>To:</B> <A=20
      href=3D"mailto:openvpn-devel@lists.sourceforge.net"=20
      target=3D_blank>openvpn-devel@lists.sourceforge.net</A><BR><B>Subject=
:</B>=20
      [Openvpn-devel] CE port needed DLLs<BR><BR></FONT></DIV>Hello.<BR><BR=
>I'm=20
      triying to execute a Windows CE 5.0 porting of openvpn client applica=
tion.=20
      I've been successful on compiling it but when i try to execute i rece=
ive=20
      the message: "openvpn is not a valid WindowsCE application".<BR><BR>I=
 am=20
      compiling to ARM-Thumb architecture. I suspect there is a problem wit=
h=20
      needed DLLs.<BR><BR>Could anyone tell me wich DLLs are needed and whe=
re=20
      could i get them?<BR><BR>Thank you very=20
    much.<BR></BLOCKQUOTE></DIV></DIV></DIV></BLOCKQUOTE></DIV><BR></BLOCKQ=
UOTE></BODY></HTML>

------=_NextPart_000_001C_01C9DF6E.2EEE3710--


