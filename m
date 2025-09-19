Date: Fri, 19 Sep 2025 17:03:01 +0200
From: Sabrina Dubroca <sd@...2891...>
Message-ID: <aM1wpYP5LYhM3jcz@...2915...>
References: <20250912112420.4394-1-mmietus97@...109...>
 <20250912112420.4394-4-mmietus97@...109...>
 <aMlApjuzBJsHVMjN@...2915...>
 <cd8193c9-1af8-4182-8e6a-a769acfde340@...109...>
MIME-Version: 1.0
In-Reply-To: <cd8193c9-1af8-4182-8e6a-a769acfde340@...109...>
Subject: Re: [Openvpn-devel] [PATCH net-next v2 3/3] net: ovpn: use new
 noref xmit flow in ovpn_udp4_output
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Marek Mietus <mmietus97@...109...>
Cc: netdev@...2909..., antonio@...515..., kuba@...2912..., openvpn-devel@lists.sourceforge.net

2025-09-18, 18:29:08 +0200, Marek Mietus wrote:
> W dniu 9/16/25 o 12:49, Sabrina Dubroca pisze:
> > 2025-09-12, 13:24:20 +0200, Marek Mietus wrote:
> > Why are you changing only ipv4? Is there something in the ipv6 code
> > that prevents this?
> > 
> 
> I'm not sure. I'm not as acquainted with IPv6 as I am with IPv4. (and thought I'd hold off
> until I got a positive response about the series)

Ok, understood.

> IPv4 already has some noref xmit optimizations, so it just felt like the right place to start.

There's also some in IPv6, see d14730b8e911 ("ipv6: use RCU in inet6_csk_xmit()").

-- 
Sabrina

