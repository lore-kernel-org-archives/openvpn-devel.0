From: Mathias Sundman <mathias@...209...>
Message-ID: <Pine.LNX.4.61.0410141450560.17318@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Show client IP address in status file
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
Date: Thu Oct 14 06:25:35 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

I have a little feature request.

I use TAP and bridging in many roadwarrior configurations.

I would really like to see what IP address that has been assigned to which 
client in the --status file.

A while ago we discussed how to protect against the user using another IP 
address that the one he was assigned, and you, James, changed the code so 
when using TUN, only the assigned IP address is allowed.

However with TAP you said it was much harder as openvpn only keeps track 
of MAC addresses rather than IP addresses.

I can live with this security issue, but would it be possible to just save 
the IP address that was assigned to a client so it can be showed in the 
status file?

How does openvpn work when a client is not a single machine, but a whole 
bridged network? Does openvpn hand out multiple IP addresses from 
--ifconfig-pool then?

How does this look like in the status file? One CLIENT LIST line and multi 
ROUTING TABLE lines?

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://www.nilings.se/openvpn    / \   NO Word docs in e-mail

