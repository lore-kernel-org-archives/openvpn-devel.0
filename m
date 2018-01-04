MIME-Version: 1.0
Sender: gsloop.treo@...277...
In-Reply-To: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...>
From: "Greg Sloop <gregs@...1934...>" <gregs@...1934...>
Date: Thu, 4 Jan 2018 15:37:25 -0800
Message-ID: <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
Content-Type: multipart/alternative; boundary="001a114520ee7ffcb20561fbd0c8"
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Tom Kunz <tkunz@...2030...>
Cc: openvpn-devel@lists.sourceforge.net

--001a114520ee7ffcb20561fbd0c8
Content-Type: text/plain; charset="UTF-8"

I'm sure someone else, or a Google search will get you a more detailed
run-down - but the gist of the "problem" is this;

OpenVPN is run in user-space, not kernel space. IPSec  runs in kernel
space, and the difference is vastly diminished throughput.

HTH

-Greg

On Jan 4, 2018 3:23 PM, "Tom Kunz" <tkunz@...2030...> wrote:

> Hi,
>
> I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be used as
> transport, and I have found something that I think might be a
> performance issue.  I have 3 linux boxes, A, B, and C.  All interfaces
> are 1Gbps.  Each has an interface to the next one downstream:
>
> A - eth0=10.10.10.10/24 and eth1=172.16.0.10/24
>
> B - eth0=172.16.0.11/24 and eth1=172.30.0.11/24
>
> C - eth0=172.30.0.10/24 and eth1=192.168.168.10/24
>
> Packets route as usual through this with no encryption, and throughput
> from A to C is at wire speed.  With IPSec between A&B, from
> 172.16.0.10-172.16.0.11, I can still get wire speed from A to C.  Then I
> turn off IPSec, and I setup A as the server and B as the client, with
> A's config being:
>
> =====
>
> dev tun
>
> topology subnet
> server 172.17.0.0 255.255.255.0
> port 1194
> proto udp
> dh /etc/openvpn/keys/dh2048.pem
> ca /etc/openvpn/keys/ca.crt
> cert /etc/openvpn/keys/server.crt
> key /etc/openvpn/keys/server.key
> verb 3
> keepalive 10 45
> cipher aes-256-cbc
> comp-lzo
>
> tun-mtu 50000
>
> mssfix 0
>
> fragment 0
>
> client-config-dir ccd
>
> push "route 10.10.10.0 255.255.255.0"
>
> =====
>
> and the client B config file is
>
> =====
>
> verb 3
> client
> cipher AES-256-CBC
> comp-lzo
> tun-mtu 50000
> mssfix 0
> fragment 0
> remote 172.16.0.10  1194
>
> dev tun
> redirect-private local
> tls-client
>
> ca /etc/openvpn/keys/ca.crt
> cert /etc/openvpn/keys/client1.crt
> key /etc/openvpn/keys/client1.key
>
> =====
>
> and I setup static routes on each side so that traffic is going through
> the tunnel from A to C and vice versa.
>
> I can pass traffic over this link, however when I do tests for speed, I
> am only getting about 200Mbps instead of 1Gbps.
>
> The funny thing is, I know that each of these machines can easily do
> 1Gbps.  If I do my performance test from A to B, over the above ovpn
> configs, I can get just over 1Gbps because of the MTU overhead being
> removed. But as soon as I have it make the leap downstream once more, I
> lose 80+% of the speed.  And again, both non-encrypted traffic and IPSec
> do the exact same test at wire speed or just slightly under wire speed.
>
> The way I do a speed test is on A:
>
> # nc -l -p 5555 > /dev/null
>
> and over on C:
>
> # dd if=/dev/urandom of=blob.random.1G bs=10M count=100
>
> # time cat blob.random.1G | nc 10.10.10.10 5555
>
> tcpdumps over each interface confirm traffic is flowing in the expected
> fashion.
>
> Over unencrypted or IPSec, I am looking at about 4s to move 1G of data
> from one end to the other, and with ovpn, 15-22s.  The machines involved
> are 2 Dell R720's with 8+G ram and a homebrew machine with several Xeons
> and 32G RAM.  Network cards involved are a mix of BCM Tigon3 "tg3"
> driver and IGB driver gigabit NICs.
>
> Anyone have any suggestions or thoughts as to why the big perf decrease
> and what might be done to improve it?
>
> Thanks,
>
> Tom
>
>
>
>
> ------------------------------------------------------------
> ------------------
> Check out the vibrant tech community on one of the world's most
> engaging tech sites, Slashdot.org! http://sdm.link/slashdot
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--001a114520ee7ffcb20561fbd0c8
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">I&#39;m sure someone else, or a Google search will get yo=
u a more detailed run-down - but the gist of the &quot;problem&quot; is thi=
s;<div dir=3D"auto"><br></div><div dir=3D"auto">OpenVPN is run in user-spac=
e, not kernel space. IPSec =C2=A0runs in kernel space, and the difference i=
s vastly diminished throughput.</div><div dir=3D"auto"><br></div><div dir=
=3D"auto">HTH</div><div dir=3D"auto"><br></div><div dir=3D"auto">-Greg</div=
></div><div class=3D"gmail_extra"><br><div class=3D"gmail_quote">On Jan 4, =
2018 3:23 PM, &quot;Tom Kunz&quot; &lt;<a href=3D"mailto:tkunz@...2030...">=
tkunz@...2030...</a>&gt; wrote:<br type=3D"attribution"><blockquote class=
=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;padd=
ing-left:1ex">Hi,<br>
<br>
I have been testing OVPN 2.4.4 vs StrongSwan IPSec, to be used as<br>
transport, and I have found something that I think might be a<br>
performance issue.=C2=A0 I have 3 linux boxes, A, B, and C.=C2=A0 All inter=
faces<br>
are 1Gbps.=C2=A0 Each has an interface to the next one downstream:<br>
<br>
A - eth0=3D<a href=3D"http://10.10.10.10/24" rel=3D"noreferrer" target=3D"_=
blank">10.10.10.10/24</a> and eth1=3D<a href=3D"http://172.16.0.10/24" rel=
=3D"noreferrer" target=3D"_blank">172.16.0.10/24</a><br>
<br>
B - eth0=3D<a href=3D"http://172.16.0.11/24" rel=3D"noreferrer" target=3D"_=
blank">172.16.0.11/24</a> and eth1=3D<a href=3D"http://172.30.0.11/24" rel=
=3D"noreferrer" target=3D"_blank">172.30.0.11/24</a><br>
<br>
C - eth0=3D<a href=3D"http://172.30.0.10/24" rel=3D"noreferrer" target=3D"_=
blank">172.30.0.10/24</a> and eth1=3D<a href=3D"http://192.168.168.10/24" r=
el=3D"noreferrer" target=3D"_blank">192.168.168.10/24</a><br>
<br>
Packets route as usual through this with no encryption, and throughput<br>
from A to C is at wire speed.=C2=A0 With IPSec between A&amp;B, from<br>
172.16.0.10-172.16.0.11, I can still get wire speed from A to C.=C2=A0 Then=
 I<br>
