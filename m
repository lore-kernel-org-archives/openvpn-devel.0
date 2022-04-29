Date: Fri, 29 Apr 2022 15:11:27 +0200 (CEST)
From: Frank Lichtenheld <frank@...2641...>
Message-ID: <877931381.691988.1651237887669@...2642...>
In-Reply-To: <20220422142953.3805364-13-arne@...1227...>
References: <20220422134038.3801239-1-arne@...1227...>
 <20220422142953.3805364-1-arne@...1227...>
 <20220422142953.3805364-13-arne@...1227...>
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH 22/28] Implement HMAC based session id
 for tls-crypt v2
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

> Arne Schwabe <arne@...1227...> hat am 22.04.2022 16:29 geschrieben:
> 
>  
> Tls-crypt v2 is more complicated to implement a proper stateless
> handshake. To allow state handshake this commit does
> 
>  - introduce a new packet CONTROL_WKC_V1 that repeats the wrapped
>    client key.
>  - introduce a way to negotiate the support for this packet in the
>    three way handshake
> 
> Details about the protocol changes are in tls-crypt-v2.txt. Optional
> arguments to the tls-crypt-v2 option have been added to explicitly
> allow or disallow client that do not support the stateless handshake.
[...] 
> diff --git a/Changes.rst b/Changes.rst
> index ceb0b2680..a7e8b4b81 100644
> --- a/Changes.rst
> +++ b/Changes.rst
> @@ -69,6 +69,14 @@ Improved ``--mssfix`` and ``--fragment`` calculation
>      account and the resulting size is specified as the total size of the VPN packets
>      including IP and UDP headers.
>  
> +Cookie based handshake for UDP server
> +    Instead of allocating a connection for each client on the initial packet
> +    OpenVPN will now send back a response that contains an HMAC based cookie
> +    that the client will need to respond to. This eliminates the amplification
> +    attack and resource exhaustion attacks. For tls-crypt-v2 clients, this
> +    requires OpenVPN 2.6 clients or later and the tls-crypt-v2 option allows
> +    controlling if older clients are accepted.

I think this sounds like much more intrusive protocol changes than are actually
happening. What about something more like:

Cookie based handshake for UDP server
    Instead of allocating a connection for each client on the initial packet
    OpenVPN server will now use an HMAC based cookie as its session id. This
    way the server can verify it on completing the handshake without keeping
    state. This eliminates the amplification and resource exhaustion attacks.
    For tls-crypt-v2 clients, this requires OpenVPN 2.6 clients or later
    because the client needs to resend its client key on completing the hand
    shake. The tls-crypt-v2 option allows controlling if older clients are
    accepted.

> diff --git a/doc/man-sections/tls-options.rst b/doc/man-sections/tls-options.rst
> index ac5756034..5ad58140d 100644
> --- a/doc/man-sections/tls-options.rst
> +++ b/doc/man-sections/tls-options.rst
> @@ -486,6 +486,13 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>    8000 years'.
>  
>  --tls-crypt-v2 keyfile
> +
> +  Valid syntax:
> +  ::
> +
> +     tls-crypt-v2 keyfile [force-cookie]
> +     tls-crypt-v2 keyfile [allow-noncookie]

I find that a slightly confusing mixture of examples. I would go either for
     tls-crypt-v2 keyfile [force-cookie|allow-noncookie]
or
     tls-crypt-v2 keyfile force-cookie
     tls-crypt-v2 keyfile allow-noncookie
     tls-crypt-v2 keyfile

> +
>    Use client-specific tls-crypt keys.
>  
>    For clients, ``keyfile`` is a client-specific tls-crypt key. Such a key
> @@ -501,6 +508,13 @@ certificates and keys: https://github.com/OpenVPN/easy-rsa
>    client is using client-specific keys, and automatically select the right
>    mode.
>  
> +  The optional parameters :code:`force-cookie` allows only tls-crypt-v2
> +  clients that support a cookie based stateless three way handshake that
> +  avoids replay attacks and state exhaustion on the server side (OpenVPN
> +  2.6 and later). The option :code:`allow-noncookie` explicilty allows

"explicitly"

> +  older tls-crypt-v2 clients. The default is (currently)
> +  :code:`allow-noncookie`.
> +
>  --tls-crypt-v2-verify cmd
>    Run command ``cmd`` to verify the metadata of the client-specific
>    tls-crypt-v2 key of a connecting client. This allows server
> diff --git a/doc/tls-crypt-v2.txt b/doc/tls-crypt-v2.txt
> index f6a6a1395..224b24ab4 100644
> --- a/doc/tls-crypt-v2.txt
> +++ b/doc/tls-crypt-v2.txt
> @@ -157,6 +157,47 @@ When setting up the openvpn connection:
>     messages.
>  
>  
> +HMAC Cookie support
> +-------------------
> +To avoid exhaustion attack and keeping state for connections that fail to

