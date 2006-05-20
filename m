From: Bryan Neff <bryan.neff@...277...>
Message-ID: <loom.20060520T183548-943@...171...>
Mime-Version: 1.0
Subject: [Openvpn-devel] OpenVPN Crash Drops tap Interface
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
Date: Sat May 20 09:51:02 2006
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello,

I have an application that binds to OpenVPN's interface (tap0).  This app is 
fairly intensive as I can send out ~14Mbps of streaming video using tcp.  
SOMETHING is causing OpenVPN to crash, and when this happens, my app(s) which 
is bound to that interface crashes.

I am running OpenVPN Server 2.0.7 on the Linux 2.6.13 kernel
and OpenVPN 2.0.7 Client on WinXP.

Ideally, I would like to trace what is causing the crash, however, in the 
meantime I would like to seperate the tap0 device and OpenVPN so, worst case, 
I simply lose the availability of VPN connections until my service monitor can 
restart OpenVPN.

I can simulate this by pkill -9 openvpn, the tap0 interface will dissappear 
from ifconfig. 


Any suggestions?


OpenVPN is a great piece of software.  Thank you and the rest of the 
contributors for this.

-Bryan



