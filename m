From: Heiko Hund <heiko.hund@...1489...>
Date: Sun, 16 Nov 2014 13:51:33 +0100
Message-ID: <2215306.x9ci9DhAZ9@...2001...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Make OpenVPN set routes on Windows Vista and later
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: OpenVPN Devel <openvpn-devel@lists.sourceforge.net>

Hi everyone

I've been working on a Windows service that enables OpenVPN to do privileged 
network operations on Windows Vista and later. You can find the code here:  
https://sourceforge.net/p/openvpn-gui/openvpn/ci/interactive_service/tree/

Here's an overview of how it works:

0) A regular user runs the GUI and connects a VPN.
1) The GUI requests an openvpn.exe instance running with a certain config from 
the service.
2) The service starts openvpn as the user and provides a IPC pipe to the 
process for requesting defined privileged operations.
3) The GUI talks to openvpn using the management interface.
4) Along the way openvpn requests routes to be set and other things.

Since openvpn is run as the same user the GUI is run for, the hook scripts are 
only capable of doing operations the user is allowed to perform. The pipe can 
only be used by the openvpn process and is not accessible for other processes. 
So this code could be a nice base for further securing openvpn on Windows 
while keeping it fully functional.

To get a feeling of how this works you could look at the files:
include/openvpn-msg.h
src/openvpn/route.c
src/openvpnserv/interactive.c

Please review and comment.

Cheers
Heiko

