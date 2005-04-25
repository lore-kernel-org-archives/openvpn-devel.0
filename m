From: "Vladimir S. Petukhov" <vladimir@...379...>
Reply-To: vladimir@...379...
MIME-Version: 1.0
Message-Id: <200504251354.08540.vladimir@...379...>
Subject: [Openvpn-devel] Help!
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
Date: Mon Apr 25 03:03:24 2005
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hi!

Sorry for my English...

I have next task:
	We have client and provider with 2 channel (land & satellite) between them: 
for in/outgoing traffic. Client and server have a soft, implemented as local 
http-proxy. Server proxy made real http-request. Between client and server 
all data must be compressed and encapsulated in udp packets.


                           <----compressed udp channel (satellite)--
Client  |  "proxy"    --- compressed udp channel (land) ->  "proxy" | server

The main goal - compression (HTTP - 70-90%).

Can anybody advice usefull soft or any decisions?

