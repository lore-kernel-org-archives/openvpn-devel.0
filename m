From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] PocketPC - Compile Error
Message-ID: <000001c65023$94484700$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C64FF1.49ADD700"
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
Date: Sat Mar 25 07:51:00 2006
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C64FF1.49ADD700
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

-----Original Message-----
From: openvpn-devel-admin@lists.sourceforge.net
[mailto:openvpn-devel-admin@lists.sourceforge.net] On Behalf Of Iftikhar
Qureshi
Sent: Friday, March 24, 2006 2:42 PM
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] PocketPC - Compile Error
Dave:

I tried to Rebuild and getting an error.
 ...
=20
OK, I found the dependency and eliminated it.  It was just a couple ioctl()
code definitions for loading and unloading the NDIS driver that were needed.
That project should build fine now without the Platform Builder installed.
Also, I checked that the same was true of the main openvpn project, and it
is.  The driver currently still required some headers from the Platform
Builder.  I included pre-built binaries of the driver in all configurations.
=20
-Dave

------=_NextPart_000_0001_01C64FF1.49ADD700
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B=
>=20
openvpn-devel-admin@lists.sourceforge.net=20
[mailto:openvpn-devel-admin@lists.sourceforge.net] <B>On Behalf Of </B>Ifti=
khar=20
Qureshi<BR><B>Sent:</B> Friday, March 24, 2006 2:42 PM<BR><B>To:</B>=20
openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> [Openvpn-devel] Pock=
etPC=20
- Compile Error<BR></FONT>Dave:<BR><BR>I tried to Rebuild and getting an=20
error.<BR><SPAN class=3D473344315-25032006><FONT face=3D"Courier New" color=
=3D#0000ff=20
size=3D2>&nbsp;...</FONT></SPAN></DIV>
<DIV><SPAN class=3D473344315-25032006></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D473344315-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>OK, I found the dependency and eliminated it.&nbsp; It was just a =
couple=20
ioctl() code definitions for loading and unloading the NDIS driver that wer=
e=20
needed.&nbsp; </FONT></SPAN><SPAN class=3D473344315-25032006><FONT=20
face=3D"Courier New" color=3D#0000ff size=3D2>That project should build fin=
e now=20
without the Platform Builder installed.&nbsp; Also, I checked that the same=
 was=20
true of&nbsp;the main openvpn project, and it is.&nbsp; The driver currentl=
y=20
still required some headers from the Platform Builder.&nbsp; I=20
included&nbsp;pre-built binaries of the driver in all=20
configurations.</FONT></SPAN></DIV>
<DIV><SPAN class=3D473344315-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D473344315-25032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>-Dave</FONT></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0001_01C64FF1.49ADD700--


