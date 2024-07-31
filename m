From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Wed, 31 Jul 2024 09:17:02 +0000
In-Reply-To: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
References: <gerrit.1721982049000.I9766c68feaba71279f26c3310eee4b5ca215e6ac@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1689c775e328adc124c42317e060d43d56d6526e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GjFWpEsZD/w="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: Add support for
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

--GjFWpEsZD/w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld, Code-Review-1 by plaisthos


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
test the feature and a unit test for the parsing.

Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac
Signed-off-by: Ralf Lici <ralf@...2726...>
---
M CMakeLists.txt
A doc/haproxy-protocol.txt
M src/openvpn/Makefile.am
A src/openvpn/haproxy_protocol.c
A src/openvpn/haproxy_protocol.h
M src/openvpn/init.c
M src/openvpn/multi.c
M src/openvpn/openvpn.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/test_haproxy_protocol.c
12 files changed, 1,324 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/685/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index ad620fa..e927a01 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -419,6 +419,8 @@
     src/openvpn/fragment.h
     src/openvpn/gremlin.c
     src/openvpn/gremlin.h
+    src/openvpn/haproxy_protocol.c
+    src/openvpn/haproxy_protocol.h
     src/openvpn/helper.c
     src/openvpn/helper.h
     src/openvpn/httpdigest.c
diff --git a/doc/haproxy-protocol.txt b/doc/haproxy-protocol.txt
new file mode 100644
index 0000000..604951a
--- /dev/null
+++ b/doc/haproxy-protocol.txt
@@ -0,0 +1,166 @@
+HAProxy PROXY protocol support for OpenVPN
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+The PROXY protocol is a simple protocol that can be used to retreive the
+original source address of a connection that has been proxied. Every conne=
ction
+is prepended with a header reporting the client IP address and port. This
+document aims to breifly describe the protocol and how it can be tested in
+OpenVPN. For more information about the protocol, see the official
+specification at https://www.haproxy.org/download/2.4/doc/proxy-protocol.t=
xt.
+
+Currently there are two versions of the protocol, a text based version (v1=
) and
+a binary version (v2). Although the binary version is more efficient, the =
text
+based version is still the only version supported by some proxies therefor=
e it
+we support both versions.
+
+The protocol is agnostic to the underlying transport protocol, so it can b=
e used
+with both TCP, UDP and UNIX sockets but currently only TCP is supported by
+OpenVPN.
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
+A PROXY Protocol binary header for an IPv4 incoming address has the format:
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
+  Can by one of the following:
+    - LOCAL: 0x0
+      The connection was initiated by the proxy for health-checks or simil=
ar.
+      This command is not supported and therefore the header is ignored.
+    - PROXY: 0x1
+      The connection was initiated by the client.
+
+- AF: 4 bits
+    The address family of the connection can be: AF_UNSPEC (0x0), AF_INET =
(0x1),
+    AF_INET6 (0x2) or AF_UNIX (0x3). Only AF_INET and AF_INET6 are support=
ed.
+
+- Proto: 4 bits
+    The protocol of the connection can be: UNSPEC (0x0), STREAM (0x1) or
+    DGRAM (0x2). Only STREAM is supported.
+
+- Address Length: 16 bits
+    The length of the rest of the header in bytes.
+
+Finally there may be additional data arranged as a series of TLV
+(Type-Length-Value) vectors that can be used to carry additional informati=
on.
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
+You can use the commented line to test the binary format and the TLV data
+instead of the text based format.
+
+Note that you should set the keepalive option so that the connection is not
+reset by HAProxy for inactivity (timeout option in the config).
+
+The OpenVPN TCP server should read and parse the header and use the inform=
ation
+to display the original source address in the logs.
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 56cce9d..9dce362 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -65,6 +65,7 @@
 	forward.c forward.h \
 	fragment.c fragment.h \
 	gremlin.c gremlin.h \
+	haproxy_protocol.c haproxy_protocol.h \
 	helper.c helper.h \
 	httpdigest.c httpdigest.h \
 	lladdr.c lladdr.h \
