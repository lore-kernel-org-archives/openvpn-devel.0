Message-ID: <40B0733F.6000307@...196...>
From: Miika Keskinen <weeti@...196...>
MIME-Version: 1.0
Subject: [Openvpn-devel] openvpn 2.0 beta, mode server, bridge, fbd - problem
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
Date: Mon May 24 05:13:03 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hello

I have following setup - openvpn 2.0b2 in mode server. In up-script I 
ifconfig tap-device to 0.0.0.0 promisc up and add that to bridge with 
one physical interface. Sometimes (not allways) I'm getting following 
error message:

(tap0): received packet with  own address as source address


This fixes when I either reboot the box or delete that bridge and build 
it again. also sometimes it's triggered if that physical line is 
connected while rebooting but not when I connect the cable after it has 
booted up. Effectively this is caused by line 285 in net/bridge/br_fbd.c 
(using linux 2.6.6). If someone has had similar problems I'm more than 
glad to hear about. Also it is semi-randomly triggered either from pings 
from eth-device or tap-device - but not from both at the same time - so 
if tap hangs eth will work. I'm wondering if this can be bug in bridge-code?

Yours.
Miika Keskinen


