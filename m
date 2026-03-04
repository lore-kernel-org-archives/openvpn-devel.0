From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 11:59:38 +0100
Message-ID: <20260304105944.15386-1-gert@...1296...>
In-Reply-To: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
References: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] buffer: Add BLENZ macro that returns
 size_t and use it where required
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

From: Frank Lichtenheld <frank@...2641...>

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
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1132
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8304fb7..745b1c8 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -126,7 +126,7 @@
     ret.data = (uint8_t *)malloc(buf->capacity);
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
 
-    const ssize_t size = write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size = write(fd, BPTR(buf), (unsigned int)BLEN(buf));
     if (size != BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -1270,9 +1270,9 @@
     struct buffer_entry *more = bl->head;
     size_t size = 0;
     int count = 0;
-    for (count = 0; more; ++count)
+    for (; more; ++count)
     {
-        size_t extra_len = BLEN(&more->buf) + sep_len;
+        size_t extra_len = BLENZ(&more->buf) + sep_len;
         if (size + extra_len > max_len)
         {
             break;
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 86df1a5..040f752 100644
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
-    return BLEN(a) == BLEN(b) && 0 == memcmp(BPTR(a), BPTR(b), BLEN(a));
+    return BLEN(a) == BLEN(b) && 0 == memcmp(BPTR(a), BPTR(b), BLENZ(a));
 }
 
 /**
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index f671fee..32c1325 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -249,14 +249,14 @@
 
         if (h->ip.protocol == OPENVPN_IPPROTO_TCP)
         {
-            if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_tcphdr))
+            if (BLENZ(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_tcphdr))
             {
                 ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
             }
         }
         else if (h->ip.protocol == OPENVPN_IPPROTO_UDP)
         {
-            if (BLEN(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))
+            if (BLENZ(ipbuf) >= sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))
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
         buf = work;
-        buf_p = buf_write_alloc(&buf, BLEN(&src));
+        buf_p = buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
-        memcpy(buf_p, BPTR(&src), BLEN(&src));
+        memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
         /* initialize work buffer with buf.headroom bytes of prepend capacity */
         ASSERT(buf_init(&encrypt_workspace, frame->buf.headroom));
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5004e35..27cfd36 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1386,8 +1386,8 @@
         struct openvpn_iphdr *pip = (struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);
         const int ip_hlen = OPENVPN_IPH_GET_LEN(pip->version_len);
         /* Reject malformed or truncated headers */
-        if (ip_hlen < sizeof(struct openvpn_iphdr)
-            || BLEN(buf) < (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t) * 2))
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
     lzo_uint zlen = frame->buf.payload_size;
-    int err;
     uint8_t c; /* flag indicating whether or not our peer compressed */
 
     if (buf->len <= 0)
@@ -93,7 +92,7 @@
     if (c == LZO_COMPRESS_BYTE) /* packet was compressed */
     {
         ASSERT(buf_safe(&work, zlen));
-        err = LZO_DECOMPRESS(BPTR(buf), BLEN(buf), BPTR(&work), &zlen, compctx->wu.lzo.wmem);
+        int err = LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&work), &zlen, compctx->wu.lzo.wmem);
         if (err != LZO_E_OK)
         {
             dmsg(D_COMP_ERRORS, "LZO decompression error: %d", err);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index d26c9b2..df72f15 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3737,9 +3737,9 @@
         buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
-            result = (char *)malloc(BLEN(buf) + 1);
+            result = (char *)malloc(BLENZ(buf) + 1);
             check_malloc_return(result);
-            memcpy(result, buf->data, BLEN(buf));
+            memcpy(result, buf->data, BLENZ(buf));
             result[BLEN(buf)] = '\0';
         }
     }
