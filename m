From: Antonio Quartulli <a@...2181...>
References: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
 <1510511581-12120-1-git-send-email-arne@...1227...>
Message-ID: <2202ec29-6107-e34f-4317-ace40e4ccbac@...2181...>
Date: Wed, 24 Jan 2018 13:31:41 +0800
MIME-Version: 1.0
In-Reply-To: <1510511581-12120-1-git-send-email-arne@...1227...>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="nUFZ1lgRSNyZVb1YJGJIOFgjjFpuenlqD"
Subject: Re: [Openvpn-devel] [PATCH v3] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--nUFZ1lgRSNyZVb1YJGJIOFgjjFpuenlqD
Content-Type: multipart/mixed; boundary="6zk64DSp77tx5dfonlsTE6iMt0fPlq8D6";
 protected-headers="v1"
From: Antonio Quartulli <a@...2181...>
To: Arne Schwabe <arne@...1227...>, openvpn-devel@lists.sourceforge.net
Message-ID: <2202ec29-6107-e34f-4317-ace40e4ccbac@...2181...>
Subject: Re: [Openvpn-devel] [PATCH v3] Implement block-ipv6
References: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
 <1510511581-12120-1-git-send-email-arne@...1227...>
In-Reply-To: <1510511581-12120-1-git-send-email-arne@...1227...>

--6zk64DSp77tx5dfonlsTE6iMt0fPlq8D6
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

Hi,

see comments inline

On 13/11/17 02:33, Arne Schwabe wrote:
> This can be used to redirect all IPv6 traffic to the tun interface,
> effectively black holing the IPv6 traffic. Without ICMPv6 error
> messages this will result in timeouts when the server does not send
> error codes.  block-ipv6 allows client side only blocking on all
> platforms that OpenVPN supports IPv6. On Android it is only way to do
> sensible IPv6 blocking on Android < 5.0 and broken devices (Samsung).
>=20
> PATCH V3:
> - Fix style iusses reported by Antonio and accidentily commited parts
> - merge udp_checksum and ipv6_checkusm into common ip_checksum method
> - Use fake ff80::7 address when no other address is configured.
> - Make block-ipv6 also work for server  by replying block-ipv6 to all
>   ipv6 traffic send to the server
>=20
> Note for the server the process_ip happens before the ipv6 route
> lookup so every ipv6 packet, regardless of its source address is
> replyied to with a no route to host packet.
>=20
> ---
>  doc/openvpn.8         |  34 +++++++++++++
>  src/openvpn/dhcp.c    |  49 ++-----------------
>  src/openvpn/forward.c | 132 ++++++++++++++++++++++++++++++++++++++++++++=
++++--
>  src/openvpn/forward.h |   4 +-
>  src/openvpn/multi.c   |   2 +-
>  src/openvpn/options.c |  11 +++++
>  src/openvpn/options.h |   1 +
>  src/openvpn/proto.c   |  45 +++++++++++++++++
>  src/openvpn/proto.h   |  52 ++++++++++++++++++++
>  src/openvpn/socket.h  |  19 --------
>  10 files changed, 278 insertions(+), 71 deletions(-)
>=20
> diff --git a/doc/openvpn.8 b/doc/openvpn.8
> index a4189ac2..9f5ae781 100644
> --- a/doc/openvpn.8
> +++ b/doc/openvpn.8
> @@ -1232,6 +1232,40 @@ Like \-\-redirect\-gateway, but omit actually chan=
ging the default
>  gateway.  Useful when pushing private subnets.
>  .\"*********************************************************
>  .TP
> +.B \-\-block\-ipv6
> +On the client, instead of sending IPv6 packets over the VPN tunnel, all =
IPv6 packets are answered with
> +an ICMPv6 no route host message. On the server, all IPv6 packets from cl=
ients are answered with an ICMPv6
> +no route to host message. This options is intended for
> +cases when IPv6 should be blocked and other options are not available.

The lines above are quite long compared to the rest of the manual. I'd
suggest to shorten them.

