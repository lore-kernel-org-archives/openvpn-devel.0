Message-ID: <48CBE0A1.4060805@...1124...>
Date: Sat, 13 Sep 2008 17:47:45 +0200
From: Tobias Gruber <tobias.gruber@...1124...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Failure in Manual
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I think there is a failure in the manuals on openvpn.org.
They write there, that the pings are send over the control channel:

*--ping n*
   Ping remote over the TCP/UDP control channel if no packets have been
   sent for at least *n* seconds (


but there are some reasons why the pings are send over the data channel:
-p2p mode dont has a control channel:

Packet opcode/key_id (8 bits) -- TLS only, not used in
*       pre-shared secret mode.

-both sites must send the ping. if it would be send over control 
channel, the sender would get an ACK and so the other peer dont have to 
send the ping too.
- in the logs the pings come in P_DATA_V1, there is no P_CONTROL_ACK or 
something. There is no op code for a ping. I think it comes on the data 
channel with a speciale bit sequence.

What do you say ?

A second question:
I have Clients which get from time to time new ip adresses. I have 
server mode with tls client and tls server.
I thougt with the directive --float the tunnel will overcome the ip 
change. But it breaks, because the Server says:
No TLS State for client... opcode=6
In p2p mode it works fine.
Doesnt it work with tls mode?

Regards
Tobias


