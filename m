MIME-Version: 1.0
References: <6cc03a83-47e6-cedb-254b-f445972788f5@...515...>
 <b9c984d6-bcde-0d0e-349d-3a586600b668@...515...>
 <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
In-Reply-To: <6ebf219f-6a8e-6e39-893c-5610129abaef@...1147...>
From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 29 Nov 2018 17:18:45 +0200
Message-ID: <CAGyAFMU1iS3FJjVbmBqYq6BeSt+UyxUrAUg=xd=cmiH3nVac6g@...278...>
Content-Type: multipart/alternative; boundary="000000000000937ded057bcf3333"
Subject: Re: [Openvpn-devel] Summary of the community meeting (Wed,
 28th Nov 2018)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Jan Just Keijser <janjust@...1147...>
Cc: =?UTF-8?Q?Samuli_Sepp=C3=A4nen?= <samuli@...515...>, openvpn-devel@lists.sourceforge.net

--000000000000937ded057bcf3333
Content-Type: text/plain; charset="UTF-8"

Hi Jan Just,

(forgot to add openvpn-devel in previous mail)

Some background information.

In openvpn3 we decided not to implement fragments, because:

 - this is quite a big feature which has to be supported through the whole
stack (client, server, kernel module)
 - we assume that it is not used by most of users

However, for those who needs --fragment, we'll implement:

 - mssfix support, this should solve problems with tcp-based protocols
 - sending icmp "packet too big" for other protocols, we assume that
they'll respect icmp response

--fragment is/was very useful on a system where you do not / cannot change
> the tun MTU size. Up to Windows XP, this was not
> possible without rebooting the OS. Since Vista, it *is* possible to change
> the MTU of an adapter on the fly (as explained in my
> trusty old cookbook, of course ;))
>

As James wrote a while ago (13 years ago :)

https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html

> A lot of experience gained during the OpenVPN 1.x releases showed that
it's best to fix the tunnel MTU at
> 1500 and vary the other parameters (and use --mssfix to prevent
fragmentation rather than a lower tunnel MTU).

Don't know if still holds. Assuming that we can change tun-mtu on any
supported platforms, do you think that it is better
to do _that_, rather than have mssfix/icmp ptb workaround?


> With that, it would be possible to fix the link-mtu to 1500 (or
> whatever is set on the outbound interface) and then subtract the header
> size to get a meaningful tun-mtu size.
>

Do you think 1500 is a safe value? Arne just mentioned today that his
network interface MTU is 1500 and router's MTU is 1492 due to
PPPoE, and openvpn2 works because it assumes that mtu is 1450.


> Having said all that, I do have one gripe with the way the link or tun mtu
> is calculated in the current codebase:
> In the 2.3 code base, the server tun mtu size was equal to the client
> tun-mtu size.
> In the 2.4+ code base, the server-side tun mtu size is set to some
> ridiculous low level (with link-mtu 1500 set) in order to
> accomocate all possible encryption ciphers - *even if I add ncp-disable* .
> To me, that does not make a whole lot of sense. If I
> add '--ncp-disable' I'd expect the client and the server to behave pretty
> much like an OpenVPN 2.3 client (with a possible 3
> bytes difference to accomodate for the peer id).
>

With 2.4 codebase I noticed that what man page says is not what openvpn2
code does - it does include transport overhead, while
man page says it doesn't (copying my mail here):

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

-Lev

--000000000000937ded057bcf3333
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div class=3D"gmail_quote"><div dir=3D"ltr"><div dir=3D"lt=
r"><div dir=3D"ltr">Hi Jan Just,<br><div class=3D"gmail_quote"><div><br></d=
iv><div>(forgot to add openvpn-devel in previous mail)</div><div><br></div>=
<div>Some background information.</div><div><br></div><div>In openvpn3 we d=
ecided not to implement fragments, because:</div><div><br></div><div>=C2=A0=
- this is quite a big feature which has to be supported through the whole s=
tack (client, server, kernel module)</div><div>=C2=A0- we assume that it is=
 not used by most of users</div><div><br></div><div>However, for those who =
needs --fragment, we&#39;ll implement:</div><div><br></div><div>=C2=A0- mss=
fix support, this should solve problems with tcp-based protocols</div><div>=
=C2=A0- sending icmp &quot;packet too big&quot; for other protocols, we ass=
ume that they&#39;ll respect icmp response</div><div><br></div><blockquote =
class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px sol=
id rgb(204,204,204);padding-left:1ex">--fragment is/was very useful on a sy=
stem where you do not / cannot change the tun MTU size. Up to Windows XP, t=
his was not=C2=A0<br>possible without rebooting the OS. Since Vista, it *is=
* possible to change the MTU of an adapter on the fly (as explained in my=
=C2=A0<br>trusty old cookbook, of course ;))<br></blockquote><div><br></div=
><div>As James wrote a while ago (13 years ago :)</div><div><br></div><div>=
<a href=3D"https://openvpn.net/archive/openvpn-users/2005-10/msg00354.html"=
 target=3D"_blank">https://openvpn.net/archive/openvpn-users/2005-10/msg003=