diff --git a/src/openvpn/haproxy_protocol.c b/src/openvpn/haproxy_protocol.c
new file mode 100644
index 0000000..1786d2f
--- /dev/null
+++ b/src/openvpn/haproxy_protocol.c
@@ -0,0 +1,487 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2024 OpenVPN Inc <sales@...515...>
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
+#include "syshead.h"
+
+#include "error.h"
+#include "haproxy_protocol.h"
+
+#define HAPROXY_PROTOCOL_V1_MAX_WORDS 6
+#define HAPROXY_PROTOCOL_V1_MAX_WORD_LEN 40
+
+typedef enum
+{
+    HAPROXY_PROTOCOL_PARSING_STATE_INVALID =3D -1,
+    HAPROXY_PROTOCOL_PARSING_STATE_OK =3D 0,
+    HAPROXY_PROTOCOL_PARSING_STATE_IGNORE =3D 1,
+} haproxy_protocol_parsing_state_t;
+
+static const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;
+static const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6 =3D 36;
+static const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;
+
+static haproxy_protocol_header_t *header =3D NULL;
+static uint16_t header_len =3D 0;
+static haproxy_protocol_parsing_state_t parsing_state =3D HAPROXY_PROTOCOL=
_PARSING_STATE_OK;
+
+haproxy_protocol_version_t
+haproxy_protocol_version(const uint8_t *buf, const int buf_len)
+{
+    if (buf_len >=3D HAPROXY_PROTOCOL_V2_MIN_HDR_LEN
+        && memcmp(buf, HAPROXY_PROTOCOL_V2_SIG, HAPROXY_PROTOCOL_V2_SIG_LE=
N) =3D=3D 0)
+    {
+        return HAPROXY_PROTOCOL_VERSION_2;
+    }
+    else if (buf_len >=3D HAPROXY_PROTOCOL_V1_MIN_HDR_LEN
+             && memcmp(buf, HAPROXY_PROTOCOL_V1_SIG, HAPROXY_PROTOCOL_V1_S=
IG_LEN) =3D=3D 0)
+    {
+        return HAPROXY_PROTOCOL_VERSION_1;
+    }
+    return HAPROXY_PROTOCOL_VERSION_INVALID;
+}
+
+int
+haproxy_protocol_header_len(const uint8_t *buf, const int buf_len,
+                            const haproxy_protocol_version_t version)
+{
+    switch (version)
+    {
+        case HAPROXY_PROTOCOL_VERSION_1:
+        {
+            const char *end =3D memchr(buf, '\r', buf_len - 1);
+            /* partial or invalid header */
+            if (!end || end[1] !=3D '\n')
+            {
+                return -1;
+            }
+            return (int)(end + 2 - (char *)buf);
+        }
+
+        case HAPROXY_PROTOCOL_VERSION_2:
+            /* byte 15 and 16 contain the length */
+            return HAPROXY_PROTOCOL_V2_MIN_HDR_LEN + ntohps(*(uint16_t *)(=
buf + 14));
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
+haproxy_protocol_parse_port(const char *port_str)
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
+ * @param hpi - The haproxy protocol info structure to store the addresses.
+ * @param ver - The version of the PROXY protocol.
+ * @param fam - The address family (supports: AF_INET or AF_INET6).
+ * @param st - The socket type.
+ * @param src_addr - The source address.
+ * @param dst_addr - The destination address.
+ * @param src_port - The source port.
+ * @param dst_port - The destination port.
+ */
+void
+haproxy_protocol_set_addr(struct haproxy_protocol_info *hpi,
+                          const haproxy_protocol_version_t ver, const int =
fam, const int st,
+                          const void *src_addr, const void *dst_addr,
+                          const uint16_t src_port, const uint16_t dst_port)
+{
+
+    hpi->version =3D ver;
+    hpi->sock_type =3D st;
+    if (fam =3D=3D AF_INET)
+    {
+        hpi->src.addr.sa.sa_family =3D AF_INET;
+        hpi->dst.addr.sa.sa_family =3D AF_INET;
+        hpi->src.addr.in4.sin_addr.s_addr =3D *(uint32_t *)src_addr;
+        hpi->dst.addr.in4.sin_addr.s_addr =3D *(uint32_t *)dst_addr;
+        hpi->src.addr.in4.sin_port =3D src_port;
+        hpi->dst.addr.in4.sin_port =3D dst_port;
+        msg(M_DEBUG, "PROXY protocol %s: SRC %s:%u",
+            ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1",
+            inet_ntoa(hpi->src.addr.in4.sin_addr),
+            ntohs(hpi->src.addr.in4.sin_port));
+        msg(M_DEBUG, "PROXY protocol %s: DST %s:%u",
+            ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1",
+            inet_ntoa(hpi->dst.addr.in4.sin_addr),
+            ntohs(hpi->dst.addr.in4.sin_port));
+    }
+    else if (fam =3D=3D AF_INET6)
+    {
+        hpi->src.addr.sa.sa_family =3D AF_INET6;
+        hpi->dst.addr.sa.sa_family =3D AF_INET6;
+        memcpy(&hpi->src.addr.in6.sin6_addr, src_addr, sizeof(struct in6_a=
ddr));
+        memcpy(&hpi->dst.addr.in6.sin6_addr, dst_addr, sizeof(struct in6_a=
ddr));
+        hpi->src.addr.in6.sin6_port =3D src_port;
+        hpi->dst.addr.in6.sin6_port =3D dst_port;
+
+        char ip6_str[INET6_ADDRSTRLEN];
+        if (inet_ntop(AF_INET6, &hpi->src.addr.in6.sin6_addr, ip6_str,
+                      INET6_ADDRSTRLEN))
+        {
+            msg(M_DEBUG, "PROXY protocol %s: SRC %s:%u",
+                ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1",
+                ip6_str,
+                ntohs(hpi->src.addr.in6.sin6_port));
+        }
+        else
+        {
+            msg(M_NONFATAL, "PROXY protocol %s: could not parse source add=
ress",
+                ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1");
+        }
+        if (inet_ntop(AF_INET6, &hpi->dst.addr.in6.sin6_addr, ip6_str,
+                      INET6_ADDRSTRLEN))
+        {
+            msg(M_DEBUG, "PROXY protocol %s: DST %s:%u",
+                ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1",
+                ip6_str,
+                ntohs(hpi->dst.addr.in6.sin6_port));
+        }
+        else
+        {
+            msg(M_NONFATAL, "PROXY protocol %s: could not parse destinatio=
n address",
+                ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1");
+        }
+    }
+    else
+    {
+        msg(M_NONFATAL, "PROXY protocol %s: unsupported address family",
+            ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? "v2" : "v1");
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
+haproxy_protocol_v1_split_words(char words[][HAPROXY_PROTOCOL_V1_MAX_WORD_=
LEN],
+                                const char *line, int len)
+{
+    int word_num =3D 0;
+    const char *start =3D line;
+    for (int i =3D 0; i < len; ++i)
+    {
+        if (line[i] =3D=3D ' ')
+        {
+            if (word_num < HAPROXY_PROTOCOL_V1_MAX_WORDS)
+            {
+                int word_len =3D (int)(line + i - start);
+                if (word_len < HAPROXY_PROTOCOL_V1_MAX_WORD_LEN)
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
+ * @param hpi - The haproxy protocol info structure to store the parsed da=
ta.
+ * @param line - The header line to parse.
+ * @param len - The length of the header line.
+ *
+ * @return - true if the header was successfully parsed.
+ */
+bool
+haproxy_protocol_parse_v1(struct haproxy_protocol_info *hpi,
+                          const char *line, int len)
+{
+    const haproxy_protocol_version_t version =3D HAPROXY_PROTOCOL_VERSION_=
1;
+    char words[HAPROXY_PROTOCOL_V1_MAX_WORDS][HAPROXY_PROTOCOL_V1_MAX_WORD=
_LEN];
+
+    char *end =3D memchr(line, '\r', len - 1);
+    if (!end || end[1] !=3D '\n') /* partial or invalid header */
+    {
+        return false;
+    }
+    *end =3D ' '; /* replace CRLF with space for easier splitting */
+    int size =3D (int)(end - line + 1);
+
+    int word_num =3D haproxy_protocol_v1_split_words(words, line, size);
+    if (word_num < 3)
+    {
+        msg(M_NONFATAL, "PROXY protocol v1: invalid header");
+        return false;
+    }
+
+    if (strcmp(words[1], "TCP4") =3D=3D 0)
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
+        haproxy_protocol_set_addr(hpi, version, AF_INET, SOCK_STREAM,
+                                  &ip4_src_addr, &ip4_dst_addr,
+                                  ntohs(haproxy_protocol_parse_port(words[=
4])),
+                                  ntohs(haproxy_protocol_parse_port(words[=
5])));
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
+        haproxy_protocol_set_addr(hpi, version, AF_INET6, SOCK_STREAM,
+                                  &ip6_src_addr, &ip6_dst_addr,
+                                  ntohs(haproxy_protocol_parse_port(words[=
4])),
+                                  ntohs(haproxy_protocol_parse_port(words[=
5])));
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
+ * Parse the PROXY protocol v2 header
+ *
+ * @param hpi - The haproxy protocol info structure to store the parsed da=
ta.
+ *
+ * @return - The number of bytes parsed.
+ */
+int
+haproxy_protocol_parse_v2(struct haproxy_protocol_info *hpi)
+{
+    size_t addr_len =3D 0;
+    int pos =3D HAPROXY_PROTOCOL_V2_SIG_LEN + sizeof(header->v2.ver_cmd);
+    const haproxy_protocol_version_t version =3D HAPROXY_PROTOCOL_VERSION_=
2;
+
+    switch (header->v2.ver_cmd & HAPROXY_PROTOCOL_V2_CMD_MASK)
+    {
+        case HAPROXY_PROTOCOL_V2_LOCAL_CMD:
+            /*
+             * this command is sent by the proxy for health-checks and sim=
ilar
+             * and it doesn't make much sense in the openvpn context, so we
+             * ignore the whole header
+             */
+            msg(M_DEBUG, "PROXY protocol v2: LOCAL command");
+            parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_IGNORE;
+            break;
+
+        case HAPROXY_PROTOCOL_V2_PROXY_CMD:
+            msg(M_DEBUG, "PROXY protocol v2: PROXY command");
+            break;
+
+        default:
+            msg(M_DEBUG, "PROXY protocol v2: unknown command");
+            parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_INVALID;
+    }
+
+    if (parsing_state !=3D HAPROXY_PROTOCOL_PARSING_STATE_OK)
+    {
+        return pos;
+    }
+    pos +=3D sizeof(header->v2.fam);
+
+    switch (header->v2.fam)
+    {
+        case HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM:
+            msg(M_DEBUG, "PROXY protocol v2: TCP over IPv4.");
+            haproxy_protocol_set_addr(hpi, version, AF_INET, SOCK_STREAM,
+                                      &header->v2.addr.ip4.src_addr,
+                                      &header->v2.addr.ip4.dst_addr,
+                                      header->v2.addr.ip4.src_port,
+                                      header->v2.addr.ip4.dst_port);
+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV4;
+            break;
+
+        case HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_DGRAM:
+            msg(M_DEBUG, "PROXY protocol v2: UDP over IPv4");
+            haproxy_protocol_set_addr(hpi, version, AF_INET, SOCK_DGRAM,
+                                      &header->v2.addr.ip4.src_addr,
+                                      &header->v2.addr.ip4.dst_addr,
+                                      header->v2.addr.ip4.src_port,
+                                      header->v2.addr.ip4.dst_port);
+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV4;
+            break;
+
+        case HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_STREAM:
+            msg(M_DEBUG, "PROXY protocol v2: TCP over IPv6");
+            haproxy_protocol_set_addr(hpi, version, AF_INET6, SOCK_STREAM,
+                                      header->v2.addr.ip6.src_addr,
+                                      header->v2.addr.ip6.dst_addr,
+                                      header->v2.addr.ip6.src_port,
+                                      header->v2.addr.ip6.dst_port);
+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6;
+            break;
+
+        case HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_DGRAM:
+            msg(M_DEBUG, "PROXY protocol v2: UDP over IPv6");
+            haproxy_protocol_set_addr(hpi, version, AF_INET6, SOCK_DGRAM,
+                                      header->v2.addr.ip6.src_addr,
+                                      header->v2.addr.ip6.dst_addr,
+                                      header->v2.addr.ip6.src_port,
+                                      header->v2.addr.ip6.dst_port);
+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6;
+            break;
+
+        case HAPROXY_PROTOCOL_V2_AF_UNIX | HAPROXY_PROTOCOL_V2_TP_STREAM:
+            msg(M_DEBUG, "PROXY protocol v2: AF_UNIX stream");
+            haproxy_protocol_set_addr(hpi, version, AF_UNIX, SOCK_STREAM,
+                                      header->v2.addr.unx.src_addr,
+                                      header->v2.addr.unx.dst_addr, 0, 0);
+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX;
+            break;
+
+        case HAPROXY_PROTOCOL_V2_AF_UNIX | HAPROXY_PROTOCOL_V2_TP_DGRAM:
+            msg(M_DEBUG, "PROXY protocol v2: AF_UNIX datagram");
+            haproxy_protocol_set_addr(hpi, version, AF_UNIX, SOCK_DGRAM,
+                                      header->v2.addr.unx.src_addr,
+                                      header->v2.addr.unx.dst_addr, 0, 0);
+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX;
+            break;
+
+        default:
+            if ((header->v2.fam & HAPROXY_PROTOCOL_V2_AF_MASK) =3D=3D HAPR=
OXY_PROTOCOL_V2_AF_UNSPEC
+                || (header->v2.fam & HAPROXY_PROTOCOL_V2_TP_MASK) =3D=3D H=
APROXY_PROTOCOL_V2_TP_UNSPEC)
+            {
+                msg(M_DEBUG, "PROXY protocol v2: UNSPEC address family or =
transport protocol");
+                parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_IGNORE;
+                break;
+            }
+            msg(M_DEBUG, "PROXY protocol v2: unknown address family (0x%02=
x) "
+                "or transport protocol (0x%02x)",
+                header->v2.fam & HAPROXY_PROTOCOL_V2_AF_MASK,
+                header->v2.fam & HAPROXY_PROTOCOL_V2_TP_MASK);
+            parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_IGNORE;
+            break;
+    }
+    return (int)(pos + sizeof(header->v2.len) + addr_len);
+}
+
+bool
+haproxy_protocol_parse(struct haproxy_protocol_info *hpi, const uint8_t *b=
uf, const int buf_len)
+{
+    const haproxy_protocol_version_t version =3D haproxy_protocol_version(=
buf, buf_len);
+    header_len =3D buf_len;
+    header =3D (haproxy_protocol_header_t *)buf;
+
+    if (!hpi)
+    {
+        msg(M_NONFATAL, "PROXY protocol: invalid haproxy protocol info str=
ucture");
+        return false;
+    }
+
+    switch (version)
+    {
+        case HAPROXY_PROTOCOL_VERSION_2:
+        {
+            if ((header->v2.ver_cmd & HAPROXY_PROTOCOL_V2_VER_MASK) =3D=3D=
 HAPROXY_PROTOCOL_V2_VER)
+            {
+                haproxy_protocol_parse_v2(hpi);
+                if (parsing_state !=3D HAPROXY_PROTOCOL_PARSING_STATE_OK)
+                {
+                    msg(M_DEBUG, "PROXY protocol v2: %s header",
+                        parsing_state =3D=3D HAPROXY_PROTOCOL_PARSING_STAT=
E_IGNORE ? "ignoring" : "invalid");
+                    return false;
+                }
+                return true;
+            }
+            else
+            {
+                msg(M_NONFATAL, "PROXY protocol v2: expected version 2, go=
t %d",
+                    (header->v2.ver_cmd & HAPROXY_PROTOCOL_V2_VER_MASK) >>=
 4);
+                return false;
+            }
+        }
+
+        case HAPROXY_PROTOCOL_VERSION_1:
+            msg(M_DEBUG, "PROXY protocol header v1: %.*s", header_len - 2,=
 header->v1.line);
+            return haproxy_protocol_parse_v1(hpi, header->v1.line, header_=
len);
+
+        default:
+            return false;
+    }
+}
+
+void
+haproxy_protocol_reset(struct haproxy_protocol_info *hpi)
+{
+    header =3D NULL;
+    header_len =3D 0;
+    parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_OK;
+}
diff --git a/src/openvpn/haproxy_protocol.h b/src/openvpn/haproxy_protocol.h
new file mode 100644
index 0000000..5ffcfa5
--- /dev/null
+++ b/src/openvpn/haproxy_protocol.h
@@ -0,0 +1,185 @@
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
+#ifndef HAPROXY_PROTOCOL_H
+#define HAPROXY_PROTOCOL_H
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
+#define HAPROXY_PROTOCOL_V1_SIG          "PROXY"
+#define HAPROXY_PROTOCOL_V1_SIG_LEN      5
+#define HAPROXY_PROTOCOL_V1_MIN_HDR_LEN  8
+#define HAPROXY_PROTOCOL_V1_LINE_MAX_LEN 108
+
+#define HAPROXY_PROTOCOL_V2_SIG         "\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\=
x55\x49\x54\x0A"
+#define HAPROXY_PROTOCOL_V2_SIG_LEN     12
+#define HAPROXY_PROTOCOL_V2_MIN_HDR_LEN 16
+
+#define HAPROXY_PROTOCOL_V2_VER_MASK 0xF0
+#define HAPROXY_PROTOCOL_V2_VER      (0x2 << 4)
+
+#define HAPROXY_PROTOCOL_V2_CMD_MASK  0x0F
+#define HAPROXY_PROTOCOL_V2_LOCAL_CMD (0x0 << 0)
+#define HAPROXY_PROTOCOL_V2_PROXY_CMD (0x1 << 0)
+
+#define HAPROXY_PROTOCOL_V2_AF_MASK   0xF0
+#define HAPROXY_PROTOCOL_V2_AF_UNSPEC (0x0 << 4)
+#define HAPROXY_PROTOCOL_V2_AF_INET   (0x1 << 4)
+#define HAPROXY_PROTOCOL_V2_AF_INET6  (0x2 << 4)
+#define HAPROXY_PROTOCOL_V2_AF_UNIX   (0x3 << 4)
+
+#define HAPROXY_PROTOCOL_V2_TP_MASK   0x0F
+#define HAPROXY_PROTOCOL_V2_TP_UNSPEC (0x0 << 0)
+#define HAPROXY_PROTOCOL_V2_TP_STREAM (0x1 << 0)
+#define HAPROXY_PROTOCOL_V2_TP_DGRAM  (0x2 << 0)
+
+#define HAPROXY_PROTOCOL_TLV_TYPE_ALPN            0x01
+#define HAPROXY_PROTOCOL_TLV_TYPE_AUTHORITY       0x02
+#define HAPROXY_PROTOCOL_TLV_TYPE_CRC32C          0x03
+#define HAPROXY_PROTOCOL_TLV_TYPE_NOOP            0x04
+#define HAPROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID       0x05
+#define HAPROXY_PROTOCOL_TLV_TYPE_SSL             0x20
+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION  0x21
+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_CN       0x22
+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER   0x23
+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_SIG_ALG  0x24
+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG  0x25
+#define HAPROXY_PROTOCOL_TLV_TYPE_NETNS           0x30
+
+#define HAPROXY_PROTOCOL_V2_CLIENT_SSL          0x01
+#define HAPROXY_PROTOCOL_V2_CLIENT_CERT_CONN    0x02
+#define HAPROXY_PROTOCOL_V2_CLIENT_CERT_SESS    0x04
+
+#define HAPROXY_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN 128
+
+typedef enum
+{
+    HAPROXY_PROTOCOL_VERSION_INVALID =3D -1,
+
+    HAPROXY_PROTOCOL_VERSION_UNKNOWN =3D 0,
+    HAPROXY_PROTOCOL_VERSION_1,
+    HAPROXY_PROTOCOL_VERSION_2,
+} haproxy_protocol_version_t;
+
+#pragma pack(push, 1)
+typedef union
+{
+    struct
+    {
+        char line[HAPROXY_PROTOCOL_V1_LINE_MAX_LEN];
+    } v1;
+    struct
+    {
+        uint8_t sig[HAPROXY_PROTOCOL_V2_SIG_LEN];
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
+} __attribute__((packed)) haproxy_protocol_header_t;
+#pragma pack(pop)
+
+struct haproxy_protocol_info
+{
+    haproxy_protocol_version_t version;
+    int sock_type;
+    struct openvpn_sockaddr src;
+    struct openvpn_sockaddr dst;
+};
+
+/*
+ * Check if the buffer contains an PROXY protocol header and return the ve=
rsion.
+ *
+ * @param buf - The buffer to check.
+ * @param buf_len - The length of the buffer.
+ *
+ * @return - The PROXY protocol version or HAPROXY_PROTOCOL_VERSION_INVALI=
D if
+ *          the buffer does not contain a valid PROXY protocol header.
+ */
+haproxy_protocol_version_t
+haproxy_protocol_version(const uint8_t *buf, int buf_len);
+
+/*
+ * Get the length of the PROXY protocol header.
+ * This function does not check if the header is fully contained in the bu=
ffer
+ * therefore it is the caller's responsibility to perform this check.
+ *
+ * @param buf - The buffer to check.
+ * @param buf_len - The length of the buffer.
+ * @param version - The PROXY protocol version.
+ *
+ * @return - The length of the header or -1 if the header is partial or in=
valid.
+ */
+int
+haproxy_protocol_header_len(const uint8_t *buf, int len, haproxy_protocol_=
version_t version);
+
+/*
+ * Parse the PROXY protocol header.
+ *
+ * @param hpi - The proxy protocol info structure to store the parsed data.
+ * @param buf - The header to parse.
+ * @param buf_len - The length of the header.
+ * @param version - The version of the PROXY protocol.
+ *
+ * @return - true if the header was successfully parsed.
+ */
+bool
+haproxy_protocol_parse(struct haproxy_protocol_info *hpi, const uint8_t *b=
uf, int buf_len);
+
+/*
+ * Free the allocated memory.
+ *
+ * @param hpi - The proxy protocol info structure.
+ */
+void
+haproxy_protocol_reset(struct haproxy_protocol_info *hpi);
+
+#endif /* HAPROXY_PROTOCOL_H */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..ecd3253 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "mss.h"
 #include "mudp.h"
 #include "dco.h"
+#include "haproxy_protocol.h"

 #include "memdbg.h"

@@ -3926,6 +3927,14 @@

         c->c1.link_socket_addr.bind_local =3D NULL;
     }
+
+    /* Clear and free the memory allocated for the HAProxy protocol */
+    if (c->c1.haproxy_protocol)
+    {
+        haproxy_protocol_reset(c->c1.haproxy_protocol);
+        free(c->c1.haproxy_protocol);
+        c->c1.haproxy_protocol =3D NULL;
+    }
 }

 /*
@@ -4774,7 +4783,7 @@
         /* free up environmental variable store */
         do_env_set_destroy(c);

-        /* close HTTP or SOCKS proxy */
+        /* close HTTP or SOCKS proxy or PROXY protocol object */
         uninit_proxy(c);

         /* garbage collect */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 03177bb..e6441cd 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -51,6 +51,7 @@
 #include "ssl_util.h"
 #include "dco.h"
 #include "reflect_filter.h"
+#include "haproxy_protocol.h"

 /*#define MULTI_DEBUG_EVENT_LOOP*/

@@ -779,6 +780,8 @@
         goto err;
     }

+    ALLOC_OBJ_CLEAR(mi->context.c1.haproxy_protocol, struct haproxy_protoc=
ol_info);
+
     mi->context.c2.tls_multi->multi_state =3D CAS_NOT_CONNECTED;

     if (hash_n_elements(m->hash) >=3D m->max_clients)
@@ -789,6 +792,9 @@
=20
     if (!real) /* TCP mode? */
     {
+        /* allow checking for HAProxy protocol header at the beginning of =
the connection */
+        mi->context.c2.link_socket->haproxy_protocol_allowed =3D true;
+
         if (!multi_tcp_instance_specific_init(m, mi))
         {
             goto err;
@@ -3207,6 +3213,57 @@
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
+    if (!mroute_extract_openvpn_sockaddr(&real, &mi->context.c1.haproxy_pr=
otocol->src, true))
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
@@ -3348,6 +3405,7 @@
     struct mroute_addr src, dest;
     unsigned int mroute_flags;
     struct multi_instance *mi;
+    struct link_socket_info *lsi;
     bool ret =3D true;
     bool floated =3D false;

@@ -3387,15 +3445,29 @@
             }
         }

+        lsi =3D get_link_socket_info(c);
+
+        /* check for PROXY protocol */
+        if (lsi->proto =3D=3D PROTO_TCP_SERVER && c->c2.link_socket->hapro=
xy_protocol_allowed && BLEN(&c->c2.buf) > 0)
+        {
+            if (haproxy_protocol_parse(c->c1.haproxy_protocol, BPTR(&c->c2=
.buf), BLEN(&c->c2.buf)))
+            {
+                /* replace proxy address with real address */
+                multi_replace_proxy_addr(m, m->pending);
+                /* avoid processing the packet as an openvpn one */
+                buf_reset_len(&c->c2.buf);
+            }
+            /* stop checking for HAProxy protocol headers */
+            c->c2.link_socket->haproxy_protocol_allowed =3D false;
+        }
+
         if (BLEN(&c->c2.buf) > 0)
         {
-            struct link_socket_info *lsi;
             const uint8_t *orig_buf;

             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index e98c93e..a192f7a 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -45,6 +45,7 @@
 #include "pool.h"
 #include "plugin.h"
 #include "manage.h"
+#include "haproxy_protocol.h"

 /*
  * Our global key schedules, packaged thusly
@@ -191,6 +192,8 @@
     struct socks_proxy_info *socks_proxy;
     bool socks_proxy_owned;

+    struct haproxy_protocol_info *haproxy_protocol;
+
     /* persist --ifconfig-pool db to file */
     struct ifconfig_pool_persist *ifconfig_pool_persist;
     bool ifconfig_pool_persist_owned;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 17c5e76..f096a20 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -39,6 +39,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "forward.h"
+#include "haproxy_protocol.h"

 #include "memdbg.h"

@@ -1617,7 +1618,7 @@
 stream_buf_close(struct stream_buf *sb);

 static bool
-stream_buf_added(struct stream_buf *sb, int length_added);
+stream_buf_added(struct stream_buf *sb, int length_added, bool haproxy_pro=
tocol_allowed);

 /* For stream protocols, allocate a buffer to build up packet.
  * Called after frame has been finalized. */
@@ -2629,7 +2630,7 @@
     {
         ASSERT(buf_copy(&sock->stream_buf.buf, &sock->stream_buf.residual)=
);
         ASSERT(buf_init(&sock->stream_buf.residual, 0));
-        sock->stream_buf.residual_fully_formed =3D stream_buf_added(&sock-=
>stream_buf, 0);
+        sock->stream_buf.residual_fully_formed =3D stream_buf_added(&sock-=
>stream_buf, 0, false);
         dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=3D%d=
",
              sock->stream_buf.residual_fully_formed ? "YES" : "NO",
              sock->stream_buf.residual.len);
@@ -2644,7 +2645,8 @@

 static bool
 stream_buf_added(struct stream_buf *sb,
-                 int length_added)
+                 int length_added,
+                 const bool haproxy_protocol_allowed)
 {
     dmsg(D_STREAM_DEBUG, "STREAM: ADD length_added=3D%d", length_added);
     if (length_added > 0)
@@ -2680,10 +2682,26 @@

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
+            haproxy_protocol_version_t hp_version =3D HAPROXY_PROTOCOL_VER=
SION_UNKNOWN;
+            int hp_len =3D -1;
+            /* if it's allowed (first packet), check for a HAProxy protoco=
l header */
+            if (haproxy_protocol_allowed)
+            {
+                /* undo the reading of net_size */
+                ASSERT(buf_prepend(&sb->buf, sizeof(net_size)));
+                hp_version =3D haproxy_protocol_version(BPTR(&sb->buf), BL=
EN(&sb->buf));
+                hp_len =3D haproxy_protocol_header_len(BPTR(&sb->buf), BLE=
N(&sb->buf), hp_version);
+            }
+
+            /* we do not allow partial headers */
+            if (hp_version <=3D 0 || hp_len < 0 || hp_len > sb->buf.len)
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
+            sb->len =3D hp_len;
         }
     }

@@ -3267,7 +3285,7 @@
     }

     if (sock->stream_buf.residual_fully_formed
-        || stream_buf_added(&sock->stream_buf, len)) /* packet complete? */
+        || stream_buf_added(&sock->stream_buf, len, sock->haproxy_protocol=
_allowed)) /* packet complete? */
     {
         stream_buf_get_final(&sock->stream_buf, buf);
         stream_buf_reset(&sock->stream_buf);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 47083ad..1132b35 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -227,6 +227,9 @@
     const char *proxy_dest_host;
     const char *proxy_dest_port;

+    /* check HAProxy PROXY protocol only if true */
+    bool haproxy_protocol_allowed;
+
     /* Pointer to the server-poll to trigger the timeout in function which=
 have
      * their own loop instead of using the main oop */
     struct event_timeout *server_poll_timeout;
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index a4e6235..1802132 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -10,8 +10,9 @@
 test_binaries +=3D argv_testdriver buffer_testdriver
 endif

-test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver ssl_testdriver user_pass_testdriver
+test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river \
+				 haproxy_protocol_testdriver ncp_testdriver misc_testdriver \
+				 pkt_testdriver ssl_testdriver user_pass_testdriver

 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -73,6 +74,16 @@
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/mss.c

+haproxy_protocol_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/c=
ompat \
+	@TEST_CFLAGS@
+haproxy_protocol_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+haproxy_protocol_testdriver_SOURCES =3D test_haproxy_protocol.c mock_msg.c=
 mock_msg.h \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/haproxy_protocol.c
+
 ssl_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_haproxy_protocol.c b/tests/unit_=
tests/openvpn/test_haproxy_protocol.c
new file mode 100644
index 0000000..0464315
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_haproxy_protocol.c
@@ -0,0 +1,354 @@
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "platform.h"
+#include "buffer.h"
+#include "haproxy_protocol.h"
+#include "test_common.h"
+
+extern uint32_t
+haproxy_protocol_crc32c(const uint8_t *data, int len);
+
+/* header building blocks */
+#define HP1_SIG           0x50, 0x52, 0x4f, 0x58, 0x59 /* "PROXY" */
+#define HP1_TCP4_AF_UNKN  0x55, 0x4E, 0x4B, 0x4E, 0x4F, 0x57, 0x4E /* "UNK=
NOWN" */
+#define HP1_TCP4_AF_INET  0x54, 0x43, 0x50, 0x34 /* "TCP4" */
+#define HP1_TCP6_AF_INET  0x54, 0x43, 0x50, 0x36 /* "TCP6" */
+#define HP1_TCP4_SRC_ADDR 0x31, 0x30, 0x2e, 0x31, 0x30, 0x2e, 0x32, 0x30, =
0x2e, 0x32 /* "10.10.20.2" */
+#define HP1_TCP4_DST_ADDR 0x31, 0x30, 0x2e, 0x31, 0x30, 0x2e, 0x32, 0x30, =
0x2e, 0x31 /* "10.10.20.1" */
+#define HP1_TCP4_SRC_PORT 0x34, 0x30, 0x31, 0x35, 0x30 /* 40150 */
+#define HP1_TCP4_DST_PORT 0x31, 0x31, 0x39, 0x35 /* 1195 */
+#define HP1_TCP6_SRC_ADDR 0x32, 0x30, 0x30, 0x31, 0x3a, 0x64, 0x62, 0x38, =
0x3a, 0x32, 0x30, 0x3a, 0x3a, 0x32 /* "2001:db8:20::2" */
+#define HP1_TCP6_DST_ADDR 0x32, 0x30, 0x30, 0x31, 0x3a, 0x64, 0x62, 0x38, =
0x3a, 0x32, 0x30, 0x3a, 0x3a, 0x31 /* "2001:db8:20::1" */
+#define HP1_TCP6_SRC_PORT 0x35, 0x33, 0x33, 0x34, 0x34 /* 53344 */
+#define HP1_TCP6_DST_PORT 0x31, 0x31, 0x39, 0x35 /* 1195 */
+#define HP1_END           0x0d, 0x0a /* "\r\n" */
+
+#define HP2_SIG         0x0d, 0x0a, 0x0d, 0x0a, 0x00, 0x0d, 0x0a, 0x51, 0x=
55, 0x49, 0x54, 0x0a /* "\r\n\r\n\x00\r\nQUIT\n" */
+#define HP2_V4_SRC_ADDR 0x0a, 0x0a, 0x14, 0x02 /* 10.10.20.2 */
+#define HP2_V4_DST_ADDR 0x0a, 0x0a, 0x14, 0x01 /* 10.10.20.1 */
+#define HP2_V4_SRC_PORT 0xa5, 0x30 /* 42288 */
+#define HP2_V4_DST_PORT 0x04, 0xab /* 1195 */
+#define HP2_V6_SRC_ADDR 0x20, 0x01, 0x0d, 0xb8, 0x00, 0x20, 0x00, 0x00, 0x=
00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x02 /* 2001:db8:20::2 */
+#define HP2_V6_DST_ADDR 0x20, 0x01, 0x0d, 0xb8, 0x00, 0x20, 0x00, 0x00, 0x=
00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01 /* 2001:db8:20::1 */
+#define HP2_V6_SRC_PORT 0xe8, 0xb6 /* 59574 */
+#define HP2_V6_DST_PORT 0x04, 0xab /* 1195 */
+#define HP2_TLV \
+    0x01, 0x00, 0x03, 'h', '2', '3', \
+    0x02, 0x00, 0x0b, 'e', 'x', 'a', 'm', 'p', 'l', 'e', '.', 'c', 'o', 'm=
', \
+    0x04, 0x00, 0x00, \
+    0x05, 0x00, 0x0f, 'u', 'n', 'i', 'q', 'u', 'e', '-', 'i', 'd', '-', 'v=
', 'a', 'l', 'u', 'e', \
+    0x20, 0x00, 0x33, 0x01, 0x00, 0x00, 0x00, 0x00, \
+    0x21, 0x00, 0x06, 'T', 'L', 'S', '1', '.', '3', \
+    0x22, 0x00, 0x06, 'c', 'l', 'i', 'e', 'n', 't', \
+    0x23, 0x00, 0x06, 'A', 'E', 'S', '2', '5', '6', \
+    0x24, 0x00, 0x06, 'S', 'H', 'A', '2', '5', '6', \
+    0x25, 0x00, 0x07, 'R', 'S', 'A', '2', '0', '4', '8', \
+    0x30, 0x00, 0x07, 'n', 'e', 't', 'n', 's', '-', '1'
+
+#define HP_TEST_OPENVPN \
+    0x00, 0x0e, 0x38, 0xa8, 0xf5, 0x24, 0xa0, 0xa7, \
+    0x89, 0x00, 0xca, 0x00, 0x00, 0x00, 0x00, 0x00
+
+/* headers */
+static uint8_t HP1_TEST_UNKNOWN[] =3D {
+    HP1_SIG, 0x20, HP1_TCP4_AF_UNKN, HP1_END
+};
+
+static uint8_t HP1_TEST_TCP4[] =3D {
+    HP1_SIG, 0x20,
+    HP1_TCP4_AF_INET, 0x20,
+    HP1_TCP4_SRC_ADDR, 0x20,
+    HP1_TCP4_DST_ADDR, 0x20,
+    HP1_TCP4_SRC_PORT, 0x20,
+    HP1_TCP4_DST_PORT,
+    HP1_END
+};
+
+static uint8_t HP1_TEST_TCP4_PLUS_OPENVPN[] =3D {
+    HP1_SIG, 0x20,
+    HP1_TCP4_AF_INET, 0x20,
+    HP1_TCP4_SRC_ADDR, 0x20,
+    HP1_TCP4_DST_ADDR, 0x20,
+    HP1_TCP4_SRC_PORT, 0x20,
+    HP1_TCP4_DST_PORT,
+    HP1_END,
+    HP_TEST_OPENVPN
+};
+
+static uint8_t HP1_TEST_TCP6[] =3D {
+    HP1_SIG, 0x20,
+    HP1_TCP6_AF_INET, 0x20,
+    HP1_TCP6_SRC_ADDR, 0x20,
+    HP1_TCP6_DST_ADDR, 0x20,
+    HP1_TCP6_SRC_PORT, 0x20,
+    HP1_TCP6_DST_PORT,
+    HP1_END
+};
+
+static uint8_t HP1_TEST_TCP6_PLUS_OPENVPN[] =3D {
+    HP1_SIG, 0x20,
+    HP1_TCP6_AF_INET, 0x20,
+    HP1_TCP6_SRC_ADDR, 0x20,
+    HP1_TCP6_DST_ADDR, 0x20,
+    HP1_TCP6_SRC_PORT, 0x20,
+    HP1_TCP6_DST_PORT,
+    HP1_END,
+    HP_TEST_OPENVPN
+};
+
+static uint8_t HP2_TEST_LOCAL[] =3D {
+    HP2_SIG,
+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_LOCAL_CMD,
+    HAPROXY_PROTOCOL_V2_AF_UNSPEC | HAPROXY_PROTOCOL_V2_TP_UNSPEC,
+    0x00, 0x00 /* length */
+};
+
+static uint8_t HP2_TEST_WRONG_VER[] =3D {
+    HP2_SIG,
+    0x10 | HAPROXY_PROTOCOL_V2_PROXY_CMD,
+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM,
+    0x00, 0x0c, /* length */
+    HP2_V4_SRC_ADDR,
+    HP2_V4_DST_ADDR,
+    HP2_V4_SRC_PORT,
+    HP2_V4_DST_PORT,
+};
+
+static uint8_t HP2_TEST_PROXY_TCP4[] =3D {
+    HP2_SIG,
+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,
+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM,
+    0x00, 0x7c, /* length */
+    HP2_V4_SRC_ADDR,
+    HP2_V4_DST_ADDR,
+    HP2_V4_SRC_PORT,
+    HP2_V4_DST_PORT,
+    HP2_TLV,
+    0x03, 0x00, 0x04, 0x6e, 0x8a, 0xbf, 0x7f /* crc32c */
+};
+
+static uint8_t HP2_TEST_PROXY_TCP4_PLUS_OPENVPN[] =3D {
+    HP2_SIG,
+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,
+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM,
+    0x00, 0x7c, /* length */
+    HP2_V4_SRC_ADDR,
+    HP2_V4_DST_ADDR,
+    HP2_V4_SRC_PORT,
+    HP2_V4_DST_PORT,
+    HP2_TLV,
+    0x03, 0x00, 0x04, 0x6e, 0x8a, 0xbf, 0x7f, /* crc32c */
+    HP_TEST_OPENVPN
+};
+
+static uint8_t HP2_TEST_PROXY_TCP6[] =3D {
+    HP2_SIG,
+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,
+    HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_STREAM,
+    0x00, 0x94, /* length */
+    HP2_V6_SRC_ADDR,
+    HP2_V6_DST_ADDR,
+    HP2_V6_SRC_PORT,
+    HP2_V6_DST_PORT,
+    HP2_TLV,
+    0x03, 0x00, 0x04, 0xed, 0xb0, 0x61, 0xb6 /* crc32c */
+};
+
+static uint8_t HP2_TEST_PROXY_TCP6_PLUS_OPENVPN[] =3D {
+    HP2_SIG,
+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,
+    HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_STREAM,
+    0x00, 0x94, /* length */
+    HP2_V6_SRC_ADDR,
+    HP2_V6_DST_ADDR,
+    HP2_V6_SRC_PORT,
+    HP2_V6_DST_PORT,
+    HP2_TLV,
+    0x03, 0x00, 0x04, 0xed, 0xb0, 0x61, 0xb6, /* crc32c */
+    HP_TEST_OPENVPN
+};
+
+static void
+test_haproxy_protocol_version(void **state)
+{
+    assert_int_equal(haproxy_protocol_version(HP1_TEST_UNKNOWN, sizeof(HP1=
_TEST_UNKNOWN)), HAPROXY_PROTOCOL_VERSION_1);
+    assert_int_equal(haproxy_protocol_version(HP1_TEST_TCP4, sizeof(HP1_TE=
ST_TCP4)), HAPROXY_PROTOCOL_VERSION_1);
+    assert_int_equal(haproxy_protocol_version(HP1_TEST_TCP6, sizeof(HP1_TE=
ST_TCP6)), HAPROXY_PROTOCOL_VERSION_1);
+    assert_int_equal(haproxy_protocol_version(HP2_TEST_WRONG_VER, sizeof(H=
P2_TEST_WRONG_VER)), HAPROXY_PROTOCOL_VERSION_2);
+    assert_int_equal(haproxy_protocol_version(HP2_TEST_LOCAL, sizeof(HP2_T=
EST_LOCAL)), HAPROXY_PROTOCOL_VERSION_2);
+    assert_int_equal(haproxy_protocol_version(HP2_TEST_PROXY_TCP4, sizeof(=
HP2_TEST_PROXY_TCP4)), HAPROXY_PROTOCOL_VERSION_2);
+    assert_int_equal(haproxy_protocol_version(HP2_TEST_PROXY_TCP6, sizeof(=
HP2_TEST_PROXY_TCP6)), HAPROXY_PROTOCOL_VERSION_2);
+    assert_int_equal(haproxy_protocol_version((uint8_t []){HP_TEST_OPENVPN=
}, sizeof((uint8_t []){HP_TEST_OPENVPN})), HAPROXY_PROTOCOL_VERSION_INVALID=
);
+}
+
+static void
+test_haproxy_protocol_header_len(void **state)
+{
+    assert_int_equal(haproxy_protocol_header_len(HP1_TEST_UNKNOWN, sizeof(=
HP1_TEST_UNKNOWN), HAPROXY_PROTOCOL_VERSION_1), sizeof(HP1_TEST_UNKNOWN));
+    assert_int_equal(haproxy_protocol_header_len(HP1_TEST_TCP4_PLUS_OPENVP=
N, sizeof(HP1_TEST_TCP4_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION_1), sizeof(=
HP1_TEST_TCP4));
+    assert_int_equal(haproxy_protocol_header_len(HP1_TEST_TCP6_PLUS_OPENVP=
N, sizeof(HP1_TEST_TCP6_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION_1), sizeof(=
HP1_TEST_TCP6));
+    assert_int_equal(haproxy_protocol_header_len(HP2_TEST_WRONG_VER, sizeo=
f(HP2_TEST_WRONG_VER), HAPROXY_PROTOCOL_VERSION_2), sizeof(HP2_TEST_WRONG_V=
ER));
+    assert_int_equal(haproxy_protocol_header_len(HP2_TEST_LOCAL, sizeof(HP=
2_TEST_LOCAL), HAPROXY_PROTOCOL_VERSION_2), sizeof(HP2_TEST_LOCAL));
+    assert_int_equal(haproxy_protocol_header_len(HP2_TEST_PROXY_TCP4_PLUS_=
OPENVPN, sizeof(HP2_TEST_PROXY_TCP4_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION=
_2), sizeof(HP2_TEST_PROXY_TCP4));
+    assert_int_equal(haproxy_protocol_header_len(HP2_TEST_PROXY_TCP6_PLUS_=
OPENVPN, sizeof(HP2_TEST_PROXY_TCP6_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION=
_2), sizeof(HP2_TEST_PROXY_TCP6));
+    assert_int_equal(haproxy_protocol_header_len((uint8_t []){HP_TEST_OPEN=
VPN}, sizeof((uint8_t []){HP_TEST_OPENVPN}), HAPROXY_PROTOCOL_VERSION_INVAL=
ID), -1);
+}
+
+static bool
+compare_hpi_basic(void **state, struct haproxy_protocol_info *actual, stru=
ct haproxy_protocol_info *expected)
+{
+    if (actual->src.addr.sa.sa_family !=3D expected->src.addr.sa.sa_family
+        || actual->dst.addr.sa.sa_family !=3D expected->dst.addr.sa.sa_fam=
ily)
+    {
+        return false;
+    }
+
+    switch (actual->src.addr.sa.sa_family)
+    {
+        case AF_INET:
+            return actual->version =3D=3D expected->version
+                   && actual->sock_type =3D=3D expected->sock_type
+                   && memcmp(&actual->src.addr.in4.sin_addr, &expected->sr=
c.addr.in4.sin_addr, sizeof(struct in_addr)) =3D=3D 0
+                   && memcmp(&actual->dst.addr.in4.sin_addr, &expected->ds=
t.addr.in4.sin_addr, sizeof(struct in_addr)) =3D=3D 0
+                   && actual->dst.addr.in4.sin_port =3D=3D expected->dst.a=
ddr.in4.sin_port
+                   && actual->src.addr.in4.sin_port =3D=3D expected->src.a=
ddr.in4.sin_port;
+
+        case AF_INET6:
+            return actual->version =3D=3D expected->version
+                   && actual->sock_type =3D=3D expected->sock_type
+                   && memcmp(&actual->src.addr.in6, &expected->src.addr.in=
6, sizeof(struct sockaddr_in6)) =3D=3D 0
+                   && memcmp(&actual->dst.addr.in6, &expected->dst.addr.in=
6, sizeof(struct sockaddr_in6)) =3D=3D 0;
+
+        default:
+            return false;
+    }
+}
+
+static bool
+compare_hpi(void **state, struct haproxy_protocol_info *actual, struct hap=
roxy_protocol_info *expected)
+{
+    return compare_hpi_basic(state, actual, expected);
+}
+
+static int
+setup_parse(void **state)
+{
+    struct haproxy_protocol_info *actual;
+    ALLOC_OBJ_CLEAR(actual, struct haproxy_protocol_info);
+    *state =3D actual;
+    return 0;
+}
+
+static int
+teardown_parse(void **state)
+{
+    haproxy_protocol_reset(*state);
+    free(*state);
+    return 0;
+}
+
+static void
+test_haproxy_protocol_parse(void **state)
+{
+    struct haproxy_protocol_info *expected;
+    struct haproxy_protocol_info *actual =3D *state;
+
+    ALLOC_OBJ_CLEAR(expected, struct haproxy_protocol_info);
+
+    /* v1 UNKNOWN protocol */
+    assert_false(haproxy_protocol_parse(actual, HP1_TEST_UNKNOWN, sizeof(H=
P1_TEST_UNKNOWN)));
+
+    /* v1 TCP4 */
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    haproxy_protocol_reset(actual);
+    expected->version =3D HAPROXY_PROTOCOL_VERSION_1;
+    expected->sock_type =3D SOCK_STREAM;
+    expected->src.addr.sa.sa_family =3D AF_INET;
+    expected->src.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1402);
+    expected->src.addr.in4.sin_port =3D ntohs(40150);
+    expected->dst.addr.sa.sa_family =3D AF_INET;
+    expected->dst.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1401);
+    expected->dst.addr.in4.sin_port =3D ntohs(1195);
+    haproxy_protocol_parse(actual, HP1_TEST_TCP4, sizeof(HP1_TEST_TCP4));
+    assert_true(compare_hpi(state, actual, expected));
+
+    /* v1 TCP6 */
+    haproxy_protocol_reset(actual);
+    haproxy_protocol_reset(expected);
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    memset((expected), 0, sizeof(struct haproxy_protocol_info));
+    expected->version =3D HAPROXY_PROTOCOL_VERSION_1;
+    expected->sock_type =3D SOCK_STREAM;
+    expected->src.addr.in6.sin6_family =3D AF_INET6;
+    expected->src.addr.in6.sin6_port =3D ntohs(53344);
+    inet_pton(AF_INET6, "2001:db8:20::2", &expected->src.addr.in6.sin6_add=
r);
+    expected->dst.addr.in6.sin6_family =3D AF_INET6;
+    expected->dst.addr.in6.sin6_port =3D ntohs(1195);
+    inet_pton(AF_INET6, "2001:db8:20::1", &expected->dst.addr.in6.sin6_add=
r);
+    haproxy_protocol_parse(actual, HP1_TEST_TCP6, sizeof(HP1_TEST_TCP6));
+    assert_true(compare_hpi(state, actual, expected));
+
+    /* v2 wrong version */
+    haproxy_protocol_reset(actual);
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    assert_false(haproxy_protocol_parse(actual, HP2_TEST_WRONG_VER, sizeof=
(HP2_TEST_WRONG_VER)));
+
+    /* v2 local */
+    haproxy_protocol_reset(actual);
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    assert_false(haproxy_protocol_parse(actual, HP2_TEST_LOCAL, sizeof(HP2=
_TEST_LOCAL)));
+
+    /* v2 TCP4 */
+    haproxy_protocol_reset(actual);
+    haproxy_protocol_reset(expected);
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    memset((expected), 0, sizeof(struct haproxy_protocol_info));
+    expected->version =3D HAPROXY_PROTOCOL_VERSION_2;
+    expected->sock_type =3D SOCK_STREAM;
+    expected->src.addr.in4.sin_family =3D AF_INET;
+    expected->src.addr.in4.sin_port =3D ntohs(42288);
+    expected->src.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1402);
+    expected->dst.addr.in4.sin_family =3D AF_INET;
+    expected->dst.addr.in4.sin_port =3D ntohs(1195);
+    expected->dst.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1401);
+    haproxy_protocol_parse(actual, HP2_TEST_PROXY_TCP4, sizeof(HP2_TEST_PR=
OXY_TCP4));
+    assert_true(compare_hpi(state, actual, expected));
+
+    /* v2 TCP6 */
+    haproxy_protocol_reset(actual);
+    haproxy_protocol_reset(expected);
+    memset((actual), 0, sizeof(struct haproxy_protocol_info));
+    memset((expected), 0, sizeof(struct haproxy_protocol_info));
+    expected->version =3D HAPROXY_PROTOCOL_VERSION_2;
+    expected->sock_type =3D SOCK_STREAM;
+    expected->src.addr.in6.sin6_family =3D AF_INET6;
+    expected->src.addr.in6.sin6_port =3D ntohs(59574);
+    inet_pton(AF_INET6, "2001:db8:20::2", &expected->src.addr.in6.sin6_add=
r);
+    expected->dst.addr.in6.sin6_family =3D AF_INET6;
+    expected->dst.addr.in6.sin6_port =3D ntohs(1195);
+    inet_pton(AF_INET6, "2001:db8:20::1", &expected->dst.addr.in6.sin6_add=
r);
+    haproxy_protocol_parse(actual, HP2_TEST_PROXY_TCP6, sizeof(HP2_TEST_PR=
OXY_TCP6));
+    assert_true(compare_hpi(state, actual, expected));
+
+    haproxy_protocol_reset(expected);
+    free(expected);
+}
+
+int
+main(void)
+{
+    openvpn_unit_test_setup();
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_haproxy_protocol_version),
+        cmocka_unit_test(test_haproxy_protocol_header_len),
+        cmocka_unit_test_setup_teardown(test_haproxy_protocol_parse, setup=
_parse, teardown_parse)
+    };
+    return cmocka_run_group_tests_name("haproxy_protocol", tests, NULL, NU=
LL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac
Gerrit-Change-Number: 685
Gerrit-PatchSet: 2
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--GjFWpEsZD/w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ralf_lici <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld, Code-Review-1 by plaisthos</p><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">Add support for H=
AProxy&#39;s PROXY protocol<br><br>The PROXY protocol is a simple protocol =
that can be used to<br>communicate connection information such as a client&=
#39;s address across<br>multiple layers of NAT or TCP proxies. This commit =
adds support for<br>the parsing of the v1 and v2 PROXY protocol header but =
does not yet<br>parse the TLV data in the v2 header.<br><br>Check if a PROX=
Y protocol header was sent by the client at the<br>beginning of the connect=
ion. If so, parse it, store the extracted<br>informations and replace the p=
roxy address with the real client<br>address. Checking for the header is do=
ne only if the packet has an<br>invalid length so that there&#39;s minimal =
overhead for the common case.<br><br>Also add a small document file showing=
 how to configure HAProxy to<br>test the feature and a unit test for the pa=
rsing.<br><br>Change-Id: I9766c68feaba71279f26c3310eee4b5ca215e6ac<br>Signe=
d-off-by: Ralf Lici &lt;ralf@...2726...&gt;<br>---<br>M CMakeLists.txt<br>A=
 doc/haproxy-protocol.txt<br>M src/openvpn/Makefile.am<br>A src/openvpn/hap=
roxy_protocol.c<br>A src/openvpn/haproxy_protocol.h<br>M src/openvpn/init.c=
<br>M src/openvpn/multi.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/socke=
t.c<br>M src/openvpn/socket.h<br>M tests/unit_tests/openvpn/Makefile.am<br>=
A tests/unit_tests/openvpn/test_haproxy_protocol.c<br>12 files changed, 1,3=
24 insertions(+), 13 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/85/685/2</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt =
b/CMakeLists.txt</span><br><span>index ad620fa..e927a01 100644</span><br><s=
pan>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><sp=
an>@@ -419,6 +419,8 @@</span><br><span>     src/openvpn/fragment.h</span><b=
r><span>     src/openvpn/gremlin.c</span><br><span>     src/openvpn/gremlin=
.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/h=
aproxy_protocol.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  src/openvpn/haproxy_protocol.h</span><br><span>     src/openvpn/helper.c<=
/span><br><span>     src/openvpn/helper.h</span><br><span>     src/openvpn/=
httpdigest.c</span><br><span>diff --git a/doc/haproxy-protocol.txt b/doc/ha=
proxy-protocol.txt</span><br><span>new file mode 100644</span><br><span>ind=
ex 0000000..604951a</span><br><span>--- /dev/null</span><br><span>+++ b/doc=
/haproxy-protocol.txt</span><br><span>@@ -0,0 +1,166 @@</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+HAProxy PROXY protocol support for Open=
VPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Th=
e PROXY protocol is a simple protocol that can be used to retreive the</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+original source address =
of a connection that has been proxied. Every connection</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+is prepended with a header reporting th=
e client IP address and port. This</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+document aims to breifly describe the protocol and how it ca=
n be tested in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenV=
PN. For more information about the protocol, see the official</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+specification at https://www.hapr=
oxy.org/download/2.4/doc/proxy-protocol.txt.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+Currently there are two versions of the protocol, a text based versio=
n (v1) and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+a binary =
version (v2). Although the binary version is more efficient, the text</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+based version is still th=
e only version supported by some proxies therefore it</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+we support both versions.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+The protocol is agnostic to the underlying transport p=
rotocol, so it can be used</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+with both TCP, UDP and UNIX sockets but currently only TCP is suppor=
ted by</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+Version 1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+---------</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The t=
ext based version is a human readable protocol that is easy to debug. It</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+consists of a single l=
ine of text with the following fields:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
PROXY_SIGNATURE_V1 + single space + INET_PROTOCOL + single space + CLIENT_I=
P +</span><br><span style=3D"color: hsl(120, 100%, 40%);">+single space + P=
ROXY_IP + single space + CLIENT_PORT + single space +</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+PROXY_PORT + &quot;\r\n&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+The only supported INET_PROTOCOL in version 1 are =
&quot;TCP4&quot; and &quot;TCP6&quot;.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
Version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+---------<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+The binary version is a more efficient =
protocol that is more suitable for</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+production use. It consists of a fixed length header followe=
d by the original</span><br><span style=3D"color: hsl(120, 100%, 40%);">+co=
nnection data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+A PROXY Protocol binary =
header for an IPv4 incoming address has the format:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ 0               1               2       =
        3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ 0 1 2 3 4=
 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+|                                                               |</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">++                      =
                                         +</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+|                  Proxy Protocol v2 Signature      =
            |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++     =
                                                          +</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+|                                  =
                             |</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|Version|Command| =
  AF  | Proto.|         Address Length        |</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|=
                      IPv4 Source Address                      |</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+|                    IPv4 Destination Address              =
     |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+|          Source Port          |        =
Destination Port       |</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+|                       =
                                        |</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">++                                                    =
           +</span><br><span style=3D"color: hsl(120, 100%, 40%);">++      =
                        TLVs                             +</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">++                                   =
                            +</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+|                                                               |=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+A PROXY Protocol binary header for a IPv6 incoming address has the =
format:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ 0          =
     1               2               3</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3 4 5 6 7 0 1 2 3=
 4 5 6 7</span><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+|                                       =
                        |</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">++                                                               +</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+|                  Prox=
y Protocol v2 Signature                  |</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">++                                                   =
            +</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|     =
                                                          |</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+=
-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+|Version|Command|   AF  | Proto.|         Address Length        =
|</span><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+|                                              =
                 |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++=
                                                               +</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+|                             =
                                  |</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">++                      IPv6 Source Address                 =
     +</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|            =
                                                   |</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">++                                        =
                       +</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+|                                                               |</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">++-+-+-+-+-+-+-+-+-+-+-+-=
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+|                                                    =
           |</span><br><span style=3D"color: hsl(120, 100%, 40%);">++      =
                                                         +</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+|                                   =
                            |</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">++                    IPv6 Destination Address                   +=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+|                  =
                                             |</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">++                                               =
                +</span><br><span style=3D"color: hsl(120, 100%, 40%);">+| =
                                                              |</span><br><=
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
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+The field=
s are as follows:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Proxy Protocol v2 S=
ignature: 12 bytes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
 The v2 signature of the protocol: &quot;\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x=
55\x49\x54\x0A\x20&quot;.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Version: 4 =
bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  The version o=
f the PROXY protocol (0x2).</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Command: =
4 bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Can by one =
of the following:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  - LOCAL: 0x0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 The connection was initiated by the proxy for health-checks or similar.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      This command is =
not supported and therefore the header is ignored.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    - PROXY: 0x1</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      The connection was initiated by the clien=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+- AF: 4 bits</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    The address family of the connection =
can be: AF_UNSPEC (0x0), AF_INET (0x1),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    AF_INET6 (0x2) or AF_UNIX (0x3). Only AF_INET and A=
F_INET6 are supported.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+- Proto: 4 bits<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The protocol of =
the connection can be: UNSPEC (0x0), STREAM (0x1) or</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    DGRAM (0x2). Only STREAM is supported=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+- Address Length: 16 bits</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    The length of the rest of t=
he header in bytes.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Finally there may b=
e additional data arranged as a series of TLV</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+(Type-Length-Value) vectors that can be used to c=
arry additional information.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OpenVPN te=
sting</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--------------=
-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+Currently only TCP is supported. To t=
est the PROXY protocol support in OpenVPN,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+you can use HAProxy as a proxy with a configuration =
like this:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+global</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    log stdout format raw local0</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    log 127.0.0.1 local0 deb=
ug</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    daemon</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+defaults</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    log     global</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    mode    tcp</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    option  tcplog</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    timeout connect 5000ms</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    timeout client  50000ms</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    timeout server  50000ms</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+frontend openvpn_front</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    bind 10.10.20.1:1195</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    default_backend openvpn_back</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+backend openvpn_back</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    server openvpn_server 10.10.10.1:1194 send-proxy</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    # server openvpn_s=
erver 10.10.10.1:1194 send-proxy-v2 proxy-v2-options ssl,cert-cn,ssl-cipher=
,cert-sig,cert-key,authority,crc32c,unique-id</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+You can use =
the commented line to test the binary format and the TLV data</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+instead of the text based format.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+Note that you should set the keepalive=
 option so that the connection is not</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+reset by HAProxy for inactivity (timeout option in the co=
nfig).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+The OpenVPN TCP server should re=
ad and parse the header and use the information</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+to display the original source address in the l=
ogs.</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Mak=
efile.am</span><br><span>index 56cce9d..9dce362 100644</span><br><span>--- =
a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</sp=
an><br><span>@@ -65,6 +65,7 @@</span><br><span> 	forward.c forward.h \</spa=
n><br><span> 	fragment.c fragment.h \</span><br><span> 	gremlin.c gremlin.h=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	haproxy_protocol=
.c haproxy_protocol.h \</span><br><span> 	helper.c helper.h \</span><br><sp=
an> 	httpdigest.c httpdigest.h \</span><br><span> 	lladdr.c lladdr.h \</spa=
n><br><span>diff --git a/src/openvpn/haproxy_protocol.c b/src/openvpn/hapro=
xy_protocol.c</span><br><span>new file mode 100644</span><br><span>index 00=
00000..1786d2f</span><br><span>--- /dev/null</span><br><span>+++ b/src/open=
vpn/haproxy_protocol.c</span><br><span>@@ -0,0 +1,487 @@</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP net=
works</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 over a single TCP/UDP port, with support for SSL/TLS-based</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *             session authenticati=
on and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             packet encryption, packet authentication, and</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2024 OpenVPN Inc =
&lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This prog=
ram is free software; you can redistribute it and/or modify</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU G=
eneral Public License version 2</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  as published by the Free Software Foundation.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that i=
t will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS=
 FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  GNU General Public License for more details.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GNU =
General Public License along</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  with this program; if not, write to the Free Software Foundati=
on, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Fra=
nklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;error.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;haprox=
y_protocol.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROT=
OCOL_V1_MAX_WORDS 6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define HAPROXY_PROTOCOL_V1_MAX_WORD_LEN 40</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+typedef enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL=
_PARSING_STATE_INVALID =3D -1,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    HAPROXY_PROTOCOL_PARSING_STATE_OK =3D 0,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_PARSING_STATE_IGNO=
RE =3D 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} haproxy_=
protocol_parsing_state_t;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static const =
size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV4 =3D 12;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+static const size_t HAPROXY_PROTOCOL_V2_ADDR_L=
EN_IPV6 =3D 36;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stat=
ic const size_t HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX =3D 216;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static haproxy_protocol_header_t *header =3D NULL;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint16_t header_l=
en =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static hap=
roxy_protocol_parsing_state_t parsing_state =3D HAPROXY_PROTOCOL_PARSING_ST=
ATE_OK;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_version_t</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_version=
(const uint8_t *buf, const int buf_len)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (buf_len &gt;=3D HAPROXY_PROTOCOL_V2_MIN_HDR_LEN</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        &amp;&amp; memcmp(buf, HAPROX=
Y_PROTOCOL_V2_SIG, HAPROXY_PROTOCOL_V2_SIG_LEN) =3D=3D 0)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return HAPROXY_PROTOCOL_VERSION_2;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (buf_len &gt;=3D HAPROXY_PROT=
OCOL_V1_MIN_HDR_LEN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
             &amp;&amp; memcmp(buf, HAPROXY_PROTOCOL_V1_SIG, HAPROXY_PROTOC=
OL_V1_SIG_LEN) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        r=
eturn HAPROXY_PROTOCOL_VERSION_1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    return HAPROXY_PROTOCOL_VERSION_INVALID;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_header_len(=
const uint8_t *buf, const int buf_len,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                            const haproxy_protocol_versi=
on_t version)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (version)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_VERSION=
_1:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *en=
d =3D memchr(buf, &#39;\r&#39;, buf_len - 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            /* partial or invalid header */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!end || e=
nd[1] !=3D &#39;\n&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               return -1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            return (int)(end + 2 - (char *)buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        case HAPROXY_PROTOCOL_VERSION_2:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            /* byte 15 and 16 contain the length */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return HAP=
ROXY_PROTOCOL_V2_MIN_HDR_LEN + ntohps(*(uint16_t *)(buf + 14));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return -1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Parse a port number from a string.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * @param port_str - The string to parse=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return - The port number or -1 =
if the string is invalid.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uint16_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_pars=
e_port(const char *port_str)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char =
*endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    errno =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    long port =3D strtol(port_st=
r, &amp;endptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (errno !=3D 0 || endptr =3D=3D port_str || *endptr !=3D &#39;\0&#39=
; || port &lt;=3D 0 || port &gt; 65535)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return -1;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retur=
n (uint16_t)port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Set the source and destination addresses and ports in=
 the proxy protocol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * info structure for later use.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @=
param hpi - The haproxy protocol info structure to store the addresses.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param ver - The ver=
sion of the PROXY protocol.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param fam - The address family (supports: AF_INET or AF_INET6).=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param st - The =
socket type.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am src_addr - The source address.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * @param dst_addr - The destination address.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param src_port - The source por=
t.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param dst_por=
t - The destination port.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_set_addr=
(struct haproxy_protocol_info *hpi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                          const haproxy_protocol_version_t =
ver, const int fam, const int st,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                          const void *src_addr, const void *d=
st_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
               const uint16_t src_port, const uint16_t dst_port)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    hpi-&gt;version =3D ver;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    hpi-&gt;sock_type =3D st;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (fam =3D=3D AF_INET)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        hpi-&gt;src.addr.sa.sa_family =3D AF_INET;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        hpi-&gt;dst.add=
r.sa.sa_family =3D AF_INET;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        hpi-&gt;src.addr.in4.sin_addr.s_addr =3D *(uint32_t *)src_a=
ddr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hpi-&gt=
;dst.addr.in4.sin_addr.s_addr =3D *(uint32_t *)dst_addr;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        hpi-&gt;src.addr.in4.sin_port =
=3D src_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  hpi-&gt;dst.addr.in4.sin_port =3D dst_port;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY protocol %s: SRC=
 %s:%u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? &quot;v2&quot; : &quot;v1&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            inet=
_ntoa(hpi-&gt;src.addr.in4.sin_addr),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ntohs(hpi-&gt;src.addr.in4.sin_port));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot=
;PROXY protocol %s: DST %s:%u&quot;,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? &quot;=
v2&quot; : &quot;v1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            inet_ntoa(hpi-&gt;dst.addr.in4.sin_addr),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            ntohs(hpi-&gt;dst.addr=
.in4.sin_port));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (fam =
=3D=3D AF_INET6)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        hpi-&gt;s=
rc.addr.sa.sa_family =3D AF_INET6;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        hpi-&gt;dst.addr.sa.sa_family =3D AF_INET6;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;hpi-&gt;=
src.addr.in6.sin6_addr, src_addr, sizeof(struct in6_addr));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;hpi-&gt;dst.add=
r.in6.sin6_addr, dst_addr, sizeof(struct in6_addr));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        hpi-&gt;src.addr.in6.sin6_port =
=3D src_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  hpi-&gt;dst.addr.in6.sin6_port =3D dst_port;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        char ip6_str[INET6_ADDRSTRLEN];</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (inet_ntop(AF_INET6, &amp;hpi-&gt;sr=
c.addr.in6.sin6_addr, ip6_str,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                      INET6_ADDRSTRLEN))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol %s: S=
RC %s:%u&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? &quot;v2&quot; : &quot;=
v1&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      ip6_str,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           ntohs(hpi-&gt;src.addr.in6.sin6_port));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(M_NONFATAL, &quot;PROXY protocol %s: could not parse so=
urce address&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ver =3D=3D HAPROXY_PROTOCOL_VERSION_2 ? &quot;v2&quot; : &q=
uot;v1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ine=
t_ntop(AF_INET6, &amp;hpi-&gt;dst.addr.in6.sin6_addr, ip6_str,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                      INET6_ADDR=
STRLEN))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEB=
UG, &quot;PROXY protocol %s: DST %s:%u&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                ver =3D=3D HAPROXY_PROTOCOL_VERSI=
ON_2 ? &quot;v2&quot; : &quot;v1&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                ip6_str,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ntohs(hpi-&gt;dst.addr.in6.sin6_po=
rt));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_NONFATAL, &quot;PROXY p=
rotocol %s: could not parse destination address&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                ver =3D=3D HAPROXY_PROTO=
COL_VERSION_2 ? &quot;v2&quot; : &quot;v1&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_NONFA=
TAL, &quot;PROXY protocol %s: unsupported address family&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            ver =3D=3D HAPROXY_=
PROTOCOL_VERSION_2 ? &quot;v2&quot; : &quot;v1&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * Split the v1 header line into =
words (space-separated)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param wor=
ds - The array to store the words.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param line - The header line to split.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @param len - The length of the hea=
der line.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return - The number of =
words found or -1 if an error occurred.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_prot=
ocol_v1_split_words(char words[][HAPROXY_PROTOCOL_V1_MAX_WORD_LEN],</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
     const char *line, int len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in=
t word_num =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const char *start =3D line;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; len; ++i)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (line[i] =3D=3D &#39; &#39;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (word_num &lt; HAPROXY_PROTOCOL_V1_=
MAX_WORDS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 int word_len =3D (int)(line + i - start);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                if (word_len &lt; HAPROXY_PROTOCOL_V=
1_MAX_WORD_LEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              memcpy(words[word_num], start, word_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    words[word_num][wor=
d_len] =3D &#39;\0&#39;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    ++word_num;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    msg(M_NONFATAL, &quot;PROXY protocol v1: =
word too long&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    return -1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            start =3D line + i + 1;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return word_num;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * Parse the PROXY protocol v1 header line.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param hpi - The haproxy protocol info structu=
re to store the parsed data.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param line - The header line to parse.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param len - The length of the header =
line.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * @return - true if the header=
 was successfully parsed.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_parse_v1=
(struct haproxy_protocol_info *hpi,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                          const char *line, int len)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const haproxy_protocol_version_t version=
 =3D HAPROXY_PROTOCOL_VERSION_1;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    char words[HAPROXY_PROTOCOL_V1_MAX_WORDS][HAPROXY_PROTOCOL=
_V1_MAX_WORD_LEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *end =3D me=
mchr(line, &#39;\r&#39;, len - 1);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!end || end[1] !=3D &#39;\n&#39;) /* partial or inva=
lid header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    *end =3D &#39; &#39;; /* rep=
lace CRLF with space for easier splitting */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int size =3D (int)(end - line + 1);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int word_num =3D haproxy_protocol_v1_split_wo=
rds(words, line, size);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (word_num &lt; 3)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_NONFATAL, &quot;PROXY protocol v1: invalid header&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (strcmp(words[1], &quot;TCP4&quot;) =3D=3D 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY protoco=
l v1: TCP4 protocol&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        struct in_addr ip4_src_addr, ip4_dst_addr;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (inet_pton(AF_INET, words=
[2], &amp;ip4_src_addr) !=3D 1)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            msg(M_NONFATAL,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                &quot;PROXY protocol v1: could not parse source a=
ddress&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (inet_pton(AF_INET, words[3], &amp;ip4_dst_addr) !=3D 1)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            msg(M_NONFATAL,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                &quot;PROXY protocol v=
1: could not parse destination address&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        haproxy_protocol_set_addr(hpi, version, AF_=
INET, SOCK_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                 &amp;ip4_src_addr, &amp;ip4_dst_addr,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
          ntohs(haproxy_protocol_parse_port(words[4])),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                  ntohs=
(haproxy_protocol_parse_port(words[5])));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        return true;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    else if (strcmp(words[1], &quot;TCP6&quot;) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_DEBUG, &quot;PROXY protocol=
 v1: TCP6 protocol&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct in6_addr ip6_src_addr, ip6_dst_addr;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (inet_pton(AF_INET6, word=
s[2], &amp;ip6_src_addr) !=3D 1)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(M_NONFATAL,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                &quot;PROXY protocol v1: could not parse source =
address&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (inet_pton(AF_INET6, words[3], &amp;ip6_dst_addr) !=3D 1)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            msg(M_NONFATAL,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                &quot;PROXY protocol=
 v1: could not parse destination address&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            return false;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        haproxy_protocol_set_addr(hpi, version, AF=
_INET6, SOCK_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                  &amp;ip6_src_addr, &amp;ip6_dst_addr,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
            ntohs(haproxy_protocol_parse_port(words[4])),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                  nto=
hs(haproxy_protocol_parse_port(words[5])));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        return true;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
NONFATAL, &quot;PROXY protocol v1: unsupported protocol&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Parse the PROXY p=
rotocol v2 header</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param hpi - The=
 haproxy protocol info structure to store the parsed data.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @return - The number of bytes parsed.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+haproxy_protocol_parse_v2(struct haproxy_protocol_info *hpi)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t addr_len =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int pos =3D HAPROXY_PROTOCOL_V=
2_SIG_LEN + sizeof(header-&gt;v2.ver_cmd);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    const haproxy_protocol_version_t version =3D HAP=
ROXY_PROTOCOL_VERSION_2;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    switch (he=
ader-&gt;v2.ver_cmd &amp; HAPROXY_PROTOCOL_V2_CMD_MASK)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_V2_LOCAL_CMD:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * this command is sen=
t by the proxy for health-checks and similar</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+             * and it doesn&#39;t make much sense =
in the openvpn context, so we</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * ignore the whole header</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2: =
LOCAL command&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_IGNORE;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_V2_PROXY_CMD:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DE=
BUG, &quot;PROXY protocol v2: PROXY command&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        default:</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2: unknown comma=
nd&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   parsing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_INVALID;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (parsing_state !=3D HAPROXY_PROTOCOL_PARSING_STATE_OK)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return pos;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    pos +=3D sizeof(header-&gt;v2.fam);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    switch (header-&gt;v2.fam)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROT=
OCOL_V2_TP_STREAM:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_DEBUG, &quot;PROXY protocol v2: TCP over IPv4.&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            haproxy_pro=
tocol_set_addr(hpi, version, AF_INET, SOCK_STREAM,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                      &amp;h=
eader-&gt;v2.addr.ip4.src_addr,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                      &amp;header-&gt;v2.addr.i=
p4.dst_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                               header-&gt;v2.addr.ip4.src_port,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
       header-&gt;v2.addr.ip4.dst_port);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            addr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_=
IPV4;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            br=
eak;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_V2_A=
F_INET | HAPROXY_PROTOCOL_V2_TP_DGRAM:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY protocol v2: UDP ov=
er IPv4&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        haproxy_protocol_set_addr(hpi, version, AF_INET, SOCK_DGRAM,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
            &amp;header-&gt;v2.addr.ip4.src_addr,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                      &amp;he=
ader-&gt;v2.addr.ip4.dst_addr,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                      header-&gt;v2.addr.ip4.src=
_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                         header-&gt;v2.addr.ip4.dst_port);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            addr_len =3D HAPROXY_PRO=
TOCOL_V2_ADDR_LEN_IPV4;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        case HAP=
ROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_STREAM:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &quot;PROXY=
 protocol v2: TCP over IPv6&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            haproxy_protocol_set_addr(hpi, version, AF_INET=
6, SOCK_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                                  header-&gt;v2.addr.ip6.src_addr,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
          header-&gt;v2.addr.ip6.dst_addr,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                      header-&gt;v2.=
addr.ip6.src_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                     header-&gt;v2.addr.ip6.dst_port);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr_len =3D=
 HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    case HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_DGRAM:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEBUG, =
&quot;PROXY protocol v2: UDP over IPv6&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            haproxy_protocol_set_addr(hpi, versi=
on, AF_INET6, SOCK_DGRAM,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                      header-&gt;v2.addr.ip6.src_addr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                    header-&gt;v2.addr.ip6.dst_addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                      hea=
der-&gt;v2.addr.ip6.src_port,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                      header-&gt;v2.addr.ip6.dst_=
port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            a=
ddr_len =3D HAPROXY_PROTOCOL_V2_ADDR_LEN_IPV6;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        case HAPROXY_PROTOCOL_V2_AF_UNIX | HAPROXY_PROTOCOL_V2_TP_ST=
REAM:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ms=
g(M_DEBUG, &quot;PROXY protocol v2: AF_UNIX stream&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            haproxy_protocol_set_add=
r(hpi, version, AF_UNIX, SOCK_STREAM,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                      header-&gt;v2.addr.=
unx.src_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                                header-&gt;v2.addr.unx.dst_addr, 0, 0);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            addr_len =
=3D HAPROXY_PROTOCOL_V2_ADDR_LEN_UNIX;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            break;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       case HAPROXY_PROTOCOL_V2_AF_UNIX | HAPROXY_PROTOCOL_V2_TP_DGRAM:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEBUG=
, &quot;PROXY protocol v2: AF_UNIX datagram&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            haproxy_protocol_set_addr(hpi=
, version, AF_UNIX, SOCK_DGRAM,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                      header-&gt;v2.addr.unx.sr=
c_addr,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                          header-&gt;v2.addr.unx.dst_addr, 0, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            addr_len =3D HAPR=
OXY_PROTOCOL_V2_ADDR_LEN_UNIX;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            break;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        d=
efault:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
if ((header-&gt;v2.fam &amp; HAPROXY_PROTOCOL_V2_AF_MASK) =3D=3D HAPROXY_PR=
OTOCOL_V2_AF_UNSPEC</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                || (header-&gt;v2.fam &amp; HAPROXY_PROTOCOL_V2_TP_MASK) =
=3D=3D HAPROXY_PROTOCOL_V2_TP_UNSPEC)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                msg(M_DEBUG, &quot;PROXY protocol v2: UNSPEC ad=
dress family or transport protocol&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                parsing_state =3D HAPROXY_PROTOCOL_P=
ARSING_STATE_IGNORE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                break;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          msg(M_DEBUG, &quot;PROXY protocol v2: unknown address family (0x%=
02x) &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        &quot;or transport protocol (0x%02x)&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                header-&gt;v2.fam &amp; H=
APROXY_PROTOCOL_V2_AF_MASK,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                header-&gt;v2.fam &amp; HAPROXY_PROTOCOL_V2_TP_MASK=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            parsi=
ng_state =3D HAPROXY_PROTOCOL_PARSING_STATE_IGNORE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    return (int)(pos + sizeof(header-&gt;v2.len) + addr=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+haproxy_protocol_parse(struct haproxy_protocol_info *hpi, const u=
int8_t *buf, const int buf_len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
nst haproxy_protocol_version_t version =3D haproxy_protocol_version(buf, bu=
f_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    header_l=
en =3D buf_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
header =3D (haproxy_protocol_header_t *)buf;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!hpi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_=
NONFATAL, &quot;PROXY protocol: invalid haproxy protocol info structure&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    switch (version)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case HAPROXY_PROTOCOL_VERSION_2:</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if ((header-&gt;v2.ver_cmd &amp; HAP=
ROXY_PROTOCOL_V2_VER_MASK) =3D=3D HAPROXY_PROTOCOL_V2_VER)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                haproxy_protocol_parse_v2=
(hpi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (parsing_state !=3D HAPROXY_PROTOCOL_PARSING_STATE_OK)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    msg(M_DEBUG, &qu=
ot;PROXY protocol v2: %s header&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        parsing_state =3D=3D HAPROXY_PRO=
TOCOL_PARSING_STATE_IGNORE ? &quot;ignoring&quot; : &quot;invalid&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    r=
eturn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 msg(M_NONFATAL, &quot;PROXY protocol v2: expected version 2, got %d&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 (header-&gt;v2.ver_cmd &amp; HAPROXY_PROTOCOL_V2_VER_MASK) &gt;&gt; 4);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        case HAPROXY_PROTOCOL_VERSION_1:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_DEBUG, &=
quot;PROXY protocol header v1: %.*s&quot;, header_len - 2, header-&gt;v1.li=
ne);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ret=
urn haproxy_protocol_parse_v1(hpi, header-&gt;v1.line, header_len);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        default:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_reset(struct ha=
proxy_protocol_info *hpi)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    header =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    header=
_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pars=
ing_state =3D HAPROXY_PROTOCOL_PARSING_STATE_OK;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/hap=
roxy_protocol.h b/src/openvpn/haproxy_protocol.h</span><br><span>new file m=
ode 100644</span><br><span>index 0000000..5ffcfa5</span><br><span>--- /dev/=
null</span><br><span>+++ b/src/openvpn/haproxy_protocol.h</span><br><span>@=
@ -0,0 +1,185 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             over a single TCP/UDP port, with suppor=
t for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *             session authentication and key exchange,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption, packe=
t authentication, and</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             packet compression.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is free software; you can redis=
tribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *  it under the terms of the GNU General Public License version 2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by the=
 Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is distributed in the hope that it will be useful,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without=
 even the implied warranty of</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Pub=
lic License for more details.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You=
 should have received a copy of the GNU General Public License along</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if =
not, write to the Free Software Foundation, Inc.,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, =
MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAPROXY_PROTOCOL_H</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;openvpn.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socke=
t.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdbool.h&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdint.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* https://www.haproxy.org/download=
/1.8/doc/proxy-protocol.txt */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
HAPROXY_PROTOCOL_V1_SIG          &quot;PROXY&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V1_SIG_LEN      5</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTO=
COL_V1_MIN_HDR_LEN  8</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define HAPROXY_PROTOCOL_V1_LINE_MAX_LEN 108</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define HAPROXY_PROTOCOL_V2_SIG         &quot;\x0D\x0A\x0D\x0A\x00\=
x0D\x0A\x51\x55\x49\x54\x0A&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define HAPROXY_PROTOCOL_V2_SIG_LEN     12</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_MIN_HDR_LE=
N 16</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_VER_MA=
SK 0xF0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPR=
OXY_PROTOCOL_V2_VER      (0x2 &lt;&lt; 4)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define HAPROXY_PROTOCOL_V2_CMD_MASK  0x0F</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_LOCAL_CMD (0x0 &lt;&l=
t; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROX=
Y_PROTOCOL_V2_PROXY_CMD (0x1 &lt;&lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define HAPROXY_PROTOCOL_V2_AF_MASK   0xF0</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_AF_UNSPEC (0x0 &lt;&lt=
; 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY=
_PROTOCOL_V2_AF_INET   (0x1 &lt;&lt; 4)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_AF_INET6  (0x2 &lt;&lt; 4)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROT=
OCOL_V2_AF_UNIX   (0x3 &lt;&lt; 4)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine HAPROXY_PROTOCOL_V2_TP_MASK   0x0F</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_TP_UNSPEC (0x0 &lt;&lt; 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTO=
COL_V2_TP_STREAM (0x1 &lt;&lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define HAPROXY_PROTOCOL_V2_TP_DGRAM  (0x2 &lt;&lt; 0)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_TLV_TYPE_ALPN       =
     0x01</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HA=
PROXY_PROTOCOL_TLV_TYPE_AUTHORITY       0x02</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_TLV_TYPE_CRC32C          =
0x03</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY=
_PROTOCOL_TLV_TYPE_NOOP            0x04</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_TLV_TYPE_UNIQUE_ID       0x05<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROT=
OCOL_TLV_TYPE_SSL             0x20</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_VERSION  0x21</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_=
TLV_SUBTYPE_SSL_CN       0x22</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_CIPHER   0x23</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_TLV_S=
UBTYPE_SSL_SIG_ALG  0x24</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#define HAPROXY_PROTOCOL_TLV_SUBTYPE_SSL_KEY_ALG  0x25</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_TLV_TYPE_N=
ETNS           0x30</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PRO=
TOCOL_V2_CLIENT_SSL          0x01</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#define HAPROXY_PROTOCOL_V2_CLIENT_CERT_CONN    0x02</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROXY_PROTOCOL_V2_=
CLIENT_CERT_SESS    0x04</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAPROX=
Y_PROTOCOL_V2_TLV_UNIQUE_ID_MAX_LEN 128</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+typedef enum</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_VER=
SION_INVALID =3D -1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOC=
OL_VERSION_UNKNOWN =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    HAPROXY_PROTOCOL_VERSION_1,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    HAPROXY_PROTOCOL_VERSION_2,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+} haproxy_protocol_version_t;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#pragma pack(push, 1)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+typedef union</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        char line[HAPROX=
Y_PROTOCOL_V1_LINE_MAX_LEN];</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    } v1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t sig[HAPR=
OXY_PROTOCOL_V2_SIG_LEN];</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uint8_t ver_cmd;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        uint8_t fam;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        uint16_t len;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        union</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          struct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       uint32_t src_addr;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                uint32_t dst_addr;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                uint16_t src_port;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                uint16_t dst_port;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            } ip4;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                uint8_t src_addr=
[16];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  uint8_t dst_addr[16];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                uint16_t src_port;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                uint16_t dst_port;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            } ip6;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            struct</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                uint8_t src_addr[108];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                uint8_t dst_=
addr[108];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   } unx;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        } =
addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } v2;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+} __attribute__((packed)=
) haproxy_protocol_header_t;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#pragma pack(pop)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct hapro=
xy_protocol_info</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_=
version_t version;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int sock_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct openvpn_sockaddr src;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct openvpn_sockaddr dst;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * Check if the buffer contai=
ns an PROXY protocol header and return the version.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param buf - The buffer to check.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf_len - The length of the buf=
fer.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @return - The PROXY protocol =
version or HAPROXY_PROTOCOL_VERSION_INVALID if</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *          the buffer does not contain a valid =
PROXY protocol header.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_proto=
col_version_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+haprox=
y_protocol_version(const uint8_t *buf, int buf_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Get the length of the PROXY protocol header.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * This function does not check if the header is =
fully contained in the buffer</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * therefore it is the caller&#39;s responsibility to perform thi=
s check.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf - The buffer t=
o check.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param b=
uf_len - The length of the buffer.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param version - The PROXY protocol version.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @return - The length of the header or -1 if th=
e header is partial or invalid.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_hea=
der_len(const uint8_t *buf, int len, haproxy_protocol_version_t version);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Parse the PROXY protocol header.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param hpi - The proxy protocol info structure to store=
 the parsed data.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param buf - The header to parse.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param buf_len - The length of the header.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param version - The version of=
 the PROXY protocol.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return - tru=
e if the header was successfully parsed.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_pr=
otocol_parse(struct haproxy_protocol_info *hpi, const uint8_t *buf, int buf=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * Free the allocated memory.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param hpi - The proxy protocol info structure.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+haproxy_protocol_reset(struct haproxy_protocol_info *hpi=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAPROXY_PROTOCOL_H */</spa=
n><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br>=
<span>index a49e563..ecd3253 100644</span><br><span>--- a/src/openvpn/init.=
c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -54,6 +54,7 @=
@</span><br><span> #include &quot;mss.h&quot;</span><br><span> #include &qu=
ot;mudp.h&quot;</span><br><span> #include &quot;dco.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;haproxy_protocol.h&q=
uot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span=
><br><span> </span><br><span>@@ -3926,6 +3927,14 @@</span><br><span> </span=
><br><span>         c-&gt;c1.link_socket_addr.bind_local =3D NULL;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Clear and free th=
e memory allocated for the HAProxy protocol */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (c-&gt;c1.haproxy_protocol)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        haproxy_protocol_reset(c-&gt;c1.haproxy=
_protocol);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
free(c-&gt;c1.haproxy_protocol);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        c-&gt;c1.haproxy_protocol =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><sp=
an> </span><br><span> /*</span><br><span>@@ -4774,7 +4783,7 @@</span><br><s=
pan>         /* free up environmental variable store */</span><br><span>   =
      do_env_set_destroy(c);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        /* close HTTP or SOCKS proxy */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* close HTTP or SOCKS=
 proxy or PROXY protocol object */</span><br><span>         uninit_proxy(c)=
;</span><br><span> </span><br><span>         /* garbage collect */</span><b=
r><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><s=
pan>index 03177bb..e6441cd 100644</span><br><span>--- a/src/openvpn/multi.c=
</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -51,6 +51,7 @=
@</span><br><span> #include &quot;ssl_util.h&quot;</span><br><span> #includ=
e &quot;dco.h&quot;</span><br><span> #include &quot;reflect_filter.h&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;hapro=
xy_protocol.h&quot;</span><br><span> </span><br><span> /*#define MULTI_DEBU=
G_EVENT_LOOP*/</span><br><span> </span><br><span>@@ -779,6 +780,8 @@</span>=
<br><span>         goto err;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(mi-&g=
t;context.c1.haproxy_protocol, struct haproxy_protocol_info);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     mi-&gt;cont=
ext.c2.tls_multi-&gt;multi_state =3D CAS_NOT_CONNECTED;</span><br><span> </=
span><br><span>     if (hash_n_elements(m-&gt;hash) &gt;=3D m-&gt;max_clien=
ts)</span><br><span>@@ -789,6 +792,9 @@</span><br><span> </span><br><span> =
    if (!real) /* TCP mode? */</span><br><span>     {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* allow checking for HAProxy pro=
tocol header at the beginning of the connection */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        mi-&gt;context.c2.link_socket-&gt;ha=
proxy_protocol_allowed =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>         if (!multi_tcp_instance_specific_ini=
t(m, mi))</span><br><span>         {</span><br><span>             goto err;=
</span><br><span>@@ -3207,6 +3213,57 @@</span><br><span>     gc_free(&amp;g=
c);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+multi_replace_proxy_addr(struct multi_context *m, struct multi_instan=
ce *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct mroute_addr real =
=3D {0};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (!mroute_extract_openvpn_sockaddr(&amp;real, &amp;mi-&gt;contex=
t.c1.haproxy_protocol-&gt;src, true))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        goto done;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const uint32_t hv =3D hash=
_value(hash, &amp;real);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /* if the new address is already in the hash ta=
ble, the new client takes precedence */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct hash_element *he =3D hash_lookup_fast(hash, =
bucket, &amp;real, hv);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (he)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct mul=
ti_instance *oldmi =3D (struct multi_instance *) he-&gt;value;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_LOW, &quot;C=
lient&#39;s real address (behind proxy) matches &quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;existing client addres=
s -- new client takes precedence&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        oldmi-&gt;did_real_hash =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        multi_close_instance(m,=
 oldmi, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    he-&gt;key =3D &amp;mi-&gt;real;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        he-&gt;value =3D mi;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cle=
ar_prefix();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg=
(D_MULTI_LOW, &quot;Replacing proxy address: %s with client&#39;s real addr=
ess: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   mroute_addr_print(&amp;mi-&gt;real, &amp;gc),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        mroute_addr_print(&amp;real, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* remove proxy address from hash=
 table before changing address */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(hash_remove(m-&gt;hash, &amp;mi-&gt;real));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_remove(m-&=
gt;iter, &amp;mi-&gt;real));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt=
;real =3D real;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
generate_prefix(mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_ad=
d(m-&gt;hash, &amp;mi-&gt;real, mi, false));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m-&gt;iter, &amp;mi-&gt;real, =
mi, false));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(hash_add(m=
-&gt;cid_hash, &amp;mi-&gt;context.c2.mda_context.cid, mi, true));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+done:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> /*</span><br><span>  * Called when an instance should be closed due to t=
he</span><br><span>  * reception of a soft signal.</span><br><span>@@ -3348=
,6 +3405,7 @@</span><br><span>     struct mroute_addr src, dest;</span><br>=
<span>     unsigned int mroute_flags;</span><br><span>     struct multi_ins=
tance *mi;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t link_socket_info *lsi;</span><br><span>     bool ret =3D true;</span><br>=
<span>     bool floated =3D false;</span><br><span> </span><br><span>@@ -33=
87,15 +3445,29 @@</span><br><span>             }</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* check for PROXY protocol */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (lsi-&gt;proto =3D=3D PROTO_TCP_SERVER &amp;=
&amp; c-&gt;c2.link_socket-&gt;haproxy_protocol_allowed &amp;&amp; BLEN(&am=
p;c-&gt;c2.buf) &gt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (haproxy_protocol_parse(c-&gt;c1.haproxy_protocol, BPTR(&amp;c-&gt=
;c2.buf), BLEN(&amp;c-&gt;c2.buf)))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* replace proxy address with real address */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                multi_r=
eplace_proxy_addr(m, m-&gt;pending);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                /* avoid processing the packet as an openv=
pn one */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      buf_reset_len(&amp;c-&gt;c2.buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            /* stop checking for HAProxy protocol headers */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2=
.link_socket-&gt;haproxy_protocol_allowed =3D false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span>         if (BLEN(&amp;c-&gt;c2.bu=
f) &gt; 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            struct link_socket_info *lsi;</span><br><span> =
            const uint8_t *orig_buf;</span><br><span> </span><br><span>    =
         /* decrypt in instance context */</span><br><span> </span><br><spa=
n>             perf_push(PERF_PROC_IN_LINK);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            lsi =3D get_link_socket_info(c);</span><=
br><span>             orig_buf =3D c-&gt;c2.buf.data;</span><br><span>     =
        if (process_incoming_link_part1(c, lsi, floated))</span><br><span> =
            {</span><br><span>diff --git a/src/openvpn/openvpn.h b/src/open=
vpn/openvpn.h</span><br><span>index e98c93e..a192f7a 100644</span><br><span=
>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/src/openvpn/openvpn.h</s=
pan><br><span>@@ -45,6 +45,7 @@</span><br><span> #include &quot;pool.h&quot=
;</span><br><span> #include &quot;plugin.h&quot;</span><br><span> #include =
&quot;manage.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#include &quot;haproxy_protocol.h&quot;</span><br><span> </span><br><span>=
 /*</span><br><span>  * Our global key schedules, packaged thusly</span><br=
><span>@@ -191,6 +192,8 @@</span><br><span>     struct socks_proxy_info *so=
cks_proxy;</span><br><span>     bool socks_proxy_owned;</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct haproxy_pr=
otocol_info *haproxy_protocol;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     /* persist --ifconfig-pool db to file */</=
span><br><span>     struct ifconfig_pool_persist *ifconfig_pool_persist;</s=
pan><br><span>     bool ifconfig_pool_persist_owned;</span><br><span>diff -=
-git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 17=
c5e76..f096a20 100644</span><br><span>--- a/src/openvpn/socket.c</span><br>=
<span>+++ b/src/openvpn/socket.c</span><br><span>@@ -39,6 +39,7 @@</span><b=
r><span> #include &quot;manage.h&quot;</span><br><span> #include &quot;open=
vpn.h&quot;</span><br><span> #include &quot;forward.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;haproxy_protocol.h&q=
uot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span=
><br><span> </span><br><span>@@ -1617,7 +1618,7 @@</span><br><span> stream_=
buf_close(struct stream_buf *sb);</span><br><span> </span><br><span> static=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_added=
(struct stream_buf *sb, int length_added);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+stream_buf_added(struct stream_buf *sb, int length_a=
dded, bool haproxy_protocol_allowed);</span><br><span> </span><br><span> /*=
 For stream protocols, allocate a buffer to build up packet.</span><br><spa=
n>  * Called after frame has been finalized. */</span><br><span>@@ -2629,7 =
+2630,7 @@</span><br><span>     {</span><br><span>         ASSERT(buf_copy(=
&amp;sock-&gt;stream_buf.buf, &amp;sock-&gt;stream_buf.residual));</span><b=
r><span>         ASSERT(buf_init(&amp;sock-&gt;stream_buf.residual, 0));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock-&gt;stream_=
buf.residual_fully_formed =3D stream_buf_added(&amp;sock-&gt;stream_buf, 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;s=
tream_buf.residual_fully_formed =3D stream_buf_added(&amp;sock-&gt;stream_b=
uf, 0, false);</span><br><span>         dmsg(D_STREAM_DEBUG, &quot;STREAM: =
RESIDUAL FULLY FORMED [%s], len=3D%d&quot;,</span><br><span>              s=
ock-&gt;stream_buf.residual_fully_formed ? &quot;YES&quot; : &quot;NO&quot;=
,</span><br><span>              sock-&gt;stream_buf.residual.len);</span><b=
r><span>@@ -2644,7 +2645,8 @@</span><br><span> </span><br><span> static boo=
l</span><br><span> stream_buf_added(struct stream_buf *sb,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                 int length_added)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                 int le=
ngth_added,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         const bool haproxy_protocol_allowed)</span><br><span> {</span><br>=
<span>     dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD length_added=3D%d&quot;, =
length_added);</span><br><span>     if (length_added &gt; 0)</span><br><spa=
n>@@ -2680,10 +2682,26 @@</span><br><span> </span><br><span>         if (sb=
-&gt;len &lt; 1 || sb-&gt;len &gt; sb-&gt;maxlen)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WA=
RN, &quot;WARNING: Bad encapsulated packet length from peer (%d), which mus=
t be &gt; 0 and &lt;=3D %d -- please ensure that --tun-mtu or --link-mtu is=
 equal on both peers -- this condition could also indicate a possible activ=
e attack on the TCP link -- [Attempting restart...]&quot;, sb-&gt;len, sb-&=
gt;maxlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  stream_buf_reset(sb);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            sb-&gt;error =3D true;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            return false;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            haproxy_protocol_version_t hp_version =3D =
HAPROXY_PROTOCOL_VERSION_UNKNOWN;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            int hp_len =3D -1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* if it&#39;s allowed (first packet),=
 check for a HAProxy protocol header */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if (haproxy_protocol_allowed)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                /* undo the reading of =
net_size */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        ASSERT(buf_prepend(&amp;sb-&gt;buf, sizeof(net_size)));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                hp_version =3D =
haproxy_protocol_version(BPTR(&amp;sb-&gt;buf), BLEN(&amp;sb-&gt;buf));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                hp_len =
=3D haproxy_protocol_header_len(BPTR(&amp;sb-&gt;buf), BLEN(&amp;sb-&gt;buf=
), hp_version);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            /* we do not allo=
w partial headers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (hp_version &lt;=3D 0 || hp_len &lt; 0 || hp_len &gt; sb-&g=
t;buf.len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 msg(M_WARN, &quot;WARNING: Bad encapsulated packet length from peer (%d), =
which must be &gt; 0 and &lt;=3D %d -- please ensure that --tun-mtu or --li=
nk-mtu is equal on both peers -- this condition could also indicate a possi=
ble active attack on the TCP link -- [Attempting restart...]&quot;, sb-&gt;=
len, sb-&gt;maxlen);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                stream_buf_reset(sb);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                sb-&gt;error =3D true;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            sb-&gt;len =3D hp_len=
;</span><br><span>         }</span><br><span>     }</span><br><span> </span=
><br><span>@@ -3267,7 +3285,7 @@</span><br><span>     }</span><br><span> </=
span><br><span>     if (sock-&gt;stream_buf.residual_fully_formed</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        || stream_buf_added(&am=
p;sock-&gt;stream_buf, len)) /* packet complete? */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        || stream_buf_added(&amp;sock-&gt=
;stream_buf, len, sock-&gt;haproxy_protocol_allowed)) /* packet complete? *=
/</span><br><span>     {</span><br><span>         stream_buf_get_final(&amp=
;sock-&gt;stream_buf, buf);</span><br><span>         stream_buf_reset(&amp;=
sock-&gt;stream_buf);</span><br><span>diff --git a/src/openvpn/socket.h b/s=
rc/openvpn/socket.h</span><br><span>index 47083ad..1132b35 100644</span><br=
><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.=
h</span><br><span>@@ -227,6 +227,9 @@</span><br><span>     const char *prox=
y_dest_host;</span><br><span>     const char *proxy_dest_port;</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check H=
AProxy PROXY protocol only if true */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    bool haproxy_protocol_allowed;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Pointer to the s=
erver-poll to trigger the timeout in function which have</span><br><span>  =
    * their own loop instead of using the main oop */</span><br><span>     =
struct event_timeout *server_poll_timeout;</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</s=
pan><br><span>index a4e6235..1802132 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/=
Makefile.am</span><br><span>@@ -10,8 +10,9 @@</span><br><span> test_binarie=
s +=3D argv_testdriver buffer_testdriver</span><br><span> endif</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries +=
=3D crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_testdr=
iver misc_testdriver \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	pkt_testdriver ssl_testdriver user_pass_testdriver</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_binaries +=3D crypto_testdriver pack=
et_id_testdriver auth_token_testdriver \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+				 haproxy_protocol_testdriver ncp_testdriver misc_t=
estdriver \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				 pkt=
_testdriver ssl_testdriver user_pass_testdriver</span><br><span> </span><br=
><span> if HAVE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><br><span>=
@@ -73,6 +74,16 @@</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/mss.c</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_testdri=
ver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-=
I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/comp=
at \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@TEST_CFLAGS@<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_tes=
tdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+haproxy_protocol_testdriver_SOURCES =3D test_haproxy_protoco=
l.c mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	mock_get_random.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/h=
aproxy_protocol.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> ssl_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcd=
ir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span>=
<br><span> 	@TEST_CFLAGS@</span><br><span>diff --git a/tests/unit_tests/ope=
nvpn/test_haproxy_protocol.c b/tests/unit_tests/openvpn/test_haproxy_protoc=
ol.c</span><br><span>new file mode 100644</span><br><span>index 0000000..04=
64315</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_haproxy_protocol.c</span><br><span>@@ -0,0 +1,354 @@</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#include &quot;platform.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;haproxy_protocol.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_c=
ommon.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+extern uint32_t</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+haproxy_protocol_crc32c(const=
 uint8_t *data, int len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* header bui=
lding blocks */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine HP1_SIG           0x50, 0x52, 0x4f, 0x58, 0x59 /* &quot;PROXY&quot; */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HP1_TCP4_AF_=
UNKN  0x55, 0x4E, 0x4B, 0x4E, 0x4F, 0x57, 0x4E /* &quot;UNKNOWN&quot; */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HP1_TCP4_AF_IN=
ET  0x54, 0x43, 0x50, 0x34 /* &quot;TCP4&quot; */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define HP1_TCP6_AF_INET  0x54, 0x43, 0x50, 0=
x36 /* &quot;TCP6&quot; */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define HP1_TCP4_SRC_ADDR 0x31, 0x30, 0x2e, 0x31, 0x30, 0x2e, 0x32, =
0x30, 0x2e, 0x32 /* &quot;10.10.20.2&quot; */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define HP1_TCP4_DST_ADDR 0x31, 0x30, 0x2e, 0x31,=
 0x30, 0x2e, 0x32, 0x30, 0x2e, 0x31 /* &quot;10.10.20.1&quot; */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#define HP1_TCP4_SRC_PORT 0x34=
, 0x30, 0x31, 0x35, 0x30 /* 40150 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define HP1_TCP4_DST_PORT 0x31, 0x31, 0x39, 0x35 /* 1195 *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HP1_TCP6_S=
RC_ADDR 0x32, 0x30, 0x30, 0x31, 0x3a, 0x64, 0x62, 0x38, 0x3a, 0x32, 0x30, 0=
x3a, 0x3a, 0x32 /* &quot;2001:db8:20::2&quot; */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define HP1_TCP6_DST_ADDR 0x32, 0x30, 0x30, 0x=
31, 0x3a, 0x64, 0x62, 0x38, 0x3a, 0x32, 0x30, 0x3a, 0x3a, 0x31 /* &quot;200=
1:db8:20::1&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define HP1_TCP6_SRC_PORT 0x35, 0x33, 0x33, 0x34, 0x34 /* 53344 */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define HP1_TCP6_DST_PORT 0=
x31, 0x31, 0x39, 0x35 /* 1195 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define HP1_END           0x0d, 0x0a /* &quot;\r\n&quot; */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define HP2_SIG         0x0d, 0x0a, 0x0d,=
 0x0a, 0x00, 0x0d, 0x0a, 0x51, 0x55, 0x49, 0x54, 0x0a /* &quot;\r\n\r\n\x00=
\r\nQUIT\n&quot; */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define HP2_V4_SRC_ADDR 0x0a, 0x0a, 0x14, 0x02 /* 10.10.20.2 */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define HP2_V4_DST_ADDR 0x0a, 0=
x0a, 0x14, 0x01 /* 10.10.20.1 */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define HP2_V4_SRC_PORT 0xa5, 0x30 /* 42288 */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define HP2_V4_DST_PORT 0x04, 0xab =
/* 1195 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define H=
P2_V6_SRC_ADDR 0x20, 0x01, 0x0d, 0xb8, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, =
0x00, 0x00, 0x00, 0x00, 0x00, 0x02 /* 2001:db8:20::2 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define HP2_V6_DST_ADDR 0x20, 0x01, 0x0=
d, 0xb8, 0x00, 0x20, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, =
0x01 /* 2001:db8:20::1 */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define HP2_V6_SRC_PORT 0xe8, 0xb6 /* 59574 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define HP2_V6_DST_PORT 0x04, 0xab /* 119=
5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HP2_TLV=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x01, 0x00, 0=
x03, &#39;h&#39;, &#39;2&#39;, &#39;3&#39;, \</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    0x02, 0x00, 0x0b, &#39;e&#39;, &#39;x&#39;, &=
#39;a&#39;, &#39;m&#39;, &#39;p&#39;, &#39;l&#39;, &#39;e&#39;, &#39;.&#39;=
, &#39;c&#39;, &#39;o&#39;, &#39;m&#39;, \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    0x04, 0x00, 0x00, \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    0x05, 0x00, 0x0f, &#39;u&#39;, &#39;n&#39;, =
&#39;i&#39;, &#39;q&#39;, &#39;u&#39;, &#39;e&#39;, &#39;-&#39;, &#39;i&#39=
;, &#39;d&#39;, &#39;-&#39;, &#39;v&#39;, &#39;a&#39;, &#39;l&#39;, &#39;u&=
#39;, &#39;e&#39;, \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    0x20, 0x00, 0x33, 0x01, 0x00, 0x00, 0x00, 0x00, \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    0x21, 0x00, 0x06, &#39;T&#39;, &#39;=
L&#39;, &#39;S&#39;, &#39;1&#39;, &#39;.&#39;, &#39;3&#39;, \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    0x22, 0x00, 0x06, &#39;c&#39;=
, &#39;l&#39;, &#39;i&#39;, &#39;e&#39;, &#39;n&#39;, &#39;t&#39;, \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0x23, 0x00, 0x06, &#39=
;A&#39;, &#39;E&#39;, &#39;S&#39;, &#39;2&#39;, &#39;5&#39;, &#39;6&#39;, \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x24, 0x00, 0x0=
6, &#39;S&#39;, &#39;H&#39;, &#39;A&#39;, &#39;2&#39;, &#39;5&#39;, &#39;6&=
#39;, \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x25, 0x=
00, 0x07, &#39;R&#39;, &#39;S&#39;, &#39;A&#39;, &#39;2&#39;, &#39;0&#39;, =
&#39;4&#39;, &#39;8&#39;, \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    0x30, 0x00, 0x07, &#39;n&#39;, &#39;e&#39;, &#39;t&#39;, &#39;n=
&#39;, &#39;s&#39;, &#39;-&#39;, &#39;1&#39;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define HP_TEST_OPENVPN \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    0x00, 0x0e, 0x38, 0xa8, 0xf5, 0x24, 0xa0, 0xa7, \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    0x89, 0x00, 0xca, 0x00, 0=
x00, 0x00, 0x00, 0x00</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* headers */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint8_t HP1_TEST=
_UNKNOWN[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 HP1_SIG, 0x20, HP1_TCP4_AF_UNKN, HP1_END</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint8_t=
 HP1_TEST_TCP4[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    HP1_SIG, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    HP1_TCP4_AF_INET, 0x20,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    HP1_TCP4_SRC_ADDR, 0x20,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    HP1_TCP4_DST_ADDR, 0x20,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    HP1_TCP4_SRC_PORT, 0x20,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP4_DST_PORT,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    HP1_END</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic uint8_t HP1_TEST_TCP4_PLUS_OPENVPN[] =3D {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    HP1_SIG, 0x20,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    HP1_TCP4_AF_INET, 0x20,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP4_SRC_ADDR, 0x20,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP4_DST_ADDR, 0x20,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP4_SRC_PORT,=
 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP4_=
DST_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_EN=
D,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP_TEST_OPENV=
PN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static uint8_t HP1_TEST_TCP6[] =3D {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    HP1_SIG, 0x20,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP6_AF_INET, 0x20,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP6_SRC_ADDR, 0x20,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP6_DST_ADD=
R, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP=
6_SRC_PORT, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  HP1_TCP6_DST_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    HP1_END</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static uint8_t HP1_TEST_TCP6_PLUS_OPENVPN=
[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_SIG=
, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP1_TCP6=
_AF_INET, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
HP1_TCP6_SRC_ADDR, 0x20,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    HP1_TCP6_DST_ADDR, 0x20,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    HP1_TCP6_SRC_PORT, 0x20,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    HP1_TCP6_DST_PORT,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    HP1_END,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    HP_TEST_OPENVPN</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint8_t HP=
2_TEST_LOCAL[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    HP2_SIG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HA=
PROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_LOCAL_CMD,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_AF_UNSPEC | HAPR=
OXY_PROTOCOL_V2_TP_UNSPEC,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    0x00, 0x00 /* length */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static uint8_t HP2_TE=
ST_WRONG_VER[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    HP2_SIG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x=
10 | HAPROXY_PROTOCOL_V2_PROXY_CMD,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_ST=
REAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x00, 0x0c=
, /* length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    H=
P2_V4_SRC_ADDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
HP2_V4_DST_ADDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 HP2_V4_SRC_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  HP2_V4_DST_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static uint8_t HP2_TEST_PROXY_TCP4[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_SIG,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_=
V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_T=
P_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x00, =
0x7c, /* length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   HP2_V4_SRC_ADDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    HP2_V4_DST_ADDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    HP2_V4_SRC_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    HP2_V4_DST_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    HP2_TLV,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
0x03, 0x00, 0x04, 0x6e, 0x8a, 0xbf, 0x7f /* crc32c */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic uint8_t HP2_TEST_PROXY_TCP4_PLUS_OPENVPN[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    HP2_SIG,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V=
2_PROXY_CMD,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HAP=
ROXY_PROTOCOL_V2_AF_INET | HAPROXY_PROTOCOL_V2_TP_STREAM,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    0x00, 0x7c, /* length */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V4_SRC_ADDR,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V4_DST_ADDR,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V4_SRC_PORT,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V4_DST_PORT,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_TLV,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    0x03, 0x00, 0x04, 0x6e, 0x8=
a, 0xbf, 0x7f, /* crc32c */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    HP_TEST_OPENVPN</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static uint8_t HP2_TEST_PROX=
Y_TCP6[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    H=
P2_SIG,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_=
PROTOCOL_V2_VER | HAPROXY_PROTOCOL_V2_PROXY_CMD,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PRO=
TOCOL_V2_TP_STREAM,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    0x00, 0x94, /* length */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    HP2_V6_SRC_ADDR,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    HP2_V6_DST_ADDR,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    HP2_V6_SRC_PORT,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    HP2_V6_DST_PORT,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    HP2_TLV,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    0x03, 0x00, 0x04, 0xed, 0xb0, 0x61, 0xb6 /* crc32c */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static uint8_t HP2_TEST_PROXY_TCP6_PLUS_OPENVPN[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    HP2_SIG,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    HAPROXY_PROTOCOL_V2_VER | HAPROXY_=
PROTOCOL_V2_PROXY_CMD,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    HAPROXY_PROTOCOL_V2_AF_INET6 | HAPROXY_PROTOCOL_V2_TP_STREAM,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    0x00, 0x94, /* length =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V6_SRC_AD=
DR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V6_DST_A=
DDR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V6_SRC_=
PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_V6_DST=
_PORT,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    HP2_TLV,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    0x03, 0x00, 0x04=
, 0xed, 0xb0, 0x61, 0xb6, /* crc32c */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    HP_TEST_OPENVPN</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_haproxy_protocol_ver=
sion(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(haproxy_protocol_version(HP1_TEST_UNKNOWN, sizeof(HP1_TEST_UNKNOWN)), HAP=
ROXY_PROTOCOL_VERSION_1);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(haproxy_protocol_version(HP1_TEST_TCP4, sizeof(H=
P1_TEST_TCP4)), HAPROXY_PROTOCOL_VERSION_1);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(haproxy_protocol_version(HP1_=
TEST_TCP6, sizeof(HP1_TEST_TCP6)), HAPROXY_PROTOCOL_VERSION_1);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(haproxy_pr=
otocol_version(HP2_TEST_WRONG_VER, sizeof(HP2_TEST_WRONG_VER)), HAPROXY_PRO=
TOCOL_VERSION_2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(haproxy_protocol_version(HP2_TEST_LOCAL, sizeof(HP2_TEST=
_LOCAL)), HAPROXY_PROTOCOL_VERSION_2);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(haproxy_protocol_version(HP2_TEST_P=
ROXY_TCP4, sizeof(HP2_TEST_PROXY_TCP4)), HAPROXY_PROTOCOL_VERSION_2);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(hapr=
oxy_protocol_version(HP2_TEST_PROXY_TCP6, sizeof(HP2_TEST_PROXY_TCP6)), HAP=
ROXY_PROTOCOL_VERSION_2);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(haproxy_protocol_version((uint8_t []){HP_TEST_OP=
ENVPN}, sizeof((uint8_t []){HP_TEST_OPENVPN})), HAPROXY_PROTOCOL_VERSION_IN=
VALID);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+test_haproxy_protocol_header_len(void **state)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(haproxy_protocol_header_len=
(HP1_TEST_UNKNOWN, sizeof(HP1_TEST_UNKNOWN), HAPROXY_PROTOCOL_VERSION_1), s=
izeof(HP1_TEST_UNKNOWN));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(haproxy_protocol_header_len(HP1_TEST_TCP4_PLUS_O=
PENVPN, sizeof(HP1_TEST_TCP4_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION_1), si=
zeof(HP1_TEST_TCP4));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(haproxy_protocol_header_len(HP1_TEST_TCP6_PLUS_OPENV=
PN, sizeof(HP1_TEST_TCP6_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION_1), sizeof=
(HP1_TEST_TCP6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_int_equal(haproxy_protocol_header_len(HP2_TEST_WRONG_VER, sizeof(H=
P2_TEST_WRONG_VER), HAPROXY_PROTOCOL_VERSION_2), sizeof(HP2_TEST_WRONG_VER)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(haproxy_protocol_header_len(HP2_TEST_LOCAL, sizeof(HP2_TEST_LOCAL), HAP=
ROXY_PROTOCOL_VERSION_2), sizeof(HP2_TEST_LOCAL));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_int_equal(haproxy_protocol_header=
_len(HP2_TEST_PROXY_TCP4_PLUS_OPENVPN, sizeof(HP2_TEST_PROXY_TCP4_PLUS_OPEN=
VPN), HAPROXY_PROTOCOL_VERSION_2), sizeof(HP2_TEST_PROXY_TCP4));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(haproxy_p=
rotocol_header_len(HP2_TEST_PROXY_TCP6_PLUS_OPENVPN, sizeof(HP2_TEST_PROXY_=
TCP6_PLUS_OPENVPN), HAPROXY_PROTOCOL_VERSION_2), sizeof(HP2_TEST_PROXY_TCP6=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(haproxy_protocol_header_len((uint8_t []){HP_TEST_OPENVPN}, sizeof((uin=
t8_t []){HP_TEST_OPENVPN}), HAPROXY_PROTOCOL_VERSION_INVALID), -1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+compare_hpi_basic(void **state, struct haproxy_protocol_info *actual, st=
ruct haproxy_protocol_info *expected)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (actual-&gt;src.addr.sa.sa_family !=3D expected-&gt;src.addr.sa.sa_f=
amily</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || act=
ual-&gt;dst.addr.sa.sa_family !=3D expected-&gt;dst.addr.sa.sa_family)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    switch (actual-&gt;src.addr.sa.sa_family)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        case AF_INET:</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return actual-&gt;version =3D=3D expected=
-&gt;version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
            &amp;&amp; actual-&gt;sock_type =3D=3D expected-&gt;sock_type</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   &a=
mp;&amp; memcmp(&amp;actual-&gt;src.addr.in4.sin_addr, &amp;expected-&gt;sr=
c.addr.in4.sin_addr, sizeof(struct in_addr)) =3D=3D 0</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                   &amp;&amp; memcmp(&amp=
;actual-&gt;dst.addr.in4.sin_addr, &amp;expected-&gt;dst.addr.in4.sin_addr,=
 sizeof(struct in_addr)) =3D=3D 0</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   &amp;&amp; actual-&gt;dst.addr.in4.sin_por=
t =3D=3D expected-&gt;dst.addr.in4.sin_port</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                   &amp;&amp; actual-&gt;src.addr.i=
n4.sin_port =3D=3D expected-&gt;src.addr.in4.sin_port;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        case AF_INET6:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return actual-&gt;version =3D=3D expected-&g=
t;version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
         &amp;&amp; actual-&gt;sock_type =3D=3D expected-&gt;sock_type</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   &amp;=
&amp; memcmp(&amp;actual-&gt;src.addr.in6, &amp;expected-&gt;src.addr.in6, =
sizeof(struct sockaddr_in6)) =3D=3D 0</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   &amp;&amp; memcmp(&amp;actual-&gt;dst.=
addr.in6, &amp;expected-&gt;dst.addr.in6, sizeof(struct sockaddr_in6)) =3D=
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        default:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+compare_hpi=
(void **state, struct haproxy_protocol_info *actual, struct haproxy_protoco=
l_info *expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return compare_h=
pi_basic(state, actual, expected);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+setup_parse(void **state)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct haproxy_protocol_info *actual;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR=
(actual, struct haproxy_protocol_info);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    *state =3D actual;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+teardown_parse(void **state)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_reset(*state);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    free(*state);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_haproxy_protocol_parse(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct haproxy_protocol_info *expected;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct haproxy_protocol_info *actual =3D *s=
tate;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ALLOC_OBJ_CLEAR(expected, str=
uct haproxy_protocol_info);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* v1 U=
NKNOWN protocol */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_false(haproxy_protocol_parse(actual, HP1_TEST_UNKNOWN, sizeof(HP1=
_TEST_UNKNOWN)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* v1 TCP4 */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset((actual), 0,=
 sizeof(struct haproxy_protocol_info));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    haproxy_protocol_reset(actual);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;version =3D HAPROXY_PR=
OTOCOL_VERSION_1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  expected-&gt;sock_type =3D SOCK_STREAM;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expected-&gt;src.addr.sa.sa_family =3D AF_INET;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;src.=
addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1402);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expected-&gt;src.addr.in4.sin_port =3D ntoh=
s(40150);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect=
ed-&gt;dst.addr.sa.sa_family =3D AF_INET;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expected-&gt;dst.addr.in4.sin_addr.s_addr =3D hto=
nl(0x0a0a1401);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
expected-&gt;dst.addr.in4.sin_port =3D ntohs(1195);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_parse(actual, HP1_TE=
ST_TCP4, sizeof(HP1_TEST_TCP4));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(compare_hpi(state, actual, expected));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /* v1 TCP6 */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    haproxy_protocol_reset(actual);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_reset(expec=
ted);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset((ac=
tual), 0, sizeof(struct haproxy_protocol_info));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    memset((expected), 0, sizeof(struct haprox=
y_protocol_info));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   expected-&gt;version =3D HAPROXY_PROTOCOL_VERSION_1;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;sock_type =3D SOCK_STR=
EAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&g=
t;src.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    expected-&gt;src.addr.in6.sin6_port =3D ntohs(5334=
4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_pton(AF=
_INET6, &quot;2001:db8:20::2&quot;, &amp;expected-&gt;src.addr.in6.sin6_add=
r);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt=
;dst.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    expected-&gt;dst.addr.in6.sin6_port =3D ntohs(1195)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_pton(AF_I=
NET6, &quot;2001:db8:20::1&quot;, &amp;expected-&gt;dst.addr.in6.sin6_addr)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    haproxy_protoc=
ol_parse(actual, HP1_TEST_TCP6, sizeof(HP1_TEST_TCP6));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(compare_hpi(state, actu=
al, expected));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* v2 wrong version=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    haproxy_prot=
ocol_reset(actual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    memset((actual), 0, sizeof(struct haproxy_protocol_info));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_false(haproxy_protoco=
l_parse(actual, HP2_TEST_WRONG_VER, sizeof(HP2_TEST_WRONG_VER)));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* v2 local */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    haproxy_protocol_reset(actual);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    memset((actual), 0, sizeof(st=
ruct haproxy_protocol_info));</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_false(haproxy_protocol_parse(actual, HP2_TEST_LOCAL, s=
izeof(HP2_TEST_LOCAL)));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* v2 TCP4=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    haproxy_prot=
ocol_reset(actual);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    haproxy_protocol_reset(expected);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    memset((actual), 0, sizeof(struct haproxy_protocol_in=
fo));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memset((ex=
pected), 0, sizeof(struct haproxy_protocol_info));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    expected-&gt;version =3D HAPROXY_PROTOCO=
L_VERSION_2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exp=
ected-&gt;sock_type =3D SOCK_STREAM;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    expected-&gt;src.addr.in4.sin_family =3D AF_INET;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;src.add=
r.in4.sin_port =3D ntohs(42288);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    expected-&gt;src.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a=
1402);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-=
&gt;dst.addr.in4.sin_family =3D AF_INET;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    expected-&gt;dst.addr.in4.sin_port =3D ntohs(1195)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;d=
st.addr.in4.sin_addr.s_addr =3D htonl(0x0a0a1401);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    haproxy_protocol_parse(actual, HP2_TEST_=
PROXY_TCP4, sizeof(HP2_TEST_PROXY_TCP4));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(compare_hpi(state, actual, expected))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* v2 TCP6 */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_reset(actual);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    haproxy_protocol_re=
set(expected);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
emset((actual), 0, sizeof(struct haproxy_protocol_info));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    memset((expected), 0, sizeof(stru=
ct haproxy_protocol_info));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expected-&gt;version =3D HAPROXY_PROTOCOL_VERSION_2;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    expected-&gt;sock_type =3D=
 SOCK_STREAM;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ex=
pected-&gt;src.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    expected-&gt;src.addr.in6.sin6_port =3D n=
tohs(59574);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ine=
t_pton(AF_INET6, &quot;2001:db8:20::2&quot;, &amp;expected-&gt;src.addr.in6=
.sin6_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exp=
ected-&gt;dst.addr.in6.sin6_family =3D AF_INET6;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    expected-&gt;dst.addr.in6.sin6_port =3D nt=
ohs(1195);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    inet_=
pton(AF_INET6, &quot;2001:db8:20::1&quot;, &amp;expected-&gt;dst.addr.in6.s=
in6_addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    hapro=
xy_protocol_parse(actual, HP2_TEST_PROXY_TCP6, sizeof(HP2_TEST_PROXY_TCP6))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(co=
mpare_hpi(state, actual, expected));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  haproxy_protocol_reset(expected);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free(expected);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    openvpn_unit_test_setup();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_h=
aproxy_protocol_version),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        cmocka_unit_test(test_haproxy_protocol_header_len),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test_setu=
p_teardown(test_haproxy_protocol_parse, setup_parse, teardown_parse)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(=
&quot;haproxy_protocol&quot;, tests, NULL, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail">c=
hange 685</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/685?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9766c68feaba71279f26c3310ee=
e4b5ca215e6ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 685 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--GjFWpEsZD/w=--

