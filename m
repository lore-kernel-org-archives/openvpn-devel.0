From: Kristian McColm <kristianmccolm@...160...>
Date: Mon, 29 Oct 2018 21:06:13 +0000
Message-ID: <BN6PR04MB0932760BE8E092FA236F57C0DDF30@...2439...>
References: <1d93843c-6fe8-1a60-28fc-c013a57877da@...2181...>
 <20181029172040.17034-1-arne@...1227...>
In-Reply-To: <20181029172040.17034-1-arne@...1227...>
Content-Language: en-US
MIME-Version: 1.0
Subject: Re: [Openvpn-devel] [PATCH v5] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
To: Arne Schwabe <arne@...1227...>, "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

Will this feature break VPNs that use NAT64 to connect to IPv4-only OpenVPN=
 servers?

-----Original Message-----
From: Arne Schwabe [mailto:arne@...1227...]=20
Sent: October 29, 2018 13:21
To: openvpn-devel@lists.sourceforge.net
Subject: [Openvpn-devel] [PATCH v5] Implement block-ipv6

This can be used to redirect all IPv6 traffic to the tun interface, effecti=
vely black holing the IPv6 traffic. Without ICMPv6 error messages this will=
 result in timeouts when the server does not send error codes.  block-ipv6 =
allows client side only blocking on all platforms that OpenVPN supports IPv=
6. On Android it is only way to do sensible IPv6 blocking on Android < 5.0 =
and broken devices (Samsung).

PATCH V4:
- Fix more style issues reported by Antonio
- Clarify parts of the patch in comments and manpage

PATCH V3:
- Fix style iusses reported by Antonio and accidentily commited parts
- merge udp_checksum and ipv6_checkusm into common ip_checksum method
- Use fake ff80::7 address when no other address is configured.
- Make block-ipv6 also work for server  by replying block-ipv6 to all
  ipv6 traffic send to the server

Note for the server the process_ip happens before the ipv6 route lookup so =
every ipv6 packet, regardless of its source address is replyied to with a n=
o route to host packet.
---
 doc/openvpn.8         |  37 ++++++++++
 src/openvpn/dhcp.c    |  51 ++-----------
 src/openvpn/forward.c | 163 ++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/forward.h |  12 ++--
 src/openvpn/multi.c   |   2 +-
 src/openvpn/options.c |   9 +++
 src/openvpn/options.h |   1 +
 src/openvpn/proto.c   |  52 ++++++++++++++
 src/openvpn/proto.h   |  58 ++++++++++++++-
 src/openvpn/socket.h  |  19 -----
 10 files changed, 325 insertions(+), 79 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8 index 29801aa8..f9413a0d 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1243,6 +1243,43 @@ Like \-\-redirect\-gateway, but omit actually changi=
ng the default  gateway.  Useful when pushing private subnets.
 .\"*********************************************************
 .TP
+.B \-\-block\-ipv6
+On the client, instead of sending IPv6 packets over the VPN tunnel, all
+IPv6 packets are answered with an ICMPv6 no route host message. On the=20
+server, all IPv6 packets from clients are answered with an ICMPv6 no=20
+route to host message. This options is intended for cases when IPv6=20
+should be blocked and other options are not available.
+\.B \-\-block\-ipv6
+will use the remote IPv6 as source address of the ICMPv6 packets if=20
+set, otherwise will use fe80::7 as source address.
+
+For this option to make sense you actually have to route traffic to the=20
+tun interface. The following example config block would send all IPv6=20
+traffic to OpenVPN and answer all requests with no route to host,=20
+effectively blocking IPv6.
+
+# client config
+.br
+.B \-\-ifconfig-ipv6
+fd15:53b6:dead::2/64  fd15:53b6:dead::1 .br .B \-\-redirect\-gateway
+ipv6
+.br
+.B \-\-block\-ipv6
+
+# Server config, push a "valid" ipv6 config to the client and block #=20
+on the server .br .B \-\-push
+"ifconfig-ipv6 fd15:53b6:dead::2/64  fd15:53b6:dead::1"
+.br
+.B \-\-push
+"redirect\-gateway ipv6"
+.br
+.B \-\-block\-ipv6
+.\"*********************************************************
+.TP
 .B \-\-tun\-mtu n
 Take the TUN device MTU to be
 .B n
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c index fb28b27d..d9480d=
c1 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -147,49 +147,6 @@ do_extract(struct dhcp *dhcp, int optlen)
     return ret;
 }
