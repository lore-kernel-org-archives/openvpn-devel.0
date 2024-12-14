Message-ID: <6fbf5828-05ad-47fd-8093-a4feb54f6f6c@...68...>
Date: Sun, 15 Dec 2024 00:20:40 +0100
MIME-Version: 1.0
From: corubba <corubba@...68...>
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
Content-Language: de-CH
In-Reply-To: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
Subject: [Openvpn-devel] [PATCH 2/2] port-share: Add proxy protocol v2
 support
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

In addition to the custom journal solution, also support the widely
used binary PROXY protocol version 2 to convey the original client
connection parameters to the proxy receiver. This makes the port-share
journal feature more accessable and easier to use, because one doesn't
need a custom integration.

While this is a spec-compliant sender implementation of the PROXY
protocol, it does not implement it in full. Version 1 was left out
entirely, in favour of the superior and easier-to-implement version 2.
The implementation was also kept minimal with regards to what OpenVPN
supports/requires: Local commands, unix sockets, UDP and TLVs are not
implemented.

Signed-off-by: corubba <corubba@...68...>
---
 doc/man-sections/server-options.rst |   4 +
 src/openvpn/ps.c                    | 110 +++++++++++++++++++++++++++-
 2 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-=
options.rst
index 3fe9862c..5fdd4a22 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -435,6 +435,10 @@ fast hardware. SSL/TLS authentication must be used in =
this mode.
   the origin of the connection. Each generated file will be automatically
   deleted when the proxied connection is torn down.

+  ``dir`` can be set to the special value ``proxy_protocol_v2`` to make
+  OpenVPN use the binary PROXY protocol version 2 towards the proxy receiv=
er.
+  No temporary files will be written in this mode.
+
   Not implemented on Windows.

 --push option
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 36ea63b8..b5d04c5b 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -393,6 +393,107 @@ journal_add(const char *journal_dir, struct proxy_con=
nection *pc, struct proxy_c
     gc_free(&gc);
 }

