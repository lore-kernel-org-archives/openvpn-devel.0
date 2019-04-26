MIME-Version: 1.0
References: <CAEYw=WoZDJap1cwCh-SAqJr8KiQEv80XmBkVbVijTbCbOCOP0g@...278...>
 <CAEYw=Wqna4PnOf+ZQV2sqkrQ6sLdCUQgwxRnrFBVuRx60uAbZA@...278...>
 <bbf01b87-32bf-f234-cd95-6b5738ad463b@...1147...>
 <59329176-c948-a816-d128-4601d7720dcd@...2181...>
 <0600680d-4eb6-0790-9990-26a7cdf0b7cc@...1147...>
 <CAEYw=Woe1ycyBRx=FtL9pQOhSr66-Njwr5x3VR_46DFMQ9W52w@...278...>
In-Reply-To: <CAEYw=Woe1ycyBRx=FtL9pQOhSr66-Njwr5x3VR_46DFMQ9W52w@...278...>
From: Pieter Hulshoff <pieter.hulshoff@...2499...>
Date: Fri, 26 Apr 2019 16:55:36 +0200
Message-ID: <CAEYw=WrCmqAwGDY=xEtL7Huy6pDvXVY=fgwrPz0zndKtdM1XRA@...278...>
Content-Type: multipart/alternative; boundary="000000000000389e220587702122"
Subject: Re: [Openvpn-devel] Client reconnect issues
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>, Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Openvpn-users@lists.sourceforge.net

--000000000000389e220587702122
Content-Type: text/plain; charset="UTF-8"

Antonio & Jan Just,

Looking at the logs, there are some notable differences. I assumed for the
moment that the TLS calls are logged before the received message, since the
message first needs to be decoded (and the client reports a 13 byte
plaintext with 42 byte ciphertext).

--------------------------------------------------------------------------------------------------------------------------------------------------------
This is the log of the initial connection:
Fri Jan 26 09:35:30 2018 us=253552 client1/10.11.11.10:1194 write
tls_write_ciphertext 42 bytes
Fri Jan 26 09:35:30 2018 us=253581 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:6743):
=> read
Fri Jan 26 09:35:30 2018 us=253609 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:3721):
=> read record
Fri Jan 26 09:35:30 2018 us=253636 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2208):
=> fetch input
Fri Jan 26 09:35:30 2018 us=253664 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2366):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:30 2018 us=253692 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:30 2018 us=253721 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2391):
ssl->f_recv(_timeout)() returned 5 (-0xfffffffb)
Fri Jan 26 09:35:30 2018 us=253748 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2403):
<= fetch input
Fri Jan 26 09:35:30 2018 us=253777 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2208):
=> fetch input
Fri Jan 26 09:35:30 2018 us=253804 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2366):
in_left: 5, nb_want: 42
Fri Jan 26 09:35:30 2018 us=253832 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390):
in_left: 5, nb_want: 42
Fri Jan 26 09:35:30 2018 us=253860 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2391):
ssl->f_recv(_timeout)() returned 37 (-0xffffffdb)
Fri Jan 26 09:35:30 2018 us=253887 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2403):
<= fetch input
Fri Jan 26 09:35:30 2018 us=253914 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:1576):
=> decrypt buf
Fri Jan 26 09:35:30 2018 us=253956 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2051):
<= decrypt buf
Fri Jan 26 09:35:30 2018 us=253984 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:3754):
<= read record
Fri Jan 26 09:35:30 2018 us=254012 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:7042):
<= read
Fri Jan 26 09:35:30 2018 us=254038 client1/10.11.11.10:1194 read
tls_read_plaintext 13 bytes
Fri Jan 26 09:35:30 2018 us=254068 client1/10.11.11.10:1194 ACK
reliable_send_timeout 604800 [6]
Fri Jan 26 09:35:30 2018 us=254100 client1/10.11.11.10:1194 PUSH: Received
control message: 'PUSH_REQUEST'
--------------------------------------------------------------------------------------------------------------------------------------------------------

