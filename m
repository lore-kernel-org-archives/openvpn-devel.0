Message-ID: <1347538873.18716.YahooMailNeo@...1760...>
Date: Thu, 13 Sep 2012 05:21:13 -0700 (PDT)
From: Raj Kumar <raj_kumar_sh@...109...>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="-1658718958-729068439-1347538873=:18716"
Subject: [Openvpn-devel] Controlling the vpn tunnel traffic
Reply-To: Raj Kumar <raj_kumar_sh@...109...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

---1658718958-729068439-1347538873=:18716
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hi All,

I have one PC on which=A0 OpenVpn server is=A0 running and 3 MIPS based emb=
edded devices=A0 on which OpenVpn clients are running.
They all are connected using Ethernet Gigabit switch. All devices are runni=
ng on Linux.


I stream video to all the 3 devices from the PC using VPN.=20

If i stream data at 50Mbps,=A0 2 devices are working fine. But 3rd device i=
s equipped with slightly low end processor and this device=A0 restarts.=20

But this device works fine if=A0 I stream=A0 at 35 Mbps.=20


Is there any way i can configure OpenVpn server in such a way that it can s=
tream data at 50 Mbps to the first 2 devices and=20

at 35 Mbps to the 3rd device.=A0 Can I use "-shaper n" option to limit the =
bandwidth.=20


Please help me.




HW Configurations

--------------
1 )PC=20

=A0=A0=A0=A0=A0=A0=A0 Intel(R) Core(TM) i3-2100 CPU @ 3.10GHz
=A0=A0=A0=A0=A0=A0=A0 RAM - 4 GB

=A0=A0=A0=A0=A0=A0=A0 Linux :-=A0 Centos - 5
=A0=A0=A0=A0=A0=A0=A0 OpenVpn :- openvpn-2.1.1


2) Embedded Device=20

=A0=A0=A0 Core :-=A0 MIPS 800 Mhz

=A0=A0=A0 RAM - 256 MB

=A0=A0=A0 Linux - 2.6.29.2=20

=A0=A0=A0  OpenVpn :- openvpn-2.1.1


3) Embedded Device=20

=A0=A0=A0 Core :-=A0 MIPS 600 Mhz

=A0=A0=A0 RAM - 256 MB

=A0=A0=A0 Linux - 2.6.29.2=20

=A0=A0=A0  OpenVpn :- openvpn-2.1.1



OpenVpn Server Configuration=20

-----------------------------

# IMPORTANT: For comments on any of the setting below, please
#=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 read server.conf.README file


server=A0 192.168.0.0 255.255.0.0
port=A0=A0=A0 1194
ca=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/cert/internal/ab=
c.chain=20
cert=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/cert/internal/abc.ce=
r=20
key=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/cert/internal/abc.=
key=20
askpass=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/cert/internal/abc.pwd=20


dh=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/etc/openvp=
n/2.0/keys/dh1024.pem
log-append=A0=A0=A0=A0=A0=A0=A0=A0 /var/log/openvpn.log
status=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 /opt/var/log/openvpn.st=
atus

proto=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 udp
dev=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 tun
ifconfig-pool-persist ipp.txt 3600
topology=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 subnet
max-clients=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 65532
keepalive=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 10 120=20
cipher=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 AES-128-CBC
script-security=A0=A0=A0=A0=A0=A0 3=20
verb=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 4
mute=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 1

-----------------------------------------------------------------------






Please let me know if more data is required.



Thanks and Regards
Raj Kumar S=

---1658718958-729068439-1347538873=:18716
Content-Type: text/html; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

<html><body><div style=3D"color:#000; background-color:#fff; font-family:ve=
rdana, helvetica, sans-serif;font-size:10pt"><div><br></div><div style=3D"c=
olor: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sa=
ns-serif; background-color: transparent; font-style: normal;">Hi All,</div>=
<div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verda=
na,helvetica,sans-serif; background-color: transparent; font-style: normal;=
"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-f=
amily: verdana,helvetica,sans-serif; background-color: transparent; font-st=
yle: normal;">I have one PC on which&nbsp; OpenVpn server is&nbsp; running =
and 3 MIPS based embedded devices&nbsp; on which OpenVpn clients are runnin=
g.</div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-famil=
y: verdana,helvetica,sans-serif; background-color: transparent; font-style:=
 normal;">They all are connected using Ethernet Gigabit switch. All devices
 are running on Linux.<br></div><div style=3D"color: rgb(0, 0, 0); font-siz=
e: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: =
transparent; font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, =
0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; backgr=
ound-color: transparent; font-style: normal;">I stream video to all the 3 d=
evices from the PC using VPN. <br></div><div style=3D"color: rgb(0, 0, 0); =
font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; background=
-color: transparent; font-style: normal;">If i stream data at 50Mbps,&nbsp;=
 2 devices are working fine. But 3rd device is equipped with slightly low e=
