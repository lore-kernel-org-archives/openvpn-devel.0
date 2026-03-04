From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 13:11:14 +0000
In-Reply-To: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
References: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7f5a583fbe8f429db7a16c67406754794e0989fb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JSmGZ8gC590="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Add BLENZ
 macro that returns size_t and use it where required
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JSmGZ8gC590=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
32?usp=3Demail )

Change subject: buffer: Add BLENZ macro that returns size_t and use it wher=
e required
......................................................................

buffer: Add BLENZ macro that returns size_t and use it where required

The big int-vs-size_t length confusion in buffer and its
users can't be solved easily or quickly. So as a first step
document which users of BLEN actually already want a size_t
return. This is better than adding manual size_t casts since
it should be easier to change the API later.

This will also help with the -Wsign-compare introduction.

This does not actually change any behavior. The compiler
already did all of these casts implicitly. We just make
them explicit.

Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1132
Message-Id: <20260304105944.15386-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
870.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/clinat.c
M src/openvpn/crypto.c
M src/openvpn/forward.c
M src/openvpn/lzo.c
M src/openvpn/manage.c
M src/openvpn/mroute.c
M src/openvpn/mss.c
M src/openvpn/networking_sitnl.c
M src/openvpn/proto.c
M src/openvpn/ps.c
M src/openvpn/push.c
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/ssl.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_pkt.c
M src/openvpn/ssl_verify.c
M src/openvpn/tls_crypt.c
M src/openvpn/tun.h
M src/openvpn/vlan.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/openvpn/test_tls_crypt.c
27 files changed, 81 insertions(+), 80 deletions(-)




diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 12a8ff9..280cbc8 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -126,7 +126,7 @@
     ret.data =3D (uint8_t *)malloc(buf->capacity);
 #endif
     check_malloc_return(ret.data);
-    memcpy(BPTR(&ret), BPTR(buf), BLEN(buf));
+    memcpy(BPTR(&ret), BPTR(buf), BLENZ(buf));
     return ret;
 }

@@ -177,7 +177,7 @@
     {
         return false;
     }
-    return buf_write(dest, BPTR(src), BLEN(src));
+    return buf_write(dest, BPTR(src), BLENZ(src));
 }

 void
@@ -308,7 +308,7 @@
         return false;
     }

-    const ssize_t size =3D write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size =3D write(fd, BPTR(buf), (unsigned int)BLEN(buf));
     if (size !=3D BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -1259,9 +1259,9 @@
     struct buffer_entry *more =3D bl->head;
     size_t size =3D 0;
     int count =3D 0;
-    for (count =3D 0; more; ++count)
+    for (; more; ++count)
     {
-        size_t extra_len =3D BLEN(&more->buf) + sep_len;
+        size_t extra_len =3D BLENZ(&more->buf) + sep_len;
         if (size + extra_len > max_len)
         {
             break;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 7502050..7bb491d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -124,6 +124,7 @@
 #define BEND(buf)  (buf_bend(buf))
 #define BLAST(buf) (buf_blast(buf))
 #define BLEN(buf)  (buf_len(buf))
+#define BLENZ(buf) ((size_t)buf_len(buf))
 #define BDEF(buf)  (buf_defined(buf))
 #define BSTR(buf)  (buf_str(buf))
 #define BCAP(buf)  (buf_forward_capacity(buf))
@@ -703,7 +704,7 @@
 static inline bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
-    return buf_write(dest, BPTR(src), BLEN(src));
+    return buf_write(dest, BPTR(src), BLENZ(src));
 }

 static inline bool
@@ -830,7 +831,7 @@
 static inline bool
 buf_equal(const struct buffer *a, const struct buffer *b)
 {
-    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLE=
N(a));
+    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLE=
NZ(a));
 }

 /**
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index f671fee..32c1325 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -249,14 +249,14 @@

         if (h->ip.protocol =3D=3D OPENVPN_IPPROTO_TCP)
         {
-            if (BLEN(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(str=
uct openvpn_tcphdr))
+            if (BLENZ(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(st=
ruct openvpn_tcphdr))
             {
                 ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
             }
         }
         else if (h->ip.protocol =3D=3D OPENVPN_IPPROTO_UDP)
         {
-            if (BLEN(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(str=
uct openvpn_udphdr))
+            if (BLENZ(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(st=
ruct openvpn_udphdr))
             {
                 ADJUST_CHECKSUM(accumulate, h->u.udp.check);
             }
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 9a4269c..7d32ee8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -119,7 +119,7 @@
             }
         }
         /* Write packet id part of IV to work buffer */
-        ASSERT(buf_write(&work, iv, buf_len(&iv_buffer)));
+        ASSERT(buf_write(&work, iv, BLENZ(&iv_buffer)));

         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
@@ -1243,9 +1243,9 @@

         /* copy source to input buf */
         buf =3D work;
-        buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
-        memcpy(buf_p, BPTR(&src), BLEN(&src));
+        memcpy(buf_p, BPTR(&src), BLENZ(&src));

         /* initialize work buffer with buf.headroom bytes of prepend capac=
ity */
         ASSERT(buf_init(&encrypt_workspace, frame->buf.headroom));
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5004e35..27cfd36 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1386,8 +1386,8 @@
         struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) +=
 ip_hdr_offset);
         const int ip_hlen =3D OPENVPN_IPH_GET_LEN(pip->version_len);
         /* Reject malformed or truncated headers */
-        if (ip_hlen < sizeof(struct openvpn_iphdr)
-            || BLEN(buf) < (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t=
) * 2))
+        if (ip_hlen < (int)sizeof(struct openvpn_iphdr)
+            || BLENZ(buf) < ip_hdr_offset + ip_hlen + sizeof(uint16_t) * 2)
         {
             return;
         }
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 538c66d..51cf5e8 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -77,7 +77,6 @@
                const struct frame *frame)
 {
     lzo_uint zlen =3D frame->buf.payload_size;
-    int err;
     uint8_t c; /* flag indicating whether or not our peer compressed */

     if (buf->len <=3D 0)
@@ -93,7 +92,7 @@
     if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */
     {
         ASSERT(buf_safe(&work, zlen));
-        err =3D LZO_DECOMPRESS(BPTR(buf), BLEN(buf), BPTR(&work), &zlen, c=
ompctx->wu.lzo.wmem);
+        int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zl=
en, compctx->wu.lzo.wmem);
         if (err !=3D LZO_E_OK)
         {
             dmsg(D_COMP_ERRORS, "LZO decompression error: %d", err);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d26c9b2..df72f15 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3737,9 +3737,9 @@
         buf =3D buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
-            result =3D (char *)malloc(BLEN(buf) + 1);
+            result =3D (char *)malloc(BLENZ(buf) + 1);
             check_malloc_return(result);
-            memcpy(result, buf->data, BLEN(buf));
+            memcpy(result, buf->data, BLENZ(buf));
             result[BLEN(buf)] =3D '\0';
         }
     }
@@ -3766,9 +3766,9 @@
         buf =3D buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
-            result =3D (char *)malloc(BLEN(buf) + 1);
+            result =3D (char *)malloc(BLENZ(buf) + 1);
             check_malloc_return(result);
