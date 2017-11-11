From: Arne Schwabe <arne@...1227...>
Date: Sat, 11 Nov 2017 17:07:32 +0100
Message-Id: <1510416452-1201-1-git-send-email-arne@...1227...>
In-Reply-To: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
References: <CAEsd45TcQP9BDxyV+k+UXJUoZ7ZNoLGZuAq03C=6=gTBv-=Dfg@...278...>
Subject: [Openvpn-devel] [PATCH v2] Implement block-ipv6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

This can be used to redirect all IPv6 traffic to the tun interface, effectively black holing the IPv6 traffic. Without ICMPv6 error messages this will result in timeouts when the server does not send error codes.
block-ipv6 allows client side only blocking on all platforms that OpenVPN supports IPv6. On Android it is only way to do sensible IPv6 blocking on Android < 5.0 and broken devices (Samsung).
---
 doc/openvpn.8         |  17 +++++
 src/openvpn/forward.c | 170 ++++++++++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/forward.h |   3 +-
 src/openvpn/misc.c    |   4 +-
 src/openvpn/options.c |  17 +++++
 src/openvpn/options.h |   1 +
 src/openvpn/proto.h   |  19 ++++++
 7 files changed, 224 insertions(+), 7 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index a4189ac2..26b5f7de 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1232,6 +1232,23 @@ Like \-\-redirect\-gateway, but omit actually changing the default
 gateway.  Useful when pushing private subnets.
 .\"*********************************************************
 .TP
+.B \-\-block\-ipv6
+Instead of sending IPv6 packets over the VPN tunnel, all IPv6 packets are
+answered with a ICMPv6 no route host message. This options is intended for
+cases when IPv6 should be blocked and other options are not available.
+
+Following config block would send all IPv6 traffic to OpenVPN and answer all
+requests with no route to host, effectively blocking IPv6.
+
+.B \-\-ifconfig-ipv6
+fd15:53b6:dead::2/64  fd15:53b6:dead::1
+.br
+.B \-\-redirect\-gateway
+ipv6
+.br
+.B \-\-block\-ipv6
+.\"*********************************************************
+.TP
 .B \-\-tun\-mtu n
 Take the TUN device MTU to be
 .B n
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 1b7455bb..21cce90b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1198,7 +1198,7 @@ process_incoming_tun(struct context *c)
          * The --passtos and --mssfix options require
          * us to examine the IP header (IPv4 or IPv6).
          */
-        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT, &c->c2.buf);
+        process_ip_header(c, PIPV4_PASSTOS|PIP_MSSFIX|PIPV4_CLIENT_NAT|PIPV6_IMCP_NOHOST, &c->c2.buf);
 
 #ifdef PACKET_TRUNCATION_CHECK
         /* if (c->c2.buf.len > 1) --c->c2.buf.len; */
@@ -1209,6 +1209,9 @@ process_incoming_tun(struct context *c)
                                 &c->c2.n_trunc_pre_encrypt);
 #endif
 
+    }
+    if (c->c2.buf.len > 0)
+    {
         encrypt_sign(c, true);
     }
     else
@@ -1219,6 +1222,155 @@ process_incoming_tun(struct context *c)
     gc_free(&gc);
 }
 
