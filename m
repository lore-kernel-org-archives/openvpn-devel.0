References: <1446761780-13816-1-git-send-email-steffan@...1856...>
	<1446795759-3288-1-git-send-email-steffan@...1856...>
	<20151106205635.GA24952@...1296...>
From: Arne Schwabe <arne@...1227...>
Message-ID: <56403904.10006@...1227...>
Date: Mon, 9 Nov 2015 07:11:16 +0100
MIME-Version: 1.0
In-Reply-To: <20151106205635.GA24952@...1296...>
Subject: Re: [Openvpn-devel] [PATCH (master,
 v2)] Fix (potential) memory leak in init_route_list()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: Gert Doering <gert@...1296...>, Steffan Karger <steffan@...1856...>
Cc: openvpn-devel@lists.sourceforge.net


> I can see why we do this gc_addspecial() dance in socket.c (because the
> elements returned by getaddrinfo() are being pointed at, not copied).
> 
> This usage here seems unneeded, as the code will walk netlist, copy
> out the IPv4 addresses into a separate (gc-allocated) struct route_ipv4,
> and never use parts of netlist again - so freeaddrinfo() *should* work,
> and make the code slightly less complex.
> 
> Arne, this came from you in commit e719a053534 (and I ACKed it) - could
> you revisit this particular use and check whether it's truly needed?
> 

I don't think it is really needed. It is more consistency and we try to
use gc functions instead of free/malloc.

Arne


