Message-ID: <47149548.60001@...1061...>
Date: Tue, 16 Oct 2007 11:41:12 +0100
From: Matthew Richardson <M.Richardson@...1061...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Altering routing Tables as non-admin on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

I've recently come back to looking at openvpn, after discovering that it 
now handles most things 'out of the box' for non-admins on Windows a 
requirement on our managed machines).

The one problem I've discovered is that as openvpn starts, it tries to 
alter the routing tables on the client to route through the VPN. 
However, these routing rules can only be changed by an admin - or more 
specifically by a member of the 'Network Configuration Operators' group, 
This group gives more rights to the user than are necessary for just 
routing, and may create security problems.

I've come up with a solution for this, for which I've written a
'proof-of-concept' script - please don't use this in service, as its not 
really
been tested!

The idea is that a Windows Service runs and in some way monitors the VPN 
connection (tailing a log file, having a socket which it can be 
connected to on, etc).  the routing rules that are normally implemented 
by the openvpn command itself are moved to this service, and when 
'triggered' it runs the routing commands.  The service runs as an 
account with appropriate privileges to make these changes.  There is no 
need to 'undo' these rules, since when the vpn is disconnected, and the 
tun device disappears, the network stack tidies up the routing table 
accordingly.

I've implemented this as a test using a VBS script, which watches the 
OpenVPN log file for successful connections.

The script is here:

http://www.see.ed.ac.uk/~mrichar1/openvpn-routing/

And relies on the srvany/instsrv tools from Microsoft.  download all the 
files to c:\openvpn-routing\

To install:

instsrv.exe OPENVPN-Routing c:\openvpn-routing\srvany.exe

then edit the registry:

HKLM\CurrentControlSet\Services\OPENVPN-Routing\Parameters\

Create String 'Application' - value of:

cscript c:\openvpn-routing\monitor.vbs

At the moment the script doesn't change the routing tables - instead it
launches notepad to show its working - change the notepad line to the
appropriate route commands to actually use it.

All of the above is really provided as a demonstration of a possible 
solution for this problem - its written in vbs for simplicity, but I 
imagine (not being familiar with the openvpn code-base) that it would be 
possible to reproduce in a more suitable language and bundle as part of 
the openvpn package, and use a better mechanism than tailing the log 
file to make the call to the service to change the routing table.

Just a thought on solving this problem.  Comments etc welcome!

Matthew


-- 
=====================================================
Matthew Richardson
School of Engineering and Electronics,
The University of Edinburgh, King's Buildings,
Mayfield Rd, Edinburgh EH9 3JL
-----------------------------------------------------
0131 650 8747,  FAX: 0131 650 6554
M.Richardson@...1061...
=====================================================

