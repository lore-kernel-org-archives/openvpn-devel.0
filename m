Date: Tue, 24 Jun 2008 00:38:49 -0500 (CDT)
From: Ross Alan Binkley <rabinkley21@...1110...>
Message-id: <20080624003849.AST17241@...1111...>
MIME-version: 1.0
Subject: [Openvpn-devel] TAP-win32
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: text/plain; charset=us-ascii
Content-transfer-encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I am a former network administrator at my university's Computer Science Department and we are setting up a mass virtual machine deployment using the Qemu VMM. We are using the tap-win32 driver to connect the virtual machine to the LAN. However, this requires that the TAP adapter be bridged to the physical ethernet card to function properly and the Windows network bridge is an administrative nightmare at best (it changes the externally-visible MAC address of the box, which then makes Ghost and DHCP very unhappy, as well as messing with a few other things.)

As a solution to this, I have been looking into the possibility of writing a modified TAP-win32 driver that is installed as an NDIS Intermediate Filter Driver in the net stack of the desired physical ethernet adapter instead of using the bridge, thus eliminating the MAC-changing headaches. While looking into this, I noticed an old post on this list from Emil titled "TAP-Win32 and other NDIS IM drivers". This post seemed to indicate that he had written such a driver already. If anyone knows if/where this driver has been made publically available, I would greatly appreciate finding this out. I did not see any links to Emil's project in the previous e-mails. Also, if anyone else has developed such a driver, I would greatly appreciate a link.

As a side note, the IM filter driver is how MS VMM's (virtual server and virtual PC) connect to the network and seem to make a more elegant solution for connecting a Windows-hosted VMM to the network than the current tap-win32 driver, IMHO.

Thanks,
Ross Binkley
Graduate Student / Systems Administrator
Department of Computer Science
Tennessee Technological University