> +\.B \-\-block\-ipv6
> +will use the remote IPv6 as source address of the ICMPv6 packets if set,
> +otherwise will use fe80::7 as source address.
> +
> +For this option to make sense you actually have to route traffic to the =
tun interface.
> +Following config block would send all IPv6 traffic to OpenVPN and answer=
 all
> +requests with no route to host, effectively blocking IPv6.
> +
> +# client config
> +.br
> +.B \-\-ifconfig-ipv6
> +fd15:53b6:dead::2/64  fd15:53b6:dead::1
> +.br
> +.B \-\-redirect\-gateway
> +ipv6
> +.br
> +.B \-\-block\-ipv6
> +
> +# Server config, push a "valid" ipv6 config to the client and block on t=
he server
> +.br
> +.B \-\-push
> +"ifconfig-ipv6 fd15:53b6:dead::2/64  fd15:53b6:dead::1"
> +.br
> +.B \-\-push
> +"redirect\-gateway ipv6"
> +.br
> +.B \-\-block\-ipv6
> +.\"*********************************************************
> +.TP
>  .B \-\-tun\-mtu n
>  Take the TUN device MTU to be
>  .B n
> diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
> index a2a54540..cec38cd6 100644
> --- a/src/openvpn/dhcp.c
> +++ b/src/openvpn/dhcp.c
> @@ -147,49 +147,6 @@ do_extract(struct dhcp *dhcp, int optlen)
>      return ret;
>  }
>=20=20
> -static uint16_t
> -udp_checksum(const uint8_t *buf,
> -             const int len_udp,
> -             const uint8_t *src_addr,
> -             const uint8_t *dest_addr)
> -{
> -    uint16_t word16;
> -    uint32_t sum =3D 0;
> -    int i;
> -
> -    /* make 16 bit words out of every two adjacent 8 bit words and  */
> -    /* calculate the sum of all 16 bit words */
> -    for (i =3D 0; i < len_udp; i +=3D 2)
> -    {
> -        word16 =3D ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_udp) ? (buf[=
i+1] & 0xFF) : 0);
> -        sum +=3D word16;
> -    }
> -
> -    /* add the UDP pseudo header which contains the IP source and destin=
ation addresses */
> -    for (i =3D 0; i < 4; i +=3D 2)
> -    {
> -        word16 =3D ((src_addr[i] << 8) & 0xFF00) + (src_addr[i+1] & 0xFF=
);
> -        sum +=3D word16;
> -    }
> -    for (i =3D 0; i < 4; i +=3D 2)
> -    {
> -        word16 =3D ((dest_addr[i] << 8) & 0xFF00) + (dest_addr[i+1] & 0x=
FF);
> -        sum +=3D word16;
> -    }
> -
> -    /* the protocol number and the length of the UDP packet */
> -    sum +=3D (uint16_t) OPENVPN_IPPROTO_UDP + (uint16_t) len_udp;
> -
> -    /* keep only the last 16 bits of the 32 bit calculated sum and add t=
he carries */
> -    while (sum >> 16)
> -    {
> -        sum =3D (sum & 0xFFFF) + (sum >> 16);
> -    }
> -
> -    /* Take the one's complement of sum */
> -    return ((uint16_t) ~sum);
> -}
> -
>  in_addr_t
>  dhcp_extract_router_msg(struct buffer *ipbuf)
>  {
> @@ -210,10 +167,10 @@ dhcp_extract_router_msg(struct buffer *ipbuf)
>=20=20
>              /* recompute the UDP checksum */
>              df->udp.check =3D 0;
> -            df->udp.check =3D htons(udp_checksum((uint8_t *) &df->udp,
> +            df->udp.check =3D htons(ip_checksum(AF_INET, (uint8_t *) &df=
->udp,

no space between the cast and the following variable.

>                                                 sizeof(struct openvpn_udp=
hdr) + sizeof(struct dhcp) + optlen,
> -                                               (uint8_t *)&df->ip.saddr,
> -                                               (uint8_t *)&df->ip.daddr)=
);
> +                                               (uint8_t *)&df->ip.saddr,=
 (uint8_t *)&df->ip.daddr,

lines above are longer than 80 chars and they should be aligned to the
first character after the opening parenthesis.

> +                                               OPENVPN_IPPROTO_UDP));
>=20=20
>              /* only return the extracted Router address if DHCPACK */
>              if (message_type =3D=3D DHCPACK)
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 1b7455bb..36e0afe2 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -1198,7 +1198,7 @@ process_incoming_tun(struct context *c)
>           * The --passtos and --mssfix options require
>           * us to examine the IP header (IPv4 or IPv6).
>           */
> -        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, =
&c->c2.buf);
> +        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT|P=
IPV6_IMCP_NOHOST_CLIENT, &c->c2.buf);

