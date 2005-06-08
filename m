From: Jason Lunz <lunz@...413...>
Message-ID: <d87dej$ujh$1@...165...>
Subject: [Openvpn-devel] ip/mac spoofing prevention
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
Date: Wed Jun  8 12:09:38 2005
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

If many clients are connected to a server-mode openvpn instance running
in bridge mode, any client can inject arbitrary ethernet frames onto the
VPN. By arbitrary, I mean that clients can change source mac and source
IP at will. This is a good thing; it's flexible.

However, this makes it useless to attempt user-based firewalling on the
vpn server on the packets arriving on the tap device. By the time a
given packet arrives at firewall rules on the tap device, there's no
non-spoofable way to determine which user sent the packet.

How difficult would it be to add an option to enforce that packets
arriving from a particular user be discarded by openvpn if they do not
match a given mac address (and/or IP)?  That way, firewall rules could
be written on the tap device with per-user granularity, and openvpn
would prevent any possibility of spoofing.

thanks for a great program,

Jason