@@ -3766,9 +3766,9 @@
         buf = buffer_list_peek(*input);
         if (buf && BLEN(buf) > 0)
         {
-            result = (char *)malloc(BLEN(buf) + 1);
+            result = (char *)malloc(BLENZ(buf) + 1);
             check_malloc_return(result);
-            memcpy(result, buf->data, BLEN(buf));
+            memcpy(result, buf->data, BLENZ(buf));
             result[BLEN(buf)] = '\0';
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
-                if (BLEN(buf) >= (int)sizeof(struct openvpn_iphdr))
+                if (BLENZ(buf) >= sizeof(struct openvpn_iphdr))
                 {
                     const struct openvpn_iphdr *ip = (const struct openvpn_iphdr *)BPTR(buf);
 
@@ -176,7 +176,7 @@
                 break;
 
             case 6:
-                if (BLEN(buf) >= (int)sizeof(struct openvpn_ipv6hdr))
+                if (BLENZ(buf) >= sizeof(struct openvpn_ipv6hdr))
                 {
                     const struct openvpn_ipv6hdr *ipv6 = (const struct openvpn_ipv6hdr *)BPTR(buf);
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
-    if (BLEN(buf) != (int)ntohs(pip6->payload_len) + 40)
+    if (BLEN(buf) != ntohs(pip6->payload_len) + 40)
     {
         return;
     }
@@ -120,7 +120,7 @@
      * verify remainder is large enough to contain a full TCP header
      */
     newbuf = *buf;
-    if (buf_advance(&newbuf, 40) && BLEN(&newbuf) >= (int)sizeof(struct openvpn_tcphdr))
+    if (buf_advance(&newbuf, 40) && BLENZ(&newbuf) >= sizeof(struct openvpn_tcphdr))
     {
         struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *)BPTR(&newbuf);
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
             if (h->nlmsg_type == NLMSG_ERROR)
             {
                 err = (struct nlmsgerr *)NLMSG_DATA(h);
-                if (rem_len < sizeof(struct nlmsgerr))
+                if (rem_len < (int)sizeof(struct nlmsgerr))
                 {
                     msg(M_WARN, "%s: ERROR truncated", __func__);
                     ret = -EIO;
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index a55a2ae..13fe0a5 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -45,7 +45,7 @@
     verify_align_4(buf);
     if (tunnel_type == DEV_TYPE_TUN)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        if (BLENZ(buf) < sizeof(struct openvpn_iphdr))
         {
             return false;
         }
@@ -54,7 +54,7 @@
     else if (tunnel_type == DEV_TYPE_TAP)
     {
         const struct openvpn_ethhdr *eh;
-        if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr)))
+        if (BLENZ(buf) < sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))
         {
             return false;
         }
@@ -70,7 +70,7 @@
         if (proto == htons(OPENVPN_ETH_P_8021Q))
         {
             const struct openvpn_8021qhdr *evh;
-            if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr)))
+            if (BLENZ(buf) < sizeof(struct openvpn_ethhdr) + sizeof(struct openvpn_iphdr))
             {
                 return false;
             }
@@ -185,7 +185,7 @@
             const char *msgstr = "PACKET SIZE INFO";
             msglvl_t msglevel = D_PACKET_TRUNC_DEBUG;
 
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
             iov[1].iov_base = BPTR(head);
-            iov[1].iov_len = BLEN(head);
+            iov[1].iov_len = BLENZ(head);
             mesg.msg_iovlen = 2;
         }
 
@@ -582,7 +582,7 @@
 proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)
 {
     const socket_descriptor_t sd = pc->counterpart->sd;
-    const ssize_t status = send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_NOSIGNAL);
+    const ssize_t status = send(sd, BPTR(&pc->buf), BLENZ(&pc->buf), MSG_NOSIGNAL);
 
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
+    if (BLENZ(&buf) >= sizeof(push_reply_cmd))
     {
         const bool status = send_control_channel_string(c, BSTR(&buf), D_PUSH);
         if (!status)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 033444e..d92b551 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2263,7 +2263,7 @@
 #else
         struct buffer frag;
         stream_buf_get_next(&sock->stream_buf, &frag);
-        len = recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
+        len = recv(sock->sd, BPTR(&frag), BLENZ(&frag), MSG_NOSIGNAL);
 #endif
 
         if (!len)
@@ -2411,8 +2411,8 @@
 ssize_t
 link_socket_write_tcp(struct link_socket *sock, struct buffer *buf, struct link_socket_actual *to)
 {
-    packet_size_type len = BLEN(buf);
-    dmsg(D_STREAM_DEBUG, "STREAM: WRITE %d offset=%d", (int)len, buf->offset);
+    packet_size_type len = (packet_size_type)BLENZ(buf);
+    dmsg(D_STREAM_DEBUG, "STREAM: WRITE %u offset=%d", len, buf->offset);
     ASSERT(len <= sock->stream_buf.maxlen);
     len = htonps(len);
     ASSERT(buf_write_prepend(buf, &len, sizeof(len)));
@@ -2439,7 +2439,7 @@
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];
 
     iov.iov_base = BPTR(buf);
-    iov.iov_len = BLEN(buf);
+    iov.iov_len = BLENZ(buf);
     mesg.msg_iov = &iov;
     mesg.msg_iovlen = 1;
     switch (to->dest.addr.sa.sa_family)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 3f46dc6..08cc849 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -690,14 +690,14 @@
     }
     else
 #endif
