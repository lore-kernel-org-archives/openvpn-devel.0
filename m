From: James Yonan <jim@...41...>
Subject: Re: [Openvpn-devel] Show client IP address in status file
In-Reply-To: <Pine.LNX.4.61.0410141450560.17318@...210...>
Message-ID: <Pine.LNX.4.58.0410141055550.5469@...269...>
References: <Pine.LNX.4.61.0410141450560.17318@...210...>
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
Date: Thu Oct 14 10:13:24 2004
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 8bit
To: Mathias Sundman <mathias@...209...>
Cc: openvpn-devel@lists.sourceforge.net


On Thu, 14 Oct 2004, Mathias Sundman wrote:

> I have a little feature request.
> 
> I use TAP and bridging in many roadwarrior configurations.
> 
> I would really like to see what IP address that has been assigned to which 
> client in the --status file.
> 
> A while ago we discussed how to protect against the user using another IP 
> address that the one he was assigned, and you, James, changed the code so 
> when using TUN, only the assigned IP address is allowed.
> 
> However with TAP you said it was much harder as openvpn only keeps track 
> of MAC addresses rather than IP addresses.
> 
> I can live with this security issue, but would it be possible to just save 
> the IP address that was assigned to a client so it can be showed in the 
> status file?

There will be a way to do this in beta12.  I've added an
--ifconfig-pool-persist option which will periodically output a comma
separated list of <common name>,<IP address> to a file.  This is
ostensibly used to persist the ifconfig pool data across daemon
instantiations but could be used for other purposes as well.

> How does openvpn work when a client is not a single machine, but a whole 
> bridged network? Does openvpn hand out multiple IP addresses from 
> --ifconfig-pool then?

No, --ifconfig-pool is only used to allocate IPs for the actual client
machine which is connecting to the server.  If there is a subnet behind
the client, that subnet can be numbered however you wish.

When --dev tun is used, you can use the --iroute directive to tell the
server which subnets exist behind a particular client.

With --dev tap, this should all work without needing any --iroute
directive because the server is routing based on MAC address and doesn't
care what the IP addresses are.

One difference between --dev tun and --dev tap handling is that in --dev 
tun mode, where we are routing based on IP addresses, the server will not 
"learn" a new IP address or subnet on the client (so that it can route 
back to it) unless you explicitly configure it with --iroute.

With --dev tap handling, where we are routing by MAC address, we try to 
act more like an ethernet bridge, by dynamically learning any MAC address 
that comes from a client, subject to filewall controls which can be set by 
the --learn-address script.

James


