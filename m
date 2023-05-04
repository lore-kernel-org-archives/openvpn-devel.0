Message-ID: <9fd4f0f6-9ec8-2a7e-630f-78824f4fb0c5@...2181...>
Date: Thu, 4 May 2023 17:19:20 +0200
MIME-Version: 1.0
From: Antonio Quartulli <a@...2181...>
References: <20230414094227.9153-1-kprovost@...2661...>
Content-Language: en-US
In-Reply-To: <20230414094227.9153-1-kprovost@...2661...>
Subject: Re: [Openvpn-devel] [PATCH] DCO: support key rotation notifications
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
To: Kristof Provost <kprovost@...2661...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

Hi,

On 14/04/2023 11:42, Kristof Provost via Openvpn-devel wrote:
> From: Kristof Provost <kp@...1376...>
> 
> Allow the kernel driver to notify us that it's time to renegotiate keys.
> The intent is to avoid IV re-use after 2^32 packets.
> 
> This is a first draft intended for discussion. The accompanying kernel
> change for FreeBSD can be found in https://reviews.freebsd.org/D39570
> 
> Signed-off-by: Kristof Provost <kprovost@...2661...>

This looks good to me and I think it's reasonable to use the 
CMD_SWAP_KEYS as notification for userspace to actually trigger a key 
rotation.

Acked-by: Antonio Quartulli <a@...2181...>

Linux and Windows part is now missing.

Cheers,

> ---
>   src/openvpn/dco_freebsd.c      |  4 ++++
>   src/openvpn/dco_freebsd.h      |  1 +
>   src/openvpn/forward.c          | 32 +++++++++++++++++++++-----------
>   src/openvpn/multi.c            |  4 ++++
>   src/openvpn/ovpn_dco_freebsd.h |  1 +
>   src/openvpn/ssl.c              |  6 ++++++
>   src/openvpn/ssl.h              |  3 +++
>   7 files changed, 40 insertions(+), 11 deletions(-)
> 
> diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
> index a334d5d2..1111abeb 100644
> --- a/src/openvpn/dco_freebsd.c
> +++ b/src/openvpn/dco_freebsd.c
> @@ -550,6 +550,10 @@ dco_do_read(dco_context_t *dco)
>               dco->dco_message_type = OVPN_CMD_DEL_PEER;
>               break;
>   
> +        case OVPN_NOTIF_ROTATE_KEY:
> +            dco->dco_message_type = OVPN_CMD_SWAP_KEYS;
> +            break;
> +
>           default:
>               msg(M_WARN, "Unknown kernel notification %d", type);
>               break;
> diff --git a/src/openvpn/dco_freebsd.h b/src/openvpn/dco_freebsd.h
> index a07f9b69..e1a054e0 100644
> --- a/src/openvpn/dco_freebsd.h
> +++ b/src/openvpn/dco_freebsd.h
> @@ -35,6 +35,7 @@ typedef enum ovpn_key_cipher dco_cipher_t;
>   enum ovpn_message_type_t {
>       OVPN_CMD_DEL_PEER,
>       OVPN_CMD_PACKET,
> +    OVPN_CMD_SWAP_KEYS,
>   };
>   
>   enum ovpn_del_reason_t {
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index b3e0ba5d..d50eb457 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1232,20 +1232,30 @@ process_incoming_dco(struct context *c)
>           return;
>       }
>   
> -    if (dco->dco_message_type != OVPN_CMD_DEL_PEER)
> +    switch (dco->dco_message_type)
>       {
> -        msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
> -            dco->dco_message_type);
> -        return;
> -    }
> +        case OVPN_CMD_DEL_PEER:
> +            if (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED)
> +            {
> +                    msg(D_DCO_DEBUG, "%s: received peer expired notification of for peer-id "
> +                                    "%d", __func__, dco->dco_message_peer_id);
> +                    trigger_ping_timeout_signal(c);
> +                    return;
> +            }
> +            break;
>   
> -    if (dco->dco_del_peer_reason == OVPN_DEL_PEER_REASON_EXPIRED)
> -    {
> -        msg(D_DCO_DEBUG, "%s: received peer expired notification of for peer-id "
> -            "%d", __func__, dco->dco_message_peer_id);
> -        trigger_ping_timeout_signal(c);
> -        return;
> +        case OVPN_CMD_SWAP_KEYS:
> +            msg(D_DCO_DEBUG, "%s: received key rotation notification for peer-id %d",
> +                            __func__, dco->dco_message_peer_id);
> +            tls_session_soft_reset(c->c2.tls_multi);
> +            break;
> +
> +        default:
> +            msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
> +                dco->dco_message_type);
> +            return;
>       }
> +
>   #endif /* if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBSD)) */
>   }
>   
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 5444e752..6fb9cff2 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -3284,6 +3284,10 @@ multi_process_incoming_dco(struct multi_context *m)
>           {
>               process_incoming_del_peer(m, mi, dco);
>           }
> +        else if (dco->dco_message_type == OVPN_CMD_SWAP_KEYS)
> +        {
> +            tls_session_soft_reset(mi->context.c2.tls_multi);
> +        }
>       }
>       else
>       {
> diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
> index fec33835..53f94dfd 100644
> --- a/src/openvpn/ovpn_dco_freebsd.h
> +++ b/src/openvpn/ovpn_dco_freebsd.h
> @@ -36,6 +36,7 @@
>   
>   enum ovpn_notif_type {
>       OVPN_NOTIF_DEL_PEER,
> +    OVPN_NOTIF_ROTATE_KEY,
>   };
>   
>   enum ovpn_del_reason {
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 60aaee8d..26e86c8d 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -1918,6 +1918,12 @@ key_state_soft_reset(struct tls_session *session)
>       ks->remote_addr = ks_lame->remote_addr;
>   }
>   
> +void
> +tls_session_soft_reset(struct tls_multi *tls_multi)
> +{
> +	key_state_soft_reset(&tls_multi->session[TM_ACTIVE]);
> +}
> +
>   /*
>    * Read/write strings from/to a struct buffer with a u16 length prefix.
>    */
> diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
> index 4ed4cfaa..3c40fbed 100644
> --- a/src/openvpn/ssl.h
> +++ b/src/openvpn/ssl.h
> @@ -573,6 +573,9 @@ bool
>   tls_session_generate_data_channel_keys(struct tls_multi *multi,
>                                          struct tls_session *session);
>   
> +void
> +tls_session_soft_reset(struct tls_multi *multi);
> +
>   /**
>    * Load ovpn.xkey provider used for external key signing
>    */

-- 
Antonio Quartulli

-- 
Antonio Quartulli

