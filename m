From: mts.spb.suxx@...450...
Reply-To: mts.spb.suxx@...450...
Message-ID: <722546201.20051206222018@...450...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN documentation correction suggestion
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
Date: Tue Dec  6 11:22:32 2005
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello Developers,

 Please look into re-wording the server.ovpn hints for bridging mode:

# Configure server mode for ethernet bridging.
# You must first use your OS's bridging capability
# to bridge the TAP interface with the ethernet
# NIC interface.  Then you must manually set the
# IP/netmask on the bridge interface,
> You must use the free IP from your existing
> LAN subnet range.
# Here we assume 10.8.0.4/255.255.255.0. Finally we
# must set aside an IP range in this subnet
# (start=10.8.0.50 end=10.8.0.100) to allocate
# to connecting clients.
> Make sure this range will not overlap with
> your LAN's DHCP-server scope.
# Leave this line commented out unless you are
# ethernet bridging.
;server-bridge 10.8.0.4 255.255.255.0 10.8.0.50 10.8.0.100

Please comment.
(Please CC me, for I'm not on the list.)

PS. I'm on winXP thoughout.
I was able to let my LAN's DHCP server to allocate the IP for the
bridged interface on the OpenVPN server. It would be nice to be able
to control everything from one point - the LAN's DHCP server: the
default gateway IP pushed to the OpenVPN clients, the DNS server IP
and so on. Is it possible to make the OpenVPN daemon to learn all
those settings automagically (by querying the bridge properties)?

This is my layout:
internet-NAT-(192.168.0.0/24)-OpenVPNserver(192.168.0.3)-etc.
Announced gateway is 192.168.0.1
Announced DNS is 192.168.0.1
LAN DHCP scope is 192.168.0.3~192.168.0.127
OpenVPN scope is 192.168.0.128~192.168.0.132

-- 
Best regards,
 Anthony                  mailto:mts.spb.suxx@...450...


