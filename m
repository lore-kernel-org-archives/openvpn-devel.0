From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 26 Jul 2024 08:20:53 +0000
References: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <192618d15a2b6ecb2eb10e078a5752ddb4723062-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mPTQdSu9amM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for
 HAProxy's PROXY protocol
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mPTQdSu9amM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail

to review the following change.


Change subject: Add support for HAProxy's PROXY protocol
......................................................................

Add support for HAProxy's PROXY protocol

The PROXY protocol is a simple protocol that can be used to
communicate connection information such as a client's address across
multiple layers of NAT or TCP proxies. This commit adds support for
the parsing of the v1 and v2 PROXY protocol header but does not yet
parse the TLV data in the v2 header.

Check if a PROXY protocol header was sent by the client at the
beginning of the connection. If so, parse it, store the extracted
informations and replace the proxy address with the real client
address. Checking for the header is done only if the packet has an
invalid length so that there's minimal overhead for the common case.

Also add a small document file showing how to configure HAProxy to
test the feature.

Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac
Signed-off-by: Ralf Lici <ralflici95@...277...>
---
M CMakeLists.txt
A doc/proxy-protocol.txt
M src/openvpn/Makefile.am
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/openvpn.h
A src/openvpn/proxy_protocol.c
A src/openvpn/proxy_protocol.h
M src/openvpn/socket.c
9 files changed, 895 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/685/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index ad620fa..67cfd08 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -490,6 +490,8 @@
     src/openvpn/proto.h
     src/openvpn/proxy.c
     src/openvpn/proxy.h
+    src/openvpn/proxy_protocol.c
+    src/openvpn/proxy_protocol.h
     src/openvpn/ps.c
     src/openvpn/ps.h
     src/openvpn/push.c
diff --git a/doc/proxy-protocol.txt b/doc/proxy-protocol.txt
new file mode 100644
index 0000000..bd9b606
--- /dev/null
+++ b/doc/proxy-protocol.txt
@@ -0,0 +1,157 @@
+HAProxy PROXY protocol support for OpenVPN
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The PROXY protocol is a simple protocol that can be used to retreive the
+original source address of a connection that has been proxied. Every conne=
ction
+is prepended with a header reporting the client IP address and port. The
+protocol specification is available at:
+https://www.haproxy.org/download/2.4/doc/proxy-protocol.txt
+
+Currently there are two versions of the protocol, a text based version (v1=
) and
+a binary version (v2).
+
+Version 1
+---------
+
+The text based version is a human readable protocol that is easy to debug.=
 It
+consists of a single line of text with the following fields:
+
+PROXY_SIGNATURE_V1 + single space + INET_PROTOCOL + single space + CLIENT_=
IP +
+single space + PROXY_IP + single space + CLIENT_PORT + single space +
+PROXY_PORT + "\r\n"
+
+The only supported INET_PROTOCOL in version 1 are "TCP4" and "TCP6".
+
+Version 2
+---------
+
+The binary version is a more efficient protocol that is more suitable for
+production use. It consists of a fixed length header followed by the origi=
nal
+connection data.
+
+A PROXY Protocol binary header for a IPv4 incoming address has the format:
+ 0               1               2               3
+ 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                                                               |
++                                                               +
+|                  Proxy Protocol v2 Signature                  |
++                                                               +
+|                                                               |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|Version|Command|   AF  | Proto.|         Address Length        |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                      IPv4 Source Address                      |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                    IPv4 Destination Address                   |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|          Source Port          |        Destination Port       |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                                                               |
++                                                               +
++                              TLVs                             +
++                                                               +
+|                                                               |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+
+A PROXY Protocol binary header for a IPv6 incoming address has the format:
+ 0               1               2               3
+ 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                                                               |
++                                                               +
+|                  Proxy Protocol v2 Signature                  |
++                                                               +
+|                                                               |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|Version|Command|   AF  | Proto.|         Address Length        |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                                                               |
++                                                               +
+|                                                               |
++                      IPv6 Source Address                      +
+|                                                               |
++                                                               +
+|                                                               |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                                                               |
++                                                               +
+|                                                               |
++                    IPv6 Destination Address                   +
+|                                                               |
++                                                               +
+|                                                               |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|          Source Port          |        Destination Port       |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+|                                                               |
++                                                               +
++                              TLVs                             +
++                                                               +
+|                                                               |
++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
+
+The fields are as follows:
+
+- Proxy Protocol v2 Signature: 12 bytes
+  The v2 signature of the protocol: "\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\=
x49\x54\x0A\x20".
+
+- Version: 4 bits
+  The version of the PROXY protocol (0x2).
+
+- Command: 4 bits
+  The command of the PROXY protocol can by one of the following:
+    - LOCAL: 0x0
+      The connection was initiated by the proxy.
+    - PROXY: 0x1
+      The connection was initiated by the client.
+
+- AF: 4 bits
+    The address family of the connection can be: AF_UNSPEC (0x0), AF_INET =
(0x1),
+    AF_INET6 (0x2) or AF_UNIX (0x3).
+
+- Proto: 4 bits
+    The protocol of the connection can be: UNSPEC (0x0), STREAM (0x1) or
+    DGRAM (0x2).
+
+- Address Length: 16 bits
+    The length of the rest of the header in bytes.
+
+Finally there may be a series of TLVs (Type-Length-Value) that can be used=
 to
+carry additional information.
+
+OpenVPN testing
+---------------
+
+Currently only TCP is supported. To test the PROXY protocol support in Ope=
nVPN,
+you can use HAProxy as a proxy with a configuration like this:
+
+global
+    log stdout format raw local0
+    log 127.0.0.1 local0 debug
+    daemon
+
+defaults
+    log     global
+    mode    tcp
+    option  tcplog
+    timeout connect 5000ms
+    timeout client  50000ms
+    timeout server  50000ms
+
+frontend openvpn_front
+    bind 10.10.20.1:1195
+    default_backend openvpn_back
+
+backend openvpn_back
+    server openvpn_server 10.10.10.1:1194 send-proxy
+    # server openvpn_server 10.10.10.1:1194 send-proxy-v2 proxy-v2-options=
 ssl,cert-cn,ssl-cipher,cert-sig,cert-key,authority,crc32c,unique-id
+
+
+You can use the commented line to test the binary format and the TLV data.
+
+Note that you should set the keepalive option so that the connection is not
+reset by HAProxy for inactivity.
+
+The OpenVPN TCP server should read and parse the header and use the inform=
ation
+to display the original source address in the logs.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 56cce9d..fc037ca 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -111,6 +111,7 @@
 	pool.c pool.h \
 	proto.c proto.h \
 	proxy.c proxy.h \
+	proxy_protocol.c proxy_protocol.h \
 	ps.c ps.h \
 	push.c push.h \
 	pushlist.h \
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..cbce217 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "mss.h"
 #include "mudp.h"
 #include "dco.h"
+#include "proxy_protocol.h"

 #include "memdbg.h"

@@ -680,6 +681,11 @@
         c->c1.socks_proxy =3D NULL;
         c->c1.socks_proxy_owned =3D false;
     }
+    if (c->c1.proxy_protocol)
+    {
+        proxy_protocol_free(c->c1.proxy_protocol);
+        c->c1.proxy_protocol =3D NULL;
+    }
 }

 static void
@@ -4774,7 +4780,7 @@
         /* free up environmental variable store */
         do_env_set_destroy(c);

-        /* close HTTP or SOCKS proxy */
+        /* close HTTP or SOCKS proxy or PROXY protocol object */
         uninit_proxy(c);

         /* garbage collect */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 03177bb..ac4652d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -51,6 +51,7 @@
 #include "ssl_util.h"
 #include "dco.h"
 #include "reflect_filter.h"
+#include "proxy_protocol.h"

 /*#define MULTI_DEBUG_EVENT_LOOP*/

@@ -779,6 +780,8 @@
         goto err;
     }

+    ALLOC_OBJ_CLEAR(mi->context.c1.proxy_protocol, struct proxy_protocol_i=
nfo);
+
     mi->context.c2.tls_multi->multi_state =3D CAS_NOT_CONNECTED;

     if (hash_n_elements(m->hash) >=3D m->max_clients)
@@ -3207,6 +3210,57 @@
     gc_free(&gc);
 }