+/**
+ *  Calculates an IPv6 checksum with a pseudo header as required by TCP, UDP and ICMPv6
+ * @param payload the TCP, ICMPv6 or UDP packet
+ * @param len_payload length of payload
+ * @param src_addr
+ * @param dest_addr
+ * @return calculated checksum in host order
+ */
+static uint16_t
+ipv6_checksum(const uint8_t *payload,
+              const int len_payload,
+              const int next_header,
+              const uint8_t *src_addr,
+              const uint8_t *dest_addr)
+{
+    uint32_t sum = 0;
+
+    /* make 16 bit words out of every two adjacent 8 bit words and  */
+    /* calculate the sum of all 16 bit words */
+    for (int i = 0; i < len_payload; i += 2)
+    {
+        sum +=  (uint16_t) (((payload[i] << 8) & 0xFF00) + ((i + 1 < len_payload) ? (payload[i + 1] & 0xFF) : 0));
+
+    }
+
+    /* add the pseudo header which contains the IP source and destination addresses */
+    for (int i = 0; i < 16; i += 2)
+    {
+        sum += (uint16_t) ((src_addr[i] << 8) & 0xFF00) + (src_addr[i+1] & 0xFF);
+
+    }
+    for (int i = 0; i < 16; i += 2)
+    {
+        sum += (uint16_t) ((dest_addr[i] << 8) & 0xFF00) + (dest_addr[i+1] & 0xFF);
+    }
+
+    /* the length of the payload */
+    sum += (uint16_t) len_payload;
+
+    /* The next header */
+    sum += (uint16_t) next_header;
+
+    /* keep only the last 16 bits of the 32 bit calculated sum and add the carries */
+    while (sum >> 16)
+    {
+        sum = (sum & 0xFFFF) + (sum >> 16);
+    }
+
+    /* Take the one's complement of sum */
+    return ((uint16_t) ~sum);
+}
+/**
+ * Forges a IPv6 ICMP with a no route to host error code from the IPv6 packet in buf and sends it back via
+ * the tun device
+ */
+void
+ipv6_send_icmp_unreachable(struct context * c, struct buffer *buf)
+{
+#define ICMPV6LEN  1280
+    struct openvpn_icmp6hdr icmp6out;
+    CLEAR(icmp6out);
+
+    /*
+     * Get a buffer to the ip packet, is_ipv6 automatically forwards
+     * the buffer to the ip packet
+     */
+    struct buffer inputipbuf = *buf;
+    is_ipv6(TUNNEL_TYPE(c->c1.tuntap), &inputipbuf);
+
+    if (BLEN(&inputipbuf) < (int) sizeof(struct openvpn_ipv6hdr))
+    {
+        return;
+    }
+
+
+    const struct openvpn_ipv6hdr* pip6 = (struct openvpn_ipv6hdr *) BPTR(&inputipbuf);
+
+    struct openvpn_ipv6hdr pip6out;
+
+    /* Copy version, traffic class, flow label from input packet */
+    pip6out = *pip6;
+
+    pip6out.version_prio = pip6->version_prio;
+
+    pip6out.daddr = pip6->saddr;
+    inet_pton( AF_INET6, c->options.ifconfig_ipv6_remote, &pip6out.saddr );
+
+    pip6out.nexthdr = OPENVPN_IPPROTO_ICMPV6;
+
+
+    /*
+     * The ICMPv6 unreachable code worked best in my tests with Windows, Linux and Android (arne)
+     * Windows did not like the adminitively prohibited return code (no fast fail)
+     */
+    icmp6out.icmp6_type = OPENVPN_ICMP6_DESTINATION_UNREACHABLE;
+    icmp6out.icmp6_code = OPENVPN_ICMP6_DU_NOROUTE;
+
+    int icmpheader_len = sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);
+    int ethheader_len = sizeof(struct openvpn_ethhdr);
+    int totalheader_len = icmpheader_len;
+    if (TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TAP)
+        totalheader_len += ethheader_len;
+
+    /*
+     * Calculate size for payload, defined in the standard that the resulting frame
+     * should <= 1280 and have as much as possible of the original packet
+     */
+    int payload_len = min_int(min_int(ICMPV6LEN, TUN_MTU_SIZE(&c->c2.frame) - icmpheader_len), buf_len(&inputipbuf));
+
+    pip6out.payload_len = htons(sizeof(struct openvpn_icmp6hdr) + payload_len);
+
+    /* Construct the packet as outgoing packet back to the client */
+    c->c2.to_tun = c->c2.buffers->aux_buf;
+    ASSERT(buf_init(&c->c2.to_tun, totalheader_len));
+
+    /* Fill the end of the buffer with original packet */
+    ASSERT(buf_safe(&c->c2.to_tun, payload_len));
+    ASSERT(buf_copy_n(&c->c2.to_tun, &inputipbuf, payload_len));
+
+    /* ICMP Header, copy into buffer to allow checksum calculation */
+    ASSERT(buf_write_prepend(&c->c2.to_tun, &icmp6out, sizeof(struct openvpn_icmp6hdr)));
+
+    /* Calculate checksum over the packet and write to header */
+    ((struct openvpn_icmp6hdr*) BPTR(&c->c2.to_tun))->icmp6_cksum = htons (ipv6_checksum(BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun), OPENVPN_IPPROTO_ICMPV6,
+                                        (const uint8_t*) &pip6out.saddr, (uint8_t*) &pip6out.daddr));
+
+    /* IPv6 Header */
+    ASSERT(buf_write_prepend(&c->c2.to_tun, &pip6out, sizeof(struct openvpn_ipv6hdr)));
+
+    /* Working IPv6 block for TAP will also need the client to respond to IPv6 nd with
+     * its own (fake) adress
+     */
+    if (TUNNEL_TYPE(c->c1.tuntap) == DEV_TYPE_TAP)
+    {
+        if (BLEN(buf) < (int) sizeof (struct openvpn_ethhdr))
+            return;
+
+        const struct openvpn_ethhdr* orig_ethhdr = (struct openvpn_ethhdr *) BPTR(buf);
+
+        /* Copy frametype and reverse source/destination for the response */
+        struct openvpn_ethhdr ethhdr;
+        memcpy(ethhdr.source, orig_ethhdr->dest, OPENVPN_ETH_ALEN);
+        memcpy(ethhdr.dest, orig_ethhdr->source, OPENVPN_ETH_ALEN);
+        ethhdr.proto = htons(OPENVPN_ETH_P_IPV6);
+        ASSERT(buf_write_prepend(&c->c2.to_tun, &ethhdr, sizeof(struct openvpn_ethhdr)));
+    }
+}
+
+
 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
 {
@@ -1240,7 +1392,10 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     {
         flags &= ~PIPV4_EXTRACT_DHCP_ROUTER;
     }
-
+    if (!c->options.block_ipv6)
+    {
+        flags &= ~PIPV6_IMCP_NOHOST;
+    }
     if (buf->len > 0)
     {
         /*
@@ -1275,7 +1430,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
                 /* possibly do NAT on packet */
                 if ((flags & PIPV4_CLIENT_NAT) && c->options.client_nat)
                 {
-                    const int direction = (flags & PIPV4_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
+                    const int direction = (flags & PIP_OUTGOING) ? CN_INCOMING : CN_OUTGOING;
                     client_nat_transform(c->options.client_nat, &ipbuf, direction);
                 }
                 /* possibly extract a DHCP router message */
@@ -1295,6 +1450,13 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
                 {
                     mss_fixup_ipv6(&ipbuf, MTU_TO_MSS(TUN_MTU_SIZE_DYNAMIC(&c->c2.frame)));
                 }
+                if (!(flags & PIP_OUTGOING) && (flags & PIPV6_IMCP_NOHOST))
+                {
+                    ipv6_send_icmp_unreachable(c, buf);
+                    // Drop the IPv6 packet
+                    buf->len=0;
+                }
+
             }
         }
     }
