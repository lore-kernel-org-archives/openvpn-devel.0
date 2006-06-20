Date: Tue, 20 Jun 2006 16:10:09 +0200 (CEST)
From: Mathias Sundman <mathias@...454...>
Message-ID: <Pine.LNX.4.64.0606201558300.2083@...210...>
MIME-Version: 1.0
Subject: [Openvpn-devel] DHCP on PocketPC port
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Christer Lindell <christer.lindell@...341...>, Kenneth Karlsson <kenneth.karlsson@...341...>

When pushing an IP to an OpenVPN client and using the DHCP feature in the 
TAP-Win32 driver to have it assigned to the windows client, I believe 
OpenVPN or the TAP-Win32 driver is blocking the DHCP requests from 
traversing the VPN tunnel. This is the behavior I'd expect as well.

Now, while testing the PocketPC port, I just realized that I recieved two 
IP addresses! One from the TAP-Win32 driver, pushed from the OpenVPN 
server, the correct one, but also one from my real DHCP server on the 
remote network. We're using TAP and bridging... So obviously the PocketPC 
port does not block these packets, even though the build-in DHCP server in 
the TAP driver is replying to the DHCP requests.

So, is this a bug in the PocketPC port of OpenVPN/TAP-Win32 or is 
this expected behaviour? Or is there simply no blocking feature in the 
WinXP TAP-Win32 driver either, but these O/S only care about the first 
DHCP server that it gets a reply from?

As a workaround, I just used iptables on my linux server to block 
forwarding of UDP67/68 packets over the bridge and the things worked just 
fine.

-- 
_____________________________________________________________
Mathias Sundman                  (^)   ASCII Ribbon Campaign
OpenVPN GUI for Windows           X    NO HTML/RTF in e-mail
http://openvpn.se/               / \   NO Word docs in e-mail

