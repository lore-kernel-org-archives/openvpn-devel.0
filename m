Message-ID: <0f4501c8b271$3b877200$0202fea9@...1094...>
From: "Bonno Bloksma" <b.bloksma@...1093...>
Date: Sat, 10 May 2008 09:41:17 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_0F42_01C8B281.FEF14850"
Subject: [Openvpn-devel] SIGHUP SIGUSR1 new logfile
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

------=_NextPart_000_0F42_01C8B281.FEF14850
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,

I wanted to implement a weekly logfile rotation for the openvpn logfile and=
 noticed that it did not work, openvpn kept writing to the old logfile.

If I did a manual mv openvpn.log openvpn.1 openvpn would still write to the=
 same file, now called openvpn.1, and not start a new openvpn.log. Only aft=
er restarting openvpn dit it start a new openvpn.log file.
What is the correct way to keep openvpn up and running but have it start us=
ing the new logfile?

The logrotate program has a workaround by using the copytruncate option but=
 that is more of a stopgap sollution for dumb programs, of which I'm sure o=
penvpn is not one.
The logrotate program can send a SIGHUP, SIGUSR1, etc after the rotation to=
 tell the program the logfile has been rotated.

The openvpn script in the init.d/ folder has options like reload and reopen=
 which correspondent to SIGHUP, SIGUSR1 and might do what I want but.... so=
 far it seems not. After both reload and reopen the old logfile is still be=
ing used.
Besides that....

Testing with 2.0.9-1 on a Redhat 9 machine I found out that trying to do a =
reload would produce several errors, one about opening the key file, and I =
would loose the vpn connection.
Sat May 10 08:58:44 2008 us=3D750706 TCP/UDP: Closing socket
Sat May 10 08:58:44 2008 us=3D750822 /sbin/ip route del 172.16.1.64/26
RTNETLINK answers: Operation not permitted
Sat May 10 08:58:44 2008 us=3D755306 ERROR: Linux route delete command fail=
ed: shell command exited with error status: 2
[.....]
Sat May 10 08:58:44 2008 us=3D865438 OpenVPN 2.0.9 i386-redhat-linux-gnu [S=
SL] [LZO] [EPOLL] built on Feb  2 2007
Sat May 10 08:58:44 2008 us=3D865545 Restart pause, 2 second(s)
Sat May 10 08:58:46 2008 us=3D866570 IMPORTANT: OpenVPN's default port numb=
er is now 1194, based on an official port number assignment by IANA.  OpenV=
PN 2.0-beta16 and earlier used 5000 as the default port.
Sat May 10 08:58:46 2008 us=3D867202 Cannot load private key file bonnothui=
s.key: error:0200100D:system library:fopen:Permission denied: error:2007400=
2:BIO routines:FILE_CTRL:system lib: error:140B0002:S
SL routines:SSL_CTX_use_PrivateKey_file:system lib
Sat May 10 08:58:46 2008 us=3D867316 Error: private key password verificati=
on failed
Sat May 10 08:58:46 2008 us=3D867342 Exiting
Is this a known error, maybe connected to the nobody options, or should I d=
o some testing with the new 2.1 version?


Is the issue with the logfile rotation dealt with in the 2.1 release? If no=
t, will it be in a next rc? Do I need to help testing some things?
I am NOT a C programmer, at least not anymore. My programming skills are ol=
d and were in several other languages like Pascal, Forth, etc. :-)

p.s. In my production environment I will be using Openvpn mainly on Debian =
etch, so for that I would still be using the 2.0.9 release for a while. But=
 at home I'd like to use the newer version to see if openvpn 2.1 does work =
as it should.

Groetjes,
Bonno Bloksma

------=_NextPart_000_0F42_01C8B281.FEF14850
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Diso-8859-1">
<META content=3D"MSHTML 6.00.6000.16640" name=3DGENERATOR>
<STYLE></STYLE>
</HEAD>
<BODY bgColor=3D#ffffff>
<DIV><FONT face=3DArial size=3D2>Hi,</FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV>
<DIV><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial">
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>I wanted to implement a=
 weekly=20
logfile rotation for the openvpn logfile and noticed that it did not work,=
=20
openvpn kept writing to the old logfile.</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000></FONT>&nbsp;</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>If I did a manual <EM>m=
v=20
openvpn.log openvpn.1</EM>&nbsp;openvpn would still write to the same file,=
 now=20