=20
-static uint16_t
-udp_checksum(const uint8_t *buf,
-             const int len_udp,
-             const uint8_t *src_addr,
-             const uint8_t *dest_addr)
-{
-    uint16_t word16;
-    uint32_t sum =3D 0;
-    int i;
-
-    /* make 16 bit words out of every two adjacent 8 bit words and  */
-    /* calculate the sum of all 16 bit words */
-    for (i =3D 0; i < len_udp; i +=3D 2)
-    {
-        word16 =3D ((buf[i] << 8) & 0xFF00) + ((i + 1 < len_udp) ? (buf[i+=
1] & 0xFF) : 0);
-        sum +=3D word16;
-    }
-
-    /* add the UDP pseudo header which contains the IP source and destinat=
ion addresses */
-    for (i =3D 0; i < 4; i +=3D 2)
-    {
-        word16 =3D ((src_addr[i] << 8) & 0xFF00) + (src_addr[i+1] & 0xFF);
-        sum +=3D word16;
-    }
-    for (i =3D 0; i < 4; i +=3D 2)
-    {
-        word16 =3D ((dest_addr[i] << 8) & 0xFF00) + (dest_addr[i+1] & 0xFF=
);
-        sum +=3D word16;
-    }
-
-    /* the protocol number and the length of the UDP packet */
-    sum +=3D (uint16_t) OPENVPN_IPPROTO_UDP + (uint16_t) len_udp;
-
-    /* keep only the last 16 bits of the 32 bit calculated sum and add the=
 carries */
-    while (sum >> 16)
-    {
-        sum =3D (sum & 0xFFFF) + (sum >> 16);
-    }
-
-    /* Take the one's complement of sum */
-    return ((uint16_t) ~sum);
-}
-
 in_addr_t
 dhcp_extract_router_msg(struct buffer *ipbuf)  { @@ -210,10 +167,10 @@ dhc=
p_extract_router_msg(struct buffer *ipbuf)
=20
             /* recompute the UDP checksum */
             df->udp.check =3D 0;
-            df->udp.check =3D htons(udp_checksum((uint8_t *) &df->udp,
-                                               sizeof(struct openvpn_udphd=
r) + sizeof(struct dhcp) + optlen,
-                                               (uint8_t *)&df->ip.saddr,
-                                               (uint8_t *)&df->ip.daddr));
+            df->udp.check =3D htons(ip_checksum(AF_INET, (uint8_t *)&df->u=
dp,
+                                  sizeof(struct openvpn_udphdr) + sizeof(s=
truct dhcp) + optlen,
+                                  (uint8_t *)&df->ip.saddr, (uint8_t *)&df=
->ip.daddr,
+                                  OPENVPN_IPPROTO_UDP));
=20
             /* only return the extracted Router address if DHCPACK */
             if (message_type =3D=3D DHCPACK) diff --git a/src/openvpn/forw=
ard.c b/src/openvpn/forward.c index 941ba49f..9c0e98a8 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1420,7 +1420,9 @@ process_incoming_tun(struct context *c)
          * The --passtos and --mssfix options require
          * us to examine the IP header (IPv4 or IPv6).
          */
-        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c=
->c2.buf);
+        unsigned int flags =3D PIPV4_PASSTOS | PIP_MSSFIX | PIPV4_CLIENT_N=
AT
+            | PIPV6_IMCP_NOHOST_CLIENT;
+        process_ip_header(c, flags, &c->c2.buf);
=20
 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */ @@ -1431,6 +1433,9 @=
@ process_incoming_tun(struct context *c)
                                 &c->c2.n_trunc_pre_encrypt);  #endif
=20
+    }
+    if (c->c2.buf.len > 0)
+    {
         encrypt_sign(c, true);
     }
     else
@@ -1441,6 +1446,140 @@ process_incoming_tun(struct context *c)
     gc_free(&gc);
 }