this line is now longer than 80 chars. Please break it (even by using a
temporary variable if needed - the compiler will optimize it anyway.

>=20=20
>  #ifdef PACKET_TRUNCATION_CHECK
>          /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
> @@ -1209,6 +1209,9 @@ process_incoming_tun(struct context *c)
>                                  &c->c2.n_trunc_pre_encrypt);
>  #endif
>=20=20
> +    }
> +    if (c->c2.buf.len > 0)
> +    {

is this related to the ipv6 change? If so, how?


>          encrypt_sign(c, true);
>      }
>      else
> @@ -1219,6 +1222,117 @@ process_incoming_tun(struct context *c)
>      gc_free(&gc);
>  }
>=20=20
> +/**
> + * Forges a IPv6 ICMP with a no route to host error code from the IPv6 p=
acket in buf and sends it back via
> + * the tun device
> + */
> +void
> +ipv6_send_icmp_unreachable(struct context * c, struct buffer *buf, bool =
client)

no space after '*'

my understanding was that this patch was only for clients to block ipv6
packet *before* they get out. But now that I am reading the code I see
that this function can be invoked in a client as well as in a server
context.

How about clarifying that in the commit, and maybe also in the comment
above the function?
Bonus: you could use the kerneldoc comment style (here or in the .h file)


> +{
> +#define ICMPV6LEN  1280

isn't this available in any header? If not, I'd put MAX somewhere, to
let people immediately understand what it is used for.

> +    struct openvpn_icmp6hdr icmp6out;
> +    CLEAR(icmp6out);
> +
> +    /*
> +     * Get a buffer to the ip packet, is_ipv6 automatically forwards
> +     * the buffer to the ip packet
> +     */
> +    struct buffer inputipbuf =3D *buf;
> +
> +    is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &inputipbuf);
> +
> +    if (BLEN(&inputipbuf) < (int) sizeof(struct openvpn_ipv6hdr))

no space between cast and following expression.

> +    {
> +        return;
> +    }
> +
> +    const struct openvpn_ipv6hdr* pip6 =3D (struct openvpn_ipv6hdr *) BP=
TR(&inputipbuf);

no space between cast and following expression.

> +
> +    struct openvpn_ipv6hdr pip6out;

I know that we can declare variables basically everywhere, but don't you
think this can quickly get out of control? Personally I'd just declare
all of them at the top.

But I am not sure what the others think about it.

> +
> +    /* Copy version, traffic class, flow label from input packet */
> +    pip6out =3D *pip6;
> +
> +    pip6out.version_prio =3D pip6->version_prio;
> +    pip6out.daddr =3D pip6->saddr;
> +
> +    /* Use the Ipv6 remote address if we have one, otherwise use a fake =
one */

niptick: keep the writing consistent: Ipv6 -> IPv6

> +    if (c->options.ifconfig_ipv6_remote)
> +        inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote, &pip6out.sa=
ddr);
> +    else
> +        inet_pton(AF_INET6, "fe80::7", &pip6out.saddr);

I remember we discussed this, but why not always using "fe80::7"?
Maybe a comment explaining this would be helpful to avoid forgetting (I
already did ..)?

