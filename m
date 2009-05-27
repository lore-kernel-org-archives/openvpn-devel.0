From: "dave" <dev@...575...>
Date: Wed, 27 May 2009 07:41:21 -0500
Message-ID: <6577A8C6073C4955870B08F7CB09B9FD@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0022_01C9DE9E.87DDD130"
In-Reply-To: <2ece24860905270336r54fb6cb9hfa1578e611d97fb3@...278...>
Subject: Re: [Openvpn-devel] CE port needed DLLs
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

------=_NextPart_000_0022_01C9DE9E.87DDD130
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

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



------=_NextPart_000_0022_01C9DE9E.87DDD130
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.6000.16825" name=3DGENERATOR></HEAD>
<BODY>
<DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>That=20
message usually means the binary is hosed, and I believe missing dlls give =
a=20
different message.</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>Are=20
you sure Thumb is correct for your platform?&nbsp; Are you using a consumer=
=20
device like a pocket pc phone, etc, or is it a custom board?</FONT></SPAN><=
/DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>I ask=20
that because the existing code does use some functionality peculiar to the=
=20
pocket pc (phone) that is not generally available on other platforms, yet t=
he=20
SDKs ofen include the headers and import libs, allowing you to successfully=
=20
compile, but then you can't run it on the target device.</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>When=20
you say 'client application' are you meaning just the gui, or the whole ent=
ire=20
set of programs (i.e., the TAP driver, the openvpn executable, and the=20
gui).</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff si=
ze=3D2>You=20
can use DUMPBIN to find the dlls from the exe, and also inspect the header =
to=20
see the cpu configuration.&nbsp; Here is a short list, if it=20
helps:</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>openvpn:</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>*&nbsp; coredll.dll</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>*&nbsp; w2s.dll</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>*&nbsp; iphlpapi.dll</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>*&nbsp; wininet.dll</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>*&nbsp; ole32.dll</FONT></SPAN></DIV>
<DIV><SPAN class=3D947451512-27052009><FONT face=3DArial color=3D#0000ff=20
size=3D2>*&nbsp; cellcore.dll</FONT></SPAN></DIV>
<DIV><FONT face=3DTahoma><FONT size=3D2><SPAN class=3D947451512-27052009><F=
ONT=20
face=3DArial color=3D#0000ff></FONT></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>tap-ce:</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; ndis.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; coredll.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>ovpncmgr:</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; iphlpapi.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; toolhelp.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; cellcore.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; ole32.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; mfcce300.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; coredll.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT size=3D+0><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=20
class=3D947451512-27052009>*&nbsp; winsock.dll</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009>Your build may (will) differ depending on your=20
platform, because your platform builder may have put some of these features=
 in=20
different dlls.&nbsp; That list was for PocketPC.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009>Now, the cellcore.dll, you may not have on other=
=20
platforms.&nbsp; It is needed for supporting Windows Connectin Manager, and=
 you=20
can surgically cut out that functionality if your platform doesn't have=20
it.&nbsp; Most of the rest is fairly standard.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009>Before doing surgery, you may wish to re-check y=
our=20
assumptions.&nbsp; Also, if you wish to zip up your problem binaries and se=
nd=20
them to me directly, I will do a quick inspection for=20
you.</SPAN></FONT></FONT></DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009></SPAN></FONT></FONT>&nbsp;</DIV>
<DIV><FONT face=3DTahoma><FONT face=3DArial color=3D#0000ff size=3D2><SPAN=
=20
class=3D947451512-27052009>-dave</SPAN></FONT></FONT></DIV></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> jonatha=
n openvpn=20
  [mailto:jonathan.openvpn@...277...] <BR><B>Sent:</B> Wednesday, May 27, 2=
009=20
  5:36 AM<BR><B>To:</B> openvpn-devel@lists.sourceforge.net<BR><B>Subject:<=
/B>=20
  [Openvpn-devel] CE port needed DLLs<BR><BR></FONT></DIV>Hello.<BR><BR>I'm=
=20
  triying to execute a Windows CE 5.0 porting of openvpn client application=
.=20
  I've been successful on compiling it but when i try to execute i receive =
the=20
  message: "openvpn is not a valid WindowsCE application".<BR><BR>I am comp=
iling=20
  to ARM-Thumb architecture. I suspect there is a problem with needed=20
  DLLs.<BR><BR>Could anyone tell me wich DLLs are needed and where could i =
get=20
  them?<BR><BR>Thank you very much.<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_0022_01C9DE9E.87DDD130--


