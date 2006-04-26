From: Eric Limpens <eric@...624...>
Subject: Re: [Openvpn-devel] Changing routes on the client
Message-ID: <20060426102143.71f89ea8@...625...>
In-Reply-To: <20060425171727.6abb2a1b@...625...>
References: <20060425100020.18086c30@...625...>
	<20060425171727.6abb2a1b@...625...>
Mime-Version: 1.0
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
Date: Wed Apr 26 01:24:02 2006
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: openvpn-devel@lists.sourceforge.net

On Tue, 25 Apr 2006 17:17:27 +0200
Eric Limpens <eric@...624...> wrote:

> Digging thru the sources, I've found a more convenient way by adding a
> new flag to the redirect-gateway option.
> When set, it uses 'add_route3' to re-route all (local) traffic to the 
> remote endpoint: 
> 
> add_route3(0xc08a0500, 0xffffff00, rl->spec.rmote_endpoint, tt,
> flags, es)
> 
> However the 2 first parameters should be determined by the os.. For
> testing purposes I've hardcoded them, things work as expected.
> 
> My question: does anyone have pointers how to obtain the local-net
> and netmask?


Anyone to enlighten me?

It appears the rl->spec.net_gateway is the original gateway and 
rl->spec.remote_endpoint is the address I'ld like to route all
traffic to.

I'm still missing the netmask for the original network. Is there
an easy way to retrieve this?


