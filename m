Message-ID: <95544bb0-bfdf-0698-d91d-b4178880579e@...2181...>
Date: Wed, 8 Mar 2023 20:00:21 +0100
MIME-Version: 1.0
Content-Language: en-US
References: <20230308151945.3670151-1-arne@...1227...>
From: Antonio Quartulli <a@...2181...>
In-Reply-To: <20230308151945.3670151-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH] Set netlink socket to be non-blocking
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Hi,

On 08/03/2023 16:19, Arne Schwabe wrote:
> Even though we use select/poll to explicitly query when the nextlink

nextlink -> netlink

> socket is ready for read, sometimes we end up reading from the socket
> when it is not ready to read and then the process hangs for several
> seoneds (20-30s). Avoid this situation by setting the socket to be
> non-blocking, so we get a status in this case that allows us to continue.
> 
> Change-Id: I35447c23a9350176007df5455bf9451021e9856d
> Signed-off-by: Arne Schwabe <arne@...1227...>

Well spotted!

Acked-by: Antonio Quartulli <a@...2181...>

> ---
>   src/openvpn/dco_linux.c | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
> index 1a6566aad..6f1b999bb 100644
> --- a/src/openvpn/dco_linux.c
> +++ b/src/openvpn/dco_linux.c
> @@ -359,7 +359,9 @@ ovpn_dco_init_netlink(dco_context_t *dco)
>               nl_geterror(ret));
>       }
>   
> +    /* set close on exec and non-block on the netlink socket */
>       set_cloexec(nl_socket_get_fd(dco->nl_sock));
> +    set_nonblock(nl_socket_get_fd(dco->nl_sock));
>   
>       dco->nl_cb = nl_cb_alloc(NL_CB_DEFAULT);
>       if (!dco->nl_cb)

-- 
Antonio Quartulli

