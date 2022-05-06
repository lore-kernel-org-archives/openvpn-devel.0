Date: Fri, 6 May 2022 17:43:49 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <312454070.350745.1651851829138@...2642...>
In-Reply-To: <20220422142953.3805364-16-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-16-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 25/28] Ensure that control channel
 packet are respecting tls-mtu
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
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

Note: Patch has some conflicts against current master.
Note2: I get "make check" failures:
2022-05-06 16:29:23 Assertion failed at init.c:2991 (c->c2.tls_multi->opt.frame.buf.payload_size <= c->c2.frame.buf.payload_size)
2022-05-06 16:29:23 Exiting due to fatal error

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> This ensure that control packets are actually are actually smaller than

redundant "are actually"

> tls-mtu. Since OpenVPN will consider a control message packet complete
> when the TLS record is complete, we have to ensure that the SSL library
> will still write one records, so the receiving side will only be able

"record"

> to get/read the control message content when a TLS records is

"record"

> complete. To achieve this goal, this commit does:
> 
> - Splitting one read from TLS library into multiple control
>   channel packets, splitting one TLS record into multiple
>   control packets.
> - increase allowed number of outstanding packets to 6 from 4 on the
>   sender side. This is still okay with older implementation as
>   receivers will have room for 8.
> - calculate the overhead for control channel message to allow
>   staying below that threshold.
> - remove maxlen from key_state_read_ciphertext and related functions
>   as we now always allow control channel messages to be up to
>   TLS_CHANNEL_BUF_SIZE in size and longer limit this by the mtu of
>   control packets as the implemented splitting will take care of
>   larger payloads from the SSL library
> ---
>  src/openvpn/reliable.c    |  64 +++++++++++----
>  src/openvpn/reliable.h    |  32 +++++++-
>  src/openvpn/ssl.c         | 162 ++++++++++++++++++++++++++++++++------
>  src/openvpn/ssl_backend.h |   8 +-
>  src/openvpn/ssl_mbedtls.c |  14 +---
>  src/openvpn/ssl_openssl.c |  16 ++--
>  src/openvpn/ssl_pkt.h     |   4 +-
>  7 files changed, 229 insertions(+), 71 deletions(-)
> 
> diff --git a/src/openvpn/reliable.c b/src/openvpn/reliable.c
> index 372444350..28f99d187 100644
> --- a/src/openvpn/reliable.c
> +++ b/src/openvpn/reliable.c
> @@ -41,30 +41,30 @@
>  
>  #include "memdbg.h"
>  
> -/*
> - * verify that test - base < extent while allowing for base or test wraparound
> - */
> -static inline bool
> -reliable_pid_in_range1(const packet_id_type test,
> -                       const packet_id_type base,
> -                       const unsigned int extent)
> +/* calculates test - base while allowing for base or test wraparound. test is
> + * assume to be higher than base */

"assumed"

> +static inline packet_id_type
> +subtract_pid(const packet_id_type test, const packet_id_type base)
>  {
>      if (test >= base)
>      {
> -        if (test - base < extent)
> -        {
> -            return true;
> -        }
> +        return test - base;
>      }
>      else
>      {
> -        if ((test+0x80000000u) - (base+0x80000000u) < extent)
> -        {
> -            return true;
> -        }
> +        return (test+0x80000000u) - (base+0x80000000u);

As discussed on IRC, I think this is bogus. test - base is the same as (test+0x80000000u) - (base+0x80000000u),
so I don't see what the if accomplishes.

>      }
> +}
>  
> -    return false;
> +/*
> + * verify that test - base < extent while allowing for base or test wraparound
> + */
> +static inline bool
> +reliable_pid_in_range1(const packet_id_type test,
> +                       const packet_id_type base,
> +                       const unsigned int extent)
> +{
> +    return subtract_pid(test, base) < extent;
>  }
>  
>  /*
> @@ -496,6 +496,38 @@ reliable_get_buf(struct reliable *rel)
>      return NULL;
>  }
>  
> +/* Counts the number of free buffers in output that can be potientially used
> + * for sending */
> +int
> +reliable_get_num_output_sequenced_available(struct reliable *rel)
> +{
> +    struct gc_arena gc = gc_new();
> +    packet_id_type min_id = 0;
> +    bool min_id_defined = false;
> +
> +    /* find minimum active packet_id */
> +    for (int i = 0; i < rel->size; ++i)
> +    {
> +        const struct reliable_entry *e = &rel->array[i];
> +        if (e->active)
> +        {
> +            if (!min_id_defined || reliable_pid_min(e->packet_id, min_id))
> +            {
> +                min_id_defined = true;
> +                min_id = e->packet_id;
> +            }
> +        }
> +    }
> +
> +    int ret = rel->size;
> +    if (min_id_defined)
> +    {
> +        ret -= subtract_pid(rel->packet_id, min_id);

Okay... Why does this work? packet_id always increases by 1 exactly?

> +    }
> +    gc_free(&gc);
> +    return ret;
> +}
> +
>  /* grab a free buffer, fail if buffer clogged by unacknowledged low packet IDs */
>  struct buffer *
>  reliable_get_buf_output_sequenced(struct reliable *rel)
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index 8152e788c..c80949525 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
> @@ -46,7 +46,7 @@
>                                   *   be stored in one \c reliable_ack
>                                   *   structure. */
>  
> -#define RELIABLE_CAPACITY 8     /**< The maximum number of packets that
> +#define RELIABLE_CAPACITY 12    /**< The maximum number of packets that
>                                   *   the reliability layer for one VPN
>                                   *   tunnel in one direction can store. */
>  
> @@ -93,7 +93,7 @@ struct reliable
>      int size;
>      interval_t initial_timeout;
>      packet_id_type packet_id;
> -    int offset;
> +    int offset; /**< Offset of the bufs in the reliable_entry array */
>      bool hold; /* don't xmit until reliable_schedule_now is called */
>      struct reliable_entry array[RELIABLE_CAPACITY];
>  };
> @@ -178,6 +178,20 @@ reliable_ack_empty(struct reliable_ack *ack)
>      return !ack->len;
>  }
>  
> +/**
> + * Returns the number of packets that need to be acked.
> + *
> + * @param ack The acknowledgment structure to check.
> + *
> + * @returns the number of outstanding acks
> + */
> +static inline bool