> +
> +    pip6out.nexthdr =3D OPENVPN_IPPROTO_ICMPV6;
> +
> +    /*
> +     * The ICMPv6 unreachable code worked best in my tests with Windows,=
 Linux and Android (arne)
> +     * Windows did not like the adminitively prohibited return code (no =
fast fail)

adminitively -> administratively ?

> +     */
> +    icmp6out.icmp6_type =3D OPENVPN_ICMP6_DESTINATION_UNREACHABLE;
> +    icmp6out.icmp6_code =3D OPENVPN_ICMP6_DU_NOROUTE;
> +
> +    int icmpheader_len =3D sizeof(struct openvpn_ipv6hdr) + sizeof(struc=
t openvpn_icmp6hdr);
> +    int ethheader_len =3D sizeof(struct openvpn_ethhdr);
> +    int totalheader_len =3D icmpheader_len;
> +
> +    if (TUNNEL_TYPE(c->c1.tuntap) =3D=3D DEV_TYPE_TAP)
> +        totalheader_len +=3D ethheader_len;

why using ethheader_len ? it's used just in this line (sorry for this
little complaints, but it's just an attempt t reduce the complexity of
this long function)

> +
> +    /*
> +     * Calculate size for payload, defined in the standard that the resu=
lting frame
> +     * should <=3D 1280 and have as much as possible of the original pac=
ket

missing "be".

> +     */
> +    int payload_len =3D min_inputipbufint(min_int(ICMPV6LEN, TUN_MTU_SIZ=
E(&c->c2.frame) - icmpheader_len), buf_len(&inputipbuf));

this line is longer than 80 chars. You can easily split it in two parts
(might also be easier to brain-parse).

and why not using BLEN() like you have done in other spots?

> +
> +    pip6out.payload_len =3D htons(sizeof(struct openvpn_icmp6hdr) + payl=
oad_len);
> +
> +    /* Construct the packet as outgoing packet back to the client */
> +    struct buffer * outbuf;
> +    if (client) {
> +        c->c2.to_tun =3D c->c2.buffers->aux_buf;
> +        outbuf =3D &(c->c2.to_tun);
> +    } else {
> +        c->c2.to_link =3D c->c2.buffers->aux_buf;
> +        outbuf =3D &(c->c2.to_link);
> +    }
> +    ASSERT(buf_init(outbuf, totalheader_len));
> +
> +    /* Fill the end of the buffer with original packet */
> +    ASSERT(buf_safe(outbuf, payload_len));
> +    ASSERT(buf_copy_n(outbuf, &inputipbuf, payload_len));
> +
> +    /* ICMP Header, copy into buffer to allow checksum calculation */
> +    ASSERT(buf_write_prepend(outbuf, &icmp6out, sizeof(struct openvpn_ic=
mp6hdr)));
> +
> +    /* Calculate checksum over the packet and write to header */
> +    ((struct openvpn_icmp6hdr*) BPTR(outbuf))->icmp6_cksum =3D
> +            htons (ip_checksum(AF_INET6, BPTR(outbuf), BLEN(outbuf), (co=
nst uint8_t*) &pip6out.saddr,
> +                               (uint8_t*) &pip6out.daddr, OPENVPN_IPPROT=
O_ICMPV6));

no space after cast or function call.

> +
> +    /* IPv6 Header */
> +    ASSERT(buf_write_prepend(outbuf, &pip6out, sizeof(struct openvpn_ipv=
6hdr)));
> +
> +    /*
> +     * Working IPv6 block for TAP will also need the client to respond t=
o IPv6 nd with
> +     * its own (fake) adress
> +     */

maybe I am missing something, but in the comment above you talk about
answering to ND, but below you are just filling the Ethernet header. How
are the two related?

> +    if (TUNNEL_TYPE(c->c1.tuntap) =3D=3D DEV_TYPE_TAP)
> +    {
> +        if (BLEN(buf) < (int) sizeof (struct openvpn_ethhdr))

spaces..

> +            return;
> +
> +        const struct openvpn_ethhdr* orig_ethhdr =3D (struct openvpn_eth=
hdr *) BPTR(buf);
> +
> +        /* Copy frametype and reverse source/destination for the respons=
e */
> +        struct openvpn_ethhdr ethhdr;
> +        memcpy(ethhdr.source, orig_ethhdr->dest, OPENVPN_ETH_ALEN);
> +        memcpy(ethhdr.dest, orig_ethhdr->source, OPENVPN_ETH_ALEN);
> +        ethhdr.proto =3D htons(OPENVPN_ETH_P_IPV6);
> +        ASSERT(buf_write_prepend(outbuf, &ethhdr, sizeof(struct openvpn_=
ethhdr)));
> +    }
> +}

