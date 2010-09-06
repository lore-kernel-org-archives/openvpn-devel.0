Message-ID: <58460.94.193.81.228.1283805868.squirrel@...1399...>
Date: Mon, 6 Sep 2010 21:44:28 +0100 (BST)
From: b.green@...1398...
MIME-Version: 1.0
Subject: [Openvpn-devel] DNS Leakage in Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain;charset=iso-8859-15
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Hello All,

I have been using OpenVPN for a little while now on the Linux platform and
suffice to say I think it is great. Recently I began rollout of a company
VPN service for regular users to access the domain (a Windows Active
Directory Domain) now this all works fine but the names for internal
servers (as resolved by the Windows DNS server service) are sometimes not
resolving. The reason for this is that both the local interface (Wireless
Network Connection: 192.168.1.100) and the Win32 TAP interface
(192.168.40.30) both have a DNS Server provided by DHCP. Sometimes windows
uses one and sometimes it uses the other.

After some investigating and a few pokes at my machine I found in Windows
7 and XP (assume Vista but not tested) the way to make windows query the
correct (VPN assigned) DNS server and not bother with the locally assigned
one is to change the value of:

HKLM\SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\Interfaces\{Interface
GUID}\NameServer

to: 0.0.0.0, on a DHCP assigned interface it is normally an empty string.
This setting overrides the DhcpNameServer setting and will then allow the
other interface to handle DNS queries. FYI: Changing the value of
DhcpNameServer does not work because it is refreshed by Windows.

I have written a short C# programme that does this on the few test laptops
we have but more work needs to be done and I would like to implement a
feature inside OpenVPN.exe if it is perceived as worthwhile for OpenVPN on
windows.

Another way to make this work is to use Interface Metrics but I have not
looked at that yet.

The feature would do the following when a successful connection has been
established:

1, Find out what interface is being used for communication with the
internet (in this case see what interface has the default route) and it's
corresponding GUID.
2, Save the current value of the NameServer value (in statically assigned
interfaces it will not be blank) in a text file, or another value in the
registry and replace the NameServer value with 0.0.0.0.

When a connection is dropped or a connection is being re-established the
nameserver will be returned to the value it was before.

This may cause a problem with privileges, the OpenVPN user needs to have
access to registry keys but in most setups (standard service install) this
is not a problem and a note can be put next to the option notifying the
user of this restriction.

I have downloaded the latest sources from the Git repo and would like to
contribute to the community if you feel this feature worthwhile.

I look forward to your comments.

(I can write C and I am familiar with the Windows API)

Ben.


