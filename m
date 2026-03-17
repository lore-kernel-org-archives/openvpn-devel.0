Message-ID: <6ca3e34e-26cd-448d-875d-43b7f7d13d62@...1227...>
Date: Tue, 17 Mar 2026 23:49:14 +0100
MIME-Version: 1.0
References: <ef1b6b7c-eae5-4554-97ad-fdf4e586de21@...3013...>
From: Arne Schwabe <arne@...1227...>
In-Reply-To: <ef1b6b7c-eae5-4554-97ad-fdf4e586de21@...3013...>
Subject: Re: [Openvpn-devel] [PATCH] Add --sni-passthrough-hostname and
 --sni-passthrough-server, options
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@...3013..., openvpn-devel@lists.sourceforge.net


Am 17.03.2026 um 10:22 schrieb openvpn-devel@...3013...:
> Hi everyone,
>
> This is my first contribution to OpenVPN. I'd appreciate any feedback.
>
>
> This patch adds the ability to operate openvpn behind HTTP SNI proxy 
> like Traefik.
> It is meant to operate in the reverse way of the already implemented 
> port-sharing option.
This quite simple way here might make it quite hard in the future to 
implement a proper TLS TCP connection. I would suggest to add to the 
ALPN extension to your proposal and have it report something like 
fakesni or something like that and have the server side a minimal enough 
parser to pick that up.

> Allow OpenVPN TCP connections to be routed through SNI-based reverse
> proxies (e.g. Traefik with tls passthrough) by prepending a minimal
> fake TLS ClientHello containing an SNI extension before the OpenVPN
> protocol stream.
>
> Client side (--sni-passthrough-hostname <host>): builds and sends a
> single TLS record containing a ClientHello with the specified SNI
> hostname. The proxy reads the SNI and forwards the connection to the
> correct backend. The OpenVPN protocol follows immediately after.
This is a quite hacky method that probably a lot of IDS/IPS system will 
not tolerate since it looks like a completely broken TLS connection.
>
> Server side (--sni-passthrough-server): auto-detects the routing
> header by peeking at the first byte (0x16 = TLS record). 
That is a very weak detection. Also 0x16 is key-id 0 with opcode 22, 
which is not unlikely to become a valid way to start an openvpn 
connection sometime in the future. So your patch would recude our op 
code space. This detection needs to be more specific to have a chance of 
being acceptd.
> If present,
> the header is consumed and discarded before normal OpenVPN stream
> parsing begins. Legacy clients without --sni-passthrough-hostname
> are accepted transparently.

I don't think clients that do not support your, in my opinon hacky, way 
of starting an OpenVPN connection should be considered legacy.


