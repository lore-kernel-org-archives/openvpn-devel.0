MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF80C424FD.27405071-ONC1257C07.004692C7-C1257C07.004BC866@...1846...>
Date: Thu, 17 Oct 2013 15:47:44 +0200
Content-Type: multipart/alternative;
	boundary="=_alternative 004BC7CBC1257C07_="
Subject: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after 24hours
	(addendum2)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multipart message in MIME format.
--=_alternative 004BC7CBC1257C07_=
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

Dear all,

unfortunately, the potential memory leak, first reported "Brad Zhang",=20
Sept. 27 2013, proves to be a real memory leak:

pls. see earlier parts of my story in attached eMails below, thank you.

We now have enlarged the time-window for the renegotiation process "
reneg-sec 86400" ->  172800 and additionally added "reneg-bytes 1024000"=20
to randomize the renegotiation phase of individual O-VPN clients and to=20
prevent the situation, all connected clients to start to renegotiate=20
within a time window of 5 minutes.

We still recongized the memory consumption of the openvpn process to start=
=20

to steadily increase, until the memory limit per process has become=20
reached and openvpn crashed as following:

Oct 15 12:13:15 ip-10-56-61-152 openvpn[21742]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)
Oct 15 12:13:16 ip-10-56-61-152 openvpn[21742]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)
Oct  15 12:13:16 ip-10-56-61-152 openvpn[21742]: Exiting due to fatal=20
error
Unfortunately, we never recognized, reserved memory for openvpn to start=20
to decreased, which is another sign for a memory leak.

Pls. can anyone provide me with a response, whether this mailing list is=20
the right place to deal with this kind of problem?
Thank you very much


freundlich gr=FCsst,
kind regards,

_________________________
_________________________
_________________________
_________________________
_________________________
________________=20

Arno Odermatt=20
Phone +41414454053=20
arno.odermatt@...1845...=20

Schindler Elevator Ltd. | Corporate Research & Development | CRD/CO-BAT=20
Zugerstr. 13 | CH-6030 Ebikon, Switzerland=20
http://www.schindler.com=20
_________________________
_________________________
_________________________
_________________________
_________________________
________________=20

Please consider your environment.=20

Schindler supports sustainable urban development with
safe, reliable and ecologically sound mobility solutions.


----- Forwarded by Arno Odermatt/R&D/SCH/SCHINDLER on 17.10.2013 14:50=20
-----

From:   Arno Odermatt/R&D/SCH/SCHINDLER
To:     openvpn-devel@lists.sourceforge.net,=20
Date:   10.10.2013 11:11
Subject:        Openvpn 2.3.2 potential memory-leak after 24hours=20
(addendum1)


Dear all,

we found our certificate renegotiating timer to be set to 86400secs =3D 24h.
Therefore, we strongly assume, potentially a memory leak occurs in the=20
renegotiating phase of the keys (passwords) as already earlier described=20
in the mailing-list by "Brad Zhang" (Sept. 27. 2013)  and=20
treated/discussed by David Sommerseth.


http://sourceforge.net/mailarchive/forum.php?thread_name=3D52456F61.3000104=
%40topphemmelig.net&forum_name=3Dopenvpn-devel


our server side config-file:
reneg-sec 86400


 more /etc/openvpn/server.cnf=20

;log /var/log/openvpn_cgwvpn.log

# Set server mode
mode server
float
management tunnel 7505
port 443
proto tcp-server
max-clients 5000

# Use Ethernet tunnel
dev tap

# The IPv4 addresses are used to establish the tunnel
# All traffic is routed using IPv6 addresses
ifconfig 172.16.0.1 255.255.128.0
ifconfig-pool 172.16.1.1 172.16.127.254 255.255.128.0

# Server certificate settings
tls-server
dh /etc/openvpn/servervpn/keys/dh1024.pem
ca /etc/openvpn/servervpn/keys/ca.crt
cert /etc/openvpn/servervpn/keys/CLTVpnSrv.crt
key /etc/openvpn/servervpn/keys/CLTVpnSrv.key