--------------------------------------------------------------------------------------------------------------------------------------------------------
This is the log of the request after the reconnect:
Fri Jan 26 09:35:42 2018 us=558215 client1/10.11.11.10:1194 write
tls_write_ciphertext 42 bytes
Fri Jan 26 09:35:42 2018 us=558244 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:6743):
=> read
Fri Jan 26 09:35:42 2018 us=558271 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:3721):
=> read record
Fri Jan 26 09:35:42 2018 us=558299 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2208):
=> fetch input
Fri Jan 26 09:35:42 2018 us=558327 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2366):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:42 2018 us=558355 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:42 2018 us=558384 client1/10.11.11.10:1194 ACK
reliable_can_send active=0 current=0 : [6]
Fri Jan 26 09:35:42 2018 us=558412 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:6743):
=> read
Fri Jan 26 09:35:42 2018 us=558439 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:3721):
=> read record
Fri Jan 26 09:35:42 2018 us=558466 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2208):
=> fetch input
Fri Jan 26 09:35:42 2018 us=558493 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2366):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:42 2018 us=558521 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:42 2018 us=558550 client1/10.11.11.10:1194 ACK write ID 5
(ack->len=1, n=1)
Fri Jan 26 09:35:42 2018 us=558582 client1/10.11.11.10:1194 ACK
reliable_send_timeout 604800 [6]
Fri Jan 26 09:35:42 2018 us=558614 PO_CTL rwflags=0x0002 ev=5
arg=0x563eb8ff1858
Fri Jan 26 09:35:42 2018 us=558641 PO_CTL rwflags=0x0000 ev=4
arg=0x563eb8fe80a8
Fri Jan 26 09:35:42 2018 us=558671 I/O WAIT Tr|Tw|Sr|SW [1/165054]
Fri Jan 26 09:35:42 2018 us=558703 PO_WAIT[0,0] fd=5 rev=0x00000004
rwflags=0x0002 arg=0x563eb8ff1858
Fri Jan 26 09:35:42 2018 us=558729 I/O WAIT status=0x0002
Fri Jan 26 09:35:42 2018 us=558764 client1/10.11.11.10:1194 UDPv4 WRITE
[62] to [AF_INET]10.11.11.10:1194: P_ACK_V1 kid=0 pid=[ #8 ] [ 5 ]
Fri Jan 26 09:35:42 2018 us=558829 client1/10.11.11.10:1194 ACK
reliable_can_send active=0 current=0 : [6]
Fri Jan 26 09:35:42 2018 us=558859 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:6743):
=> read
Fri Jan 26 09:35:42 2018 us=558886 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:3721):
=> read record
Fri Jan 26 09:35:42 2018 us=558914 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2208):
=> fetch input
Fri Jan 26 09:35:42 2018 us=558941 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2366):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:42 2018 us=558970 client1/10.11.11.10:1194 mbed TLS msg
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390):
in_left: 0, nb_want: 5
Fri Jan 26 09:35:42 2018 us=558999 client1/10.11.11.10:1194 ACK
reliable_send_timeout 604800 [6]
Fri Jan 26 09:35:42 2018 us=559029 PO_CTL rwflags=0x0001 ev=5
arg=0x563eb8ff1858
Fri Jan 26 09:35:42 2018 us=559056 PO_CTL rwflags=0x0001 ev=4
arg=0x563eb8fe80a8
Fri Jan 26 09:35:42 2018 us=559086 I/O WAIT TR|Tw|SR|Sw [1/165054]
Fri Jan 26 09:35:43 2018 us=725320 I/O WAIT status=0x0020
Fri Jan 26 09:35:43 2018 us=725415 MULTI: REAP range 0 -> 16
--------------------------------------------------------------------------------------------------------------------------------------------------------

As you can see, the message is never actually decrypted after the
reconnect, and as such the server will never receive it.

Kind regards,

Pieter Hulshoff

--000000000000389e220587702122
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div dir=3D"ltr"><div di=
r=3D"ltr"><div class=3D"gmail_default" style=3D"font-family:arial,helvetica=
,sans-serif">Antonio &amp; Jan Just,</div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif"><br></div><div class=3D"gmail_=
default" style=3D"font-family:arial,helvetica,sans-serif">Looking at the lo=
gs, there are some notable differences. I assumed for the moment that the T=
LS calls are logged before the received message, since the message first ne=
eds to be decoded (and the client reports a 13 byte plaintext with 42 byte =
ciphertext).</div><div class=3D"gmail_default" style=3D"font-family:arial,h=
elvetica,sans-serif"><br></div><div class=3D"gmail_default" style=3D"font-f=
amily:arial,helvetica,sans-serif">-----------------------------------------=
---------------------------------------------------------------------------=
------------------------------------</div><div class=3D"gmail_default" styl=
e=3D"font-family:arial,helvetica,sans-serif">This is the log of the initial=
 connection:</div><div class=3D"gmail_default"><div class=3D"gmail_default"=
