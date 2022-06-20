Date: Mon, 20 Jun 2022 15:19:57 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1398737843.386553.1655731197068@...2642...>
In-Reply-To: <20220617041326.2744668-1-i.ponetaev@...2676...>
References: <20220617041326.2744668-1-i.ponetaev@...2676...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH] fix compilation issues with small and
 w/o debug
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: Ilya Ponetayev <i.ponetaev@...2676...>, openvpn-devel@lists.sourceforge.net

Acked-By: Frank Lichtenheld <frank@...2641...>

I can confirm that this fixes issues seen with

./configure --enable-small --disable-debug --enable-werror

(compile tested on Debian 11 amd64, gcc 10.2.1)

The init.c change did not fix a warning for my compiler, but it looks correct
and might be a warning with different compilers.

Regards,
  Frank

> Ilya Ponetayev <i.ponetaev@...2676...> hat am 17.06.2022 06:13 CEST geschrieben:
> 
>  
> ---
>  src/openvpn/init.c      | 2 +-
>  src/openvpn/mtcp.c      | 2 ++
>  src/openvpn/packet_id.c | 2 ++
>  src/openvpn/reliable.c  | 2 ++
>  4 files changed, 7 insertions(+), 1 deletion(-)
> 
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index b0c62a85..f06afc29 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2491,7 +2491,7 @@ frame_finalize_options(struct context *c, const struct options *o)
>      size_t tailroom = headroom;
>  
>  #ifdef USE_COMP
> -    msg(D_MTU_DEBUG, "MTU: adding %lu buffer tailroom for compression for %lu "
> +    msg(D_MTU_DEBUG, "MTU: adding %zu buffer tailroom for compression for %zu "
>          "bytes of payload",
>          COMP_EXTRA_BUFFER(payload_size), payload_size);
>      tailroom += COMP_EXTRA_BUFFER(payload_size);
> diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
> index b725bebb..b3c153fe 100644
> --- a/src/openvpn/mtcp.c
> +++ b/src/openvpn/mtcp.c
> @@ -72,6 +72,7 @@ struct ta_iow_flags
>      unsigned int sock;
>  };
>  
> +#ifdef ENABLE_DEBUG
>  static const char *
>  pract(int action)
>  {
> @@ -114,6 +115,7 @@ pract(int action)
>              return "?";
>      }
>  }
> +#endif /* ENABLE_DEBUG */
>  
>  static struct multi_instance *
>  multi_create_instance_tcp(struct multi_context *m)
> diff --git a/src/openvpn/packet_id.c b/src/openvpn/packet_id.c
> index e357909d..851b506c 100644
> --- a/src/openvpn/packet_id.c
> +++ b/src/openvpn/packet_id.c
> @@ -53,11 +53,13 @@
>  #define SEQ_UNSEEN  ((time_t)0)
>  #define SEQ_EXPIRED ((time_t)1)
>  
> +#ifdef ENABLE_DEBUG
>  static void packet_id_debug_print(int msglevel,
>                                    const struct packet_id_rec *p,
>                                    const struct packet_id_net *pin,
>                                    const char *message,
>                                    int value);
> +#endif /* ENABLE_DEBUG */
>  
>  static inline void
>  packet_id_debug(int msglevel,
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index 37244435..73473625 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -394,6 +394,7 @@ reliable_send_purge(struct reliable *rel, const struct reliable_ack *ack)
>      }
>  }
>  
> +#ifdef ENABLE_DEBUG
>  /* print the current sequence of active packet IDs */
>  static const char *
>  reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
> @@ -412,6 +413,7 @@ reliable_print_ids(const struct reliable *rel, struct gc_arena *gc)
>      }
>      return BSTR(&out);
>  }
> +#endif /* ENABLE_DEBUG */
>  
>  /* true if at least one free buffer available */
>  bool
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
Frank Lichtenheld