# Keep tunnel open
persist-tun
persist-key

# keep-alive ping
# -> keepalive 10 60
# will also be pushed to the client
# if mode server:
#   ping 10
#   ping-restart 120
#   push "ping 10"
#   push "ping-restart 60"
# else
#   ping 10
#   ping-restart 60
keepalive 240 600

# Renegotiate data channel key once per day
reneg-sec 86400

# optimize timout of slow GPRS connections
tcp-queue-limit 256
tcp-nodelay
tls-timeout 60
hand-window 120
sndbuf 262144
txqueuelen 400
bcast-buffers 4096

# enable LZO compression
comp-lzo

# moderate verbosity
verb 0
mute 10

#Execute scripts
script-security 2 system
up /etc/openvpn/servervpn/vpn-up.sh
down /etc/openvpn/servervpn/vpn-down.sh
client-connect /etc/openvpn/servervpn/client-connect.sh
client-disconnect /etc/openvpn/servervpn/client-disconnect.sh
tmp-dir /var/tmp
[root@...23... ~]

Any reply on this and idea for a soonest fix would be appreciated

thx and regards,=20

AO





From:   arno.odermatt@...1845...
To:     openvpn-devel@lists.sourceforge.net,=20
Date:   09.10.2013 19:19
Subject:        [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after=20
24hours



All,=20

we are running Openvpn 2.3.2 on Fedora17/64Bit with 8GByte RAM total (EoL,=
=20

yes we are aware) and seem to run into a memory leak situation, as=20
following:

- around 2955 Openvpn session running OK for 23'58"
- memory allocated 3247mByte, memory reserved 2.5gByte, CPU utilization=20
~1% (see "status-prior-o-vpnrestart-131009.rtf")
- script-security 2 (in openvpn.conf)=20

After exactly 24hours, allocated and reserved memory of the=20
openvpn-process start to increase in 1-2Mbyte steps, without seeing an=20
increase in the amount of Openvpn sessions and steps up to around=20
3970mByte for the allocated and 3.2gByte for the reserved memory. Then=20
Openvpn crashes! (see bottom "status-prior-o-vpnrestart-131009.rtf")

The behavior of this symptom has been recognized in Openvpn 2.2.2-7 and=20
2.3.2 as following:


> Openvpn 2.2.2-7: keeps reporting "external program fork failed"
=20
 2.2.2-7 endlessly keeps reporting a fork failed, when the client-connect=20
script should be executed, no new openvpn sessions can be established but=20
the process stays alive.=20

WARNING: Failed running command (--client-connect): external program fork=20
failed=20
WARNING: Failed running command (--client-connect): external program fork=20
failed=20
WARNING: Failed running command (--client-connect): external program fork=20
failed



> Openvpn 2.3.2: exiting due to fatal error (openvpn is killed)=20

When a certain memory stage from a perspective of allocated and reserved=20
memory is reached, following scenario happens:=20

Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error=
=20


Please, can you analyze the issue and send us a feedback about the=20
possible root cause and mitigation?

snip log:=20
------------------------------=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error=
=20


Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interface=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr del dev=20
tap1 172.16.0.1/17=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error=
=20


^C[ec2-user@...23... ~]$=20
[ec2-user@...23... ~]$ sudo tail -f /var/log/messages=20
Oct  9 15:40:27 ip-10-56-61-152 openvpn[25964]:=20
NL-200000134777/109.37.153.117:41299 NOTE: --mute triggered...=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]:=20
DE-2024460/139.7.160.82:42187 40 variation(s) on previous 10 message(s)=20
suppressed by --mute=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]:=20
DE-2024460/139.7.160.82:42187 Connection reset, restarting [0]=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]:=20
DE-2024460/139.7.160.82:42187 SIGUSR1[soft,connection-reset] received,=20
client-instance restarting=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error=
=20


Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interface=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr del dev=20
tap1 172.16.0.1/17=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to=20
fork: Cannot allocate memory (errno=3D12)=20
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error


thx and regards,=20

AO

_________________________
_________________________
_________________________
_________________________
_________________________
________________=20




