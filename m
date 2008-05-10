Message-ID: <109201c8b2e4$a08816a0$0202fea9@...1094...>
From: "Bonno Bloksma" <b.bloksma@...1093...>
References: <0f4501c8b271$3b877200$0202fea9@...1094...>
	<9e0cf0bf0805100051md5fcd4au6f032a85c6a87cbe@...278...>
Date: Sat, 10 May 2008 23:27:19 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_108F_01C8B2F5.63F1ECF0"
Subject: Re: [Openvpn-devel] SIGHUP SIGUSR1 new logfile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Alon Bar-Lev <alon.barlev@...277...>
Cc: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_108F_01C8B2F5.63F1ECF0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello,

I might look into the syslog way to seperate the openvpn log messages.
That leaves the unwanted effect of killing the connection when doing a relo=
ad. Is that a know bug or something specific to my situation?



Met vriendelijke groet,
Bonno Bloksma
hoofd systeembeheer



tio hogeschool hospitality en toerisme=20
begijnenhof 8-12 / 5611 el eindhoven
t 040 296 28 28 / f 040 237 35 20
b.bloksma@...1093...  / www.tio.nl=20
  ----- Original Message -----=20
  From: Alon Bar-Lev=20
  To: Bonno Bloksma=20
  Cc: openvpn-devel@lists.sourceforge.net=20
  Sent: Saturday, May 10, 2008 9:51 AM
  Subject: Re: [Openvpn-devel] SIGHUP SIGUSR1 new logfile


  SIGUSR1 is used for other stuff in openvpn.

  Why don't you use syslog, catch the openvpn related messages and place
  them in separate file? It is much simpler and can be managed in
  greater flexibility.

  Alon.

  On 5/10/08, Bonno Bloksma <b.bloksma@...1093...> wrote:
  >
  >
  > Hi,
  >
  >
  >
  > I wanted to implement a weekly logfile rotation for the openvpn logfile=
 and
  > noticed that it did not work, openvpn kept writing to the old logfile.
  >
  > If I did a manual mv openvpn.log openvpn.1 openvpn would still write to=
 the
  > same file, now called openvpn.1, and not start a new openvpn.log. Only =
after
  > restarting openvpn dit it start a new openvpn.log file.
  > What is the correct way to keep openvpn up and running but have it start
  > using the new logfile?
  >
  > The logrotate program has a workaround by using the copytruncate option=
 but
  > that is more of a stopgap sollution for dumb programs, of which I'm sure
  > openvpn is not one.
  > The logrotate program can send a SIGHUP, SIGUSR1, etc after the rotatio=
n to
  > tell the program the logfile has been rotated.
  >
  > The openvpn script in the init.d/ folder has options like reload and re=
open
  > which correspondent to SIGHUP, SIGUSR1 and might do what I want but....=
 so
  > far it seems not. After both reload and reopen the old logfile is still
  > being used.
  > Besides that....
  >
  > Testing with 2.0.9-1 on a Redhat 9 machine I found out that trying to d=
o a
  > reload would produce several errors, one about opening the key file, an=
d I
  > would loose the vpn connection.
  > Sat May 10 08:58:44 2008 us=3D750706 TCP/UDP: Closing socket
  > Sat May 10 08:58:44 2008 us=3D750822 /sbin/ip route del 172.16.1.64/26
  > RTNETLINK answers: Operation not permitted
  > Sat May 10 08:58:44 2008 us=3D755306 ERROR: Linux route delete command =
failed:
  > shell command exited with error status: 2
  > [.....]
  > Sat May 10 08:58:44 2008 us=3D865438 OpenVPN 2.0.9 i386-redhat-linux-gn=
u [SSL]
  > [LZO] [EPOLL] built on Feb  2 2007
  > Sat May 10 08:58:44 2008 us=3D865545 Restart pause, 2 second(s)
  > Sat May 10 08:58:46 2008 us=3D866570 IMPORTANT: OpenVPN's default port =
number
  > is now 1194, based on an official port number assignment by IANA.  Open=
VPN
  > 2.0-beta16 and earlier used 5000 as the default port.
  > Sat May 10 08:58:46 2008 us=3D867202 Cannot load private key file
  > bonnothuis.key: error:0200100D:system library:fopen:Permission denied:
  > error:20074002:BIO routines:FILE_CTRL:system lib: error:140B0002:S
  > SL routines:SSL_CTX_use_PrivateKey_file:system lib
  > Sat May 10 08:58:46 2008 us=3D867316 Error: private key password verifi=
cation
  > failed
  > Sat May 10 08:58:46 2008 us=3D867342 Exiting
  > Is this a known error, maybe connected to the nobody options, or should=
 I do
  > some testing with the new 2.1 version?
  >
  >
  > Is the issue with the logfile rotation dealt with in the 2.1 release? If
  > not, will it be in a next rc? Do I need to help testing some things?
  > I am NOT a C programmer, at least not anymore. My programming skills ar=
