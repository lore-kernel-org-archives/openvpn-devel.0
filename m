MIME-Version: 1.0
Date: Sun, 13 Dec 2009 12:35:26 +0000
Message-ID: <a62fd16c0912130435j706089e1m41534b3f83c3544e@...278...>
From: Steven Williamson <steven43126@...277...>
Content-Type: multipart/alternative; boundary=001485f19764336801047a9b6483
Subject: [Openvpn-devel] openvpn-2.1_rc22 on opensolaris
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001485f19764336801047a9b6483
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Trying to get openvpn working on opensolaris version (SunOS opensolaris 5.11
snv_128a i86pc i386 i86pc Solaris).

I'm using tuntap drivers from here
http://www.whiteboard.ne.jp/~admin2/tuntap/

OpenVPN will start, connect and even pull down a list of routes that are
pushed by the VPN server. But i can't pass any traffic via the VPN.

The errors i get returned by OpenVPN are error 34 result too large. Looking
into it this error is returned when writing to the tun device, using the
putmsg syscall.

Error 34 is actually ERANGE error, but i can't figure out why it's been
generated everything looks ok to me.

According to the man page of putmsg ERANGE is used as follows:


 ERANGE          The size of the data  part  of  the  message
                     does  not fall within the range specified by
                     the maximum and minimum packet sizes of  the

SunOS 5.11           Last change: 1 Nov 2003                    3

System Calls                                            putmsg(2)

                     topmost  stream  module.  This value is also
                     returned if the control part of the  message
                     is  larger  than the maximum configured size
                     of the control part of a message, or if  the
                     data  part  of  a message is larger than the
                     maximum configured size of the data part  of
                     a message.

Just to confirm iv'e also compiled the example programs that come with
tuntap drivers that just open a tun device and send data, which seems to
work without error.
So it's looking like the problem does lie with openvpn but i may well be
wrong.

Here is some debug output from OpenVPN for good measure, the write_tun: line
was an extra printf added by myself. I don't mind getting my hands dirty and
trying to fix this but im a bit stumped as to why the ERANGE error is
returned, any help is greatly appreciated.

Cheers
Steven Williamson.


