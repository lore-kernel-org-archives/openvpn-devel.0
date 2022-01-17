MIME-Version: 1.0
References: <20220117093508.17681-1-a@...2181...>
In-Reply-To: <20220117093508.17681-1-a@...2181...>
From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 17 Jan 2022 11:50:58 +0200
Message-ID: <CAGyAFMVP7=2sXZHGv+m5uTw9sNCbUnEXGeziPomDp5eKp3y4Ew@...278...>
Subject: Re: [Openvpn-devel] [PATCH] use 'static inline' instead of 'inline
 static'
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
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, Lev Stipakov <lev@...515...>

Makes sense.

Acked-by: Lev Stipakov <lstipakov@...277...>

ma 17. tammik. 2022 klo 11.36 Antonio Quartulli (a@...2181...) kirjoitti:
>
> There are 2 occurrences where the order 'inline static' is used when
> defining a function, while the rest of the code uses the definitely
> more common form 'static inline'.
>
> Convert those 2 occurrences to the common format.
>
> Reported-by: Lev Stipakov <lev@...515...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/buffer.h | 2 +-
>  src/openvpn/proto.h  | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
> index 8017130f..d2dbb64b 100644
> --- a/src/openvpn/buffer.h
> +++ b/src/openvpn/buffer.h
> @@ -198,7 +198,7 @@ bool buf_init_debug(struct buffer *buf, int offset, const char *file, int line);
>
>
>  /* inline functions */
> -inline static void
> +static inline void
>  gc_freeaddrinfo_callback(void *addr)
>  {
>      freeaddrinfo((struct addrinfo *) addr);
> diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
> index 94010a98..0062951d 100644
> --- a/src/openvpn/proto.h
> +++ b/src/openvpn/proto.h
> @@ -251,7 +251,7 @@ struct ip_tcp_udp_hdr {
>   * This returns an ip protocol version of packet inside tun
>   * and offset of IP header (via parameter).
>   */
> -inline static int
> +static inline int
>  get_tun_ip_ver(int tunnel_type, struct buffer *buf, int *ip_hdr_offset)
>  {
>      int ip_ver = -1;
> --
> 2.34.1
>
>
>
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

