Message-ID: <53C28CED.6060501@...1227...>
Date: Sun, 13 Jul 2014 15:43:09 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
References: <1405075659-7881-1-git-send-email-arne@...1227...>
	<1405254527-23833-1-git-send-email-gert@...1296...>
In-Reply-To: <1405254527-23833-1-git-send-email-gert@...1296...>
Subject: Re: [Openvpn-devel] [PATCH] Fix server routes not working in
 topology subnet with --server [v3]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
To: Gert Doering <gert@...1296...>, openvpn-devel@lists.sourceforge.net

On 13.07.2014 14:28, Gert Doering wrote:
> From: Arne Schwabe <arne@...1227...>
>
> The IPv4 routing code needs an IPv4 address to point a route to, and
> in --topology subnet mode, the *server* did not have one set by default.
>
> So we now just default --route-gateway to the next address right after
> the server address - the specific address doesn't matter, as the correct
> next-hop will not be resolved by the host OS but by the OpenVPN daemon.
> All that is needed is "it's in the subnet routed to the tun interface".
>
> Using the server address itself would work on unix, but doesn't work with
> the Windows TAP driver (as it does not spoof ARP responses for itself).
>
>
ACK.

Arne