called openvpn.1, and not start a new openvpn.log. Only after restarting op=
envpn=20
dit it start a new openvpn.log file.</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>What is the correct way=
 to keep=20
openvpn up and running but have it start using the new logfile?</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000></FONT>&nbsp;</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>The logrotate program h=
as a=20
workaround by using the copytruncate option but that is more of a stopgap=20
sollution for dumb programs, of which I'm sure openvpn is not one.</FONT></=
DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>The logrotate program c=
an send a=20
SIGHUP, SIGUSR1, etc after the rotation to tell the program the logfile has=
 been=20
rotated.</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000></FONT>&nbsp;</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>The openvpn script in t=
he=20
init.d/ folder has options like reload and reopen which correspondent to SI=
GHUP,=20
SIGUSR1&nbsp;and might do what I want but.... so far it seems not. After bo=
th=20
reload and reopen the old logfile is still being used.</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>Besides that....</FONT>=
</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000></FONT>&nbsp;</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>Testing with 2.0.9-1 on=
 a Redhat=20
9 machine I found out that trying to do a reload would produce&nbsp;several=
=20
errors, one&nbsp;about opening the key file, and I would loose the vpn=20
connection.</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>Sat May 10 08:58:44 200=
8=20
us=3D750706 TCP/UDP: Closing socket<BR>Sat May 10 08:58:44 2008 us=3D750822=
 /sbin/ip=20
route del 172.16.1.64/26<BR>RTNETLINK answers: Operation not permitted<BR>S=
at=20
May 10 08:58:44 2008 us=3D755306 ERROR: Linux route delete command failed: =
shell=20
command exited with error status: 2<BR></FONT><FONT=20
color=3D#000000>[.....]</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>Sat May 10 08:58:44 200=
8=20
us=3D865438 OpenVPN 2.0.9 i386-redhat-linux-gnu [SSL] [LZO] [EPOLL] built o=
n=20
Feb&nbsp; 2 2007<BR>Sat May 10 08:58:44 2008 us=3D865545 Restart pause, 2=20
second(s)<BR>Sat May 10 08:58:46 2008 us=3D866570 IMPORTANT: OpenVPN's defa=
ult=20
port number is now 1194, based on an official port number assignment by=20
IANA.&nbsp; OpenVPN 2.0-beta16 and earlier used 5000 as the default port.<B=
R>Sat=20
May 10 08:58:46 2008 us=3D867202 Cannot load private key file bonnothuis.ke=
y:=20
error:0200100D:system library:fopen:Permission denied: error:20074002:BIO=20
routines:FILE_CTRL:system lib: error:140B0002:S<BR>SL=20
routines:SSL_CTX_use_PrivateKey_file:system lib<BR>Sat May 10 08:58:46 2008=
=20
us=3D867316 Error: private key password verification failed<BR>Sat May 10 0=
8:58:46=20
2008 us=3D867342 Exiting<BR>Is this a known error, maybe connected to=20
the&nbsp;nobody options,&nbsp;or should I do some&nbsp;testing with the new=
 2.1=20
version?</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000></FONT>&nbsp;</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000></FONT>&nbsp;</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>Is the issue with the l=
ogfile=20
rotation dealt with in the 2.1 release? If not, will it be in a next rc? Do=
 I=20
need to help testing some things?</FONT></DIV>
<DIV style=3D"COLOR: #0189b4"><FONT color=3D#000000>I am NOT a C programmer=
, at=20
least not anymore. My programming skills are old and were in several other=
=20
languages like Pascal, Forth, etc. :-)</FONT></DIV><FONT=20
color=3D#000000></FONT></SPAN></DIV>
<DIV><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><FONT=20
color=3D#000000></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><FONT color=3D#000=
000>p.s.=20
In my production environment I will be using Openvpn mainly on Debian=20
etch,&nbsp;so for that I would still be using the 2.0.9 release for a while=
. But=20
at home I'd like to use the newer version to see if openvpn 2.1 does work a=
s it=20
should.</FONT></SPAN></DIV>
<DIV><SPAN style=3D"FONT-SIZE: 10pt; FONT-FAMILY: Arial"><FONT=20
color=3D#000000><BR>Groetjes,<BR>Bonno Bloksma</DIV>
<DIV style=3D"COLOR: #0189b4"><FONT=20
color=3D#000000></FONT></FONT>&nbsp;</DIV></SPAN></DIV></BODY></HTML>

------=_NextPart_000_0F42_01C8B281.FEF14850--


