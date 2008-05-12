Message-ID: <111801c8b40a$16fd49b0$0202fea9@...1094...>
From: "Bonno Bloksma" <b.bloksma@...1093...>
References: <0f4501c8b271$3b877200$0202fea9@...1094...>
	<9e0cf0bf0805100051md5fcd4au6f032a85c6a87cbe@...278...>
	<109201c8b2e4$a08816a0$0202fea9@...1094...>
	<9e0cf0bf0805101429y588943ecj15432578d73391c7@...278...>
Date: Mon, 12 May 2008 10:28:00 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_1115_01C8B41A.DA5DAA20"
Subject: Re: [Openvpn-devel] SIGHUP SIGUSR1 new logfile
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.

------=_NextPart_000_1115_01C8B41A.DA5DAA20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Alon,

What dou you mean by:
> This is what SIGUSR1 is for.

If you mean SIGUSR1 is for reopen, I knew that. If you mean SIGUSR1 is fol =
solving the problem I had after a reload... no that does not work. After a =
failed reload there is no running openvpn session anymore, the reopen comma=
nd does not work.

Did some more testing with 2.0.9 on my system. It's the "user nobody" line =
in the client.conf file that's the cause for the failure to open the keyfil=
e after a reload. The "group nobody" does not affect this behaviour.
Files are:
-r--r--r--  1 root root  3471 Mar  6  2007 bonnothuis.crt
-r--r--r--  1 root root   729 Mar  6  2007 bonnothuis.csr
-r--------  1 root root   887 Mar  6  2007 bonnothuis.key
-r--r--r--  1 root root  1212 Mar  6  2007 ca.crt
-rw-r--r--  1 root root   245 May 12 10:14 client.conf

It seems that openvpn running as nobody is not allowed to do several things=
, among them to open the key file, when doing a reload.

I only have an old RedHat 9 system here currently for testing, not sure I c=
an get 2.1rc7 on that as it also has no gcc. So, if the problem I'm describ=
ing is unknow to the developers yet and you want me to do some more testing=
 let me know. I'll have to rebuild my testbed machine first though to a lat=
er Linux version, probabbly Debian lenny or unstable.
Please let me know.




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
  Sent: Saturday, May 10, 2008 11:29 PM
  Subject: Re: [Openvpn-devel] SIGHUP SIGUSR1 new logfile


  This is what SIGUSR1 is for.

  On 5/11/08, Bonno Bloksma <b.bloksma@...1093...> wrote:
  >
  >
  > Hello,
  >
  > I might look into the syslog way to seperate the openvpn log messages.
  > That leaves the unwanted effect of killing the connection when doing a
  > reload. Is that a know bug or something specific to my situation?
  >
  >
  >
  >
  > Met vriendelijke groet,
  > Bonno Bloksma
  > hoofd systeembeheer
  >
  >
  > tio hogeschool hospitality en toerisme
  > begijnenhof 8-12 / 5611 el eindhoven
  > t 040 296 28 28 / f 040 237 35 20
  > b.bloksma@...1093...  / www.tio.nl
  >
  >
  > ----- Original Message -----
  > From: Alon Bar-Lev
  > To: Bonno Bloksma
  > Cc: openvpn-devel@lists.sourceforge.net
  >
  > Sent: Saturday, May 10, 2008 9:51 AM
  > Subject: Re: [Openvpn-devel] SIGHUP SIGUSR1 new logfile
  >
  > SIGUSR1 is used for other stuff in openvpn.
  >
  > Why don't you use syslog, catch the openvpn related messages and place
  > them in separate file? It is much simpler and can be managed in
  > greater flexibility.
  >
  > Alon.
  >
  > On 5/10/08, Bonno Bloksma <b.bloksma@...1093...> wrote:
  > >
  > >
  > > Hi,
  > >
  > >
  > >
  > > I wanted to implement a weekly logfile rotation for the openvpn logfi=
le
  > and
  > > noticed that it did not work, openvpn kept writing to the old logfile.
  > >
  > > If I did a manual mv openvpn.log openvpn.1 openvpn would still write =