54.html</a><br></div><div><br></div><div>&gt; A lot of experience gained du=
ring the OpenVPN 1.x releases showed that it&#39;s best to fix the tunnel M=
TU at</div><div>&gt; 1500 and vary the other parameters (and use --mssfix t=
o prevent fragmentation rather than a lower tunnel MTU).</div><div>=C2=A0</=
div><div>Don&#39;t know if still holds. Assuming that we can change tun-mtu=
 on any supported platforms, do you think that it is better=C2=A0</div><div=
>to do _that_, rather than have mssfix/icmp ptb workaround?</div><div>=C2=
=A0=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0p=
x 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">With that,=
 it would be possible to fix the link-mtu to 1500 (or=C2=A0<br>whatever is =
set on the outbound interface) and then subtract the header size to get a m=
eaningful tun-mtu size.<br></blockquote><div><br></div><div>Do you think 15=
00 is a safe value? Arne just mentioned today that his network interface MT=
U is 1500 and router&#39;s MTU is 1492 due to</div><div>PPPoE, and openvpn2=
 works because it assumes that mtu is 1450.=C2=A0</div><div>=C2=A0</div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t:1px solid rgb(204,204,204);padding-left:1ex">Having said all that, I do h=
ave one gripe with the way the link or tun mtu is calculated in the current=
 codebase:<br>In the 2.3 code base, the server tun mtu size was equal to th=
e client tun-mtu size.<br>In the 2.4+ code base, the server-side tun mtu si=
ze is set to some ridiculous low level (with link-mtu 1500 set) in order to=
=C2=A0<br>accomocate all possible encryption ciphers - *even if I add ncp-d=
isable* . To me, that does not make a whole lot of sense. If I=C2=A0<br>add=
 &#39;--ncp-disable&#39; I&#39;d expect the client and the server to behave=
 pretty much like an OpenVPN 2.3 client (with a possible 3=C2=A0<br>bytes d=
ifference to accomodate for the peer id).<br></blockquote><div><br></div><d=
iv>With 2.4 codebase I noticed that what man page says is not what openvpn2=
 code does - it does include transport overhead, while</div><div>man page s=
ays it doesn&#39;t (copying my mail here):</div><div><br></div><div>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 Announce to TCP sessions running =
over the tunnel that they should limit their send packet sizes such that af=
ter OpenVPN has encapsulated them, the resulting UDP packet size that OpenV=
PN sends to its peer will not exceed max bytes. The =C2=A0default =C2=A0val=
ue is 1450.<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 The max=
 parameter is interpreted in the same way as the --link-mtu parameter, i.e.=
 the UDP packet size after encapsulation overhead has been added in, but no=
t including the UDP header itself. Resulting packet would be at most 28 byt=
es larger for IPv4 and 48 bytes for IPv6 (20/40 bytes for IP header and 8 b=
ytes for UDP header).<br><br>So it means that with &quot;mssfix&quot; 1300 =
resulting IPv4 packet size would be at most 1328.=C2=A0=C2=A0<br></div><div=
><br></div><div>This is what I see in Wireshark (server - git master, clien=
t 2.4.6):<br><br>Internet Protocol Version 4, Src: 128.199.xxx.yyy, Dst: 10=
.0.200.20<br>=C2=A0 =C2=A0 0100 .... =3D Version: 4<br>=C2=A0 =C2=A0 .... 0=
101 =3D Header Length: 20 bytes (5)<br>=C2=A0 =C2=A0 Total Length: 1300<br>=
=C2=A0 =C2=A0 Protocol: UDP (17)<br>User Datagram Protocol, Src Port: 1194,=
 Dst Port: 1194<br>=C2=A0 =C2=A0 Source Port: 1194<br>=C2=A0 =C2=A0 Destina=
tion Port: 1194<br>=C2=A0 =C2=A0 Length: 1280<br>OpenVPN Protocol<br>=C2=A0=
 =C2=A0 Type: 0x49 [opcode/key_id]<br>=C2=A0 =C2=A0 Peer ID: 0<br>=C2=A0 =
=C2=A0 Data (1268 bytes)<br><br>While man page statement is technically cor=
rect - UDP packet size is 1300, which is &quot;at most 1328&quot;, I think =
it should say:<div><br></div><div>&gt; the resulting IP packet size that Op=
enVPN sends to its peer will not exceed max bytes=C2=A0=C2=A0</div><div><br=
></div><div>and</div><div><br></div><div>&gt; The max parameter is interpre=
ted in the same way as the --link-mtu parameter, i.e. the IP packet size</d=
iv><div>after encapsulation overhead has been added in, including UDP and I=
P headers.</div></div><div><br></div><div>-Lev</div></div></div></div></div=
></div></div>

--000000000000937ded057bcf3333--