+/*
+ * Send the proxy protocol v2 binary header, so that the receiving
+ * server knows the true client connection parameters.
+ */
+static void
+send_proxy_protocol_v2_header(const struct proxy_connection *const pc, con=
st struct proxy_connection *const cp)
+{
+    static const uint8_t PP2_AF_UNSPEC =3D 0x0, PP2_AF_INET =3D 0x1, PP2_A=
F_INET6 =3D 0x2;
+    static const uint8_t PP2_PROTO_STREAM =3D 0x1;
+
+    struct openvpn_sockaddr src, dst;
+    socklen_t src_len, dst_len;
+    unsigned char header[52] =3D {
+        "\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\x49\x54\x0A" /* signature */
+        "\x21" /* version=3D2 + command=3Dproxy */
+        /* initialize the rest to zero for now */
+    };
+    uint8_t addr_fam, header_len =3D 16;
+    uint16_t addr_len;
+
+    src_len =3D sizeof(src.addr);
+    dst_len =3D sizeof(dst.addr);
+    if (0 !=3D getpeername(pc->sd, &src.addr.sa, &src_len)
+        || 0 !=3D getsockname(pc->sd, &dst.addr.sa, &dst_len))
+    {
+        msg(M_WARN, "PORT SHARE PROXY: getting client connection parameter=
s failed");
+        src.addr.sa.sa_family =3D dst.addr.sa.sa_family =3D AF_UNSPEC;
+    }
+
+    transform_mapped_v4_sockaddr(&src);
+    transform_mapped_v4_sockaddr(&dst);
+    if (src.addr.sa.sa_family !=3D dst.addr.sa.sa_family)
+    {
+        msg(M_WARN, "PORT SHARE PROXY: address family mismatch between pee=
r and socket");
+        /* src wins, because that is usually the more important info */
+        dst.addr.sa.sa_family =3D src.addr.sa.sa_family;
+    }
+
+    if (msg_test(D_PS_PROXY_DEBUG))
+    {
+        struct gc_arena gc =3D gc_new();
+        dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client connection is %s =
-> %s",
+             print_openvpn_sockaddr(&src, &gc), print_openvpn_sockaddr(&ds=
t, &gc));
+        gc_free(&gc);
+    }
+
+    switch (src.addr.sa.sa_family)
+    {
+        case AF_INET:
+            addr_fam =3D PP2_AF_INET;
+            addr_len =3D 12;
+            ASSERT(4 >=3D sizeof(src.addr.in4.sin_addr));
+            ASSERT(4 >=3D sizeof(dst.addr.in4.sin_addr));
+            memcpy(&header[16], &src.addr.in4.sin_addr, sizeof(src.addr.in=
4.sin_addr));
+            memcpy(&header[20], &dst.addr.in4.sin_addr, sizeof(dst.addr.in=
4.sin_addr));
+            ASSERT(2 >=3D sizeof(src.addr.in4.sin_port));
+            ASSERT(2 >=3D sizeof(dst.addr.in4.sin_port));
+            memcpy(&header[24], &src.addr.in4.sin_port, sizeof(src.addr.in=
4.sin_port));
+            memcpy(&header[26], &dst.addr.in4.sin_port, sizeof(dst.addr.in=
4.sin_port));
+            break;
+
+        case AF_INET6:
+            addr_fam =3D PP2_AF_INET6;
+            addr_len =3D 36;
+            ASSERT(16 >=3D sizeof(src.addr.in6.sin6_addr));
+            ASSERT(16 >=3D sizeof(dst.addr.in6.sin6_addr));
+            memcpy(&header[16], &src.addr.in6.sin6_addr, sizeof(src.addr.i=
n6.sin6_addr));
+            memcpy(&header[32], &dst.addr.in6.sin6_addr, sizeof(dst.addr.i=
n6.sin6_addr));
+            ASSERT(2 >=3D sizeof(src.addr.in6.sin6_port));
+            ASSERT(2 >=3D sizeof(dst.addr.in6.sin6_port));
+            memcpy(&header[48], &src.addr.in6.sin6_port, sizeof(src.addr.i=
n6.sin6_port));
+            memcpy(&header[50], &dst.addr.in6.sin6_port, sizeof(dst.addr.i=
n6.sin6_port));
+            break;
+
+        /* AF_UNIX is currently not suppported by OpenVPN */
+
+        default:
+            addr_fam =3D PP2_AF_UNSPEC;
+            addr_len =3D 0;
+            break;
+    }
+
+    const uint8_t proto =3D PP2_PROTO_STREAM; /* DGRAM is currently not su=
pported by port-share */
+    header[13] =3D (addr_fam << 4) | proto;
+
+    /* TLV is currently not implemented */
+
+    header_len +=3D addr_len;
+    const uint16_t addr_len_n =3D htons(addr_len);
+    memcpy(&header[14], &addr_len_n, sizeof(addr_len_n));
+
+    ASSERT(header_len <=3D sizeof(header));
+    const socket_descriptor_t sd =3D cp->sd;
+    const int status =3D send(sd, header, header_len, MSG_NOSIGNAL);
+    dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: proxy protocol v2 wrote[%d] =
%d", (int) sd, status);
+    if (status < (int) header_len)
+    {
+        msg(M_WARN, "PORT SHARE PROXY: failed to send proxy protocol v2 he=
ader");
+    }
+}
+
 /*
  * Cleanup function, on proxy process exit.
  */
@@ -488,7 +589,14 @@ proxy_entry_new(struct proxy_connection **list,
     /* add journal entry */
     if (journal_dir)
     {
-        journal_add(journal_dir, pc, cp);
+        if (0 =3D=3D strcmp("proxy_protocol_v2", journal_dir))
+        {
+            send_proxy_protocol_v2_header(pc, cp);
+        }
+        else
+        {
+            journal_add(journal_dir, pc, cp);
+        }
     }

     dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: NEW CONNECTION [c=3D%d s=3D%=
d]", (int)sd_client, (int)sd_server);
--
2.47.1