turn off IPSec, and I setup A as the server and B as the client, with<br>
A&#39;s config being:<br>
<br>
=3D=3D=3D=3D=3D<br>
<br>
dev tun<br>
<br>
topology subnet<br>
server 172.17.0.0 255.255.255.0<br>
port 1194<br>
proto udp<br>
dh /etc/openvpn/keys/dh2048.pem<br>
ca /etc/openvpn/keys/ca.crt<br>
cert /etc/openvpn/keys/server.crt<br>
key /etc/openvpn/keys/server.key<br>
verb 3<br>
keepalive 10 45<br>
cipher aes-256-cbc<br>
comp-lzo<br>
<br>
tun-mtu 50000<br>
<br>
mssfix 0<br>
<br>
fragment 0<br>
<br>
client-config-dir ccd<br>
<br>
push &quot;route 10.10.10.0 255.255.255.0&quot;<br>
<br>
=3D=3D=3D=3D=3D<br>
<br>
and the client B config file is<br>
<br>
=3D=3D=3D=3D=3D<br>
<br>
verb 3<br>
client<br>
cipher AES-256-CBC<br>
comp-lzo<br>
tun-mtu 50000<br>
mssfix 0<br>
fragment 0<br>
remote 172.16.0.10=C2=A0 1194<br>
<br>
dev tun<br>
redirect-private local<br>
tls-client<br>
<br>
ca /etc/openvpn/keys/ca.crt<br>
cert /etc/openvpn/keys/client1.crt<br>
key /etc/openvpn/keys/client1.key<br>
<br>
=3D=3D=3D=3D=3D<br>
<br>
and I setup static routes on each side so that traffic is going through<br>
the tunnel from A to C and vice versa.<br>
<br>
I can pass traffic over this link, however when I do tests for speed, I<br>
am only getting about 200Mbps instead of 1Gbps.<br>
<br>
The funny thing is, I know that each of these machines can easily do<br>
1Gbps.=C2=A0 If I do my performance test from A to B, over the above ovpn<b=
r>
configs, I can get just over 1Gbps because of the MTU overhead being<br>
removed. But as soon as I have it make the leap downstream once more, I<br>
lose 80+% of the speed.=C2=A0 And again, both non-encrypted traffic and IPS=
ec<br>
do the exact same test at wire speed or just slightly under wire speed.<br>
<br>
The way I do a speed test is on A:<br>
<br>
# nc -l -p 5555 &gt; /dev/null<br>
<br>
and over on C:<br>
<br>
# dd if=3D/dev/urandom of=3Dblob.random.1G bs=3D10M count=3D100<br>
<br>
# time cat blob.random.1G | nc 10.10.10.10 5555<br>
<br>
tcpdumps over each interface confirm traffic is flowing in the expected<br>
fashion.<br>
<br>
Over unencrypted or IPSec, I am looking at about 4s to move 1G of data<br>
from one end to the other, and with ovpn, 15-22s.=C2=A0 The machines involv=
ed<br>
are 2 Dell R720&#39;s with 8+G ram and a homebrew machine with several Xeon=
s<br>
and 32G RAM.=C2=A0 Network cards involved are a mix of BCM Tigon3 &quot;tg3=
&quot;<br>
driver and IGB driver gigabit NICs.<br>
<br>
Anyone have any suggestions or thoughts as to why the big perf decrease<br>
and what might be done to improve it?<br>
<br>
Thanks,=C2=A0<br>
<br>
Tom<br>
<br>
<br>
<br>
<br>
------------------------------<wbr>------------------------------<wbr>-----=
-------------<br>
Check out the vibrant tech community on one of the world&#39;s most<br>
engaging tech sites, Slashdot.org! <a href=3D"http://sdm.link/slashdot" rel=
=3D"noreferrer" target=3D"_blank">http://sdm.link/slashdot</a><br>
______________________________<wbr>_________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net">Openvpn-devel@...2155...=
9...<wbr>sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer" target=3D"_blank">https://lists.sourceforge.net/<wbr>lists/=
listinfo/openvpn-devel</a><br>
</blockquote></div></div>

--001a114520ee7ffcb20561fbd0c8--

