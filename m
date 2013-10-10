MIME-Version: 1.0
From: arno.odermatt@...1845...
Message-ID: <OF84EDADBC.E6A45A95-ONC1257C00.00301BFD-C1257C00.003278C0@...1846...>
Date: Thu, 10 Oct 2013 11:11:16 +0200
Content-Type: multipart/mixed; boundary="=_mixed 00327682C1257C00_="
Subject: [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after 24hours
	(addendum1)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--=_mixed 00327682C1257C00_=
Content-Type: multipart/alternative;
	boundary="=_alternative 00327682C1257C00_="

--=_alternative 00327682C1257C00_=
Content-Type: text/plain; charset="US-ASCII"

Dear all,

we found our certificate renegotiating timer to be set to 86400secs = 24h.
Therefore, we strongly assume, potentially a memory leak occurs in the 
renegotiating phase of the keys (passwords) as already earlier described 
in the mailing-list by "Brad Zhang" (Sept. 27. 2013)  and 
treated/discussed by David Sommerseth.


http://sourceforge.net/mailarchive/forum.php?thread_name=52456F61.3000104%40topphemmelig.net&forum_name=openvpn-devel


our server side config-file:
reneg-sec 86400


 more /etc/openvpn/server.cnf 

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

thx and regards, 

AO





From:   arno.odermatt@...1845...
To:     openvpn-devel@lists.sourceforge.net, 
Date:   09.10.2013 19:19
Subject:        [Openvpn-devel] Openvpn 2.3.2 potential memory-leak after 
24hours



All, 

we are running Openvpn 2.3.2 on Fedora17/64Bit with 8GByte RAM total (EoL, 
yes we are aware) and seem to run into a memory leak situation, as 
following:

- around 2955 Openvpn session running OK for 23'58"
- memory allocated 3247mByte, memory reserved 2.5gByte, CPU utilization 
~1% (see "status-prior-o-vpnrestart-131009.rtf")
- script-security 2 (in openvpn.conf) 

After exactly 24hours, allocated and reserved memory of the 
openvpn-process start to increase in 1-2Mbyte steps, without seeing an 
increase in the amount of Openvpn sessions and steps up to around 
3970mByte for the allocated and 3.2gByte for the reserved memory. Then 
Openvpn crashes! (see bottom "status-prior-o-vpnrestart-131009.rtf")

The behavior of this symptom has been recognized in Openvpn 2.2.2-7 and 
2.3.2 as following:


> Openvpn 2.2.2-7: keeps reporting "external program fork failed"
 
 2.2.2-7 endlessly keeps reporting a fork failed, when the client-connect 
script should be executed, no new openvpn sessions can be established but 
the process stays alive. 

WARNING: Failed running command (--client-connect): external program fork 
failed 
WARNING: Failed running command (--client-connect): external program fork 
failed 
WARNING: Failed running command (--client-connect): external program fork 
failed



> Openvpn 2.3.2: exiting due to fatal error (openvpn is killed) 

When a certain memory stage from a perspective of allocated and reserved 
memory is reached, following scenario happens: 

Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to 
fork: Cannot allocate memory (errno=12) 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error 

Please, can you analyze the issue and send us a feedback about the 
possible root cause and mitigation?

snip log: 
------------------------------ 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to 
fork: Cannot allocate memory (errno=12) 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error 

Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interface 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr del dev 
tap1 172.16.0.1/17 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to 
fork: Cannot allocate memory (errno=12) 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error 

^C[ec2-user@...23... ~]$ 
[ec2-user@...23... ~]$ sudo tail -f /var/log/messages 
Oct  9 15:40:27 ip-10-56-61-152 openvpn[25964]: 
NL-200000134777/109.37.153.117:41299 NOTE: --mute triggered... 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: 
DE-2024460/139.7.160.82:42187 40 variation(s) on previous 10 message(s) 
suppressed by --mute 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: 
DE-2024460/139.7.160.82:42187 Connection reset, restarting [0] 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: 
DE-2024460/139.7.160.82:42187 SIGUSR1[soft,connection-reset] received, 
client-instance restarting 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to 
fork: Cannot allocate memory (errno=12) 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error 

Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interface 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr del dev 
tap1 172.16.0.1/17 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable to 
fork: Cannot allocate memory (errno=12) 
Oct  9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal error


thx and regards, 

AO

_____________________________________________________________________________________________________________________________________________ 




******************************************************
Notice: The information contained in this message is intended only for use 
of the individual(s) named above and may contain confidential, proprietary 
or legally privileged information. No confidentiality or privilege is 
waived or lost by any mistransmission. If you are not the intended 
recipient of this message you are hereby notified that you must not use, 
disseminate , copy it in any form or take any action in reliance of it. If 
you have received this message in error please delete it and any copies of 
it and notify the sender immediately.
*******************************************************
------------------------------------------------------------------------------
October Webinars: Code for Performance
Free Intel webinars can help you accelerate application performance.
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most 
from 
the latest Intel processors and coprocessors. See abstracts and register >
http://pubads.g.doubleclick.net/gampad/clk?id=60134071&iu=/4140/ostg.clktrk
_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel


******************************************************
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.
*******************************************************
--=_alternative 00327682C1257C00_=
Content-Type: text/html; charset="US-ASCII"

<font size=2 face="sans-serif">Dear all,</font>
<br>
<br><font size=2 face="sans-serif">we found our certificate renegotiating
timer to be set to 86400secs = 24h.<br>
Therefore, we strongly assume, potentially a memory leak occurs in the
renegotiating phase of the keys (passwords) as already earlier described
in the mailing-list by </font><tt><font size=3>&quot;Brad Zhang&quot; (Sept.
27. 2013) </font></tt><font size=2 face="sans-serif">&nbsp;and treated/discussed
by David Sommerseth.</font>
<table width=100% style="border-collapse:collapse;">
<tr height=8>
<td width=100% style="border-style:solid;border-color:#000000;border-width:0px 0px 0px 0px;padding:0px 0px;"><font size=1><br>
</font>
<table width=100% style="border-collapse:collapse;">
<tr height=8>
<td width=100% style="border-style:solid;border-color:#000000;border-width:0px 0px 0px 0px;padding:1px 1px;"><a href="http://sourceforge.net/mailarchive/forum.php?thread_name=52456F61.3000104%40topphemmelig.net&amp;forum_name=openvpn-devel"><tt><font size=3>http://sourceforge.net/mailarchive/forum.php?thread_name=52456F61.3000104%40topphemmelig.net&amp;forum_name=openvpn-devel</font></tt></a></table>
<br></table>
<br>
<br><font size=2 face="sans-serif">our server side config-file:</font>
<br><font size=2 face="sans-serif"><b>reneg-sec 86400</b><br>
<br>
<br>
 more /etc/openvpn/server.cnf </font>
<br>
<br><font size=2 face="sans-serif">;log /var/log/openvpn_cgwvpn.log</font>
<br>
<br><font size=2 face="sans-serif"># Set server mode</font>
<br><font size=2 face="sans-serif">mode server</font>
<br><font size=2 face="sans-serif">float</font>
<br><font size=2 face="sans-serif">management tunnel 7505</font>
<br><font size=2 face="sans-serif">port 443</font>
<br><font size=2 face="sans-serif">proto tcp-server</font>
<br><font size=2 face="sans-serif">max-clients 5000</font>
<br>
<br><font size=2 face="sans-serif"># Use Ethernet tunnel</font>
<br><font size=2 face="sans-serif">dev tap</font>
<br>
<br><font size=2 face="sans-serif"># The IPv4 addresses are used to establish
the tunnel</font>
<br><font size=2 face="sans-serif"># All traffic is routed using IPv6 addresses</font>
<br><font size=2 face="sans-serif">ifconfig 172.16.0.1 255.255.128.0</font>
<br><font size=2 face="sans-serif">ifconfig-pool 172.16.1.1 172.16.127.254
255.255.128.0</font>
<br>
<br><font size=2 face="sans-serif"># Server certificate settings</font>
<br><font size=2 face="sans-serif">tls-server</font>
<br><font size=2 face="sans-serif">dh /etc/openvpn/servervpn/keys/dh1024.pem</font>
<br><font size=2 face="sans-serif">ca /etc/openvpn/servervpn/keys/ca.crt</font>
<br><font size=2 face="sans-serif">cert /etc/openvpn/servervpn/keys/CLTVpnSrv.crt</font>
<br><font size=2 face="sans-serif">key /etc/openvpn/servervpn/keys/CLTVpnSrv.key</font>
<br>
<br><font size=2 face="sans-serif"># Keep tunnel open</font>
<br><font size=2 face="sans-serif">persist-tun</font>
<br><font size=2 face="sans-serif">persist-key</font>
<br>
<br><font size=2 face="sans-serif"># keep-alive ping</font>
<br><font size=2 face="sans-serif"># -&gt; keepalive 10 60</font>
<br><font size=2 face="sans-serif"># will also be pushed to the client</font>
<br><font size=2 face="sans-serif"># if mode server:</font>
<br><font size=2 face="sans-serif"># &nbsp; ping 10</font>
<br><font size=2 face="sans-serif"># &nbsp; ping-restart 120</font>
<br><font size=2 face="sans-serif"># &nbsp; push &quot;ping 10&quot;</font>
<br><font size=2 face="sans-serif"># &nbsp; push &quot;ping-restart 60&quot;</font>
<br><font size=2 face="sans-serif"># else</font>
<br><font size=2 face="sans-serif"># &nbsp; ping 10</font>
<br><font size=2 face="sans-serif"># &nbsp; ping-restart 60</font>
<br><font size=2 face="sans-serif">keepalive 240 600</font>
<br>
<br><font size=2 face="sans-serif"># Renegotiate data channel key once
per day</font>
<br><font size=2 face="sans-serif"><b>reneg-sec 86400</b></font>
<br>
<br><font size=2 face="sans-serif"># optimize timout of slow GPRS connections</font>
<br><font size=2 face="sans-serif">tcp-queue-limit 256</font>
<br><font size=2 face="sans-serif">tcp-nodelay</font>
<br><font size=2 face="sans-serif">tls-timeout 60</font>
<br><font size=2 face="sans-serif">hand-window 120</font>
<br><font size=2 face="sans-serif">sndbuf 262144</font>
<br><font size=2 face="sans-serif">txqueuelen 400</font>
<br><font size=2 face="sans-serif">bcast-buffers 4096</font>
<br>
<br><font size=2 face="sans-serif"># enable LZO compression</font>
<br><font size=2 face="sans-serif">comp-lzo</font>
<br>
<br><font size=2 face="sans-serif"># moderate verbosity</font>
<br><font size=2 face="sans-serif">verb 0</font>
<br><font size=2 face="sans-serif">mute 10</font>
<br>
<br><font size=2 face="sans-serif">#Execute scripts</font>
<br><font size=2 face="sans-serif">script-security 2 system</font>
<br><font size=2 face="sans-serif">up /etc/openvpn/servervpn/vpn-up.sh</font>
<br><font size=2 face="sans-serif">down /etc/openvpn/servervpn/vpn-down.sh</font>
<br><font size=2 face="sans-serif">client-connect /etc/openvpn/servervpn/client-connect.sh</font>
<br><font size=2 face="sans-serif">client-disconnect /etc/openvpn/servervpn/client-disconnect.sh</font>
<br><font size=2 face="sans-serif">tmp-dir /var/tmp</font>
<br><font size=2 face="sans-serif">[root@...23... ~]</font>
<br>
<br><font size=2 face="sans-serif">Any reply on this and idea for a soonest
fix would be appreciated<br>
</font>
<br><font size=2 face="sans-serif">thx and regards,</font><font size=3>
<br>
</font><font size=2 face="sans-serif"><br>
AO<br>
</font><font size=1 color=#5f5f5f face="Arial"><br>
</font><font size=1 color=#008000 face="Arial"><br>
</font>
<br>
<br>
<br><font size=1 color=#5f5f5f face="sans-serif">From: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">arno.odermatt@...1845...</font>
<br><font size=1 color=#5f5f5f face="sans-serif">To: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">openvpn-devel@lists.sourceforge.net,
</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Date: &nbsp; &nbsp; &nbsp;
&nbsp;</font><font size=1 face="sans-serif">09.10.2013 19:19</font>
<br><font size=1 color=#5f5f5f face="sans-serif">Subject: &nbsp; &nbsp;
&nbsp; &nbsp;</font><font size=1 face="sans-serif">[Openvpn-devel]
Openvpn 2.3.2 potential memory-leak after 24hours</font>
<br>
<hr noshade>
<br>
<br>
<br><font size=2 face="sans-serif">All,</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
we are running Openvpn 2.3.2 on Fedora17/64Bit with 8GByte RAM total (EoL,
yes we are aware) and seem to run into a memory leak situation, as following:<br>
<br>
- around 2955 Openvpn session running OK for 23'58&quot;<br>
- memory allocated 3247mByte, memory reserved 2.5gByte, CPU utilization
~1% (see &quot;status-prior-o-vpnrestart-131009.rtf&quot;)<br>
- script-security 2 (in openvpn.conf)</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
After exactly 24hours, allocated and reserved memory of the openvpn-process
start to increase in 1-2Mbyte steps, without seeing an increase in the
amount of Openvpn sessions and steps up to around 3970mByte for the allocated
and 3.2gByte for the reserved memory. Then Openvpn crashes! (see bottom
&quot;status-prior-o-vpnrestart-131009.rtf&quot;)<br>
<br>
The behavior of this symptom has been recognized in Openvpn 2.2.2-7 and
2.3.2 as following:</font><font size=3><br>
<br>
</font><font size=2 face="sans-serif"><br>
&gt; Openvpn 2.2.2-7: keeps reporting &quot;</font><font size=2 face="Calibri">external
program fork failed</font><font size=2 face="sans-serif">&quot;<br>
 &nbsp;<br>
 2.2.2-7 endlessly keeps reporting a fork failed, when the client-connect
script should be executed, no new openvpn sessions can be established but
the process stays alive.</font><font size=3> <br>
</font><font size=2 face="Calibri"><br>
WARNING: Failed running command (--client-connect): external program fork
failed</font><font size=3> </font><font size=2 face="Calibri"><br>
WARNING: Failed running command (--client-connect): external program fork
failed</font><font size=3> </font><font size=2 face="Calibri"><br>
WARNING: Failed running command (--client-connect): external program fork
failed</font><font size=2 face="sans-serif"><br>
</font><font size=3><br>
<br>
</font><font size=2 face="sans-serif"><br>
&gt; Openvpn 2.3.2: exiting due to fatal error (openvpn is killed)</font><font size=3>
</font><font size=2 face="sans-serif"><br>
<br>
When a certain memory stage from a perspective of allocated and reserved
memory is reached, following scenario happens:</font><font size=3> </font><font size=2 face="sans-serif"><br>
</font><font size=2 color=red face="Calibri"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=12)</font><font size=3> </font><font size=2 color=red face="Calibri"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3> </font>
<p><font size=2 face="sans-serif">Please, can you analyze the issue and
send us a feedback about the possible root cause and mitigation?</font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
snip log:</font><font size=3> </font><font size=2 face="sans-serif"><br>
------------------------------</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=12)</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interface</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr
del dev tap1 172.16.0.1/17</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=12)</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3> </font><font size=2 face="sans-serif"><br>
^C[ec2-user@...23... ~]$</font><font size=3> </font><font size=2 face="sans-serif"><br>
[ec2-user@...23... ~]$ sudo tail -f /var/log/messages</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:27 ip-10-56-61-152 openvpn[25964]: NL-200000134777/109.37.153.117:41299
NOTE: --mute triggered...</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: DE-2024460/139.7.160.82:42187
40 variation(s) on previous 10 message(s) suppressed by --mute</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: DE-2024460/139.7.160.82:42187
Connection reset, restarting [0]</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: DE-2024460/139.7.160.82:42187
SIGUSR1[soft,connection-reset] received, client-instance restarting</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=12)</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Exiting due to fatal
error</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: Closing TUN/TAP interface</font><font size=3>
</font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: /usr/sbin/ip addr
del dev tap1 172.16.0.1/17</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: openvpn_execve: unable
to fork: Cannot allocate memory (errno=12)</font><font size=3> </font><font size=2 face="sans-serif"><br>
Oct &nbsp;9 15:40:29 ip-10-56-61-152 openvpn[25964]: <b>Exiting due to
fatal error</b><br>
</font><font size=3><br>
</font><font size=2 face="sans-serif"><br>
thx and regards,</font><font size=3> <br>
</font><font size=2 face="sans-serif"><br>
AO</font><font size=1 face="Arial"><br>
<br>
_____________________________________________________________________________________________________________________________________________
</font><font size=1 color=#5f5f5f face="Arial"><br>
</font><font size=1 color=#008000 face="Arial"><br>
</font><font size=3><br>
<br>
******************************************************<br>
Notice: The information contained in this message is intended only for
use of the individual(s) named above and may contain confidential, proprietary
or legally privileged information. No confidentiality or privilege is waived
or lost by any mistransmission. If you are not the intended recipient of
this message you are hereby notified that you must not use, disseminate
, copy it in any form or take any action in reliance of it. If you have
received this message in error please delete it and any copies of it and
notify the sender immediately.<br>
*******************************************************</font><tt><font size=2>------------------------------------------------------------------------------<br>
October Webinars: Code for Performance<br>
Free Intel webinars can help you accelerate application performance.<br>
Explore tips for MPI, OpenMP, advanced profiling, and more. Get the most
from <br>
the latest Intel processors and coprocessors. See abstracts and register
&gt;<br>
</font></tt><a href="http://pubads.g.doubleclick.net/gampad/clk?id=60134071&amp;iu=/4140/ostg.clktrk"><tt><font size=2>http://pubads.g.doubleclick.net/gampad/clk?id=60134071&amp;iu=/4140/ostg.clktrk</font></tt></a><tt><font size=2>_______________________________________________<br>
Openvpn-devel mailing list<br>
Openvpn-devel@lists.sourceforge.net<br>
</font></tt><a href="https://lists.sourceforge.net/lists/listinfo/openvpn-devel"><tt><font size=2>https://lists.sourceforge.net/lists/listinfo/openvpn-devel</font></tt></a><tt><font size=2><br>
</font></tt>
<br clear="both">
******************************************************<BR>
Notice: The information contained in this message is intended only for use of the individual(s) named above and may contain confidential, proprietary or legally privileged information. No confidentiality or privilege is waived or lost by any mistransmission. If you are not the intended recipient of this message you are hereby notified that you must not use, disseminate , copy it in any form or take any action in reliance of it. If you have received this message in error please delete it and any copies of it and notify the sender immediately.<BR>
*******************************************************<BR>

