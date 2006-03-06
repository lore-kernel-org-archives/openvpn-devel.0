Message-ID: <440D05E9.7030203@...564...>
From: Kosta Welke <kosta@...564...>
MIME-Version: 1.0
Subject: [Openvpn-devel] float is broken when source port changes
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
Date: Mon Mar  6 20:02:20 2006
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi!

I really enjoy openvpn. I also found a bug :)

Consider this network layout, float is enabled:
(client and server are the openvpn client and server)

client -- box1 -- NAT --- server
        \- box2 -/

The client has an instable connection to both boxes. If a connection 
breaks, it simply uses the other one. openvpn client does this without 
any problem. However, the server fails to update to the new client port.
Here's what tcpdump on the server says:

04:25:40.379210 IP client.1042 > server.1194: UDP, length 53
04:25:50.641933 IP server.1194 > client.1042: UDP, length 53
[connection breaks -> client has same IP thanks to NAT, but other port]
04:25:50.949669 IP client.39630 > server.1194: UDP, length 53
04:26:00.774602 IP server.1194 > client.1042: UDP, length 53
04:26:10.390386 IP client.39630 > server.1194: UDP, length 53
04:26:20.239776 IP server.1194 > client.1042: UDP, length 53

the server should have sent those last two packets to client.39630, of 
course. As it does not, I have to wait for a connection timeout.

I tried finding the bug myself, however, wherever i looked, both ip 
address and port number were compared, or sockaddr_in was compared, 
which essentially is the same. Any hints how to fix it?

Yours,
Kosta