-            memcpy(result, buf->data, BLEN(buf));
+            memcpy(result, buf->data, BLENZ(buf));
             result[BLEN(buf)] =3D '\0';
         }
     }
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 167d995..6fa70a3 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -152,7 +152,7 @@
         switch (OPENVPN_IPH_GET_VER(*BPTR(buf)))
         {
             case 4:
-                if (BLEN(buf) >=3D (int)sizeof(struct openvpn_iphdr))
+                if (BLENZ(buf) >=3D sizeof(struct openvpn_iphdr))
                 {
                     const struct openvpn_iphdr *ip =3D (const struct openv=
pn_iphdr *)BPTR(buf);

@@ -176,7 +176,7 @@
                 break;

             case 6:
-                if (BLEN(buf) >=3D (int)sizeof(struct openvpn_ipv6hdr))
+                if (BLENZ(buf) >=3D sizeof(struct openvpn_ipv6hdr))
                 {
                     const struct openvpn_ipv6hdr *ipv6 =3D (const struct o=
penvpn_ipv6hdr *)BPTR(buf);
 #if 0 /* very basic debug */
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 3e19ea3..14112b4 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -48,7 +48,7 @@
     const struct openvpn_iphdr *pip;
     int hlen;

-    if (BLEN(buf) < (int)sizeof(struct openvpn_iphdr))
+    if (BLENZ(buf) < sizeof(struct openvpn_iphdr))
     {
         return;
     }
@@ -85,7 +85,7 @@
     const struct openvpn_ipv6hdr *pip6;
     struct buffer newbuf;

-    if (BLEN(buf) < (int)sizeof(struct openvpn_ipv6hdr))
+    if (BLENZ(buf) < sizeof(struct openvpn_ipv6hdr))
     {
         return;
     }
@@ -96,7 +96,7 @@
     /* do we have the full IPv6 packet?
      * "payload_len" does not include IPv6 header (+40 bytes)
      */
-    if (BLEN(buf) !=3D (int)ntohs(pip6->payload_len) + 40)
+    if (BLEN(buf) !=3D ntohs(pip6->payload_len) + 40)
     {
         return;
     }
@@ -120,7 +120,7 @@
      * verify remainder is large enough to contain a full TCP header
      */
     newbuf =3D *buf;
-    if (buf_advance(&newbuf, 40) && BLEN(&newbuf) >=3D (int)sizeof(struct =
openvpn_tcphdr))
+    if (buf_advance(&newbuf, 40) && BLENZ(&newbuf) >=3D sizeof(struct open=
vpn_tcphdr))
     {
         struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(&newbu=
f);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
@@ -141,7 +141,7 @@
     int olen, optlen;
     uint8_t *opt;

-    if (BLEN(buf) < (int)sizeof(struct openvpn_tcphdr))
+    if (BLENZ(buf) < sizeof(struct openvpn_tcphdr))
     {
         return;
     }
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index ad7edef..b88f03c 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -388,7 +388,7 @@
             if (h->nlmsg_type =3D=3D NLMSG_ERROR)
             {
                 err =3D (struct nlmsgerr *)NLMSG_DATA(h);
-                if (rem_len < sizeof(struct nlmsgerr))
+                if (rem_len < (int)sizeof(struct nlmsgerr))
                 {
                     msg(M_WARN, "%s: ERROR truncated", __func__);
                     ret =3D -EIO;
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index a55a2ae..13fe0a5 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -45,7 +45,7 @@
     verify_align_4(buf);
     if (tunnel_type =3D=3D DEV_TYPE_TUN)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        if (BLENZ(buf) < sizeof(struct openvpn_iphdr))
         {
             return false;
         }
@@ -54,7 +54,7 @@
     else if (tunnel_type =3D=3D DEV_TYPE_TAP)
     {
         const struct openvpn_ethhdr *eh;
-        if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct ope=
nvpn_iphdr)))
+        if (BLENZ(buf) < sizeof(struct openvpn_ethhdr) + sizeof(struct ope=
nvpn_iphdr))
         {
             return false;
         }
@@ -70,7 +70,7 @@
         if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))
         {
             const struct openvpn_8021qhdr *evh;
-            if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct=
 openvpn_iphdr)))
+            if (BLENZ(buf) < sizeof(struct openvpn_ethhdr) + sizeof(struct=
 openvpn_iphdr))
             {
                 return false;
             }
@@ -185,7 +185,7 @@
             const char *msgstr =3D "PACKET SIZE INFO";
             msglvl_t msglevel =3D D_PACKET_TRUNC_DEBUG;

-            if (BLEN(&buf) < (int)sizeof(struct openvpn_iphdr))
+            if (BLENZ(&buf) < sizeof(struct openvpn_iphdr))
             {
                 return;
             }
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index e4c5794..3b8fd84 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -209,7 +209,7 @@
         if (head)
         {
             iov[1].iov_base =3D BPTR(head);
-            iov[1].iov_len =3D BLEN(head);
+            iov[1].iov_len =3D BLENZ(head);
             mesg.msg_iovlen =3D 2;
         }

@@ -582,7 +582,7 @@
 proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)
 {
     const socket_descriptor_t sd =3D pc->counterpart->sd;
-    const ssize_t status =3D send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_=
NOSIGNAL);
+    const ssize_t status =3D send(sd, BPTR(&pc->buf), BLENZ(&pc->buf), MSG=
_NOSIGNAL);

     if (status < 0)
     {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 25df48d..5ee43a8 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -829,7 +829,7 @@
         buf_printf(&buf, ",push-continuation 1");
     }

-    if (BLEN(&buf) > sizeof(push_reply_cmd) - 1)
+    if (BLENZ(&buf) >=3D sizeof(push_reply_cmd))
     {
         const bool status =3D send_control_channel_string(c, BSTR(&buf), D=
_PUSH);
         if (!status)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 1df1001..2d5fc50 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2290,7 +2290,7 @@
         len =3D sockethandle_finalize(sh, &sock->reads, buf, NULL);
 #else
         struct buffer frag =3D stream_buf_get_next(&sock->stream_buf);
-        len =3D recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
+        len =3D recv(sock->sd, BPTR(&frag), BLENZ(&frag), MSG_NOSIGNAL);
 #endif

         if (!len)
@@ -2438,8 +2438,8 @@
 ssize_t
 link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, struct=
 link_socket_actual *to)
 {
-    packet_size_type len =3D BLEN(buf);
-    dmsg(D_STREAM_DEBUG, "STREAM: WRITE %d offset=3D%d", (int)len, buf->of=
fset);
+    packet_size_type len =3D (packet_size_type)BLENZ(buf);
+    dmsg(D_STREAM_DEBUG, "STREAM: WRITE %u offset=3D%d", len, buf->offset);
     ASSERT(len <=3D sock->stream_buf.maxlen);
     len =3D htonps(len);
     ASSERT(buf_write_prepend(buf, &len, sizeof(len)));
@@ -2466,7 +2466,7 @@
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];

     iov.iov_base =3D BPTR(buf);
-    iov.iov_len =3D BLEN(buf);
+    iov.iov_len =3D BLENZ(buf);
     mesg.msg_iov =3D &iov;
     mesg.msg_iovlen =3D 1;
     switch (to->dest.addr.sa.sa_family)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index ebaf776..cd4e8ed 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -708,14 +708,14 @@
     }
     else
 #endif
-        return sendto(sock->sd, BPTR(buf), BLEN(buf), 0, (struct sockaddr =
*)&to->dest.addr.sa,
+        return sendto(sock->sd, BPTR(buf), BLENZ(buf), 0, (struct sockaddr=
 *)&to->dest.addr.sa,
                       (socklen_t)af_addr_size(to->dest.addr.sa.sa_family));
 }

 static inline ssize_t
 link_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)
 {
-    return send(sock->sd, BPTR(buf), BLEN(buf), MSG_NOSIGNAL);
+    return send(sock->sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);
 }

 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 69d0e4e..9ed1d85 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1320,7 +1320,7 @@
     }

     /* compute PRF */
-    bool ret =3D ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len=
, output, output_len);
+    bool ret =3D ssl_tls1_PRF(BPTR(&seed), BLENZ(&seed), secret, secret_le=
n, output, output_len);

     buf_clear(&seed);
     free_buf(&seed);
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 09f23964..16f55ba 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2085,9 +2085,10 @@
 static void
 bio_write_post(const int status, struct buffer *buf)
 {
-    if (status =3D=3D 1)                     /* success status return from=
 bio_write? */
+    /* success status return from bio_write? */
+    if (status =3D=3D 1)
     {
-        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+        memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */
         buf->len =3D 0;
     }
 }
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 4e97ae4..1805995 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -298,7 +298,7 @@
 {
     struct gc_arena gc =3D gc_new();
     /* A packet needs to have at least an opcode and session id */
-    if (buf->len < (1 + SID_SIZE))
+    if (BLENZ(buf) < 1 + SID_SIZE)
     {
         dmsg(D_TLS_STATE_ERRORS, "TLS State Error: Too short packet (lengt=
h  %d) received from %s",
              buf->len, print_link_socket_actual(from, &gc));
@@ -568,7 +568,7 @@
 {
     /* commands on the control channel are seperated by 0x00 bytes.
      * cmdlen does not include the 0 byte of the string */
-    int cmdlen =3D (int)strnlen(BSTR(buf), BLEN(buf));
+    int cmdlen =3D (int)strnlen(BSTR(buf), BLENZ(buf));

     if (cmdlen >=3D BLEN(buf))
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0b02a2f..8bd8e96 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -692,7 +692,7 @@

         while (current_hash)
         {
-            if (memcmp_constant_time(BPTR(&cert_fp), current_hash->hash, B=
LEN(&cert_fp)) =3D=3D 0)
+            if (memcmp_constant_time(BPTR(&cert_fp), current_hash->hash, B=
LENZ(&cert_fp)) =3D=3D 0)
             {
                 break;
             }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2b00e1c..bfe665e 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -159,7 +159,7 @@
     dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format_hex(BPTR(dst), =
BLEN(dst), 0, &gc));

     /* Buffer overflow check */
-    if (!buf_safe(dst, BLEN(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SI=
ZE))
+    if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_S=
IZE))
     {
         msg(D_CRYPT_ERRORS,
             "TLS-CRYPT WRAP: buffer size error, "
@@ -222,7 +222,7 @@

     dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(BPTR(sr=
c), BLEN(src), 80, &gc));

-    if (buf_len(src) < TLS_CRYPT_OFF_CT)
+    if (BLENZ(src) < TLS_CRYPT_OFF_CT)
     {
         CRYPT_ERROR("packet too short");
     }
@@ -232,7 +232,7 @@
         int outlen =3D 0;

         /* Buffer overflow check (should never fail) */
-        if (!buf_safe(dst, BLEN(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_=
SIZE))
+        if (!buf_safe(dst, BLENZ(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK=
_SIZE))
         {
             CRYPT_ERROR("potential buffer overflow");
         }
@@ -441,7 +441,7 @@
     uint16_t net_len =3D 0;
     const uint8_t *tag =3D BPTR(&wrapped_client_key);

-    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    if (BLENZ(&wrapped_client_key) < sizeof(net_len))
     {
         CRYPT_ERROR("failed to read length");
     }
@@ -496,7 +496,7 @@
                              "a different tls-crypt-v2 server key)");
     }

-    if (buf_len(&plaintext) < sizeof(client_key->keys))
+    if (BLENZ(&plaintext) < sizeof(client_key->keys))
     {
         CRYPT_ERROR("failed to read client key");
     }
@@ -523,7 +523,7 @@
 static bool
 tls_crypt_v2_check_client_key_age(const struct tls_wrap_ctx *ctx, int max_=
days)
 {
-    if (ctx->tls_crypt_v2_metadata.len < 1 + sizeof(int64_t))
+    if (BLENZ(&ctx->tls_crypt_v2_metadata) < 1 + sizeof(int64_t))
     {
         msg(M_WARN, "ERROR: Client key metadata is too small to contain a =
timestamp.");
         return false;
@@ -619,7 +619,7 @@
     struct buffer wrapped_client_key =3D *buf;
     uint16_t net_len =3D 0;

-    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    if (BLENZ(&wrapped_client_key) < sizeof(net_len))
     {
         msg(D_TLS_ERRORS, "Can not read tls-crypt-v2 client key length");
         return false;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 34f4929..4d6dfbb 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -510,14 +510,14 @@

     if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 4)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        if (BLENZ(buf) < sizeof(struct openvpn_iphdr))
         {
             return false;
         }
     }
     else if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 6)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_ipv6hdr))
+        if (BLENZ(buf) < sizeof(struct openvpn_ipv6hdr))
         {
             return false;
         }
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 85a54eb..bffc60e 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -85,7 +85,7 @@
     uint16_t vid;

     /* assume untagged frame */
-    if (BLEN(buf) < sizeof(*ethhdr))
+    if (BLENZ(buf) < sizeof(*ethhdr))
     {
         goto drop;
     }
@@ -109,7 +109,7 @@
     }

     /* tagged frame */