to
  > the
  > > same file, now called openvpn.1, and not start a new openvpn.log. Only
  > after
  > > restarting openvpn dit it start a new openvpn.log file.
  > > What is the correct way to keep openvpn up and running but have it st=
art
  > > using the new logfile?
  > >
  > > The logrotate program has a workaround by using the copytruncate opti=
on
  > but
  > > that is more of a stopgap sollution for dumb programs, of which I'm s=
ure
  > > openvpn is not one.
  > > The logrotate program can send a SIGHUP, SIGUSR1, etc after the rotat=
ion
  > to
  > > tell the program the logfile has been rotated.
  > >
  > > The openvpn script in the init.d/ folder has options like reload and
  > reopen
  > > which correspondent to SIGHUP, SIGUSR1 and might do what I want but..=
.. so
  > > far it seems not. After both reload and reopen the old logfile is sti=
ll
  > > being used.
  > > Besides that....
  > >
  > > Testing with 2.0.9-1 on a Redhat 9 machine I found out that trying to=
 do a
  > > reload would produce several errors, one about opening the key file, =
and I
  > > would loose the vpn connection.
  > > Sat May 10 08:58:44 2008 us=3D750706 TCP/UDP: Closing socket
  > > Sat May 10 08:58:44 2008 us=3D750822 /sbin/ip route del 172.16.1.64/26
  > > RTNETLINK answers: Operation not permitted
  > > Sat May 10 08:58:44 2008 us=3D755306 ERROR: Linux route delete command
  > failed:
  > > shell command exited with error status: 2
  > > [.....]
  > > Sat May 10 08:58:44 2008 us=3D865438 OpenVPN 2.0.9 i386-redhat-linux-=
gnu
  > [SSL]
  > > [LZO] [EPOLL] built on Feb  2 2007
  > > Sat May 10 08:58:44 2008 us=3D865545 Restart pause, 2 second(s)
  > > Sat May 10 08:58:46 2008 us=3D866570 IMPORTANT: OpenVPN's default port
  > number
  > > is now 1194, based on an official port number assignment by IANA.  Op=
enVPN
  > > 2.0-beta16 and earlier used 5000 as the default port.
  > > Sat May 10 08:58:46 2008 us=3D867202 Cannot load private key file
  > > bonnothuis.key: error:0200100D:system library:fopen:Permission denied:
  > > error:20074002:BIO routines:FILE_CTRL:system lib: error:140B0002:S
  > > SL routines:SSL_CTX_use_PrivateKey_file:system lib
  > > Sat May 10 08:58:46 2008 us=3D867316 Error: private key password
  > verification
  > > failed
  > > Sat May 10 08:58:46 2008 us=3D867342 Exiting
  > > Is this a known error, maybe connected to the nobody options, or shou=
ld I
  > do
  > > some testing with the new 2.1 version?
  > >
  > >
  > > Is the issue with the logfile rotation dealt with in the 2.1 release?=
 If
  > > not, will it be in a next rc? Do I need to help testing some things?
  > > I am NOT a C programmer, at least not anymore. My programming skills =
are
  > old
  > > and were in several other languages like Pascal, Forth, etc. :-)
  > >
  > > p.s. In my production environment I will be using Openvpn mainly on D=
ebian
  > > etch, so for that I would still be using the 2.0.9 release for a whil=
e.
  > But
  > > at home I'd like to use the newer version to see if openvpn 2.1 does =
work
  > as
  > > it should.
  > >
  > > Groetjes,
  > > Bonno Bloksma
  > >
  > >
  > -----------------------------------------------------------------------=
--
  > >  This SF.net email is sponsored by the 2008 JavaOne(SM) Conference
  > >  Don't miss this year's exciting event. There's still time to save $1=
00.
  > >  Use priority code J8TL2D2.
  > >
  > http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/=
javaone
  > > _______________________________________________
  > >  Openvpn-devel mailing list
  > >  Openvpn-devel@lists.sourceforge.net
  > >
  > https://lists.sourceforge.net/lists/listinfo/openvpn-devel
  > >
  > >
  >

