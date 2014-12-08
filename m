Message-ID: <5485F66D.5010300@...1856...>
Date: Mon, 08 Dec 2014 20:05:17 +0100
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
References: <1418057325-13265-1-git-send-email-lstipakov@...277...>
In-Reply-To: <1418057325-13265-1-git-send-email-lstipakov@...277...>
Subject: Re: [Openvpn-devel] [PATCH] Prevent memory drain for long lasting
 floating sessions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

ACK. Less memory usage (even without float), and got rid of a dynamic
allocation, nice! Code looks good and passes my local tests.

-Steffan

On 08-12-14 17:48, Lev Stipakov wrote:
> For every float event we generate prefix, which allocates 256 + 64
> bytes. That memory is reclaimed when client disconnects, so long lasting
> and constantly floating sessions drain memory.
> 
> As a fix use preallocated buffer inside multi_instance for storing
> multi_prefix.
> 
> Signed-off-by: Lev Stipakov <lstipakov@...277...>
> ---
>  src/openvpn/mudp.c  |  4 ++++
>  src/openvpn/multi.c | 14 ++++++++++----
>  src/openvpn/multi.h |  8 +++++---
>  3 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
> index 853c08c..3e3f750 100644
> --- a/src/openvpn/mudp.c
> +++ b/src/openvpn/mudp.c
> @@ -111,6 +111,10 @@ multi_get_create_instance_udp (struct multi_context *m, bool *floated)
>  			      break;
>  			    }
>  			}
> +
> +		      /* should not really end up here, since multi_create_instance returns null
> +		       * if amount of clients exceeds max_clients */
> +		      ASSERT(i < m->max_clients);
>  		    }
>  		}
>  	      else
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 538f4f1..fd0d0fe 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -403,7 +403,7 @@ multi_instance_string (const struct multi_instance *mi, bool null, struct gc_are
>  {
>    if (mi)
>      {
> -      struct buffer out = alloc_buf_gc (256, gc);
> +      struct buffer out = alloc_buf_gc (MULTI_PREFIX_MAX_LENGTH, gc);
>        const char *cn = tls_common_name (mi->context.c2.tls_multi, true);
>  
>        if (cn)
> @@ -420,21 +420,27 @@ multi_instance_string (const struct multi_instance *mi, bool null, struct gc_are
>  void
>  generate_prefix (struct multi_instance *mi)
>  {
> -  mi->msg_prefix = multi_instance_string (mi, true, &mi->gc);
> +  struct gc_arena gc = gc_new();
> +  const char *prefix = multi_instance_string (mi, true, &gc);
> +  if (prefix)
> +    strncpynt(mi->msg_prefix, prefix, sizeof(mi->msg_prefix));
> +  else
> +    mi->msg_prefix[0] = '\0';
>    set_prefix (mi);
> +  gc_free(&gc);
>  }
>  
>  void
>  ungenerate_prefix (struct multi_instance *mi)
>  {
> -  mi->msg_prefix = NULL;
> +  mi->msg_prefix[0] = '\0';
>    set_prefix (mi);
>  }
>  
>  static const char *
>  mi_prefix (const struct multi_instance *mi)
>  {
> -  if (mi && mi->msg_prefix)
> +  if (mi && mi->msg_prefix[0])
>      return mi->msg_prefix;
>    else
>      return "UNDEF_I";
> diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
> index ad7f700..32b89d2 100644
> --- a/src/openvpn/multi.h
> +++ b/src/openvpn/multi.h
> @@ -42,6 +42,8 @@
>  #include "mtcp.h"
>  #include "perf.h"
>  
> +#define MULTI_PREFIX_MAX_LENGTH 256
> +
>  /*
>   * Walk (don't run) through the routing table,
>   * deleting old entries, and possibly multi_instance
> @@ -80,7 +82,7 @@ struct multi_instance {
>    struct mroute_addr real;      /**< External network address of the
>                                   *   remote peer. */
>    ifconfig_pool_handle vaddr_handle;
> -  const char *msg_prefix;
> +  char msg_prefix[MULTI_PREFIX_MAX_LENGTH];
>  
>    /* queued outgoing data in Server/TCP mode */
>    unsigned int tcp_rwflags;
> @@ -445,10 +447,10 @@ static inline void
>  set_prefix (struct multi_instance *mi)
>  {
>  #ifdef MULTI_DEBUG_EVENT_LOOP
> -  if (mi->msg_prefix)
> +  if (mi->msg_prefix[0])
>      printf ("[%s]\n", mi->msg_prefix);
>  #endif
> -  msg_set_prefix (mi->msg_prefix);
> +  msg_set_prefix (mi->msg_prefix[0] ? mi->msg_prefix : NULL);
>  }
>  
>  static inline void
> 