******************************************************
Notice: The information contained in this message is intended only for use=
=20

of the individual(s) named above and may contain confidential, proprietary=
=20

or legally privileged information. No confidentiality or privilege is=20
waived or lost by any mistransmission. If you are not the intended=20
recipient of this message you are hereby notified that you must not use,=20
disseminate , copy it in any form or take any action in reliance of it. If=
=20

you have received this message in error please delete it and any copies of=
=20

it and notify the sender immediately.
*******************************************************[attachment=20
"status-prior-o-vpnrestart-131009.rtf" deleted by Arno=20
Odermatt/R&D/SCH/SCHINDLER]=20
---------------------------------------------------------------------------=
---
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most=20
from=20
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=3D60134071&iu=3D/4140/ostg.cl=
ktrk
_________________________
______________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

******************************************************
Notice: The information contained in this message is intended only for use =
of the individual(s) named above and may contain confidential, proprietary =
or legally privileged information. No confidentiality or privilege is waive=
d or lost by any mistransmission. If you are not the intended recipient of =
this message you are hereby notified that you must not use, disseminate , c=
opy it in any form or take any action in reliance of it. If you have receiv=
ed this message in error please delete it and any copies of it and notify t=
he sender immediately.
*******************************************************=

--=_alternative 004BC7CBC1257C07_=
Content-Type: text/html; charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<font size=3D2 face=3D"sans-serif">Dear all,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">unfortunately, the potential memory
leak, first reported </font><tt><font size=3D3>&quot;Brad Zhang</font></tt>=
<font size=3D2 face=3D"sans-serif">&quot;,
Sept. 27 2013, proves to be a real memory leak:</font>
<br>
<br><font size=3D2 face=3D"sans-serif">pls. see earlier parts of my story in
attached eMails below, thank you.</font>
<br>
<br><font size=3D2 face=3D"sans-serif">We now have enlarged the time-window
for the renegotiation process &quot;<b>reneg-sec 86400</b>&quot; -&gt;
&nbsp;172800 and additionally added &quot;reneg-bytes 1024000&quot; to
randomize the renegotiation phase of individual O-VPN clients and to prevent
the situation, all connected clients to start to renegotiate within a time
window of 5 minutes.<br>
</font>
<br><font size=3D2 face=3D"sans-serif">We still recongized the memory consu=
mption
of the openvpn process to start to steadily increase, until the memory
limit per process has become reached and openvpn crashed as following:<br>
<br>
</font><font size=3D2 face=3D"Calibri">Oct 15 12:13:15 ip-10-56-61-152 open=
vpn[21742]:
openvpn_execve: unable to fork: Cannot allocate memory (errno=3D12)</font>
<br><font size=3D2 face=3D"Calibri">Oct 15 12:13:16 ip-10-56-61-152 openvpn=
[21742]:
openvpn_execve: unable to fork: Cannot allocate memory (errno=3D12)</font><=
font size=3D2 face=3D"sans-serif"><br>
</font><font size=3D2 color=3Dred face=3D"Calibri">Oct </font><font size=3D=
2 face=3D"Calibri">&nbsp;</font><font size=3D2 color=3Dred face=3D"Calibri"=
>15
12:13:16 ip-10-56-61-152 openvpn[21742]: Exiting due to fatal error</font>
<p><font size=3D2 face=3D"sans-serif">Unfortunately, we never recognized, r=
eserved
memory for openvpn to start to decreased, which is another sign for a memory
leak.<br>
<br>
Pls. can anyone provide me with a response, whether this mailing list is
the right place to deal with this kind of problem?</font>
<p><font size=3D2 face=3D"sans-serif">Thank you very much<br>
</font>
<p><font size=3D2 face=3D"sans-serif"><br>
freundlich gr=FCsst,<br>
kind regards,<br>
</font><font size=3D1 face=3D"Arial"><br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D2 face=3D"sans-serif"><br>
Arno Odermatt <br>
Phone +41414454053 <br>
arno.odermatt@...1845... <br>
<br>
Schindler Elevator Ltd. | Corporate Research &amp; Development | CRD/CO-BAT
<br>
Zugerstr. 13 | CH-6030 Ebikon, Switzerland <br>
</font><a href=3Dhttp://www.schindler.com/><font size=3D2 face=3D"sans-seri=
f">http://www.schindler.com</font></a><font size=3D2 face=3D"sans-serif">
</font><font size=3D1 face=3D"Arial"><br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
Please consider your environment. <br>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
Schindler supports sustainable urban development with<br>
safe, reliable and ecologically sound mobility solutions.<br>
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
</font>
<br><font size=3D1 color=3D#800080 face=3D"sans-serif">----- Forwarded by A=
rno
Odermatt/R&amp;D/SCH/SCHINDLER on 17.10.2013 14:50 -----</font>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">Arno Odermatt/R&amp;D/SCH/S=
CHINDLER</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">openvpn-devel@...1535...=
orge.net,
</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">10.10.2013 11:11</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">Openvpn 2.3.2
potential memory-leak after 24hours (addendum1)</font>
<br>
<hr noshade>
<br>
<br><font size=3D2 face=3D"sans-serif">Dear all,</font>
<br>
<br><font size=3D2 face=3D"sans-serif">we found our certificate renegotiati=
ng
timer to be set to 86400secs =3D 24h.<br>
Therefore, we strongly assume, potentially a memory leak occurs in the
renegotiating phase of the keys (passwords) as already earlier described
in the mailing-list by </font><tt><font size=3D3>&quot;Brad Zhang&quot; (Se=
pt.
27. 2013) </font></tt><font size=3D2 face=3D"sans-serif">&nbsp;and treated/=
discussed
by David Sommerseth.</font>
<table width=3D100% style=3D"border-collapse:collapse;">
<tr height=3D8>
<td width=3D100% style=3D"border-style:solid;border-color:#000000;border-wi=
dth:0px 0px 0px 0px;padding:0px 0px;"><font size=3D1><br>
</font>
<table width=3D100% style=3D"border-collapse:collapse;">
<tr height=3D8>
<td width=3D100% style=3D"border-style:solid;border-color:#000000;border-wi=
dth:0px 0px 0px 0px;padding:1px 1px;"><a href=3D"http://sourceforge.net/mai=
larchive/forum.php?thread_name=3D52456F61.3000104%40topphemmelig.net&amp;fo=
rum_name=3Dopenvpn-devel"><tt><font size=3D3>http://sourceforge.net/mailarc=
hive/forum.php?thread_name=3D52456F61.3000104%40topphemmelig.net&amp;forum_=
name=3Dopenvpn-devel</font></tt></a></table>
<br></table>
<br>
<br><font size=3D2 face=3D"sans-serif">our server side config-file:</font>
<br><font size=3D2 face=3D"sans-serif"><b>reneg-sec 86400</b><br>
<br>
<br>
 more /etc/openvpn/server.cnf </font>
