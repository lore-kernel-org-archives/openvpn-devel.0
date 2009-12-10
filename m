Date: Thu, 10 Dec 2009 14:15:01 +0200
From: Pasi =?iso-8859-1?Q?K=E4rkk=E4inen?= <pasik@...124...>
Message-ID: <20091210121501.GN16033@...1281...>
MIME-Version: 1.0
Subject: [Openvpn-devel] OpenVPN default gateway problems on Windows after
	resume from hibernation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: openvpn-devel@lists.sourceforge.net

Hello,

I'm having some problems with OpenVPN (2.1rc20) on Windows Vista. 
Yeah I know, vista is crap, but I had to play with it a bit.

I've seen a couple of different problems:

1) I start the openvpn connection, and it works OK. Default gateway is
through the openvpn connection. Then I suspend (hibernate) the laptop,
and after a while when I resume from hibernation, openvpn re-connects the vpn
successfully (openvpn gui icon goes green), but sometimes the default gateway 
is wrong, making the connection non-functional.

OpenVPN related parts of "route print" when the openvpn connection works properly:

IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0        10.0.0.5        10.0.0.6      5
          10.0.0.1  255.255.255.255       10.0.0.5	  10.0.0.6      5

Default route points to the OpenVPN interface correctly and the connections works OK.

Now, after hibernate+resume, _sometimes_ (not always) the routing table
looks like this, and the connection doesn't work:

IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0        10.0.0.5               18      5
          10.0.0.1  255.255.255.255       10.0.0.5               18      5

Which is a bit weird.. Interface is just a number? anyway, the next variation 
happens more often:

IPv4 Route Table
===========================================================================
Active Routes:
Network Destination        Netmask          Gateway       Interface  Metric
          0.0.0.0          0.0.0.0        10.0.0.5  169.254.108.226      5
          10.0.0.1  255.255.255.255       10.0.0.5  169.254.108.226      5


So that looks like it fails to get an IP with DHCP. 
"ipconfig /all" show this:

Ethernet adapter Local Area Connection 3:

   Connection-specific DNS Suffix  . :
   Description . . . . . . . . . . . : TAP-Win32 Adapter V9
   Physical Address. . . . . . . . . : 00-FF-82-51-06-E2
   DHCP Enabled. . . . . . . . . . . : Yes
   Autoconfiguration Enabled . . . . : Yes
   Autoconfiguration IPv4 Address. . : 169.254.108.226(Preferred)
   Subnet Mask . . . . . . . . . . . : 255.255.0.0
   Default Gateway . . . . . . . . . : 10.0.0.5
   NetBIOS over Tcpip. . . . . . . . : Enabled

So yeah.. it failed to obtain an IP with DHCP. 
I saw some DHCP related fixes in the latest rc versions.. related possibly?

Weird that the OpenVPN gui icon is still green, when obviously the openvpn 
connection is broken.


2) OpenVPN and other nics/connections. I had to change the OpenVPN Windows
TAP network adapter interface metric to 5 manually, to make it be the
preferred connection always. Otherwise for example the WLAN took over
the default gateway sometimes.

Is there some way to specify the interface metric in openvpn
configuration? 

Thanks!

-- Pasi


