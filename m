Message-ID: <400AE191.3090801@...158...>
From: Doug Lytle <support@...158...>
MIME-Version: 1.0
References: <twig.1074156443.1050@...41...>
In-Reply-To: <twig.1074156443.1050@...41...>
Subject: [Openvpn-devel] Re: [Openvpn-users] OpenVPN 1.6-beta1 released
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
Date: Sun Jan 18 11:43:02 2004
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>
Cc: openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

James,

Just put 1.6 beta into place.  I will no longer set routes via 
office.up.bat on Windows 2000.  I currently have a up delay of 5 
seconds.  This is what I get in my logs:

---SNIP---

Sun Jan 18 14:30:17 2004 20: Local Options hash (VER=V3): 'e6303372'
Sun Jan 18 14:30:17 2004 21: Expected Remote Options hash (VER=V3): 
'e6303372'
Sun Jan 18 14:30:17 2004 22: UDPv4 link local (bound): [undef]:5001
Sun Jan 18 14:30:17 2004 23: UDPv4 link remote: 12.27.xxx.xxx:5001
Sun Jan 18 14:30:20 2004 24: Peer Connection Initiated with 
12.27.xxx.xxx:5001
Sun Jan 18 14:30:22 2004 25: Attempting to lock Win32 semaphore 
'openvpn_netcmd' prior to net shell command (timeout = 600 sec)
Sun Jan 18 14:30:22 2004 26: TAP-WIN32 device [OpenVPN] opened: 
\\.\{A93FB2A2-9C8A-4040-9B4A-461BEB112723}.tap
Sun Jan 18 14:30:22 2004 27: TAP-Win32 Driver Version 4.18
Sun Jan 18 14:30:22 2004 28: TAP-Win32 MTU=1500
Sun Jan 18 14:30:22 2004 29: Notified TAP-Win32 driver to set a dynamic 
IP/netmask of 192.168.200.6/255.255.255.252 on interface 
{A93FB2A2-9C8A-4040-9B4A-461BEB112723}
Sun Jan 18 14:30:22 2004 30: Successful ARP Flush on interface [2] 
{A93FB2A2-9C8A-4040-9B4A-461BEB112723}
Sun Jan 18 14:30:22 2004 31: office.up.bat OpenVPN 1500 1577 
192.168.200.6 255.255.255.252 init

C:\Program Files\OpenVPN\config>route add 192.168.100.0 mask 
255.255.255.0 192.168.200.5
The route addition failed: Either the interface index is wrong or the 
gateway does not lie on the same network as the interface. Check the IP 
Address Table for the machine.


C:\Program Files\OpenVPN\config>route add 192.168.101.0 mask 
255.255.255.0 192.168.200.5
The route addition failed: Either the interface index is wrong or the 
gateway does not lie on the same network as the interface. Check the IP 
Address Table for the machine.


C:\Program Files\OpenVPN\config>route add 192.168.102.0 mask 
255.255.255.0 192.168.200.5
The route addition failed: Either the interface index is wrong or the 
gateway does not lie on the same network as the interface. Check the IP 
Address Table for the machine.


C:\Program Files\OpenVPN\config>route add 192.168.103.0 mask 
255.255.255.0 192.168.200.5
The route addition failed: Either the interface index is wrong or the 
gateway does not lie on the same network as the interface. Check the IP 
Address Table for the machine.


C:\Program Files\OpenVPN\config>route add 192.168.104.0 mask 
255.255.255.0 192.168.200.5
The route addition failed: Either the interface index is wrong or the 
gateway does not lie on the same network as the interface. Check the IP 
Address Table for the machine.

---SNIP---

Now, if I remove the office.up.bat in the configuration and wait for the 
VPN to be established, and run the office.up.bat manually, everything 
works great.  Guessing it's to do with the .252 subnet mask?

Doug

>  
>


