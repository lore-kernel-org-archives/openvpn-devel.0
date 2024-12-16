Message-ID: <14907efd-e18b-4bb2-94b7-51fe44011abd@...68...>
Date: Mon, 16 Dec 2024 13:23:10 +0100
MIME-Version: 1.0
References: <7e42399c-3a94-40a2-bcaa-15545c3b761c@...68...>
 <6a00da72-dc11-409e-9d47-4694e1d6f02f@...68...>
 <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
Content-Language: de-CH
From: corubba <corubba@...68...>
In-Reply-To: <a986633d-69d7-4bd1-b288-2f0de53b106e@...2181...>
Subject: [Openvpn-devel] [PATCH v2 3/2] port-share: Add unix-socket and udp
 support for proxy protocol
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

Just in case it is ever needed.

Signed-off-by: Corubba Smith <corubba@...68...>
---
 src/openvpn/ps.c     | 42 +++++++++++++++++++++++++++++++++++-------
 src/openvpn/socket.h |  1 +
 2 files changed, 36 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index b5d04c5b..b34df315 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -400,18 +400,19 @@ journal_add(const char *journal_dir, struct proxy_con=
nection *pc, struct proxy_c
 static void
 send_proxy_protocol_v2_header(const struct proxy_connection *const pc, con=
st struct proxy_connection *const cp)
 {
-    static const uint8_t PP2_AF_UNSPEC =3D 0x0, PP2_AF_INET =3D 0x1, PP2_A=
F_INET6 =3D 0x2;
-    static const uint8_t PP2_PROTO_STREAM =3D 0x1;
+    static const uint8_t PP2_AF_UNSPEC =3D 0x0, PP2_AF_INET =3D 0x1, PP2_A=
F_INET6 =3D 0x2, PP2_AF_UNIX =3D 0x3;
+    static const uint8_t PP2_PROTO_UNSPEC =3D 0x0, PP2_PROTO_STREAM =3D 0x=
1, PP2_PROTO_DGRAM =3D 0x2;

     struct openvpn_sockaddr src, dst;
-    socklen_t src_len, dst_len;
-    unsigned char header[52] =3D {
+    socklen_t src_len, dst_len, socket_type_len;
+    unsigned char header[232] =3D {
         "\x0D\x0A\x0D\x0A\x00\x0D\x0A\x51\x55\x49\x54\x0A" /* signature */
         "\x21" /* version=3D2 + command=3Dproxy */
         /* initialize the rest to zero for now */
     };
-    uint8_t addr_fam, header_len =3D 16;
+    uint8_t addr_fam, proto, header_len =3D 16;
     uint16_t addr_len;
+    int socket_type;

     src_len =3D sizeof(src.addr);
     dst_len =3D sizeof(dst.addr);
@@ -467,7 +468,14 @@ send_proxy_protocol_v2_header(const struct proxy_conne=
ction *const pc, const str
             memcpy(&header[50], &dst.addr.in6.sin6_port, sizeof(dst.addr.i=
n6.sin6_port));
             break;

-        /* AF_UNIX is currently not suppported by OpenVPN */
+        case AF_UNIX:
+            addr_fam =3D PP2_AF_UNIX;
+            addr_len =3D 216;
+            ASSERT(108 >=3D sizeof(src.addr.un.sun_path));
+            ASSERT(108 >=3D sizeof(dst.addr.un.sun_path));
+            memcpy(&header[16], &src.addr.un.sun_path, 108);
+            memcpy(&header[124], &dst.addr.un.sun_path, 108);
+            break;

         default:
             addr_fam =3D PP2_AF_UNSPEC;
@@ -475,7 +483,27 @@ send_proxy_protocol_v2_header(const struct proxy_conne=
ction *const pc, const str
             break;
     }

-    const uint8_t proto =3D PP2_PROTO_STREAM; /* DGRAM is currently not su=
pported by port-share */
+    socket_type_len =3D sizeof(socket_type);
+    if (0 !=3D getsockopt(pc->sd, SOL_SOCKET, SO_TYPE, &socket_type, &sock=
et_type_len))
+    {
+        msg(M_WARN, "PORT SHARE PROXY: getting socket type failed");
+        socket_type =3D -1; /* fallback to unspec */
+    }
+    switch (socket_type)
+    {
+        case SOCK_STREAM:
+            proto =3D PP2_PROTO_STREAM;
+            break;
+
+        case SOCK_DGRAM:
+            proto =3D PP2_PROTO_DGRAM;
+            break;
+
+        default:
+            proto =3D PP2_PROTO_UNSPEC;
+            break;
+    }
+
     header[13] =3D (addr_fam << 4) | proto;

     /* TLV is currently not implemented */
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 465d92ba..3578b3c3 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -69,6 +69,7 @@ struct openvpn_sockaddr
         struct sockaddr sa;
         struct sockaddr_in in4;
         struct sockaddr_in6 in6;
+        struct sockaddr_un un;
     } addr;
 };

--
2.47.1