-        return sendto(sock->sd, BPTR(buf), BLEN(buf), 0, (struct sockaddr *)&to->dest.addr.sa,
+        return sendto(sock->sd, BPTR(buf), BLENZ(buf), 0, (struct sockaddr *)&to->dest.addr.sa,
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
-    bool ret = ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output, output_len);
+    bool ret = ssl_tls1_PRF(BPTR(&seed), BLENZ(&seed), secret, secret_len, output, output_len);
 
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
-    if (status == 1)                     /* success status return from bio_write? */
+    /* success status return from bio_write? */
+    if (status == 1)
     {
-        memset(BPTR(buf), 0, BLEN(buf)); /* erase data just written */
+        memset(BPTR(buf), 0, BLENZ(buf)); /* erase data just written */
         buf->len = 0;
     }
 }
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 4e97ae4..1805995 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -298,7 +298,7 @@
 {
     struct gc_arena gc = gc_new();
     /* A packet needs to have at least an opcode and session id */
-    if (buf->len < (1 + SID_SIZE))
+    if (BLENZ(buf) < 1 + SID_SIZE)
     {
         dmsg(D_TLS_STATE_ERRORS, "TLS State Error: Too short packet (length  %d) received from %s",
              buf->len, print_link_socket_actual(from, &gc));
@@ -568,7 +568,7 @@
 {
     /* commands on the control channel are seperated by 0x00 bytes.
      * cmdlen does not include the 0 byte of the string */
-    int cmdlen = (int)strnlen(BSTR(buf), BLEN(buf));
+    int cmdlen = (int)strnlen(BSTR(buf), BLENZ(buf));
 
     if (cmdlen >= BLEN(buf))
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 9e30d25..d44f25f 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -692,7 +692,7 @@
 
         while (current_hash)
         {
-            if (memcmp_constant_time(BPTR(&cert_fp), current_hash->hash, BLEN(&cert_fp)) == 0)
+            if (memcmp_constant_time(BPTR(&cert_fp), current_hash->hash, BLENZ(&cert_fp)) == 0)
             {
                 break;
             }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2b00e1c..bfe665e 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -159,7 +159,7 @@
     dmsg(D_PACKET_CONTENT, "TLS-CRYPT WRAP AD: %s", format_hex(BPTR(dst), BLEN(dst), 0, &gc));
 
     /* Buffer overflow check */
-    if (!buf_safe(dst, BLEN(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))
+    if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_CRYPT_TAG_SIZE))
     {
         msg(D_CRYPT_ERRORS,
             "TLS-CRYPT WRAP: buffer size error, "
@@ -222,7 +222,7 @@
 
     dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(BPTR(src), BLEN(src), 80, &gc));
 
-    if (buf_len(src) < TLS_CRYPT_OFF_CT)
+    if (BLENZ(src) < TLS_CRYPT_OFF_CT)
     {
         CRYPT_ERROR("packet too short");
     }
@@ -232,7 +232,7 @@
         int outlen = 0;
 
         /* Buffer overflow check (should never fail) */
-        if (!buf_safe(dst, BLEN(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_SIZE))
+        if (!buf_safe(dst, BLENZ(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_SIZE))
         {
             CRYPT_ERROR("potential buffer overflow");
         }
@@ -441,7 +441,7 @@
     uint16_t net_len = 0;
     const uint8_t *tag = BPTR(&wrapped_client_key);
 
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
 tls_crypt_v2_check_client_key_age(const struct tls_wrap_ctx *ctx, int max_days)
 {
-    if (ctx->tls_crypt_v2_metadata.len < 1 + sizeof(int64_t))
+    if (BLENZ(&ctx->tls_crypt_v2_metadata) < 1 + sizeof(int64_t))
     {
         msg(M_WARN, "ERROR: Client key metadata is too small to contain a timestamp.");
         return false;
@@ -619,7 +619,7 @@
     struct buffer wrapped_client_key = *buf;
     uint16_t net_len = 0;
 
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
 
     if (OPENVPN_IPH_GET_VER(ih->version_len) == 4)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        if (BLENZ(buf) < sizeof(struct openvpn_iphdr))
         {
             return false;
         }
     }
     else if (OPENVPN_IPH_GET_VER(ih->version_len) == 6)
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
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index d04f40a..5f43e0d 100644
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
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
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
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c
index fc2c0a1..a94732d 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -665,7 +665,7 @@
     struct buffer buf2 =
         tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
-    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLENZ(&buf));
 
     free_tls_pre_decrypt_state(&state);
     free_buf(&tas.workbuf);
@@ -702,7 +702,7 @@
     struct buffer buf2 = tls_reset_standalone(&tas_client.tls_wrap, &tas_client, &client_id,
                                               &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
-    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLENZ(&buf));
 
     free_tls_pre_decrypt_state(&state);
 
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 153aa77..2b73ee7 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -324,9 +324,9 @@
 
         /* copy source to input buf */
         buf = work;
-        buf_p = buf_write_alloc(&buf, BLEN(&src));
+        buf_p = buf_write_alloc(&buf, BLENZ(&src));
         ASSERT(buf_p);
-        memcpy(buf_p, BPTR(&src), BLEN(&src));
+        memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
         /* initialize work buffer with buf.headroom bytes of prepend capacity */
         ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
@@ -370,9 +370,9 @@
 
     /* copy source to input buf */
     buf = work;
-    buf_p = buf_write_alloc(&buf, BLEN(&src));
+    buf_p = buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
-    memcpy(buf_p, BPTR(&src), BLEN(&src));
+    memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
     ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
     openvpn_encrypt(&buf, encrypt_workspace, co);
@@ -668,9 +668,9 @@
 
     /* copy source to input buf */
     buf = work;
-    buf_p = buf_write_alloc(&buf, BLEN(&src));
+    buf_p = buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
-    memcpy(buf_p, BPTR(&src), BLEN(&src));
+    memcpy(buf_p, BPTR(&src), BLENZ(&src));
 
     /* initialize work buffer with buf.headroom bytes of prepend capacity */
     ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 730841e..ed82279 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -225,7 +225,7 @@
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
     assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
-    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLEN(&ctx->source));
+    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLENZ(&ctx->source));
 }
 
 
@@ -259,7 +259,7 @@
                                       0x33, 0x7b, 0x9c, 0xfb, 0x56, 0xe1, 0xf1, 0x3a, 0x87, 0x0e,
                                       0x66, 0x47, 0xdf, 0xa1, 0x95, 0xc9, 0x2c, 0x17, 0xa0, 0x15,
                                       0xba, 0x49, 0x67, 0xa1, 0x1d, 0x55, 0xea, 0x1a, 0x06, 0xa7 };
-    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, buf_len(&rctx->work));
+    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, BLENZ(&rctx->work));
     tls_wrap_free(&session.tls_wrap_reneg);
 
     /* Use previous tls-crypt key as 0x00, with xor we should have the same key
@@ -273,7 +273,7 @@
     tls_crypt_wrap(&ctx->source, &rctx->work, &rctx->opt);
     assert_int_equal(buf_len(&ctx->source) + 40, buf_len(&rctx->work));
 
-    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, buf_len(&rctx->work));
+    assert_memory_equal(BPTR(&rctx->work), expected_ciphertext, BLENZ(&rctx->work));
     tls_wrap_free(&session.tls_wrap_reneg);
 
     /* XOR should not force a different key */
@@ -289,7 +289,7 @@
 
     /* Skip packet id */
     buf_advance(&rctx->work, 8);
-    assert_memory_not_equal(BPTR(&rctx->work), expected_ciphertext, buf_len(&rctx->work));
+    assert_memory_not_equal(BPTR(&rctx->work), expected_ciphertext, BLENZ(&rctx->work));
     tls_wrap_free(&session.tls_wrap_reneg);
 
 
@@ -312,7 +312,7 @@
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
     assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
-    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLEN(&ctx->source));
+    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLENZ(&ctx->source));
 }
 
 /**
@@ -333,7 +333,7 @@
     assert_true(BLEN(&ctx->source) < BLEN(&ctx->ciphertext));
     assert_true(tls_crypt_unwrap(&ctx->ciphertext, &ctx->unwrapped, &ctx->co));
     assert_int_equal(BLEN(&ctx->source), BLEN(&ctx->unwrapped));
-    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLEN(&ctx->source));
+    assert_memory_equal(BPTR(&ctx->source), BPTR(&ctx->unwrapped), BLENZ(&ctx->source));
 }
 
 /**

