Message-ID: <ef1b6b7c-eae5-4554-97ad-fdf4e586de21@...3013...>
Date: Tue, 17 Mar 2026 10:22:07 +0100
MIME-Version: 1.0
Content-Language: en-US, fr-FR, de-DE
From: openvpn-devel@...3013...
Subject: [Openvpn-devel] [PATCH] Add --sni-passthrough-hostname and
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
To: openvpn-devel@lists.sourceforge.net

Hi everyone,

This is my first contribution to OpenVPN. I'd appreciate any feedback.


This patch adds the ability to operate openvpn behind HTTP SNI proxy 
like Traefik.
It is meant to operate in the reverse way of the already implemented 
port-sharing option.


Usefulness of this patch :
I got bored of my vpn not working when connected to a public wifi that 
filter out non HTTP/HTTPS connection.
As most of those public wifi are not IPv6 enabled , i need to share IPv4 
ports.
I also want my web service to natively retain remote IP in their logs.
For example :  my client config will first try the openvpn port IPv6, 
IPv4, then the HTTPS shared.
It may induce bandwidth impact due to the added proxy, but that's a 
tradeoff .


How it works :
- server : when sni-passthrough-server is enabled and tcp, check the 
first datas for a SNI header then discard and proceed to the openvpn 
protocol, legacy client not sending the SNI header make it through .
- client : when sni-passthrough-hostname is given and tcp, send a forged 
SNI header ahead of the openvpn protocol, it is therefore incompatible 
with servers without sni-passthrough-server enabled (see possible 
improvement).


sni-passthrough-server is not used to find the remote server.
Traefik let it go through HTTP and HTTPS , it only cares about the SNI 
header.

config example :

openvpn client :
sni-passthrough-hostname vpn.example.com

openvpn server :
sni-passthrough-server


Traefik config :

tcp:
   routers:
     matrix_https:
       rule: "HostSNI(`matrix.example.com`) || 
HostSNI(`element.example.com`) "
       entryPoints:
         - websecure
       service: matrix_service_https
       tls:
         passthrough: true
     openvpn_router:
       rule: "HostSNI(`vpn.example.com`)"
       entryPoints:
         - websecure
         - web
       service: openvpn_service
       tls:
         passthrough: true

   services:
     openvpn_service:
       loadBalancer:
         servers:
           - address: "192.168.254.2:1194"
      matrix_service_https:
       loadBalancer:
         servers:
           - address: "192.168.254.1:443"
  http:
   routers:
     ip_https:
       rule: "Host(`ip.example.com`) || Host(`ip4.example.com`)  || 
Host(`ip6.example.com`)"
       entryPoints:
         - websecure
       service: ip_service_http
       tls: {}
     ip_http:
       rule: "Host(`ip.example.com`) || Host(`ip4.example.com`)  || 
Host(`ip6.example.com`)"
       entryPoints:
         - web
       service: ip_service_http

    services:
      ip_service_http:
       loadBalancer:
         servers:
           - url: "http://ifconfig:8080"



Possible improvement : client config : per remote server 
sni-passthrough-hostname option like the lport option seems to be

Note: This patch was developed with the assistance of AI.

https://github.com/OpenVPN/openvpn/commit/1c58e94dfea0a359ce55d656c9beb46c8afb0570



Thanks for your time and review.

         Bertrand Hudzia





Allow OpenVPN TCP connections to be routed through SNI-based reverse
proxies (e.g. Traefik with tls passthrough) by prepending a minimal
fake TLS ClientHello containing an SNI extension before the OpenVPN
protocol stream.

Client side (--sni-passthrough-hostname <host>): builds and sends a
single TLS record containing a ClientHello with the specified SNI
hostname. The proxy reads the SNI and forwards the connection to the
correct backend. The OpenVPN protocol follows immediately after.

Server side (--sni-passthrough-server): auto-detects the routing
header by peeking at the first byte (0x16 = TLS record). If present,
the header is consumed and discarded before normal OpenVPN stream
parsing begins. Legacy clients without --sni-passthrough-hostname
are accepted transparently.

The feature is conditionally compiled via --enable-sni-passthrough
(enabled by default) and guarded by #if SNI_PASSTHROUGH throughout.