Overall I was thinking: instead of creating many little objects (one per
header) here and there and then copying them one by one in the allocated
buffer, why not allocating the buffer first and writing directly into
it? I believe that this is normal practice and might make the code a bit
slimmer too. What do you think?

This is just a suggestion - I haven't tried to change the code myself.

> +
> +

accidental double empty line?

>  void
>  process_ip_header(struct context *c, unsigned int flags, struct buffer *=
buf)
>  {
> @@ -1240,7 +1354,10 @@ process_ip_header(struct context *c, unsigned int =
flags, struct buffer *buf)
>      {
>          flags &=3D ~PIPV4_EXTRACT_DHCP_ROUTER;
>      }
> -

if conditions are not related it is ok to "unstick" them by keeping an
empty line between them, it makes the code easier to read imho.

> +    if (!c->options.block_ipv6)
> +    {
> +        flags &=3D ~(PIPV6_IMCP_NOHOST_CLIENT|PIPV6_IMCP_NOHOST_SERVER);
> +    }
>      if (buf->len > 0)
>      {
>          /*
> @@ -1275,7 +1392,7 @@ process_ip_header(struct contexICMPV6LENt *c, unsig=
ned int flags, struct buffer *buf)
>                  /* possibly do NAT on packet */
>                  if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
>                  {
> -                    const int direction =3D (flags & PIPV4_OUTGOING) ? C=
N_INCOMING : CN_OUTGOING;
> +                    const int direction =3D (flags & PIP_OUTGOING) ? CN_=
INCOMING : CN_OUTGOING;

how is this change related to this patch?

>                      client_nat_transform(c->options.client_nat, &ipbuf, =
direction);
>                  }
>                  /* possibly extract a DHCP router message */
> @@ -1295,6 +1412,13 @@ process_ip_header(struct context *c, unsigned int =
flags, struct buffer *buf)
>                  {
>                      mss_fixup_ipv6(&ipbuf, MTU_TO_MSS(TUN_MTU_SIZE_DYNAM=
IC(&c->c2.frame)));
>                  }IMCP
> +                if (!(flags & PIP_OUTGOING) && (flags & (PIPV6_IMCP_NOHO=
ST_CLIENT|PIPV6_IMCP_NOHOST_SERVER)))


> +                {
> +                    ipv6_send_icmp_unreachable(c, buf, (bool)(flags & PI=
PV6_IMCP_NOHOST_CLIENT));
> +                    /* Drop the IPv6 packet */
> +                    buf->len=3D0;
> +                }
> +
>              }
>          }
>      }
> @@ -1478,7 +1602,7 @@ process_outgoing_tun(struct context *c)
>       * The --mssfix option requires
>       * us to examine the IP header (IPv4 or IPv6).
>       */
> -    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIE=
NT_NAT|PIPV4_OUTGOING, &c->c2.to_tun);
> +    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIE=
NT_NAT|PIP_OUTGOING, &c->c2.to_tun);
>=20=20
>      if (c->c2.to_tun.len <=3D MAX_RW_SIZE_TUN(&c->c2.frame))
>      {
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
> index 9fde5a30..0fa4a31e 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -251,9 +251,11 @@ bool send_control_channel_string(struct context *c, =
const char *str, int msgleve
>=20=20
>  #define PIPV4_PASSTOS         (1<<0)
>  #define PIP_MSSFIX            (1<<1)         /* v4 and v6 */
> -#define PIPV4_OUTGOING        (1<<2)
> +#define PIP_OUTGOING          (1<<2)
>  #define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
>  #define PIPV4_CLIENT_NAT      (1<<4)
> +#define PIPV6_IMCP_NOHOST_CLIENT (1<<5)
> +#define PIPV6_IMCP_NOHOST_SERVER (1<<6)
>=20=20
>  void process_ip_header(struct context *c, unsigned int flags, struct buf=
fer *buf);
>=20=20
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index 82a0b9d9..eeb7644a 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -2837,7 +2837,7 @@ multi_get_queue(struct mbuf_set *ms)
>=20=20
>      if (mbuf_extract_item(ms, &item)) /* cleartext IP packet */
>      {
> -        unsigned int pip_flags =3D PIPV4_PASSTOS;
> +        unsigned int pip_flags =3D PIPV4_PASSTOS|PIPV6_IMCP_NOHOST_SERVE=
R;
>=20=20
>          set_prefix(item.instance);
>          item.instance->context.c2.buf =3D item.buffer->buf;
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index 641a26e2..d1b4f48c 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -226,6 +226,8 @@ static const char usage_message[] =3D
>      "                  Add 'bypass-dns' flag to similarly bypass tunnel =
for DNS.\n"
>      "--redirect-private [flags]: Like --redirect-gateway, but omit actua=
lly changing\n"
>      "                  the default gateway.  Useful when pushing private=
 subnets.\n"
> +    "--block-ipv6     : (client only) Instead sending IPv6 to the server=
 generate\n"
> +    "                   ICMPv6 host unreachable messages.\n"
>      "--client-nat snat|dnat network netmask alias : on client add 1-to-1=
 NAT rule.\n"
>  #ifdef ENABLE_PUSH_PEER_INFO
>      "--push-peer-info : (client only) push client info to server.\n"
> @@ -2084,6 +2086,10 @@ options_postprocess_verify_ce(const struct options=
 *options, const struct connec
>          msg(M_USAGE, "--lladdr can only be used in --dev tap mode");
>      }
>=20=20
> +    if (options->block_ipv6 && dev !=3D DEV_TYPE_TUN)
> +    {
> +        msg(M_USAGE, "--block-ipv6 can be only used in --dev tun mode");
> +    }
>      /*
>       * Sanity check on MTU parameters
>       */
> @@ -6360,6 +6366,11 @@ add_option(struct options *options,
>  #endif
>          options->routes->flags |=3D RG_ENABLE;
>      }
> +    else if (streq(p[0], "block-ipv6") && !p[1])
> +    {
> +        VERIFY_PERMISSION(OPT_P_ROUTE);
> +        options->block_ipv6 =3D true;
> +    }
>      else if (streq(p[0], "remote-random-hostname") && !p[1])
>      {
>          VERIFY_PERMISSION(OPT_P_GENERAL);
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 496c1143..38e9e431 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -340,6 +340,7 @@ struct options
>      bool route_delay_defined;
>      struct route_option_list *routes;
>      struct route_ipv6_option_list *routes_ipv6;                 /* IPv6 =
*/
> +    bool block_ipv6;
>      bool route_nopull;
>      bool route_gateway_via_dhcp;
>      bool allow_pull_fqdn; /* as a client, allow server to push a FQDN fo=
r certain parameters */
> diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
> index 2cbea3ab..4cafdd31 100644
> --- a/src/openvpn/proto.c
> +++ b/src/openvpn/proto.c
> @@ -98,6 +98,51 @@ is_ipv6(int tunnel_type, struct buffer *buf)
>      return is_ipv_X( tunnel_type, buf, 6 );
>  }
>=20=20
> +
> +uint16_t
> +ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_=
payload, const uint8_t *src_addr,
> +            const uint8_t *dest_addr, const int proto)
> +{
> +    uint32_t sum =3D 0;
> +    int addr_len =3D (af =3D=3D AF_INET) ? 4 : 16;
> +
> +    /*
> +     * make 16 bit words out of every two adjacent 8 bit words and  */
> +    /* calculate the sum of all 16 bit words
> +     */
> +    for (int i =3D 0; i < len_payload; i +=3D 2)
> +    {
> +        sum +=3D  (uint16_t) (((payload[i] << 8) & 0xFF00) + ((i + 1 < l=
en_payload) ? (payload[i + 1] & 0xFF) : 0));
> +
> +    }
> +
> +    /* add the pseudo header which contains the IP source and destinatio=
n addresses */
> +    for (int i =3D 0; i < addr_len; i +=3D 2)
> +    {
> +        sum +=3D (uint16_t) ((src_addr[i] << 8) & 0xFF00) + (src_addr[i =
+ 1] & 0xFF);
> +
> +    }
> +    for (int i =3D 0; i < addr_len; i +=3D 2)
> +    {
> +        sum +=3D (uint16_t) ((dest_addr[i] << 8) & 0xFF00) + (dest_addr[=
i + 1] & 0xFF);
> +    }
> +
> +    /* the length of the payload */
> +    sum +=3D (uint16_t) len_payload;
> +
> +    /* The next header or proto field*/
> +    sum +=3D (uint16_t) proto;
> +
> +    /* keep only the last 16 bits of the 32 bit calculated sum and add t=
he carries */
> +    while (sum >> 16)
> +    {
> +        sum =3D (sum & 0xFFFF) + (sum >> 16);
> +    }
> +
> +    /* Take the one's complement of sum */
> +    return ((uint16_t) ~sum);
> +}
> +
>  #ifdef PACKET_TRUNCATION_CHECK
>=20=20
>  void
> diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
> index 57f25c90..afbd226b 100644
> --- a/src/openvpn/proto.h
> +++ b/src/openvpn/proto.h
> @@ -98,6 +98,7 @@ struct openvpn_iphdr {
>  #define OPENVPN_IPPROTO_IGMP 2  /* IGMP protocol */
>  #define OPENVPN_IPPROTO_TCP  6  /* TCP protocol */
>  #define OPENVPN_IPPROTO_UDP 17  /* UDP protocol */
> +#define OPENVPN_IPPROTO_ICMPV6 58 /* ICMPV6 protocol */

I believe the above defines were trying to have the value nicely
aligned. I think you should rathe realign all the values.

>      uint8_t protocol;
>=20=20
>      uint16_t check;
> @@ -120,6 +121,24 @@ struct openvpn_ipv6hdr {
>      struct  in6_addr daddr;
>  };
>=20=20
> +/*
> + * ICMPv6 header
> + */
> +struct openvpn_icmp6hdr {
> +# define OPENVPN_ICMP6_DESTINATION_UNREACHABLE 1
> +# define OPENVPN_ND_ROUTER_SOLICIT	133
> +# define OPENVPN_ND_ROUTER_ADVERT	134
> +# define OPENVPN_ND_NEIGHBOR_SOLICIT	135
> +# define OPENVPN_ND_NEIGHBOR_ADVERT	136
> +# define OPENVPN_ND_INVERSE_SOLICIT	141
> +# define OPENVPN_ND_INVERSE_ADVERT	142
> +	uint8_t		icmp6_type;
> +# define OPENVPN_ICMP6_DU_NOROUTE 0
> +# define OPENVPN_ICMP6_DU_COMMUNICATION_PROHIBTED 1
> +	uint8_t		icmp6_code;
> +	uint16_t	icmp6_cksum;
> +	uint8_t		icmp6_dataun[4];
> +};
>=20=20
>  /*
>   * UDP header
> @@ -265,6 +284,39 @@ bool is_ipv4(int tunnel_type, struct buffer *buf);
>=20=20
>  bool is_ipv6(int tunnel_type, struct buffer *buf);
>=20=20
> +static inline int
> +af_addr_size(sa_family_t af)
> +{
> +    switch (af)
> +    {
> +        case AF_INET: return sizeof(struct sockaddr_in);
> +
> +        case AF_INET6: return sizeof(struct sockaddr_in6);
> +
> +        default:
> +#if 0
> +            /* could be called from socket_do_accept() with empty addr */
> +            msg(M_ERR, "Bad address family: %d\n", af);
> +            ASSERT(0);
> +#endif

> +            return 0;
> +    }
> +}

the function above really needs some cleanup :( in a later patch

> +
> +/**
> + *  Calculates an IP or IPv6 checksum with a pseudo header as required b=
y TCP, UDP and ICMPv6
> + * @param af Address family for which the checksum is calculated AF_INET=
 or AF_INET6
> + * @param payload the TCP, ICMPv6 or UDP packet
> + * @param len_payload length of payload
> + * @param src_addr Source address of the packet
> + * @param dest_addr Destination address of the packet
> + * @param proto next header or IP protocol of the packet
> + * @return calculated checksum in host order

The doxygen style doc above does not look like the rest. Please check
ssl_backend.h for a good example.

> + */
> +uint16_t
> +ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_=
payload, const uint8_t *src_addr,
> +            const uint8_t *dest_addr,  const int proto);
> +

And don't forget the max line length

>  #ifdef PACKET_TRUNCATION_CHECK
>  void ipv4_packet_size_verify(const uint8_t *data,
>                               const int size,
> diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
> index 2d7f2187..9ccc9466 100644
> --- a/src/openvpn/socket.h
> +++ b/src/openvpn/socket.h
> @@ -848,25 +848,6 @@ addr_inet4or6(struct sockaddr *addr)
>=20=20
>  int addr_guess_family(sa_family_t af,const char *name);
>=20=20
> -static inline int
> -af_addr_size(sa_family_t af)
> -{
> -    switch (af)
> -    {
> -        case AF_INET: return sizeof(struct sockaddr_in);
> -
> -        case AF_INET6: return sizeof(struct sockaddr_in6);
> -
> -        default:
> -#if 0
> -            /* could be called from socket_do_accept() with empty addr */
> -            msg(M_ERR, "Bad address family: %d\n", af);
> -            ASSERT(0);
> -#endif
> -            return 0;
> -    }
> -}
> -
>  static inline bool
>  link_socket_actual_match(const struct link_socket_actual *a1, const stru=
ct link_socket_actual *a2)
>  {
>=20


in case of doubt about any of my points, we can also discuss on IRC.


Cheers,


--=20
Antonio Quartulli




--6zk64DSp77tx5dfonlsTE6iMt0fPlq8D6--

--nUFZ1lgRSNyZVb1YJGJIOFgjjFpuenlqD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEERdCuyFSHc3WdqS4EB6U8WA7yzXQFAlpoGj0ACgkQB6U8WA7y
zXSI5g/8D41YVtcqQGwRXp0GGLVEjx0mFWP0hmUzVewYgCJAGoUPJragfHWEdlgX
OtxWdPBE7n7tXuw8SS0mS+ZRdge1FIAQnesSKKtNGaH7Hx7ebR/i1npAfUaEv3w/
N2+iqMgkeA9krJUqABIa0rUiW/Bie81c+fqKPkeVXghEE9Tkus6MUMRaD1aNjO9f
xUpdnZNexBll2GXM0EKwhlDf1hNm2gMqvtE1/Qys/8slHVBd8a4LcPeZjlgqwTHG
ZClhNQMsCwErauTVvnTWxgViZW8nAl8l//L79tPs4zr3tYOGFZhhIzmRJVK6herv
r6aUerr5W8PSsuB7LkJpwX0IP/subGeE90szRjHfb/FSJGXqcPHzQATLVkTl+2IE
h1eohs/nlNiZ42vDLhpElfdZ3D/vRq81IijSicG9Yos5WBbN0Gf62fwldVjbA9AM
yYQg7P3XrXO9Gri1g04ocewygQENyy+5fL75vUrkWOVbpJ0PsZOdYewu6VweM6TT
Q6r8ZFBZaURKZPq07S1wJu8w8wmQypwx6IRVruHxM1L4ME0bnBLIQHOUnBXG5ywk
quSYY0IPoAJsGhASl7C/fIj9Y92wFPN+xvJvr7ZRATA0fw3/siA+iYbq/ek3o1Ez
rg9RkcYGj5dBnpXEBsca+0Z84ipSvBGOGfhhx56u61bnu8kzIZI=
=bou1
-----END PGP SIGNATURE-----

--nUFZ1lgRSNyZVb1YJGJIOFgjjFpuenlqD--