Sun Dec 13 12:29:48 2009 us=638048 I/O WAIT status=0x0008
Sun Dec 13 12:29:48 2009 us=638097 TUN WRITE [17]
Sun Dec 13 12:29:48 2009 us=638132 write_tun: sbuf.len:17 sbuf.buf:80f9f9c
Sun Dec 13 12:29:48 2009 us=638216 write to TUN/TAP : Result too large
(code=34)
Sun Dec 13 12:29:48 2009 us=638372 PO_CTL rwflags=0x0001 ev=3 arg=0x080d4d1c
Sun Dec 13 12:29:48 2009 us=638416 PO_CTL rwflags=0x0001 ev=6 arg=0x080d4c84
Sun Dec 13 12:29:48 2009 us=638469 I/O WAIT TR|Tw|SR|Sw [1/130202]
Sun Dec 13 12:29:49 2009 us=768606 I/O WAIT status=0x0020
Sun Dec 13 12:29:49 2009 us=768748 ACK reliable_can_send active=0 current=0
: [27]
Sun Dec 13 12:29:49 2009 us=768822 ACK reliable_send_timeout 604800 [27]
Sun Dec 13 12:29:49 2009 us=768867 PO_CTL rwflags=0x0001 ev=3 arg=0x080d4d1c
Sun Dec 13 12:29:49 2009 us=768897 PO_CTL rwflags=0x0001 ev=6 arg=0x080d4c84
Sun Dec 13 12:29:49 2009 us=768931 I/O WAIT TR|Tw|SR|Sw [1/130202]
Sun Dec 13 12:29:50 2009 us=900592 I/O WAIT status=0x0020
Sun Dec 13 12:29:50 2009 us=900785 TLS: tls_pre_encrypt: key_id=0
Sun Dec 13 12:29:50 2009 us=900885 SENT PING
Sun Dec 13 12:29:50 2009 us=900916 TIMER: coarse timer wakeup 10 seconds
Sun Dec 13 12:29:50 2009 us=900966 PO_CTL rwflags=0x0003 ev=3 arg=0x080d4d1c
Sun Dec 13 12:29:50 2009 us=901015 PO_CTL rwflags=0x0000 ev=6 arg=0x080d4c84
Sun Dec 13 12:29:50 2009 us=901061 I/O WAIT Tr|Tw|SR|SW [10/130202]
Sun Dec 13 12:29:50 2009 us=901143 PO_WAIT[0,0] fd=3 rev=0x00000004
rwflags=0x0002 arg=0x080d4d1c
Sun Dec 13 12:29:50 2009 us=901214 I/O WAIT status=0x0002
Sun Dec 13 12:29:50 2009 us=901270 UDPv4 WRITE [53] to 82.82.82.82:1194:
P_DATA_V1 kid=0 DATA len=52
Sun Dec 13 12:29:50 2009 us=901371 PO_CTL rwflags=0x0001 ev=3 arg=0x080d4d1c
Sun Dec 13 12:29:50 2009 us=901435 PO_CTL rwflags=0x0001 ev=6 arg=0x080d4c84
Sun Dec 13 12:29:50 2009 us=901623 I/O WAIT TR|Tw|SR|Sw [10/130202]
Sun Dec 13 12:29:59 2009 us=77201 PO_WAIT[0,0] fd=3 rev=0x00000001
rwflags=0x0001 arg=0x080d4d1c
Sun Dec 13 12:29:59 2009 us=77403 I/O WAIT status=0x0001
Sun Dec 13 12:29:59 2009 us=77487 UDPv4 READ [53] from 82.82.82.82:1194:
P_DATA_V1 kid=0 DATA len=52
Sun Dec 13 12:29:59 2009 us=77529 TLS: tls_pre_decrypt, key_id=0, IP=
82.82.82.82:1194
Sun Dec 13 12:29:59 2009 us=77613 RANDOM USEC=206362
Sun Dec 13 12:29:59 2009 us=77665 PO_CTL rwflags=0x0000 ev=3 arg=0x080d4d1c
Sun Dec 13 12:29:59 2009 us=77701 PO_CTL rwflags=0x0003 ev=6 arg=0x080d4c84
Sun Dec 13 12:29:59 2009 us=77743 I/O WAIT TR|TW|Sr|Sw [1/206362]
Sun Dec 13 12:29:59 2009 us=77836 PO_WAIT[1,0] fd=6 rev=0x00000004
rwflags=0x0002 arg=0x080d4c84
Sun Dec 13 12:29:59 2009 us=77886 I/O WAIT status=0x0008
Sun Dec 13 12:29:59 2009 us=77920 TUN WRITE [17]
Sun Dec 13 12:29:59 2009 us=77953 write_tun: sbuf.len:17 sbuf.buf:80f9f9c
Sun Dec 13 12:29:59 2009 us=78018 write to TUN/TAP : Result too large
(code=34)
Sun Dec 13 12:29:59 2009 us=78053 PO_CTL rwflags=0x0001 ev=3 arg=0x080d4d1c
Sun Dec 13 12:29:59 2009 us=78087 PO_CTL rwflags=0x0001 ev=6 arg=0x080d4c84
Sun Dec 13 12:29:59 2009 us=78126 I/O WAIT TR|Tw|SR|Sw [1/206362]
Sun Dec 13 12:30:00 2009 us=285898 I/O WAIT status=0x0020

--001485f19764336801047a9b6483
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi,<br><br>Trying to get openvpn working on opensolaris version (SunOS open=
solaris 5.11 snv_128a i86pc i386 i86pc Solaris).<br><br>I&#39;m using tunta=
p drivers from here <a href=3D"http://www.whiteboard.ne.jp/~admin2/tuntap/"=
>http://www.whiteboard.ne.jp/~admin2/tuntap/</a><br>
<br>OpenVPN will start, connect and even pull down a list of routes that ar=
e pushed by the VPN server. But i can&#39;t pass any traffic via the VPN.<b=
r><br>The errors i get returned by OpenVPN are error 34 result too large. L=
ooking into it this error is returned when writing to the tun device, using=
 the putmsg syscall.<br>
