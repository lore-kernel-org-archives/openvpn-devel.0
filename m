Message-ID: <406A7C21.80804@...177...>
From: Farkas Levente <lfarkas@...177...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] OpenVPN 2.0 -- Project Update and Release Notes
References: <twig.1080688545.10218@...41...>
In-Reply-To: <twig.1080688545.10218@...41...>
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
Date: Wed Mar 31 00:08:01 2004
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
To: openvpn-users@lists.sourceforge.net, openvpn-devel@lists.sourceforge.net

first of all THANKS!

James Yonan wrote:
> * Add an internal routing capability to the OpenVPN server to allow
> client-to-client communication, without going through the tun interface on the
> server.

why this is needed? ans what exactly this means?

> * Right now clients are allocated a single, dynamic IP address.  It would be
> nice if a connecting client could specify a full subnet to be tunneled.

would be welcome!

> * It would be nice to provide for some client-side failover by allowing
> --remote to specify a set of machines, or allow a hostname in --remote that
> has been configured with multiple addresses in DNS.  The idea is that a server
> would be randomly chosen from the list, and if the connect failed, another
> would be tried.

would be nice.

> * True point-to-multipoint capability -- essentially a generalization of the
> current multi-client server model.  In point-to-multipoint mode, a host can
> securely connect into a kind of "VPN cloud" that is fully distributed, without
> a single point of failure.  The VPN cloud is like a small version of the
> internet itself and uses a protcol such as OSPF to dynamically manage routing
> information.  The key advantage of this model is that it is distributed rather
> than being bound to a single server.  This means that VPN traffic will take a
> direct path between any 2 points in the cloud, rather than needing to go
> through a central server.

how does this effect the --redirect-gateway option? it's my favorite 
since I like that my vpn clients can only communicate with me (the 
server) and through me the rest of the world (intranet, other vpn point 
and internet). this is essential when I wanna make a central firewall 
and internet access policy.
this is why it's not clear to me what do you mean by the above 
"client-to-client communication"?

> # The server's virtual endpoints
> ifconfig 10.8.0.1 10.8.0.2

this means this server has two enpoint in the server side?

-- 
   Levente                               "Si vis pacem para bellum!"


