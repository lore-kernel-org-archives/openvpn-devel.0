From: "Dave" <dev@...575...>
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC
Message-ID: <000001c64c5c$3d772b00$1601a8c0@...576...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0001_01C64C29.F2DCBB00"
In-Reply-To: <20060320173008.49307.qmail@...582...>
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
Date: Mon Mar 20 12:25:01 2006
To: 'Iftikhar Qureshi' <iftikharqureshi@...109...>, openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_0001_01C64C29.F2DCBB00
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

I'll send a package to you later tonight or possibly tomorrow depending on
how other things I'm doing work out.
=20
Good that you have a WM5 device since I don't have one of those to test
with.  Wish I had a smartphone too.  I'd using PPC2003 and SE.
=20
Regarding targeting WM5, I seem to recall that they changed the whole
ActiveSync protocol in WM5 and I wonder if that might be the source of your
troubles.  You definitely should be able to build a PPC2003-targeted app and
have it run on WM5, but I don't know if you'll still run into troubles
connecting to the WM5 device for debugging purposes.  DevStudio 2005 is
supposed to be able to target WM5 specifically, but it is not even slightly
free, alas.
=20
Brief status update:
=20
*  I unit tested all the 'portability' functions I had to implement to get
user-mode to build, so that's out of the way.  I discovered yesterday,
though, that there will be some significant work to do in two places:  the
tun.c which is the interface to the driver, which I expected, but also all
of the stuff in socket.c will have to be visited as well.  I didn't expect
that, but all the socket IO is using overlapped IO also, which we don't have
in CE.  I'm hoping that we can deal with this by making an implementation
that is more patterned after the unix socket io, which of course definitely
is not 'overlapped' and then just accomodate the few BSD-WSA discrepancies.
=20
Since I have been hacking on the code a bit to get it to compile, I am going
to send you:
=20
*  the libs and headers for the openssl and lzo like we talked about
*  a zip of my source tree with modifications I have made thus far
*  a brief description of non-obvious configuration; e.g. I have my 3rd
party libs in a location relative to my projects that gets picked up via
settings in the eVC project
=20
I have marked all the spots I have hacked-on with the comment //HHH for ease
of searching.  You're free of course also to use diff.
=20
Talk to you later; you're help will be greatly appreciated!
=20
-Dave

-----Original Message-----
From: Iftikhar Qureshi [mailto:iftikharqureshi@...109...]=20
Sent: Monday, March 20, 2006 11:30 AM
To: Dave; openvpn-devel@lists.sourceforge.net
Subject: RE: [Openvpn-devel] OpenVPN for PocketPC


Please do send the binaries/headers. I'll start testing and will give you an
update. You may send it to my email id.
=20
I'm having a bit of difficulity making eVC4 target my WM5.0 device - so
still working on that.
=20
Salamz,
-IQ

Dave <dev@...575...> wrote:

Well, a lot of the discovery work at least. Currently I'm testing the
routines I added for porting the user-mode stuff. I've tested most of
those.

Also, if it's useful, I can send you prebuilt binaries and headers for the
openssl and lzo. That way at least you don't have to mess with that. Or
you might wish to build them anyway as a sanity check on your setup.

-Dave





------=_NextPart_000_0001_01C64C29.F2DCBB00
Content-Type: text/html; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; charset=3Dus-ascii">
<TITLE>Message</TITLE>

<META content=3D"MSHTML 6.00.2900.2802" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>I'll send a package to you later tonight or possibly tomorrow depe=
nding=20
on how other things I'm doing work out.</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Good that you have a WM5 device since I don't have one of those to=
 test=20