nd processor and this device&nbsp; restarts. <br></div><div style=3D"color:=
 rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-se=
rif; background-color: transparent; font-style: normal;">But this device wo=
rks fine if&nbsp; I stream&nbsp; at 35 Mbps. <br></div><div style=3D"color:
 rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-se=
rif; background-color: transparent; font-style: normal;"><br></div><div sty=
le=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helve=
tica,sans-serif; background-color: transparent; font-style: normal;">Is the=
re any way i can configure OpenVpn server in such a way that it can stream =
data at 50 Mbps to the first 2 devices and <br></div><div style=3D"color: r=
gb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-seri=
f; background-color: transparent; font-style: normal;">at 35 Mbps to the 3r=
d device.&nbsp; Can I use "-shaper n" option to limit the bandwidth. <br></=
div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: v=
erdana,helvetica,sans-serif; background-color: transparent; font-style: nor=
mal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; fo=
nt-family: verdana,helvetica,sans-serif; background-color: transparent;
 font-style: normal;">Please help me.</div><div style=3D"color: rgb(0, 0, 0=
); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; backgro=
und-color: transparent; font-style: normal;"><br></div><div style=3D"color:=
 rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-se=
rif; background-color: transparent; font-style: normal;"><br></div><div sty=
le=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helve=
tica,sans-serif; background-color: transparent; font-style: normal;"><br></=
div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: v=
erdana,helvetica,sans-serif; background-color: transparent; font-style: nor=
mal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; fo=
nt-family: verdana,helvetica,sans-serif; background-color: transparent; fon=
t-style: normal;">HW Configurations<br></div><div style=3D"color: rgb(0, 0,=
 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif;
 background-color: transparent; font-style: normal;">--------------</div><d=
iv style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana=
,helvetica,sans-serif; background-color: transparent; font-style: normal;">=
1 )PC <br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; fo=
nt-family: verdana,helvetica,sans-serif; background-color: transparent; fon=
t-style: normal;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Intel(R) Core(=
TM) i3-2100 CPU @ 3.10GHz</div><div style=3D"color: rgb(0, 0, 0); font-size=
: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: t=
ransparent; font-style: normal;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
 RAM - 4 GB<br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333p=
x; font-family: verdana,helvetica,sans-serif; background-color: transparent=
; font-style: normal;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Linux :-&=
nbsp; Centos - 5</div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333=
px;
 font-family: verdana,helvetica,sans-serif; background-color: transparent; =
font-style: normal;">&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; OpenVpn :- =
openvpn-2.1.1</div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px;=
 font-family: verdana,helvetica,sans-serif; background-color: transparent; =
font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size=
: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: t=
ransparent; font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0=
); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; backgro=
und-color: transparent; font-style: normal;">2) Embedded Device <br></div><=
div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdan=
a,helvetica,sans-serif; background-color: transparent; font-style: normal;"=
>&nbsp;&nbsp;&nbsp; Core :-&nbsp; MIPS 800 Mhz<br></div><div style=3D"color=
: rgb(0, 0, 0); font-size: 13.3333px; font-family:
 verdana,helvetica,sans-serif; background-color: transparent; font-style: n=
