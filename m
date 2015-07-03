Message-ID: <55966BE0.5090400@...1147...>
Date: Fri, 03 Jul 2015 13:02:56 +0200
From: Jan Just Keijser <janjust@...1147...>
MIME-Version: 1.0
Subject: [Openvpn-devel] Adding routes on Windows using DHCP
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
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

hi all,

whilst writing the TFTP/WPAD patch I stumbled upon the options to set a 
default gateway and/or routes using DHCP options.
I've patched openvpn to also set DHCP option 3 ("gateway") and indeed, 
windows picks up the route supplied to it  :)

This might be a way to address this topic from the IRC meeting:

Windows 8.1 DNS registration issues

    * ipconfig failing to execute during VPN connection
      <https://community.openvpn.net/openvpn/ticket/516>
    * Who will fix and how?


It's even possible to run openvpn without admin privileges and set 
routes this way!
Before you get too excited: it does not seem to be possible to replace 
an existing default GW this way. the new 0.0.0.0 route has the metric of 
the tap-win32 adapter , which is better than that of a wifi adapter but 
worse (30 == higher) than that of a regular LAN Adapter (metric=10).

Before I go any deeper into this: what does the rest think about setting 
routes on Windows this way? It could be a nice way to circumvent all 
kinds of "route add" problems.


cheers,

JJK