-    if (BLEN(buf) < sizeof(*vlanhdr))
+    if (BLENZ(buf) < sizeof(*vlanhdr))
     {
         goto drop;
     }
@@ -184,7 +184,7 @@
     const struct openvpn_ethhdr *ethhdr;
     struct openvpn_8021qhdr *vlanhdr;

-    if (BLEN(buf) < sizeof(*ethhdr))
+    if (BLENZ(buf) < sizeof(*ethhdr))
     {
         goto drop;
     }
@@ -197,7 +197,7 @@
          */

         /* Frame too small for header type? */
-        if (BLEN(buf) < sizeof(*vlanhdr))
+        if (BLENZ(buf) < sizeof(*vlanhdr))
         {
             goto drop;
         }
@@ -216,7 +216,7 @@
         /* Untagged frame. */

         /* Not enough head room for VLAN tag? */
-        if (buf_reverse_capacity(buf) < SIZE_ETH_TO_8021Q_HDR)
+        if (buf_reverse_capacity(buf) < (int)SIZE_ETH_TO_8021Q_HDR)
         {
             goto drop;
         }
@@ -263,7 +263,7 @@
     const struct openvpn_8021qhdr *vlanhdr;
     uint16_t vid;

-    if (BLEN(buf) < sizeof(struct openvpn_8021qhdr))
+    if (BLENZ(buf) < sizeof(struct openvpn_8021qhdr))
     {
         /* frame too small to be VLAN-tagged */
         return false;
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 16949bc..1c78cf0 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -49,9 +49,9 @@
 #define teststr2  "two"
 #define teststr3  "three"

-#define assert_buf_equals_str(buf, str)       \
-    assert_int_equal(BLEN(buf), strlen(str)); \
-    assert_memory_equal(BPTR(buf), str, BLEN(buf));
+#define assert_buf_equals_str(buf, str)        \
+    assert_int_equal(BLENZ(buf), strlen(str)); \
+    assert_memory_equal(BPTR(buf), str, BLENZ(buf));

 static void
 test_buffer_printf_catrunc(void **state)
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 3d3e53a..1679d88 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -70,7 +70,7 @@

     assert_true(crypto_pem_decode("TESTKEYNAME", &dec_buf, &pem_buf));
     assert_int_equal(BLEN(&src_buf), BLEN(&dec_buf));
-    assert_memory_equal(BPTR(&src_buf), BPTR(&dec_buf), BLEN(&src_buf));
+    assert_memory_equal(BPTR(&src_buf), BPTR(&dec_buf), BLENZ(&src_buf));

     gc_free(&gc);
 }
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index fc2c0a1..a94732d 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -665,7 +665,7 @@
     struct buffer buf2 =3D
         tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, =
header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
-    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLENZ(&buf));

     free_tls_pre_decrypt_state(&state);
     free_buf(&tas.workbuf);
@@ -702,7 +702,7 @@
     struct buffer buf2 =3D tls_reset_standalone(&tas_client.tls_wrap, &tas=
_client, &client_id,
                                               &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
-    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLENZ(&buf));

     free_tls_pre_decrypt_state(&state);

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 153aa77..2b73ee7 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -324,9 +324,9 @@

         /* copy source to input buf */
         buf =3D work;
-        buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+        buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
-        memcpy(buf_p, BPTR(&src), BLEN(&src));
+        memcpy(buf_p, BPTR(&src), BLENZ(&src));

         /* initialize work buffer with buf.headroom bytes of prepend capac=
ity */
         ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
@@ -370,9 +370,9 @@

     /* copy source to input buf */
     buf =3D work;
-    buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+    buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
-    memcpy(buf_p, BPTR(&src), BLEN(&src));
+    memcpy(buf_p, BPTR(&src), BLENZ(&src));

     ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
     openvpn_encrypt(&buf, encrypt_workspace, co);
@@ -668,9 +668,9 @@

     /* copy source to input buf */
     buf =3D work;
-    buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+    buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
-    memcpy(buf_p, BPTR(&src), BLEN(&src));
+    memcpy(buf_p, BPTR(&src), BLENZ(&src));

     /* initialize work buffer with buf.headroom bytes of prepend capacity =
*/
     ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 730841e..ed82279 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -225,7 +225,7 @@
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->=
co));
     assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
-    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLEN(&c=
tx->source));
+    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLENZ(&=
ctx->source));
 }


@@ -259,7 +259,7 @@
                                       0x33, 0x7b, 0x9c, 0xfb, 0x56, 0xe1, =
0xf1, 0x3a, 0x87, 0x0e,
                                       0x66, 0x47, 0xdf, 0xa1, 0x95, 0xc9, =
0x2c, 0x17, 0xa0, 0x15,
                                       0xba, 0x49, 0x67, 0xa1, 0x1d, 0x55, =
0xea, 0x1a, 0x06, 0xa7 };
-    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, buf_len(&r=
ctx->work));
+    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, BLENZ(&rct=
x->work));
     tls_wrap_free(&session.tls_wrap_reneg);

     /* Use previous tls-crypt key as 0x00, with xor we should have the sam=
e key
@@ -273,7 +273,7 @@
     tls_crypt_wrap(&ctx->source, &rctx->work, &rctx->opt);
     assert_int_equal(buf_len(&ctx->source) + 40, buf_len(&rctx->work));

-    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, buf_len(&r=
ctx->work));
+    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, BLENZ(&rct=
x->work));
     tls_wrap_free(&session.tls_wrap_reneg);

     /* XOR should not force a different key */
@@ -289,7 +289,7 @@

     /* Skip packet id */
     buf_advance(&rctx->work, 8);
-    assert_memory_not_equal(BPTR(&rctx->work), expected_ciphertext, buf_le=
n(&rctx->work));
+    assert_memory_not_equal(BPTR(&rctx->work), expected_ciphertext, BLENZ(=
&rctx->work));
     tls_wrap_free(&session.tls_wrap_reneg);
=20

@@ -312,7 +312,7 @@
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->=
co));
     assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
