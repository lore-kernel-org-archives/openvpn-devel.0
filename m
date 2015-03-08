MIME-Version: 1.0
In-Reply-To: <1425745391-8069-1-git-send-email-steffan@...1856...>
References: <1425745391-8069-1-git-send-email-steffan@...1856...>
Date: Sun, 8 Mar 2015 11:13:33 +0200
Message-ID: <CAGyAFMWsY+HfZoyKLpZApSgEDvwMdxtGkFBXeH25EFuO6T-V-g@...278...>
From: Lev Stipakov <lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Change float log message to include
 common name, if available.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To: Steffan Karger <steffan@...1856...>
Cc: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

ACK

2015-03-07 18:23 GMT+02:00 Steffan Karger <steffan@...1856...>:
> Makes it a lot easier to see which client is floating.
>
> Signed-off-by: Steffan Karger <steffan@...1856...>
> ---
>  src/openvpn/multi.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 4412491..b0f66ca 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2151,8 +2151,11 @@ void multi_process_float (struct multi_context* m, struct multi_instance* mi)
>        multi_close_instance(m, ex_mi, false);
>      }
>
> -    msg (D_MULTI_MEDIUM, "peer %" PRIu32 " floated from %s to %s", mi->context.c2.tls_multi->peer_id,
> -        mroute_addr_print (&mi->real, &gc), print_link_socket_actual (&m->top.c2.from, &gc));
> +    msg (D_MULTI_MEDIUM, "peer %" PRIu32 " (%s) floated from %s to %s",
> +       mi->context.c2.tls_multi->peer_id,
> +       tls_common_name (mi->context.c2.tls_multi, false),
> +       mroute_addr_print (&mi->real, &gc),
> +       print_link_socket_actual (&m->top.c2.from, &gc));
>
>      ASSERT (hash_remove(m->hash, &mi->real));
>      ASSERT (hash_remove(m->iter, &mi->real));
> --
> 2.1.0
>
>
> ------------------------------------------------------------------------------
> Dive into the World of Parallel Programming The Go Parallel Website, sponsored
> by Intel and developed in partnership with Slashdot Media, is your hub for all
> things parallel software development, from weekly thought leadership blogs to
> news, videos, case studies, tutorials and more. Take a look and join the
> conversation now. http://goparallel.sourceforge.net/
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel



-- 
-Lev

