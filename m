From: Mike Ireton <mike-openvpn@...479...>
Message-ID: <dj6pnr$gs4$1@...165...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Bug report (long) - OpenVPN dropping small frames
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 19 18:04:15 2005
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I'm looking for a solution to a problem with small amounts of packet 
loss thru Openvpn tunnel, and I think the root cause may be some sort of 
subtle bug in Openvpn. It appears to be dropping small packets - such as 
those that result from fragmenting larger frames for 
crypto/encapsulation  - as well as the small frames used by ppp/pppoe 
for link control. We aren't dealing with actual packet loss of the 
crypted udp packets carrying the tunneld data, nor are we dealing with 
firewalls or other common openvpn faq items. Please forgive my 
verbosity, here's what I have so far:

I do bridging thru openvpn/tap device, and I'm basiclly passing a *lot* 
of different pppoe sessions thru it. I initially became aware of the 
problem back in Feburary and it was due to a very simple observation - 
that there appeared to be an occasional network disruption which would 
cause just one (and random) pppoe client to think the server had went 
away, but then immediately when the client tried to re-establish pppoe, 
the server would 'be there' again and ppp would sucessfully renegotiate 
a new session and everything would be fine.

The PPP protocol can use (and all of my clients do), a sub protocol 
called 'lcp-echo', which is basiclly a protocol layer ping check between 
the client and server to verify connectivity. In my configuration, this 
check happens once every 10 seconds and if there are 5 failures in a 
row, the client will decide that the server is dead, send a 'padt' 
protocol frame with a message embedded in it to the other side and will 
recycle itself and begin a new session negotiation process.

I experience issues where random clients will, for no network reason I 
am aware of, renegotiate their sessions. And I have spent much time
investigating the circumstances surrounding these. The key bit of
information I see is recorded either on the pppoe client or the pppoe
server, where either of them will claim 'no response to 5 echo 
requests', which implies that the network path between them has been 
unavailable for at least 50 seconds continously (or enough packet loss 
to make it the same difference).

I have focused on this symptom - of there being enough (apparent) packet
loss enough to cause client disconnection - and what I found was that 
this is NOT happening, and that at no time did the disconnecting client 
actually suffer a real loss of connectivity. I have been able to ping 
sample clients over the routed portion of the network (my clients have 
pppoe thru the vpn, and a statically routed IP address as well) during 
these times and have observed NO PACKET LOSS, and yet the client in 
question clearly states this (no echo replies) as the reason for 
dropping and renogiating the session.

This has been maddening to say the least. Because if I can ping the 
client, and it's taking exactly the same path thru the network that the 
encapsulated pppoe frames do, and the pings all work and at the same 
time the pppoe client thinks it's partner is gone, then logically 
there's got to be another explanation.

I have recently been able to observe this situation first hand with 
tcpdump running at the OpenVPN server and client sides. I saw frames go 
into the tunnel that _did not_ make it out the other side. Worse yet, it 
appeared that the frames not making it out (the encapsulated pppoe 
frames) were all destined for one mac address in particular. Like, for 
whatever reason, OpenVPN appeared to not be able to decapsulate any 
frames destined for one particular mac address for some period of time.

Suspeciously, I also have been observing an excessive number of ICMP 
"Frag reassembly time exceeded" messages coming from this openvpn client 
directed at the server. Putting 2 and 2 together, these excess icmp 
messages appear to be being generated because the client is not 
receiving all fragments. And I think it's the encrypted payload that's 
not being received properly.

I have a good test case right now. If I ping with 1393 bytes or more of
data, it doesn't work reliably. Whereas if I ping with 1392 bytes, it 
does work reliably and without loss. Here is an example:


[root@...478... ~]# ping -s1393 172.16.18.18
PING 172.16.18.18 (172.16.18.18) 1393(1421) bytes of data.
1401 bytes from 172.16.18.18: icmp_seq=6 ttl=62 time=42.7 ms
1401 bytes from 172.16.18.18: icmp_seq=7 ttl=62 time=6.89 ms
1401 bytes from 172.16.18.18: icmp_seq=69 ttl=62 time=7.61 ms
1401 bytes from 172.16.18.18: icmp_seq=130 ttl=62 time=8.66 ms
1401 bytes from 172.16.18.18: icmp_seq=131 ttl=62 time=8.19 ms
^C
--- 172.16.18.18 ping statistics ---
137 packets transmitted, 5 received, 96% packet loss, time 136261ms
rtt min/avg/max/mdev = 6.893/14.813/42.703/13.957 ms, pipe 2

Now the 'good' size:
[root@...478... ~]# ping -s1392  -c 100 172.16.18.18
PING 172.16.18.18 (172.16.18.18) 1392(1420) bytes of data.
1400 bytes from 172.16.18.18: icmp_seq=0 ttl=62 time=10.2 ms
1400 bytes from 172.16.18.18: icmp_seq=1 ttl=62 time=9.89 ms
1400 bytes from 172.16.18.18: icmp_seq=2 ttl=62 time=9.96 ms
.
.
.
^C
--- 172.16.18.18 ping statistics ---
86 packets transmitted, 86 received, 0% packet loss, time 85247ms
rtt min/avg/max/mdev = 8.169/16.197/138.610/21.278 ms, pipe 2


	So what does it mean that a 1 byte larger packet size is just
unreliable, as opposed to just not working at all?!?

	I'm not really sure where to go next with this other than to report 
these damm strange observations and hope someone can suggest some next 
steps to try in resolving the basic packet loss problem. Please bear in 
mind that I have to be careful with the testing I do because I am 
running this in production and can't afford to take it completely down 
for long periods of time. I do have a backup system which has everything 
the production system does - except no clients - which I can test 
against, but I haven't yet been able to reproduce the problem on it yet 
(and I fear it is because of traffic loading).

Mike



