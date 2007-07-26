Message-ID: <46A8C3D5.70307@...1000...>
Date: Thu, 26 Jul 2007 17:55:01 +0200
From: Peter Warasin <peter@...1000...>
MIME-Version: 1.0
References: <46A4E272.9030002@...1000...>
In-Reply-To: <46A4E272.9030002@...1000...>
Subject: Re: [Openvpn-devel] centralized filtering
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: Peter Warasin <peter@...1000...>
Cc: openvpn-devel@lists.sourceforge.net


hola

Peter Warasin wrote:
> > Is there a possibility to configure openvpn server in order to push to
> > it's clients a routing constellation in a manner that every traffic from
> > a vpn endpoint to another vpn endpoint must pass the tap device on the
> > openvpn server?

For whom it may concern: I have found a workaround for this problem.
(maybe there is someone with the same problem)

Use a bigger server-bridge subnet for server-bridge than the address
pool you use for openvpn clients, like:

server-bridge 10.0.0.1 255.255.255.0 10.0.0.129 10.0.0.254

push a lesser subnet which fits the openvpn-pool to the clients:

push "route 10.0.0.128/25"

remove client-to-client


What happens?
The roadwarriors get the whole subnet for setting up their interface but
then get a routing entry which direct traffic to the vpn_gateway for
ip-addresses of the smaller subnet. each vpn endpoint is in the smaller
subnet, so each connection will pass the vpn_gateway and thus also the
servers tap device.

peter


-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.com   :: peter@...1028...

