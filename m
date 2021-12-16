Date: Thu, 16 Dec 2021 16:51:35 +0100 (CET)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <1565170174.1461018.1639669895740@...2642...>
In-Reply-To: <20211214150903.4119175-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
 <20211214150903.4119175-1-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v2 07/21] Add helper functions to
 calculate header/payload sizes
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



> Arne Schwabe <arne@...1227...> hat am 14.12.2021 16:09 geschrieben:
> 
>  
> These functions are intended to lay the groundwork to later replace
> the distributed frame calculations and centralise the calculation in
> one place.
> 
> Patch v2: clarify that the socks comments is assuming IPv4

You addressed by first question, but not my others.

[...]
> diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
> index 0ab716d7a..0da1dadfa 100644
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
[...]
> @@ -51,6 +52,91 @@ alloc_buf_sock_tun(struct buffer *buf,
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
> +    bool tlsmode = options->tls_server || options->tls_client;
> +
> +    /* A socks proxy adds 10 byte of extra header to each packet
> +     * (we only support Socks with IPv4, this value is different for IPv6) */
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
> +    if (tlsmode)
> +    {
> +        header_size += options->use_peer_id ? 4 : 1;
> +    }
> +
> +    /* Add the crypto overhead */
> +    bool packet_id = options->replay;
> +    bool packet_id_long_form = !tlsmode || cipher_kt_mode_ofb_cfb(kt->cipher);
> +
> +    /* For figuring out the crypto overhead, we need to use the real payload
> +     * including all extra headers that also get encrypted */
> +    header_size += calculate_crypto_overhead(kt, packet_id,
> +                                             packet_id_long_form,
> +                                             payload_size, occ);

My question was why you mention "extra headers" here but that doesn't seem to be reflected
in the code itself. After looking further into the code it seems to me that you allude here
to the frame_caculate_payload_overhead function? But you don't use it here, you assume that
the caller of this function already called it. So maybe instead of putting this comment here
it would be better to put that into the documentation of this function in the header?

Regards,
--
Frank Lichtenheld

