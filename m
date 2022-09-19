Date: Mon, 19 Sep 2022 16:47:43 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <YyiBDyh3jKn8iUVI@...2685...>
References: <20220919141757.9336-1-a@...2181...>
MIME-Version: 1.0
In-Reply-To: <20220919141757.9336-1-a@...2181...>
Subject: Re: [Openvpn-devel] [PATCH] p2p/dco: renew peer in P2P mode upon
 reconnection
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
To: Antonio Quartulli <a@...2181...>
Cc: openvpn-devel@lists.sourceforge.net

On Mon, Sep 19, 2022 at 04:17:57PM +0200, Antonio Quartulli wrote:
> In P2P mode when the peer reconnects we have to renew the state in DCO
> in order to inform it about the new peer-id.
> 
> Cc: Arne Schwabe <arne@...1227...>
> Signed-off-by: Antonio Quartulli <a@...2181...>
> ---
>  src/openvpn/forward.c |  2 +-
>  src/openvpn/ssl.c     | 42 +++++++++++++++++++++++++++++++++++++-----
>  src/openvpn/ssl.h     |  3 ++-
>  3 files changed, 40 insertions(+), 7 deletions(-)
> 
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 810cb8a7..cdf97d44 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -171,7 +171,7 @@ check_tls(struct context *c)
>      if (interval_test(&c->c2.tmp_int))
>      {
>          const int tmp_status = tls_multi_process
> -                                   (c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
> +                                   (c, c->c2.tls_multi, &c->c2.to_link, &c->c2.to_link_addr,
>                                     get_link_socket_info(c), &wakeup);

Now that you pass c, all other options are redundant.

>          if (tmp_status == TLSMP_ACTIVE)
>          {
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 3116fa4b..652df5d6 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -45,6 +45,7 @@
>  
>  #include "error.h"
>  #include "common.h"
> +#include "openvpn.h"
>  #include "socket.h"
>  #include "misc.h"
>  #include "fdmisc.h"
> @@ -2717,7 +2718,8 @@ read_incoming_tls_plaintext(struct key_state *ks, struct buffer *buf,
>  
>  
>  static bool
> -tls_process_state(struct tls_multi *multi,
> +tls_process_state(struct context *c,
> +                  struct tls_multi *multi,
>                    struct tls_session *session,
>                    struct buffer *to_link,
>                    struct link_socket_actual **to_link_addr,
> @@ -2827,6 +2829,20 @@ tls_process_state(struct tls_multi *multi,
>          state_change = true;
>          dmsg(D_TLS_DEBUG_MED, "STATE S_SENT_KEY");
>          ks->state = S_SENT_KEY;
> +
> +        /* In P2P mode we have to renew the peer in DCO in case of
> +         * reconnection (--tls-server case)
> +         */
> +        if (session->opt->server && (session->opt->mode != MODE_SERVER)
> +            && (ks->key_id == 0) && c->c2.tls_multi->dco_peer_added)

The redundant options make this weird. So here you use c->c2.tls_multi
instead of multi parameter, which should be the same thing. But of
course there is no guarantee that it is. Confusing.

It think it would be better to get rid of the redundant options
(e.g. convert them to local variables) to avoid this ambiguity.

> +        {
> +            msg(D_DCO, "Renewing P2P peer in tls-server mode");
> +            int ret = dco_p2p_add_new_peer(c);
> +            if (ret < 0)
> +            {
> +                msg(D_DCO, "Cannot renew peer in DCO: %s (%d)", strerror(-ret), ret);
> +            }
> +        }
>      }
>  
>      /* Receive Key */
[...]

Regards,
-- 
  Frank Lichtenheld

