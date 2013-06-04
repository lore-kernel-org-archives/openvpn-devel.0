Date: Tue, 4 Jun 2013 08:19:21 +0200 (CEST)
From: Gerhard Wiesinger <lists@...390...>
Message-ID: <alpine.LFD.2.02.1306040815590.28059@...391...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN and NAT source Port change on firewall
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; format=flowed; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

Hi,

I've a usecase with OpenVPN and NAT with UDP where the commercial firewall 
changes NAT binding. Keep alive is 30s, so short enough. Also float option 
doesn't help because it accepts packets but doesn't do the source port 
change. Details find below. This behaviour is reproduceable on different 
installations with this firewall.

Client:
IPClient..IP address client
SPoClient..Source port client

NAT:
IPNAT..IP address NAT
SPoNAT1..Source port NAT (before change)
SPoNAT2..Source port NAT (after change)

Server:
IPServer..IP address OpenVPN server

Client                              | NAT                            | Server
# From client                       |                                |
IPClient:SPoClient => IPServer:1194 | IPNAT:SPoNAT1 => IPServer:1194 | IPNAT:SPoNAT1 => IPServer:1194
# Answer from server                |                                |
IPClient:SPoClient <= IPServer:1194 | IPNAT:SPoNAT1 <= IPServer:1194 | IPNAT:SPoNAT1 <= IPServer:1194
# NAT changes source port NATing!!! |                                |
IPClient:SPoClient => IPServer:1194 | IPNAT:SPoNAT2 => IPServer:1194 | IPNAT:SPoNAT2 => IPServer:1194
# Answer from server to original source port!!!                      |
----BLOCKED BY NAT----              | ----BLOCKED BY NAT----         | IPNAT:SPoNAT1 <= IPServer:1194
# Suggested behaviour: On authenticated source port change remember  |
# the change, answer to new source port from NAT/client              |
IPClient:SPoClient <= IPServer:1194 | IPNAT:SPoNAT2 <= IPServer:1194 | IPNAT:SPoNAT2 <= IPServer:1194

Can the suggested behaviour be easily implemented (should be easily done 
in socket.c)?

I can try a patch if you want.

Thank you.

Ciao,
Gerhard

--
http://www.wiesinger.com/