bool? you probably meant int.

> +reliable_ack_outstanding(struct reliable_ack *ack)
> +{
> +    return ack->len;
> +}
> +
> +
>  /**
>   * Write a packet ID acknowledgment record to a buffer.
>   *
> @@ -385,6 +399,20 @@ void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
>   */
>  struct buffer *reliable_get_buf_output_sequenced(struct reliable *rel);
>  
> +
> +/**
> + * Counts the number of free buffers in output that can be potientially used
> + * for sending
> + *
> + *  @param rel The reliable structure in which to search for a free
> + *     entry.
> + *
> + *  @return the number of buffer that are available for sending without
> + *             breaking ack sequence
> + * */
> +int
> +reliable_get_num_output_sequenced_available(struct reliable *rel);
> +
>  /**
>   * Mark the reliable entry associated with the given buffer as
>   *     active outgoing.
> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 01717559c..3b81f9707 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
> @@ -323,10 +323,12 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
>      /* Previous OpenVPN version calculated the maximum size and buffer of a
>       * control frame depending on the overhead of the data channel frame
>       * overhead and limited its maximum size to 1250. We always allocate the
> -     * 1250 buffer size since a lot of code blindly assumes a large buffer
> -     * (e.g. PUSH_BUNDLE_SIZE) and set frame->mtu_mtu as suggestion for the
> +     * TLS_CHANNEL_BUF_SIZE buffer size since a lot of code blindly assumes
> +     * a large buffer (e.g. PUSH_BUNDLE_SIZE) and also our peer might have
> +     * a higher size configure and we still want to be able to receive the

"configured"

> +     * packets. frame->mtu_mtu is set as suggestion for the maximum packet
>       * size */
> -    frame->buf.payload_size = 1250 + overhead;
> +    frame->buf.payload_size = TLS_CHANNEL_BUF_SIZE + overhead;
>  
>      frame->buf.headroom = overhead;
>      frame->buf.tailroom = overhead;
> @@ -334,6 +336,48 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
>      frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
>  }
>  
> +/**
> + * calculate the maximum overhead that control channel frames have
> + * This includes header, op code and everything apart from the
> + * payload itself. This method is a bit pessmistic and might give higher

"pessimistic"

> + * overhead that we actually have */

"than"

> +static int
> +calc_control_channel_frame_overhead(const struct tls_session *session)
> +{
> +    const struct key_state *ks = &session->key[KS_PRIMARY];
> +    int overhead = 0;
> +
> +    /* TCP length field and opcode */
> +    overhead+= 3;
> +
> +    /* our own session id */
> +    overhead += SID_SIZE;
> +
> +    /* ACK array and remote SESSION ID (part of the ACK array) */
> +    overhead += ACK_SIZE(min_int(reliable_ack_outstanding(ks->rec_ack), CONTROL_SEND_ACK_MAX));
> +
> +    /* Message packet id */
> +    overhead += sizeof(packet_id_type);
> +
> +    if (session->tls_wrap.mode == TLS_WRAP_CRYPT)
> +    {
> +        overhead += tls_crypt_buf_overhead();
> +        overhead += packet_id_size(true);

tls_crypt_buf_overhead already contains packet_id_size(true)

> +    }
> +    else if (session->tls_wrap.mode == TLS_WRAP_AUTH)
> +    {
> +        overhead += hmac_ctx_size(session->tls_wrap.opt.key_ctx_bi.encrypt.hmac);
> +        overhead += packet_id_size(true);
> +    }
> +
> +    /* Add the typical UDP overhead for an IPv6 UDP packet. TCP+IPv6 has a
> +     * larger overhead but the risk of a TCP connection getting dropped because
> +     * we try to send a too large packet is basically zero */
> +    overhead += datagram_overhead(AF_INET6, PROTO_UDP);
> +
> +    return overhead;
> +}
> +
>  void
>  init_ssl_lib(void)
>  {
> @@ -2613,10 +2657,13 @@ control_packet_needs_wkc(const struct key_state *ks)
[...]

Rest of patch not yet reviewed.

Regards,
--
Frank Lichtenheld