------=_NextPart_000_1115_01C8B41A.DA5DAA20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=EF=BB=BF<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dutf-8">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hello Alon,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>What dou you mean by:</FONT></DIV>
<DIV>&gt; This is what SIGUSR1 is for.</DIV>
<DIV><FONT face=3DArial size=3D2></FONT><FONT face=3DArial size=3D2></FONT>=
&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>If you mean SIGUSR1 is for reopen, I knew =
that. If=20
you mean SIGUSR1 is fol solving the problem I had after a reload... no that=
 does=20
not work. After a failed reload there is no running openvpn session anymore=
, the=20
reopen command does not work.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>Did some more testing with 2.0.9 on my sys=
tem. It's=20
the "user nobody"&nbsp;line in the client.conf file that's the cause for th=
e=20
failure to open the keyfile after a reload. The "group nobody" does not aff=
ect=20
this behaviour.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Files are:</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>-r--r--r--&nbsp; 1 root root&nbsp; 3471 Ma=
r&nbsp;=20
6&nbsp; 2007 bonnothuis.crt<BR>-r--r--r--&nbsp; 1 root root&nbsp;&nbsp; 729=
=20
Mar&nbsp; 6&nbsp; 2007 bonnothuis.csr<BR>-r--------&nbsp; 1 root=20
root&nbsp;&nbsp; 887 Mar&nbsp; 6&nbsp; 2007 bonnothuis.key<BR>-r--r--r--&nb=
sp; 1=20
root root&nbsp; 1212 Mar&nbsp; 6&nbsp; 2007 ca.crt<BR>-rw-r--r--&nbsp; 1 ro=
ot=20
root&nbsp;&nbsp; 245 May 12 10:14 client.conf<BR></FONT></DIV>
<DIV><FONT face=3DArial size=3D2>It seems that openvpn running as nobody is=
 not=20
allowed to do several things, among them to open the key file, when doing a=
=20
reload.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2>I only have an old RedHat 9 system here cu=
rrently=20
for testing, not sure I can get 2.1rc7 on that as it also has no gcc. So, i=
f the=20
problem I'm describing is unknow to the developers yet and you want me to d=
o=20
some more testing let me know. I'll have to rebuild my testbed machine firs=
t=20
though to a later Linux version, probabbly Debian lenny or=20
unstable.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2>Please let me know.</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV><BR><BR></DIV>
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
</DIV></SPAN></DIV>
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
  <DIV style=3D"FONT: 10pt arial"><B>Sent:</B> Saturday, May 10, 2008 11:29=
=20
  PM</DIV>
  <DIV style=3D"FONT: 10pt arial"><B>Subject:</B> Re: [Openvpn-devel] SIGHU=
P=20
  SIGUSR1 new logfile</DIV>
  <DIV><BR></DIV>This is what SIGUSR1 is for.<BR><BR>On 5/11/08, Bonno Blok=
sma=20
  &lt;<A href=3D"mailto:b.bloksma@...1093...">b.bloksma@...1093...</A>&gt;=
=20
  wrote:<BR>&gt;<BR>&gt;<BR>&gt; Hello,<BR>&gt;<BR>&gt; I might look into t=
he=20
  syslog way to seperate the openvpn log messages.<BR>&gt; That leaves the=
=20
  unwanted effect of killing the connection when doing a<BR>&gt; reload. Is=
 that=20
  a know bug or something specific to my=20
  situation?<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt;<BR>&gt; Met vriendelijke=20
  groet,<BR>&gt; Bonno Bloksma<BR>&gt; hoofd=20
  systeembeheer<BR>&gt;<BR>&gt;<BR>&gt; tio hogeschool hospitality en=20
  toerisme<BR>&gt; begijnenhof 8-12 / 5611 el eindhoven<BR>&gt; t 040 296 2=
8 28=20
  / f 040 237 35 20<BR>&gt; <A=20
  href=3D"mailto:b.bloksma@...1093...">b.bloksma@...1093...</A>&nbsp; / <A=
=20
  href=3D"http://www.tio.nl">www.tio.nl</A><BR>&gt;<BR>&gt;<BR>&gt; ----- O=
riginal=20
  Message -----<BR>&gt; From: Alon Bar-Lev<BR>&gt; To: Bonno Bloksma<BR>&gt=
