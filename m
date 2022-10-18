Date: Tue, 18 Oct 2022 18:02:35 +0200
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <Y07OG5Jgt2kKSc5U@...2685...>
References: <20220921104930.3452270-1-arne@...1227...>
MIME-Version: 1.0
In-Reply-To: <20220921104930.3452270-1-arne@...1227...>
Subject: Re: [Openvpn-devel] [PATCH v4 1/3] Ensure that control channel
 packet are respecting maximum packet size
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
To: Arne Schwabe <arne@...1227...>
Cc: openvpn-devel@lists.sourceforge.net

On Wed, Sep 21, 2022 at 12:49:28PM +0200, Arne Schwabe wrote:
> This ensures that control packets are actually smaller than the maximum
> control channel packet size.
> 
> Since OpenVPN will consider a control message packet complete
> when the TLS record is complete, we have to ensure that the SSL library
> will still write one record, so the receiving side will only be able
> to get/read the control message content when a TLS record is
> complete. To achieve this goal, this commit does:
> 
> - Split one read from TLS library into multiple control
>   channel packets, splitting one TLS record into multiple
>   control packets.
> - increase allowed number of outstanding packets to 6 from 4 on the
>   sender side. This is still okay with older implementations as
>   receivers will have room for 8.
> - calculate the overhead for control channel message to allow
>   staying below that threshold.
> - remove maxlen from key_state_read_ciphertext and related functions
>   as we now always allow control channel messages to be up to
>   TLS_CHANNEL_BUF_SIZE in size and no longer limit this by the mtu of
>   control packets as the implemented splitting will take care of
>   larger payloads from the SSL library
> 
> Note this commit has a warning message that references max-packet-size that
> is introduced in the next commit. In this commit the packet size is not yet
> configurable.
> 
> Patch v2: avoid assertion about to large buffer by sticking to 1250 max
>           control size in this commit and leaving larger sizes for the
>           --max-packet-size commit. Also fix
>           various other small problems and grammar fixes.
> Patch v3: grammar fixes
> Patch v4: adjust tls-mtu to max-packet-size in message.

Reread the code. Did some client-side tests with small MTUs. Didn't find any issues.
One remaining typo found, see below.

I think it would actually have been possible to split this up in even smaller
patches (e.g. removing the maxlen parameter), but probably not worth doing that
now on a v4.

Acked-By: Frank Lichtenheld <frank@...2641...>

> diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
> index 672cd9c84..b69258be8 100644
> --- a/src/openvpn/ssl.c
> +++ b/src/openvpn/ssl.c
[...]
> @@ -2675,6 +2718,92 @@ read_incoming_tls_plaintext(struct key_state *ks, struct buffer *buf,
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
> +            msg(D_TLS_ERRORS, "--max-packet-size setting too low. Unable to "
> +                "send control channel message.");
> +        }
> +        msg(D_REL_LOW, "Reliable: Send queue full, postponing TLS send");
> +        return true;
> +    }
> +
> +    /* This seems a bit wasteful to allocate every time */
> +    struct gc_arena gc = gc_new();
> +    struct buffer tmp = alloc_buf_gc(TLS_CHANNEL_BUF_SIZE, &gc);
> +
> +    int status = key_state_read_ciphertext(&ks->ks_ssl, &tmp);
> +
> +    if (status == -1)
> +    {
> +        msg(D_TLS_ERRORS,
> +            "TLS Error: Ciphertext -> reliable TCP/UDP transport read error");
> +        gc_free(&gc);
> +        return false;
> +    }
> +    if (status == 1)
> +    {
> +        /* Split the TLS ciphertext (TLS record) into multiple small packets
> +         * that respect tls_mtu */
> +        while (tmp.len)
> +        {
> +            int len = max_pkt_len;
> +            int opcode = P_CONTROL_V1;
> +            if (control_packet_needs_wkc(ks))
> +            {
> +                opcode = P_CONTROL_WKC_V1;
> +                len = max_int(0, len - buf_len(session->tls_wrap.tls_crypt_v2_wkc));
> +            }
> +            /* do not send more than available */
> +            len = min_int(len, tmp.len);
> +
> +            struct buffer *buf = reliable_get_buf_output_sequenced(ks->send_reliable);
> +            /* we assert here since we checked for its availibility before */

"availability"

> +            ASSERT(buf);
> +            buf_copy_n(buf, &tmp, len);
> +
> +            reliable_mark_active_outgoing(ks->send_reliable, buf, opcode);
> +            INCR_GENERATED;
> +            *state_change = true;
> +        }
> +        dmsg(D_TLS_DEBUG, "Outgoing Ciphertext -> Reliable");
> +    }
> +
> +    gc_free(&gc);
> +    return true;
> +}
> +
>  

Regards,
-- 
  Frank Lichtenheld