Signed-off-by: Bertrand Hudzia <openvpn-devel@...3013...>
Signed-off-by: Bertrand Hudzia <dev-contrib@...3013...>
---
  configure.ac          |   8 ++
  src/openvpn/options.c |  26 ++++
  src/openvpn/options.h |  16 +++
  src/openvpn/socket.c  | 306 ++++++++++++++++++++++++++++++++++++++++++
  src/openvpn/socket.h  |   8 ++
  src/openvpn/syshead.h |   9 ++
  6 files changed, 373 insertions(+)

diff --git a/configure.ac b/configure.ac
index ecef2b9e..0d1a0606 100644
--- a/configure.ac
+++ b/configure.ac
@@ -129,6 +129,13 @@ AC_ARG_ENABLE(
      [enable_port_share="yes"]
  )

+AC_ARG_ENABLE(
+    [sni-passthrough],
+    [AS_HELP_STRING([--disable-sni-passthrough], [disable SNI 
passthrough support 
(--sni-passthrough-hostname/--sni-passthrough-server) 
@<:@default=yes@:>@])],
+    ,
+    [enable_sni_passthrough="yes"]
+)
+
  AC_ARG_ENABLE(
      [debug],
      [AS_HELP_STRING([--disable-debug], [disable debugging support 
(disable gremlin and verb 7+ messages) @<:@default=yes@:>@])],
@@ -1164,6 +1171,7 @@ test "${enable_small}" = "yes" && 
AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller
  test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], 
[Enable internal fragmentation support])
  test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], 
[1], [Enable TCP Server port sharing])
  test "${enable_dns_updown_by_default}" = "yes" && 
AC_DEFINE([ENABLE_DNS_UPDOWN_BY_DEFAULT], [1], [Enable dns-updown hook 
by default])
+test "${enable_sni_passthrough}" = "yes" && 
AC_DEFINE([ENABLE_SNI_PASSTHROUGH], [1], [Enable SNI passthrough support])
  test "${enable_crypto_ofb_cfb}" = "yes" && 
AC_DEFINE([ENABLE_OFB_CFB_MODE], [1], [Enable OFB and CFB cipher modes])
  OPTIONAL_CRYPTO_CFLAGS="${OPTIONAL_CRYPTO_CFLAGS} ${CRYPTO_CFLAGS}"
  OPTIONAL_CRYPTO_LIBS="${OPTIONAL_CRYPTO_LIBS} ${CRYPTO_LIBS}"
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1db781d8..41b62f68 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -641,6 +641,20 @@ static const char usage_message[] =
      "                  client-supplied tls-crypt-v2 client key\n"
      "--tls-crypt-v2-max-age n : Only accept tls-crypt-v2 client keys 
that have a\n"
      "                  timestamp which is at most n days old.\n"
+#if SNI_PASSTHROUGH
+    "--sni-passthrough-hostname name : (Client) Prepend an SNI routing\n"
+    "                  header to every TCP connection so that SNI-aware 
proxies\n"
+    "                  (e.g. Traefik passthrough) route the stream to 
the right\n"
+    "                  backend by hostname.  name is the hostname the 
proxy must\n"
+    "                  route to this OpenVPN server.  No extra 
encryption is\n"
+    "                  added.  The server must have 
--sni-passthrough-server\n"
+    "                  set.\n"
+    "--sni-passthrough-server : (Server) Detect and discard the SNI 
routing\n"
+    "                  header sent by clients using 
--sni-passthrough-hostname,\n"
+    "                  then proceed with the OpenVPN protocol. Legacy 
clients\n"
+    "                  (no routing header) are detected by peeking the 
first\n"
+    "                  byte and handled normally.\n"
+#endif
      "--askpass [file]: Get PEM password from controlling tty before we 
daemonize.\n"
      "--auth-nocache  : Don't cache --askpass or --auth-user-pass 
passwords.\n"
      "--crl-verify crl ['dir']: Check peer certificate against a CRL.\n"
@@ -9039,6 +9053,18 @@ add_option(struct options *options, char *p[], 
bool is_inline, const char *file,
              goto err;
          }
      }
