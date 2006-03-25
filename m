From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] PocketPC - Compile Error
Message-ID: <000001c6501c$ad0acb70$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C64FEA.62705B70"
In-Reply-To: <20060324204215.11097.qmail@...589...>
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sat Mar 25 07:02:02 2006
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C64FEA.62705B70
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: openvpn-devel-admin@lists.sourceforge.net
[mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Iftikhar
Qureshi
Sent: Friday, March 24, 2006 2:42 PM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] PocketPC - Compile Error
 ...=20
c:\program files\windows ce tools\wce420\pocket pc
2003\include\armv4\ntcompat.h(1236) : fatal error C1083: Cannot open include
file: 'lss.h': No such file or directory
 ...=20
=20
Iftikhar,
=20
I took a peek and that file lss.h is part of the 'Platform Builder'.
Actually, I don't know what hoisted it into that project.  Parts of the
platform builder are needed for the TAP driver, but it shouldn't be needed
at all for any of the user-mode parts.  I'll try and see if I can find where
the dependency came in, and how to remove it.
=20
-Dave

------=_NextPart_000_0001_01C64FEA.62705B70
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT size=3D2><FONT face=3DTahoma>-----Original Message-----<BR><B>Fr=
om:</B>=20
openvpn-devel-admin@lists.sourceforge.net=20
[mailto:openvpn-devel-admin@lists.sourceforge.net] <B>On Behalf Of </B>Ifti=
khar=20
Qureshi<BR><B>Sent:</B> Friday, March 24, 2006 2:42 PM<BR><B>To:</B>=20
openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> [Openvpn-devel] Pock=
etPC=20
- Compile Error<BR></FONT><SPAN class=3D114065414-25032006><FONT=20
face=3D"Courier New"=20
color=3D#0000ff>&nbsp;...&nbsp;</FONT></SPAN></FONT><BR>c:\program files\wi=
ndows=20
ce tools\wce420\pocket pc 2003\include\armv4\ntcompat.h(1236) : fatal error=
=20
C1083: Cannot open include file: 'lss.h': No such file or directory<BR><SPA=
N=20
class=3D114065414-25032006><FONT face=3D"Courier New" color=3D#0000ff=20
size=3D2>&nbsp;...&nbsp;</FONT></SPAN><BR><SPAN class=3D114065414-25032006>=
<FONT=20
face=3D"Courier New" color=3D#0000ff size=3D2>&nbsp;</FONT></SPAN></DIV>
<DIV><SPAN class=3D114065414-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Iftikhar,</FONT></SPAN></DIV>
<DIV><SPAN class=3D114065414-25032006></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D114065414-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>I took a peek and that file&nbsp;lss.h is part of the 'Platform=20
Builder'.&nbsp; Actually, I don't know what hoisted it into that project.&n=
bsp;=20
Parts of the platform builder are needed for the TAP driver, but it=20
<EM>shouldn't</EM> be needed at all for any of the user-mode parts.&nbsp; I=
'll=20
try and see if I can find where the dependency came in, and how to remove=20
it.</FONT></SPAN></DIV>
<DIV><SPAN class=3D114065414-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D114065414-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>-Dave</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0001_01C64FEA.62705B70--