; Cc:=20
  <A=20
  href=3D"mailto:openvpn-devel@lists.sourceforge.net">openvpn-devel@...1096...=
ourceforge.net</A><BR>&gt;<BR>&gt;=20
  Sent: Saturday, May 10, 2008 9:51 AM<BR>&gt; Subject: Re: [Openvpn-devel]=
=20
  SIGHUP SIGUSR1 new logfile<BR>&gt;<BR>&gt; SIGUSR1 is used for other stuf=
f in=20
  openvpn.<BR>&gt;<BR>&gt; Why don't you use syslog, catch the openvpn rela=
ted=20
  messages and place<BR>&gt; them in separate file? It is much simpler and =
can=20
  be managed in<BR>&gt; greater flexibility.<BR>&gt;<BR>&gt;=20
  Alon.<BR>&gt;<BR>&gt; On 5/10/08, Bonno Bloksma &lt;<A=20
  href=3D"mailto:b.bloksma@...1093...">b.bloksma@...1093...</A>&gt; wrote:<=
BR>&gt;=20
  &gt;<BR>&gt; &gt;<BR>&gt; &gt; Hi,<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt;=20
  &gt;<BR>&gt; &gt; I wanted to implement a weekly logfile rotation for the=
=20
  openvpn logfile<BR>&gt; and<BR>&gt; &gt; noticed that it did not work, op=
envpn=20
  kept writing to the old logfile.<BR>&gt; &gt;<BR>&gt; &gt; If I did a man=
ual=20
  mv openvpn.log openvpn.1 openvpn would still write to<BR>&gt; the<BR>&gt;=
 &gt;=20
  same file, now called openvpn.1, and not start a new openvpn.log. Only<BR=
>&gt;=20
  after<BR>&gt; &gt; restarting openvpn dit it start a new openvpn.log=20
  file.<BR>&gt; &gt; What is the correct way to keep openvpn up and running=
 but=20
  have it start<BR>&gt; &gt; using the new logfile?<BR>&gt; &gt;<BR>&gt; &g=
t;=20
  The logrotate program has a workaround by using the copytruncate=20
  option<BR>&gt; but<BR>&gt; &gt; that is more of a stopgap sollution for d=
umb=20
  programs, of which I'm sure<BR>&gt; &gt; openvpn is not one.<BR>&gt; &gt;=
 The=20
  logrotate program can send a SIGHUP, SIGUSR1, etc after the rotation<BR>&=
gt;=20
  to<BR>&gt; &gt; tell the program the logfile has been rotated.<BR>&gt;=20
  &gt;<BR>&gt; &gt; The openvpn script in the init.d/ folder has options li=
ke=20
  reload and<BR>&gt; reopen<BR>&gt; &gt; which correspondent to SIGHUP, SIG=
USR1=20
  and might do what I want but.... so<BR>&gt; &gt; far it seems not. After =
both=20
  reload and reopen the old logfile is still<BR>&gt; &gt; being used.<BR>&g=
t;=20
  &gt; Besides that....<BR>&gt; &gt;<BR>&gt; &gt; Testing with 2.0.9-1 on a=
=20
  Redhat 9 machine I found out that trying to do a<BR>&gt; &gt; reload woul=
d=20
  produce several errors, one about opening the key file, and I<BR>&gt; &gt=
;=20
  would loose the vpn connection.<BR>&gt; &gt; Sat May 10 08:58:44 2008=20
  us=3D750706 TCP/UDP: Closing socket<BR>&gt; &gt; Sat May 10 08:58:44 2008=
=20
  us=3D750822 /sbin/ip route del 172.16.1.64/26<BR>&gt; &gt; RTNETLINK answ=
ers:=20
  Operation not permitted<BR>&gt; &gt; Sat May 10 08:58:44 2008 us=3D755306=
 ERROR:=20
  Linux route delete command<BR>&gt; failed:<BR>&gt; &gt; shell command exi=
ted=20
  with error status: 2<BR>&gt; &gt; [.....]<BR>&gt; &gt; Sat May 10 08:58:4=
