From: Denis Vlasenko <vda@...216...>
Subject: Re: [Openvpn-devel] openvpn-2.0_beta1: tunnel MTU a bit too large
References: <200405161143.42983.vda@...216...> <twig.1084740580.39452@...41...> <twig.1084830135.40921@...41...>
In-Reply-To: <twig.1084830135.40921@...41...>
MIME-Version: 1.0
Message-Id: <200405180110.05618.vda@...216...>
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
Date: Mon May 17 17:01:21 2004
Content-Type: text/plain;
  charset="windows-1251"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
To: James Yonan <jim@...41...>, openvpn-devel@lists.sourceforge.net

[snip]
> > Anyway, regarding --mssfix: I dont want to work around the problem.
> > I want to set correct tunnel MTU. An MTU such that:
> > 1) large UDP packets (say, 7000 bytes) sent over tunnel link are cut into
> > fragments of such size that, when encapsulated and sent over
> > carrier link, do not exceed MTU of carrier path (in my case, 1500).
> > Ideally, they should be equal to it.
> > 2) TCP streams should use MSS which, again, results in sending full-sized
> > packets over carrier link.
>
> This is possible with correct settings of --tun-mtu/--link-mtu, --fragment,
> and --mssfix.
>
> James

I don't see that in my testing. --tun-mtu 1434 is maximum which does not
violate (1). I will try setting --mssfix to value higher than 1434 to
tweak TCP packet sizes.
--
vda


