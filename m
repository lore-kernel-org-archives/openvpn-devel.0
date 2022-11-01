MIME-Version: 1.0
References: <20221012133457.1927871-1-arne@...1227...>
 <20221026164522.3773718-1-arne@...1227...>
In-Reply-To: <20221026164522.3773718-1-arne@...1227...>
From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 1 Nov 2022 11:21:40 +0200
Message-ID: <CAGyAFMU6RDJOo6YOYaHXPxfqS0Xt1ctGx_wrF2X-GKoiYsM+wg@...278...>
Subject: Re: [Openvpn-devel] [PATCH v2 1/3] Move dco_installed from
 sock->info to sock->info.lsa.actual
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

Hi,

> @@ -1190,7 +1190,7 @@ link_socket_write(struct link_socket *sock,
>                    struct buffer *buf,
>                    struct link_socket_actual *to)
>  {
> -    if (proto_is_udp(sock->info.proto) || sock->info.dco_installed)
> +    if (proto_is_udp(sock->info.proto) || to->dco_installed)
>      {

Previously we used to check the dco flag from sock->info and now it is changed
to "to", which is a separate member in c->c2 (c->c2.to_link_addr vs
c->c2.link_socket).

Why not use "sock->info.lsa->actual.dco_installed" ? My understanding
is that this patch
only moves the flag to a different place and is not supposed to change
the behavior.

Besides, below we call link_socket_write_win32(), which down the stack
checks dco flag from "sock",
not from "to":

    static inline int
    link_socket_write_win32(struct link_socket *sock,
                            struct buffer *buf,
                            struct link_socket_actual *to)
    {
        int err = 0;
        int status = 0;
        sockethandle_t sh = { .s = sock->sd, .is_handle =
sock->info.lsa->actual.dco_installed };

This doesn't look consistent.

-Lev