e old
  > and were in several other languages like Pascal, Forth, etc. :-)
  >
  > p.s. In my production environment I will be using Openvpn mainly on Deb=
ian
  > etch, so for that I would still be using the 2.0.9 release for a while.=
 But
  > at home I'd like to use the newer version to see if openvpn 2.1 does wo=
rk as
  > it should.
  >
  > Groetjes,
  > Bonno Bloksma
  >
  > -----------------------------------------------------------------------=
--
  >  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
  >  Don't miss this year's exciting event. There's still time to save $100.
  >  Use priority code J8TL2D2.
  > http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/=
javaone
  > _______________________________________________
  >  Openvpn-devel mailing list
  >  Openvpn-devel@lists.sourceforge.net
  >  https://lists.sourceforge.net/lists/listinfo/openvpn-devel
  >
  >

------=_NextPart_000_108F_01C8B2F5.63F1ECF0
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I might look into the syslog way to sepera=
te the=20
openvpn log messages.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>That leaves the unwanted effect of killing=
 the=20
connection when doing a reload. Is that a know bug or something specific to=
 my=20
situation?</FONT></DIV>
<DIV><BR><BR>
<DIV><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">
<DIV style=3D"COLOR: #66b821">Met vriendelijke groet,<BR><!-- Hier de naam =
aanpassen -->Bonno Bloksma<BR><!-- en hier de functie -->hoofd systeembehee=
r<BR></DIV><BR>
<DIV style=3D"COLOR: #0189b4">tio hogeschool hospitality en toerisme </DIV>
<DIV style=3D"COLOR: #0189b4">begijnenhof 8-12 / 5611 el eindhoven<BR>t 040=
 296 28=20
28 / f 040 237 35 20<BR><!-- Hieronder 2x het email adres (r.naam@...493...=
)aanpassen --><!-- *na* de mailto: en voor de quote, daaronder nog een keer=
 --><A=20
href=3D"mailto:b.bloksma@...1093..."><FONT=20
color=3D#66b821>b.bloksma@...1093...</FONT></A>&nbsp; / <A=20
href=3D"http://www.tio.nl"><FONT color=3D#66b821>www.tio.nl</FONT></A>=20
</DIV></SPAN></DIV></DIV>
<BLOCKQUOTE=20
style=3D"PADDING-RIGHT: 0px; PADDING-LEFT: 5px; MARGIN-LEFT: 5px; BORDER-LE=
FT: #000000 2px solid; MARGIN-RIGHT: 0px">
  <DIV style=3D"FONT: 10pt arial">----- Original Message ----- </DIV>
  <DIV=20
  style=3D"BACKGROUND: #e4e4e4; FONT: 10pt arial; font-color: black"><B>Fro=
m:</B>=20
  <A title=3Dalon.barlev@...277... href=3D"mailto:alon.barlev@...277...">Al=
on=20
  Bar-Lev</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>To:</B> <A title=3Db.bloksma@...1095...=
.=20
  href=3D"mailto:b.bloksma@...1093...">Bonno Bloksma</A> </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Cc:</B> <A=20
  title=3Dopenvpn-devel@lists.sourceforge.net=20
  href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1096...=
ourceforge.net</A>=20
  </DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Saturday, May 10, 2008 9:51=
=20
AM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [Openvpn-devel] SIGHU=
P=20
  SIGUSR1 new logfile</DIV>
  <DIV><BR></DIV>SIGUSR1 is used for other stuff in openvpn.<BR><BR>Why don=
't=20
  you use syslog, catch the openvpn related messages and place<BR>them in=20
  separate file? It is much simpler and can be managed in<BR>greater=20
  flexibility.<BR><BR>Alon.<BR><BR>On 5/10/08, Bonno Bloksma &lt;<A=20
  href=3D"mailto:b.bloksma@...1093...">b.bloksma@...1093...</A>&gt;=20
  wrote:<BR>&gt;<BR>&gt;<BR>&gt; Hi,<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; I want=
ed to=20
  implement a weekly logfile rotation for the openvpn logfile and<BR>&gt;=20
  noticed that it did not work, openvpn kept writing to the old=20
  logfile.<BR>&gt;<BR>&gt; If I did a manual mv openvpn.log openvpn.1 openv=
pn=20
  would still write to the<BR>&gt; same file, now called openvpn.1, and not=
=20
  start a new openvpn.log. Only after<BR>&gt; restarting openvpn dit it sta=
rt a=20
  new openvpn.log file.<BR>&gt; What is the correct way to keep openvpn up =
and=20
  running but have it start<BR>&gt; using the new logfile?<BR>&gt;<BR>&gt; =
The=20
  logrotate program has a workaround by using the copytruncate option=20
  but<BR>&gt; that is more of a stopgap sollution for dumb programs, of whi=
ch=20
  I'm sure<BR>&gt; openvpn is not one.<BR>&gt; The logrotate program can se=
