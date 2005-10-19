From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Bug report (long) - OpenVPN dropping small frames
In-Reply-To: <dj6pnr$gs4$1@...165...>
Message-ID: <Pine.LNX.4.58.0510192103130.32723@...41...>
References: <dj6pnr$gs4$1@...165...>
MIME-Version: 1.0
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
Date: Wed Oct 19 20:28:57 2005
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mike Ireton <mike-openvpn@...479...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, 19 Oct 2005, Mike Ireton wrote:

> I have recently been able to observe this situation first hand with 
> tcpdump running at the OpenVPN server and client sides. I saw frames go 
> into the tunnel that _did not_ make it out the other side. Worse yet, it 
> appeared that the frames not making it out (the encapsulated pppoe 
> frames) were all destined for one mac address in particular. Like, for 
> whatever reason, OpenVPN appeared to not be able to decapsulate any 
> frames destined for one particular mac address for some period of time.

I need a more granular snapshot of what's happening here.

To properly test for packet lossage on an OpenVPN session between machines
A and B, you would need 4 simultaneous tcpdump sessions:

(1) Machine A -- tcpdump on tap interface
(2) Machine A -- tcpdump on TCP/UDP 1194 (internet gateway interface)
(3) Machine B -- tcpdump on TCP/UDP 1194 (internet gateway interface)
(4) Machine B -- tcpdump on tap interface

When you do your 1393 byte ping from A to B, the packet is going to travel
1 -> 2 -> 3 -> 4 -> ICMP echo reply on B -> 4 -> 3 -> 2 -> 1.

I need to know exactly where the packet is being dropped in this chain.

If the packet disappears between 1 and 2 or between 3 and 4 then either
OpenVPN or a firewall/packet-filter operating on the tap interface is
dropping it.

If the packet disappears between 2 and 3, it's a network connectivity 
issue, or a firewall/router/NAT issue on OpenVPN's communication port 
(usually 1194).

BTW, I tried a 1393 byte ping through an OpenVPN tap tunnel with default
settings and it worked fine.

If you think that 1393 is an important number with respect to reproducing
the problem, try to isolate and differentiate the cases where 1393 byte
pings fail and where they succeed.

James


