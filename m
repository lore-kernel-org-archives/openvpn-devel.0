Date: Thu, 1 Nov 2007 13:32:06 +0300
From: Alexey Vdovin <admin@...1022...>
Message-ID: <469588034.20071101133206@...1022...>
In-Reply-To: <20071101101408.GA3572@...1017...>
References: <20071101101408.GA3572@...1017...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] DHCP Renew failing on Windows
Reply-To: Alexey Vdovin <admin@...1022...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: Michele Baldessari <michele-lists@...1016...>
Cc: openvpn-devel@lists.sourceforge.net

Hello Michele,

Most probably it happens when DHCP lase is expires and client trys
renew DHCP address.

Check DHCP lease lifetime, try decrease it to reproduce the issue.

-- 
Best regards,
 Alexey                            mailto:admin@...1022...


Thursday, November 1, 2007, 1:14:08 PM, you wrote:

MB> Hi James et al.,

MB> I'm running OpenVPN quite successfully on 20 Windows XP roadwarrios, in
MB> order to access different networks. All the clients access a single VPN
MB> concentrator (2.0.9 on Debian Etch) using x.509 authentication and
MB> depending on a few server-side scripts they receive personalized routes
MB> and iptables rules. (Nb: the INPUT chain is empty and defaults to
MB> ACCEPT, only FORWARD rules are defined by the scripts).

MB> So far so good, the setup works flawlessly pretty much all the time.
MB> Almost two or three times a month though, one or two roadwarriors
MB> (I've not been able to extrapolate a pattern, it happens to random people),
MB> loses all the OpenVPN-pushed routes. 
MB> The VPN connection is still up and running: if you add the routes manually 
MB> it keeps on working without an itch. A reboot restores normal behaviour.

MB> The client in the logs receives the following two warnings in the System
MB> Event log:

MB> 1) Your computer was not able to renew its address from the network (from
MB>    the DHCP Server) for the Network Card with network address 00FF97B41B3C.
MB>    The following error occurred:
MB>    The semaphore timeout period has expired. . Your computer will continue
MB>    to try and obtain an address on its own from the network address (DHCP)
MB>    server.

MB> 2) Your computer has automatically configured the IP address for the
MB>    Network Card with network address 00FF97B41B3C.  The IP address being
MB>    used is 169.254.236.158.

MB> So it basically wasn't able to renew the DHCP lease, hence the dropping
MB> of the routes. (Note that the initiale DHCP works fine, the client
MB> receives its routes correctly. It's just that afterwards, I believe on
MB> the subsequent renew but I'm not 100% sure, it fails and it loses all the 
MB> VPN-pushd routes).

MB> I've tried the tap-sleep option and raised the waiting time to no avail.
MB> I'll now try the --dhcp-renew and --dhcp-release options, but I suspect
MB> they won't help much.

MB> I hope I can get a packet trace of this problem, but so far I've never
MB> been able to reproduce under wireshark.

MB> Any tips/hints on how to nail down and debug this beast?

MB> thanks,
MB> Michele


