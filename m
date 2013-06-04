MIME-Version: 1.0
Date: Tue, 4 Jun 2013 12:15:30 +0200
Message-ID: <CAEYCsr6fwHqm7+Vquswp0G-m7ovC=S3wTkbcckJtLMWF5wzbwQ@...278...>
From: wen lui <esolvepolito@...277...>
Content-Type: multipart/alternative; boundary=e89a8f646db568493904de515c36
Subject: [Openvpn-devel] understanding of tun and vpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--e89a8f646db568493904de515c36
Content-Type: text/plain; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

 let me explain my understanding on tun/tap

tun device is related to a file descriptor fd :
fd=3Dopen("/dev/net/tun",O_RDWR)
when I write to this fd,  write(fd, packet,..)
tun device deliver this packet to kernel TCP/IP stack
when kernel TCP/IP stack send a packet to tun device
I can read from the fd, read=A3=A8fd, packet_buffer,...=A3=A9


for example, when using vpn, my tun device ip is 10.0.0.1, my host public
ip is 4.3.2.1, the remote host tun device ip is 10.0.0.15(eth0), the remote
host ip public IP is 1.2.3.4(eth0)

if I have a tcp server listening on port 2000, and I have a program which
has a UDP server listening on port 4000. The remote host  sends a UDP
tunneled TCP SYN to me,  it is like below:

---------------------------------------------------------------------------=
-------------------------------------------------------------------
TCP SYN port: 2000 |src: 10.0.0.15| dst: 10.0.0.1| UDP header port: 4000 |
src: 1.2.3.4|dst:4.3.2.1|
---------------------------------------------------------------------------=
-------------------------------------------------------------------

then my UDP server receives this packet, the program get a packet as below:

------------------------------------------------------------------------
TCP SYN port: 2000 |src: 10.0.0.15| dst: 10.0.0.1|
------------------------------------------------------------------------

the program then write this packet to fd, and then the tun device send the
packet via TCP/IP stack to the TCP server.
the TCP server will respond a TCP SYN/ACK as below:

---------------------------------------------------------------------------=
-----

TCP SYN/ACK port: 2000 |src: 10.0.0.1| dst: 10.0.0.15|
---------------------------------------------------------------------------=
------

according to the routing table, the TCP/IP stack deliver this SYN/ACK to
tun device
and then I read via fd to get the SYN/ACK packet, and use UDP to send it
out to remote host via eth0,
the packet becomes:

---------------------------------------------------------------------------=
-------------------------------------------------------------------
TCP SYN port: 2000 |src: 10.0.0.15| dst: 10.0.0.1| UDP header port: 4000 |
src: 4.3.2.1|dst:1.2.3.4|
---------------------------------------------------------------------------=
-------------------------------------------------------------------

is my understanding correct or not?



I did a test,

I crafted a ICMP packet, source ip is 10.0.0.3, destination ip is 10.0.0.1,
my tun device ip is 10.0.0.1, it is related to a file descriptor fd
then I write the ICMP packet to the fd,
through tshark -i tun or tcpdump -i tun
I can capture this packet,
but I don't get a ICMP echo reply, why?

thanks!

--e89a8f646db568493904de515c36
Content-Type: text/html; charset="GB2312"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>&nbsp;let me explain my understanding =
on tun/tap<br><br>tun device is related to a file descriptor fd :&nbsp; fd=
=3Dopen(&quot;/dev/net/tun&quot;,O_RDWR)<br></div>when I write to this fd,&=
nbsp; write(fd, packet,..)<br>

</div>tun device deliver this packet to kernel TCP/IP stack<br></div>when k=
ernel TCP/IP stack send a packet to tun device<br></div>I can read from the=
 fd, read=A3=A8fd, packet_buffer,...=A3=A9<div><br></div><div><br>
</div><div>for example, when using vpn, my tun device ip is 10.0.0.1, my
 host public ip is 4.3.2.1, the remote host tun device ip is=20
10.0.0.15(eth0), the remote host ip public IP is 1.2.3.4(eth0)<br><br></div=
><div>if I have a tcp server listening on port 2000, and I have a program w=
hich has a UDP server listening on port 4000. The remote host&nbsp; sends a=
 UDP tunneled TCP SYN to me,&nbsp; it is like below:<br>
<br>-----------------------------------------------------------------------=
-----------------------------------------------------------------------<br>=
</div><div>TCP SYN port: 2000 |src: 10.0.0.15| dst: 10.0.0.1| UDP header po=
rt: 4000 | src: 1.2.3.4|dst:4.3.2.1|<br>
</div><div>----------------------------------------------------------------=
---------------------------------------------------------------------------=
---<br><br></div><div>then my UDP server receives this packet, the program =
get a packet as below:<br>
<br>-----------------------------------------------------------------------=
-<br><div>TCP SYN port: 2000 |src: 10.0.0.15| dst: 10.0.0.1|<br></div>-----=
-------------------------------------------------------------------<br>
</div><div><br></div><div>the program then write this packet to fd, and the=
n the tun device send the packet via TCP/IP stack to the TCP server.<br></d=
iv><div>the TCP server will respond a TCP SYN/ACK as below:<br><br>--------=
------------------------------------------------------------------------ <b=
r>
<div>TCP SYN/ACK port: 2000 |src: 10.0.0.1| dst: 10.0.0.15|&nbsp; <br></div=
>--------------------------------------------------------------------------=
-------<br><br></div><div>according to the routing table, the TCP/IP stack =
deliver this SYN/ACK to tun device<br>
</div><div>and then I read via fd to get the SYN/ACK packet, and use UDP to=
 send it out to remote host via eth0,<br></div><div>the packet becomes:<br>=
<br>-----------------------------------------------------------------------=
-----------------------------------------------------------------------<br>
<div>TCP SYN port: 2000 |src: 10.0.0.15| dst: 10.0.0.1| UDP header port: 40=
00 | src: 4.3.2.1|dst:1.2.3.4|<br></div>-----------------------------------=
---------------------------------------------------------------------------=
--------------------------------<br>
</div><div><br></div><div>is my understanding correct or not?<br><br><br><b=
r></div><div>I did a test,<br><br></div><div>I crafted a ICMP packet, sourc=
e ip is 10.0.0.3, destination ip is 10.0.0.1, my tun device ip is 10.0.0.1,=
 it is related to a file descriptor fd<br>
</div><div>then I write the ICMP packet to the fd, <br></div><div>through t=
shark -i tun or tcpdump -i tun<br></div><div>I can capture this packet,<br>=
</div><div>but I don&#39;t get a ICMP echo reply, why?<br><br>thanks!<br>
</div><div><br><br><br><br></div><div>
<br><br></div><div>
<br><br><br><br></div></div>

--e89a8f646db568493904de515c36--