-    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLEN(&c=
tx->source));
+    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLENZ(&=
ctx->source));
 }

 /**
@@ -333,7 +333,7 @@
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->=
co));
     assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
-    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLEN(&c=
tx->source));
+    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLENZ(&=
ctx->source));
 }

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096
Gerrit-Change-Number: 1132
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JSmGZ8gC590=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1132?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: Add BLENZ macro that returns size_t and =
use it where required<br><br>The big int-vs-size_t length confusion in buff=
er and its<br>users can&#39;t be solved easily or quickly. So as a first st=
ep<br>document which users of BLEN actually already want a size_t<br>return=
. This is better than adding manual size_t casts since<br>it should be easi=
er to change the API later.<br><br>This will also help with the -Wsign-comp=
are introduction.<br><br>This does not actually change any behavior. The co=
mpiler<br>already did all of these casts implicitly. We just make<br>them e=
xplicit.<br><br>Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/o=
penvpn/+/1132<br>Message-Id: &lt;20260304105944.15386-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg35870.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>M src/openvpn/clinat=
.c<br>M src/openvpn/crypto.c<br>M src/openvpn/forward.c<br>M src/openvpn/lz=
o.c<br>M src/openvpn/manage.c<br>M src/openvpn/mroute.c<br>M src/openvpn/ms=
s.c<br>M src/openvpn/networking_sitnl.c<br>M src/openvpn/proto.c<br>M src/o=
penvpn/ps.c<br>M src/openvpn/push.c<br>M src/openvpn/socket.c<br>M src/open=
vpn/socket.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_openssl.c<br>M src=
/openvpn/ssl_pkt.c<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/tls_crypt=
.c<br>M src/openvpn/tun.h<br>M src/openvpn/vlan.c<br>M tests/unit_tests/ope=
nvpn/test_buffer.c<br>M tests/unit_tests/openvpn/test_crypto.c<br>M tests/u=
nit_tests/openvpn/test_pkt.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>M =
tests/unit_tests/openvpn/test_tls_crypt.c<br>27 files changed, 81 insertion=
s(+), 80 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index 12a8ff9..280cbc8 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -126,7 +126,7 =
@@</span><br><span>     ret.data =3D (uint8_t *)malloc(buf-&gt;capacity);</=
span><br><span> #endif</span><br><span>     check_malloc_return(ret.data);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(BPTR(&amp;r=
et), BPTR(buf), BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    memcpy(BPTR(&amp;ret), BPTR(buf), BLENZ(buf));</span><br><span>=
     return ret;</span><br><span> }</span><br><span> </span><br><span>@@ -1=
77,7 +177,7 @@</span><br><span>     {</span><br><span>         return false=
;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return buf_write(dest, BPTR(src), BLEN(src));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return buf_write(dest, BPTR(src), BLE=
NZ(src));</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span>@@ -308,7 +308,7 @@</span><br><span>         return false;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    const ssize_t size =3D write(fd, BPTR(buf), BLEN(buf));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ssize_t size=
 =3D write(fd, BPTR(buf), (unsigned int)BLEN(buf));</span><br><span>     if=
 (size !=3D BLEN(buf))</span><br><span>     {</span><br><span>         msg(=
M_ERRNO, &quot;Write error on file &#39;%s&#39;&quot;, filename);</span><br=
><span>@@ -1259,9 +1259,9 @@</span><br><span>     struct buffer_entry *more=
 =3D bl-&gt;head;</span><br><span>     size_t size =3D 0;</span><br><span> =
    int count =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (count =3D 0; more; ++count)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    for (; more; ++count)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        size_t extra_len =3D BLE=
N(&amp;more-&gt;buf) + sep_len;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        size_t extra_len =3D BLENZ(&amp;more-&gt;buf) + sep_len=
;</span><br><span>         if (size + extra_len &gt; max_len)</span><br><sp=
an>         {</span><br><span>             break;</span><br><span>diff --gi=
t a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index 75020=
50..7bb491d 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><sp=
an>+++ b/src/openvpn/buffer.h</span><br><span>@@ -124,6 +124,7 @@</span><br=
><span> #define BEND(buf)  (buf_bend(buf))</span><br><span> #define BLAST(b=
uf) (buf_blast(buf))</span><br><span> #define BLEN(buf)  (buf_len(buf))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define BLENZ(buf) ((si=
ze_t)buf_len(buf))</span><br><span> #define BDEF(buf)  (buf_defined(buf))</=
span><br><span> #define BSTR(buf)  (buf_str(buf))</span><br><span> #define =
BCAP(buf)  (buf_forward_capacity(buf))</span><br><span>@@ -703,7 +704,7 @@<=
/span><br><span> static inline bool</span><br><span> buf_copy(struct buffer=
 *dest, const struct buffer *src)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return buf_write(dest, BPTR(src), BLEN(=
src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return bu=
f_write(dest, BPTR(src), BLENZ(src));</span><br><span> }</span><br><span> <=
/span><br><span> static inline bool</span><br><span>@@ -830,7 +831,7 @@</sp=
an><br><span> static inline bool</span><br><span> buf_equal(const struct bu=
ffer *a, const struct buffer *b)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return BLEN(a) =3D=3D BLEN(b) &amp;&amp=
; 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLEN(a));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =
=3D=3D memcmp(BPTR(a), BPTR(b), BLENZ(a));</span><br><span> }</span><br><sp=
an> </span><br><span> /**</span><br><span>diff --git a/src/openvpn/clinat.c=
 b/src/openvpn/clinat.c</span><br><span>index f671fee..32c1325 100644</span=
><br><span>--- a/src/openvpn/clinat.c</span><br><span>+++ b/src/openvpn/cli=
nat.c</span><br><span>@@ -249,14 +249,14 @@</span><br><span> </span><br><sp=
an>         if (h-&gt;ip.protocol =3D=3D OPENVPN_IPPROTO_TCP)</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (BLEN(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct op=
envpn_tcphdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (BLENZ(ipbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struc=
t openvpn_tcphdr))</span><br><span>             {</span><br><span>         =
        ADJUST_CHECKSUM(accumulate, h-&gt;u.tcp.check);</span><br><span>   =
          }</span><br><span>         }</span><br><span>         else if (h-=
&gt;ip.protocol =3D=3D OPENVPN_IPPROTO_UDP)</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(ipbuf=
) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(i=
pbuf) &gt;=3D sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))=
</span><br><span>             {</span><br><span>                 ADJUST_CHE=
CKSUM(accumulate, h-&gt;u.udp.check);</span><br><span>             }</span>=
<br><span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><b=
r><span>index 9a4269c..7d32ee8 100644</span><br><span>--- a/src/openvpn/cry=
pto.c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -119,7 =
+119,7 @@</span><br><span>             }</span><br><span>         }</span><=
br><span>         /* Write packet id part of IV to work buffer */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_write(&amp;w=
ork, iv, buf_len(&amp;iv_buffer)));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        ASSERT(buf_write(&amp;work, iv, BLENZ(&amp;iv_buffe=
r)));</span><br><span> </span><br><span>         /* This generates the IV b=
y XORing the implicit part of the IV</span><br><span>          * with the p=
acket id already written to the iv buffer */</span><br><span>@@ -1243,9 +12=
43,9 @@</span><br><span> </span><br><span>         /* copy source to input =
buf */</span><br><span>         buf =3D work;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        buf_p =3D buf_write_alloc(&amp;buf, BLEN(&a=
mp;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        bu=
f_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>       =
  ASSERT(buf_p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   memcpy(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        memcpy(buf_p, BPTR(&amp;src), BLENZ(&=
amp;src));</span><br><span> </span><br><span>         /* initialize work bu=
ffer with buf.headroom bytes of prepend capacity */</span><br><span>       =
  ASSERT(buf_init(&amp;encrypt_workspace, frame-&gt;buf.headroom));</span><=
br><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><=
br><span>index 5004e35..27cfd36 100644</span><br><span>--- a/src/openvpn/fo=
rward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -138=
6,8 +1386,8 @@</span><br><span>         struct openvpn_iphdr *pip =3D (stru=
ct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><br><span>         co=
nst int ip_hlen =3D OPENVPN_IPH_GET_LEN(pip-&gt;version_len);</span><br><sp=
an>         /* Reject malformed or truncated headers */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if (ip_hlen &lt; sizeof(struct op=
envpn_iphdr)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   || BLEN(buf) &lt; (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t) * 2))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ip_hlen=
 &lt; (int)sizeof(struct openvpn_iphdr)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            || BLENZ(buf) &lt; ip_hdr_offset + ip_hlen =
+ sizeof(uint16_t) * 2)</span><br><span>         {</span><br><span>        =
     return;</span><br><span>         }</span><br><span>diff --git a/src/op=
envpn/lzo.c b/src/openvpn/lzo.c</span><br><span>index 538c66d..51cf5e8 1006=
44</span><br><span>--- a/src/openvpn/lzo.c</span><br><span>+++ b/src/openvp=
n/lzo.c</span><br><span>@@ -77,7 +77,6 @@</span><br><span>                c=
onst struct frame *frame)</span><br><span> {</span><br><span>     lzo_uint =
zlen =3D frame-&gt;buf.payload_size;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int err;</span><br><span>     uint8_t c; /* flag indicat=
ing whether or not our peer compressed */</span><br><span> </span><br><span=
>     if (buf-&gt;len &lt;=3D 0)</span><br><span>@@ -93,7 +92,7 @@</span><b=
r><span>     if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */</s=
pan><br><span>     {</span><br><span>         ASSERT(buf_safe(&amp;work, zl=
en));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D =
LZO_DECOMPRESS(BPTR(buf), BLEN(buf), BPTR(&amp;work), &amp;zlen, compctx-&g=
t;wu.lzo.wmem);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    int err =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&amp;work), &amp=
;zlen, compctx-&gt;wu.lzo.wmem);</span><br><span>         if (err !=3D LZO_=
E_OK)</span><br><span>         {</span><br><span>             dmsg(D_COMP_E=
RRORS, &quot;LZO decompression error: %d&quot;, err);</span><br><span>diff =
--git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index d=
26c9b2..df72f15 100644</span><br><span>--- a/src/openvpn/manage.c</span><br=
><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -3737,9 +3737,9 @@</sp=
an><br><span>         buf =3D buffer_list_peek(*input);</span><br><span>   =
      if (buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            result =3D (cha=
r *)malloc(BLEN(buf) + 1);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            result =3D (char *)malloc(BLENZ(buf) + 1);</span><br><sp=
an>             check_malloc_return(result);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            memcpy(result, buf-&gt;data, BLEN(buf));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(=
result, buf-&gt;data, BLENZ(buf));</span><br><span>             result[BLEN=
(buf)] =3D &#39;\0&#39;;</span><br><span>         }</span><br><span>     }<=
/span><br><span>@@ -3766,9 +3766,9 @@</span><br><span>         buf =3D buff=
er_list_peek(*input);</span><br><span>         if (buf &amp;&amp; BLEN(buf)=
 &gt; 0)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            result =3D (char *)malloc(BLEN(buf) + 1);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            result =3D (cha=
r *)malloc(BLENZ(buf) + 1);</span><br><span>             check_malloc_retur=
n(result);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 memcpy(result, buf-&gt;data, BLEN(buf));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            memcpy(result, buf-&gt;data, BLENZ(buf));=
</span><br><span>             result[BLEN(buf)] =3D &#39;\0&#39;;</span><br=
><span>         }</span><br><span>     }</span><br><span>diff --git a/src/o=
penvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index 167d995..6fa70=
a3 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/=
src/openvpn/mroute.c</span><br><span>@@ -152,7 +152,7 @@</span><br><span>  =
       switch (OPENVPN_IPH_GET_VER(*BPTR(buf)))</span><br><span>         {<=
/span><br><span>             case 4:</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                if (BLEN(buf) &gt;=3D (int)sizeof(struct ope=
nvpn_iphdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         if (BLENZ(buf) &gt;=3D sizeof(struct openvpn_iphdr))</span><br><sp=
an>                 {</span><br><span>                     const struct ope=
nvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf);</span><br><span=
> </span><br><span>@@ -176,7 +176,7 @@</span><br><span>                 bre=
ak;</span><br><span> </span><br><span>             case 6:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                if (BLEN(buf) &gt;=3D =
(int)sizeof(struct openvpn_ipv6hdr))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (BLENZ(buf) &gt;=3D sizeof(struct openv=
pn_ipv6hdr))</span><br><span>                 {</span><br><span>           =
          const struct openvpn_ipv6hdr *ipv6 =3D (const struct openvpn_ipv6=
hdr *)BPTR(buf);</span><br><span> #if 0 /* very basic debug */</span><br><s=
pan>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><span>inde=
x 3e19ea3..14112b4 100644</span><br><span>--- a/src/openvpn/mss.c</span><br=
><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -48,7 +48,7 @@</span><br>=
<span>     const struct openvpn_iphdr *pip;</span><br><span>     int hlen;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (BLEN(buf) &lt; (int)sizeof(struct openvpn_iphdr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(struct ope=
nvpn_iphdr))</span><br><span>     {</span><br><span>         return;</span>=
<br><span>     }</span><br><span>@@ -85,7 +85,7 @@</span><br><span>     con=
st struct openvpn_ipv6hdr *pip6;</span><br><span>     struct buffer newbuf;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (BLEN(buf) &lt; (int)sizeof(struct openvpn_ipv6hdr))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(struct =
openvpn_ipv6hdr))</span><br><span>     {</span><br><span>         return;</=
span><br><span>     }</span><br><span>@@ -96,7 +96,7 @@</span><br><span>   =
  /* do we have the full IPv6 packet?</span><br><span>      * &quot;payload=
_len&quot; does not include IPv6 header (+40 bytes)</span><br><span>      *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (BLEN(buf) !=
=3D (int)ntohs(pip6-&gt;payload_len) + 40)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (BLEN(buf) !=3D ntohs(pip6-&gt;payload_len) +=
 40)</span><br><span>     {</span><br><span>         return;</span><br><spa=
n>     }</span><br><span>@@ -120,7 +120,7 @@</span><br><span>      * verify=
 remainder is large enough to contain a full TCP header</span><br><span>   =
   */</span><br><span>     newbuf =3D *buf;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (buf_advance(&amp;newbuf, 40) &amp;&amp; BLEN(=
&amp;newbuf) &gt;=3D (int)sizeof(struct openvpn_tcphdr))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (buf_advance(&amp;newbuf, 40) &=
amp;&amp; BLENZ(&amp;newbuf) &gt;=3D sizeof(struct openvpn_tcphdr))</span><=
br><span>     {</span><br><span>         struct openvpn_tcphdr *tc =3D (str=
uct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>         if (tc-&gt=
;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>@@ -141,7 +141,7 @@</sp=
an><br><span>     int olen, optlen;</span><br><span>     uint8_t *opt;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
BLEN(buf) &lt; (int)sizeof(struct openvpn_tcphdr))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(struct openvp=
n_tcphdr))</span><br><span>     {</span><br><span>         return;</span><b=
r><span>     }</span><br><span>diff --git a/src/openvpn/networking_sitnl.c =
b/src/openvpn/networking_sitnl.c</span><br><span>index ad7edef..b88f03c 100=
644</span><br><span>--- a/src/openvpn/networking_sitnl.c</span><br><span>++=
+ b/src/openvpn/networking_sitnl.c</span><br><span>@@ -388,7 +388,7 @@</spa=
n><br><span>             if (h-&gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br=
><span>             {</span><br><span>                 err =3D (struct nlms=
gerr *)NLMSG_DATA(h);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                if (rem_len &lt; sizeof(struct nlmsgerr))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                if (rem_len &lt; (int=
)sizeof(struct nlmsgerr))</span><br><span>                 {</span><br><spa=
n>                     msg(M_WARN, &quot;%s: ERROR truncated&quot;, __func_=
_);</span><br><span>                     ret =3D -EIO;</span><br><span>diff=
 --git a/src/openvpn/proto.c b/src/openvpn/proto.c</span><br><span>index a5=
5a2ae..13fe0a5 100644</span><br><span>--- a/src/openvpn/proto.c</span><br><=
span>+++ b/src/openvpn/proto.c</span><br><span>@@ -45,7 +45,7 @@</span><br>=
<span>     verify_align_4(buf);</span><br><span>     if (tunnel_type =3D=3D=
 DEV_TYPE_TUN)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (BLEN(buf) &lt; sizeof(struct openvpn_iphdr))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLENZ(buf)=
 &lt; sizeof(struct openvpn_iphdr))</span><br><span>         {</span><br><s=
pan>             return false;</span><br><span>         }</span><br><span>@=
@ -54,7 +54,7 @@</span><br><span>     else if (tunnel_type =3D=3D DEV_TYPE_=
TAP)</span><br><span>     {</span><br><span>         const struct openvpn_e=
thhdr *eh;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(BLEN(buf) &lt; (sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphd=
r)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLE=
NZ(buf) &lt; sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))<=
/span><br><span>         {</span><br><span>             return false;</span=
><br><span>         }</span><br><span>@@ -70,7 +70,7 @@</span><br><span>   =
      if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))</span><br><span>        =
 {</span><br><span>             const struct openvpn_8021qhdr *evh;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(buf) &lt=
; (sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr)))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(buf) &l=
t; sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))</span><br>=
<span>             {</span><br><span>                 return false;</span><=
br><span>             }</span><br><span>@@ -185,7 +185,7 @@</span><br><span=
>             const char *msgstr =3D &quot;PACKET SIZE INFO&quot;;</span><b=
r><span>             msglvl_t msglevel =3D D_PACKET_TRUNC_DEBUG;</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (BLEN(&amp;buf) &lt; (int)sizeof(struct openvpn_iphdr))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (BLENZ(&amp;buf) &lt; s=
izeof(struct openvpn_iphdr))</span><br><span>             {</span><br><span=
>                 return;</span><br><span>             }</span><br><span>di=
ff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index e4c579=
4..3b8fd84 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><span>++=
+ b/src/openvpn/ps.c</span><br><span>@@ -209,7 +209,7 @@</span><br><span>  =
       if (head)</span><br><span>         {</span><br><span>             io=
v[1].iov_base =3D BPTR(head);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            iov[1].iov_len =3D BLEN(head);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            iov[1].iov_len =3D BLENZ(head);<=
/span><br><span>             mesg.msg_iovlen =3D 2;</span><br><span>       =
  }</span><br><span> </span><br><span>@@ -582,7 +582,7 @@</span><br><span> =
proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)</spa=
n><br><span> {</span><br><span>     const socket_descriptor_t sd =3D pc-&gt=
;counterpart-&gt;sd;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   const ssize_t status =3D send(sd, BPTR(&amp;pc-&gt;buf), BLEN(&amp;pc-&g=
t;buf), MSG_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const ssize_t status =3D send(sd, BPTR(&amp;pc-&gt;buf), BLENZ(&amp;=
pc-&gt;buf), MSG_NOSIGNAL);</span><br><span> </span><br><span>     if (stat=
us &lt; 0)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/=
push.c b/src/openvpn/push.c</span><br><span>index 25df48d..5ee43a8 100644</=
span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/p=
ush.c</span><br><span>@@ -829,7 +829,7 @@</span><br><span>         buf_prin=
tf(&amp;buf, &quot;,push-continuation 1&quot;);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
BLEN(&amp;buf) &gt; sizeof(push_reply_cmd) - 1)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (BLENZ(&amp;buf) &gt;=3D sizeof(push_rep=
ly_cmd))</span><br><span>     {</span><br><span>         const bool status =
=3D send_control_channel_string(c, BSTR(&amp;buf), D_PUSH);</span><br><span=
>         if (!status)</span><br><span>diff --git a/src/openvpn/socket.c b/=
src/openvpn/socket.c</span><br><span>index 1df1001..2d5fc50 100644</span><b=
r><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket=
.c</span><br><span>@@ -2290,7 +2290,7 @@</span><br><span>         len =3D s=
ockethandle_finalize(sh, &amp;sock-&gt;reads, buf, NULL);</span><br><span> =
#else</span><br><span>         struct buffer frag =3D stream_buf_get_next(&=
amp;sock-&gt;stream_buf);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        len =3D recv(sock-&gt;sd, BPTR(&amp;frag), BLEN(&amp;frag), MSG=
_NOSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
len =3D recv(sock-&gt;sd, BPTR(&amp;frag), BLENZ(&amp;frag), MSG_NOSIGNAL);=
</span><br><span> #endif</span><br><span> </span><br><span>         if (!le=
n)</span><br><span>@@ -2438,8 +2438,8 @@</span><br><span> ssize_t</span><br=
><span> link_socket_write_tcp(struct link_socket *sock, struct buffer *buf,=
 struct link_socket_actual *to)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    packet_size_type len =3D BLEN(buf);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &qu=
ot;STREAM: WRITE %d offset=3D%d&quot;, (int)len, buf-&gt;offset);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    packet_size_type len =3D =
(packet_size_type)BLENZ(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    dmsg(D_STREAM_DEBUG, &quot;STREAM: WRITE %u offset=3D%d&quot;=
, len, buf-&gt;offset);</span><br><span>     ASSERT(len &lt;=3D sock-&gt;st=
ream_buf.maxlen);</span><br><span>     len =3D htonps(len);</span><br><span=
>     ASSERT(buf_write_prepend(buf, &amp;len, sizeof(len)));</span><br><spa=
n>@@ -2466,7 +2466,7 @@</span><br><span>     uint8_t pktinfo_buf[PKTINFO_BU=
F_SIZE];</span><br><span> </span><br><span>     iov.iov_base =3D BPTR(buf);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    iov.iov_len =3D B=
LEN(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    iov.io=
v_len =3D BLENZ(buf);</span><br><span>     mesg.msg_iov =3D &amp;iov;</span=
><br><span>     mesg.msg_iovlen =3D 1;</span><br><span>     switch (to-&gt;=
dest.addr.sa.sa_family)</span><br><span>diff --git a/src/openvpn/socket.h b=
/src/openvpn/socket.h</span><br><span>index ebaf776..cd4e8ed 100644</span><=
br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socke=
t.h</span><br><span>@@ -708,14 +708,14 @@</span><br><span>     }</span><br>=
<span>     else</span><br><span> #endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return sendto(sock-&gt;sd, BPTR(buf), BLEN(buf), =
0, (struct sockaddr *)&amp;to-&gt;dest.addr.sa,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        return sendto(sock-&gt;sd, BPTR(buf), B=
LENZ(buf), 0, (struct sockaddr *)&amp;to-&gt;dest.addr.sa,</span><br><span>=
                       (socklen_t)af_addr_size(to-&gt;dest.addr.sa.sa_famil=
y));</span><br><span> }</span><br><span> </span><br><span> static inline ss=
ize_t</span><br><span> link_socket_write_tcp_posix(struct link_socket *sock=
, struct buffer *buf)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    return send(sock-&gt;sd, BPTR(buf), BLEN(buf), MSG_N=
OSIGNAL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 send(sock-&gt;sd, BPTR(buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }=
</span><br><span> </span><br><span> #endif /* ifdef _WIN32 */</span><br><sp=
an>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index=
 69d0e4e..9ed1d85 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br>=
<span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -1320,7 +1320,7 @@</span><=
br><span>     }</span><br><span> </span><br><span>     /* compute PRF */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D ssl_tls=
1_PRF(BPTR(&amp;seed), BLEN(&amp;seed), secret, secret_len, output, output_=
len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool ret =
=3D ssl_tls1_PRF(BPTR(&amp;seed), BLENZ(&amp;seed), secret, secret_len, out=
put, output_len);</span><br><span> </span><br><span>     buf_clear(&amp;see=
d);</span><br><span>     free_buf(&amp;seed);</span><br><span>diff --git a/=
src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c</span><br><span>index=
 09f23964..16f55ba 100644</span><br><span>--- a/src/openvpn/ssl_openssl.c</=
span><br><span>+++ b/src/openvpn/ssl_openssl.c</span><br><span>@@ -2085,9 +=
2085,10 @@</span><br><span> static void</span><br><span> bio_write_post(con=
st int status, struct buffer *buf)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (status =3D=3D 1)                   =
  /* success status return from bio_write? */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* success status return from bio_write? */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status =3D=3D=
 1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memset(BPTR=
(buf), 0, BLENZ(buf)); /* erase data just written */</span><br><span>      =
   buf-&gt;len =3D 0;</span><br><span>     }</span><br><span> }</span><br><=
span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><=
span>index 4e97ae4..1805995 100644</span><br><span>--- a/src/openvpn/ssl_pk=
t.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><span>@@ -298,7 +=
298,7 @@</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_=
new();</span><br><span>     /* A packet needs to have at least an opcode an=
d session id */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (buf-&gt;len &lt; (1 + SID_SIZE))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (BLENZ(buf) &lt; 1 + SID_SIZE)</span><br><span>     {=
</span><br><span>         dmsg(D_TLS_STATE_ERRORS, &quot;TLS State Error: T=
oo short packet (length  %d) received from %s&quot;,</span><br><span>      =
        buf-&gt;len, print_link_socket_actual(from, &amp;gc));</span><br><s=
pan>@@ -568,7 +568,7 @@</span><br><span> {</span><br><span>     /* commands=
 on the control channel are seperated by 0x00 bytes.</span><br><span>      =
* cmdlen does not include the 0 byte of the string */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int cmdlen =3D (int)strnlen(BSTR(buf), =
BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
cmdlen =3D (int)strnlen(BSTR(buf), BLENZ(buf));</span><br><span> </span><br=
><span>     if (cmdlen &gt;=3D BLEN(buf))</span><br><span>     {</span><br>=
<span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</spa=
n><br><span>index 0b02a2f..8bd8e96 100644</span><br><span>--- a/src/openvpn=
/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><spa=
n>@@ -692,7 +692,7 @@</span><br><span> </span><br><span>         while (cur=
rent_hash)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (memcmp_constant_time(BPTR(&amp;cert_fp), cu=
rrent_hash-&gt;hash, BLEN(&amp;cert_fp)) =3D=3D 0)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            if (memcmp_constant_time(BPTR(&a=
mp;cert_fp), current_hash-&gt;hash, BLENZ(&amp;cert_fp)) =3D=3D 0)</span><b=
r><span>             {</span><br><span>                 break;</span><br><s=
pan>             }</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/s=
rc/openvpn/tls_crypt.c</span><br><span>index 2b00e1c..bfe665e 100644</span>=
<br><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/t=
ls_crypt.c</span><br><span>@@ -159,7 +159,7 @@</span><br><span>     dmsg(D_=
PACKET_CONTENT, &quot;TLS-CRYPT WRAP AD: %s&quot;, format_hex(BPTR(dst), BL=
EN(dst), 0, &amp;gc));</span><br><span> </span><br><span>     /* Buffer ove=
rflow check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(!buf_safe(dst, BLEN(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(dst, =
BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))</span><br><span>  =
   {</span><br><span>         msg(D_CRYPT_ERRORS,</span><br><span>         =
    &quot;TLS-CRYPT WRAP: buffer size error, &quot;</span><br><span>@@ -222=
,7 +222,7 @@</span><br><span> </span><br><span>     dmsg(D_PACKET_CONTENT, =
&quot;TLS-CRYPT UNWRAP FROM: %s&quot;, format_hex(BPTR(src), BLEN(src), 80,=
 &amp;gc));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (buf_len(src) &lt; TLS_CRYPT_OFF_CT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(src) &lt; TLS_CRYPT_OFF_CT)=
</span><br><span>     {</span><br><span>         CRYPT_ERROR(&quot;packet t=
oo short&quot;);</span><br><span>     }</span><br><span>@@ -232,7 +232,7 @@=
</span><br><span>         int outlen =3D 0;</span><br><span> </span><br><sp=
an>         /* Buffer overflow check (should never fail) */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if (!buf_safe(dst, BLEN(src) =
- TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_SIZE))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!buf_safe(dst, BLENZ(src) - TLS_CRYPT_O=
FF_CT + TLS_CRYPT_BLOCK_SIZE))</span><br><span>         {</span><br><span> =
            CRYPT_ERROR(&quot;potential buffer overflow&quot;);</span><br><=
span>         }</span><br><span>@@ -441,7 +441,7 @@</span><br><span>     ui=
nt16_t net_len =3D 0;</span><br><span>     const uint8_t *tag =3D BPTR(&amp=
;wrapped_client_key);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (BLEN(&amp;wrapped_client_key) &lt; sizeof(net_len=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(&am=
p;wrapped_client_key) &lt; sizeof(net_len))</span><br><span>     {</span><b=
r><span>         CRYPT_ERROR(&quot;failed to read length&quot;);</span><br>=
<span>     }</span><br><span>@@ -496,7 +496,7 @@</span><br><span>          =
                    &quot;a different tls-crypt-v2 server key)&quot;);</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (buf_len(&amp;plaintext) &lt; sizeof(client_key-&gt;k=
eys))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(=
&amp;plaintext) &lt; sizeof(client_key-&gt;keys))</span><br><span>     {</s=
pan><br><span>         CRYPT_ERROR(&quot;failed to read client key&quot;);<=
/span><br><span>     }</span><br><span>@@ -523,7 +523,7 @@</span><br><span>=
 static bool</span><br><span> tls_crypt_v2_check_client_key_age(const struc=
t tls_wrap_ctx *ctx, int max_days)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ctx-&gt;tls_crypt_v2_metadata.len &=
lt; 1 + sizeof(int64_t))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (BLENZ(&amp;ctx-&gt;tls_crypt_v2_metadata) &lt; 1 + sizeof(int6=
4_t))</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;ERR=
OR: Client key metadata is too small to contain a timestamp.&quot;);</span>=
<br><span>         return false;</span><br><span>@@ -619,7 +619,7 @@</span>=
<br><span>     struct buffer wrapped_client_key =3D *buf;</span><br><span> =
    uint16_t net_len =3D 0;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (BLEN(&amp;wrapped_client_key) &lt; sizeof(n=
et_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLE=
NZ(&amp;wrapped_client_key) &lt; sizeof(net_len))</span><br><span>     {</s=
pan><br><span>         msg(D_TLS_ERRORS, &quot;Can not read tls-crypt-v2 cl=
ient key length&quot;);</span><br><span>         return false;</span><br><s=
pan>diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>inde=
x 34f4929..4d6dfbb 100644</span><br><span>--- a/src/openvpn/tun.h</span><br=
><span>+++ b/src/openvpn/tun.h</span><br><span>@@ -510,14 +510,14 @@</span>=
<br><span> </span><br><span>     if (OPENVPN_IPH_GET_VER(ih-&gt;version_len=
) =3D=3D 4)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (BLEN(buf) &lt; sizeof(struct openvpn_iphdr))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLENZ(buf) &l=
t; sizeof(struct openvpn_iphdr))</span><br><span>         {</span><br><span=
>             return false;</span><br><span>         }</span><br><span>    =
 }</span><br><span>     else if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =
=3D=3D 6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (BLEN(buf) &lt; sizeof(struct openvpn_ipv6hdr))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLENZ(buf) &l=
t; sizeof(struct openvpn_ipv6hdr))</span><br><span>         {</span><br><sp=
an>             return false;</span><br><span>         }</span><br><span>di=
ff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c</span><br><span>index 85=
a54eb..bffc60e 100644</span><br><span>--- a/src/openvpn/vlan.c</span><br><s=
pan>+++ b/src/openvpn/vlan.c</span><br><span>@@ -85,7 +85,7 @@</span><br><s=
pan>     uint16_t vid;</span><br><span> </span><br><span>     /* assume unt=
agged frame */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(BLEN(buf) &lt; sizeof(*ethhdr))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (BLENZ(buf) &lt; sizeof(*ethhdr))</span><br><span>     =
{</span><br><span>         goto drop;</span><br><span>     }</span><br><spa=
n>@@ -109,7 +109,7 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     /* tagged frame */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (BLEN(buf) &lt; sizeof(*vlanhdr))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(*vlanhdr))</span>=
<br><span>     {</span><br><span>         goto drop;</span><br><span>     }=
</span><br><span>@@ -184,7 +184,7 @@</span><br><span>     const struct open=
vpn_ethhdr *ethhdr;</span><br><span>     struct openvpn_8021qhdr *vlanhdr;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (BLEN(buf) &lt; sizeof(*ethhdr))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(*ethhdr))</span><br><span>  =
   {</span><br><span>         goto drop;</span><br><span>     }</span><br><=
