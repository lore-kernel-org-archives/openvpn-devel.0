MIME-Version: 1.0
In-Reply-To: <7ac51ab2-4c62-2bb4-f38b-664a25e3df12@...2137...>
References: <789ad4be-2cb0-9af9-1d3f-7d1a9c05a1ab@...2137...>
 <20180727192636.GK55859@...1296...>
 <330e6498-78e9-c6f2-de16-3ae207fe26c7@...2137...>
 <CAKuzo_hpbaD3f4ZOcP_rBpkRpkHW=4HvE9Gw4g4umohk+e7NFA@...278...>
 <7ac51ab2-4c62-2bb4-f38b-664a25e3df12@...2137...>
From: Selva Nair <selva.nair@...277...>
Date: Sun, 29 Jul 2018 10:19:38 -0400
Message-ID: <CAKuzo_gEGsH6bw1R8FBcOa8UMkpx2wKMQFAN4C0dmY69AA6pMQ@...278...>
Subject: Re: [Openvpn-devel] Set interface metric instead letting it on auto
 (OS choice) when we have redirect-gateway present to enforce the desired
 effect for IPv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
To: s7r@...2137...
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi


>
> Thanks for the hint Selva. Indeed it looks like something DNS related.
> The primary wired network interface has 1 IPv4-listening DNS server
> (192.168.1.1, which uses 2 upstream IPv4-listening DNS server from the
> ISP). The tun device has 2 IPv4 listening DNS servers (google) and 2
> IPv6 listening DNS servers (google) pushed via dhcp-option DNS.
>
> When it is "not working", the DNS server from the wired network
> interface (192.168.1.1) is used. When it is "working", as when the
> metric for the tun/tap adapter is changed to be lower than primary wired
> network interface, google IPv6 listening DNS server is used.

Apparently that's how Windows work. Use --block-outside-dns if you
want to be sure that the DNS servers set on the tun/tap is used. That
will block dns traffic via all other interfaces and also lower the
metric of tun interface.

Selva

