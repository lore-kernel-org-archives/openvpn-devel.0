Date: Fri, 5 Jan 2018 12:21:47 -0800
From: Gregory Sloop <gregs@...1934...>
Reply-To: Greg Sloop <gregs@...1934...>
Message-ID: <961580051.20180105122147@...1934...>
In-Reply-To: <d92ef8b9-fb9a-4cd0-ac6c-ebd04853311e@...2030...>
References: <7f72b2de-f411-c4a0-bd1e-f343543cb8e2@...2030...> 
 <CAAjorqWaFY+XdD5XZ95rPyXJHd9MfPv3Xmv3M1gKfWHbnJXL9w@...278...>
 <6ad04520-6e42-51aa-bd38-b2285e7adaab@...2030...>
 <4da8bb9a-7118-e0ab-ba7d-bc813e33d7c4@...515...>
 <d92ef8b9-fb9a-4cd0-ac6c-ebd04853311e@...2030...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
 boundary="----------0D00C117A168F7907"
Subject: Re: [Openvpn-devel] OVPN vs IPSec performance as a transport
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

------------0D00C117A168F7907
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

-SNIP-
I haven't taken the time to fully understand the tests you've done etc.=20
[And it does seem you are not some neophyte blindly hacking your way throug=
h this...]

However, I will tell you that it's *very* common for people to do things th=
at appear very similarly as you describe, and find the IPSec throughput is =
vastly better then OpenVPN. [That's always been my experience in any benchm=
arking I've done - and I've done some.]  Each time I've seen it discussed -=
 I've seen repeated threads all pointing to the kernel vs user space argume=
nts.

And all my own testing also shows that to be the case.=20

IIRC, in the platforms I've tested, OVPN isn't CPU constrained - the connec=
tion will max out throughput far earlier than CPU exhaustion. IPSec will sc=
ale more or less directly with CPU performance - and at max throughput the =
CPU handling encryption will max out. (I suppose this might not be true in =
a system with in-hardware AES or other encryption off-loading - and the eth=
ernet interface will become the bottleneck, not the CPU - but where I've ru=
n tests, that was never the case. It's, admittedly, been a while since I've=
 done any real throughput tests on a test-bed setup.)

TK> Again, keep in mind that full wire speed is realized with no vpn, and
TK> with IPSec.=20
TK> So, to reason this through a little:

1) TK> - No vpn =3D fast.
2) TK> - IPSec =3D fast.
3) - OVPN->>OVPN =3D even faster
4) - OVPN->>OVPN->routing/hardware =3D slow, down to about 200Mbps from 1+G=
bps.


I may certainly be wrong, but I'd be *really* skeptical about #3. I've *nev=
er* seen a case where the performance of OpenVPN is better than IPSec on th=
e same platform.

And if #3 is wrong, your "tinkering" with #4 will never yield something use=
ful.
Obviously, I'd want to be pretty sure the straight OVPN <-> OVPN tests are =
accurate before trying to solve #4.

-Greg=

------------0D00C117A168F7907
Content-Type: text/html; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

<html><head><title>Re: [Openvpn-devel] OVPN vs IPSec performance as a trans=
port</title>
</head>
<body>
<span style=3D" font-family:'Courier New'; font-size: 9pt;">-SNIP-<br>
I haven't taken the time to fully understand the tests you've done etc. <br>
[And it does seem you are not some neophyte blindly hacking your way throug=
h this...]<br>
<br>
However, I will tell you that it's *very* common for people to do things th=
at appear very similarly as you describe, and find the IPSec throughput is =
vastly better then OpenVPN. [That's always been my experience in any benchm=
arking I've done - and I've done some.] &nbsp;Each time I've seen it discus=
sed - I've seen repeated threads all pointing to the kernel vs user space a=
rguments.<br>
<br>
And all my own testing also shows that to be the case. <br>
<br>
IIRC, in the platforms I've tested, OVPN isn't CPU constrained - the connec=
tion will max out throughput far earlier than CPU exhaustion. IPSec will sc=
ale more or less directly with CPU performance - and at max throughput the =
CPU handling encryption will max out. (I suppose this might not be true in =
a system with in-hardware AES or other encryption off-loading - and the eth=
ernet interface will become the bottleneck, not the CPU - but where I've ru=
n tests, that was never the case. It's, admittedly, been a while since I've=
 done any real throughput tests on a test-bed setup.)<br>
<br>
<span style=3D" color: #800000;"><b>TK&gt; Again, keep in mind that full wi=
re speed is realized with no vpn, and<br>
TK&gt; with IPSec. <br>
TK&gt; So, to reason this through a little:<br>
<br>
1) TK&gt; - No vpn =3D fast.<br>
2) TK&gt; - IPSec =3D fast.<br>
3) - OVPN-&gt;&gt;OVPN =3D even faster<br>
4) - OVPN-&gt;&gt;OVPN-&gt;routing/hardware =3D slow, down to about 200Mbps=
 from 1+Gbps.<br>
<br>
<br>
</b><span style=3D" color: #000000;">I may certainly be wrong, but I'd be *=
really* skeptical about #3. I've *never* seen a case where the performance =
of OpenVPN is better than IPSec on the same platform.<br>
<br>
And if #3 is wrong, your "tinkering" with #4 will never yield something use=
ful.<br>
Obviously, I'd want to be pretty sure the straight OVPN &lt;-&gt; OVPN test=
s are accurate before trying to solve #4.<br>
<br>
-Greg</body></html>=

------------0D00C117A168F7907--