4=20
  2008 us=3D865438 OpenVPN 2.0.9 i386-redhat-linux-gnu<BR>&gt; [SSL]<BR>&gt=
; &gt;=20
  [LZO] [EPOLL] built on Feb&nbsp; 2 2007<BR>&gt; &gt; Sat May 10 08:58:44 =
2008=20
  us=3D865545 Restart pause, 2 second(s)<BR>&gt; &gt; Sat May 10 08:58:46 2=
008=20
  us=3D866570 IMPORTANT: OpenVPN's default port<BR>&gt; number<BR>&gt; &gt;=
 is now=20
  1194, based on an official port number assignment by IANA.&nbsp;=20
  OpenVPN<BR>&gt; &gt; 2.0-beta16 and earlier used 5000 as the default=20
  port.<BR>&gt; &gt; Sat May 10 08:58:46 2008 us=3D867202 Cannot load priva=
te key=20
  file<BR>&gt; &gt; bonnothuis.key: error:0200100D:system=20
  library:fopen:Permission denied:<BR>&gt; &gt; error:20074002:BIO=20
  routines:FILE_CTRL:system lib: error:140B0002:S<BR>&gt; &gt; SL=20
  routines:SSL_CTX_use_PrivateKey_file:system lib<BR>&gt; &gt; Sat May 10=20
  08:58:46 2008 us=3D867316 Error: private key password<BR>&gt;=20
  verification<BR>&gt; &gt; failed<BR>&gt; &gt; Sat May 10 08:58:46 2008=20
  us=3D867342 Exiting<BR>&gt; &gt; Is this a known error, maybe connected t=
o the=20
  nobody options, or should I<BR>&gt; do<BR>&gt; &gt; some testing with the=
 new=20
  2.1 version?<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt; &gt; Is the issue with the=
=20
  logfile rotation dealt with in the 2.1 release? If<BR>&gt; &gt; not, will=
 it=20
  be in a next rc? Do I need to help testing some things?<BR>&gt; &gt; I am=
 NOT=20
  a C programmer, at least not anymore. My programming skills are<BR>&gt;=20
  old<BR>&gt; &gt; and were in several other languages like Pascal, Forth, =
etc.=20
  :-)<BR>&gt; &gt;<BR>&gt; &gt; p.s. In my production environment I will be=
=20
  using Openvpn mainly on Debian<BR>&gt; &gt; etch, so for that I would sti=
ll be=20
  using the 2.0.9 release for a while.<BR>&gt; But<BR>&gt; &gt; at home I'd=
 like=20
  to use the newer version to see if openvpn 2.1 does work<BR>&gt; as<BR>&g=
t;=20
  &gt; it should.<BR>&gt; &gt;<BR>&gt; &gt; Groetjes,<BR>&gt; &gt; Bonno=20
  Bloksma<BR>&gt; &gt;<BR>&gt; &gt;<BR>&gt;=20
  -------------------------------------------------------------------------=
<BR>&gt;=20
  &gt;&nbsp; This SF.net email is sponsored by the 2008 JavaOne(SM)=20
  Conference<BR>&gt; &gt;&nbsp; Don't miss this year's exciting event. Ther=
e's=20
  still time to save $100.<BR>&gt; &gt;&nbsp; Use priority code J8TL2D2.<BR=
>&gt;=20
  &gt;<BR>&gt; <A=20
  href=3D"http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.su=
n.com/javaone">http://ad.doubleclick.net/clk;198757673;13503038;p?http://ja=
va.sun.com/javaone</A><BR>&gt;=20
  &gt; _______________________________________________<BR>&gt; &gt;&nbsp;=20
  Openvpn-devel mailing list<BR>&gt; &gt;&nbsp; <A=20
  href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...1096...=
ourceforge.net</A><BR>&gt;=20
  &gt;<BR>&gt; <A=20
  href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel">https=
://lists.sourceforge.net/lists/listinfo/openvpn-devel</A><BR>&gt;=20
  &gt;<BR>&gt; &gt;<BR>&gt;<BR></BLOCKQUOTE></BODY></HTML>

------=_NextPart_000_1115_01C8B41A.DA5DAA20--