+#if SNI_PASSTHROUGH
+    else if (streq(p[0], "sni-passthrough-hostname") && p[1] && !p[2])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->sni_passthrough_hostname = p[1];
+    }
+    else if (streq(p[0], "sni-passthrough-server") && !p[1])
+    {
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        options->sni_passthrough_server = true;
+    }
+#endif
      else if (streq(p[0], "x509-track") && p[1] && !p[2])
      {
          VERIFY_PERMISSION(OPT_P_GENERAL);
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3d8b5059..94e9060e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -672,6 +672,22 @@ struct options

      int tls_crypt_v2_max_age;

+#if SNI_PASSTHROUGH
+    /** Hostname to embed in the SNI routing header 
(--sni-passthrough-hostname).
+     *  When set, the client prepends an SNI routing header before the 
OpenVPN
+     *  protocol so that SNI-aware TCP proxies (e.g. Traefik 
passthrough) can
+     *  route the connection to the right backend by hostname. Works 
for both
+     *  direct and proxied connections as long as the server also has
+     *  --sni-passthrough-server set. */
+    const char *sni_passthrough_hostname;
+
+    /** Enable server-side detection and discarding of the SNI routing 
header
+     *  sent by clients using --sni-passthrough-hostname 
(--sni-passthrough-server).
+     *  Peeks the first byte: 0x16 = routing header present (discard it);
+     *  anything else = legacy client (proceed normally, full backwards 
compat). */
+    bool sni_passthrough_server;
+#endif
+
      /* Allow only one session */
      bool single_session;

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5df07924..27ffaba2 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1400,6 +1400,12 @@ link_socket_init_phase1(struct context *c, int 
sock_index, int mode)
          sock->sockflags |= SF_PORT_SHARE;
      }
  #endif
+#if SNI_PASSTHROUGH
+    if (o->sni_passthrough_server)
+    {
+        sock->sockflags |= SF_SNI_PASSTHROUGH;
+    }
+#endif

      sock->mark = o->mark;
      sock->bind_dev = o->bind_dev;
@@ -1681,6 +1687,12 @@ create_socket_dco_win(struct context *c, struct 
link_socket *sock, struct signal
  }
  #endif /* if defined(_WIN32) */

+#if SNI_PASSTHROUGH
+/* Forward declaration for SNI passthrough helper defined later in this 
file. */
+static bool sni_passthrough_send_client_hello(socket_descriptor_t sd,
+                                              const char *sni);
+#endif
+
  /* finalize socket initialization */
  void
  link_socket_init_phase2(struct context *c, struct link_socket *sock)
@@ -1774,6 +1786,19 @@ link_socket_init_phase2(struct context *c, struct 
link_socket *sock)
          goto done;
      }

+#if SNI_PASSTHROUGH
+    if (proto_is_tcp(sock->info.proto)
+        && sock->info.proto == PROTO_TCP_CLIENT
+        && c->options.sni_passthrough_hostname)
+    {
+        if (!sni_passthrough_send_client_hello(sock->sd, 
c->options.sni_passthrough_hostname))
+        {
+            register_signal(sig_info, SIGUSR1, 
"sni-passthrough-send-error");
+            goto done;
+        }
+    }
+#endif
+
      phase2_set_socket_flags(sock);
      linksock_print_addr(sock);

@@ -1792,6 +1817,210 @@ done:
      }
  }

