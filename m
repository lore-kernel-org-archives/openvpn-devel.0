MIME-Version: 1.0
From: Swan Geon <swangeon@...277...>
Date: Mon, 24 Jul 2023 03:43:17 -0500
Message-ID: <CALn4OiNv11FHk6ZhahbUYZPa15AW53H7C85Awi+qrtgeVRPm1Q@...278...>
Content-Type: multipart/alternative; boundary="000000000000c6fe15060137a06f"
Subject: [Openvpn-devel] Porting OpenVPN Problems
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000c6fe15060137a06f
Content-Type: text/plain; charset="UTF-8"

Hello all, hopefully, this is the correct mailing list to ask this
question, and sorry if it is long.

I am trying to port OpenVPN to Haiku OS and I am currently having an issue
as I run this test command from the PORTS
<https://github.com/OpenVPN/openvpn/blob/master/PORTS#L73> file `./openvpn
--remote 64.233.160.0 --verb 9 --ping 1 --dev tun` as I get the expected
output (comparing it to Linux at least) until it just hangs on the line `I/O
WAIT status=0x0004`. I am not sure if this is a problem caused by the
driver I am writing or OpenVPN not being able to run the do_ifconfig()
command that has a TARGET_HAIKU definition and I wanted to ask you all
about it. Here
<https://review.haiku-os.org/c/haiku/+/6608/15/src/add-ons/kernel/drivers/network/tun/driver.cpp>
I have the driver source code, here
<https://review.haiku-os.org/c/haiku/+/6608/15/src/add-ons/kernel/network/devices/tun/tun.cpp>
is the interface source code, and here
<https://github.com/Swangeon/Haiku-Openvpn/commit/9954e48fa35dcb4f77fe08863b1d12f0f3e29b72>
I have a forked version of the OpenVPN source code where I added the
definition for the OS and info on how to do the ifconfig command on the
system. I know that UDP sockets are working normally within Haiku since I
can switch the line `--dev tun` to `--dev null` and it will work just fine.
One problem that I think might be there is that it's not setting up a tun
interface properly and/or it might be going off of the assumption of a
Linux driver where the driver and the interface are the same when in this
case they are two separate things. If I manually make an interface using
ifconfig, it still doesn't change where it hangs though interestingly
enough if I set the address within the command to that of the interface,
then the interface will respond with `read from TUN/TAP returned 44`
followed by `Recursive routing detected, drop tun packet to []AF_INET]
1.1.1.1:1194` 1.1.1.1 being the address of the interface but only once and
that's it. Maybe I am confused about how that specific command works and/or
I have something set up wrong somewhere down the line. I know that this is
a complicated issue with many facets and I am new to OpenVPN so I'm not
super sure how to debug it currently so please please be patient with me
and ask questions so that I can do my best to answer them.

--000000000000c6fe15060137a06f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hello all, hopefully, this is the correct mailing lis=
t to ask this question, and sorry if it is long.</div><div><br></div><div>I=
 am trying to port OpenVPN to Haiku OS and I am currently having an issue a=
s I run this test command from the <a href=3D"https://github.com/OpenVPN/op=
envpn/blob/master/PORTS#L73">PORTS</a> file `<span style=3D"font-family:mon=
ospace">./openvpn --remote 64.233.160.0 --verb 9 --ping 1 --dev tun</span>`=
 as I get the expected output (comparing it to Linux at least) until it jus=
t hangs on the line <span style=3D"font-family:monospace">`I/O WAIT status=
=3D0x0004</span>`. I am not sure if this is a problem caused by the driver =
I am writing or OpenVPN not being able to run the do_ifconfig() command tha=
t has a TARGET_HAIKU definition and I wanted to ask you all about it. <a hr=
ef=3D"https://review.haiku-os.org/c/haiku/+/6608/15/src/add-ons/kernel/driv=
ers/network/tun/driver.cpp">Here</a> I have the driver source code, <a href=
=3D"https://review.haiku-os.org/c/haiku/+/6608/15/src/add-ons/kernel/networ=
k/devices/tun/tun.cpp">here</a> is the interface source code, and <a href=
=3D"https://github.com/Swangeon/Haiku-Openvpn/commit/9954e48fa35dcb4f77fe08=
863b1d12f0f3e29b72">here</a> I have a forked version of the OpenVPN source =
code where I added the definition for the OS and info on how to do the ifco=
nfig command on the system. I know that UDP sockets are working normally wi=
thin Haiku since I can switch the line `<span style=3D"font-family:monospac=
e">--dev tun</span>` to `<span style=3D"font-family:monospace">--dev null</=
span>` and it will work just fine. One problem that I think might be there =
is that it&#39;s not setting up a tun interface properly and/or it might be=
 going off of the assumption of a Linux driver where the driver and the int=
erface are the same when in this case they are two separate things. If I ma=
nually make an interface using ifconfig, it still doesn&#39;t change where =
it hangs though interestingly enough if I set the address within the comman=
d to that of the interface, then the interface will respond with `<span sty=
le=3D"font-family:monospace">read from TUN/TAP returned 44</span>` followed=
 by `<span style=3D"font-family:monospace">Recursive routing detected, drop=
 tun packet to []AF_INET]<a href=3D"http://1.1.1.1:1194">1.1.1.1:1194</a></=
span>` 1.1.1.1 being the address of the interface but only once and that&#3=
9;s it. Maybe I am confused about how that specific command works and/or I =
have something set up wrong somewhere down the line. I know that this is a =
complicated issue with many facets and I am new to OpenVPN so I&#39;m not s=
uper sure how to debug it currently so please please be patient with me and=
 ask questions so that I can do my best to answer them.<br></div></div>

--000000000000c6fe15060137a06f--