<br>Error 34 is actually ERANGE error, but i can&#39;t figure out why it&#3=
9;s been generated everything looks ok to me.<br><br>According to the man p=
age of putmsg ERANGE is used as follows:<br><br><br>=A0ERANGE=A0=A0=A0=A0=
=A0=A0=A0=A0=A0 The size of the data=A0 part=A0 of=A0 the=A0 message<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 does=A0 not fa=
ll within the range specified by<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0 the maximum and minimum packet sizes of=A0 the<br><br=
>SunOS 5.11=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 Last change: 1 Nov 2003=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 3<br><br>System Calls=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 putmsg(2)<br>
<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 topmost=A0=
 stream=A0 module.=A0 This value is also<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 returned if the control part of the=A0 messa=
ge<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 is=A0 la=
rger=A0 than the maximum configured size<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 of the control part of a message, or if=A0 t=
he<br>
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 data=A0 part=
=A0 of=A0 a message is larger than the<br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0=A0=A0=A0=A0=A0=A0=A0 maximum configured size of the data part=A0 of<=
br>=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 a message.<=
br><br>Just to confirm iv&#39;e also compiled the example programs that com=
e with tuntap drivers that just open a tun device and send data, which seem=
s to work without error.<br>
So it&#39;s looking like the problem does lie with openvpn but i may well b=
e wrong.<br><br>Here is some debug output from OpenVPN for good measure, th=
e write_tun: line was an extra printf added by myself. I don&#39;t mind get=
ting my hands dirty and trying to fix this but im a bit stumped as to why t=
he ERANGE error is returned, any help is greatly appreciated.<br>
<br>Cheers<br>Steven Williamson.<br><br><br>Sun Dec 13 12:29:48 2009 us=3D6=
38048 I/O WAIT status=3D0x0008<br>Sun Dec 13 12:29:48 2009 us=3D638097 TUN =
WRITE [17]<br>Sun Dec 13 12:29:48 2009 us=3D638132 write_tun: sbuf.len:17 s=
buf.buf:80f9f9c<br>
Sun Dec 13 12:29:48 2009 us=3D638216 write to TUN/TAP : Result too large (c=
ode=3D34)<br>Sun Dec 13 12:29:48 2009 us=3D638372 PO_CTL rwflags=3D0x0001 e=
v=3D3 arg=3D0x080d4d1c<br>Sun Dec 13 12:29:48 2009 us=3D638416 PO_CTL rwfla=
gs=3D0x0001 ev=3D6 arg=3D0x080d4c84<br>
Sun Dec 13 12:29:48 2009 us=3D638469 I/O WAIT TR|Tw|SR|Sw [1/130202]<br>Sun=
 Dec 13 12:29:49 2009 us=3D768606 I/O WAIT status=3D0x0020<br>Sun Dec 13 12=
:29:49 2009 us=3D768748 ACK reliable_can_send active=3D0 current=3D0 : [27]=
<br>Sun Dec 13 12:29:49 2009 us=3D768822 ACK reliable_send_timeout 604800 [=
27]<br>
Sun Dec 13 12:29:49 2009 us=3D768867 PO_CTL rwflags=3D0x0001 ev=3D3 arg=3D0=
x080d4d1c<br>Sun Dec 13 12:29:49 2009 us=3D768897 PO_CTL rwflags=3D0x0001 e=
v=3D6 arg=3D0x080d4c84<br>Sun Dec 13 12:29:49 2009 us=3D768931 I/O WAIT TR|=
Tw|SR|Sw [1/130202]<br>
Sun Dec 13 12:29:50 2009 us=3D900592 I/O WAIT status=3D0x0020<br>Sun Dec 13=
 12:29:50 2009 us=3D900785 TLS: tls_pre_encrypt: key_id=3D0<br>Sun Dec 13 1=