+#if SNI_PASSTHROUGH
+/*
+ * SNI passthrough support
+ * (--sni-passthrough-hostname / --sni-passthrough-server).
+ *
+ * Allows OpenVPN TCP connections to pass through SNI-aware TCP proxies 
such
+ * as Traefik (passthrough mode) on any port, without any double 
encryption.
+ *
+ * SNI-aware proxies read the hostname from the first bytes of the TCP 
stream
+ * and route the connection accordingly.  They expect those bytes to be
+ * formatted as a ClientHello record (the standard carrier for SNI in TCP).
+ *
+ *   Client (--sni-passthrough-hostname <hostname>):
+ *     Prepends a single SNI routing header — a minimal ClientHello record
+ *     carrying the given hostname — before the OpenVPN protocol bytes.
+ *     The proxy reads the hostname, routes the stream to the right 
backend,
+ *     and forwards all bytes (including the header) unchanged.
+ *
+ *   Server (--sni-passthrough-server):
+ *     Receives the routed stream, reads and discards the SNI routing 
header,
+ *     then proceeds with the normal OpenVPN protocol.  Legacy clients that
+ *     do not send the header are detected automatically and handled 
normally.
+ *
+ * No session of any kind is established by the routing header — it is
+ * discarded immediately.  No encryption layer is added; OpenVPN's own
+ * control-channel and data-channel security are used unchanged.
+ */
+
+/*
+ * Build a minimal SNI routing header into buf.
+ * Returns the number of bytes written, or 0 on failure (missing 
hostname or
+ * buffer too small).
+ *
+ * The header is formatted as a ClientHello record because that is what
+ * SNI-aware proxies expect.  It carries:
+ *   - SNI extension with the hostname (the only field the proxy reads)
+ *   - supported_versions extension (values 0x0304, 0x0303)
+ *   - supported_groups extension (x25519)
+ *   - Two cipher suite entries
+ * This is enough for any SNI-routing proxy to extract the hostname and
+ * forward the stream without attempting a real handshake.
+ */
+static size_t
+sni_passthrough_build_client_hello(uint8_t *buf, size_t bufsz, const 
char *sni)
+{
+    size_t sni_len;
+    size_t sni_body_len;
+    size_t sni_ext_wire;
+    size_t sv_ext_wire;
+    size_t sg_ext_wire;
+    size_t exts_total;
+    size_t hello_body;
+    size_t handshake_len;
+    size_t record_len;
+    size_t name_entry;
+    uint8_t *p;
+    int i;
+
+    if (!sni || !*sni)
+    {
+        return 0;
+    }
+    sni_len = strlen(sni);
+
+    /* Extension sizes (all big-endian, calculated bottom-up): */
+
+    /* SNI extension body: list_len(2) + name_type(1) + name_len(2) + 
name */
+    sni_body_len   = 2 + 1 + 2 + sni_len;
+    /* SNI extension wire: type(2) + ext_data_len(2) + body */
+    sni_ext_wire   = 4 + sni_body_len;
+
+    /* supported_versions: type(2)+len(2)+list_len(1)+v1.3(2)+v1.2(2) = 
9 */
+    sv_ext_wire    = 9;
+
+    /* supported_groups: type(2)+len(2)+groups_len(2)+x25519(2) = 8 */
+    sg_ext_wire    = 8;
+
+    exts_total     = sni_ext_wire + sv_ext_wire + sg_ext_wire;
+
+    /* ClientHello body: version(2)+random(32)+sess_id_len(1)+
+     * cipher_suites_len(2)+2 ciphers(4)+comp_len(1)+null_comp(1)+
+     * exts_len(2)+extensions */
+    hello_body     = 2 + 32 + 1 + 2 + 4 + 1 + 1 + 2 + exts_total;
+
+    /* Handshake message: type(1)+length(3)+body */
+    handshake_len  = 1 + 3 + hello_body;
+
+    /* Record envelope: content_type(1)+version(2)+length(2)+handshake */
+    record_len     = 5 + handshake_len;
+
+    if (record_len > bufsz)
+    {
+        return 0;
+    }
+
+    p = buf;
+
+    /* --- Record envelope header --- */
+    *p++ = 0x16;                            /* Content-Type: Handshake   */
+    *p++ = 0x03; *p++ = 0x01;              /* Legacy record version      */
+    *p++ = (handshake_len >> 8) & 0xff;
+    *p++ =  handshake_len       & 0xff;
+
+    /* --- Handshake header --- */
+    *p++ = 0x01;                            /* HandshakeType: 
ClientHello */
+    *p++ = (hello_body >> 16) & 0xff;
+    *p++ = (hello_body >>  8) & 0xff;
+    *p++ =  hello_body        & 0xff;
+
+    /* --- ClientHello body --- */
+    *p++ = 0x03; *p++ = 0x03;              /* client_version field      */
+
+    /* Random: 32 pseudo-random bytes (not cryptographically sensitive) */
+    for (i = 0; i < 32; i++)
+    {
+        *p++ = (uint8_t)(rand() & 0xff);
+    }
+
+    *p++ = 0x00;                            /* session_id: empty      */
+
+    /* cipher_suites: two plausible entries (never negotiated) */
+    *p++ = 0x00; *p++ = 0x04;
+    *p++ = 0x13; *p++ = 0x01;              /* 0x1301     */
+    *p++ = 0x13; *p++ = 0x02;              /* 0x1302     */
+
+    /* compression_methods: null only */
+    *p++ = 0x01; *p++ = 0x00;
+
+    /* extensions length */
+    *p++ = (exts_total >> 8) & 0xff;
+    *p++ =  exts_total       & 0xff;
+
+    /* --- SNI extension (type 0x0000) --- */
+    name_entry = 1 + 2 + sni_len;          /* name_type + name_len + 
name */
+    *p++ = 0x00; *p++ = 0x00;              /* extension type: 
server_name */
+    *p++ = (sni_body_len >> 8) & 0xff;
+    *p++ =  sni_body_len       & 0xff;
+    *p++ = (name_entry   >> 8) & 0xff;       /* server_name_list 
length     */
+    *p++ =  name_entry         & 0xff;
+    *p++ = 0x00;                              /* name_type: host_name  
       */
+    *p++ = (sni_len      >> 8) & 0xff;
+    *p++ =  sni_len            & 0xff;
+    memcpy(p, sni, sni_len);
+    p += sni_len;
+
+    /* --- supported_versions extension (type 0x002b) --- */
+    *p++ = 0x00; *p++ = 0x2b;
+    *p++ = 0x00; *p++ = 0x05;              /* extension data length: 5  
   */
+    *p++ = 0x04;                            /* versions list length: 4  
    */
+    *p++ = 0x03; *p++ = 0x04;              /* version 0x0304       */
+    *p++ = 0x03; *p++ = 0x03;              /* version 0x0303       */
+
+    /* --- supported_groups extension (type 0x000a) --- */
+    *p++ = 0x00; *p++ = 0x0a;
+    *p++ = 0x00; *p++ = 0x04;              /* extension data length: 4  
   */
+    *p++ = 0x00; *p++ = 0x02;             /* groups list length: 2      */
+    *p++ = 0x00; *p++ = 0x1d;             /* x25519       */
+
+    return (size_t)(p - buf);
+}
+
+/*
+ * Client side (--sni-passthrough-hostname): send the SNI routing header,
+ * then return.  The OpenVPN protocol follows immediately after.
+ * The socket must be in blocking mode (before phase2_set_socket_flags).
+ */
+static bool
+sni_passthrough_send_client_hello(socket_descriptor_t sd, const char *sni)
+{
+    uint8_t buf[512];
+    size_t len;
+    ssize_t sent;
+
+    len = sni_passthrough_build_client_hello(buf, sizeof(buf), sni);
+
+    if (!len)
+    {
+        msg(M_NONFATAL,
+            "--sni-passthrough-hostname: failed to build SNI routing 
header");
+        goto error;
+    }
+
+    sent = 0;
+    while (sent < (ssize_t)len)
+    {
+        ssize_t n = send(sd, buf + sent, len - sent, MSG_NOSIGNAL);
+        if (n <= 0)
+        {
+            msg(D_LINK_ERRORS | M_ERRNO,
+                "--sni-passthrough-hostname: send() failed");
+            goto error;
+        }
+        sent += n;
+    }
+
+    msg(M_INFO, "--sni-passthrough-hostname: sent SNI routing header"
+        " (hostname: %s)", sni);
+    return true;
+
+error:
+    return false;
+}
+#endif /* if SNI_PASSTHROUGH */
+
  void
  link_socket_close(struct link_socket *sock)
  {
@@ -2079,6 +2308,12 @@ stream_buf_init(struct stream_buf *sb, struct 
buffer *buf, const unsigned int so
  #if PORT_SHARE
      sb->port_share_state =
          ((sockflags & SF_PORT_SHARE) && (proto == PROTO_TCP_SERVER)) ? 
PS_ENABLED : PS_DISABLED;
+#endif
+#if SNI_PASSTHROUGH
+    sb->sni_passthrough_state = ((sockflags & SF_SNI_PASSTHROUGH) && 
(proto == PROTO_TCP_SERVER))
+                                ? SNI_PT_PENDING
+                                : SNI_PT_DISABLED;
+    sb->sni_passthrough_total = -1;
  #endif
      stream_buf_reset(sb);

@@ -2167,6 +2402,77 @@ stream_buf_added(struct stream_buf *sb, int 
length_added)
          sb->buf.len += length_added;
      }

+#if SNI_PASSTHROUGH
+    /* SNI passthrough: detect and consume the SNI routing header sent by
+     * --sni-passthrough-hostname clients before the OpenVPN stream begins.
+     * After the first packet sni_passthrough_state is SNI_PT_DISABLED (0),
+     * so the entire block costs one always-not-taken branch per 
fragment. */
+    if (sb->sni_passthrough_state != SNI_PT_DISABLED)
+    {
+        if (sb->sni_passthrough_state == SNI_PT_PENDING && sb->buf.len 
 >= 1)
+        {
+            if (BPTR(&sb->buf)[0] != 0x16)
+            {
+                /* Legacy client without --sni-passthrough-hostname. */
+                msg(M_INFO, "--sni-passthrough-server: legacy client"
+                    " (no routing header)");
+                sb->sni_passthrough_state = SNI_PT_DISABLED;
+            }
+            else
+            {
+                sb->sni_passthrough_state = SNI_PT_CONSUMING;
+            }
+        }
+        if (sb->sni_passthrough_state == SNI_PT_CONSUMING)
+        {
+            int total;
+            int remaining;
+            uint8_t *src;
+
+            /* Wait for the 5-byte TLS record envelope header. */
+            if (sb->sni_passthrough_total < 0 && sb->buf.len >= 5)
+            {
+                const uint8_t *hdr = BPTR(&sb->buf);
+                uint16_t payload = ((uint16_t)hdr[3] << 8) | hdr[4];
+                sb->sni_passthrough_total = 5 + (int)payload;
+
+                if (sb->sni_passthrough_total > sb->maxlen)
+                {
+                    msg(M_WARN,
+                        "--sni-passthrough-server: routing header too 
large"
+                        " (%d bytes)", sb->sni_passthrough_total);
+                    sb->error = true;
+                    return false;
+                }
+            }
+            if (sb->sni_passthrough_total < 0
+                || sb->buf.len < sb->sni_passthrough_total)
+            {
+                /* Not enough data yet; wait for more. */
+                return false;
+            }
+
+            /* Full routing header received; discard it and reset the 
buffer so
+             * normal OpenVPN stream parsing sees a clean slate. */
+            total = sb->sni_passthrough_total;
+            remaining = sb->buf.len - total;
+            msg(M_INFO,
+                "--sni-passthrough-server: discarded SNI routing header"
+                " (%d bytes), switching to OpenVPN protocol", total);
+
+            src = BPTR(&sb->buf) + total;
+            sb->buf.len = 0;
+            if (remaining > 0)
+            {
+                memmove(BPTR(&sb->buf), src, remaining);
+                sb->buf.len = remaining;
+            }
+            sb->sni_passthrough_state = SNI_PT_DISABLED;
+            /* Fall through to normal OpenVPN stream parsing. */
+        }
+    }
+#endif /* if SNI_PASSTHROUGH */
+
      /* if length unknown, see if we can get the length prefix from
       * the head of the buffer */
      if (sb->len < 0 && sb->buf.len >= (int)sizeof(packet_size_type))
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cd4e8ed7..814fdca6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -136,6 +136,13 @@ struct stream_buf
  #define PS_FOREIGN  2
      int port_share_state;
  #endif
+#if SNI_PASSTHROUGH
+#define SNI_PT_DISABLED  0  /* not active */
+#define SNI_PT_PENDING   1  /* waiting to inspect first byte */
+#define SNI_PT_CONSUMING 2  /* first byte was 0x16, consuming the 
routing header */
+    int sni_passthrough_state;
+    int sni_passthrough_total; /* total bytes to discard (5 + payload); 
-1 until known */
+#endif
  };

  /*
@@ -214,6 +221,7 @@ struct link_socket
  #define SF_DCO_WIN           (1 << 5)
  #define SF_PREPEND_SA        (1 << 6)
  #define SF_PKTINFO_COPY_IIF  (1 << 7)
+#define SF_SNI_PASSTHROUGH   (1 << 8)
      unsigned int sockflags;
      int mark;
      const char *bind_dev;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 1d6cdc2b..2b270d25 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -474,6 +474,15 @@ socket_defined(const socket_descriptor_t sd)
  #define PORT_SHARE 0
  #endif

+/*
+ * SNI passthrough capability (--sni-passthrough-hostname / 
--sni-passthrough-server)
+ */
+#if defined(ENABLE_SNI_PASSTHROUGH)
+#define SNI_PASSTHROUGH 1
+#else
+#define SNI_PASSTHROUGH 0
+#endif
+
  /*
   * Do we support Unix domain sockets?
   */
-- 
2.47.3