ormal;">&nbsp;&nbsp;&nbsp; RAM - 256 MB<br></div><div style=3D"color: rgb(0=
, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; b=
ackground-color: transparent; font-style: normal;">&nbsp;&nbsp;&nbsp; Linux=
 - 2.6.29.2 <br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333=
px; font-family: verdana,helvetica,sans-serif; background-color: transparen=
t; font-style: normal;">&nbsp;&nbsp;&nbsp;  OpenVpn :- openvpn-2.1.1</div><=
div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdan=
a,helvetica,sans-serif; background-color: transparent; font-style: normal;"=
><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-fa=
mily: verdana,helvetica,sans-serif; background-color: transparent; font-sty=
le: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.333=
3px; font-family: verdana,helvetica,sans-serif; background-color: transpare=
nt;
 font-style: normal;">3) Embedded Device <br></div><div style=3D"color: rgb=
(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif;=
 background-color: transparent; font-style: normal;">&nbsp;&nbsp;&nbsp; Cor=
e :-&nbsp; MIPS 600 Mhz<br></div><div style=3D"color: rgb(0, 0, 0); font-si=
ze: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color:=
 transparent; font-style: normal;">&nbsp;&nbsp;&nbsp; RAM - 256 MB<br></div=
><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verd=
ana,helvetica,sans-serif; background-color: transparent; font-style: normal=
;">&nbsp;&nbsp;&nbsp; Linux - 2.6.29.2 <br></div><div style=3D"color: rgb(0=
, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; b=
ackground-color: transparent; font-style: normal;">&nbsp;&nbsp;&nbsp;  Open=
Vpn :- openvpn-2.1.1</div><div style=3D"color: rgb(0, 0, 0); font-size: 13.=
3333px; font-family: verdana,helvetica,sans-serif; background-color:
 transparent; font-style: normal;"><br></div><div style=3D"color: rgb(0, 0,=
 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; backg=
round-color: transparent; font-style: normal;"><br></div><div style=3D"colo=
r: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-=
serif; background-color: transparent; font-style: normal;"><br></div><div s=
tyle=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,hel=
vetica,sans-serif; background-color: transparent; font-style: normal;">Open=
Vpn Server Configuration <br></div><div style=3D"color: rgb(0, 0, 0); font-=
size: 13.3333px; font-family: verdana,helvetica,sans-serif; background-colo=
r: transparent; font-style: normal;">-----------------------------</div><di=
v style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,=
helvetica,sans-serif; background-color: transparent; font-style: normal;"><=
br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-fami=
ly:
 verdana,helvetica,sans-serif; background-color: transparent; font-style: n=
ormal;"># IMPORTANT: For comments on any of the setting below, please<br>#&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; read serv=
er.conf.README file<br></div><div style=3D"color: rgb(0, 0, 0); font-size: =
13.3333px; font-family: verdana,helvetica,sans-serif; background-color: tra=
nsparent; font-style: normal;"><br>server&nbsp; 192.168.0.0 255.255.0.0<br>=
port&nbsp;&nbsp;&nbsp; 1194<br>ca&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /opt/cert/inte=
rnal/abc.chain <br>cert&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /opt/cert/internal/abc.cer <br>key&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp; /opt/cert/internal/abc.key <br>askpass&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
 /opt/cert/internal/abc.pwd <br><br><br>dh&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp; /opt/etc/openvpn/2.0/keys/dh1024.pem<br>log-append&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; /var/log/openvpn.log<br>status&nbsp;&nbsp;&n=
bsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
; /opt/var/log/openvpn.status<br><br>proto&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; udp<br>dev&=
nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; tun<br>ifconfig-pool-persist ipp.txt 3600<=
br>topology&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp; subnet<br>max-clients&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp; 65532<br>keepalive&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 10 120
 <br>cipher&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp; AES-128-CBC<br>script-security&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 3 <br>verb&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbs=
p;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; 4<br>mute&nbsp;&nb=
sp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;=
&nbsp;&nbsp;&nbsp; 1<br></div><div style=3D"color: rgb(0, 0, 0); font-size:=
 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: tr=
ansparent; font-style: normal;">-------------------------------------------=
----------------------------<br></div><div style=3D"color: rgb(0, 0, 0); fo=
nt-size: 13.3333px; font-family: verdana,helvetica,sans-serif; background-c=
olor: transparent; font-style: normal;"><br></div><div style=3D"color: rgb(=
0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans-serif; =
background-color: transparent; font-style: normal;"><br></div><div
 style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,h=
elvetica,sans-serif; background-color: transparent; font-style: normal;"><b=
r></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-famil=
y: verdana,helvetica,sans-serif; background-color: transparent; font-style:=
 normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px=
; font-family: verdana,helvetica,sans-serif; background-color: transparent;=
 font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-siz=
e: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: =
transparent; font-style: normal;">Please let me know if more data is requir=
ed.<br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-=
family: verdana,helvetica,sans-serif; background-color: transparent; font-s=
tyle: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3=
333px; font-family: verdana,helvetica,sans-serif; background-color: transpa=
rent;
 font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-siz=
e: 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: =
transparent; font-style: normal;">Thanks and Regards</div><div style=3D"col=
or: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helvetica,sans=
-serif; background-color: transparent; font-style: normal;">Raj Kumar S<br>=
</div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family:=
 verdana,helvetica,sans-serif; background-color: transparent; font-style: n=
ormal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; =
font-family: verdana,helvetica,sans-serif; background-color: transparent; f=
ont-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size:=
 13.3333px; font-family: verdana,helvetica,sans-serif; background-color: tr=
ansparent; font-style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0)=
; font-size: 13.3333px; font-family: verdana,helvetica,sans-serif;
 background-color: transparent; font-style: normal;"><br></div><div style=
=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: verdana,helveti=
ca,sans-serif; background-color: transparent; font-style: normal;"><br></di=
v><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font-family: ver=
dana,helvetica,sans-serif; background-color: transparent; font-style: norma=
l;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.3333px; font=
-family: verdana,helvetica,sans-serif; background-color: transparent; font-=
style: normal;"><br></div><div style=3D"color: rgb(0, 0, 0); font-size: 13.=
3333px; font-family: verdana,helvetica,sans-serif; background-color: transp=
arent; font-style: normal;"></div></div></body></html>=

---1658718958-729068439-1347538873=:18716--