span>@@ -197,7 +197,7 @@</span><br><span>          */</span><br><span> </sp=
an><br><span>         /* Frame too small for header type? */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; sizeof(*v=
lanhdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(BLENZ(buf) &lt; sizeof(*vlanhdr))</span><br><span>         {</span><br><sp=
an>             goto drop;</span><br><span>         }</span><br><span>@@ -2=
16,7 +216,7 @@</span><br><span>         /* Untagged frame. */</span><br><sp=
an> </span><br><span>         /* Not enough head room for VLAN tag? */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf_reverse_ca=
pacity(buf) &lt; SIZE_ETH_TO_8021Q_HDR)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (buf_reverse_capacity(buf) &lt; (int)SIZE_ET=
H_TO_8021Q_HDR)</span><br><span>         {</span><br><span>             got=
o drop;</span><br><span>         }</span><br><span>@@ -263,7 +263,7 @@</spa=
n><br><span>     const struct openvpn_8021qhdr *vlanhdr;</span><br><span>  =
   uint16_t vid;</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (BLEN(buf) &lt; sizeof(struct openvpn_8021qhdr))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; si=
zeof(struct openvpn_8021qhdr))</span><br><span>     {</span><br><span>     =
    /* frame too small to be VLAN-tagged */</span><br><span>         return=
 false;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer.c=
 b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>index 16949bc..1c=
78cf0 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</=
span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span><br><span=
>@@ -49,9 +49,9 @@</span><br><span> #define teststr2  &quot;two&quot;</span=
><br><span> #define teststr3  &quot;three&quot;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define assert_buf_equals_str(b=
uf, str)       \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    a=
ssert_int_equal(BLEN(buf), strlen(str)); \</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(buf), str, BLEN(buf));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#define assert_buf_equ=
als_str(buf, str)        \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(BLENZ(buf), strlen(str)); \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(buf), str,=
 BLENZ(buf));</span><br><span> </span><br><span> static void</span><br><spa=