2:29:50 2009 us=3D900885 SENT PING<br>Sun Dec 13 12:29:50 2009 us=3D900916 =
TIMER: coarse timer wakeup 10 seconds<br>
Sun Dec 13 12:29:50 2009 us=3D900966 PO_CTL rwflags=3D0x0003 ev=3D3 arg=3D0=
x080d4d1c<br>Sun Dec 13 12:29:50 2009 us=3D901015 PO_CTL rwflags=3D0x0000 e=
v=3D6 arg=3D0x080d4c84<br>Sun Dec 13 12:29:50 2009 us=3D901061 I/O WAIT Tr|=
Tw|SR|SW [10/130202]<br>
Sun Dec 13 12:29:50 2009 us=3D901143 PO_WAIT[0,0] fd=3D3 rev=3D0x00000004 r=
wflags=3D0x0002 arg=3D0x080d4d1c <br>Sun Dec 13 12:29:50 2009 us=3D901214 I=
/O WAIT status=3D0x0002<br>Sun Dec 13 12:29:50 2009 us=3D901270 UDPv4 WRITE=
 [53] to <a href=3D"http://82.82.82.82:1194">82.82.82.82:1194</a>: P_DATA_V=
1 kid=3D0 DATA len=3D52<br>
Sun Dec 13 12:29:50 2009 us=3D901371 PO_CTL rwflags=3D0x0001 ev=3D3 arg=3D0=
x080d4d1c<br>Sun Dec 13 12:29:50 2009 us=3D901435 PO_CTL rwflags=3D0x0001 e=
v=3D6 arg=3D0x080d4c84<br>Sun Dec 13 12:29:50 2009 us=3D901623 I/O WAIT TR|=
Tw|SR|Sw [10/130202]<br>
Sun Dec 13 12:29:59 2009 us=3D77201 PO_WAIT[0,0] fd=3D3 rev=3D0x00000001 rw=
flags=3D0x0001 arg=3D0x080d4d1c <br>Sun Dec 13 12:29:59 2009 us=3D77403 I/O=
 WAIT status=3D0x0001<br>Sun Dec 13 12:29:59 2009 us=3D77487 UDPv4 READ [53=
] from <a href=3D"http://82.82.82.82:1194">82.82.82.82:1194</a>: P_DATA_V1 =
kid=3D0 DATA len=3D52<br>
Sun Dec 13 12:29:59 2009 us=3D77529 TLS: tls_pre_decrypt, key_id=3D0, IP=3D=
<a href=3D"http://82.82.82.82:1194">82.82.82.82:1194</a><br>Sun Dec 13 12:2=
9:59 2009 us=3D77613 RANDOM USEC=3D206362<br>Sun Dec 13 12:29:59 2009 us=3D=
77665 PO_CTL rwflags=3D0x0000 ev=3D3 arg=3D0x080d4d1c<br>
Sun Dec 13 12:29:59 2009 us=3D77701 PO_CTL rwflags=3D0x0003 ev=3D6 arg=3D0x=
080d4c84<br>Sun Dec 13 12:29:59 2009 us=3D77743 I/O WAIT TR|TW|Sr|Sw [1/206=
362]<br>Sun Dec 13 12:29:59 2009 us=3D77836 PO_WAIT[1,0] fd=3D6 rev=3D0x000=
00004 rwflags=3D0x0002 arg=3D0x080d4c84 <br>
Sun Dec 13 12:29:59 2009 us=3D77886 I/O WAIT status=3D0x0008<br>Sun Dec 13 =
12:29:59 2009 us=3D77920 TUN WRITE [17]<br>Sun Dec 13 12:29:59 2009 us=3D77=
953 write_tun: sbuf.len:17 sbuf.buf:80f9f9c<br>Sun Dec 13 12:29:59 2009 us=
=3D78018 write to TUN/TAP : Result too large (code=3D34)<br>
Sun Dec 13 12:29:59 2009 us=3D78053 PO_CTL rwflags=3D0x0001 ev=3D3 arg=3D0x=
080d4d1c<br>Sun Dec 13 12:29:59 2009 us=3D78087 PO_CTL rwflags=3D0x0001 ev=
=3D6 arg=3D0x080d4c84<br>Sun Dec 13 12:29:59 2009 us=3D78126 I/O WAIT TR|Tw=
|SR|Sw [1/206362]<br>
Sun Dec 13 12:30:00 2009 us=3D285898 I/O WAIT status=3D0x0020<br><br><br>

--001485f19764336801047a9b6483--