=20
+/**
+ * Forges a IPv6 ICMP packet with a no route to host error code from=20
+the
+ * IPv6 packetin buf and sends it directly back to the client via the=20
+tun device
+ * when used on a client and via the link if used on the server.
+ *
+ * @param buf       - The buf containing the packet for which the icmp6
+ *                    unreachable should be constructed.
+ *
+ * @param client    - determines whether to the send packet back via tun o=
r link
+ */
+void
+ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool=20
+client) { #define MAX_ICMPV6LEN IPV6_MIN_MTU
+    struct openvpn_icmp6hdr icmp6out;
+    CLEAR(icmp6out);
+
+    /*
+     * Get a buffer to the ip packet, is_ipv6 automatically forwards
+     * the buffer to the ip packet
+     */
+    struct buffer inputipbuf =3D *buf;
+
+    is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &inputipbuf);
+
+    if (BLEN(&inputipbuf) < (int)sizeof(struct openvpn_ipv6hdr))
+    {
+        return;
+    }
+
+    const struct openvpn_ipv6hdr* pip6 =3D (struct openvpn_ipv6hdr=20
+ *)BPTR(&inputipbuf);
+
+    /* Copy version, traffic class, flow label from input packet */
+    struct openvpn_ipv6hdr pip6out =3D *pip6;
+
+    pip6out.version_prio =3D pip6->version_prio;
+    pip6out.daddr =3D pip6->saddr;
+
+    /*
+     * Use the IPv6 remote address if we have one, otherwise use a fake one
+     * using the remote address is preferred since it makes debugging and
+     * understanding where the ICMPv6 error originates easier
+     */
+    if (c->options.ifconfig_ipv6_remote)
+    {
+        inet_pton(AF_INET6, c->options.ifconfig_ipv6_remote, &pip6out.sadd=
r);
+    }
+    else
+    {
+        inet_pton(AF_INET6, "fe80::7", &pip6out.saddr);
+    }
+
+    pip6out.nexthdr =3D OPENVPN_IPPROTO_ICMPV6;
+
+    /*
+     * The ICMPv6 unreachable code worked best in my (arne) tests with Win=
dows,
+     * Linux and Android. Windows did not like the administratively prohib=
ited
+     * return code (no fast fail)
+     */
+    icmp6out.icmp6_type =3D OPENVPN_ICMP6_DESTINATION_UNREACHABLE;
+    icmp6out.icmp6_code =3D OPENVPN_ICMP6_DU_NOROUTE;
+
+    int icmpheader_len =3D sizeof(struct openvpn_ipv6hdr)
+                            + sizeof(struct openvpn_icmp6hdr);
+    int totalheader_len =3D icmpheader_len;
+
+    if (TUNNEL_TYPE(c->c1.tuntap) =3D=3D DEV_TYPE_TAP)
+        totalheader_len +=3D sizeof(struct openvpn_ethhdr);
+
+    /*
+     * Calculate size for payload, defined in the standard that the result=
ing
+     * frame should be <=3D 1280 and have as much as possible of the origi=
nal
+     * packet
+     */
+    int max_payload_size =3D min_int(MAX_ICMPV6LEN,
+                              TUN_MTU_SIZE(&c->c2.frame) - icmpheader_len);
+    int payload_len =3D min_int(max_payload_size, BLEN(&inputipbuf));
+
+    pip6out.payload_len =3D htons(sizeof(struct openvpn_icmp6hdr) +=20
+ payload_len);
+
+    /* Construct the packet as outgoing packet back to the client */
+    struct buffer * outbuf;
+    if (client)
+    {
+        c->c2.to_tun =3D c->c2.buffers->aux_buf;
+        outbuf =3D &(c->c2.to_tun);
+    }
+    else
+    {
+        c->c2.to_link =3D c->c2.buffers->aux_buf;
+        outbuf =3D &(c->c2.to_link);
+    }
+    ASSERT(buf_init(outbuf, totalheader_len));
+
+    /* Fill the end of the buffer with original packet */
+    ASSERT(buf_safe(outbuf, payload_len));
+    ASSERT(buf_copy_n(outbuf, &inputipbuf, payload_len));
+
+    /* ICMP Header, copy into buffer to allow checksum calculation */
+    ASSERT(buf_write_prepend(outbuf, &icmp6out, sizeof(struct=20
+ openvpn_icmp6hdr)));
+
+    /* Calculate checksum over the packet and write to header */
+
+    uint16_t new_csum =3D ip_checksum(AF_INET6, BPTR(outbuf), BLEN(outbuf),
+                            (const uint8_t*)&pip6out.saddr,
+                            (uint8_t*)&pip6out.daddr, OPENVPN_IPPROTO_ICMP=
V6);
+    ((struct openvpn_icmp6hdr*) BPTR(outbuf))->icmp6_cksum =3D=20
+ htons(new_csum);
+
+
+    /* IPv6 Header */
+    ASSERT(buf_write_prepend(outbuf, &pip6out, sizeof(struct=20
+ openvpn_ipv6hdr)));
+
+    /*
+     * Tap mode, we also need to create an Ethernet header.
+     */
+    if (TUNNEL_TYPE(c->c1.tuntap) =3D=3D DEV_TYPE_TAP)
+    {
+        if (BLEN(buf) < (int)sizeof(struct openvpn_ethhdr))
+        {
+            return;
+        }
+
+        const struct openvpn_ethhdr* orig_ethhdr =3D (struct=20
+ openvpn_ethhdr *) BPTR(buf);
+
+        /* Copy frametype and reverse source/destination for the response =
*/
+        struct openvpn_ethhdr ethhdr;
+        memcpy(ethhdr.source, orig_ethhdr->dest, OPENVPN_ETH_ALEN);
+        memcpy(ethhdr.dest, orig_ethhdr->source, OPENVPN_ETH_ALEN);
+        ethhdr.proto =3D htons(OPENVPN_ETH_P_IPV6);
+        ASSERT(buf_write_prepend(outbuf, &ethhdr, sizeof(struct openvpn_et=
hhdr)));
+    }
+#undef MAX_ICMPV6LEN
+}
+
 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f)  { @@ -1462,6 +1601,10 @@ process_ip_header(struct context *c, unsigned =
int flags, struct buffer *buf)
     {
         flags &=3D ~PIPV4_EXTRACT_DHCP_ROUTER;
     }
+    if (!c->options.block_ipv6)
+    {
+        flags &=3D ~(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER);
+    }
=20
     if (buf->len > 0)
     {
@@ -1497,7 +1640,7 @@ process_ip_header(struct context *c, unsigned int fla=
gs, struct buffer *buf)
                 /* possibly do NAT on packet */
                 if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
                 {
-                    const int direction =3D (flags & PIPV4_OUTGOING) ? CN_=
INCOMING : CN_OUTGOING;
+                    const int direction =3D (flags & PIP_OUTGOING) ?=20
+ CN_INCOMING : CN_OUTGOING;
                     client_nat_transform(c->options.client_nat, &ipbuf, di=
rection);
                 }
                 /* possibly extract a DHCP router message */ @@ -1515,8 +1=
658,18 @@ process_ip_header(struct context *c, unsigned int flags, struct b=
uffer *buf)
                 /* possibly alter the TCP MSS */
                 if (flags & PIP_MSSFIX)
                 {
-                    mss_fixup_ipv6(&ipbuf, MTU_TO_MSS(TUN_MTU_SIZE_DYNAMIC=
(&c->c2.frame)));
+                    mss_fixup_ipv6(&ipbuf,
+                        MTU_TO_MSS(TUN_MTU_SIZE_DYNAMIC(&c->c2.frame)));
+                }
+                if (!(flags & PIP_OUTGOING) && (flags &
+                       (PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVE=
R)))
+                {
+                    ipv6_send_icmp_unreachable(c, buf,
+                        (bool)(flags & PIPV6_IMCP_NOHOST_CLIENT));
+                    /* Drop the IPv6 packet */
+                    buf->len=3D0;
                 }
+
             }
         }
     }