+void
+multi_replace_proxy_addr(struct multi_context *m, struct multi_instance *m=
i)
+{
+    struct mroute_addr real =3D {0};
+    struct hash *hash =3D m->hash;
+    struct gc_arena gc =3D gc_new();
+
+    if (!mroute_extract_openvpn_sockaddr(&real, &mi->context.c1.proxy_prot=
ocol->src, true))
+    {
+        goto done;
+    }
+
+    const uint32_t hv =3D hash_value(hash, &real);
+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);
+
+    /* if the new address is already in the hash table, the new client tak=
es precedence */
+    struct hash_element *he =3D hash_lookup_fast(hash, bucket, &real, hv);
+    if (he)
+    {
+        struct multi_instance *oldmi =3D (struct multi_instance *) he->val=
ue;
+        msg(D_MULTI_LOW, "Client's real address (behind proxy) matches "
+            "existing client address -- new client takes precedence");
+        oldmi->did_real_hash =3D false;
+        multi_close_instance(m, oldmi, false);
+        he->key =3D &mi->real;
+        he->value =3D mi;
+    }
+
+    clear_prefix();
+    msg(D_MULTI_LOW, "Replacing proxy address: %s with client's real addre=
ss: %s",
+        mroute_addr_print(&mi->real, &gc),
+        mroute_addr_print(&real, &gc));
+
+    /* remove proxy address from hash table before changing address */
+    ASSERT(hash_remove(m->hash, &mi->real));
+    ASSERT(hash_remove(m->iter, &mi->real));
+
+    mi->real =3D real;
+    generate_prefix(mi);
+
+    ASSERT(hash_add(m->hash, &mi->real, mi, false));
+    ASSERT(hash_add(m->iter, &mi->real, mi, false));
+
+#ifdef ENABLE_MANAGEMENT
+    ASSERT(hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, true=
));
+#endif
+
+done:
+    gc_free(&gc);
+}
+
 /*
  * Called when an instance should be closed due to the
  * reception of a soft signal.
@@ -3348,6 +3402,7 @@
     struct mroute_addr src, dest;
     unsigned int mroute_flags;
     struct multi_instance *mi;
+    struct link_socket_info *lsi;
     bool ret =3D true;
     bool floated =3D false;

@@ -3387,15 +3442,31 @@
             }
         }

+        lsi =3D get_link_socket_info(c);
+
+        /* check for PROXY protocol */
+        if (lsi->proto =3D=3D PROTO_TCP_SERVER && !c->c1.proxy_protocol->v=
ersion && BLEN(&c->c2.buf) > 0)
+        {
+            if (!proxy_protocol_parse(c->c1.proxy_protocol, &c->c2.buf))
+            {
+                /* set version to invalid to avoid checking again */
+                c->c1.proxy_protocol->version =3D PROXY_PROTOCOL_VERSION_I=
NVALID;
+            }
+            else
+            {
+                multi_replace_proxy_addr(m, m->pending);
+                /* avoid processing the packet as an openvpn one */
+                buf_reset_len(&c->c2.buf);
+            }
+        }
+
         if (BLEN(&c->c2.buf) > 0)
         {
-            struct link_socket_info *lsi;
             const uint8_t *orig_buf;

             /* decrypt in instance context */
=20
             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index e98c93e..ded6103 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -45,6 +45,7 @@
 #include "pool.h"
 #include "plugin.h"
 #include "manage.h"
+#include "proxy_protocol.h"

 /*
  * Our global key schedules, packaged thusly
@@ -191,6 +192,8 @@
     struct socks_proxy_info *socks_proxy;
     bool socks_proxy_owned;

+    struct proxy_protocol_info *proxy_protocol;
+
     /* persist --ifconfig-pool db to file */
     struct ifconfig_pool_persist *ifconfig_pool_persist;
     bool ifconfig_pool_persist_owned;
diff --git a/src/openvpn/proxy_protocol.c b/src/openvpn/proxy_protocol.c
new file mode 100644
index 0000000..10a68c2
--- /dev/null
+++ b/src/openvpn/proxy_protocol.c
@@ -0,0 +1,472 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "error.h"
+#include "proxy_protocol.h"
+
+#define PROXY_PROTOCOL_V1_MAX_WORDS 6
+#define PROXY_PROTOCOL_V1_MAX_WORD_LEN 40
+
+typedef enum
+{
+    PROXY_PROTOCOL_PARSING_STATE_INVALID =3D -1,
+    PROXY_PROTOCOL_PARSING_STATE_OK =3D 0,
+    PROXY_PROTOCOL_PARSING_STATE_IGNORE =3D 1,
+} proxy_protocol_parsing_state_t;
+
+static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;
+static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;
+static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;
+
+static proxy_protocol_header_t header;
+static uint16_t header_len;
+static proxy_protocol_parsing_state_t parsing_state =3D PROXY_PROTOCOL_PAR=
SING_STATE_OK;
+
+proxy_protocol_version_t
+proxy_protocol_version(const uint8_t *buf, const int buf_len)
+{
+    if (buf_len >=3D PROXY_PROTOCOL_V2_MIN_HDR_LEN
+        && memcmp(buf, PROXY_PROTOCOL_V2_SIG, PROXY_PROTOCOL_V2_SIG_LEN) =
=3D=3D 0)
+    {
+        return PROXY_PROTOCOL_VERSION_2;
+    }
+    else if (buf_len >=3D PROXY_PROTOCOL_V1_MIN_HDR_LEN
+             && memcmp(buf, PROXY_PROTOCOL_V1_SIG, PROXY_PROTOCOL_V1_SIG_L=
EN) =3D=3D 0)
+    {
+        return PROXY_PROTOCOL_VERSION_1;
+    }
+    return PROXY_PROTOCOL_VERSION_INVALID;
+}
+
+int
+proxy_protocol_header_len(const uint8_t *buf, const int buf_len,
+                          const proxy_protocol_version_t version)
+{
+    memcpy(&header, buf, buf_len);
+
+    switch (version)
+    {
+        case PROXY_PROTOCOL_VERSION_1:
+        {
+            char *end =3D memchr(header.v1.line, '\r', buf_len - 1);
+            if (!end || end[1] !=3D '\n')
+            {
+                return -1; /* partial or invalid header */
+            }
+            return (int)(end + 2 - header.v1.line);
+        }
+
+        case PROXY_PROTOCOL_VERSION_2:
+            return PROXY_PROTOCOL_V2_MIN_HDR_LEN + ntohps(header.v2.len);
+
+        default:
+            return -1;
+    }
+}
+
+/*
+ * Parse a port number from a string.
+ *
+ * @param port_str - The string to parse.
+ *
+ * @return - The port number or -1 if the string is invalid.
+ */
+uint16_t
+proxy_protocol_parse_port(const char *port_str)
+{
+    char *endptr;
+    errno =3D 0;
+
+    long port =3D strtol(port_str, &endptr, 10);
+    if (errno !=3D 0 || endptr =3D=3D port_str || *endptr !=3D '\0' || por=
t <=3D 0 || port > 65535)
+    {
+        return -1;
+    }
+    return (uint16_t)port;
+}
+
+/*
+ * Set the source and destination addresses and ports in the proxy protocol
+ * info structure for later use.
+ *
+ * @param ppi - The proxy protocol info structure to store the addresses.
+ * @param ver - The version of the PROXY protocol.
+ * @param fam - The address family (supports: AF_INET or AF_INET6).
+ * @param st - The socket type.
+ * @param src_addr - The source address.
+ * @param dst_addr - The destination address.
+ * @param src_port - The source port.
+ * @param dst_port - The destination port.
+ */
+void
+proxy_protocol_set_addr(struct proxy_protocol_info *ppi,
+                        const proxy_protocol_version_t ver, const int fam,=
 const int st,
+                        const void *src_addr, const void *dst_addr,
+                        const uint16_t src_port, const uint16_t dst_port)
+{
+
+    ppi->version =3D ver;
+    ppi->sock_type =3D st;
+    if (fam =3D=3D AF_INET)
+    {
+        ppi->src.addr.sa.sa_family =3D AF_INET;
+        ppi->dst.addr.sa.sa_family =3D AF_INET;
+        memcpy(&ppi->src.addr.in4.sin_addr, (uint32_t *)src_addr,
+               sizeof(struct in_addr));
+        memcpy(&ppi->dst.addr.in4.sin_addr, (uint32_t *)dst_addr,
+               sizeof(struct in_addr));
+        ppi->src.addr.in4.sin_port =3D src_port;
+        ppi->dst.addr.in4.sin_port =3D dst_port;
+        msg(M_DEBUG, "PROXY protocol: SRC: %s:%u",
+            inet_ntoa(ppi->src.addr.in4.sin_addr),
+            ntohs(ppi->src.addr.in4.sin_port));
+        msg(M_DEBUG, "PROXY protocol: DST: %s:%u",
+            inet_ntoa(ppi->dst.addr.in4.sin_addr),
+            ntohs(ppi->dst.addr.in4.sin_port));
+    }
+    else if (fam =3D=3D AF_INET6)
+    {
+        ppi->src.addr.sa.sa_family =3D AF_INET6;
+        ppi->dst.addr.sa.sa_family =3D AF_INET6;
+        memcpy(&ppi->src.addr.in6.sin6_addr, src_addr, sizeof(struct in6_a=
ddr));
+        memcpy(&ppi->dst.addr.in6.sin6_addr, dst_addr, sizeof(struct in6_a=
ddr));
+        ppi->src.addr.in6.sin6_port =3D src_port;
+        ppi->dst.addr.in6.sin6_port =3D dst_port;
+
+        char ip6_str[INET6_ADDRSTRLEN];
+        if (inet_ntop(AF_INET6, &ppi->src.addr.in6.sin6_addr, ip6_str,
+                      INET6_ADDRSTRLEN))
+        {
+            msg(M_DEBUG, "PROXY protocol: SRC: %s:%u", ip6_str,
+                ntohs(ppi->src.addr.in6.sin6_port));
+        }
+        else
+        {
+            msg(M_NONFATAL, "PROXY protocol: could not parse source addres=
s");
+        }
+        if (inet_ntop(AF_INET6, &ppi->dst.addr.in6.sin6_addr, ip6_str,
+                      INET6_ADDRSTRLEN))
+        {
+            msg(M_DEBUG, "PROXY protocol: DST: %s:%u", ip6_str,
+                ntohs(ppi->dst.addr.in6.sin6_port));
+        }
+        else
+        {
+            msg(M_NONFATAL,
+                "PROXY protocol: could not parse destination address");
+        }
+    }
+    else
+    {
+        msg(M_NONFATAL, "PROXY protocol: unsupported address family");
+    }
+}
+
+/*
+ * Split the v1 header line into words (space-separated)
+ *
+ * @param words - The array to store the words.
+ * @param line - The header line to split.
+ * @param len - The length of the header line.
+ *
+ * @return - The number of words found or -1 if an error occurred.
+ */
+int
+proxy_protocol_v1_split_words(char words[][PROXY_PROTOCOL_V1_MAX_WORD_LEN],
+                              const char *line,
+                              int len)
+{
+    int word_num =3D 0;
+    const char *start =3D line;
+    for (int i =3D 0; i < len; ++i)
+    {
+        if (line[i] =3D=3D ' ')
+        {
+            if (word_num < PROXY_PROTOCOL_V1_MAX_WORDS)
+            {
+                int word_len =3D (int)(line + i - start);
+                if (word_len < PROXY_PROTOCOL_V1_MAX_WORD_LEN)
+                {
+                    memcpy(words[word_num], start, word_len);
+                    words[word_num][word_len] =3D '\0';
+                    ++word_num;
+                }
+                else
+                {
+                    msg(M_NONFATAL, "PROXY protocol v1: word too long");
+                    return -1;
+                }
+            }
+            start =3D line + i + 1;
+        }
+    }
+    return word_num;
+}
+
+/*
+ * Parse the PROXY protocol v1 header line.
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param line - The header line to parse.
+ * @param len - The length of the header line.
+ *
+ * @return - true if the header was successfully parsed.
+ */
+bool
+proxy_protocol_parse_v1(struct proxy_protocol_info *ppi,
+                        const char *line,
+                        int len)
+{
+    const proxy_protocol_version_t version =3D PROXY_PROTOCOL_VERSION_1;
+    char words[PROXY_PROTOCOL_V1_MAX_WORDS][PROXY_PROTOCOL_V1_MAX_WORD_LEN=
];
+
+    char *end =3D memchr(line, '\r', len - 1);
+    if (!end || end[1] !=3D '\n') /* partial or invalid header */
+    {
+        return false;
+    }
+    *end =3D ' '; /* replace CRLF with space for easier splitting */
+    int size =3D (int)(end - line + 1);
+
+    int word_num =3D proxy_protocol_v1_split_words(words, line, size);
+    if (word_num < 3)
+    {
+        msg(M_NONFATAL, "PROXY protocol v1: could not split header");
+        return false;
+    }
+
+    if (strcmp(words[1], "UNKNOWN") =3D=3D 0)
+    {
+        msg(M_DEBUG, "PROXY protocol v1: UNKNOWN protocol, ignoring header=
");
+        return true;
+    }
+    else if (strcmp(words[1], "TCP4") =3D=3D 0)
+    {
+        msg(M_DEBUG, "PROXY protocol v1: TCP4 protocol");
+        struct in_addr ip4_src_addr, ip4_dst_addr;
+        if (inet_pton(AF_INET, words[2], &ip4_src_addr) !=3D 1)
+        {
+            msg(M_NONFATAL,
+                "PROXY protocol v1: could not parse source address");
+            return false;
+        }
+        if (inet_pton(AF_INET, words[3], &ip4_dst_addr) !=3D 1)
+        {
+            msg(M_NONFATAL,
+                "PROXY protocol v1: could not parse destination address");
+            return false;
+        }
+        proxy_protocol_set_addr(ppi, version, AF_INET, SOCK_STREAM,
+                                &ip4_src_addr, &ip4_dst_addr,
+                                ntohs(proxy_protocol_parse_port(words[4])),
+                                ntohs(proxy_protocol_parse_port(words[5]))=
);
+        return true;
+    }
+    else if (strcmp(words[1], "TCP6") =3D=3D 0)
+    {
+        msg(M_DEBUG, "PROXY protocol v1: TCP6 protocol");
+        struct in6_addr ip6_src_addr, ip6_dst_addr;
+        if (inet_pton(AF_INET6, words[2], &ip6_src_addr) !=3D 1)
+        {
+            msg(M_NONFATAL,
+                "PROXY protocol v1: could not parse source address");
+            return false;
+        }
+        if (inet_pton(AF_INET6, words[3], &ip6_dst_addr) !=3D 1)
+        {
+            msg(M_NONFATAL,
+                "PROXY protocol v1: could not parse destination address");
+            return false;
+        }
+        proxy_protocol_set_addr(ppi, version, AF_INET6, SOCK_STREAM,
+                                &ip6_src_addr, &ip6_dst_addr,
+                                ntohs(proxy_protocol_parse_port(words[4])),
+                                ntohs(proxy_protocol_parse_port(words[5]))=
);
+        return true;
+    }
+    else
+    {
+        msg(M_NONFATAL, "PROXY protocol v1: unsupported protocol");
+        return false;
+    }
+}
+
+/*
+ * Parse the PROXY protocol v2 header.
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param header - The header to parse.
+ *
+ * @return - The number of bytes parsed or 0 if the header can be ignored.
+ */
+int
+proxy_protocol_parse_v2(struct proxy_protocol_info *ppi)
+{
+    size_t addr_len =3D 0;
+    int pos =3D PROXY_PROTOCOL_V2_SIG_LEN + sizeof(header.v2.ver_cmd);
+    const proxy_protocol_version_t version =3D PROXY_PROTOCOL_VERSION_2;
+
+    switch (header.v2.ver_cmd & PROXY_PROTOCOL_V2_CMD_MASK)
+    {
+        case PROXY_PROTOCOL_V2_LOCAL_CMD:
+            /* the receiver must accept this connection as valid and must =
use
+             * the real connection endpoints and discard the protocol block
+             * including the family which is ignored */
+            msg(M_DEBUG, "PROXY protocol v2: LOCAL command");
+            parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_IGNORE;
+            break;
+
+        case PROXY_PROTOCOL_V2_PROXY_CMD:
+            msg(M_DEBUG, "PROXY protocol v2: PROXY command");
+            break;
+
+        default:
+            msg(M_DEBUG, "PROXY protocol v2: UNSPEC or unknown command");
+            parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;
+    }
+
+    if (parsing_state !=3D PROXY_PROTOCOL_PARSING_STATE_OK)
+    {
+        return pos;
+    }
+    pos +=3D sizeof(header.v2.fam);
+
+    switch (header.v2.fam)
+    {
+        case PROXY_PROTOCOL_V2_AF_INET | PROXY_PROTOCOL_V2_TP_STREAM:
+            msg(M_DEBUG, "PROXY protocol v2: TCP over IPv4.");
+            proxy_protocol_set_addr(ppi, version, AF_INET, SOCK_STREAM,
+                                    &header.v2.addr.ip4.src_addr,
+                                    &header.v2.addr.ip4.dst_addr,
+                                    header.v2.addr.ip4.src_port,
+                                    header.v2.addr.ip4.dst_port);
+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV4;
+            break;
+
+        case PROXY_PROTOCOL_V2_AF_INET | PROXY_PROTOCOL_V2_TP_DGRAM:
+            msg(M_DEBUG, "PROXY protocol v2: UDP over IPv4");
+            proxy_protocol_set_addr(ppi, version, AF_INET, SOCK_DGRAM,
+                                    &header.v2.addr.ip4.src_addr,
+                                    &header.v2.addr.ip4.dst_addr,
+                                    header.v2.addr.ip4.src_port,
+                                    header.v2.addr.ip4.dst_port);
+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV4;
+            break;
+
+        case PROXY_PROTOCOL_V2_AF_INET6 | PROXY_PROTOCOL_V2_TP_STREAM:
+            msg(M_DEBUG, "PROXY protocol v2: TCP over IPv6");
+            proxy_protocol_set_addr(ppi, version, AF_INET6, SOCK_STREAM,
+                                    header.v2.addr.ip6.src_addr,
+                                    header.v2.addr.ip6.dst_addr,
+                                    header.v2.addr.ip6.src_port,
+                                    header.v2.addr.ip6.dst_port);
+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV6;
+            break;
+
+        case PROXY_PROTOCOL_V2_AF_INET6 | PROXY_PROTOCOL_V2_TP_DGRAM:
+            msg(M_DEBUG, "PROXY protocol v2: UDP over IPv6");
+            proxy_protocol_set_addr(ppi, version, AF_INET6, SOCK_DGRAM,
+                                    header.v2.addr.ip6.src_addr,
+                                    header.v2.addr.ip6.dst_addr,
+                                    header.v2.addr.ip6.src_port,
+                                    header.v2.addr.ip6.dst_port);
+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV6;
+            break;
+
+        case PROXY_PROTOCOL_V2_AF_UNIX | PROXY_PROTOCOL_V2_TP_STREAM:
+            msg(M_DEBUG, "PROXY protocol v2: AF_UNIX stream");
+            proxy_protocol_set_addr(ppi, version, AF_UNIX, SOCK_STREAM,
+                                    header.v2.addr.unx.src_addr,
+                                    header.v2.addr.unx.dst_addr, 0, 0);
+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_UNIX;
+            break;
+
+        case PROXY_PROTOCOL_V2_AF_UNIX | PROXY_PROTOCOL_V2_TP_DGRAM:
+            msg(M_DEBUG, "PROXY protocol v2: AF_UNIX datagram");
+            proxy_protocol_set_addr(ppi, version, AF_UNIX, SOCK_DGRAM,
+                                    header.v2.addr.unx.src_addr,
+                                    header.v2.addr.unx.dst_addr, 0, 0);
+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_UNIX;
+            break;
+
+        default:
+            msg(M_DEBUG, "PROXY protocol v2: UNSPEC or unknown address fam=
ily");
+            parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;
+            break;
+    }
+    return (int)(pos + sizeof(header.v2.len) + addr_len);
+}
+
+bool
+proxy_protocol_parse(struct proxy_protocol_info *ppi, const struct buffer =
*buf)
+{
+    const proxy_protocol_version_t version =3D proxy_protocol_version(BPTR=
(buf), BLEN(buf));
+
+    header_len =3D BLEN(buf);
+    memcpy(&header, BPTR(buf), header_len);
+
+    switch (version)
+    {
+        case PROXY_PROTOCOL_VERSION_2:
+        {
+            if ((header.v2.ver_cmd & PROXY_PROTOCOL_V2_VER_MASK) =3D=3D PR=
OXY_PROTOCOL_V2_VER)
+            {
+                proxy_protocol_parse_v2(ppi);
+                if (parsing_state =3D=3D PROXY_PROTOCOL_PARSING_STATE_IGNO=
RE)
+                {
+                    msg(M_DEBUG, "PROXY protocol v2: ignoring header");
+                    return true;
+                }
+                else if (parsing_state =3D=3D PROXY_PROTOCOL_PARSING_STATE=
_INVALID)
+                {
+                    return false;
+                }
+                msg(M_DEBUG, "PROXY protocol v2: header parsed");
+                return true;
+            }
+            else
+            {
+                msg(M_NONFATAL, "PROXY protocol v2: expected version 2, go=
t %d",
+                    header.v2.ver_cmd & PROXY_PROTOCOL_V2_VER_MASK);
+                return false;
+            }
+        }
+
+        case PROXY_PROTOCOL_VERSION_1:
+            msg(M_DEBUG, "PROXY protocol header v1: %.*s", BLEN(buf) - 2, =
header.v1.line);
+            return proxy_protocol_parse_v1(ppi, header.v1.line, BLEN(buf));
+
+        default:
+            return false;
+    }
+}
+
+void
+proxy_protocol_free(struct proxy_protocol_info *ppi)
+{
+    gc_free(&ppi->gc);
+}
diff --git a/src/openvpn/proxy_protocol.h b/src/openvpn/proxy_protocol.h
new file mode 100644
index 0000000..8e9af03
--- /dev/null
+++ b/src/openvpn/proxy_protocol.h
@@ -0,0 +1,165 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef PROXY_PROTOCOL_H
+#define PROXY_PROTOCOL_H
+
+#include "buffer.h"
+#include "openvpn.h"
+#include "socket.h"
+
+#include <stdbool.h>
+#include <stdint.h>
+
+/* https://www.haproxy.org/download/1.8/doc/proxy-protocol.txt */
+
+#define PROXY_PROTOCOL_V1_SIG          "PROXY"
+#define PROXY_PROTOCOL_V1_SIG_LEN      5
+#define PROXY_PROTOCOL_V1_MIN_HDR_LEN  8
+#define PROXY_PROTOCOL_V1_LINE_MAX_LEN 108
+
+#define PROXY_PROTOCOL_V2_SIG         "\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x5=
5\x49\x54\x0A"
+#define PROXY_PROTOCOL_V2_SIG_LEN     12
+#define PROXY_PROTOCOL_V2_MIN_HDR_LEN 16
+
+#define PROXY_PROTOCOL_V2_VER_MASK 0xF0
+#define PROXY_PROTOCOL_V2_VER      (0x2 << 4)
+
+#define PROXY_PROTOCOL_V2_CMD_MASK  0x0F
+#define PROXY_PROTOCOL_V2_LOCAL_CMD (0x0 << 0)
+#define PROXY_PROTOCOL_V2_PROXY_CMD (0x1 << 0)
+
+#define PROXY_PROTOCOL_V2_AF_MASK   0xF0
+#define PROXY_PROTOCOL_V2_AF_UNSPEC (0x0 << 4)
+#define PROXY_PROTOCOL_V2_AF_INET   (0x1 << 4)
+#define PROXY_PROTOCOL_V2_AF_INET6  (0x2 << 4)
+#define PROXY_PROTOCOL_V2_AF_UNIX   (0x3 << 4)
+
+#define PROXY_PROTOCOL_V2_TP_MASK   0x0F
+#define PROXY_PROTOCOL_V2_TP_UNSPEC (0x0 << 0)
+#define PROXY_PROTOCOL_V2_TP_STREAM (0x1 << 0)
+#define PROXY_PROTOCOL_V2_TP_DGRAM  (0x2 << 0)
+
+typedef enum
+{
+    PROXY_PROTOCOL_VERSION_INVALID =3D -1,
+
+    PROXY_PROTOCOL_VERSION_UNKNOWN =3D 0,
+    PROXY_PROTOCOL_VERSION_1,
+    PROXY_PROTOCOL_VERSION_2,
+} proxy_protocol_version_t;
+
+/* HAProxy PROXY protocol header */
+typedef union
+{
+    struct
+    {
+        char line[PROXY_PROTOCOL_V1_LINE_MAX_LEN];
+    } v1;
+    struct
+    {
+        uint8_t sig[PROXY_PROTOCOL_V2_SIG_LEN];
+        uint8_t ver_cmd;
+        uint8_t fam;
+        uint16_t len;
+        union
+        {
+            struct
+            {
+                uint32_t src_addr;
+                uint32_t dst_addr;
+                uint16_t src_port;
+                uint16_t dst_port;
+            } ip4;
+            struct
+            {
+                uint8_t src_addr[16];
+                uint8_t dst_addr[16];
+                uint16_t src_port;
+                uint16_t dst_port;
+            } ip6;
+            struct
+            {
+                uint8_t src_addr[108];
+                uint8_t dst_addr[108];
+            } unx;
+        } addr;
+    } v2;
+} proxy_protocol_header_t;
+
+struct proxy_protocol_info
+{
+    struct gc_arena gc;
+
+    proxy_protocol_version_t version;
+    int sock_type;
+    struct openvpn_sockaddr src;
+    struct openvpn_sockaddr dst;
+};
+
+/*
+ * Check if the buffer contains a PROXY protocol header and return the ver=
sion.
+ *
+ * @param buf - The buffer to check.
+ * @param buf_len - The length of the buffer.
+ *
+ * @return - The PROXY protocol version or PROXY_PROTOCOL_VERSION_INVALID =
if
+ *          the buffer does not contain a valid PROXY protocol header.
+ */
+proxy_protocol_version_t
+proxy_protocol_version(const uint8_t *buf, int buf_len);
+
+/*
+ * Get the length of the PROXY protocol header.
+ *
+ * @param buf - The buffer to check.
+ * @param buf_len - The length of the buffer.
+ * @param version - The PROXY protocol version.
+ *
+ * @return - The length of the header or -1 if the header is partial or in=
valid.
+ */
+int
+proxy_protocol_header_len(const uint8_t *buf, int len,
+                          proxy_protocol_version_t version);
+
+/*
+ * Parse the PROXY protocol header.
+ *
+ * @param ppi - The proxy protocol info structure to store the parsed data.
+ * @param buf - The buffer containing the header.
+ * @param version - The version of the PROXY protocol.
+ *
+ * @return - true if the header was successfully parsed.
+ */
+bool
+proxy_protocol_parse(struct proxy_protocol_info *ppi, const struct buffer =
*buf);
+
+/*
+ * Free the allocated memory.
+ *
+ * @param ppi - The proxy protocol info structure.
+ */
+void
+proxy_protocol_free(struct proxy_protocol_info *ppi);
+
+#endif /* PROXY_PROTOCOL_H */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 17c5e76..7fb382c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -39,6 +39,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "forward.h"
+#include "proxy_protocol.h"

 #include "memdbg.h"

@@ -2680,10 +2681,20 @@

         if (sb->len < 1 || sb->len > sb->maxlen)
         {
-            msg(M_WARN, "WARNING: Bad encapsulated packet length from peer=
 (%d), which must be > 0 and <=3D %d -- please ensure that --tun-mtu or --l=
ink-mtu is equal on both peers -- this condition could also indicate a poss=
ible active attack on the TCP link -- [Attempting restart...]", sb->len, sb=
->maxlen);
-            stream_buf_reset(sb);
-            sb->error =3D true;
-            return false;
+            /* check if it's a PROXY protocol header */
+
+            /* undo the reading of net_size */
+            ASSERT(buf_prepend(&sb->buf, sizeof(net_size)));
+            const proxy_protocol_version_t pp_version =3D proxy_protocol_v=
ersion(BPTR(&sb->buf), BLEN(&sb->buf));
+            const int pp_len =3D proxy_protocol_header_len(BPTR(&sb->buf),=
 BLEN(&sb->buf), pp_version);
+            if (pp_version <=3D 0 || pp_len < 0 || pp_len > sb->buf.len)
+            {
+                msg(M_WARN, "WARNING: Bad encapsulated packet length from =
peer (%d), which must be > 0 and <=3D %d -- please ensure that --tun-mtu or=
 --link-mtu is equal on both peers -- this condition could also indicate a =
possible active attack on the TCP link -- [Attempting restart...]", sb->len=
, sb->maxlen);
+                stream_buf_reset(sb);
+                sb->error =3D true;
+                return false;
+            }
+            sb->len =3D pp_len;
         }
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac
Gerrit-Change-Number: 685
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--mPTQdSu9amM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add support for HAProxy&#39;s PROXY protocol<br><br>The PROXY=
 protocol is a simple protocol that can be used to<br>communicate connectio=
n information such as a client&#39;s address across<br>multiple layers of N=
AT or TCP proxies. This commit adds support for<br>the parsing of the v1 an=
d v2 PROXY protocol header but does not yet<br>parse the TLV data in the v2=
 header.<br><br>Check if a PROXY protocol header was sent by the client at =
the<br>beginning of the connection. If so, parse it, store the extracted<br=
>informations and replace the proxy address with the real client<br>address=
. Checking for the header is done only if the packet has an<br>invalid leng=
th so that there&#39;s minimal overhead for the common case.<br><br>Also ad=
d a small document file showing how to configure HAProxy to<br>test the fea=
ture.<br><br>Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac<br>Signed=
-off-by: Ralf Lici &lt;ralflici95@...277...&gt;<br>---<br>M CMakeLists.txt<=
br>A doc/proxy-protocol.txt<br>M src/openvpn/Makefile.am<br>M src/openvpn/i=
nit.c<br>M src/openvpn/multi.c<br>M src/openvpn/openvpn.h<br>A src/openvpn/=
proxy_protocol.c<br>A src/openvpn/proxy_protocol.h<br>M src/openvpn/socket.=
c<br>9 files changed, 895 insertions(+), 7 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/685/1</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index ad620fa..67cfd=
08 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeL=
ists.txt</span><br><span>@@ -490,6 +490,8 @@</span><br><span>     src/openv=
pn/proto.h</span><br><span>     src/openvpn/proxy.c</span><br><span>     sr=
c/openvpn/proxy.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/proxy_protocol.c</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    src/openvpn/proxy_protocol.h</span><br><span>     src/openvp=
n/ps.c</span><br><span>     src/openvpn/ps.h</span><br><span>     src/openv=
pn/push.c</span><br><span>diff --git a/doc/proxy-protocol.txt b/doc/proxy-p=
rotocol.txt</span><br><span>new file mode 100644</span><br><span>index 0000=
000..bd9b606</span><br><span>--- /dev/null</span><br><span>+++ b/doc/proxy-=
protocol.txt</span><br><span>@@ -0,0 +1,157 @@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+HAProxy PROXY protocol support for OpenVPN</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The PROXY p=
rotocol is a simple protocol that can be used to retreive the</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+original source address of a conn=
ection that has been proxied. Every connection</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+is prepended with a header reporting the client =
IP address and port. The</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+protocol specification is available at:</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+https://www.haproxy.org/download/2.4/doc/proxy-pro=
tocol.txt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+Currently there are two versi=
ons of the protocol, a text based version (v1) and</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+a binary version (v2).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+Version 1</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+---------</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+The text based version i=
s a human readable protocol that is easy to debug. It</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+consists of a single line of text with th=
e following fields:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+PROXY_SIGNATURE_V1 =
+ single space + INET_PROTOCOL + single space + CLIENT_IP +</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+single space + PROXY_IP + single sp=
ace + CLIENT_PORT + single space +</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+PROXY_PORT + &quot;\r\n&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+The only supported INET_PROTOCOL in version 1 are &quot;TCP4&quot; an=
d &quot;TCP6&quot;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Version 2</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+---------</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+The binary version is a more efficient protocol that is mo=
re suitable for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prod=
uction use. It consists of a fixed length header followed by the original</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+connection data.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+A PROXY Protocol binary header for a IPv4=
 incoming address has the format:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ 0               1               2               3</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6=
 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|             =
                                                  |</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">++                                        =
                       +</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+|                  Proxy Protocol v2 Signature                  |</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">++                       =
                                        +</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+|                                                    =
           |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+|Version|Command|   AF  | Proto.|   =
      Address Length        |</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|                  =
    IPv4 Source Address                      |</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+| =
                   IPv4 Destination Address                   |</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+|          Source Port          |        Destination Port   =
    |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+|                                        =
                       |</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">++                                                               +</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">++                       =
       TLVs                             +</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">++                                                    =
           +</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|      =
                                                         |</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+A PROXY P=
rotocol binary header for a IPv6 incoming address has the format:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ 0               1           =
    2               3</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+|                                                        =
       |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++          =
                                                     +</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+|                  Proxy Protocol v2 Sig=
nature                  |</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">++                                                               +</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+|                      =
                                         |</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|Versi=
on|Command|   AF  | Proto.|         Address Length        |</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+|                                                               =
|</span><br><span style=3D"color: hsl(120, 100%, 40%);">++                 =
                                              +</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+|                                              =
                 |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++=
                      IPv6 Source Address                      +</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+|                             =
                                  |</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">++                                                          =
     +</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|            =
                                                   |</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+|                                                               |</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">++                       =
                                        +</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+|                                                    =
           |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++      =
              IPv6 Destination Address                   +</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+|                                   =
                            |</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">++                                                               +=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|                  =
                                             |</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+| =
         Source Port          |        Destination Port       |</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+|                                                           =
    |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++             =
                                                  +</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">++                              TLVs      =
                       +</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">++                                                               +</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+|                       =
                                        |</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+The fields are as follows:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+- Proxy Protocol v2 Signature: 12 byte=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The v2 signature=
 of the protocol: &quot;\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\x49\x54\x0A\x2=
0&quot;.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+- Version: 4 bits</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  The version of the PROXY proto=
col (0x2).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+- Command: 4 bits</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  The command of the PROXY pro=
tocol can by one of the following:</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    - LOCAL: 0x0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      The connection was initiated by the proxy.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    - PROXY: 0x1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      The connection was initiated by=
 the client.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+- AF: 4 bits</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    The address family of the con=
nection can be: AF_UNSPEC (0x0), AF_INET (0x1),</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    AF_INET6 (0x2) or AF_UNIX (0x3).</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+- Proto: 4 bits</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    The protocol of the connection can be: UNSPEC (0x=
0), STREAM (0x1) or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    DGRAM (0x2).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+- Address Length: 16 b=
its</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The length o=
f the rest of the header in bytes.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Fina=
lly there may be a series of TLVs (Type-Length-Value) that can be used to</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+carry additional info=
rmation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN testing</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+---------------</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+Currently only TCP is supported. To test the PROXY protoc=
ol support in OpenVPN,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+you can use HAProxy as a proxy with a configuration like this:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+global</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    log stdout format raw local0</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    log 127.0.0.1 local0 debug</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    daemon</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+defaults</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   log     global</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  mode    tcp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    op=
tion  tcplog</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tim=
eout connect 5000ms</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    timeout client  50000ms</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    timeout server  50000ms</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fro=
ntend openvpn_front</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    bind 10.10.20.1:1195</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    default_backend openvpn_back</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ackend openvpn_back</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    server openvpn_server 10.10.10.1:1194 send-proxy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    # server openvpn_server 10.10.10.1:11=
94 send-proxy-v2 proxy-v2-options ssl,cert-cn,ssl-cipher,cert-sig,cert-key,=
authority,crc32c,unique-id</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+You can use the commented line =
to test the binary format and the TLV data.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+Note that you should set the keepalive option so that the connection i=
s not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset by HAPro=
xy for inactivity.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+The OpenVPN TCP serv=
er should read and parse the header and use the information</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+to display the original source addr=
ess in the logs.</span><br><span>diff --git a/src/openvpn/Makefile.am b/src=
/openvpn/Makefile.am</span><br><span>index 56cce9d..fc037ca 100644</span><b=
r><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Mak=
efile.am</span><br><span>@@ -111,6 +111,7 @@</span><br><span> 	pool.c pool.=
h \</span><br><span> 	proto.c proto.h \</span><br><span> 	proxy.c proxy.h \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	proxy_protocol.c p=
roxy_protocol.h \</span><br><span> 	ps.c ps.h \</span><br><span> 	push.c pu=
sh.h \</span><br><span> 	pushlist.h \</span><br><span>diff --git a/src/open=
vpn/init.c b/src/openvpn/init.c</span><br><span>index a49e563..cbce217 1006=
44</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openv=
pn/init.c</span><br><span>@@ -54,6 +54,7 @@</span><br><span> #include &quot=
;mss.h&quot;</span><br><span> #include &quot;mudp.h&quot;</span><br><span> =
#include &quot;dco.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#include &quot;proxy_protocol.h&quot;</span><br><span> </span><br><s=
pan> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -68=
0,6 +681,11 @@</span><br><span>         c-&gt;c1.socks_proxy =3D NULL;</spa=
n><br><span>         c-&gt;c1.socks_proxy_owned =3D false;</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt=
;c1.proxy_protocol)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        proxy_=
protocol_free(c-&gt;c1.proxy_protocol);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c-&gt;c1.proxy_protocol =3D NULL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><b=
r><span> </span><br><span> static void</span><br><span>@@ -4774,7 +4780,7 @=
@</span><br><span>         /* free up environmental variable store */</span=
><br><span>         do_env_set_destroy(c);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /* close HTTP or SOCKS proxy=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* close=
 HTTP or SOCKS proxy or PROXY protocol object */</span><br><span>         u=
ninit_proxy(c);</span><br><span> </span><br><span>         /* garbage colle=
ct */</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.=
c</span><br><span>index 03177bb..ac4652d 100644</span><br><span>--- a/src/o=
penvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@=
 -51,6 +51,7 @@</span><br><span> #include &quot;ssl_util.h&quot;</span><br>=
<span> #include &quot;dco.h&quot;</span><br><span> #include &quot;reflect_f=
ilter.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;proxy_protocol.h&quot;</span><br><span> </span><br><span> /*#defin=
e MULTI_DEBUG_EVENT_LOOP*/</span><br><span> </span><br><span>@@ -779,6 +780=
,8 @@</span><br><span>         goto err;</span><br><span>     }</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ=
_CLEAR(mi-&gt;context.c1.proxy_protocol, struct proxy_protocol_info);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     mi-=
&gt;context.c2.tls_multi-&gt;multi_state =3D CAS_NOT_CONNECTED;</span><br><=
span> </span><br><span>     if (hash_n_elements(m-&gt;hash) &gt;=3D m-&gt;m=
ax_clients)</span><br><span>@@ -3207,6 +3210,57 @@</span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+multi_replace_proxy_addr(struct multi_context *m, struct=
 multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mroute=
_addr real =3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (!mroute_extract_openvpn_sockaddr(&amp;real, &amp;mi=
-&gt;context.c1.proxy_protocol-&gt;src, true))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uint32_t hv=
 =3D hash_value(hash, &amp;real);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* if the new address is already in t=
he hash table, the new client takes precedence */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct hash_element *he =3D hash_lookup_f=
ast(hash, bucket, &amp;real, hv);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (he)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct multi_instance *oldmi =3D (struct multi_instance *) he-&gt;value;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LO=
W, &quot;Client&#39;s real address (behind proxy) matches &quot;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;existing cli=
ent address -- new client takes precedence&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        oldmi-&gt;did_real_hash =3D false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        multi_close_i=
nstance(m, oldmi, false);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        he-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        he-&gt;value =3D mi;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    clear_prefix();</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(D_MULTI_LOW, &quot;Replacing proxy address: %s with client&#39;s=
 real address: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        mroute_addr_print(&amp;real,=
 &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* remove proxy address=
 from hash table before changing address */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_=
remove(m-&gt;iter, &amp;mi-&gt;real));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    mi-&gt;real =3D real;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    generate_prefix(mi);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(hash_add(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m-&gt;iter, &amp;mi-=
&gt;real, mi, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MA=
NAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
hash_add(m-&gt;cid_hash, &amp;mi-&gt;context.c2.mda_context.cid, mi, true))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> /*</span><br><span>  * Called when an instance should be close=
d due to the</span><br><span>  * reception of a soft signal.</span><br><spa=
n>@@ -3348,6 +3402,7 @@</span><br><span>     struct mroute_addr src, dest;<=
/span><br><span>     unsigned int mroute_flags;</span><br><span>     struct=
 multi_instance *mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct link_socket_info *lsi;</span><br><span>     bool ret =3D true;<=
/span><br><span>     bool floated =3D false;</span><br><span> </span><br><s=
pan>@@ -3387,15 +3442,31 @@</span><br><span>             }</span><br><span>=
         }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        lsi =3D get_link_socket_info(c);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* check for PROXY protocol */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (lsi-&gt;proto =3D=3D PROTO_TCP_SE=
RVER &amp;&amp; !c-&gt;c1.proxy_protocol-&gt;version &amp;&amp; BLEN(&amp;c=
-&gt;c2.buf) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (!proxy_protocol_parse(c-&gt;c1.proxy_protocol, &amp;c-&gt;c2.buf))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                /* set vers=
ion to invalid to avoid checking again */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                c-&gt;c1.proxy_protocol-&gt;version =
=3D PROXY_PROTOCOL_VERSION_INVALID;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                multi_replace_proxy_addr(m, m-&gt;pending);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* avoid processin=
g the packet as an openvpn one */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                buf_reset_len(&amp;c-&gt;c2.buf);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>         if (BLEN(&amp;c-&gt;c=
2.buf) &gt; 0)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            struct link_socket_info *lsi;</span><br><sp=
an>             const uint8_t *orig_buf;</span><br><span> </span><br><span>=
             /* decrypt in instance context */</span><br><span> </span><br>=
<span>             perf_push(PERF_PROC_IN_LINK);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            lsi =3D get_link_socket_info(c);</sp=
an><br><span>             orig_buf =3D c-&gt;c2.buf.data;</span><br><span> =
            if (process_incoming_link_part1(c, lsi, floated))</span><br><sp=
an>             {</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/=
openvpn/openvpn.h</span><br><span>index e98c93e..ded6103 100644</span><br><=
span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.=
h</span><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;pool.h&=
quot;</span><br><span> #include &quot;plugin.h&quot;</span><br><span> #incl=
ude &quot;manage.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;proxy_protocol.h&quot;</span><br><span> </span><br><spa=
n> /*</span><br><span>  * Our global key schedules, packaged thusly</span><=
br><span>@@ -191,6 +192,8 @@</span><br><span>     struct socks_proxy_info *=
socks_proxy;</span><br><span>     bool socks_proxy_owned;</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct proxy_pr=
otocol_info *proxy_protocol;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     /* persist --ifconfig-pool db to file */</sp=
an><br><span>     struct ifconfig_pool_persist *ifconfig_pool_persist;</spa=
n><br><span>     bool ifconfig_pool_persist_owned;</span><br><span>diff --g=
it a/src/openvpn/proxy_protocol.c b/src/openvpn/proxy_protocol.c</span><br>=
<span>new file mode 100644</span><br><span>index 0000000..10a68c2</span><br=
><span>--- /dev/null</span><br><span>+++ b/src/openvpn/proxy_protocol.c</sp=
an><br><span>@@ -0,0 +1,472 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Op=
enVPN -- An application to securely tunnel IP networks</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP por=
t, with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *             session authentication and key exchange,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet enc=
ryption, packet authentication, and</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet compression.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software;=
 you can redistribute it and/or modify</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  it under the terms of the GNU General Public License=
 version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as pu=
blished by the Free Software Foundation.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *  This program is distributed in the hope that it will be useful,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WAR=
RANTY; without even the implied warranty of</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PUR=
POSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  G=
NU General Public License for more details.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  You should have received a copy of the GNU General Public Licens=
e along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with thi=
s program; if not, write to the Free Software Foundation, Inc.,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth F=
loor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;error.h&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;proxy_protocol.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V1_MAX_WOR=
DS 6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_P=
ROTOCOL_V1_MAX_WORD_LEN 40</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    PROXY_PROTOCOL_PARSING_STATE_INVA=
LID =3D -1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROX=
Y_PROTOCOL_PARSING_STATE_OK =3D 0,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    PROXY_PROTOCOL_PARSING_STATE_IGNORE =3D 1,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+} proxy_protocol_parsing_state_t;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static const size_t PROXY_PROTOCOL_V2_=
ADDR_LEN_IPV4 =3D 12;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static const size_t PROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static const size_t PROXY_PROTOCO=
L_V2_ADDR_LEN_UNIX =3D 216;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static prox=
y_protocol_header_t header;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static uint16_t header_len;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+static proxy_protocol_parsing_state_t parsing_state =3D PRO=
XY_PROTOCOL_PARSING_STATE_OK;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_pro=
tocol_version_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+prox=
y_protocol_version(const uint8_t *buf, const int buf_len)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (buf_len &gt;=3D PROXY_PROTOCOL_V2_MIN_HDR_LEN</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; me=
mcmp(buf, PROXY_PROTOCOL_V2_SIG, PROXY_PROTOCOL_V2_SIG_LEN) =3D=3D 0)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return PROXY_PROTOCOL_VERSION_2=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else if (buf_len &gt;=3D PRO=
XY_PROTOCOL_V1_MIN_HDR_LEN</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             &amp;&amp; memcmp(buf, PROXY_PROTOCOL_V1_SIG, PROXY_PRO=
TOCOL_V1_SIG_LEN) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return PROXY_PROTOCOL_VERSION_1;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    return PROXY_PROTOCOL_VERSION_INVALID;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+proxy_protocol_header_len(con=
st uint8_t *buf, const int buf_len,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                          const proxy_protocol_version_t ve=
rsion)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;header, buf, bu=
f_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    switch (version)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        case PROXY_PROTOCOL_VERSION_1:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            char *end =3D memchr(he=
ader.v1.line, &#39;\r&#39;, buf_len - 1);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (!end || end[1] !=3D &#39;\n&#39;)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                return -1; /*=
 partial or invalid header */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            return (int)(end + 2 - header.v1.line);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case PROXY_PROTOCOL_VERSION_2:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return PROXY_PROTOCOL_V2_MIN_HDR_LEN =
+ ntohps(header.v2.len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        defaul=
t:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n -1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Pars=
e a port number from a string.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram port_str - The string to parse.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* @return - The port number or -1 if the string is invalid.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+uint16_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+proxy_protocol_parse_port(const char *port_str)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    char *endptr;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    errno =3D 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   long port =3D strtol(port_str, &amp;endptr, 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (errno !=3D 0 || endptr =3D=3D por=
t_str || *endptr !=3D &#39;\0&#39; || port &lt;=3D 0 || port &gt; 65535)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return (uint16_t)port;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Set the source and d=
estination addresses and ports in the proxy protocol</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * info structure for later use.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param ppi - The proxy protocol info struc=
ture to store the addresses.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param ver - The version of the PROXY protocol.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param fam - The address family =
(supports: AF_INET or AF_INET6).</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param st - The socket type.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param src_addr - The source address.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dst_addr - The dest=
ination address.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param src_port - The source port.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param dst_port - The destination port.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+proxy_protocol_set_addr(struct proxy_protocol_info *ppi,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        const p=
roxy_protocol_version_t ver, const int fam, const int st,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                        const void *s=
rc_addr, const void *dst_addr,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        const uint16_t src_port, const uint16_t =
dst_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ppi-&gt;version =3D ver;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    ppi-&gt;sock_type =3D st;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (fam =3D=3D AF_INET)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        ppi-&gt;src.addr.sa.sa_fam=
ily =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ppi-&gt;dst.addr.sa.sa_family =3D AF_INET;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        memcpy(&amp;ppi-&gt;src.addr.in4.sin_ad=
dr, (uint32_t *)src_addr,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+               sizeof(struct in_addr));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        memcpy(&amp;ppi-&gt;dst.addr.in4.sin_addr=
, (uint32_t *)dst_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+               sizeof(struct in_addr));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        ppi-&gt;src.addr.in4.sin_port =3D src_port;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ppi-&gt;dst=
.addr.in4.sin_port =3D dst_port;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        msg(M_DEBUG, &quot;PROXY protocol: SRC: %s:%u&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            inet_ntoa=
(ppi-&gt;src.addr.in4.sin_addr),</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ntohs(ppi-&gt;src.addr.in4.sin_port));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;PROX=
Y protocol: DST: %s:%u&quot;,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            inet_ntoa(ppi-&gt;dst.addr.in4.sin_addr),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ntohs(ppi-&gt;dst.a=
ddr.in4.sin_port));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (f=
am =3D=3D AF_INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ppi-&g=
t;src.addr.sa.sa_family =3D AF_INET6;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ppi-&gt;dst.addr.sa.sa_family =3D AF_INET6;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;ppi-&=
gt;src.addr.in6.sin6_addr, src_addr, sizeof(struct in6_addr));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;ppi-&gt;dst.=
addr.in6.sin6_addr, dst_addr, sizeof(struct in6_addr));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        ppi-&gt;src.addr.in6.sin6_port =
=3D src_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  ppi-&gt;dst.addr.in6.sin6_port =3D dst_port;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        char ip6_str[INET6_ADDRSTRLEN];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (inet_ntop(AF_INET6, &amp;ppi-&gt;sr=
c.addr.in6.sin6_addr, ip6_str,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                      INET6_ADDRSTRLEN))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol: SRC:=
 %s:%u&quot;, ip6_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                ntohs(ppi-&gt;src.addr.in6.sin6_port));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_NONFATAL, &quot;PROXY protocol: could not par=
se source address&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (inet_ntop(AF_INET6, &amp;ppi-&gt;dst.addr.in6.sin6_addr, ip6_str,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
 INET6_ADDRSTRLEN))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_DEBUG, &quot;PROXY protocol: DST: %s:%u&quot;, ip6_str,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ntohs(ppi-&gt;d=
st.addr.in6.sin6_port));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_NONF=
ATAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  &quot;PROXY protocol: could not parse destination address&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       msg(M_NONFATAL, &quot;PROXY protocol: unsupported address family&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Split=
 the v1 header line into words (space-separated)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param words - The array to store the words.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param line - The header line to=
 split.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param le=
n - The length of the header line.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return - The number of words found or -1 if an error occurred.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+proxy_protocol_v1_split_words(char words[][PROXY_PROTOCOL_V1_M=
AX_WORD_LEN],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                        const char *line,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              int len)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int word_num =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const char *start =3D line;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; len; ++=
i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (line[i] =3D=3D &#39=
; &#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (word_=
num &lt; PROXY_PROTOCOL_V1_MAX_WORDS)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                int word_len =3D (int)(line + i - start);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (word_=
len &lt; PROXY_PROTOCOL_V1_MAX_WORD_LEN)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    memcpy(words[word_num], start, word_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      words[word_num][word_len] =3D &#39;\0&#39;;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    ++word_num;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_NONFATAL, =
&quot;PROXY protocol v1: word too long&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    return -1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            start =3D line + i + 1;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return word_num;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the PROXY protocol v1 =
header line.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ppi - The prox=
y protocol info structure to store the parsed data.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param line - The header line to parse=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param len - Th=
e length of the header line.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn - true if the header was successfully parsed.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pr=
oxy_protocol_parse_v1(struct proxy_protocol_info *ppi,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        const char *line=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const proxy_protoco=
l_version_t version =3D PROXY_PROTOCOL_VERSION_1;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char words[PROXY_PROTOCOL_V1_MAX_WORDS][P=
ROXY_PROTOCOL_V1_MAX_WORD_LEN];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cha=
r *end =3D memchr(line, &#39;\r&#39;, len - 1);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!end || end[1] !=3D &#39;\n&#39;) /* pa=
rtial or invalid header */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    *end =3D &#39; =
&#39;; /* replace CRLF with space for easier splitting */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int size =3D (int)(end - line + 1=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    int word_num =3D proxy_protocol_=
v1_split_words(words, line, size);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (word_num &lt; 3)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        msg(M_NONFATAL, &quot;PROXY protocol v1: could not split head=
er&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(words[1], &quot;UNKNOWN&q=
uot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBU=
G, &quot;PROXY protocol v1: UNKNOWN protocol, ignoring header&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(words[1], &quot;TC=
P4&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
DEBUG, &quot;PROXY protocol v1: TCP4 protocol&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        struct in_addr ip4_src_addr, ip4_=
dst_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (inet_pton(AF_INET, words[2], &amp;ip4_src_addr) !=3D 1)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_NONFATAL,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                &quot;PROXY protocol v1=
: could not parse source address&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (inet_pton(AF_INET, words[3], &amp;ip4_dst_addr=
) !=3D 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_NO=
NFATAL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    &quot;PROXY protocol v1: could not parse destination address&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return fal=
se;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        proxy_protocol_set=
_addr(ppi, version, AF_INET, SOCK_STREAM,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                &amp;ip4_src_addr, &a=
mp;ip4_dst_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                             ntohs(proxy_protocol_parse_port(words[4])),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
          ntohs(proxy_protocol_parse_port(words[5])));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else if (strcmp(words[1], &quot;TCP6&quot;) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;=
PROXY protocol v1: TCP6 protocol&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        struct in6_addr ip6_src_addr, ip6_dst_addr;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (inet_pton(=
AF_INET6, words[2], &amp;ip6_src_addr) !=3D 1)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            msg(M_NONFATAL,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                &quot;PROXY protocol v1: could not=
 parse source address&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            return false;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (inet_pton(AF_INET6, words[3], &amp;ip6_dst_addr) !=3D 1)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_NONFATAL,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                &quot;=
PROXY protocol v1: could not parse destination address&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        proxy_protocol_set_addr(ppi,=
 version, AF_INET6, SOCK_STREAM,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                                &amp;ip6_src_addr, &amp;ip6_ds=
t_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                    ntohs(proxy_protocol_parse_port(words[4])),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 ntohs(proxy_protocol_parse_port(words[5])));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(=
M_NONFATAL, &quot;PROXY protocol v1: unsupported protocol&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the PROXY p=
rotocol v2 header.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ppi - Th=
e proxy protocol info structure to store the parsed data.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param header - The header to pars=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @return - The number of bytes p=
arsed or 0 if the header can be ignored.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_proto=
col_parse_v2(struct proxy_protocol_info *ppi)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t addr_len =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    int pos =3D PROXY_PROTOCOL_V2_SIG_LEN + sizeof(header.v2=
.ver_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 proxy_protocol_version_t version =3D PROXY_PROTOCOL_VERSION_2;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    switch (header.v2.ver_cmd &amp; PROXY_PROTOCOL=
_V2_CMD_MASK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_P=
ROTOCOL_V2_LOCAL_CMD:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /* the receiver must accept this connection as valid and must=
 use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * =
the real connection endpoints and discard the protocol block</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * including the famil=
y which is ignored */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_DEBUG, &quot;PROXY protocol v2: LOCAL command&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            parsing_s=
tate =3D PROXY_PROTOCOL_PARSING_STATE_IGNORE;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        case PROXY_PROTOCOL_V2_PROXY_CMD:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v=
2: PROXY command&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default=
:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_=
DEBUG, &quot;PROXY protocol v2: UNSPEC or unknown command&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            parsing_state =3D=
 PROXY_PROTOCOL_PARSING_STATE_INVALID;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (parsin=
g_state !=3D PROXY_PROTOCOL_PARSING_STATE_OK)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        return pos;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  pos +=3D sizeof(header.v2.fam);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
witch (header.v2.fam)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case=
 PROXY_PROTOCOL_V2_AF_INET | PROXY_PROTOCOL_V2_TP_STREAM:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY =
protocol v2: TCP over IPv4.&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            proxy_protocol_set_addr(ppi, version, AF_INET, =
SOCK_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                             &amp;header.v2.addr.ip4.src_addr,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                                =
    &amp;header.v2.addr.ip4.dst_addr,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                    header.v2.addr.ip4.sr=
c_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                        header.v2.addr.ip4.dst_port);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            addr_len =3D PROXY_PROTOCOL_V=
2_ADDR_LEN_IPV4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PROT=
OCOL_V2_AF_INET | PROXY_PROTOCOL_V2_TP_DGRAM:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2:=
 UDP over IPv4&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            proxy_protocol_set_addr(ppi, version, AF_INET, SOCK_DGRAM,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
               &amp;header.v2.addr.ip4.src_addr,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                    &amp;heade=
r.v2.addr.ip4.dst_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                    header.v2.addr.ip4.src_port,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
          header.v2.addr.ip4.dst_port);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV=
4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PROTOCOL_V2_AF_INE=
T6 | PROXY_PROTOCOL_V2_TP_STREAM:</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2: TCP over IP=
v6&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   proxy_protocol_set_addr(ppi, version, AF_INET6, SOCK_STREAM,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
     header.v2.addr.ip6.src_addr,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                    header.v2.addr.ip6.dst_ad=
dr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                    header.v2.addr.ip6.src_port,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                                    header.v2.=
addr.ip6.dst_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV6;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        case PROXY_PROTOCOL_V2_AF_INET6 | PROXY_PROTOCOL_=
V2_TP_DGRAM:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     msg(M_DEBUG, &quot;PROXY protocol v2: UDP over IPv6&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            proxy_protocol_set=
_addr(ppi, version, AF_INET6, SOCK_DGRAM,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                    header.v2.addr.ip=
6.src_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                            header.v2.addr.ip6.dst_addr,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                    he=
ader.v2.addr.ip6.src_port,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                    header.v2.addr.ip6.dst_port);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr_len =
=3D PROXY_PROTOCOL_V2_ADDR_LEN_IPV6;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     case PROXY_PROTOCOL_V2_AF_UNIX | PROXY_PROTOCOL_V2_TP_STREAM:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &qu=
ot;PROXY protocol v2: AF_UNIX stream&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            proxy_protocol_set_addr(ppi, version, =
AF_UNIX, SOCK_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                    header.v2.addr.unx.src_addr,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
        header.v2.addr.unx.dst_addr, 0, 0);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN=
_UNIX;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            b=
reak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PROTOCOL_V2_AF=
_UNIX | PROXY_PROTOCOL_V2_TP_DGRAM:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2: AF_UNIX d=
atagram&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        proxy_protocol_set_addr(ppi, version, AF_UNIX, SOCK_DGRAM,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
        header.v2.addr.unx.src_addr,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                    header.v2.addr.unx.dst=
_addr, 0, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      addr_len =3D PROXY_PROTOCOL_V2_ADDR_LEN_UNIX;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2: UNSPEC or unk=
nown address family&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            parsing_state =3D PROXY_PROTOCOL_PARSING_STATE_INVALID;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return (int)(pos + sizeof(head=
er.v2.len) + addr_len);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+proxy_protocol_parse(struct proxy_protocol_info =
*ppi, const struct buffer *buf)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst proxy_protocol_version_t version =3D proxy_protocol_version(BPTR(buf), =
BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    header_len =3D BLEN(buf=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(&amp;h=
eader, BPTR(buf), header_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swit=
ch (version)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case PROXY_PR=
OTOCOL_VERSION_2:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if ((header.v2.ver_cmd &amp; PROXY_PROTOCOL_V2_VER_MASK) =3D=3D PROXY_PROTO=
COL_V2_VER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  proxy_protocol_parse_v2(ppi);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (parsing_state =3D=3D PROXY_PROTOCOL_PARSING=
_STATE_IGNORE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             msg(M_DEBUG, &quot;PROXY protocol v2: ignoring header&quot;);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       else if (parsing_state =3D=3D PROXY_PROTOCOL_PARSING_STATE_INVALID)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      msg(M_DEBUG, &quot;PROXY protocol v2: header parsed&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                return true;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                msg(M_NONFATAL, &qu=
ot;PROXY protocol v2: expected version 2, got %d&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    header.v2.ver_cmd &=
amp; PROXY_PROTOCOL_V2_VER_MASK);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                return false;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cas=
e PROXY_PROTOCOL_VERSION_1:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            msg(M_DEBUG, &quot;PROXY protocol header v1: %.*s&quot;=
, BLEN(buf) - 2, header.v1.line);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return proxy_protocol_parse_v1(ppi, header.v1.lin=
e, BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        default:</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_protoc=
ol_free(struct proxy_protocol_info *ppi)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    gc_free(&amp;ppi-&gt;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+}</span><br><span>diff --git a/src/openvpn/proxy_protocol.h b/=
src/openvpn/proxy_protocol.h</span><br><span>new file mode 100644</span><br=
><span>index 0000000..8e9af03</span><br><span>--- /dev/null</span><br><span=
>+++ b/src/openvpn/proxy_protocol.h</span><br><span>@@ -0,0 +1,165 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely=
 tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             over a single TCP/UDP port, with support for SSL/TLS-based</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessio=
n authentication and key exchange,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *             packet encryption, packet authentication, and=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pack=
et compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 200=
2-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  This program is free software; you can redistribute it and/or mod=
ify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the=
 terms of the GNU General Public License version 2</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Founda=
tion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed=
 in the hope that it will be useful,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied war=
ranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more =
details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received=
 a copy of the GNU General Public License along</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Fre=
e Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef PROXY_PROTOCOL_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &quot;buffer.h&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#include &quot;openvpn.h&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;socket.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &lt;stdint.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* https://www.haproxy.org/download/1.8/doc/proxy-protocol.t=
xt */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V1_SIG    =
      &quot;PROXY&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define PROXY_PROTOCOL_V1_SIG_LEN      5</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V1_MIN_HDR_LEN  8</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V1_LIN=
E_MAX_LEN 108</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2=
_SIG         &quot;\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\x49\x54\x0A&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCO=
L_V2_SIG_LEN     12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define PROXY_PROTOCOL_V2_MIN_HDR_LEN 16</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define PROXY_PROTOCOL_V2_VER_MASK 0xF0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_VER      (0x2 &lt;&lt; 4)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_CMD_MASK  0x0F=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTO=
COL_V2_LOCAL_CMD (0x0 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define PROXY_PROTOCOL_V2_PROXY_CMD (0x1 &lt;&lt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_AF_MASK   0xF0</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_=
AF_UNSPEC (0x0 &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define PROXY_PROTOCOL_V2_AF_INET   (0x1 &lt;&lt; 4)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_AF_INET6 =
 (0x2 &lt;&lt; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine PROXY_PROTOCOL_V2_AF_UNIX   (0x3 &lt;&lt; 4)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#define PROXY_PROTOCOL_V2_TP_MASK   0x0F</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_TP_UNSPEC (0x0 =
&lt;&lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
PROXY_PROTOCOL_V2_TP_STREAM (0x1 &lt;&lt; 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define PROXY_PROTOCOL_V2_TP_DGRAM  (0x2 &lt;&lt; =
0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef enum</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    PROXY_PROTOCOL_VERSION_INVALID =3D -1,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    PROXY_PROTOCOL_VERSION_UNKNOWN =3D 0,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    PROXY_PROTOCOL_VERSION_1,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    PROXY_PROTOCOL_VERS=
ION_2,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} proxy_proto=
col_version_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* HAProxy PROXY protoco=
l header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
union</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        char line[PROXY_PROTOCOL_V1_LINE_MAX_LEN];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    } v1;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    struct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        uint8_t sig[PROXY_PROTOCOL_V2_SIG_LEN];</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t ver_cmd;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t fam;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t len;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        union</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            struct</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                uint32_t src_addr;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                uint32_t d=
st_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     uint16_t src_port;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                uint16_t dst_port;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            } ip4;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            struct</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                uint8_t src_addr[16];</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                uint8_t dst_addr[16];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                uint16_t src=
_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   uint16_t dst_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            } ip6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          uint8_t src_addr[108];</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                uint8_t dst_addr[108];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            } unx;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        } addr;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    } v2;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+} proxy_protocol_header_t;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+struct proxy_protocol_info</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct gc_arena gc;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    proxy_protocol=
_version_t version;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int sock_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct openvpn_sockaddr src;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct openvpn_sockaddr dst;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if the buffer conta=
ins a PROXY protocol header and return the version.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf - The buffer to check.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf_len - The length of the buf=
fer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return - The PROXY protocol =
version or PROXY_PROTOCOL_VERSION_INVALID if</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *          the buffer does not contain a valid PR=
OXY protocol header.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_protocol_=
version_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+proxy_prot=
ocol_version(const uint8_t *buf, int buf_len);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get th=
e length of the PROXY protocol header.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @param buf - The buffer to check.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param buf_len - The length of the buffer.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param version - The PROXY =
protocol version.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return - The le=
ngth of the header or -1 if the header is partial or invalid.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+proxy_protocol_header_len(const uint8_t *buf, int len,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                          prox=
y_protocol_version_t version);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the PROXY protoc=
ol header.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ppi - The proxy =
protocol info structure to store the parsed data.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * @param buf - The buffer containing the hea=
der.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param versi=
on - The version of the PROXY protocol.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * @return - true if the header was successfully parsed.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+proxy_protocol_parse(struct proxy_protocol_info *ppi, const struct=
 buffer *buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Free the allocated memory.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * @param ppi - The proxy protocol info structur=
e.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+proxy_protocol_free(struct proxy_protocol_info *=
ppi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* PROXY_PROTOCOL_H */</sp=
an><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span=
><br><span>index 17c5e76..7fb382c 100644</span><br><span>--- a/src/openvpn/=
socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -39,=
6 +39,7 @@</span><br><span> #include &quot;manage.h&quot;</span><br><span> =
#include &quot;openvpn.h&quot;</span><br><span> #include &quot;forward.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;p=
roxy_protocol.h&quot;</span><br><span> </span><br><span> #include &quot;mem=
dbg.h&quot;</span><br><span> </span><br><span>@@ -2680,10 +2681,20 @@</span=
><br><span> </span><br><span>         if (sb-&gt;len &lt; 1 || sb-&gt;len &=
gt; sb-&gt;maxlen)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: Bad encapsul=
ated packet length from peer (%d), which must be &gt; 0 and &lt;=3D %d -- p=
lease ensure that --tun-mtu or --link-mtu is equal on both peers -- this co=
ndition could also indicate a possible active attack on the TCP link -- [At=
tempting restart...]&quot;, sb-&gt;len, sb-&gt;maxlen);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            stream_buf_reset(sb);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            sb-&gt;error =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            retu=
rn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  /* check if it&#39;s a PROXY protocol header */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            /* undo the reading of net_size */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            ASSERT(buf_prepend(&amp;s=
b-&gt;buf, sizeof(net_size)));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            const proxy_protocol_version_t pp_version =3D proxy_=
protocol_version(BPTR(&amp;sb-&gt;buf), BLEN(&amp;sb-&gt;buf));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            const int pp_len =
=3D proxy_protocol_header_len(BPTR(&amp;sb-&gt;buf), BLEN(&amp;sb-&gt;buf),=
 pp_version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (pp_version &lt;=3D 0 || pp_len &lt; 0 || pp_len &gt; sb-&gt;buf.l=
en)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(M_=
WARN, &quot;WARNING: Bad encapsulated packet length from peer (%d), which m=
ust be &gt; 0 and &lt;=3D %d -- please ensure that --tun-mtu or --link-mtu =
is equal on both peers -- this condition could also indicate a possible act=
ive attack on the TCP link -- [Attempting restart...]&quot;, sb-&gt;len, sb=
-&gt;maxlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          stream_buf_reset(sb);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                sb-&gt;error =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                return false;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            sb-&gt;len =3D pp_len;</span=
><br><span>         }</span><br><span>     }</span><br><span> </span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/685?usp=3Demail">change 685</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9766c68feaba71279f26c3310ee=
e4b5ca215e6ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 685 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--mPTQdSu9amM=--