><font face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:30 2018 us=3D=
253552 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> wri=
te tls_write_ciphertext 42 bytes</font></div><div class=3D"gmail_default"><=
font face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:30 2018 us=3D25=
3581 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed =
TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64=
-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_t=
ls.c:6743): =3D&gt; read</font></div><div class=3D"gmail_default"><span sty=
le=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=
=3D253609 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> =
mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/ar=
ch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/=
ssl_tls.c:3721): =3D&gt; read record</span><br></div><div class=3D"gmail_de=
fault"><span style=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09=
:35:30 2018 us=3D253636 client1/<a href=3D"http://10.11.11.10:1194">10.11.1=
1.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-N=
L-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mb=
edtls/library/ssl_tls.c:2208): =3D&gt; fetch input</span><br></div><div cla=
ss=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif"=
>Fri Jan 26 09:35:30 2018 us=3D253664 client1/<a href=3D"http://10.11.11.10=
:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/works=
pace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build=
/openvpn-nl/mbedtls/library/ssl_tls.c:2366): in_left: 0, nb_want: 5</span><=
br></div><div class=3D"gmail_default"><span style=3D"font-family:arial,helv=
etica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D253692 client1/<a href=3D"h=
ttp://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openv=
pn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial=
/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390): in_left: 0, n=
b_want: 5</span><br></div><div class=3D"gmail_default"><span style=3D"font-=
family:arial,helvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D253721 cli=
ent1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg =
(/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/dis=
tro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:239=
1): ssl-&gt;f_recv(_timeout)() returned 5 (-0xfffffffb)</span><br></div><di=
v class=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-s=
erif">Fri Jan 26 09:35:30 2018 us=3D253748 client1/<a href=3D"http://10.11.=
11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/=
workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/=
build/openvpn-nl/mbedtls/library/ssl_tls.c:2403): &lt;=3D fetch input</span=
><br></div><div class=3D"gmail_default"><span style=3D"font-family:arial,he=
lvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D253777 client1/<a href=3D=
"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_ope=
nvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xeni=
al/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2208): =3D&gt; fet=
ch input</span><br></div><div class=3D"gmail_default"><span style=3D"font-f=
amily:arial,helvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D253804 clie=
nt1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (=
/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/dist=
ro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2366=
): in_left: 5, nb_want: 42</span><br></div><div class=3D"gmail_default"><sp=
an style=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:30 201=
8 us=3D253832 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194<=
/a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-buil=
d/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/libr=
ary/ssl_tls.c:2390): in_left: 5, nb_want: 42</span><br></div><div class=3D"=
gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif">Fri J=
an 26 09:35:30 2018 us=3D253860 client1/<a href=3D"http://10.11.11.10:1194"=
>10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/O=
penVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openv=
pn-nl/mbedtls/library/ssl_tls.c:2391): ssl-&gt;f_recv(_timeout)() returned =
37 (-0xffffffdb)</span><br></div><div class=3D"gmail_default"><span style=
=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D2=
53887 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed=
 TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/6=
4-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_=
tls.c:2403): &lt;=3D fetch input</span><br></div><div class=3D"gmail_defaul=
t"><span style=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:=
30 2018 us=3D253914 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10=
:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.=
4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtl=
s/library/ssl_tls.c:1576): =3D&gt; decrypt buf</span><br></div><div class=
=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif">F=
ri Jan 26 09:35:30 2018 us=3D253956 client1/<a href=3D"http://10.11.11.10:1=
194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspa=
ce/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/o=
penvpn-nl/mbedtls/library/ssl_tls.c:2051): &lt;=3D decrypt buf</span><br></=
div><div class=3D"gmail_default"><span style=3D"font-family:arial,helvetica=
,sans-serif">Fri Jan 26 09:35:30 2018 us=3D253984 client1/<a href=3D"http:/=
/10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.j=
enkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/serv=
ertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:3754): &lt;=3D read recor=
d</span><br></div><div class=3D"gmail_default"><span style=3D"font-family:a=
rial,helvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D254012 client1/<a =
href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/sl=
ave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubun=
tu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:7042): &lt;=
=3D read</span><br></div><div class=3D"gmail_default"><span style=3D"font-f=
amily:arial,helvetica,sans-serif">Fri Jan 26 09:35:30 2018 us=3D254038 clie=
nt1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> read tls_read_=
plaintext 13 bytes</span><br></div><div class=3D"gmail_default"><font face=
=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:30 2018 us=3D254068 clie=
nt1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> ACK reliable_s=
end_timeout 604800 [6]</font></div><div class=3D"gmail_default"><font face=
=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:30 2018 us=3D254100 clie=
nt1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> PUSH: Received=
 control message: &#39;PUSH_REQUEST&#39;</font></div></div></div><div class=
