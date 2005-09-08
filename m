Message-ID: <432012B6.9080104@...177...>
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
References: <Pine.LNX.4.58.0509062125110.12112@...41...>
In-Reply-To: <Pine.LNX.4.58.0509062125110.12112@...41...>
Subject: [Openvpn-devel] Re: [Openvpn-users] New subnet topology feature ready for testing
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
Date: Thu Sep  8 03:50:12 2005
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net, openvpn-users@lists.sourceforge.net

James Yonan wrote:
> OpenVPN Addressing Topology
> ---------------------------
> However, now I've put together a brand new topology, called "topology
> subnet".  This topology is very intuitive, like the "dev tap" topology
> where each client gets a single IP address from a pool, the server gets
> the .1 address, clients get .2, .3, .4, etc., and all clients and the
> server can communicate by virtue of possessing a single IP address taken
> out of the shared VPN subnet.  Plus -- a very cool property of this
> feature is that it works on Windows clients as well as any *nix system
> which supports tun interfaces being configured by ifconfig with an
> IP/netmask rather than the usual local and remote endpoint (Linux supports 
> this, I haven't tried any of the BSDs yet).

it's amazing feature! thanks!!!

> Other interesting features
> --------------------------
> 
> "redirect-gateway bypass-dhcp" gets around the problem of DHCP packets 
> to the local DHCP server being incorrectly routed into the tunnel.

one quick question without reading the whole docs.
i always like to know my vpn enpoint has a static ip address so if i'd 
like to access joe's vpn i can simply use joe.vpn.company.com name. is 
it possible to use this new subnet topology and somehow staticaly define 
endpoint's ip address? the best would be if i can use a central internal 
dhcp server which can give ip, subnet, dns and other address to the vpn 
clients automaticaly. is it possible with linux and windows clients?

> Merging Schedule
> ----------------
> 
> With sufficient testing, this code will be a candidate for inclusion in 
> 2.1 or higher, and will be applicable to the 2.0.x branch via manual 
> merging.  While this patch is not huge, it's deep enough that I don't plan 
> on merging it in 2.0.x anytime soon.

i'd like to see some kind of early 2.1 or 2.1rc release since we can 
create rpm packages this and test it.

-- 
   Levente                               "Si vis pacem para bellum!"


