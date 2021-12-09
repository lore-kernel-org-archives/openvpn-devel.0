Date: Thu, 9 Dec 2021 14:10:39 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1692147884.739294.1639055439893@...2642...>
In-Reply-To: <20211207170211.3275837-8-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211207170211.3275837-8-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 07/21] Add helper functions to calculate
 header/payload sizes
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



> Arne Schwabe <arne@...1227...> hat am 07.12.2021 18:01 geschrieben:
[...]  
> diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
> index 0ab716d7a..25b943722 100644
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
[...]
> @@ -51,6 +52,85 @@ alloc_buf_sock_tun(struct buffer *buf,
>      ASSERT(buf_safe(buf, 0));
>  }
>  
> +size_t
> +frame_calculate_protocol_header_size(const struct key_type *kt,
> +                                     const struct options *options,
> +                                     unsigned int payload_size,
> +                                     bool occ)
> +{
> +    /* Sum of all the overhead that reduces the usable packet size */
> +    size_t header_size = 0;
> +
> +    /* A socks proxy adds 10 byte of extra header to each packet */

This is only true since we do not support IPv6 UDP over socks. Would it be worth
to point that out?

> +    if (options->ce.socks_proxy_server && proto_is_udp(options->ce.proto))
> +    {
> +        header_size += 10;
> +    }
> +
> +    /* TCP stream based packets have a 16 bit length field */
> +    if (proto_is_tcp(options->ce.proto))
> +    {
> +        header_size += 2;
> +    }
> +
> +    /* Add the opcode and peerid */
> +    header_size += options->use_peer_id ? 4 : 1;
> +
> +    /* Add the crypto overhead */
> +    bool packet_id = options->replay;
> +    bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
> +
> +    /* For figuring out the crypto overhead, we need to use the real payload
> +     * including all extra headers that also get encrypted */

That comment sounds like header size should somehow be a input into
calculate_crypto_overhead, which it isn't. Is there an error here or
do I just misunderstand the comment?

> +    header_size += calculate_crypto_overhead(kt, packet_id,
> +                                             packet_id_long_form,
> +                                             payload_size, occ);
> +    return header_size;
> +}
> +
> +
> +size_t
> +frame_calculate_payload_overhead(const struct frame *frame,
> +                                 const struct options *options,
> +                                 bool extra_tun)
> +{
> +    size_t overhead = 0;
> +
> +    /* This is the overhead of tap device that is not included in the MTU itself
> +     * i.e. Ethernet header that we still need to transmit as part of the
> +     * payload*/
> +    if (extra_tun)
> +    {
> +        overhead += frame->extra_tun;
> +    }
> +
> +#if defined(USE_COMP)
> +    /* v1 Compression schemes add 1 byte header. V2 only adds a header when it
> +     * does not increase the packet length. We ignore the unlikely escaping
> +     * for tap here */
> +    if (options->comp.alg == COMP_ALG_LZ4 || options->comp.alg == COMP_ALG_STUB
> +        || options->comp.alg == COMP_ALG_LZO)
> +    {
> +        overhead += 1;
> +    }
> +#endif
> +#if defined(ENABLE_FRAGMENT)
> +    if (options->ce.fragment)
> +    {
> +        overhead += 4;

Every other statement has an explanation of the number, except this one. Maybe you could add
one here as well?

> +    }
> +#endif
> +    return overhead;
> +}
> +
> +size_t
> +frame_calculate_payload_size(const struct frame *frame, const struct options *options)
> +{
> +    size_t payload_size = options->ce.tun_mtu;
> +    payload_size += frame_calculate_payload_overhead(frame, options, true);
> +    return payload_size;
> +}
> +
>  void
>  frame_finalize(struct frame *frame,
>                 bool link_mtu_defined,

Regards,
  Frank

--
Frank Lichtenheld

