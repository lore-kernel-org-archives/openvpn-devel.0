Date: Wed, 11 May 2022 11:59:07 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <623304717.640814.1652263147363@...2642...>
In-Reply-To: <20220510170448.1856465-1-arne@...1227...>
References: <20220422142953.3805364-16-arne@...1227...>
 <20220510170448.1856465-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 25/28] Ensure that control channel
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

Typo/grammar fixes only for now.

> Arne Schwabe <arne@...1227...> hat am 10.05.2022 19:04 geschrieben:
> This ensure that control packets are actually  smaller than tls-mtu.

"ensures"

> Since OpenVPN will consider a control message packet complete
> when the TLS record is complete, we have to ensure that the SSL library
> will still write one record, so the receiving side will only be able
> to get/read the control message content when a TLS record is
> complete. To achieve this goal, this commit does:
> 
> - Splitting one read from TLS library into multiple control

"split" to be consistent with other bullet points.

>   channel packets, splitting one TLS record into multiple
>   control packets.
> - increase allowed number of outstanding packets to 6 from 4 on the
>   sender side. This is still okay with older implementation as

"implementations"

>   receivers will have room for 8.
> - calculate the overhead for control channel message to allow
>   staying below that threshold.
> - remove maxlen from key_state_read_ciphertext and related functions
>   as we now always allow control channel messages to be up to
>   TLS_CHANNEL_BUF_SIZE in size and longer limit this by the mtu of

"no longer"

>   control packets as the implemented splitting will take care of
>   larger payloads from the SSL library
> 
> Patch v2: avoid assertion about to large buffer by sticking to 1250 max control size

"too"

>           in this commit and leaving larger sizes for the --tls-mtu commit. Also fix
>           various other small problems and grammer fixes.

"grammar"

[...]
> @@ -496,6 +489,38 @@ reliable_get_buf(struct reliable *rel)
>      return NULL;
>  }
>  
> +/* Counts the number of free buffers in output that can be potientially used

"potentially"

> + * for sending */
> +int
> +reliable_get_num_output_sequenced_available(struct reliable *rel)
> +{
[...]
> diff --git a/src/openvpn/reliable.h b/src/openvpn/reliable.h
> index b9863efe3..5b4f75c28 100644
> --- a/src/openvpn/reliable.h
> +++ b/src/openvpn/reliable.h
[...]
> @@ -385,6 +399,20 @@ void reliable_mark_deleted(struct reliable *rel, struct buffer *buf);
>   */
>  struct buffer *reliable_get_buf_output_sequenced(struct reliable *rel);
>  
> +
> +/**
> + * Counts the number of free buffers in output that can be potientially used

"potentially"

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
> index 61dea996d..1e3c500d8 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
[...]
> @@ -334,6 +336,47 @@ tls_init_control_channel_frame_parameters(const struct frame *data_channel_frame
>      frame->tun_mtu = min_int(data_channel_frame->tun_mtu, 1250);
>  }
>  
> +/**
> + * calculate the maximum overhead that control channel frames have

"."

> + * This includes header, op code and everything apart from the
> + * payload itself. This method is a bit pessimistic and might give higher
> + * overhead than we actually have */
> +static int
> +calc_control_channel_frame_overhead(const struct tls_session *session)
> +{
[...]
> @@ -2638,6 +2681,91 @@ read_incoming_tls_plaintext(struct key_state *ks, struct buffer *buf,
>      return true;
>  }
>  
> +static bool
> +write_outgoing_tls_ciphertext(struct tls_session *session, bool *state_change)
> +{
> +    struct key_state *ks = &session->key[KS_PRIMARY];
> +
> +    int rel_avail = reliable_get_num_output_sequenced_available(ks->send_reliable);
> +    if (rel_avail == 0)
> +    {
> +        return true;
> +    }
> +
> +    /* We need to determine how much space is actually available in the control
> +     * channel frame */
> +
> +    int max_pkt_len = min_int(TLS_CHANNEL_BUF_SIZE, session->opt->frame.tun_mtu);
> +
> +
> +    /* Subtract overhead */
> +    max_pkt_len -= calc_control_channel_frame_overhead(session);
> +
> +    /* calculate total available length for outgoing tls ciphertext */
> +    int maxlen = max_pkt_len * rel_avail;
> +
> +    /* Is first packet one that will have a WKC appended? */
> +    if (control_packet_needs_wkc(ks))
> +    {
> +        maxlen -= buf_len(session->tls_wrap.tls_crypt_v2_wkc);
> +    }
> +
> +    /* Not enough space available to send a full control channel packet */
> +    if (maxlen < TLS_CHANNEL_BUF_SIZE)
> +    {
> +        if (rel_avail == TLS_RELIABLE_N_SEND_BUFFERS)
> +        {
> +            msg(D_TLS_ERRORS, "--tls-mtu setting to low. Unable to send TLS packets");

"too"

--tls-mtu is not actually defined, yet. But not sure whether it is worth
fixing this just to restore the text in the next commit.

> +        }
> +        msg(D_REL_LOW, "Reliable: Send queue full, postponing TLS send");
> +        return true;
> +    }
[...]

Regards,
--
Frank Lichtenheld

