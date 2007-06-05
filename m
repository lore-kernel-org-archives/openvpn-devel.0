Message-ID: <4665B1DB.50300@...1000...>
Date: Tue, 05 Jun 2007 20:56:27 +0200
From: Peter Warasin <peter@...1000...>
MIME-Version: 1.0
References: <d5494cd50706050222k4bc500bfy1bf7f1c53fd0869d@...278...>
In-Reply-To: <d5494cd50706050222k4bc500bfy1bf7f1c53fd0869d@...278...>
Subject: Re: [Openvpn-devel] openvpn server in client-to-client mode -
	filtering
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

hi

Oleg Motienko wrote:
> > Is it possible to filter some ports between clients while server is in
> > client-to-clientmode?

you need to direct the traffic out to the servers tun/tap device in
order to filter centralized on the server.

i have the same problem like you. i solved it manually but don't know
exactly how to push the rules correctly.


i toggled of client-to-client mode and set up on each client a host
route for the servers ip address which is bound to the tap device.
then i created on each client routes for each subnet assigned to the
several clients with gateway pointing to the servers tap ip address.

the server certainly routes each client-network back into the tap device

this way each traffic coming from a client going to a client must pass
the servers tap device twice,. so you can filter using netfilter.


only thing which i did not manage to do is to push this routing
configuration to the clients.
maybe we need something like redirect-gateway, but only for a list of
subnets?
or did i understood something wrong?


regards,
peter


-- 
:: e n d i a n
:: open source - open minds

:: peter warasin
:: http://www.endian.com   :: peter@...1028...