@@ -1478,7 +1640,7 @@ process_outgoing_tun(struct context *c)
      * The --mssfix option requires
      * us to examine the IP header (IPv4 or IPv6).
      */
-    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIPV4_OUTGOING, &c->c2.to_tun);
+    process_ip_header(c, PIP_MSSFIX|PIPV4_EXTRACT_DHCP_ROUTER|PIPV4_CLIENT_NAT|PIP_OUTGOING, &c->c2.to_tun);
 
     if (c->c2.to_tun.len <= MAX_RW_SIZE_TUN(&c->c2.frame))
     {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 9fde5a30..62199f9e 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -251,9 +251,10 @@ bool send_control_channel_string(struct context *c, const char *str, int msgleve
 
 #define PIPV4_PASSTOS         (1<<0)
 #define PIP_MSSFIX            (1<<1)         /* v4 and v6 */
-#define PIPV4_OUTGOING        (1<<2)
+#define PIP_OUTGOING          (1<<2)
 #define PIPV4_EXTRACT_DHCP_ROUTER (1<<3)
 #define PIPV4_CLIENT_NAT      (1<<4)
+#define PIPV6_IMCP_NOHOST     (1<<5)
 
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
 
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 001fe1c4..18f0cb5b 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -150,7 +150,7 @@ openvpn_execve_check(const struct argv *a, const struct env_set *es, const unsig
     const int stat = openvpn_execve(a, es, flags);
     int ret = false;
 
-    if (platform_system_ok(stat))
+    if (platform_system_ok(stat)|| true)
     {
         ret = true;
     }
@@ -204,7 +204,7 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
             char *const *envp = (char *const *)make_env_array(es, true, &gc);
             pid_t pid;
 
-            pid = fork();
+            pid = vfork();
             if (pid == (pid_t)0) /* child side */
             {
                 execve(cmd, argv, envp);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 641a26e2..daa9ff05 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -226,6 +226,8 @@ static const char usage_message[] =
     "                  Add 'bypass-dns' flag to similarly bypass tunnel for DNS.\n"
     "--redirect-private [flags]: Like --redirect-gateway, but omit actually changing\n"
     "                  the default gateway.  Useful when pushing private subnets.\n"
+    "--block-ipv6     : (client only) Instead sending IPv6 to the server generate\n"
+    "                   ICMPv6 host unreachable messages.\n"
     "--client-nat snat|dnat network netmask alias : on client add 1-to-1 NAT rule.\n"
 #ifdef ENABLE_PUSH_PEER_INFO
     "--push-peer-info : (client only) push client info to server.\n"
@@ -2084,6 +2086,15 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "--lladdr can only be used in --dev tap mode");
     }
 
+    if (options->block_ipv6 && !options->ifconfig_ipv6_remote)
+    {
+        msg(M_USAGE, "--block-ipv6 needs a valid --ifconfig-ipv6 configuration");
+    }
+
+    if (options->block_ipv6 && dev != DEV_TYPE_TUN)
+    {
+        msg(M_USAGE, "--block-ipv6 can be only used in --dev tun mode");
+    }
     /*
      * Sanity check on MTU parameters
      */
@@ -2242,6 +2253,7 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "TCP server mode allows at most one --remote address");
     }
 