>
> The feature is conditionally compiled via --enable-sni-passthrough
> (enabled by default) and guarded by #if SNI_PASSTHROUGH throughout.
We try to avoid adding new compile time option when possible.
>
> +static size_t
> +sni_passthrough_build_client_hello(uint8_t *buf, size_t bufsz, const 
> char *sni)
> +{
> +    size_t sni_len;
> +    size_t sni_body_len;
> +    size_t sni_ext_wire;
> +    size_t sv_ext_wire;
> +    size_t sg_ext_wire;
> +    size_t exts_total;
> +    size_t hello_body;
> +    size_t handshake_len;
> +    size_t record_len;
> +    size_t name_entry;
> +    uint8_t *p;
> +    int i;
> +

This coding style and formatting is completely different than what 
OpenVPN normal coding style does. I am also pretty this does not survive 
the formatting test of the github actions that you can yourself.


> + if (!sni || !*sni)
> +    {
> +        return 0;
> +    }
> +    sni_len = strlen(sni);
> +
> +    /* Extension sizes (all big-endian, calculated bottom-up): */
> +
> +    /* SNI extension body: list_len(2) + name_type(1) + name_len(2) + 
> name */
> +    sni_body_len   = 2 + 1 + 2 + sni_len;
> +    /* SNI extension wire: type(2) + ext_data_len(2) + body */
> +    sni_ext_wire   = 4 + sni_body_len;
> +
> +    /* supported_versions: type(2)+len(2)+list_len(1)+v1.3(2)+v1.2(2) 
> = 9 */
> +    sv_ext_wire    = 9;
> +
> +    /* supported_groups: type(2)+len(2)+groups_len(2)+x25519(2) = 8 */
> +    sg_ext_wire    = 8;
> +
> +    exts_total     = sni_ext_wire + sv_ext_wire + sg_ext_wire;
> +
> +    /* ClientHello body: version(2)+random(32)+sess_id_len(1)+
> +     * cipher_suites_len(2)+2 ciphers(4)+comp_len(1)+null_comp(1)+
> +     * exts_len(2)+extensions */
> +    hello_body     = 2 + 32 + 1 + 2 + 4 + 1 + 1 + 2 + exts_total;
> +
> +    /* Handshake message: type(1)+length(3)+body */
> +    handshake_len  = 1 + 3 + hello_body;
> +
> +    /* Record envelope: 
> content_type(1)+version(2)+length(2)+handshake */
> +    record_len     = 5 + handshake_len;
> +
> +    if (record_len > bufsz)
> +    {
> +        return 0;
> +    }
> +
> +    p = buf;
> +
> +    /* --- Record envelope header --- */
> +    *p++ = 0x16;                            /* Content-Type: 
> Handshake   */
> +    *p++ = 0x03; *p++ = 0x01;              /* Legacy record version  
>     */
> +    *p++ = (handshake_len >> 8) & 0xff;
> +    *p++ =  handshake_len       & 0xff;
> +
> +    /* --- Handshake header --- */
> +    *p++ = 0x01;                            /* HandshakeType: 
> ClientHello */
> +    *p++ = (hello_body >> 16) & 0xff;
> +    *p++ = (hello_body >>  8) & 0xff;
> +    *p++ =  hello_body        & 0xff;
> +
> +    /* --- ClientHello body --- */
> +    *p++ = 0x03; *p++ = 0x03;              /* client_version field   
>    */
> +
> +    /* Random: 32 pseudo-random bytes (not cryptographically 
> sensitive) */
> +    for (i = 0; i < 32; i++)
> +    {
> +        *p++ = (uint8_t)(rand() & 0xff);
> +    }
> +
> +    *p++ = 0x00;                            /* session_id: empty      */
> +
> +    /* cipher_suites: two plausible entries (never negotiated) */
> +    *p++ = 0x00; *p++ = 0x04;
> +    *p++ = 0x13; *p++ = 0x01;              /* 0x1301     */
> +    *p++ = 0x13; *p++ = 0x02;              /* 0x1302     */
> +
> +    /* compression_methods: null only */
> +    *p++ = 0x01; *p++ = 0x00;
> +
> +    /* extensions length */
> +    *p++ = (exts_total >> 8) & 0xff;
> +    *p++ =  exts_total       & 0xff;
> +
> +    /* --- SNI extension (type 0x0000) --- */
> +    name_entry = 1 + 2 + sni_len;          /* name_type + name_len + 
> name */
> +    *p++ = 0x00; *p++ = 0x00;              /* extension type: 
> server_name */
> +    *p++ = (sni_body_len >> 8) & 0xff;
> +    *p++ =  sni_body_len       & 0xff;
> +    *p++ = (name_entry   >> 8) & 0xff;       /* server_name_list 
> length     */
> +    *p++ =  name_entry         & 0xff;
> +    *p++ = 0x00;                              /* name_type: 
> host_name        */
> +    *p++ = (sni_len      >> 8) & 0xff;
> +    *p++ =  sni_len            & 0xff;
> +    memcpy(p, sni, sni_len);
> +    p += sni_len;
> +
> +    /* --- supported_versions extension (type 0x002b) --- */
> +    *p++ = 0x00; *p++ = 0x2b;
> +    *p++ = 0x00; *p++ = 0x05;              /* extension data length: 
> 5    */
> +    *p++ = 0x04;                            /* versions list length: 
> 4     */
> +    *p++ = 0x03; *p++ = 0x04;              /* version 0x0304   */
> +    *p++ = 0x03; *p++ = 0x03;              /* version 0x0303   */
> +
> +    /* --- supported_groups extension (type 0x000a) --- */
> +    *p++ = 0x00; *p++ = 0x0a;
> +    *p++ = 0x00; *p++ = 0x04;              /* extension data length: 
> 4    */
> +    *p++ = 0x00; *p++ = 0x02;             /* groups list length: 2   
>    */
> +    *p++ = 0x00; *p++ = 0x1d;             /* x25519       */
> +
> +    return (size_t)(p - buf);
> +}

This whole method needs to be rewritten using OpenVPN coding style. Our 
buf methods are used to avoid this pointer arithmetic thing here. Also 
the coding style is not really great to create a TLV structure. You 
typically would have a method like add_field(type, length, data) instead 
of repeating that over and over again.

Arne