--=_alternative 00327682C1257C00_=--

--=_mixed 00327682C1257C00_=
Content-Type: application/rtf; name="status-prior-o-vpnrestart-131009.rtf"
Content-Disposition: attachment;
	filename="status-prior-o-vpnrestart-131009.rtf"
Content-Transfer-Encoding: base64

e1xydGYxXGFuc2lcYW5zaWNwZzEyNTJcZGVmZjBcZGVmbGFuZzIwNTV7XGZvbnR0Ymx7XGYwXGZu
aWxcZmNoYXJzZXQwIENhbGlicmk7fX0NCntcY29sb3J0YmwgO1xyZWQwXGdyZWVuNzdcYmx1ZTE4
NztccmVkMjU1XGdyZWVuMFxibHVlMDt9DQp7XCpcZ2VuZXJhdG9yIE1zZnRlZGl0IDUuNDEuMjEu
MjUxMDt9XHZpZXdraW5kNFx1YzFccGFyZFxzYTIwMFxzbDI3NlxzbG11bHQxXGNmMVxsYW5nN1xi
XGYwXGZzMjggT3BlbnZwbiBzdGF0dXMgOS4gMTAgMTMgcHJpb3IgdG8gcmVzdGFydCBvcGVudnBu
OlxwYXINClxjZjBcYjBcZnMyMiBPcGVuVlBOIDIuMy4yIHg4Nl82NC1yZWRoYXQtbGludXgtZ251
IFtTU0wgKE9wZW5TU0wpXSBbTFpPXSBbRVBPTExdIFtQS0NTMTFdIFtldXJlcGhpYV0gW01IXSBb
SVB2Nl0gYnVpbHQgb24gSnVuICAzIDIwMTNccGFyDQpPcmlnaW5hbGx5IGRldmVsb3BlZCBieSBK
YW1lcyBZb25hblxwYXINCkNvcHlyaWdodCAoQykgMjAwMi0yMDEwIE9wZW5WUE4gVGVjaG5vbG9n
aWVzLCBJbmMuIDxzYWxlc0BvcGVudnBuLm5ldD5ccGFyDQpDb21waWxlIHRpbWUgZGVmaW5lczog
ZW5hYmxlX2NyeXB0bz15ZXMgZW5hYmxlX2RlYnVnPXllcyBlbmFibGVfZGVmX2F1dGg9eWVzIGVu
YWJsZV9kZXBlbmRlbmN5X3RyYWNraW5nPW5vIGVuYWJsZV9kbG9wZW49dW5rbm93biBlbmFibGVf
ZGxvcGVuX3NlbGY9dW5rbm93biBlbmFibGVfZGxvcGVuX3NlbGZfc3RhdGljPXVua25vd24gZW5h
YmxlX2V1cmVwaGlhPXllcyBlbmFibGVfZmFzdF9pbnN0YWxsPXllcyBlbmFibGVfZnJhZ21lbnQ9
eWVzIGVuYWJsZV9odHRwX3Byb3h5PXllcyBlbmFibGVfaXByb3V0ZTI9eWVzIGVuYWJsZV9saWJ0
b29sX2xvY2s9eWVzIGVuYWJsZV9sem89eWVzIGVuYWJsZV9sem9fc3R1Yj1ubyBlbmFibGVfbWFu
YWdlbWVudD15ZXMgZW5hYmxlX211bHRpPXllcyBlbmFibGVfbXVsdGlob21lPXllcyBlbmFibGVf
cGFtX2Rsb3Blbj1ubyBlbmFibGVfcGFzc3dvcmRfc2F2ZT15ZXMgZW5hYmxlX3BlZGFudGljPW5v
IGVuYWJsZV9wZj15ZXMgZW5hYmxlX3BrY3MxMT15ZXMgZW5hYmxlX3BsdWdpbl9hdXRoX3BhbT15
ZXMgZW5hYmxlX3BsdWdpbl9kb3duX3Jvb3Q9eWVzIGVuYWJsZV9wbHVnaW5zPXllcyBlbmFibGVf
cG9ydF9zaGFyZT15ZXMgZW5hYmxlX3B0aHJlYWQ9eWVzIGVuYWJsZV9zZWxpbnV4PW5vIGVuYWJs
ZV9zZXJ2ZXI9eWVzIGVuYWJsZV9zaGFyZWQ9eWVzIGVuYWJsZV9zaGFyZWRfd2l0aF9zdGF0aWNf
cnVudGltZXM9bm8gZW5hYmxlX3NtYWxsPW5vIGVuYWJsZV9zb2Nrcz15ZXMgZW5hYmxlX3NzbD15
ZXMgZW5hYmxlX3N0YXRpYz15ZXMgZW5hYmxlX3N0cmljdD1ubyBlbmFibGVfc3RyaWN0X29wdGlv
bnM9bm8gZW5hYmxlX3N5c3RlbWQ9bm8gZW5hYmxlX3dpbjMyX2RsbD15ZXMgZW5hYmxlX3g1MDlf
YWx0X3VzZXJuYW1lPW5vIHdpdGhfY3J5cHRvX2xpYnJhcnk9b3BlbnNzbCB3aXRoX2dudV9sZD15
ZXMgd2l0aF9pcHJvdXRlX3BhdGg9L3NiaW4vaXAgd2l0aF9tZW1fY2hlY2s9bm8gd2l0aF9wbHVn
aW5kaXI9JyQobGliZGlyKS9vcGVudnBuL3BsdWdpbnMnIHdpdGhfc3lzcm9vdD1ub1xwYXINClty
b290QGxvY2FsaG9zdCBvcGVudnBuXSNccGFyDQpccGFyDQpccGFyDQp0b3AgLSAxNDo0ODo0MCB1
cCAyIGRheXMsIDI3IG1pbiwgIDIgdXNlcnMsICBsb2FkIGF2ZXJhZ2U6IDAuMDksIDAuMDcsIDAu
MTJccGFyDQpUYXNrczogIDcxIHRvdGFsLCAgIDEgcnVubmluZywgIDcwIHNsZWVwaW5nLCAgIDAg
c3RvcHBlZCwgICAwIHpvbWJpZVxwYXINCkNwdShzKTogIDAuMyV1cywgIDQuOCVzeSwgIDAuMCVu
aSwgOTQuOSVpZCwgIDAuMCV3YSwgIDAuMCVoaSwgIDAuMCVzaSwgIDAuMCVzdFxwYXINCk1lbTog
ICA3NjI5OTIwayB0b3RhbCwgIDMxMDk4MjhrIHVzZWQsICA0NTIwMDkyayBmcmVlLCAgICA4MDAz
NmsgYnVmZmVyc1xwYXINClN3YXA6ICAgICAgICAwayB0b3RhbCwgICAgICAgIDBrIHVzZWQsICAg
ICAgICAwayBmcmVlLCAgIDE3NjgxMmsgY2FjaGVkXHBhcg0KXHBhcg0KXHBhcg0KICBQSUQgVVNF
UiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIgUyAlQ1BVICVNRU0gICAgVElNRSsgIENPTU1B
TkRccGFyDQoyNTk2NCByb290ICAgICAgMjAgICAwIDMyNDZtIDIuNWcgMjA0OCBTICAxLjAgMzQu
OCAxMTU6MDkuNDQgb3BlbnZwblxwYXINCiAgMjMwIHJvb3QgICAgICAyMCAgIDAgNTQ4MzYgMTQz
MiAxMTY4IFMgIDAuNyAgMC4wICAgMDozNi42NSBzeXN0ZW1kLWpvdXJuYWxccGFyDQoxOTYzMyBy
b290ICAgICAgMjAgICAwIDE1MjM2IDEyMjggIDkzMiBSICAwLjMgIDAuMCAgIDA6MDAuMDIgdG9w
XHBhcg0KICAgIDEgcm9vdCAgICAgIDIwICAgMCA2NTkyNCAgMjNtIDIwODggUyAgMC4wICAwLjMg
ICAwOjAxLjY1IHN5c3RlbWRccGFyDQpccGFyDQogIFBJRCBVU0VSICAgICAgUFIgIE5JICBWSVJU
ICBSRVMgIFNIUiBTICVDUFUgJU1FTSAgICBUSU1FKyAgQ09NTUFORFxwYXINCjI1OTY0IHJvb3Qg
ICAgICAyMCAgIDAgMzI0Nm0gMi41ZyAyMDM2IFMgIDEuNyAzNC44IDExMjozNS4zOSBvcGVudnBu
XHBhcg0KICAgIDEgcm9vdCAgICAgIDIwICAgMCA2NTkyNCAgMjNtIDIwODggUyAgMC4wICAwLjMg
ICAwOjAxLjY1IHN5c3RlbWRccGFyDQogICAgMiByb290ICAgICAgMjAgICAwICAgICAwICAgIDAg
ICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAga3RocmVhZGRccGFyDQogICAgMyByb290ICAgICAg
MjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMTMga3NvZnRpcnFkLzBc
cGFyDQogICAgNSByb290ICAgICAgMjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAg
IDA6MDAuMDAga3dvcmtlci91OjBccGFyDQogICAgNiByb290ICAgICAgUlQgICAwICAgICAwICAg
IDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAgbWlncmF0aW9uLzBccGFyDQogICAgNyByb290
ICAgICAgUlQgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuNTggd2F0Y2hk
b2cvMFxwYXINCiAgICA4IHJvb3QgICAgICBSVCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAg
MC4wICAgMDowMC4wMCBtaWdyYXRpb24vMVxwYXINCiAgIDEwIHJvb3QgICAgICAyMCAgIDAgICAg
IDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMiBrc29mdGlycWQvMVxwYXINCiAgIDEx
IHJvb3QgICAgICBSVCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC44MCB3
YXRjaGRvZy8xXHBhcg0KICAgMTIgcm9vdCAgICAgICAwIC0yMCAgICAgMCAgICAwICAgIDAgUyAg
MC4wICAwLjAgICAwOjAwLjAwIGNwdXNldFxwYXINCiAgIDEzIHJvb3QgICAgICAgMCAtMjAgICAg
IDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBraGVscGVyXHBhcg0KICAgMTQgcm9v
dCAgICAgIDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIGtkZXZ0
bXBmc1xwYXINCiAgIDE1IHJvb3QgICAgICAgMCAtMjAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAg
MC4wICAgMDowMC4wMCBuZXRuc1xwYXINCiAgIDE2IHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCB4ZW53YXRjaFxwYXINCiAgIDE3IHJvb3QgICAg
ICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCB4ZW5idXNccGFy
DQogICAxOCByb290ICAgICAgMjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6
MDAuMzkgc3luY19zdXBlcnNccGFyDQogICAxOSByb290ICAgICAgMjAgICAwICAgICAwICAgIDAg
ICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDEgYmRpLWRlZmF1bHRccGFyDQogICAyMCByb290ICAg
ICAgIDAgLTIwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAga2ludGVncml0
eWRccGFyDQogICAyMSByb290ICAgICAgIDAgLTIwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAu
MCAgIDA6MDAuMDAga2Jsb2NrZFxwYXINCiAgIDIzIHJvb3QgICAgICAgMCAtMjAgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBhdGFfc2ZmXHBhcg0KICAgMjQgcm9vdCAgICAg
IDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIGtodWJkXHBhcg0K
ICAgMjUgcm9vdCAgICAgICAwIC0yMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAw
LjAwIG1kXHBhcg0KICAgMjggcm9vdCAgICAgIDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4w
ICAwLjAgICAwOjAwLjAwIGtzd2FwZDBccGFyDQogICAyOSByb290ICAgICAgMjUgICA1ICAgICAw
ICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAga3NtZFxwYXINCiAgIDMwIHJvb3QgICAg
ICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBmc25vdGlmeV9t
YXJrXHBhcg0KICAgMzEgcm9vdCAgICAgICAwIC0yMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAw
LjAgICAwOjAwLjAwIGNyeXB0b1xwYXINCiAgIDM3IHJvb3QgICAgICAgMCAtMjAgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBrdGhyb3RsZFxwYXINCiAgIDM4IHJvb3QgICAg
ICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCBccGFyDQpccGFyDQpccGFyDQpbcm9vdEBs
b2NhbGhvc3Qgfl0jIHdjIC1sIC9ldGMvb3BlbnZwbi9jZ3d2cG4vcGVyc2lwb2ZmXHBhcg0KNTUg
L2V0Yy9vcGVudnBuL2Nnd3Zwbi9wZXJzaXBvZmZccGFyDQpbcm9vdEBsb2NhbGhvc3Qgfl0jIHdj
IC1sIC9ldGMvb3BlbnZwbi9jZ3d2cG4vcGVyc2lwb25ccGFyDQoyOTU1IC9ldGMvb3BlbnZwbi9j
Z3d2cG4vcGVyc2lwb25ccGFyDQpbcm9vdEBsb2NhbGhvc3Qgfl0jXHBhcg0KXHBhcg0KXHBhcg0K
W3Jvb3RAbG9jYWxob3N0IH5dIyBjYXQgL3Byb2MvMjU5NjQvbGltaXRzXHBhcg0KTGltaXQgICAg
ICAgICAgICAgICAgICAgICBTb2Z0IExpbWl0ICAgICAgICAgICBIYXJkIExpbWl0ICAgICAgICAg
ICBVbml0c1xwYXINCk1heCBjcHUgdGltZSAgICAgICAgICAgICAgdW5saW1pdGVkICAgICAgICAg
ICAgdW5saW1pdGVkICAgICAgICAgICAgc2Vjb25kc1xwYXINCk1heCBmaWxlIHNpemUgICAgICAg
ICAgICAgdW5saW1pdGVkICAgICAgICAgICAgdW5saW1pdGVkICAgICAgICAgICAgYnl0ZXNccGFy
DQpNYXggZGF0YSBzaXplICAgICAgICAgICAgIHVubGltaXRlZCAgICAgICAgICAgIHVubGltaXRl
ZCAgICAgICAgICAgIGJ5dGVzXHBhcg0KTWF4IHN0YWNrIHNpemUgICAgICAgICAgICA4Mzg4NjA4
ICAgICAgICAgICAgICB1bmxpbWl0ZWQgICAgICAgICAgICBieXRlc1xwYXINCk1heCBjb3JlIGZp
bGUgc2l6ZSAgICAgICAgMCAgICAgICAgICAgICAgICAgICAgdW5saW1pdGVkICAgICAgICAgICAg
Ynl0ZXNccGFyDQpNYXggcmVzaWRlbnQgc2V0ICAgICAgICAgIHVubGltaXRlZCAgICAgICAgICAg
IHVubGltaXRlZCAgICAgICAgICAgIGJ5dGVzXHBhcg0KTWF4IHByb2Nlc3NlcyAgICAgICAgICAg
ICAxMDI0ICAgICAgICAgICAgICAgICB1bmxpbWl0ZWQgICAgICAgICAgICBwcm9jZXNzZXNccGFy
DQpNYXggb3BlbiBmaWxlcyAgICAgICAgICAgIDY1NTM1MCAgICAgICAgICAgICAgIDY1NTM1MCAg
ICAgICAgICAgICAgIGZpbGVzXHBhcg0KTWF4IGxvY2tlZCBtZW1vcnkgICAgICAgICA2NTUzNiAg
ICAgICAgICAgICAgICA2NTUzNiAgICAgICAgICAgICAgICBieXRlc1xwYXINCk1heCBhZGRyZXNz
IHNwYWNlICAgICAgICAgdW5saW1pdGVkICAgICAgICAgICAgdW5saW1pdGVkICAgICAgICAgICAg
Ynl0ZXNccGFyDQpNYXggZmlsZSBsb2NrcyAgICAgICAgICAgIHVubGltaXRlZCAgICAgICAgICAg
IHVubGltaXRlZCAgICAgICAgICAgIGxvY2tzXHBhcg0KTWF4IHBlbmRpbmcgc2lnbmFscyAgICAg
ICA1OTMwMiAgICAgICAgICAgICAgICA1OTMwMiAgICAgICAgICAgICAgICBzaWduYWxzXHBhcg0K
TWF4IG1zZ3F1ZXVlIHNpemUgICAgICAgICA4MTkyMDAgICAgICAgICAgICAgICA4MTkyMDAgICAg
ICAgICAgICAgICBieXRlc1xwYXINCk1heCBuaWNlIHByaW9yaXR5ICAgICAgICAgMCAgICAgICAg
ICAgICAgICAgICAgMFxwYXINCk1heCByZWFsdGltZSBwcmlvcml0eSAgICAgMCAgICAgICAgICAg
ICAgICAgICAgMFxwYXINCk1heCByZWFsdGltZSB0aW1lb3V0ICAgICAgdW5saW1pdGVkICAgICAg
ICAgICAgdW5saW1pdGVkICAgICAgICAgICAgdXNccGFyDQpbcm9vdEBsb2NhbGhvc3Qgfl0jIGNh
dCAvcHJvYy8yNTk2NC9zdGF0dXNccGFyDQpOYW1lOiAgIG9wZW52cG5ccGFyDQpTdGF0ZTogIFMg
KHNsZWVwaW5nKVxwYXINClRnaWQ6ICAgMjU5NjRccGFyDQpQaWQ6ICAgIDI1OTY0XHBhcg0KUFBp
ZDogICAxXHBhcg0KVHJhY2VyUGlkOiAgICAgIDBccGFyDQpVaWQ6ICAgIDAgICAgICAgMCAgICAg
ICAwICAgICAgIDBccGFyDQpHaWQ6ICAgIDAgICAgICAgMCAgICAgICAwICAgICAgIDBccGFyDQpV
dHJhY2U6IDBccGFyDQpGRFNpemU6IDQwOTZccGFyDQpHcm91cHM6IDBccGFyDQpWbVBlYWs6ICAz
MzI0NzU2IGtCXHBhcg0KVm1TaXplOiAgMzMyNDc1MiBrQlxwYXINClZtTGNrOiAgICAgICAgIDAg
a0JccGFyDQpWbVBpbjogICAgICAgICAwIGtCXHBhcg0KVm1IV006ICAgMjY1MjIyNCBrQlxwYXIN
ClZtUlNTOiAgIDI2NTIyMjAga0JccGFyDQpWbURhdGE6ICAzMjgxMDAwIGtCXHBhcg0KVm1TdGs6
ICAgICAgIDEzNiBrQlxwYXINClZtRXhlOiAgICAgICA2MjQga0JccGFyDQpWbUxpYjogICAgICA1
ODEyIGtCXHBhcg0KVm1QVEU6ICAgICAgNjUxNiBrQlxwYXINClZtU3dhcDogICAgICAgIDAga0Jc
cGFyDQpUaHJlYWRzOiAgICAgICAgMVxwYXINClNpZ1E6ICAgMC81OTMwMlxwYXINClNpZ1BuZDog
MDAwMDAwMDAwMDAwMDAwMFxwYXINClNoZFBuZDogMDAwMDAwMDAwMDAwMDAwMFxwYXINClNpZ0Js
azogMDAwMDAwMDAwMDAwMDAwMFxwYXINClNpZ0lnbjogMDAwMDAwMDAwMDAwMTAwMFxwYXINClNp
Z0NndDogMDAwMDAwMDE4MDAwNGEwM1xwYXINCkNhcEluaDogMDAwMDAwMDAwMDAwMDAwMFxwYXIN
CkNhcFBybTogZmZmZmZmZmZmZmZmZmZmZlxwYXINCkNhcEVmZjogZmZmZmZmZmZmZmZmZmZmZlxw
YXINCkNhcEJuZDogZmZmZmZmZmZmZmZmZmZmZlxwYXINCkNwdXNfYWxsb3dlZDogICAzXHBhcg0K
Q3B1c19hbGxvd2VkX2xpc3Q6ICAgICAgMC0xXHBhcg0KTWVtc19hbGxvd2VkOiAgIDAwMDAwMDAw
LDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAw
MDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAwMDAwLDAwMDAw
MDAwLDAwMDAwMDAwLDAwMDAwMDAxXHBhcg0KTWVtc19hbGxvd2VkX2xpc3Q6ICAgICAgMFxwYXIN
CnZvbHVudGFyeV9jdHh0X3N3aXRjaGVzOiAgICAgICAgNTM0NDcwN1xwYXINCm5vbnZvbHVudGFy
eV9jdHh0X3N3aXRjaGVzOiAgICAgNjQ4NjQ4XHBhcg0KW3Jvb3RAbG9jYWxob3N0IH5dI1xwYXIN
ClxwYXINCltyb290QGxvY2FsaG9zdCB+XSMgbHNvZiAtbiB8d2MgLWxccGFyDQo0NjMyXHBhcg0K
W3Jvb3RAbG9jYWxob3N0IH5dI1xwYXINClxwYXINCl5DW2VjMi11c2VyQGxvY2FsaG9zdCB+XWlw
IC02IG5laWdoIHNob3cgfCBncmVwIGZlZDAgfCB3YyAtbFxwYXINCjI5NDRccGFyDQpbZWMyLXVz
ZXJAbG9jYWxob3N0IH5dJFxwYXINClxwYXINCltlYzItdXNlckBsb2NhbGhvc3Qgfl0kIGlwIC02
IG5laWdoIHNob3cgfCBncmVwIGZlODAgfCB3YyAtbFxwYXINCjIxOVxwYXINCltlYzItdXNlckBs
b2NhbGhvc3Qgfl0kXHBhcg0KXHBhcg0KW2VjMi11c2VyQGxvY2FsaG9zdCB+XSQgaXAgLTYgbmVp
Z2ggc2hvdyB8IHdjIC1sXHBhcg0KMzE2NFxwYXINCltlYzItdXNlckBsb2NhbGhvc3Qgfl0kXHBh
cg0KXHBhcg0KMTc6MTg6XHBhcg0KdG9wIC0gMTU6MTg6MDUgdXAgMiBkYXlzLCA1NiBtaW4sICAz
IHVzZXJzLCAgbG9hZCBhdmVyYWdlOiAwLjA0LCAwLjA4LCAwLjEwXHBhcg0KVGFza3M6ICA3NyB0
b3RhbCwgICAxIHJ1bm5pbmcsICA3NiBzbGVlcGluZywgICAwIHN0b3BwZWQsICAgMCB6b21iaWVc
cGFyDQpDcHUocyk6ICAwLjMldXMsICA4LjElc3ksICAwLjAlbmksIDkxLjQlaWQsICAwLjAld2Es
ICAwLjAlaGksICAwLjIlc2ksICAwLjAlc3RccGFyDQpNZW06ICAgNzYyOTkyMGsgdG90YWwsICAz
MTE2OTY4ayB1c2VkLCAgNDUxMjk1MmsgZnJlZSwgICAgODEwNjBrIGJ1ZmZlcnNccGFyDQpTd2Fw
OiAgICAgICAgMGsgdG90YWwsICAgICAgICAwayB1c2VkLCAgICAgICAgMGsgZnJlZSwgICAxNzc2
NDBrIGNhY2hlZFxwYXINClxwYXINCltyb290QGxvY2FsaG9zdCBvcGVudnBuXSMgIHRvcFxwYXIN
CnRvcCAtIDE1OjIyOjIwIHVwIDIgZGF5cywgIDE6MDAsICAzIHVzZXJzLCAgbG9hZCBhdmVyYWdl
OiAwLjUxLCAwLjIzLCAwLjE1XHBhcg0KVGFza3M6ICA3NyB0b3RhbCwgICAxIHJ1bm5pbmcsICA3
NiBzbGVlcGluZywgICAwIHN0b3BwZWQsICAgMCB6b21iaWVccGFyDQpDcHUocyk6ICAwLjQldXMs
IDExLjglc3ksICAwLjAlbmksIDg3LjYlaWQsICAwLjAld2EsICAwLjAlaGksICAwLjElc2ksICAw
LjAlc3RccGFyDQpNZW06ICAgNzYyOTkyMGsgdG90YWwsICAzMTE4MDcyayB1c2VkLCAgNDUxMTg0
OGsgZnJlZSwgICAgODEyMjRrIGJ1ZmZlcnNccGFyDQpTd2FwOiAgICAgICAgMGsgdG90YWwsICAg
ICAgICAwayB1c2VkLCAgICAgICAgMGsgZnJlZSwgICAxNzgxNjhrIGNhY2hlZFxwYXINClxwYXIN
ClxiXHBhcg0KMTc6MjI6ICgyMyc1OCIgc2luY2UgbGFzdCByZXN0YXJ0IG9mIE9wZW52cG4sIGFs
bG9jYXRlZCBhbmQgcmVzZXJ2ZWQgbWVtb3J5IHN0YWJsZSBmb3IgaG91cnMpXHBhcg0KXGIwIFty
b290QGxvY2FsaG9zdCBvcGVudnBuXSMgIHRvcFxwYXINCnRvcCAtIDE1OjIyOjIwIHVwIDIgZGF5
cywgIDE6MDAsICAzIHVzZXJzLCAgbG9hZCBhdmVyYWdlOiAwLjUxLCAwLjIzLCAwLjE1XHBhcg0K
VGFza3M6ICA3NyB0b3RhbCwgICAxIHJ1bm5pbmcsICA3NiBzbGVlcGluZywgICAwIHN0b3BwZWQs
ICAgMCB6b21iaWVccGFyDQpDcHUocyk6ICAwLjQldXMsIDExLjglc3ksICAwLjAlbmksIDg3LjYl
aWQsICAwLjAld2EsICAwLjAlaGksICAwLjElc2ksICAwLjAlc3RccGFyDQpNZW06ICAgNzYyOTky
MGsgdG90YWwsICAzMTE4MDcyayB1c2VkLCAgNDUxMTg0OGsgZnJlZSwgICAgODEyMjRrIGJ1ZmZl
cnNccGFyDQpTd2FwOiAgICAgICAgMGsgdG90YWwsICAgICAgICAwayB1c2VkLCAgICAgICAgMGsg
ZnJlZSwgICAxNzgxNjhrIGNhY2hlZFxwYXINClxwYXINCiAgUElEIFVTRVIgICAgICBQUiAgTkkg
IFZJUlQgIFJFUyAgU0hSIFMgJUNQVSAlTUVNICAgIFRJTUUrICBDT01NQU5EXHBhcg0KMjU5NjQg
cm9vdCAgICAgIDIwICAgMCAzMjQ2bSAyLjVnIDIwNDggUyAgMS43IDM0LjggMTE1OjM4Ljc0IG9w
ZW52cG5ccGFyDQogIDIzMCByb290ICAgICAgMjAgICAwIDU0ODQwIDE0MzYgMTE3MiBTICAwLjMg
IDAuMCAgIDA6MzguODggc3lzdGVtZC1qb3VybmFsXHBhcg0KICAgIDEgcm9vdCAgICAgIDIwICAg
MCA2NTkyNCAgMjNtIDIwODggUyAgMC4wICAwLjMgICAwOjAxLjY1IHN5c3RlbWRccGFyDQogICAg
MiByb290ICAgICAgMjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAg
a3RocmVhZGRccGFyDQpccGFyDQpcY2YxXGJcZnMyOCAxNzoyNjpcY2YwXGIwXHBhcg0KXGZzMjIg
dG9wIC0gMTU6MjY6MzYgdXAgMiBkYXlzLCAgMTowNSwgIDQgdXNlcnMsICBsb2FkIGF2ZXJhZ2U6
IDAuMjQsIDAuMjQsIDAuMTdccGFyDQpUYXNrczogIDgwIHRvdGFsLCAgIDEgcnVubmluZywgIDc5
IHNsZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAwIHpvbWJpZVxwYXINCkNwdShzKTogIDAuNyV1cywg
MTQuOSVzeSwgIDAuMCVuaSwgODQuMiVpZCwgIDAuMCV3YSwgIDAuMCVoaSwgIDAuMSVzaSwgIDAu
MCVzdFxwYXINCk1lbTogICA3NjI5OTIwayB0b3RhbCwgIDMzNTAzMTZrIHVzZWQsICA0Mjc5NjA0
ayBmcmVlLCAgICA4MTQxMmsgYnVmZmVyc1xwYXINClN3YXA6ICAgICAgICAwayB0b3RhbCwgICAg
ICAgIDBrIHVzZWQsICAgICAgICAwayBmcmVlLCAgIDE3OTE5MmsgY2FjaGVkXHBhcg0KXHBhcg0K
ICBQSUQgVVNFUiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIgUyAlQ1BVICVNRU0gICAgVElN
RSsgIENPTU1BTkRccGFyDQoyNTk2NCByb290ICAgICAgMjAgICAwIDM0NzVtIDIuN2cgMjA0OCBT
ICAzLjMgMzcuNyAxMTY6MTQuNDIgb3BlbnZwblxwYXINCjI1ODk3IHJvb3QgICAgICAyMCAgIDAg
NTAxMDQgMzkxNiAxODY0IFMgIDAuMyAgMC4xICAgMDo0OC43NyBvcGVudnBuXHBhcg0KICAgIDEg
cm9vdCAgICAgIDIwICAgMCA2NTkyNCAgMjNtIDIwODggUyAgMC4wICAwLjMgICAwOjAxLjY1IHN5
c3RlbWRccGFyDQogICAgMiByb290ICAgICAgMjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAg
IDAuMCAgIDA6MDAuMDAga3RocmVhZGRccGFyDQpccGFyDQpcY2YxXGJcZnMyOCAxNzoyOFxsaW5l
XGNmMFxiMFxmczIyXGxpbmUgW3Jvb3RAbG9jYWxob3N0IG9wZW52cG5dIyAgdG9wXHBhcg0KdG9w
IC0gMTU6Mjg6MjIgdXAgMiBkYXlzLCAgMTowNywgIDQgdXNlcnMsICBsb2FkIGF2ZXJhZ2U6IDAu
MzUsIDAuMjYsIDAuMThccGFyDQpUYXNrczogIDgwIHRvdGFsLCAgIDMgcnVubmluZywgIDc3IHNs
ZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAwIHpvbWJpZVxwYXINCkNwdShzKTogIDUuNyV1cywgMzIu
NyVzeSwgIDAuMCVuaSwgMzUuMSVpZCwgIDAuMCV3YSwgMTQuNSVoaSwgIDAuMSVzaSwgMTEuOCVz
dFxwYXINCk1lbTogICA3NjI5OTIwayB0b3RhbCwgIDM0NDAxOTJrIHVzZWQsICA0MTg5NzI4ayBm
cmVlLCAgICA4MTQ5NmsgYnVmZmVyc1xwYXINClN3YXA6ICAgICAgICAwayB0b3RhbCwgICAgICAg
IDBrIHVzZWQsICAgICAgICAwayBmcmVlLCAgIDE3OTY0OGsgY2FjaGVkXHBhcg0KXHBhcg0KICBQ
SUQgVVNFUiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIgUyAlQ1BVICVNRU0gICAgVElNRSsg
IENPTU1BTkRccGFyDQoyNTk2NCByb290ICAgICAgMjAgICAwIDM1NjltIDIuOGcgMjA0OCBSIDM0
LjkgMzguOSAxMTY6MjcuNzggb3BlbnZwblxwYXINCiAgMjMwIHJvb3QgICAgICAyMCAgIDAgNTQ4
NDQgMTUzNiAxMjcyIFIgIDMuNyAgMC4wICAgMDo0NC43NCBzeXN0ZW1kLWpvdXJuYWxccGFyDQoy
MzM1MSBlYzItdXNlciAgMjAgICAwICAxMTFtIDIxMjQgMTYzNiBTICAwLjMgIDAuMCAgIDA6MDAu
MDQgYmFzaFxwYXINCiAgICAxIHJvb3QgICAgICAyMCAgIDAgNjU5MjQgIDIzbSAyMDg4IFMgIDAu
MCAgMC4zICAgMDowMS42NSBzeXN0ZW1kXHBhcg0KICAgIDIgcm9vdCAgICAgIDIwICAgMCAgICAg
MCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIGt0aHJlYWRkXHBhcg0KICAgIDMgcm9v
dCAgICAgIDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjEzIGtzb2Z0
aXJxZC8wXHBhcg0KICAgIDUgcm9vdCAgICAgIDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4w
ICAwLjAgICAwOjAwLjAwIGt3b3JrZXIvdTowXHBhcg0KXHBhcg0KXGNmMVxiXGZzMjggMTc6MzBc
bGluZVxjZjBcYjBcZnMyMlxwYXINCltyb290QGxvY2FsaG9zdCBvcGVudnBuXSMgIHRvcFxwYXIN
CnRvcCAtIDE1OjI4OjIyIHVwIDIgZGF5cywgIDE6MDcsICA0IHVzZXJzLCAgbG9hZCBhdmVyYWdl
OiAwLjM1LCAwLjI2LCAwLjE4XHBhcg0KVGFza3M6ICA4MCB0b3RhbCwgICAzIHJ1bm5pbmcsICA3
NyBzbGVlcGluZywgICAwIHN0b3BwZWQsICAgMCB6b21iaWVccGFyDQpDcHUocyk6ICA1LjcldXMs
IDMyLjclc3ksICAwLjAlbmksIDM1LjElaWQsICAwLjAld2EsIDE0LjUlaGksICAwLjElc2ksIDEx
Ljglc3RccGFyDQpNZW06ICAgNzYyOTkyMGsgdG90YWwsICAzNDQwMTkyayB1c2VkLCAgNDE4OTcy
OGsgZnJlZSwgICAgODE0OTZrIGJ1ZmZlcnNccGFyDQpTd2FwOiAgICAgICAgMGsgdG90YWwsICAg
ICAgICAwayB1c2VkLCAgICAgICAgMGsgZnJlZSwgICAxNzk2NDhrIGNhY2hlZFxwYXINClxwYXIN
CiAgUElEIFVTRVIgICAgICBQUiAgTkkgIFZJUlQgIFJFUyAgU0hSIFMgJUNQVSAlTUVNICAgIFRJ
TUUrICBDT01NQU5EXHBhcg0KMjU5NjQgcm9vdCAgICAgIDIwICAgMCAzNTY5bSAyLjhnIDIwNDgg
UiAzNC45IDM4LjkgMTE2OjI3Ljc4IG9wZW52cG5ccGFyDQogIDIzMCByb290ICAgICAgMjAgICAw
IDU0ODQ0IDE1MzYgMTI3MiBSICAzLjcgIDAuMCAgIDA6NDQuNzQgc3lzdGVtZC1qb3VybmFsXHBh
cg0KMjMzNTEgZWMyLXVzZXIgIDIwICAgMCAgMTExbSAyMTI0IDE2MzYgUyAgMC4zICAwLjAgICAw
OjAwLjA0IGJhc2hccGFyDQogICAgMSByb290ICAgICAgMjAgICAwIDY1OTI0ICAyM20gMjA4OCBT
ICAwLjAgIDAuMyAgIDA6MDEuNjUgc3lzdGVtZFxwYXINCiAgICAyIHJvb3QgICAgICAyMCAgIDAg
ICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBrdGhyZWFkZFxwYXINCiAgICAz
IHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4xMyBr
c29mdGlycWQvMFxwYXINCiAgICA1IHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMg
IDAuMCAgMC4wICAgMDowMC4wMCBrd29ya2VyL3U6MFxwYXINClxwYXINClxjZjFcYlxmczI4IDE3
OjMyXGxpbmVcY2YwXGIwXGZzMjJccGFyDQpbcm9vdEBsb2NhbGhvc3Qgb3BlbnZwbl0jICB0b3Bc
cGFyDQp0b3AgLSAxNToyOTo1NiB1cCAyIGRheXMsICAxOjA4LCAgNCB1c2VycywgIGxvYWQgYXZl
cmFnZTogMC4xNywgMC4yMiwgMC4xN1xwYXINClRhc2tzOiAgODAgdG90YWwsICAgMSBydW5uaW5n
LCAgNzkgc2xlZXBpbmcsICAgMCBzdG9wcGVkLCAgIDAgem9tYmllXHBhcg0KQ3B1KHMpOiAgMS4w
JXVzLCAxMS45JXN5LCAgMC4wJW5pLCA4My43JWlkLCAgMC4wJXdhLCAgMS4wJWhpLCAgMC43JXNp
LCAgMS42JXN0XHBhcg0KTWVtOiAgIDc2Mjk5MjBrIHRvdGFsLCAgMzUyMzM0MGsgdXNlZCwgIDQx
MDY1ODBrIGZyZWUsICAgIDgxNTQwayBidWZmZXJzXHBhcg0KU3dhcDogICAgICAgIDBrIHRvdGFs
LCAgICAgICAgMGsgdXNlZCwgICAgICAgIDBrIGZyZWUsICAgMTc5OTQ0ayBjYWNoZWRccGFyDQpc
cGFyDQogIFBJRCBVU0VSICAgICAgUFIgIE5JICBWSVJUICBSRVMgIFNIUiBTICVDUFUgJU1FTSAg
ICBUSU1FKyAgQ09NTUFORFxwYXINCjI1OTY0IHJvb3QgICAgICAyMCAgIDAgMzY0N20gMi45ZyAy
MDQ4IFMgIDQuNyAzOS45IDExNjozNS4yNiBvcGVudnBuXHBhcg0KICAyMzAgcm9vdCAgICAgIDIw
ICAgMCA1NDgzNiAxNDMyIDExNjggUyAgMi43ICAwLjAgICAwOjQ1Ljg2IHN5c3RlbWQtam91cm5h
bFxwYXINCjE2MjQ4IHJvb3QgICAgICAyMCAgIDAgIDEwNG0gIDYwMCAgNTEyIFMgIDAuMyAgMC4w
ICAgMDowMC4xMSB0YWlsXHBhcg0KMjQyOTAgcm9vdCAgICAgIDIwICAgMCAxNTIzNiAxMjI0ICA5
MzIgUiAgMC4zICAwLjAgICAwOjAwLjA3IHRvcFxwYXINCiAgICAxIHJvb3QgICAgICAyMCAgIDAg
NjU5MjQgIDIzbSAyMDg4IFMgIDAuMCAgMC4zICAgMDowMS42NSBzeXN0ZW1kXHBhcg0KICAgIDIg
cm9vdCAgICAgIDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4wICAwLjAgICAwOjAwLjAwIGt0
aHJlYWRkXHBhcg0KICAgIDMgcm9vdCAgICAgIDIwICAgMCAgICAgMCAgICAwICAgIDAgUyAgMC4w
ICAwLjAgICAwOjAwLjEzIGtzb2Z0aXJxZC8wXHBhcg0KXHBhcg0KXGNmMVxiXGZzMjggMTc6MzVc
bGluZVxjZjBcYjBcZnMyMlxwYXINCltyb290QGxvY2FsaG9zdCBvcGVudnBuXSMgdG9wXHBhcg0K
dG9wIC0gMTU6MzU6MDQgdXAgMiBkYXlzLCAgMToxMywgIDQgdXNlcnMsICBsb2FkIGF2ZXJhZ2U6
IDAuNDEsIDAuMzIsIDAuMjNccGFyDQpUYXNrczogIDgxIHRvdGFsLCAgIDEgcnVubmluZywgIDgw
IHNsZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAwIHpvbWJpZVxwYXINCkNwdShzKTogIDAuNiV1cywg
IDMuOSVzeSwgIDAuMCVuaSwgOTUuMCVpZCwgIDAuMiV3YSwgIDAuMiVoaSwgIDAuMiVzaSwgIDAu
MCVzdFxwYXINCk1lbTogICA3NjI5OTIwayB0b3RhbCwgIDM2OTU3ODRrIHVzZWQsICAzOTM0MTM2
ayBmcmVlLCAgICA4MTczMmsgYnVmZmVyc1xwYXINClN3YXA6ICAgICAgICAwayB0b3RhbCwgICAg
ICAgIDBrIHVzZWQsICAgICAgICAwayBmcmVlLCAgIDE4MTkzNmsgY2FjaGVkXHBhcg0KXHBhcg0K
ICBQSUQgVVNFUiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIgUyAlQ1BVICVNRU0gICAgVElN
RSsgIENPTU1BTkRccGFyDQoyNTk2NCByb290ICAgICAgMjAgICAwIDM4MjNtIDMuMWcgMjA0OCBT
ICAyLjAgNDIuMiAxMTc6MjAuMzggb3BlbnZwblxwYXINCjI2MjUzIHJvb3QgICAgICAyMCAgIDAg
MTUyNDAgMTIzMiAgOTMyIFIgIDAuMyAgMC4wICAgMDowMC4wNyB0b3BccGFyDQogICAgMSByb290
ICAgICAgMjAgICAwIDY1OTI0ICAyM20gMjA4OCBTICAwLjAgIDAuMyAgIDA6MDEuNjUgc3lzdGVt
ZFxwYXINCiAgICAyIHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4w
ICAgMDowMC4wMCBrdGhyZWFkZFxwYXINCiAgICAzIHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4xMyBrc29mdGlycWQvMFxwYXINCiAgICA1IHJvb3Qg
ICAgICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBrd29ya2Vy
L3U6MFxwYXINCiAgICA2IHJvb3QgICAgICBSVCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAg
MC4wICAgMDowMC4wMCBtaWdyYXRpb24vMFxwYXINCiAgICA3IHJvb3QgICAgICBSVCAgIDAgICAg
IDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC42MiB3YXRjaGRvZy8wXHBhcg0KXHBhcg0K
XGNmMVxiXGZzMjggMTc6MzdcbGluZVxjZjBcYjBcZnMyMlxwYXINCltyb290QGxvY2FsaG9zdCBv
cGVudnBuXSMgdG9wXHBhcg0KdG9wIC0gMTU6MzU6MDQgdXAgMiBkYXlzLCAgMToxMywgIDQgdXNl
cnMsICBsb2FkIGF2ZXJhZ2U6IDAuNDEsIDAuMzIsIDAuMjNccGFyDQpUYXNrczogIDgxIHRvdGFs
LCAgIDEgcnVubmluZywgIDgwIHNsZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAwIHpvbWJpZVxwYXIN
CkNwdShzKTogIDAuNiV1cywgIDMuOSVzeSwgIDAuMCVuaSwgOTUuMCVpZCwgIDAuMiV3YSwgIDAu
MiVoaSwgIDAuMiVzaSwgIDAuMCVzdFxwYXINCk1lbTogICA3NjI5OTIwayB0b3RhbCwgIDM2OTU3
ODRrIHVzZWQsICAzOTM0MTM2ayBmcmVlLCAgICA4MTczMmsgYnVmZmVyc1xwYXINClN3YXA6ICAg
ICAgICAwayB0b3RhbCwgICAgICAgIDBrIHVzZWQsICAgICAgICAwayBmcmVlLCAgIDE4MTkzNmsg
Y2FjaGVkXHBhcg0KXHBhcg0KICBQSUQgVVNFUiAgICAgIFBSICBOSSAgVklSVCAgUkVTICBTSFIg
UyAlQ1BVICVNRU0gICAgVElNRSsgIENPTU1BTkRccGFyDQoyNTk2NCByb290ICAgICAgMjAgICAw
IDM4MjNtIDMuMWcgMjA0OCBTICAyLjAgNDIuMiAxMTc6MjAuMzggb3BlbnZwblxwYXINCjI2MjUz
IHJvb3QgICAgICAyMCAgIDAgMTUyNDAgMTIzMiAgOTMyIFIgIDAuMyAgMC4wICAgMDowMC4wNyB0
b3BccGFyDQogICAgMSByb290ICAgICAgMjAgICAwIDY1OTI0ICAyM20gMjA4OCBTICAwLjAgIDAu
MyAgIDA6MDEuNjUgc3lzdGVtZFxwYXINCiAgICAyIHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAg
MCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4wMCBrdGhyZWFkZFxwYXINCiAgICAzIHJvb3QgICAg
ICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4wICAgMDowMC4xMyBrc29mdGlycWQv
MFxwYXINCiAgICA1IHJvb3QgICAgICAyMCAgIDAgICAgIDAgICAgMCAgICAwIFMgIDAuMCAgMC4w
ICAgMDowMC4wMCBrd29ya2VyL3U6MFxwYXINClxwYXINClxjZjFcYlxmczI4IDE3OjQwXGNmMFxi
MFxmczIyXHBhcg0KW3Jvb3RAbG9jYWxob3N0IG9wZW52cG5dIyB0b3BccGFyDQp0b3AgLSAxNTo0
MDowNyB1cCAyIGRheXMsICAxOjE4LCAgNCB1c2VycywgIGxvYWQgYXZlcmFnZTogMC4yNywgMC4z
NiwgMC4yOFxwYXINClRhc2tzOiAgODEgdG90YWwsICAgMiBydW5uaW5nLCAgNzkgc2xlZXBpbmcs
ICAgMCBzdG9wcGVkLCAgIDAgem9tYmllXHBhcg0KQ3B1KHMpOiAgMC42JXVzLCAzMC43JXN5LCAg
MC4wJW5pLCA0Ni4zJWlkLCAgMC4yJXdhLCAxMy4wJWhpLCAgMC4wJXNpLCAgOS4zJXN0XHBhcg0K
TWVtOiAgIDc2Mjk5MjBrIHRvdGFsLCAgMzg0NDA5NmsgdXNlZCwgIDM3ODU4MjRrIGZyZWUsICAg
IDgxOTAwayBidWZmZXJzXHBhcg0KU3dhcDogICAgICAgIDBrIHRvdGFsLCAgICAgICAgMGsgdXNl
ZCwgICAgICAgIDBrIGZyZWUsICAgMTgzMzYwayBjYWNoZWRccGFyDQpccGFyDQogIFBJRCBVU0VS
ICAgICAgUFIgIE5JICBWSVJUICBSRVMgIFNIUiBTICVDUFUgJU1FTSAgICBUSU1FKyAgQ09NTUFO
RFxwYXINCjI1OTY0IHJvb3QgICAgICAyMCAgIDAgMzk2OG0gMy4yZyAyMDQ4IFIgNjAuNSA0NC4x
IDExODoxMC45OCBvcGVudnBuXHBhcg0KICAyMzAgcm9vdCAgICAgIDIwICAgMCA1NDgzNiAxNTMy
IDEyNjggRCAgMC43ICAwLjAgICAwOjU3LjEzIHN5c3RlbWQtam91cm5hbFxwYXINCjI4MTAxIHJv
b3QgICAgICAyMCAgIDAgMTUyMzYgMTIyOCAgOTMyIFIgIDAuMyAgMC4wICAgMDowMC4xNCB0b3Bc
cGFyDQoyOTA2NiBlYzItdXNlciAgMjAgICAwIDE1MjQ0IDEyNDAgIDkzNiBTICAwLjMgIDAuMCAg
IDA6MDAuMDMgdG9wXHBhcg0KICAgIDEgcm9vdCAgICAgIDIwICAgMCA2NTkyNCAgMjNtIDIwODgg
UyAgMC4wICAwLjMgICAwOjAxLjY1IHN5c3RlbWRccGFyDQogICAgMiByb290ICAgICAgMjAgICAw
ICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAga3RocmVhZGRccGFyDQogICAg
MyByb290ICAgICAgMjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMTMg
a3NvZnRpcnFkLzBccGFyDQpcY2YxXGJcZnMyOCAxNzo0MVxjZjBcYjBcZnMyMlxwYXINCltyb290
QGxvY2FsaG9zdCBvcGVudnBuXSMgdG9wXHBhcg0KdG9wIC0gMTU6NDA6MDcgdXAgMiBkYXlzLCAg
MToxOCwgIDQgdXNlcnMsICBsb2FkIGF2ZXJhZ2U6IDAuMjcsIDAuMzYsIDAuMjhccGFyDQpUYXNr
czogIDgxIHRvdGFsLCAgIDIgcnVubmluZywgIDc5IHNsZWVwaW5nLCAgIDAgc3RvcHBlZCwgICAw
IHpvbWJpZVxwYXINCkNwdShzKTogIDAuNiV1cywgMzAuNyVzeSwgIDAuMCVuaSwgNDYuMyVpZCwg
IDAuMiV3YSwgMTMuMCVoaSwgIDAuMCVzaSwgIDkuMyVzdFxwYXINCk1lbTogICA3NjI5OTIwayB0
b3RhbCwgIDM4NDQwOTZrIHVzZWQsICAzNzg1ODI0ayBmcmVlLCAgICA4MTkwMGsgYnVmZmVyc1xw
YXINClN3YXA6ICAgICAgICAwayB0b3RhbCwgICAgICAgIDBrIHVzZWQsICAgICAgICAwayBmcmVl
LCAgIDE4MzM2MGsgY2FjaGVkXHBhcg0KXHBhcg0KICBQSUQgVVNFUiAgICAgIFBSICBOSSAgVklS
VCAgUkVTICBTSFIgUyAlQ1BVICVNRU0gICAgVElNRSsgIENPTU1BTkRccGFyDQoyNTk2NCByb290
ICAgICAgMjAgICAwIFxjZjIgMzk2OG1cY2YwICBcY2YyIDMuMmcgXGNmMCAyMDQ4IFIgNjAuNSA0
NC4xIDExODoxMC45OCBvcGVudnBuXHBhcg0KICAyMzAgcm9vdCAgICAgIDIwICAgMCA1NDgzNiAx
NTMyIDEyNjggRCAgMC43ICAwLjAgICAwOjU3LjEzIHN5c3RlbWQtam91cm5hbFxwYXINCjI4MTAx
IHJvb3QgICAgICAyMCAgIDAgMTUyMzYgMTIyOCAgOTMyIFIgIDAuMyAgMC4wICAgMDowMC4xNCB0
b3BccGFyDQoyOTA2NiBlYzItdXNlciAgMjAgICAwIDE1MjQ0IDEyNDAgIDkzNiBTICAwLjMgIDAu
MCAgIDA6MDAuMDMgdG9wXHBhcg0KICAgIDEgcm9vdCAgICAgIDIwICAgMCA2NTkyNCAgMjNtIDIw
ODggUyAgMC4wICAwLjMgICAwOjAxLjY1IHN5c3RlbWRccGFyDQogICAgMiByb290ICAgICAgMjAg
ICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAuMDAga3RocmVhZGRccGFyDQog
ICAgMyByb290ICAgICAgMjAgICAwICAgICAwICAgIDAgICAgMCBTICAwLjAgIDAuMCAgIDA6MDAu
MTMga3NvZnRpcnFkLzBccGFyDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09XHBhcg0KXHBhcg0KXGNmMiBPY3QgIDkgMTU6NDA6MjkgaXAtMTAtNTYtNjEtMTUyIG9wZW52
cG5bMjU5NjRdOiBvcGVudnBuX2V4ZWN2ZTogdW5hYmxlIHRvIGZvcms6IENhbm5vdCBhbGxvY2F0
ZSBtZW1vcnkgKGVycm5vPTEyKVxwYXINCk9jdCAgOSAxNTo0MDoyOSBpcC0xMC01Ni02MS0xNTIg
b3BlbnZwblsyNTk2NF06IEV4aXRpbmcgZHVlIHRvIGZhdGFsIGVycm9yXHBhcg0KT2N0ICA5IDE1
OjQwOjI5IGlwLTEwLTU2LTYxLTE1MiBvcGVudnBuWzI1OTY0XTogQ2xvc2luZyBUVU4vVEFQIGlu
dGVyZmFjZVxwYXINCk9jdCAgOSAxNTo0MDoyOSBpcC0xMC01Ni02MS0xNTIgb3BlbnZwblsyNTk2
NF06IC91c3Ivc2Jpbi9pcCBhZGRyIGRlbCBkZXYgdGFwMSAxNzIuMTYuMC4xLzE3XHBhcg0KT2N0
ICA5IDE1OjQwOjI5IGlwLTEwLTU2LTYxLTE1MiBvcGVudnBuWzI1OTY0XTogb3BlbnZwbl9leGVj
dmU6IHVuYWJsZSB0byBmb3JrOiBDYW5ub3QgYWxsb2NhdGUgbWVtb3J5IChlcnJubz0xMilccGFy
DQpPY3QgIDkgMTU6NDA6MjkgaXAtMTAtNTYtNjEtMTUyIG9wZW52cG5bMjU5NjRdOiBFeGl0aW5n
IGR1ZSB0byBmYXRhbCBlcnJvclxwYXINClxjZjBccGFyDQp9DQoA

--=_mixed 00327682C1257C00_=--

