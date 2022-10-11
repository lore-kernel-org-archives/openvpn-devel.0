From: Heiko Hund <heiko@...2662...>
Date: Tue, 11 Oct 2022 14:23:28 +0200
Message-ID: <5046863.QJadu78ljV@...2664...>
In-Reply-To: <20220625234150.3398864-2-arne@...1227...>
References: <20220625234150.3398864-1-arne@...1227...>
 <20220625234150.3398864-2-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v3 2/5] Allow tun-mtu to be pushed
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Doesn't apply to master anymore, please rebase.

On Sonntag, 26. Juni 2022 01:41:47 CEST Arne Schwabe wrote:
> --- a/doc/man-sections/vpn-network-options.rst
> +++ b/doc/man-sections/vpn-network-options.rst
> @@ -516,6 +516,11 @@ routing.
>    It's best to use the ``--fragment`` and/or ``--mssfix`` options to deal
>    with MTU sizing issues.
> 
> +--tun-max-mtu maxmtu

--tun-mtu-max

> +            if (c->options.ce.tun_mtu > frame->tun_max_mtu)
> +            {
> +                msg(D_PUSH_ERRORS, "Server pushed a large mtu, please add "
> +                    "tun-mtu-max %d in the client configuration", +

"a too large MTU, to accept it add" would describe it better

> @@ -222,6 +222,7 @@ frame_print(const struct frame *frame,
>      buf_printf(&out, " max_frag:%d", frame->max_fragment_size);
>  #endif
>      buf_printf(&out, " tun_mtu:%d", frame->tun_mtu);
> +    buf_printf(&out, " tun_max_mtu:%d", frame->tun_max_mtu);

should be printed as "tun_mtu_max" to be consistent with the option. Maybe it 
Should even make sense to rename the frame element to match the option name as 
they are closely related.





