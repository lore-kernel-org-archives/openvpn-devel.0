MIME-Version: 1.0
From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 23 Nov 2018 10:49:10 +0200
Message-ID: <CAGyAFMVEP_=W=JUSrBqx9TWPW4yn=ffCsF_r2b3y5eHdGiKwNQ@...278...>
Content-Type: multipart/alternative; boundary="0000000000001cebfd057b510fb2"
Subject: [Openvpn-devel] Man for mssfix
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000001cebfd057b510fb2
Content-Type: text/plain; charset="UTF-8"

Hi,

I think that man page statement about "mssfix" doesn't fully reflect actual
functionality. Specifically, man page says:

              Announce to TCP sessions running over the tunnel that they
should limit their send packet sizes such that after OpenVPN has
encapsulated them, the resulting UDP packet size that OpenVPN sends to its
peer will not exceed max bytes. The  default  value is 1450.

              The max parameter is interpreted in the same way as the
--link-mtu parameter, i.e. the UDP packet size after encapsulation overhead
has been added in, but not including the UDP header itself. Resulting
packet would be at most 28 bytes larger for IPv4 and 48 bytes for IPv6
(20/40 bytes for IP header and 8 bytes for UDP header).

So it means that with "mssfix" 1300 resulting IPv4 packet size would be at
most 1328.

This is what I see in Wireshark (server - git master, client 2.4.6):

Internet Protocol Version 4, Src: 128.199.xxx.yyy, Dst: 10.0.200.20
    0100 .... = Version: 4
    .... 0101 = Header Length: 20 bytes (5)
    Total Length: 1300
    Protocol: UDP (17)
User Datagram Protocol, Src Port: 1194, Dst Port: 1194
    Source Port: 1194
    Destination Port: 1194
    Length: 1280
OpenVPN Protocol
    Type: 0x49 [opcode/key_id]
    Peer ID: 0
    Data (1268 bytes)

While man page statement is technically correct - UDP packet size is 1300,
which is "at most 1328", I think it should say:

> the resulting IP packet size that OpenVPN sends to its peer will not
exceed max bytes

and

> The max parameter is interpreted in the same way as the --link-mtu
parameter, i.e. the IP packet size
after encapsulation overhead has been added in, including UDP and IP
headers.

Same results without explicitly defining mssfix - IP packet size is 1450
(which is default value).

Most likely initially mssfix has worked as stated in man but then
implementation has changed. So either
we may want to fix implementation or change man. Since mssfix behaves like
link-mtu, maybe we could also
change its default value to 1500 to get 50 more bytes for payload.

What do you think?

--
-Lev

--0000000000001cebfd057b510fb2
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi,<br><br>I think that man page statement about &quot;mss=
fix&quot; doesn&#39;t fully reflect actual functionality. Specifically, man=
 page says:<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Announc=
e to TCP sessions running over the tunnel that they should limit their send=
 packet sizes such that after OpenVPN has encapsulated them, the resulting =
UDP packet size that OpenVPN sends to its peer will not exceed max bytes. T=
he =C2=A0default =C2=A0value is 1450.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 The max parameter is interpreted in the same way as th=
e --link-mtu parameter, i.e. the UDP packet size after encapsulation overhe=
ad has been added in, but not including the UDP header itself. Resulting pa=
cket would be at most 28 bytes larger for IPv4 and 48 bytes for IPv6 (20/40=
 bytes for IP header and 8 bytes for UDP header).<br><br>So it means that w=
ith &quot;mssfix&quot; 1300 resulting IPv4 packet size would be at most 132=
8.<br><br>This is what I see in Wireshark (server - git master, client 2.4.=
6):<br><br>Internet Protocol Version 4, Src: 128.199.xxx.yyy, Dst: 10.0.200=
.20<br>=C2=A0 =C2=A0 0100 .... =3D Version: 4<br>=C2=A0 =C2=A0 .... 0101 =
=3D Header Length: 20 bytes (5)<br>=C2=A0 =C2=A0 Total Length: 1300<br>=C2=
=A0 =C2=A0 Protocol: UDP (17)<br>User Datagram Protocol, Src Port: 1194, Ds=
t Port: 1194<br>=C2=A0 =C2=A0 Source Port: 1194<br>=C2=A0 =C2=A0 Destinatio=
n Port: 1194<br>=C2=A0 =C2=A0 Length: 1280<br>OpenVPN Protocol<br>=C2=A0 =
=C2=A0 Type: 0x49 [opcode/key_id]<br>=C2=A0 =C2=A0 Peer ID: 0<br>=C2=A0 =C2=
=A0 Data (1268 bytes)<br><br>While man page statement is technically correc=
t - UDP packet size is 1300, which is &quot;at most 1328&quot;, I think it =
should say:<div><br></div><div>&gt; the resulting IP packet size that OpenV=
PN sends to its peer will not exceed max bytes=C2=A0=C2=A0</div><div><br></=
div><div>and</div><div><br></div><div>&gt; The max parameter is interpreted=
 in the same way as the --link-mtu parameter, i.e. the IP packet size</div>=
<div>after encapsulation overhead has been added in, including UDP and IP h=
eaders.</div><div><br></div><div>Same results without explicitly defining m=
ssfix - IP packet size is 1450 (which is default value).</div><div><br><div=
><div>Most likely initially mssfix has worked as stated in man but then imp=
lementation has changed. So either</div><div>we may want to fix implementat=
ion or change man. Since mssfix behaves like link-mtu, maybe we could also<=
/div><div>change its default value to 1500 to get 50 more bytes for payload=
.</div><div><br></div><div>What do you think?</div><div><br>--<br>-Lev</div=
></div></div></div>

--0000000000001cebfd057b510fb2--