<br>
<br><font size=3D2 face=3D"sans-serif">;log /var/log/openvpn_cgwvpn.log</fo=
nt>
<br>
<br><font size=3D2 face=3D"sans-serif"># Set server mode</font>
<br><font size=3D2 face=3D"sans-serif">mode server</font>
<br><font size=3D2 face=3D"sans-serif">float</font>
<br><font size=3D2 face=3D"sans-serif">management tunnel 7505</font>
<br><font size=3D2 face=3D"sans-serif">port 443</font>
<br><font size=3D2 face=3D"sans-serif">proto tcp-server</font>
<br><font size=3D2 face=3D"sans-serif">max-clients 5000</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># Use Ethernet tunnel</font>
<br><font size=3D2 face=3D"sans-serif">dev tap</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># The IPv4 addresses are used to est=
ablish
the tunnel</font>
<br><font size=3D2 face=3D"sans-serif"># All traffic is routed using IPv6 a=
ddresses</font>
<br><font size=3D2 face=3D"sans-serif">ifconfig 172.16.0.1 255.255.128.0</f=
ont>
<br><font size=3D2 face=3D"sans-serif">ifconfig-pool 172.16.1.1 172.16.127.=
254
255.255.128.0</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># Server certificate settings</font>
<br><font size=3D2 face=3D"sans-serif">tls-server</font>
<br><font size=3D2 face=3D"sans-serif">dh /etc/openvpn/servervpn/keys/dh102=
4.pem</font>
<br><font size=3D2 face=3D"sans-serif">ca /etc/openvpn/servervpn/keys/ca.cr=
t</font>
<br><font size=3D2 face=3D"sans-serif">cert /etc/openvpn/servervpn/keys/CLT=
VpnSrv.crt</font>
<br><font size=3D2 face=3D"sans-serif">key /etc/openvpn/servervpn/keys/CLTV=
pnSrv.key</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># Keep tunnel open</font>
<br><font size=3D2 face=3D"sans-serif">persist-tun</font>
<br><font size=3D2 face=3D"sans-serif">persist-key</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># keep-alive ping</font>
<br><font size=3D2 face=3D"sans-serif"># -&gt; keepalive 10 60</font>
<br><font size=3D2 face=3D"sans-serif"># will also be pushed to the client<=
/font>
<br><font size=3D2 face=3D"sans-serif"># if mode server:</font>
<br><font size=3D2 face=3D"sans-serif"># &nbsp; ping 10</font>
<br><font size=3D2 face=3D"sans-serif"># &nbsp; ping-restart 120</font>
<br><font size=3D2 face=3D"sans-serif"># &nbsp; push &quot;ping 10&quot;</f=
ont>
<br><font size=3D2 face=3D"sans-serif"># &nbsp; push &quot;ping-restart 60&=
quot;</font>
<br><font size=3D2 face=3D"sans-serif"># else</font>
<br><font size=3D2 face=3D"sans-serif"># &nbsp; ping 10</font>
<br><font size=3D2 face=3D"sans-serif"># &nbsp; ping-restart 60</font>
<br><font size=3D2 face=3D"sans-serif">keepalive 240 600</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># Renegotiate data channel key once
per day</font>
<br><font size=3D2 face=3D"sans-serif"><b>reneg-sec 86400</b></font>
<br>
<br><font size=3D2 face=3D"sans-serif"># optimize timout of slow GPRS conne=
ctions</font>
<br><font size=3D2 face=3D"sans-serif">tcp-queue-limit 256</font>
<br><font size=3D2 face=3D"sans-serif">tcp-nodelay</font>
<br><font size=3D2 face=3D"sans-serif">tls-timeout 60</font>
<br><font size=3D2 face=3D"sans-serif">hand-window 120</font>
<br><font size=3D2 face=3D"sans-serif">sndbuf 262144</font>
<br><font size=3D2 face=3D"sans-serif">txqueuelen 400</font>
<br><font size=3D2 face=3D"sans-serif">bcast-buffers 4096</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># enable LZO compression</font>
<br><font size=3D2 face=3D"sans-serif">comp-lzo</font>
<br>
<br><font size=3D2 face=3D"sans-serif"># moderate verbosity</font>
<br><font size=3D2 face=3D"sans-serif">verb 0</font>
<br><font size=3D2 face=3D"sans-serif">mute 10</font>
<br>
<br><font size=3D2 face=3D"sans-serif">#Execute scripts</font>
<br><font size=3D2 face=3D"sans-serif">script-security 2 system</font>
<br><font size=3D2 face=3D"sans-serif">up /etc/openvpn/servervpn/vpn-up.sh<=
/font>
<br><font size=3D2 face=3D"sans-serif">down /etc/openvpn/servervpn/vpn-down=
.sh</font>
<br><font size=3D2 face=3D"sans-serif">client-connect /etc/openvpn/servervp=
n/client-connect.sh</font>
<br><font size=3D2 face=3D"sans-serif">client-disconnect /etc/openvpn/serve=
rvpn/client-disconnect.sh</font>
<br><font size=3D2 face=3D"sans-serif">tmp-dir /var/tmp</font>
<br><font size=3D2 face=3D"sans-serif">[root@...23... ~]</font>
<br>
<br><font size=3D2 face=3D"sans-serif">Any reply on this and idea for a soo=
nest
fix would be appreciated<br>
</font>
<br><font size=3D2 face=3D"sans-serif">thx and regards,</font><font size=3D=
3>
<br>
</font><font size=3D2 face=3D"sans-serif"><br>
AO<br>
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
</font>
<br>
<br>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">From: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">arno.odermatt@...1845...</f=
ont>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">To: &nbsp; &nbsp; &n=
bsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">openvpn-devel@...1535...=
orge.net,
</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Date: &nbsp; &nbsp; =
&nbsp;
&nbsp;</font><font size=3D1 face=3D"sans-serif">09.10.2013 19:19</font>
<br><font size=3D1 color=3D#5f5f5f face=3D"sans-serif">Subject: &nbsp; &nbs=
p;
&nbsp; &nbsp;</font><font size=3D1 face=3D"sans-serif">[Openvpn-devel]
Openvpn 2.3.2 potential memory-leak after 24hours</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=3D2 face=3D"sans-serif">All,</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
we are running Openvpn 2.3.2 on Fedora17/64Bit with 8GByte RAM total (EoL,
yes we are aware) and seem to run into a memory leak situation, as followin=
g:<br>
<br>
- around 2955 Openvpn session running OK for 23'58&quot;<br>
- memory allocated 3247mByte, memory reserved 2.5gByte, CPU utilization
~1% (see &quot;status-prior-o-vpnrestart-131009.rtf&quot;)<br>
- script-security 2 (in openvpn.conf)</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
After exactly 24hours, allocated and reserved memory of the openvpn-process
start to increase in 1-2Mbyte steps, without seeing an increase in the
amount of Openvpn sessions and steps up to around 3970mByte for the allocat=
ed
and 3.2gByte for the reserved memory. Then Openvpn crashes! (see bottom
&quot;status-prior-o-vpnrestart-131009.rtf&quot;)<br>
<br>
The behavior of this symptom has been recognized in Openvpn 2.2.2-7 and
2.3.2 as following:</font><font size=3D3><br>
<br>
</font><font size=3D2 face=3D"sans-serif"><br>
&gt; Openvpn 2.2.2-7: keeps reporting &quot;</font><font size=3D2 face=3D"C=
alibri">external
program fork failed</font><font size=3D2 face=3D"sans-serif">&quot;<br>
 &nbsp;<br>
 2.2.2-7 endlessly keeps reporting a fork failed, when the client-connect