with.&nbsp; Wish I had a smartphone too.&nbsp; I'd using PPC2003 and=20
SE.</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Regarding targeting WM5, I seem to recall that they changed the wh=
ole=20
ActiveSync protocol in WM5 and I wonder if that might be the source of your=
=20
troubles.&nbsp; You definitely should be able to build a PPC2003-targeted a=
pp=20
and have it run on WM5, but I don't know if you'll still run into troubles=
=20
connecting to the WM5 device for debugging purposes.&nbsp; DevStudio 2005 i=
s=20
supposed to be able to target WM5 specifically, but it is not even slightly=
=20
free, alas.</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Brief status update:</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; I unit tested all the 'portability' functions I had to imp=
lement=20
to get user-mode to build, so that's out of the way.&nbsp; I discovered=20
yesterday, though, that there will be some significant work to do in two=20
places:&nbsp; the tun.c which is the interface to the driver, which I expec=
ted,=20
but also all of the stuff in socket.c will have to be visited as well.&nbsp=
; I=20
didn't expect that, but all the socket IO is using overlapped IO also, whic=
h we=20
don't have in CE.&nbsp; I'm hoping that we can deal with this by making an=
=20
implementation that is more patterned after the unix socket io, which of co=
urse=20
definitely is not 'overlapped' and then&nbsp;just accomodate&nbsp;the few=20
BSD-WSA discrepancies.</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Since I have been hacking on the code a bit to get it to compile, =
I am=20
going to send you:</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; the libs and headers for the openssl and lzo like we talke=
d=20
about</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; a zip of my source tree with modifications I have made thu=
s=20
far</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>*&nbsp; a brief description of non-obvious configuration; e.g. I h=
ave my=20
3rd party libs in a location relative to my projects that gets picked up vi=
a=20
settings in the eVC project</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>I have marked all the spots I have hacked-on with the comment //HH=
H for=20
ease of searching.&nbsp; You're free of course also to use=20
diff.</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>Talk to you later; you're help will be greatly=20
appreciated!</FONT></SPAN></DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D428520820-20032006><FONT face=3D"Courier New" color=3D#0=
000ff=20
size=3D2>-Dave</FONT></SPAN></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #0000ff 2px soli=
d; MARGIN-RIGHT: 0px">
  <DIV></DIV>
  <DIV class=3DOutlookMessageHeader lang=3Den-us dir=3Dltr align=3Dleft><FO=
NT=20
  face=3DTahoma size=3D2>-----Original Message-----<BR><B>From:</B> Iftikha=
r Qureshi=20
  [mailto:iftikharqureshi@...109...] <BR><B>Sent:</B> Monday, March 20, 200=
6=20
  11:30 AM<BR><B>To:</B> Dave;=20
  openvpn-devel@lists.sourceforge.net<BR><B>Subject:</B> RE: [Openvpn-devel=
]=20
  OpenVPN for PocketPC<BR><BR></FONT></DIV>
  <DIV>Please do send the binaries/headers. I'll start testing and will giv=
e you=20
  an update. You may send it to my email id.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>I'm having a bit of difficulity making eVC4 target my WM5.0 device -=
 so=20
  still working on that.</DIV>
  <DIV>&nbsp;</DIV>
  <DIV>Salamz,</DIV>
  <DIV>-IQ<BR><BR><B><I>Dave &lt;dev@...575...&gt;</I></B> wrote:</DIV>
  <BLOCKQUOTE class=3Dreplbq=20
  style=3D"PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LEFT: #1010ff 2px so=
lid">Well,=20
    a lot of the discovery work at least. Currently I'm testing the<BR>rout=
ines=20
    I added for porting the user-mode stuff. I've tested most=20
    of<BR>those.<BR><BR>Also, if it's useful, I can send you prebuilt binar=
ies=20
    and headers for the<BR>openssl and lzo. That way at least you don't hav=
e to=20
    mess with that. Or<BR>you might wish to build them anyway as a sanity c=
heck=20
    on your setup.<BR><BR>-Dave<BR><BR></BLOCKQUOTE><BR></BLOCKQUOTE></BODY=
></HTML>

------=_NextPart_000_0001_01C64C29.F2DCBB00--