=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">-------=
---------------------------------------------------------------------------=
----------------------------------------------------------------------</div=
><br class=3D"gmail-Apple-interchange-newline"><div class=3D"gmail_default"=
 style=3D"font-family:arial,helvetica,sans-serif">-------------------------=
---------------------------------------------------------------------------=
----------------------------------------------------</div><div class=3D"gma=
il_default" style=3D"font-family:arial,helvetica,sans-serif">This is the lo=
g of the request after the reconnect:</div><div class=3D"gmail_default"><fo=
nt face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D5582=
15 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> write t=
ls_write_ciphertext 42 bytes</font></div><div class=3D"gmail_default"><font=
 face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D558244=
 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS =
msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit=
/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c=
:6743): =3D&gt; read</font></div><div class=3D"gmail_default"><span style=
=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D5=
58271 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed=
 TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/6=
4-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_=
tls.c:3721): =3D&gt; read record</span><br></div><div class=3D"gmail_defaul=
t"><span style=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:=
42 2018 us=3D558299 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10=
:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.=
4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtl=
s/library/ssl_tls.c:2208): =3D&gt; fetch input</span><br></div><div class=
=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif">F=
ri Jan 26 09:35:42 2018 us=3D558327 client1/<a href=3D"http://10.11.11.10:1=
194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspa=
ce/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/o=
penvpn-nl/mbedtls/library/ssl_tls.c:2366): in_left: 0, nb_want: 5</span><br=
></div><div class=3D"gmail_default"><span style=3D"font-family:arial,helvet=
ica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D558355 client1/<a href=3D"htt=
p://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn=
/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/s=
ervertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390): in_left: 0, nb_=
want: 5</span><br></div><div class=3D"gmail_default"><span style=3D"font-fa=
mily:arial,helvetica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D558384 clien=
t1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> ACK reliable_ca=
n_send active=3D0 current=3D0 : [6]</span><br></div><div class=3D"gmail_def=
ault"><font face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 =
us=3D558412 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a=
> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/=
arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/librar=
y/ssl_tls.c:6743): =3D&gt; read</font></div><div class=3D"gmail_default"><s=
pan style=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:42 20=
18 us=3D558439 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194=
</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-bui=
ld/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/lib=
rary/ssl_tls.c:3721): =3D&gt; read record</span><br></div><div class=3D"gma=
il_default"><span style=3D"font-family:arial,helvetica,sans-serif">Fri Jan =
26 09:35:42 2018 us=3D558466 client1/<a href=3D"http://10.11.11.10:1194">10=
.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/Open=
VPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-=
nl/mbedtls/library/ssl_tls.c:2208): =3D&gt; fetch input</span><br></div><di=
v class=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-s=
erif">Fri Jan 26 09:35:42 2018 us=3D558493 client1/<a href=3D"http://10.11.=
11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/=
workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/=
build/openvpn-nl/mbedtls/library/ssl_tls.c:2366): in_left: 0, nb_want: 5</s=
pan><br></div><div class=3D"gmail_default"><span style=3D"font-family:arial=
,helvetica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D558521 client1/<a href=
=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_=
openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_x=
enial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390): in_left:=
 0, nb_want: 5</span><br></div><div class=3D"gmail_default"><span style=3D"=
font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D55855=
0 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> ACK writ=
e ID 5 (ack-&gt;len=3D1, n=3D1)</span><br></div><div class=3D"gmail_default=
"><font face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=
=3D558582 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> =
ACK reliable_send_timeout 604800 [6]</font></div><div class=3D"gmail_defaul=
t"><font face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=
=3D558614 PO_CTL rwflags=3D0x0002 ev=3D5 arg=3D0x563eb8ff1858</font></div><=
div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">Fri=
 Jan 26 09:35:42 2018 us=3D558641 PO_CTL rwflags=3D0x0000 ev=3D4 arg=3D0x56=
3eb8fe80a8</font></div><div class=3D"gmail_default"><font face=3D"arial, he=
lvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D558671 I/O WAIT Tr|Tw|Sr=
|SW [1/165054]</font></div><div class=3D"gmail_default"><font face=3D"arial=
, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D558703 PO_WAIT[0,0] =
fd=3D5 rev=3D0x00000004 rwflags=3D0x0002 arg=3D0x563eb8ff1858=C2=A0</font><=
/div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-seri=
f">Fri Jan 26 09:35:42 2018 us=3D558729 I/O WAIT status=3D0x0002</font></di=
v><div class=3D"gmail_default"><font face=3D"arial, helvetica, sans-serif">=
Fri Jan 26 09:35:42 2018 us=3D558764 client1/<a href=3D"http://10.11.11.10:=
1194">10.11.11.10:1194</a> UDPv4 WRITE [62] to [AF_INET]<a href=3D"http://1=
0.11.11.10:1194">10.11.11.10:1194</a>: P_ACK_V1 kid=3D0 pid=3D[ #8 ] [ 5 ]<=
/font><span style=3D"font-family:arial,helvetica,sans-serif"></span></div><=
div class=3D"gmail_default"><div class=3D"gmail_default"><font face=3D"aria=
l, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D558829 client1/<a h=
ref=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> ACK reliable_can_send =
active=3D0 current=3D0 : [6]</font></div><div class=3D"gmail_default"><font=
 face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D558859=
 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS =
msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit=
/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_tls.c=
:6743): =3D&gt; read</font></div><div class=3D"gmail_default"><span style=
=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D5=
58886 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> mbed=
 TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/6=
4-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtls/library/ssl_=
tls.c:3721): =3D&gt; read record</span><br></div><div class=3D"gmail_defaul=
t"><span style=3D"font-family:arial,helvetica,sans-serif">Fri Jan 26 09:35:=
42 2018 us=3D558914 client1/<a href=3D"http://10.11.11.10:1194">10.11.11.10=
:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspace/OpenVPN-NL-2.=
4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/openvpn-nl/mbedtl=
s/library/ssl_tls.c:2208): =3D&gt; fetch input</span><br></div><div class=
=3D"gmail_default"><span style=3D"font-family:arial,helvetica,sans-serif">F=
ri Jan 26 09:35:42 2018 us=3D558941 client1/<a href=3D"http://10.11.11.10:1=
194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn/.jenkins/workspa=
ce/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/servertype/build/o=
penvpn-nl/mbedtls/library/ssl_tls.c:2366): in_left: 0, nb_want: 5</span><br=
></div><div class=3D"gmail_default"><span style=3D"font-family:arial,helvet=
ica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D558970 client1/<a href=3D"htt=
p://10.11.11.10:1194">10.11.11.10:1194</a> mbed TLS msg (/srv/slave_openvpn=
/.jenkins/workspace/OpenVPN-NL-2.4-build/arch/64-bit/distro/ubuntu_xenial/s=
ervertype/build/openvpn-nl/mbedtls/library/ssl_tls.c:2390): in_left: 0, nb_=
want: 5</span><br></div><div class=3D"gmail_default"><span style=3D"font-fa=
mily:arial,helvetica,sans-serif">Fri Jan 26 09:35:42 2018 us=3D558999 clien=
t1/<a href=3D"http://10.11.11.10:1194">10.11.11.10:1194</a> ACK reliable_se=
nd_timeout 604800 [6]</span><br></div><div class=3D"gmail_default"><font fa=
ce=3D"arial, helvetica, sans-serif">Fri Jan 26 09:35:42 2018 us=3D559029 PO=
_CTL rwflags=3D0x0001 ev=3D5 arg=3D0x563eb8ff1858</font></div><div class=3D=
"gmail_default"><font face=3D"arial, helvetica, sans-serif">Fri Jan 26 09:3=
5:42 2018 us=3D559056 PO_CTL rwflags=3D0x0001 ev=3D4 arg=3D0x563eb8fe80a8</=
font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, san=
s-serif">Fri Jan 26 09:35:42 2018 us=3D559086 I/O WAIT TR|Tw|SR|Sw [1/16505=
4]</font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica,=
 sans-serif">Fri Jan 26 09:35:43 2018 us=3D725320 I/O WAIT status=3D0x0020<=
/font></div><div class=3D"gmail_default"><font face=3D"arial, helvetica, sa=
ns-serif">Fri Jan 26 09:35:43 2018 us=3D725415 MULTI: REAP range 0 -&gt; 16=
</font></div><div style=3D"font-family:arial,helvetica,sans-serif">--------=
---------------------------------------------------------------------------=
---------------------------------------------------------------------<br></=
div></div><br class=3D"gmail-Apple-interchange-newline"></div><div dir=3D"l=
tr"><div class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-=
serif">As you can see, the message is never actually decrypted after the re=
connect, and as such the server will never receive it.</div></div><div dir=
=3D"ltr"><br></div><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"f=
ont-family:arial,helvetica,sans-serif">Kind regards,</div><div class=3D"gma=
il_default" style=3D"font-family:arial,helvetica,sans-serif"><br></div><div=
 class=3D"gmail_default" style=3D"font-family:arial,helvetica,sans-serif">P=
ieter Hulshoff</div><br></div></div></div></div>

--000000000000389e220587702122--