@@ -1697,7 +1850,9 @@ process_outgoing_tun(struct context *c)
      * The --mssfix option requires
      * us to examine the IP header (IPv4 or IPv6).
      */
-    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT=
_NAT|PIPV4_OUTGOING, &c->c2.to_tun);
+    process_ip_header(c,
+        PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OU=
TGOING,
+        &c->c2.to_tun);
=20
     if (c->c2.to_tun.len <=3D MAX_RW_SIZE_TUN(&c->c2.frame))
     {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h index 58b75d64..=
a7913088 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -286,11 +286,13 @@ void process_outgoing_tun(struct context *c);
=20
 bool send_control_channel_string(struct context *c, const char *str, int m=
sglevel);
=20
-#define PIPV4_PASSTOS         (1<<0)
-#define PIP_MSSFIX            (1<<1)         /* v4 and v6 */
-#define PIPV4_OUTGOING        (1<<2)
-#define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
-#define PIPV4_CLIENT_NAT      (1<<4)
+#define PIPV4_PASSTOS                   (1<<0)
+#define PIP_MSSFIX                      (1<<1)         /* v4 and v6 */
+#define PIP_OUTGOING                    (1<<2)
+#define PIPV4_EXTRACT_DHCP_ROUTER       (1<<3)
+#define PIPV4_CLIENT_NAT                (1<<4)
+#define PIPV6_IMCP_NOHOST_CLIENT        (1<<5)
+#define PIPV6_IMCP_NOHOST_SERVER        (1<<6)
=20
 void process_ip_header(struct context *c, unsigned int flags, struct buffe=
r *buf);
=20
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c index 8440f311..d327=
8938 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2855,7 +2855,7 @@ multi_get_queue(struct mbuf_set *ms)
=20
     if (mbuf_extract_item(ms, &item)) /* cleartext IP packet */
     {
-        unsigned int pip_flags =3D PIPV4_PASSTOS;
+        unsigned int pip_flags =3D PIPV4_PASSTOS |=20
+ PIPV6_IMCP_NOHOST_SERVER;
=20
         set_prefix(item.instance);
         item.instance->context.c2.buf =3D item.buffer->buf; diff --git a/s=
rc/openvpn/options.c b/src/openvpn/options.c index 777ef4c6..aaf21fc5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -225,6 +225,10 @@ static const char usage_message[] =3D
     "                  Add 'bypass-dns' flag to similarly bypass tunnel fo=
r DNS.\n"
     "--redirect-private [flags]: Like --redirect-gateway, but omit actuall=
y changing\n"
     "                  the default gateway.  Useful when pushing private s=
ubnets.\n"
+    "--block-ipv6     : (Client) Instead sending IPv6 to the server genera=
te\n"
+    "                   ICMPv6 host unreachable messages on the client.\n"
+    "                   (Server) Instead of forwarding IPv6 packets send\n"
+    "                   ICMPv6 host unreachable packets to the client.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1 N=
AT rule.\n"
     "--push-peer-info : (client only) push client info to server.\n"
     "--setenv name value : Set a custom environmental variable to pass to =
script.\n"
@@ -6368,6 +6372,11 @@ add_option(struct options *options,  #endif
         options->routes->flags |=3D RG_ENABLE;
     }
+    else if (streq(p[0], "block-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        options->block_ipv6 =3D true;
+    }
     else if (streq(p[0], "remote-random-hostname") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL); diff --git a/src/openvpn/options=
.h b/src/openvpn/options.h index 575777f5..93df21b4 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -350,6 +350,7 @@ struct options
     bool route_delay_defined;
     struct route_option_list *routes;
     struct route_ipv6_option_list *routes_ipv6;                 /* IPv6 */
+    bool block_ipv6;
     bool route_nopull;
     bool route_gateway_via_dhcp;
     bool allow_pull_fqdn; /* as a client, allow server to push a FQDN for =
certain parameters */ diff --git a/src/openvpn/proto.c b/src/openvpn/proto.=
c index 87c18e84..5324eda4 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -98,6 +98,58 @@ is_ipv6(int tunnel_type, struct buffer *buf)
     return is_ipv_X( tunnel_type, buf, 6 );  }
=20
+
+uint16_t
+ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_pa=
yload,
+            const uint8_t *src_addr, const uint8_t *dest_addr, const=20
+int proto) {
+    uint32_t sum =3D 0;
+    int addr_len =3D (af =3D=3D AF_INET) ? 4 : 16;
+
+    /*
+     * make 16 bit words out of every two adjacent 8 bit words and  */
+    /* calculate the sum of all 16 bit words
+     */
+    for (int i =3D 0; i < len_payload; i +=3D 2)
+    {
+        sum +=3D  (uint16_t)(((payload[i] << 8) & 0xFF00) +
+            ((i + 1 < len_payload) ? (payload[i + 1] & 0xFF) : 0));
+
+    }
+
+    /*
+     * add the pseudo header which contains the IP source and destination
+     * addresses
+     */
+    for (int i =3D 0; i < addr_len; i +=3D 2)
+    {
+        sum +=3D (uint16_t)((src_addr[i] << 8) & 0xFF00) + (src_addr[i +=20
+ 1] & 0xFF);
+
+    }
+    for (int i =3D 0; i < addr_len; i +=3D 2)
+    {
+        sum +=3D (uint16_t)((dest_addr[i] << 8) & 0xFF00) + (dest_addr[i +=
 1] & 0xFF);
+    }
+
+    /* the length of the payload */
+    sum +=3D (uint16_t)len_payload;
+
+    /* The next header or proto field*/
+    sum +=3D (uint16_t)proto;
+
+    /*
+     * keep only the last 16 bits of the 32 bit calculated sum and add
+     * the carries
+     */
+    while (sum >> 16)
+    {
+        sum =3D (sum & 0xFFFF) + (sum >> 16);
+    }
+
+    /* Take the one's complement of sum */
+    return ((uint16_t)~sum);
+}
+
 #ifdef PACKET_TRUNCATION_CHECK
=20
 void
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h index 985aa99b..fa08=
5f09 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -95,9 +95,10 @@ struct openvpn_iphdr {
=20
     uint8_t ttl;
=20
-#define OPENVPN_IPPROTO_IGMP 2  /* IGMP protocol */ -#define OPENVPN_IPPRO=
TO_TCP  6  /* TCP protocol */ -#define OPENVPN_IPPROTO_UDP 17  /* UDP proto=
col */
+#define OPENVPN_IPPROTO_IGMP    2  /* IGMP protocol */
+#define OPENVPN_IPPROTO_TCP     6  /* TCP protocol */
+#define OPENVPN_IPPROTO_UDP    17  /* UDP protocol */
+#define OPENVPN_IPPROTO_ICMPV6 58 /* ICMPV6 protocol */
     uint8_t protocol;
=20
     uint16_t check;
@@ -120,6 +121,24 @@ struct openvpn_ipv6hdr {
     struct  in6_addr daddr;
 };
=20
+/*
+ * ICMPv6 header
+ */
+struct openvpn_icmp6hdr {
+#define OPENVPN_ICMP6_DESTINATION_UNREACHABLE       1
+#define OPENVPN_ND_ROUTER_SOLICIT                 133
+#define OPENVPN_ND_ROUTER_ADVERT                  134
+#define OPENVPN_ND_NEIGHBOR_SOLICIT               135
+#define OPENVPN_ND_NEIGHBOR_ADVERT                136
+#define OPENVPN_ND_INVERSE_SOLICIT                141
+#define OPENVPN_ND_INVERSE_ADVERT                 142
+    uint8_t icmp6_type;
+#define OPENVPN_ICMP6_DU_NOROUTE                    0
+#define OPENVPN_ICMP6_DU_COMMUNICATION_PROHIBTED    1
+    uint8_t icmp6_code;
+    uint16_t icmp6_cksum;
+    uint8_t icmp6_dataun[4];
+};
=20
 /*
  * UDP header
@@ -265,6 +284,39 @@ bool is_ipv4(int tunnel_type, struct buffer *buf);
=20
 bool is_ipv6(int tunnel_type, struct buffer *buf);
=20
+static inline int
+af_addr_size(sa_family_t af)
+{
+    switch (af)
+    {
+        case AF_INET:
+            return sizeof(struct sockaddr_in);
+
+        case AF_INET6:
+            return sizeof(struct sockaddr_in6);
+
+        default:
+            return 0;
+    }
+}
+
+/**
+ *  Calculates an IP or IPv6 checksum with a pseudo header as required=20
+by
+ *  TCP, UDP and ICMPv6
+ *
+ * @param af            - Address family for which the checksum is calcula=
ted
+ *                        AF_INET or AF_INET6
+ * @param payload       - the TCP, ICMPv6 or UDP packet
+ * @param len_payload   - length of payload
+ * @param src_addr      - Source address of the packet
+ * @param dest_addr     - Destination address of the packet
+ * @param proto next    - header or IP protocol of the packet
+ * @return The calculated checksum in host order  */ uint16_t=20
+ip_checksum(const sa_family_t af, const uint8_t *payload, const int len_pa=
yload,
+            const uint8_t *src_addr, const uint8_t *dest_addr,  const=20
+int proto);
+
 #ifdef PACKET_TRUNCATION_CHECK
 void ipv4_packet_size_verify(const uint8_t *data,
                              const int size, diff --git a/src/openvpn/sock=
et.h b/src/openvpn/socket.h index 0f22d479..19b38c92 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -860,25 +860,6 @@ addr_inet4or6(struct sockaddr *addr)
=20
 int addr_guess_family(sa_family_t af,const char *name);
=20
-static inline int
-af_addr_size(sa_family_t af)
-{
-    switch (af)
-    {
-        case AF_INET: return sizeof(struct sockaddr_in);
-
-        case AF_INET6: return sizeof(struct sockaddr_in6);
-
-        default:
-#if 0
-            /* could be called from socket_do_accept() with empty addr */
-            msg(M_ERR, "Bad address family: %d\n", af);
-            ASSERT(0);
-#endif
-            return 0;
-    }
-}
-
 static inline bool
 link_socket_actual_match(const struct link_socket_actual *a1, const struct=
 link_socket_actual *a2)  {
--
2.19.0



_______________________________________________
Openvpn-devel mailing list
Openvpn-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/openvpn-devel