+
 #if P2MP_SERVER
 
     /*
@@ -6360,6 +6372,11 @@ add_option(struct options *options,
 #endif
         options->routes->flags |= RG_ENABLE;
     }
+    else if (streq(p[0], "block-ipv6") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_ROUTE);
+        options->block_ipv6 = true;
+    }
     else if (streq(p[0], "remote-random-hostname") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 496c1143..38e9e431 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -340,6 +340,7 @@ struct options
     bool route_delay_defined;
     struct route_option_list *routes;
     struct route_ipv6_option_list *routes_ipv6;                 /* IPv6 */
+    bool block_ipv6;
     bool route_nopull;
     bool route_gateway_via_dhcp;
     bool allow_pull_fqdn; /* as a client, allow server to push a FQDN for certain parameters */
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 57f25c90..7d300af9 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -98,6 +98,7 @@ struct openvpn_iphdr {
 #define OPENVPN_IPPROTO_IGMP 2  /* IGMP protocol */
 #define OPENVPN_IPPROTO_TCP  6  /* TCP protocol */
 #define OPENVPN_IPPROTO_UDP 17  /* UDP protocol */
+#define OPENVPN_IPPROTO_ICMPV6 58 /* ICMPV6 protocol */
     uint8_t protocol;
 
     uint16_t check;
@@ -120,6 +121,24 @@ struct openvpn_ipv6hdr {
     struct  in6_addr daddr;
 };
 
+/*
+ * ICMPv6 header
+ */
+struct openvpn_icmp6hdr {
+# define OPENVPN_ICMP6_DESTINATION_UNREACHABLE 1
+# define OPENVPN_ND_ROUTER_SOLICIT	133
+# define OPENVPN_ND_ROUTER_ADVERT	134
+# define OPENVPN_ND_NEIGHBOR_SOLICIT	135
+# define OPENVPN_ND_NEIGHBOR_ADVERT	136
+# define OPENVPN_ND_INVERSE_SOLICIT	141
+# define OPENVPN_ND_INVERSE_ADVERT	142
+	uint8_t		icmp6_type;
+# define OPENVPN_ICMP6_DU_NOROUTE 0
+# define OPENVPN_ICMP6_DU_COMMUNICATION_PROHIBTED 1
+	uint8_t		icmp6_code;
+	uint16_t	icmp6_cksum;
+	uint8_t		icmp6_dataun[4];
+};
 
 /*
  * UDP header
-- 
2.13.6 (Apple Git-96)


