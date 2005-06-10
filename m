From: "Cullin J. Wible" <cjw@...418...>
MIME-Version: 1.0
In-Reply-To: 
Message-ID: <0MKyxe-1DgqW50V0V-00064n@...419...>
Subject: [Openvpn-devel] RE: Windows XP Unable to Obtain IP Address in 2.0
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
Date: Fri Jun 10 13:56:48 2005
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

After installing OpenVPN 2.0 on a Linux Server and 2 windows desktops (1
Win2K and 1 WinXP) I noticed that from time to time my VPN connection were
unable to get an IP address and would just hang forever (more so on XP the
Win2K). Upon doing further research, it appears that it is exactly the same
problem as the post from almost a year ago regarding 2.0 beta 11 at:
http://openvpn.net/archive/openvpn-users/2004-08/msg00592.html and indicated
by the repetitive log entries:
 
Tue May 24 12:26:00 2005 TEST ROUTES: 0/0 succeeded len=3 ret=0 a=0 u/d=down
Tue May 24 12:26:00 2005 Route: Waiting for TUN/TAP interface to come up...
Tue May 24 12:26:01 2005 TEST ROUTES: 0/0 succeeded len=3 ret=0 a=0 u/d=down
Tue May 24 12:26:01 2005 Route: Waiting for TUN/TAP interface to come up...
Tue May 24 12:26:02 2005 TEST ROUTES: 0/0 succeeded len=3 ret=0 a=0 u/d=down
Tue May 24 12:26:02 2005 Route: Waiting for TUN/TAP interface to come up...
Tue May 24 12:26:04 2005 TEST ROUTES: 0/0 succeeded len=3 ret=0 a=0 u/d=down
Tue May 24 12:26:04 2005 Route: Waiting for TUN/TAP interface to come up...
Tue May 24 12:26:05 2005 TEST ROUTES: 0/0 succeeded len=3 ret=0 a=0 u/d=down
 
I found that there were a couple of things that made this problem go away
and wanted to share them with the group:
 
First, adding the following options to my windows clients helped (but didn't
solve the problem):
    keepalive 10 20
    route-delay 30 30
    float
 
What really solved the problem, was to add the windows "Dhcp" service and
any other relatedservices (such as VMWare's DHCP client) to the dependencies
for the OpenVPN service. This can be done by editing the registry key
located at
HKLM\SYSTEM\CurrentControlSet\Services\OpenVPNService\DependOnService, and
adding the following lines:
    Dhcp
    VMnet
    VMnetDHCP
    VMnetx

While the problem appears to be somewhat random, it happens most when
starting up the PC (as indicated by the service dependencies) and repeatedly
un-plugging the Ethernet cable in rapid succession (why you would ever do
this other then for testing is beyond me).
 
As a result, I would suggestion that the Windows installer for OpenVPN add
the "Dhcp" service as a dependency.
 
I hope that helps.
 
Cullin J. Wible
Algorim Technologies, LLC


