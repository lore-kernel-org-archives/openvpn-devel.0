MIME-Version: 1.0
Date: Tue, 25 May 2010 10:30:54 +0300
Message-ID: <AANLkTinWsHCrRh6n-ABKzbBY2XLiGqVTgrBCzfv9s3LW@...278...>
From: "nivwiz@...277..." <nivwiz@...277...>
Content-Type: multipart/alternative; boundary=001636c5bac944542c0487662302
Subject: [Openvpn-devel] bug: can't get dhcp using --up option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--001636c5bac944542c0487662302
Content-Type: text/plain; charset=ISO-8859-1

Hi all,
I want to report this bug:

1. if I run:
 openvpn --cd /etc/openvpn/ --script-security 2  --up "/etc/init.d/udhcpc
start" \
 --config $CONFIG_DIR/$NAME.conf
udhcp doesnt set dhcp as it should even if you add -up-delay --down-pre

here is the openvpn log:
Tue Mar 23 10:03:11 2010 TUN/TAP device tap0 opened
Tue Mar 23 10:03:11 2010 TUN/TAP TX queue length set to 100
Tue Mar 23 10:03:11 2010 /etc/init.d/udhcpc start tap0 1500 1574   init
Starting Openvpn dhcp client for tap0:  params: --now --no-zeroconf -i tap0 -s
/etc/openvpn/udhcp.script --pidfile=/var/run/udhcpc..pid
tap0      Link encap:Ethernet  HWaddr FE:3D:5B:EB:B1:7B
          BROADCAST MULTICAST  MTU:1500  Metric:1
          RX packets:0 errors:0 dropped:0 overruns:0 frame:0
          TX packets:0 errors:0 dropped:0 overruns:0 carrier:0
          collisions:0 txqueuelen:100
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)

 going to req dhcp for fe:3d:5b:eb:b1:7b
udhcpc (v0.9.9-pre) started
Sending discover...
Sending discover...
Sending discover...
Sending discover...
No lease, failing.
sleepnow
udhcpc (v0.9.9-pre) started
Sending discover...
Sending discover...
Sending discover...
Sending discover...
No lease, failing.
sleepnow


2. If I run:
 openvpn --cd /etc/openvpn/ --config $CONFIG_DIR/$NAME.conf
then run /etc/init.d/udhcpc start
I get udhcp to setup dhcp.

so this bug report means that one can't use the --up argument to launch udhcpc
as described in the official docs of openvpn


I am using openvpn on maemo linux on the N900 in layer 2 connection , so
after establishing connection I need to issue a dhcp request.

Regards,
Niv

--001636c5bac944542c0487662302
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi all,<br>I want to report this bug:<br><pre id=3D"commen=
t_text_10">1. if I run:<br> openvpn --cd /etc/openvpn/ --script-security 2 =
 --up &quot;/etc/init.d/udhcpc<br>start&quot; \<br> --config $CONFIG_DIR/$N=
AME.conf<br>
udhcp doesnt set dhcp as it should even if you add -up-delay --down-pre<br>=
<br>here is the openvpn log:<br>Tue Mar 23 10:03:11 2010 TUN/TAP device tap=
0 opened<br>Tue Mar 23 10:03:11 2010 TUN/TAP TX queue length set to 100<br>
Tue Mar 23 10:03:11 2010 /etc/init.d/udhcpc start tap0 1500 1574   init<br>=
Starting Openvpn dhcp client for tap0:  params: --now --no-zeroconf -i tap0=
 -s<br>/etc/openvpn/udhcp.script --pidfile=3D/var/run/udhcpc..pid <br>tap0 =
     Link encap:Ethernet  HWaddr FE:3D:5B:EB:B1:7B  <br>
          BROADCAST MULTICAST  MTU:1500  Metric:1<br>          RX packets:0=
 errors:0 dropped:0 overruns:0 frame:0<br>          TX packets:0 errors:0 d=
ropped:0 overruns:0 carrier:0<br>          collisions:0 txqueuelen:100 <br>
          RX bytes:0 (0.0 B)  TX bytes:0 (0.0 B)<br><br> going to req dhcp =
for fe:3d:5b:eb:b1:7b<br>udhcpc (v0.9.9-pre) started<br>Sending discover...=
<br>Sending discover...<br>Sending discover...<br>Sending discover...<br>
No lease, failing.<br>sleepnow<br>udhcpc (v0.9.9-pre) started<br>Sending di=
scover...<br>Sending discover...<br>Sending discover...<br>Sending discover=
...<br>No lease, failing.<br>sleepnow<br><br><br>2. If I run:<br> openvpn -=
-cd /etc/openvpn/ --config $CONFIG_DIR/$NAME.conf<br>
then run /etc/init.d/udhcpc start<br>I get udhcp to setup dhcp.<br><br>so t=
his bug report means that one can&#39;t use the --up argument to launch udh=
cpc<br>as described in the official docs of openvpn<br></pre>
=20=20=20=20

<br>I am using openvpn on maemo linux on the N900 in layer 2 connection , s=
o after establishing connection I need to issue a dhcp request.<br><br>Rega=
rds,<br>Niv<br></div>

--001636c5bac944542c0487662302--

