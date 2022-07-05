From: Heiko Hund <heiko@...2662...>
Date: Tue, 05 Jul 2022 14:32:25 +0200
Message-ID: <30400821.xTBbKaCY6X@...2664...>
In-Reply-To: <20220624083809.23487-24-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
 <20220624083809.23487-24-a@...2181...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 23/25] dco-win: implement ovpn-dco
 support in P2P Windows code path
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

On Freitag, 24. Juni 2022 10:38:07 CEST Antonio Quartulli wrote:
> +        if (!is_windco(c->c1.tuntap))
[...]
> +    if ((options->windows_driver ==
> WINDOWS_DRIVER_WINTUN || options->windows_driver == WINDOWS_DRIVER_WINDCO)
[...]
> +create_socket_windco(struct context *c, struct link_socket *sock,

Thinking "_dco_win" would be a better suffix for consistency.

> -            status = WSAGetLastError();
> +            if (sock->info.dco_installed)
> +            {
> +                status = GetLastError();
> +            }
> +            else
> +            {
> +                status = WSAGetLastError();
> +            }

Small wrapper would be good as this construct appears twice.