"and" -> "by" ?

> +complete thethree way handshake, the OpenVPN server will use its own session

"the three"

> +id as challenge that the client must repeat in the third packet of the
> +handshake. This introduces a problem. If the server does not keep the wrapped
> +client key from the initial packet, the server cannot decode the third packet.
> +Therefore, tls-crypt-v2 in 2.6 allows resending the wrapped key in the third
> +packet of the handshake with the P_CONTROL_WKC_V1 message. The modified
> +handshake is as follows (the rest of the handshake is unmodified):
> +
> +1. The client creates the P_CONTROL_HARD_RESET_CLIENT_V3 message as before
> +   but to indicate that it supports resending the wrapped key by setting the

"to indicate" -> "indicates"

> +   packet id of the replay id to 0x0f010000 where the first byte indicates the
> +   early negotiation support and the next bytes the flags.

Uff, that sentence goes on and on :)
Maybe at least split it after 0x0f010000?
"packet id of the replay id to 0x0f010000. The first byte indicates the"

> +2. The server responds with a P_CONTROL_HARD_RESET_V2 message. Instead of having
> +   an empty payload like normally, the payload consists of TLV (type (uint16),
> +   length (uint16), value) packets. TLV was chosen
> +   to allow extensibility in the future. Currently only the following TLV is
> +   defined:
> +
> +   flags - type 0x01, length 2.
> +
> +   Bit 1 indicates that the client needs to resend the WKC in the third packet.

"WKc"

> +
> +3. Instead of normal P_ACK_V1 or P_CONTROL_V1 packet, the client will send a
> +   P_CONTROL_WKC_V1 packet. The P_CONTROL_WKC_V1 is identical to a normal
> +   P_CONTROL_V1 packet but with the WKc appended.
> +
> +   Normally the first message of the client is either P_ACK_V1, directly
> +   followed by a P_CONTROL_V1 message that contains the TLS Client Hello or
> +   just a P_CONTROL_V1 message. Instead of a P_ACK_V1 message the client should
> +   send a P_CONTROL_WKC_V1 message with an empty payload. This message must
> +   also include an ACK for the P_CONTROL_HARD_RESET_V2 message.
> +
> +   When directly sending the TLS Client Hello message in the P_CONTROL_WKC_V1
> +   message, the client must ensure that the resulting P_CONTROL_WKC_V1 message
> +   with the appended Wkc does not extend the control message length.

"WKc"

[...]
> diff --git a/src/openvpn/ssl_pkt.h b/src/openvpn/ssl_pkt.h
> index 75cdc1c58..48b94e952 100644
> --- a/src/openvpn/ssl_pkt.h
> +++ b/src/openvpn/ssl_pkt.h
[...]
> @@ -262,4 +273,23 @@ packet_opcode_name(int op)
>              return "P_???";
>      }
>  }
> +
> +/* initial packet id (instead of 0) that indicates that the peer supports
> + * early protocol negotiation. This will make the packet id turn a bit faster
> + * but the network time part of the packet id could take care of that. And
> + * this is also a rather theoretical scenario as it still needs more than
> + * 2^31 control channel packets to happen */
> +#define EARLY_NEG_MASK          0xff000000
> +#define EARLY_NEG_START         0x0a000000
> +
> +#define EARLY_NEG_RESENDWKC     0x00010000
> +
> +
> +/* Early negotiation that part of the server response in the RESET_V2 packet.
> + * Since clients that announce early negotiation support will treat the payload
> + * of reset packets special and parse it as TLV messages.
> + * as TLV (type, length, value) */
> +#define EARLY_NEG_TLV_FLAG          0x01
> +#define EARLY_NEG_FLAG_RESEND_WKC   0x01
>  #endif /* ifndef SSL_PKT_H */
> +

new blank line at EOF.

> diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
> index c4e23521d..184b88383 100644
> --- a/tests/unit_tests/openvpn/test_pkt.c
> +++ b/tests/unit_tests/openvpn/test_pkt.c
> @@ -531,7 +531,7 @@ test_generate_reset_packet_plain(void **ut_state)
>  
>      uint8_t header = 0 | (P_CONTROL_HARD_RESET_CLIENT_V2 << P_OPCODE_SHIFT);
>  
> -    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header);
> +    struct buffer buf = tls_reset_standalone(&tas, &client_id, &server_id, header, 0, 0);

Nitpick: the second 0 should be "false" instead. Same for all further calls in this file.

Regards,
--
Frank Lichtenheld