nd a=20
  SIGHUP, SIGUSR1, etc after the rotation to<BR>&gt; tell the program the=20
  logfile has been rotated.<BR>&gt;<BR>&gt; The openvpn script in the init.=
d/=20
  folder has options like reload and reopen<BR>&gt; which correspondent to=
=20
  SIGHUP, SIGUSR1 and might do what I want but.... so<BR>&gt; far it seems =
not.=20
  After both reload and reopen the old logfile is still<BR>&gt; being=20
  used.<BR>&gt; Besides that....<BR>&gt;<BR>&gt; Testing with 2.0.9-1 on a=
=20
  Redhat 9 machine I found out that trying to do a<BR>&gt; reload would pro=
duce=20
  several errors, one about opening the key file, and I<BR>&gt; would loose=
 the=20
  vpn connection.<BR>&gt; Sat May 10 08:58:44 2008 us=3D750706 TCP/UDP: Clo=
sing=20
  socket<BR>&gt; Sat May 10 08:58:44 2008 us=3D750822 /sbin/ip route del=20
  172.16.1.64/26<BR>&gt; RTNETLINK answers: Operation not permitted<BR>&gt;=
 Sat=20
  May 10 08:58:44 2008 us=3D755306 ERROR: Linux route delete command=20
  failed:<BR>&gt; shell command exited with error status: 2<BR>&gt;=20
  [.....]<BR>&gt; Sat May 10 08:58:44 2008 us=3D865438 OpenVPN 2.0.9=20
  i386-redhat-linux-gnu [SSL]<BR>&gt; [LZO] [EPOLL] built on Feb&nbsp; 2=20
  2007<BR>&gt; Sat May 10 08:58:44 2008 us=3D865545 Restart pause, 2=20
  second(s)<BR>&gt; Sat May 10 08:58:46 2008 us=3D866570 IMPORTANT: OpenVPN=
's=20
  default port number<BR>&gt; is now 1194, based on an official port number=
=20
  assignment by IANA.&nbsp; OpenVPN<BR>&gt; 2.0-beta16 and earlier used 500=
0 as=20
  the default port.<BR>&gt; Sat May 10 08:58:46 2008 us=3D867202 Cannot loa=
d=20
  private key file<BR>&gt; bonnothuis.key: error:0200100D:system=20
  library:fopen:Permission denied:<BR>&gt; error:20074002:BIO=20
  routines:FILE_CTRL:system lib: error:140B0002:S<BR>&gt; SL=20
  routines:SSL_CTX_use_PrivateKey_file:system lib<BR>&gt; Sat May 10 08:58:=
46=20
  2008 us=3D867316 Error: private key password verification<BR>&gt; failed<=
BR>&gt;=20
  Sat May 10 08:58:46 2008 us=3D867342 Exiting<BR>&gt; Is this a known erro=
r,=20
  maybe connected to the nobody options, or should I do<BR>&gt; some testin=
g=20
  with the new 2.1 version?<BR>&gt;<BR>&gt;<BR>&gt; Is the issue with the=20
  logfile rotation dealt with in the 2.1 release? If<BR>&gt; not, will it b=
e in=20
  a next rc? Do I need to help testing some things?<BR>&gt; I am NOT a C=20
  programmer, at least not anymore. My programming skills are old<BR>&gt; a=
nd=20
  were in several other languages like Pascal, Forth, etc. :-)<BR>&gt;<BR>&=
gt;=20
  p.s. In my production environment I will be using Openvpn mainly on=20
  Debian<BR>&gt; etch, so for that I would still be using the 2.0.9 release=
 for=20
  a while. But<BR>&gt; at home I'd like to use the newer version to see if=
=20
  openvpn 2.1 does work as<BR>&gt; it should.<BR>&gt;<BR>&gt; Groetjes,<BR>=
&gt;=20
  Bonno Bloksma<BR>&gt;<BR>&gt;=20
  -------------------------------------------------------------------------=
<BR>&gt;&nbsp;=20
  This SF.net email is sponsored by the 2008 JavaOne(SM)=20
  Conference<BR>&gt;&nbsp; Don't miss this year's exciting event. There's s=
till=20
  time to save $100.<BR>&gt;&nbsp; Use priority code J8TL2D2.<BR>&gt; <A=20
  href=3D"http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.su=
n.com/javaone">http://ad.doubleclick.net/clk;198757673;13503038;p?http://ja=
va.sun.com/javaone</A><BR>&gt;=20
  _______________________________________________<BR>&gt;&nbsp; Openvpn-dev=
el=20
  mailing list<BR>&gt;&nbsp; <A=20
  href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1096...=
ourceforge.net</A><BR>&gt;&nbsp;=20
  <A=20
  href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https=
://lists.sourceforge.net/lists/listinfo/openvpn-devel</A><BR>&gt;<BR>&gt;<B=
R></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_108F_01C8B2F5.63F1ECF0--