n> test_buffer_printf_catrunc(void **state)</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto=
.c</span><br><span>index 3d3e53a..1679d88 100644</span><br><span>--- a/test=
s/unit_tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/o=
penvpn/test_crypto.c</span><br><span>@@ -70,7 +70,7 @@</span><br><span> </s=
pan><br><span>     assert_true(crypto_pem_decode(&quot;TESTKEYNAME&quot;, &=
amp;dec_buf, &amp;pem_buf));</span><br><span>     assert_int_equal(BLEN(&am=
p;src_buf), BLEN(&amp;dec_buf));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    assert_memory_equal(BPTR(&amp;src_buf), BPTR(&amp;dec_buf), =
BLEN(&amp;src_buf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_memory_equal(BPTR(&amp;src_buf), BPTR(&amp;dec_buf), BLENZ(&amp=
;src_buf));</span><br><span> </span><br><span>     gc_free(&amp;gc);</span>=
<br><span> }</span><br><span>diff --git a/tests/unit_tests/openvpn/test_pkt=
.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>index fc2c0a1..a94=
732d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkt.c</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>@@ -66=
5,7 +665,7 @@</span><br><span>     struct buffer buf2 =3D</span><br><span> =
        tls_reset_standalone(&amp;tas.tls_wrap, &amp;tas, &amp;client_id, &=
amp;server_id, header, false);</span><br><span>     assert_int_equal(BLEN(&=
amp;buf), BLEN(&amp;buf2));</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    assert_memory_equal(BPTR(&amp;buf), BPTR(&amp;buf2), BLEN(&amp;bu=
f));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memo=
ry_equal(BPTR(&amp;buf), BPTR(&amp;buf2), BLENZ(&amp;buf));</span><br><span=
> </span><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><=
span>     free_buf(&amp;tas.workbuf);</span><br><span>@@ -702,7 +702,7 @@</=
span><br><span>     struct buffer buf2 =3D tls_reset_standalone(&amp;tas_cl=
ient.tls_wrap, &amp;tas_client, &amp;client_id,</span><br><span>           =
                                    &amp;server_id, header, false);</span><=
br><span>     assert_int_equal(BLEN(&amp;buf), BLEN(&amp;buf2));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&am=
p;buf), BPTR(&amp;buf2), BLEN(&amp;buf));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), BPTR(&amp;buf=
2), BLENZ(&amp;buf));</span><br><span> </span><br><span>     free_tls_pre_d=
ecrypt_state(&amp;state);</span><br><span> </span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</sp=
an><br><span>index 153aa77..2b73ee7 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openvpn/te=
st_ssl.c</span><br><span>@@ -324,9 +324,9 @@</span><br><span> </span><br><s=
pan>         /* copy source to input buf */</span><br><span>         buf =
=3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_=
p =3D buf_write_alloc(&amp;buf, BLEN(&amp;src));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        buf_p =3D buf_write_alloc(&amp;buf, BL=
ENZ(&amp;src));</span><br><span>         ASSERT(buf_p);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        memcpy(buf_p, BPTR(&amp;src), BLE=
N(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span> </span><=
br><span>         /* initialize work buffer with buf.headroom bytes of prep=
end capacity */</span><br><span>         ASSERT(buf_init(&amp;encrypt_works=
pace, frame.buf.headroom));</span><br><span>@@ -370,9 +370,9 @@</span><br><=
span> </span><br><span>     /* copy source to input buf */</span><br><span>=
     buf =3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 buf_p =3D buf_write_alloc(&amp;buf, BLEN(&amp;src));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_p =3D buf_write_alloc(&amp;buf, B=
LENZ(&amp;src));</span><br><span>     ASSERT(buf_p);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    memcpy(buf_p, BPTR(&amp;src), BLEN(&amp=
;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(b=
uf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><br><span> </span><br><span> =
    ASSERT(buf_init(&amp;encrypt_workspace, frame.buf.headroom));</span><br=
><span>     openvpn_encrypt(&amp;buf, encrypt_workspace, co);</span><br><sp=
an>@@ -668,9 +668,9 @@</span><br><span> </span><br><span>     /* copy sourc=
e to input buf */</span><br><span>     buf =3D work;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf_p =3D buf_write_alloc(&amp;buf, BLE=
N(&amp;src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>     AS=
SERT(buf_p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcp=
y(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</=
span><br><span> </span><br><span>     /* initialize work buffer with buf.he=
adroom bytes of prepend capacity */</span><br><span>     ASSERT(buf_init(&a=
mp;encrypt_workspace, frame.buf.headroom));</span><br><span>diff --git a/te=
sts/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls=
_crypt.c</span><br><span>index 730841e..ed82279 100644</span><br><span>--- =
a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>+++ b/tests/uni=
t_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -225,7 +225,7 @@</span>=
<br><span>     assert_true(BLEN(&amp;ctx-&gt;source) &lt; BLEN(&amp;ctx-&gt=
;ciphertext));</span><br><span>     assert_true(tls_crypt_unwrap(&amp;ctx-&=
gt;ciphertext, &amp;ctx-&gt;unwrapped, &amp;ctx-&gt;co));</span><br><span> =
    assert_int_equal(BLEN(&amp;ctx-&gt;source), BLEN(&amp;ctx-&gt;unwrapped=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_=
equal(BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-&gt;unwrapped), BLEN(&amp;ct=
x-&gt;source));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_memory_equal(BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-&gt;unwrapped)=
, BLENZ(&amp;ctx-&gt;source));</span><br><span> }</span><br><span> </span><=
br><span> </span><br><span>@@ -259,7 +259,7 @@</span><br><span>            =
                           0x33, 0x7b, 0x9c, 0xfb, 0x56, 0xe1, 0xf1, 0x3a, =
0x87, 0x0e,</span><br><span>                                       0x66, 0x=
47, 0xdf, 0xa1, 0x95, 0xc9, 0x2c, 0x17, 0xa0, 0x15,</span><br><span>       =
                                0xba, 0x49, 0x67, 0xa1, 0x1d, 0x55, 0xea, 0=
x1a, 0x06, 0xa7 };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_memory_equal(BPTR(&amp;rctx-&gt;work), expected_ciphertext, buf_len=
(&amp;rctx-&gt;work));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_memory_equal(BPTR(&amp;rctx-&gt;work), expected_ciphertext, B=
LENZ(&amp;rctx-&gt;work));</span><br><span>     tls_wrap_free(&amp;session.=
tls_wrap_reneg);</span><br><span> </span><br><span>     /* Use previous tls=
-crypt key as 0x00, with xor we should have the same key</span><br><span>@@=
 -273,7 +273,7 @@</span><br><span>     tls_crypt_wrap(&amp;ctx-&gt;source, =
&amp;rctx-&gt;work, &amp;rctx-&gt;opt);</span><br><span>     assert_int_equ=
al(buf_len(&amp;ctx-&gt;source) + 40, buf_len(&amp;rctx-&gt;work));</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_=
memory_equal(BPTR(&amp;rctx-&gt;work), expected_ciphertext, buf_len(&amp;rc=
tx-&gt;work));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_memory_equal(BPTR(&amp;rctx-&gt;work), expected_ciphertext, BLENZ(&am=
p;rctx-&gt;work));</span><br><span>     tls_wrap_free(&amp;session.tls_wrap=
_reneg);</span><br><span> </span><br><span>     /* XOR should not force a d=
ifferent key */</span><br><span>@@ -289,7 +289,7 @@</span><br><span> </span=
><br><span>     /* Skip packet id */</span><br><span>     buf_advance(&amp;=
rctx-&gt;work, 8);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 assert_memory_not_equal(BPTR(&amp;rctx-&gt;work), expected_ciphertext, buf=
_len(&amp;rctx-&gt;work));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_memory_not_equal(BPTR(&amp;rctx-&gt;work), expected_ciphe=
rtext, BLENZ(&amp;rctx-&gt;work));</span><br><span>     tls_wrap_free(&amp;=
session.tls_wrap_reneg);</span><br><span> </span><br><span> </span><br><spa=
n>@@ -312,7 +312,7 @@</span><br><span>     assert_true(BLEN(&amp;ctx-&gt;so=
urce) &lt; BLEN(&amp;ctx-&gt;ciphertext));</span><br><span>     assert_true=
(tls_crypt_unwrap(&amp;ctx-&gt;ciphertext, &amp;ctx-&gt;unwrapped, &amp;ctx=
-&gt;co));</span><br><span>     assert_int_equal(BLEN(&amp;ctx-&gt;source),=
 BLEN(&amp;ctx-&gt;unwrapped));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    assert_memory_equal(BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-=
&gt;unwrapped), BLEN(&amp;ctx-&gt;source));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;ctx-&gt;source), =
BPTR(&amp;ctx-&gt;unwrapped), BLENZ(&amp;ctx-&gt;source));</span><br><span>=
 }</span><br><span> </span><br><span> /**</span><br><span>@@ -333,7 +333,7 =
@@</span><br><span>     assert_true(BLEN(&amp;ctx-&gt;source) &lt; BLEN(&am=
p;ctx-&gt;ciphertext));</span><br><span>     assert_true(tls_crypt_unwrap(&=
amp;ctx-&gt;ciphertext, &amp;ctx-&gt;unwrapped, &amp;ctx-&gt;co));</span><b=
r><span>     assert_int_equal(BLEN(&amp;ctx-&gt;source), BLEN(&amp;ctx-&gt;=
unwrapped));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    asser=
t_memory_equal(BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-&gt;unwrapped), BLE=
N(&amp;ctx-&gt;source));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_memory_equal(BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-&gt;u=
nwrapped), BLENZ(&amp;ctx-&gt;source));</span><br><span> }</span><br><span>=
 </span><br><span> /**</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Demail">change 11=
32</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4e75ba1dbc6d9a0f75298bc900f=
713b67e60d096 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1132 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--JSmGZ8gC590=--