script should be executed, no new openvpn sessions can be established but
the process stays alive.</font><font size=3D3> <br>
</font><font size=3D2 face=3D"Calibri"><br>
WARNING: Failed running command (--client-connect): external program fork
failed</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
WARNING: Failed running command (--client-connect): external program fork
failed</font><font size=3D3> </font><font size=3D2 face=3D"Calibri"><br>
WARNING: Failed running command (--client-connect): external program fork
failed</font><font size=3D2 face=3D"sans-serif"><br>
</font><font size=3D3><br>
<br>
</font><font size=3D2 face=3D"sans-serif"><br>
&gt; Openvpn 2.3.2: exiting due to fatal error (openvpn is killed)</font><f=
ont size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
<br>
When a certain memory stage from a perspective of allocated and reserved
memory is reached, following scenario happens:</font><font size=3D3> </font=
><font size=3D2 face=3D"sans-serif"><br>
</font><font size=3D2 color=3Dred face=3D"Calibri"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=3D12)</font><font size=3D3> </font><=
font size=3D2 color=3Dred face=3D"Calibri"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3D3> </font>
<p><font size=3D2 face=3D"sans-serif">Please, can you analyze the issue and
send us a feedback about the possible root cause and mitigation?</font><fon=
t size=3D3><br>
</font><font size=3D2 face=3D"sans-serif"><br>
snip log:</font><font size=3D3> </font><font size=3D2 face=3D"sans-serif"><=
br>
------------------------------</font><font size=3D3> </font><font size=3D2 =
face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=3D12)</font><font size=3D3> </font><=
font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3D3> </font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interf=
ace</font><font size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr
del dev tap1 172.16.0.1/17</font><font size=3D3> </font><font size=3D2 face
=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=3D12)</font><font size=3D3> </font><=
font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3D3> </font><font size=3D2 face=3D"sans-serif"><br>
^C[ec2-user@...23... ~]$</font><font size=3D3> </font><font size=3D2 face
=3D"sans-serif"><br>
[ec2-user@...23... ~]$ sudo tail -f /var/log/messages</font><font size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:27 ip-10-56-61-152 openvpn[25964]: NL-200000134777/109.37=
.153.117:41299
NOTE: --mute triggered...</font><font size=3D3> </font><font size=3D2 face
=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: DE-2024460/139.7.160.8=
2:42187
40 variation(s) on previous 10 message(s) suppressed by --mute</font><font =
size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: DE-2024460/139.7.160.8=
2:42187
Connection reset, restarting [0]</font><font size=3D3> </font><font size=3D=
2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: DE-2024460/139.7.160.8=
2:42187
SIGUSR1[soft,connection-reset] received, client-instance restarting</font><=
font size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=3D12)</font><font size=3D3> </font><=
font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3D3> </font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interf=
ace</font><font size=3D3>
</font><font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr
del dev tap1 172.16.0.1/17</font><font size=3D3> </font><font size=3D2 face
=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=3D12)</font><font size=3D3> </font><=
font size=3D2 face=3D"sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: <b>Exiting due to
fatal error</b><br>
</font><font size=3D3><br>
</font><font size=3D2 face=3D"sans-serif"><br>
thx and regards,</font><font size=3D3> <br>
</font><font size=3D2 face=3D"sans-serif"><br>
AO</font><font size=3D1 face=3D"Arial"><br>
<br>
_________________________
_________________________
_________________________
_________________________
_________________________
________________
</font><font size=3D1 color=3D#5f5f5f face=3D"Arial"><br>
</font><font size=3D1 color=3D#008000 face=3D"Arial"><br>
</font><font size=3D3><br>
<br>
******************************************************<br>
Notice: The information contained in this message is intended only for
use of the individual(s) named above and may contain confidential, propriet=
ary
or legally privileged information. No confidentiality or privilege is waived
or lost by any mistransmission. If you are not the intended recipient of
this message you are hereby notified that you must not use, disseminate
, copy it in any form or take any action in reliance of it. If you have
received this message in error please delete it and any copies of it and
notify the sender immediately.<br>
*******************************************************[attachment &quot;st=
atus-prior-o-vpnrestart-131009.rtf&quot;
deleted by Arno Odermatt/R&amp;D/SCH/SCHINDLER] </font><tt><font size=3D2>-=
---------------------------------------------------------------------------=
--<br>
October Webinars: Code for Performance<br>
Free Intel webinars can help you accelerate application performance.<br>
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most
from <br>
the latest Intel processors and coprocessors. See abstracts and register
&gt;<br>
</font></tt><a href=3D"http://pubads.g.doubleclick.net/gampad/clk?id=3D6013=
4071&amp;iu=3D/4140/ostg.clktrk"><tt><font size=3D2>http://pubads.g.doublec=
lick.net/gampad/clk?id=3D60134071&amp;iu=3D/4140/ostg.clktrk</font></tt></a=
><tt><font size=3D2>__________________
_________________________
____<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
</font></tt><a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn=
-devel"><tt><font size=3D2>https://lists.sourceforge.net/lists/listinfo/ope=
nvpn-devel</font></tt></a><tt><font size=3D2><br>
</font></tt><br clear=3D"both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use =
of the individual(s) named above and may contain confidential, proprietary =
or legally privileged information. No confidentiality or privilege is waive=
d or lost by any mistransmission. If you are not the intended recipient of =
this message you are hereby notified that you must not use, disseminate , c=
opy it in any form or take any action in reliance of it. If you have receiv=
ed this message in error please delete it and any copies of it and notify t=
he sender immediately.<BR>
*******************************************************<BR>

--=_alternative 004BC7CBC1257C07_=--

