From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Aug 2025 14:29:36 +0000
References: <gerrit.1754490554000.I4e75ba1dbc6d9a0f75298bc900f713b67e60d096@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2975cb6e4a2e03f4a93f08d966edbf660cda7a0a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ozKj0+MCPHc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ozKj0+MCPHc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Demail

to review the following change.


Change subject: buffer: Add BLENZ macro that returns size_t and use it wher=
e required
......................................................................

buffer: Add BLENZ macro that returns size_t and use it where required

The big int-vs-size_t length confusion in buffer and its
users can't be solved easily or quickly. So as a first step
document which users of BLEN actually already want a size_t
return. This is better than adding manual size_t casts since
it should be easier to change the API later.

Still reduces the -Wconversion noice considerably.

Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/comp-lz4.c
M src/openvpn/crypto.c
M src/openvpn/dhcp.c
M src/openvpn/lzo.c
M src/openvpn/manage.c
M src/openvpn/misc.c
M src/openvpn/mroute.c
M src/openvpn/mss.c
M src/openvpn/pkcs11.c
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
M src/openvpn/vlan.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_crypto.c
M tests/unit_tests/openvpn/test_pkt.c
M tests/unit_tests/openvpn/test_ssl.c
M tests/unit_tests/openvpn/test_tls_crypt.c
27 files changed, 81 insertions(+), 80 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1132/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index b6d6669..3dd8b31 100644
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
=20
-    const ssize_t size =3D write(fd, BPTR(buf), BLEN(buf));
+    const ssize_t size =3D write(fd, BPTR(buf), BLENZ(buf));
     if (size !=3D BLEN(buf))
     {
         msg(M_ERRNO, "Write error on file '%s'", filename);
@@ -1246,9 +1246,9 @@
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
index ae783c6..8d6bb64 100644
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
@@ -709,7 +710,7 @@
 static inline bool
 buf_copy(struct buffer *dest, const struct buffer *src)
 {
-    return buf_write(dest, BPTR(src), BLEN(src));
+    return buf_write(dest, BPTR(src), BLENZ(src));
 }

 static inline bool
@@ -826,7 +827,7 @@
 static inline bool
 buf_equal(const struct buffer *a, const struct buffer *b)
 {
-    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLE=
N(a));
+    return BLEN(a) =3D=3D BLEN(b) && 0 =3D=3D memcmp(BPTR(a), BPTR(b), BLE=
NZ(a));
 }

 /**
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index 6736469..366cc1a 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -94,7 +94,7 @@
 {
     int uncomp_len;
     ASSERT(buf_safe(work, zlen_max));
-    uncomp_len =3D LZ4_decompress_safe((const char *)BPTR(buf), (char *)BP=
TR(work), (size_t)BLEN(buf),
+    uncomp_len =3D LZ4_decompress_safe((const char *)BPTR(buf), (char *)BP=
TR(work), BLENZ(buf),
                                      zlen_max);
     if (uncomp_len <=3D 0)
     {
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6882ec3..1fa08fd 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -112,7 +112,7 @@
             }
         }
         /* Write packet id part of IV to work buffer */
-        ASSERT(buf_write(&work, iv, buf_len(&iv_buffer)));
+        ASSERT(buf_write(&work, iv, BLENZ(&iv_buffer)));

         /* This generates the IV by XORing the implicit part of the IV
          * with the packet id already written to the iv buffer */
@@ -1237,9 +1237,9 @@

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
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c
index 0a7689f..f0e0d73f 100644
--- a/src/openvpn/dhcp.c
+++ b/src/openvpn/dhcp.c
@@ -150,7 +150,7 @@
     struct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);
     const int optlen =3D
         BLEN(ipbuf)
-        - (sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + =
sizeof(struct dhcp));
+        - (int)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphd=
r) + sizeof(struct dhcp));

     if (optlen >=3D 0 && df->ip.protocol =3D=3D OPENVPN_IPPROTO_UDP
         && df->udp.source =3D=3D htons(BOOTPS_PORT) && df->udp.dest =3D=3D=
 htons(BOOTPC_PORT)
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index 3a73d5f..a86d7a5 100644
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
index aed04f5..16b1b73 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3634,9 +3634,9 @@
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
@@ -3663,9 +3663,9 @@
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
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 17f7706..6fb16f0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -251,7 +251,7 @@
                 struct buffer user_prompt =3D alloc_buf_gc(128, &gc);

                 buf_printf(&user_prompt, "NEED-OK|%s|%s:", prefix, up->use=
rname);
-                if (!query_user_SINGLE(BSTR(&user_prompt), BLEN(&user_prom=
pt), up->password,
+                if (!query_user_SINGLE(BSTR(&user_prompt), BLENZ(&user_pro=
mpt), up->password,
                                        USER_PASS_LEN, false))
                 {
                     msg(M_FATAL, "ERROR: could not read %s ok-confirmation=
 from stdin", prefix);
@@ -374,7 +374,7 @@
                     buf_printf(&challenge, "CHALLENGE: %s", ac->challenge_=
text);
                     buf_set_write(&packed_resp, (uint8_t *)up->password, U=
SER_PASS_LEN);

-                    if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challen=
ge), response,
+                    if (!query_user_SINGLE(BSTR(&challenge), BLENZ(&challe=
nge), response,
                                            USER_PASS_LEN, BOOL_CAST(ac->fl=
ags & CR_ECHO)))
                     {
                         msg(M_FATAL, "ERROR: could not read challenge resp=
onse from stdin");
@@ -399,13 +399,13 @@

                 if (username_from_stdin && !(flags & GET_USER_PASS_PASSWOR=
D_ONLY))
                 {
-                    query_user_add(BSTR(&user_prompt), BLEN(&user_prompt),=
 up->username,
+                    query_user_add(BSTR(&user_prompt), BLENZ(&user_prompt)=
, up->username,
                                    USER_PASS_LEN, true);
                 }

                 if (password_from_stdin)
                 {
-                    query_user_add(BSTR(&pass_prompt), BLEN(&pass_prompt),=
 up->password,
+                    query_user_add(BSTR(&pass_prompt), BLENZ(&pass_prompt)=
, up->password,
                                    USER_PASS_LEN, false);
                 }

@@ -433,7 +433,7 @@
                     challenge =3D alloc_buf_gc(14 + strlen(auth_challenge)=
, &gc);
                     buf_printf(&challenge, "CHALLENGE: %s", auth_challenge=
);

-                    if (!query_user_SINGLE(BSTR(&challenge), BLEN(&challen=
ge), response,
+                    if (!query_user_SINGLE(BSTR(&challenge), BLENZ(&challe=
nge), response,
                                            USER_PASS_LEN,
                                            BOOL_CAST(flags & GET_USER_PASS=
_STATIC_CHALLENGE_ECHO)))
                     {
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index a598037..62335c4 100644
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
=20
             case 6:
-                if (BLEN(buf) >=3D (int)sizeof(struct openvpn_ipv6hdr))
+                if (BLENZ(buf) >=3D sizeof(struct openvpn_ipv6hdr))
                 {
                     const struct openvpn_ipv6hdr *ipv6 =3D (const struct o=
penvpn_ipv6hdr *)BPTR(buf);
 #if 0 /* very basic debug */
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 32cd3f8..bf18202 100644
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
+    if (BLENZ(buf) !=3D ntohs(pip6->payload_len) + 40)
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
@@ -144,7 +144,7 @@
     int accumulate;
     struct openvpn_tcphdr *tc;

-    if (BLEN(buf) < (int)sizeof(struct openvpn_tcphdr))
+    if (BLENZ(buf) < sizeof(struct openvpn_tcphdr))
     {
         return;
     }
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index dfc87f6..d9429f9 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -662,7 +662,7 @@
     ASSERT(token !=3D NULL);

     buf_printf(&pass_prompt, "Please enter '%s' token PIN or 'cancel': ", =
token->display);
-    if (!query_user_SINGLE(BSTR(&pass_prompt), BLEN(&pass_prompt), pin, pi=
n_max, false))
+    if (!query_user_SINGLE(BSTR(&pass_prompt), BLENZ(&pass_prompt), pin, p=
in_max, false))
     {
         msg(M_FATAL, "Could not retrieve the PIN");
     }
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index 34b3378..9adc623 100644
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
+        if (BLENZ(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct op=
envpn_iphdr)))
         {
             return false;
         }
@@ -70,7 +70,7 @@
         if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))
         {
             const struct openvpn_8021qhdr *evh;
-            if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct=
 openvpn_iphdr)))
+            if (BLENZ(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struc=
t openvpn_iphdr)))
             {
                 return false;
             }
@@ -185,7 +185,7 @@
             const char *msgstr =3D "PACKET SIZE INFO";
             unsigned int msglevel =3D D_PACKET_TRUNC_DEBUG;

-            if (BLEN(&buf) < (int)sizeof(struct openvpn_iphdr))
+            if (BLENZ(&buf) < sizeof(struct openvpn_iphdr))
             {
                 return;
             }
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index b4199c3..a04398e 100644
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

@@ -586,7 +586,7 @@
 proxy_connection_io_send(struct proxy_connection *pc, int *bytes_sent)
 {
     const socket_descriptor_t sd =3D pc->counterpart->sd;
-    const int status =3D send(sd, BPTR(&pc->buf), BLEN(&pc->buf), MSG_NOSI=
GNAL);
+    const int status =3D send(sd, BPTR(&pc->buf), BLENZ(&pc->buf), MSG_NOS=
IGNAL);

     if (status < 0)
     {
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index b0be70d..750204e 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -817,7 +817,7 @@
         buf_printf(&buf, ",push-continuation 1");
     }

-    if (BLEN(&buf) > sizeof(push_reply_cmd) - 1)
+    if (BLENZ(&buf) > sizeof(push_reply_cmd) - 1)
     {
         const bool status =3D send_control_channel_string(c, BSTR(&buf), D=
_PUSH);
         if (!status)
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4019c1e..0558db7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -3174,7 +3174,7 @@
 #else
         struct buffer frag;
         stream_buf_get_next(&sock->stream_buf, &frag);
-        len =3D recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
+        len =3D recv(sock->sd, BPTR(&frag), BLENZ(&frag), MSG_NOSIGNAL);
 #endif

         if (!len)
@@ -3320,8 +3320,8 @@
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
@@ -3344,7 +3344,7 @@
     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];

     iov.iov_base =3D BPTR(buf);
-    iov.iov_len =3D BLEN(buf);
+    iov.iov_len =3D BLENZ(buf);
     mesg.msg_iov =3D &iov;
     mesg.msg_iovlen =3D 1;
     switch (to->dest.addr.sa.sa_family)
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 3b82dac..51d6813 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1111,14 +1111,14 @@
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
index b7db1e7..84ef4fb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1318,7 +1318,7 @@
     }

     /* compute PRF */
-    bool ret =3D ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len=
, output, output_len);
+    bool ret =3D ssl_tls1_PRF(BPTR(&seed), BLENZ(&seed), secret, secret_le=
n, output, output_len);

     buf_clear(&seed);
     free_buf(&seed);
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index aa1ac11..b2fa972 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2083,9 +2083,10 @@
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
index b901f87..d34036f 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -531,7 +531,7 @@
 {
     /* commands on the control channel are seperated by 0x00 bytes.
      * cmdlen does not include the 0 byte of the string */
-    int cmdlen =3D (int)strnlen(BSTR(buf), BLEN(buf));
+    int cmdlen =3D (int)strnlen(BSTR(buf), BLENZ(buf));

     if (cmdlen >=3D BLEN(buf))
     {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 6f85dca..5179d33 100644
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
index 2892199..f579c61 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -158,7 +158,7 @@
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
@@ -231,7 +231,7 @@
         int outlen =3D 0;

         /* Buffer overflow check (should never fail) */
-        if (!buf_safe(dst, BLEN(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_=
SIZE))
+        if (!buf_safe(dst, BLENZ(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK=
_SIZE))
         {
             CRYPT_ERROR("potential buffer overflow");
         }
@@ -241,7 +241,7 @@
             CRYPT_ERROR("cipher reset failed");
         }
         if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, BPTR(src) =
+ TLS_CRYPT_OFF_CT,
-                               BLEN(src) - TLS_CRYPT_OFF_CT))
+                               (int)(BLENZ(src) - TLS_CRYPT_OFF_CT)))
         {
             CRYPT_ERROR("cipher update failed");
         }
@@ -376,8 +376,8 @@
         msg(M_WARN, "ERROR: could not write tag");
         return false;
     }
-    uint16_t net_len =3D htons(sizeof(src_key->keys) + BLEN(src_metadata) =
+ TLS_CRYPT_V2_TAG_SIZE
-                             + sizeof(uint16_t));
+    uint16_t net_len =3D htons((uint16_t)(sizeof(src_key->keys) + BLENZ(sr=
c_metadata)
+                                        + TLS_CRYPT_V2_TAG_SIZE + sizeof(u=
int16_t)));
     hmac_ctx_t *hmac_ctx =3D server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
     hmac_ctx_update(hmac_ctx, (void *)&net_len, sizeof(net_len));
@@ -391,7 +391,7 @@
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));

     /* Overflow check (OpenSSL requires an extra block in the dst buffer) =
*/
-    if (buf_forward_capacity(&work) < (sizeof(src_key->keys) + BLEN(src_me=
tadata) + sizeof(net_len)
+    if (buf_forward_capacity(&work) < (sizeof(src_key->keys) + BLENZ(src_m=
etadata) + sizeof(net_len)
                                        + cipher_ctx_block_size(cipher_ctx)=
))
     {
         msg(M_WARN, "ERROR: could not crypt: insufficient space in dst");
@@ -439,7 +439,7 @@
     uint16_t net_len =3D 0;
     const uint8_t *tag =3D BPTR(&wrapped_client_key);

-    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    if (BLENZ(&wrapped_client_key) < sizeof(net_len))
     {
         CRYPT_ERROR("failed to read length");
     }
@@ -589,7 +589,7 @@
     struct buffer wrapped_client_key =3D *buf;
     uint16_t net_len =3D 0;

-    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    if (BLENZ(&wrapped_client_key) < sizeof(net_len))
     {
         msg(D_TLS_ERRORS, "Can not read tls-crypt-v2 client key length");
         return false;
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index a6a6e93..d8f49c6 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -85,7 +85,7 @@
     uint16_t vid;
=20
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
index 0cfb918..ab53131 100644
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
index 12ddaba..de8f9fe 100644
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
index b08e4c2..5bf1562 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -549,7 +549,7 @@
     struct buffer buf2 =3D
         tls_reset_standalone(&tas.tls_wrap, &tas, &client_id, &server_id, =
header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
-    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLENZ(&buf));

     free_tls_pre_decrypt_state(&state);
     free_buf(&tas.workbuf);
@@ -586,7 +586,7 @@
     struct buffer buf2 =3D tls_reset_standalone(&tas_client.tls_wrap, &tas=
_client, &client_id,
                                               &server_id, header, false);
     assert_int_equal(BLEN(&buf), BLEN(&buf2));
-    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLEN(&buf));
+    assert_memory_equal(BPTR(&buf), BPTR(&buf2), BLENZ(&buf));

     free_tls_pre_decrypt_state(&state);

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 7bf5396..cfa30a8 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -344,9 +344,9 @@

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
@@ -390,9 +390,9 @@

     /* copy source to input buf */
     buf =3D work;
-    buf_p =3D buf_write_alloc(&buf, BLEN(&src));
+    buf_p =3D buf_write_alloc(&buf, BLENZ(&src));
     ASSERT(buf_p);
-    memcpy(buf_p, BPTR(&src), BLEN(&src));
+    memcpy(buf_p, BPTR(&src), BLENZ(&src));

     ASSERT(buf_init(&encrypt_workspace, frame.buf.headroom));
     openvpn_encrypt(&buf, encrypt_workspace, co);
@@ -688,9 +688,9 @@
=20
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
index e2b2e38..596f0e0 100644
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
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096
Gerrit-Change-Number: 1132
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ozKj0+MCPHc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">buffer: Add BLENZ macro that returns size_t and use it where=
 required<br><br>The big int-vs-size_t length confusion in buffer and its<b=
r>users can&#39;t be solved easily or quickly. So as a first step<br>docume=
nt which users of BLEN actually already want a size_t<br>return. This is be=
tter than adding manual size_t casts since<br>it should be easier to change=
 the API later.<br><br>Still reduces the -Wconversion noice considerably.<b=
r><br>Change-Id: I4e75ba1dbc6d9a0f75298bc900f713b67e60d096<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buffer=
.c<br>M src/openvpn/buffer.h<br>M src/openvpn/comp-lz4.c<br>M src/openvpn/c=
rypto.c<br>M src/openvpn/dhcp.c<br>M src/openvpn/lzo.c<br>M src/openvpn/man=
age.c<br>M src/openvpn/misc.c<br>M src/openvpn/mroute.c<br>M src/openvpn/ms=
s.c<br>M src/openvpn/pkcs11.c<br>M src/openvpn/proto.c<br>M src/openvpn/ps.=
c<br>M src/openvpn/push.c<br>M src/openvpn/socket.c<br>M src/openvpn/socket=
.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_openssl.c<br>M src/openvpn/s=
sl_pkt.c<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/tls_crypt.c<br>M sr=
c/openvpn/vlan.c<br>M tests/unit_tests/openvpn/test_buffer.c<br>M tests/uni=
t_tests/openvpn/test_crypto.c<br>M tests/unit_tests/openvpn/test_pkt.c<br>M=
 tests/unit_tests/openvpn/test_ssl.c<br>M tests/unit_tests/openvpn/test_tls=
_crypt.c<br>27 files changed, 81 insertions(+), 80 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1132/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index b6d6669..3dd8b31 100644</span><br><span>--- a/src/openvpn/buffer.c</=
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
 =3D write(fd, BPTR(buf), BLENZ(buf));</span><br><span>     if (size !=3D B=
LEN(buf))</span><br><span>     {</span><br><span>         msg(M_ERRNO, &quo=
t;Write error on file &#39;%s&#39;&quot;, filename);</span><br><span>@@ -12=
46,9 +1246,9 @@</span><br><span>     struct buffer_entry *more =3D bl-&gt;h=
ead;</span><br><span>     size_t size =3D 0;</span><br><span>     int count=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (count=
 =3D 0; more; ++count)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (; more; ++count)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        size_t extra_len =3D BLEN(&amp;more=
-&gt;buf) + sep_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        size_t extra_len =3D BLENZ(&amp;more-&gt;buf) + sep_len;</span><br=
><span>         if (size + extra_len &gt; max_len)</span><br><span>        =
 {</span><br><span>             break;</span><br><span>diff --git a/src/ope=
nvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index ae783c6..8d6bb64=
 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/sr=
c/openvpn/buffer.h</span><br><span>@@ -124,6 +124,7 @@</span><br><span> #de=
fine BEND(buf)  (buf_bend(buf))</span><br><span> #define BLAST(buf) (buf_bl=
ast(buf))</span><br><span> #define BLEN(buf)  (buf_len(buf))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#define BLENZ(buf) ((size_t)buf_le=
n(buf))</span><br><span> #define BDEF(buf)  (buf_defined(buf))</span><br><s=
pan> #define BSTR(buf)  (buf_str(buf))</span><br><span> #define BCAP(buf)  =
(buf_forward_capacity(buf))</span><br><span>@@ -709,7 +710,7 @@</span><br><=
span> static inline bool</span><br><span> buf_copy(struct buffer *dest, con=
st struct buffer *src)</span><br><span> {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    return buf_write(dest, BPTR(src), BLEN(src));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf_write(dest=
, BPTR(src), BLENZ(src));</span><br><span> }</span><br><span> </span><br><s=
pan> static inline bool</span><br><span>@@ -826,7 +827,7 @@</span><br><span=
> static inline bool</span><br><span> buf_equal(const struct buffer *a, con=
st struct buffer *b)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=3D mem=
cmp(BPTR(a), BPTR(b), BLEN(a));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return BLEN(a) =3D=3D BLEN(b) &amp;&amp; 0 =3D=3D memcmp(BP=
TR(a), BPTR(b), BLENZ(a));</span><br><span> }</span><br><span> </span><br><=
span> /**</span><br><span>diff --git a/src/openvpn/comp-lz4.c b/src/openvpn=
/comp-lz4.c</span><br><span>index 6736469..366cc1a 100644</span><br><span>-=
-- a/src/openvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c</s=
pan><br><span>@@ -94,7 +94,7 @@</span><br><span> {</span><br><span>     int=
 uncomp_len;</span><br><span>     ASSERT(buf_safe(work, zlen_max));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    uncomp_len =3D LZ4_decomp=
ress_safe((const char *)BPTR(buf), (char *)BPTR(work), (size_t)BLEN(buf),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uncomp_len =3D LZ=
4_decompress_safe((const char *)BPTR(buf), (char *)BPTR(work), BLENZ(buf),<=
/span><br><span>                                      zlen_max);</span><br>=
<span>     if (uncomp_len &lt;=3D 0)</span><br><span>     {</span><br><span=
>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>i=
ndex 6882ec3..1fa08fd 100644</span><br><span>--- a/src/openvpn/crypto.c</sp=
an><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -112,7 +112,7 @@=
</span><br><span>             }</span><br><span>         }</span><br><span>=
         /* Write packet id part of IV to work buffer */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_write(&amp;work, iv, =
buf_len(&amp;iv_buffer)));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        ASSERT(buf_write(&amp;work, iv, BLENZ(&amp;iv_buffer)));</sp=
an><br><span> </span><br><span>         /* This generates the IV by XORing =
the implicit part of the IV</span><br><span>          * with the packet id =
already written to the iv buffer */</span><br><span>@@ -1237,9 +1237,9 @@</=
span><br><span> </span><br><span>         /* copy source to input buf */</s=
pan><br><span>         buf =3D work;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        buf_p =3D buf_write_alloc(&amp;buf, BLEN(&amp;src));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_p =3D b=
uf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT(=
buf_p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcpy=
(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src))=
;</span><br><span> </span><br><span>         /* initialize work buffer with=
 buf.headroom bytes of prepend capacity */</span><br><span>         ASSERT(=
buf_init(&amp;encrypt_workspace, frame-&gt;buf.headroom));</span><br><span>=
diff --git a/src/openvpn/dhcp.c b/src/openvpn/dhcp.c</span><br><span>index =
0a7689f..f0e0d73f 100644</span><br><span>--- a/src/openvpn/dhcp.c</span><br=
><span>+++ b/src/openvpn/dhcp.c</span><br><span>@@ -150,7 +150,7 @@</span><=
br><span>     struct dhcp_full *df =3D (struct dhcp_full *)BPTR(ipbuf);</sp=
an><br><span>     const int optlen =3D</span><br><span>         BLEN(ipbuf)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        - (sizeof(str=
uct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dhcp));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        - (int)(size=
of(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr) + sizeof(struct dh=
cp));</span><br><span> </span><br><span>     if (optlen &gt;=3D 0 &amp;&amp=
; df-&gt;ip.protocol =3D=3D OPENVPN_IPPROTO_UDP</span><br><span>         &a=
mp;&amp; df-&gt;udp.source =3D=3D htons(BOOTPS_PORT) &amp;&amp; df-&gt;udp.=
dest =3D=3D htons(BOOTPC_PORT)</span><br><span>diff --git a/src/openvpn/lzo=
.c b/src/openvpn/lzo.c</span><br><span>index 3a73d5f..a86d7a5 100644</span>=
<br><span>--- a/src/openvpn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</=
span><br><span>@@ -77,7 +77,6 @@</span><br><span>                const stru=
ct frame *frame)</span><br><span> {</span><br><span>     lzo_uint zlen =3D =
frame-&gt;buf.payload_size;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    int err;</span><br><span>     uint8_t c; /* flag indicating wheth=
er or not our peer compressed */</span><br><span> </span><br><span>     if =
(buf-&gt;len &lt;=3D 0)</span><br><span>@@ -93,7 +92,7 @@</span><br><span> =
    if (c =3D=3D LZO_COMPRESS_BYTE) /* packet was compressed */</span><br><=
span>     {</span><br><span>         ASSERT(buf_safe(&amp;work, zlen));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =3D LZO_DECOM=
PRESS(BPTR(buf), BLEN(buf), BPTR(&amp;work), &amp;zlen, compctx-&gt;wu.lzo.=
wmem);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int e=
rr =3D LZO_DECOMPRESS(BPTR(buf), BLENZ(buf), BPTR(&amp;work), &amp;zlen, co=
mpctx-&gt;wu.lzo.wmem);</span><br><span>         if (err !=3D LZO_E_OK)</sp=
an><br><span>         {</span><br><span>             dmsg(D_COMP_ERRORS, &q=
uot;LZO decompression error: %d&quot;, err);</span><br><span>diff --git a/s=
rc/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index aed04f5..1=
6b1b73 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>++=
+ b/src/openvpn/manage.c</span><br><span>@@ -3634,9 +3634,9 @@</span><br><s=
pan>         buf =3D buffer_list_peek(*input);</span><br><span>         if =
(buf &amp;&amp; BLEN(buf) &gt; 0)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            result =3D (char *)mallo=
c(BLEN(buf) + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          result =3D (char *)malloc(BLENZ(buf) + 1);</span><br><span>      =
       check_malloc_return(result);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            memcpy(result, buf-&gt;data, BLEN(buf));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            memcpy(result, b=
uf-&gt;data, BLENZ(buf));</span><br><span>             result[BLEN(buf)] =
=3D &#39;\0&#39;;</span><br><span>         }</span><br><span>     }</span><=
br><span>@@ -3663,9 +3663,9 @@</span><br><span>         buf =3D buffer_list=
_peek(*input);</span><br><span>         if (buf &amp;&amp; BLEN(buf) &gt; 0=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            result =3D (char *)malloc(BLEN(buf) + 1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            result =3D (char *)mal=
loc(BLENZ(buf) + 1);</span><br><span>             check_malloc_return(resul=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            memcpy=
(result, buf-&gt;data, BLEN(buf));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            memcpy(result, buf-&gt;data, BLENZ(buf));</span>=
<br><span>             result[BLEN(buf)] =3D &#39;\0&#39;;</span><br><span>=
         }</span><br><span>     }</span><br><span>diff --git a/src/openvpn/=
misc.c b/src/openvpn/misc.c</span><br><span>index 17f7706..6fb16f0 100644</=
span><br><span>--- a/src/openvpn/misc.c</span><br><span>+++ b/src/openvpn/m=
isc.c</span><br><span>@@ -251,7 +251,7 @@</span><br><span>                 =
struct buffer user_prompt =3D alloc_buf_gc(128, &amp;gc);</span><br><span> =
</span><br><span>                 buf_printf(&amp;user_prompt, &quot;NEED-O=
K|%s|%s:&quot;, prefix, up-&gt;username);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                if (!query_user_SINGLE(BSTR(&amp;user_p=
rompt), BLEN(&amp;user_prompt), up-&gt;password,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (!query_user_SINGLE(BSTR(&a=
mp;user_prompt), BLENZ(&amp;user_prompt), up-&gt;password,</span><br><span>=
                                        USER_PASS_LEN, false))</span><br><s=
pan>                 {</span><br><span>                     msg(M_FATAL, &q=
uot;ERROR: could not read %s ok-confirmation from stdin&quot;, prefix);</sp=
an><br><span>@@ -374,7 +374,7 @@</span><br><span>                     buf_p=
rintf(&amp;challenge, &quot;CHALLENGE: %s&quot;, ac-&gt;challenge_text);</s=
pan><br><span>                     buf_set_write(&amp;packed_resp, (uint8_t=
 *)up-&gt;password, USER_PASS_LEN);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (!query_user_SINGLE(=
BSTR(&amp;challenge), BLEN(&amp;challenge), response,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (!query_user_SINGL=
E(BSTR(&amp;challenge), BLENZ(&amp;challenge), response,</span><br><span>  =
                                          USER_PASS_LEN, BOOL_CAST(ac-&gt;f=
lags &amp; CR_ECHO)))</span><br><span>                     {</span><br><spa=
n>                         msg(M_FATAL, &quot;ERROR: could not read challen=
ge response from stdin&quot;);</span><br><span>@@ -399,13 +399,13 @@</span>=
<br><span> </span><br><span>                 if (username_from_stdin &amp;&=
amp; !(flags &amp; GET_USER_PASS_PASSWORD_ONLY))</span><br><span>          =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       query_user_add(BSTR(&amp;user_prompt), BLEN(&amp;user_prompt), up-&g=
t;username,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            query_user_add(BSTR(&amp;user_prompt), BLENZ(&amp;user_prompt),=
 up-&gt;username,</span><br><span>                                    USER_=
PASS_LEN, true);</span><br><span>                 }</span><br><span> </span=
><br><span>                 if (password_from_stdin)</span><br><span>      =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           query_user_add(BSTR(&amp;pass_prompt), BLEN(&amp;pass_prompt), u=
p-&gt;password,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                query_user_add(BSTR(&amp;pass_prompt), BLENZ(&amp;pass_prom=
pt), up-&gt;password,</span><br><span>                                    U=
SER_PASS_LEN, false);</span><br><span>                 }</span><br><span> <=
/span><br><span>@@ -433,7 +433,7 @@</span><br><span>                     ch=
allenge =3D alloc_buf_gc(14 + strlen(auth_challenge), &amp;gc);</span><br><=
span>                     buf_printf(&amp;challenge, &quot;CHALLENGE: %s&qu=
ot;, auth_challenge);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    if (!query_user_SINGLE(BSTR(&amp;chal=
lenge), BLEN(&amp;challenge), response,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    if (!query_user_SINGLE(BSTR(&amp;ch=
allenge), BLENZ(&amp;challenge), response,</span><br><span>                =
                            USER_PASS_LEN,</span><br><span>                =
                            BOOL_CAST(flags &amp; GET_USER_PASS_STATIC_CHAL=
LENGE_ECHO)))</span><br><span>                     {</span><br><span>diff -=
-git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index a5=
98037..62335c4 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br>=
<span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -152,7 +152,7 @@</span>=
<br><span>         switch (OPENVPN_IPH_GET_VER(*BPTR(buf)))</span><br><span=
>         {</span><br><span>             case 4:</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                if (BLEN(buf) &gt;=3D (int)sizeo=
f(struct openvpn_iphdr))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                if (BLENZ(buf) &gt;=3D sizeof(struct openvpn_iphdr))</=
span><br><span>                 {</span><br><span>                     cons=
t struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BPTR(buf);</sp=
an><br><span> </span><br><span>@@ -176,7 +176,7 @@</span><br><span>        =
         break;</span><br><span> </span><br><span>             case 6:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (BLEN(b=
uf) &gt;=3D (int)sizeof(struct openvpn_ipv6hdr))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                if (BLENZ(buf) &gt;=3D sizeof(=
struct openvpn_ipv6hdr))</span><br><span>                 {</span><br><span=
>                     const struct openvpn_ipv6hdr *ipv6 =3D (const struct =
openvpn_ipv6hdr *)BPTR(buf);</span><br><span> #if 0 /* very basic debug */<=
/span><br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><b=
r><span>index 32cd3f8..bf18202 100644</span><br><span>--- a/src/openvpn/mss=
.c</span><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -48,7 +48,7 @=
@</span><br><span>     const struct openvpn_iphdr *pip;</span><br><span>   =
  int hlen;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (BLEN(buf) &lt; (int)sizeof(struct openvpn_iphdr))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeo=
f(struct openvpn_iphdr))</span><br><span>     {</span><br><span>         re=
turn;</span><br><span>     }</span><br><span>@@ -85,7 +85,7 @@</span><br><s=
pan>     const struct openvpn_ipv6hdr *pip6;</span><br><span>     struct bu=
ffer newbuf;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (BLEN(buf) &lt; (int)sizeof(struct openvpn_ipv6hdr))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; si=
zeof(struct openvpn_ipv6hdr))</span><br><span>     {</span><br><span>      =
   return;</span><br><span>     }</span><br><span>@@ -96,7 +96,7 @@</span><=
br><span>     /* do we have the full IPv6 packet?</span><br><span>      * &=
quot;payload_len&quot; does not include IPv6 header (+40 bytes)</span><br><=
span>      */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
BLEN(buf) !=3D (int)ntohs(pip6-&gt;payload_len) + 40)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) !=3D ntohs(pip6-&gt;pa=
yload_len) + 40)</span><br><span>     {</span><br><span>         return;</s=
pan><br><span>     }</span><br><span>@@ -120,7 +120,7 @@</span><br><span>  =
    * verify remainder is large enough to contain a full TCP header</span><=
br><span>      */</span><br><span>     newbuf =3D *buf;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (buf_advance(&amp;newbuf, 40) &amp=
;&amp; BLEN(&amp;newbuf) &gt;=3D (int)sizeof(struct openvpn_tcphdr))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_advance(&amp;n=
ewbuf, 40) &amp;&amp; BLENZ(&amp;newbuf) &gt;=3D sizeof(struct openvpn_tcph=
dr))</span><br><span>     {</span><br><span>         struct openvpn_tcphdr =
*tc =3D (struct openvpn_tcphdr *)BPTR(&amp;newbuf);</span><br><span>       =
  if (tc-&gt;flags &amp; OPENVPN_TCPH_SYN_MASK)</span><br><span>@@ -144,7 +=
144,7 @@</span><br><span>     int accumulate;</span><br><span>     struct o=
penvpn_tcphdr *tc;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (BLEN(buf) &lt; (int)sizeof(struct openvpn_tcphdr))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &l=
t; sizeof(struct openvpn_tcphdr))</span><br><span>     {</span><br><span>  =
       return;</span><br><span>     }</span><br><span>diff --git a/src/open=
vpn/pkcs11.c b/src/openvpn/pkcs11.c</span><br><span>index dfc87f6..d9429f9 =
100644</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src=
/openvpn/pkcs11.c</span><br><span>@@ -662,7 +662,7 @@</span><br><span>     =
ASSERT(token !=3D NULL);</span><br><span> </span><br><span>     buf_printf(=
&amp;pass_prompt, &quot;Please enter &#39;%s&#39; token PIN or &#39;cancel&=
#39;: &quot;, token-&gt;display);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!query_user_SINGLE(BSTR(&amp;pass_prompt), BLEN(&amp;pa=
ss_prompt), pin, pin_max, false))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!query_user_SINGLE(BSTR(&amp;pass_prompt), BLENZ(&amp=
;pass_prompt), pin, pin_max, false))</span><br><span>     {</span><br><span=
>         msg(M_FATAL, &quot;Could not retrieve the PIN&quot;);</span><br><=
span>     }</span><br><span>diff --git a/src/openvpn/proto.c b/src/openvpn/=
proto.c</span><br><span>index 34b3378..9adc623 100644</span><br><span>--- a=
/src/openvpn/proto.c</span><br><span>+++ b/src/openvpn/proto.c</span><br><s=
pan>@@ -45,7 +45,7 @@</span><br><span>     verify_align_4(buf);</span><br><=
span>     if (tunnel_type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; =
sizeof(struct openvpn_iphdr))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (BLENZ(buf) &lt; sizeof(struct openvpn_iphdr))</span><=
br><span>         {</span><br><span>             return false;</span><br><s=
pan>         }</span><br><span>@@ -54,7 +54,7 @@</span><br><span>     else =
if (tunnel_type =3D=3D DEV_TYPE_TAP)</span><br><span>     {</span><br><span=
>         const struct openvpn_ethhdr *eh;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; (sizeof(struct openvpn_ethh=
dr) + sizeof(struct openvpn_iphdr)))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (BLENZ(buf) &lt; (sizeof(struct openvpn_ethhdr)=
 + sizeof(struct openvpn_iphdr)))</span><br><span>         {</span><br><spa=
n>             return false;</span><br><span>         }</span><br><span>@@ =
-70,7 +70,7 @@</span><br><span>         if (proto =3D=3D htons(OPENVPN_ETH_=
P_8021Q))</span><br><span>         {</span><br><span>             const str=
uct openvpn_8021qhdr *evh;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            if (BLEN(buf) &lt; (sizeof(struct openvpn_ethhdr) + sizeof=
(struct openvpn_iphdr)))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            if (BLENZ(buf) &lt; (sizeof(struct openvpn_ethhdr) + sizeo=
f(struct openvpn_iphdr)))</span><br><span>             {</span><br><span>  =
               return false;</span><br><span>             }</span><br><span=
>@@ -185,7 +185,7 @@</span><br><span>             const char *msgstr =3D &q=
uot;PACKET SIZE INFO&quot;;</span><br><span>             unsigned int msgle=
vel =3D D_PACKET_TRUNC_DEBUG;</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            if (BLEN(&amp;buf) &lt; (int)sizeof(s=
truct openvpn_iphdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (BLENZ(&amp;buf) &lt; sizeof(struct openvpn_iphdr))</span>=
<br><span>             {</span><br><span>                 return;</span><br=
><span>             }</span><br><span>diff --git a/src/openvpn/ps.c b/src/o=
penvpn/ps.c</span><br><span>index b4199c3..a04398e 100644</span><br><span>-=
-- a/src/openvpn/ps.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><spa=
n>@@ -209,7 +209,7 @@</span><br><span>         if (head)</span><br><span>  =
       {</span><br><span>             iov[1].iov_base =3D BPTR(head);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            iov[1].iov_len =
=3D BLEN(head);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        iov[1].iov_len =3D BLENZ(head);</span><br><span>             mesg.m=
sg_iovlen =3D 2;</span><br><span>         }</span><br><span> </span><br><sp=
an>@@ -586,7 +586,7 @@</span><br><span> proxy_connection_io_send(struct pro=
xy_connection *pc, int *bytes_sent)</span><br><span> {</span><br><span>    =
 const socket_descriptor_t sd =3D pc-&gt;counterpart-&gt;sd;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    const int status =3D send(sd, BP=
TR(&amp;pc-&gt;buf), BLEN(&amp;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const int status =3D send(sd, BP=
TR(&amp;pc-&gt;buf), BLENZ(&amp;pc-&gt;buf), MSG_NOSIGNAL);</span><br><span=
> </span><br><span>     if (status &lt; 0)</span><br><span>     {</span><br=
><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span=
>index b0be70d..750204e 100644</span><br><span>--- a/src/openvpn/push.c</sp=
an><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -817,7 +817,7 @@</=
span><br><span>         buf_printf(&amp;buf, &quot;,push-continuation 1&quo=
t;);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (BLEN(&amp;buf) &gt; sizeof(push_reply_cmd) =
- 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(&=
amp;buf) &gt; sizeof(push_reply_cmd) - 1)</span><br><span>     {</span><br>=
<span>         const bool status =3D send_control_channel_string(c, BSTR(&a=
mp;buf), D_PUSH);</span><br><span>         if (!status)</span><br><span>dif=
f --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index=
 4019c1e..0558db7 100644</span><br><span>--- a/src/openvpn/socket.c</span><=
br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -3174,7 +3174,7 @@</=
span><br><span> #else</span><br><span>         struct buffer frag;</span><b=
r><span>         stream_buf_get_next(&amp;sock-&gt;stream_buf, &amp;frag);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len =3D recv(s=
ock-&gt;sd, BPTR(&amp;frag), BLEN(&amp;frag), MSG_NOSIGNAL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        len =3D recv(sock-&gt;sd, =
BPTR(&amp;frag), BLENZ(&amp;frag), MSG_NOSIGNAL);</span><br><span> #endif</=
span><br><span> </span><br><span>         if (!len)</span><br><span>@@ -332=
0,8 +3320,8 @@</span><br><span> ssize_t</span><br><span> link_socket_write_=
tcp(struct link_socket *sock, struct buffer *buf, struct link_socket_actual=
 *to)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    packet_size_type len =3D BLEN(buf);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM: WRITE %d offset=
=3D%d&quot;, (int)len, buf-&gt;offset);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    packet_size_type len =3D (packet_size_type)BLENZ(bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_STREA=
M_DEBUG, &quot;STREAM: WRITE %u offset=3D%d&quot;, len, buf-&gt;offset);</s=
pan><br><span>     ASSERT(len &lt;=3D sock-&gt;stream_buf.maxlen);</span><b=
r><span>     len =3D htonps(len);</span><br><span>     ASSERT(buf_write_pre=
pend(buf, &amp;len, sizeof(len)));</span><br><span>@@ -3344,7 +3344,7 @@</s=
pan><br><span>     uint8_t pktinfo_buf[PKTINFO_BUF_SIZE];</span><br><span> =
</span><br><span>     iov.iov_base =3D BPTR(buf);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    iov.iov_len =3D BLEN(buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    iov.iov_len =3D BLENZ(buf);</spa=
n><br><span>     mesg.msg_iov =3D &amp;iov;</span><br><span>     mesg.msg_i=
ovlen =3D 1;</span><br><span>     switch (to-&gt;dest.addr.sa.sa_family)</s=
pan><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</spa=
n><br><span>index 3b82dac..51d6813 100644</span><br><span>--- a/src/openvpn=
/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -11=
11,14 +1111,14 @@</span><br><span>     }</span><br><span>     else</span><b=
r><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return sendto(sock-&gt;sd, BPTR(buf), BLEN(buf), 0, (struct sockaddr *)&a=
mp;to-&gt;dest.addr.sa,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return sendto(sock-&gt;sd, BPTR(buf), BLENZ(buf), 0, (struct so=
ckaddr *)&amp;to-&gt;dest.addr.sa,</span><br><span>                       (=
socklen_t)af_addr_size(to-&gt;dest.addr.sa.sa_family));</span><br><span> }<=
/span><br><span> </span><br><span> static inline ssize_t</span><br><span> l=
ink_socket_write_tcp_posix(struct link_socket *sock, struct buffer *buf)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn send(sock-&gt;sd, BPTR(buf), BLEN(buf), MSG_NOSIGNAL);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return send(sock-&gt;sd, BPTR(=
buf), BLENZ(buf), MSG_NOSIGNAL);</span><br><span> }</span><br><span> </span=
><br><span> #endif /* ifdef _WIN32 */</span><br><span>diff --git a/src/open=
vpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index b7db1e7..84ef4fb 100644=
</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/=
ssl.c</span><br><span>@@ -1318,7 +1318,7 @@</span><br><span>     }</span><b=
r><span> </span><br><span>     /* compute PRF */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    bool ret =3D ssl_tls1_PRF(BPTR(&amp;seed), B=
LEN(&amp;seed), secret, secret_len, output, output_len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool ret =3D ssl_tls1_PRF(BPTR(&am=
p;seed), BLENZ(&amp;seed), secret, secret_len, output, output_len);</span><=
br><span> </span><br><span>     buf_clear(&amp;seed);</span><br><span>     =
free_buf(&amp;seed);</span><br><span>diff --git a/src/openvpn/ssl_openssl.c=
 b/src/openvpn/ssl_openssl.c</span><br><span>index aa1ac11..b2fa972 100644<=
/span><br><span>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/o=
penvpn/ssl_openssl.c</span><br><span>@@ -2083,9 +2083,10 @@</span><br><span=
> static void</span><br><span> bio_write_post(const int status, struct buff=
er *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if (status =3D=3D 1)                     /* success status return=
 from bio_write? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* success status return from bio_write? */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (status =3D=3D 1)</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memset(BPTR(b=
uf), 0, BLEN(buf)); /* erase data just written */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        memset(BPTR(buf), 0, BLENZ(buf)); /* =
erase data just written */</span><br><span>         buf-&gt;len =3D 0;</spa=
n><br><span>     }</span><br><span> }</span><br><span>diff --git a/src/open=
vpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c</span><br><span>index b901f87..d34036=
f 100644</span><br><span>--- a/src/openvpn/ssl_pkt.c</span><br><span>+++ b/=
src/openvpn/ssl_pkt.c</span><br><span>@@ -531,7 +531,7 @@</span><br><span> =
{</span><br><span>     /* commands on the control channel are seperated by =
0x00 bytes.</span><br><span>      * cmdlen does not include the 0 byte of t=
he string */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int c=
mdlen =3D (int)strnlen(BSTR(buf), BLEN(buf));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    int cmdlen =3D (int)strnlen(BSTR(buf), BLENZ(=
buf));</span><br><span> </span><br><span>     if (cmdlen &gt;=3D BLEN(buf))=
</span><br><span>     {</span><br><span>diff --git a/src/openvpn/ssl_verify=
.c b/src/openvpn/ssl_verify.c</span><br><span>index 6f85dca..5179d33 100644=
</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/o=
penvpn/ssl_verify.c</span><br><span>@@ -692,7 +692,7 @@</span><br><span> </=
span><br><span>         while (current_hash)</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (memcmp_co=
nstant_time(BPTR(&amp;cert_fp), current_hash-&gt;hash, BLEN(&amp;cert_fp)) =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (memcmp_constant_time(BPTR(&amp;cert_fp), current_hash-&gt;hash, BLENZ=
(&amp;cert_fp)) =3D=3D 0)</span><br><span>             {</span><br><span>  =
               break;</span><br><span>             }</span><br><span>diff -=
-git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>in=
dex 2892199..f579c61 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</=
span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -158,7 +158=
,7 @@</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT WRAP AD: =
%s&quot;, format_hex(BPTR(dst), BLEN(dst), 0, &amp;gc));</span><br><span> <=
/span><br><span>     /* Buffer overflow check */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!buf_safe(dst, BLEN(src) + TLS_CRYPT_BLO=
CK_SIZE + TLS_CRYPT_TAG_SIZE))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!buf_safe(dst, BLENZ(src) + TLS_CRYPT_BLOCK_SIZE + TLS_C=
RYPT_TAG_SIZE))</span><br><span>     {</span><br><span>         msg(D_CRYPT=
_ERRORS,</span><br><span>             &quot;TLS-CRYPT WRAP: buffer size err=
or, &quot;</span><br><span>@@ -231,7 +231,7 @@</span><br><span>         int=
 outlen =3D 0;</span><br><span> </span><br><span>         /* Buffer overflo=
w check (should never fail) */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (!buf_safe(dst, BLEN(src) - TLS_CRYPT_OFF_CT + TLS_CRYP=
T_BLOCK_SIZE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!buf_safe(dst, BLENZ(src) - TLS_CRYPT_OFF_CT + TLS_CRYPT_BLOCK_SIZE)=
)</span><br><span>         {</span><br><span>             CRYPT_ERROR(&quot=
;potential buffer overflow&quot;);</span><br><span>         }</span><br><sp=
an>@@ -241,7 +241,7 @@</span><br><span>             CRYPT_ERROR(&quot;ciphe=
r reset failed&quot;);</span><br><span>         }</span><br><span>         =
if (!cipher_ctx_update(ctx-&gt;cipher, BPTR(dst), &amp;outlen, BPTR(src) + =
TLS_CRYPT_OFF_CT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                           BLEN(src) - TLS_CRYPT_OFF_CT))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                               (int)(=
BLENZ(src) - TLS_CRYPT_OFF_CT)))</span><br><span>         {</span><br><span=
>             CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><spa=
n>         }</span><br><span>@@ -376,8 +376,8 @@</span><br><span>         m=
sg(M_WARN, &quot;ERROR: could not write tag&quot;);</span><br><span>       =
  return false;</span><br><span>     }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    uint16_t net_len =3D htons(sizeof(src_key-&gt;keys) + =
BLEN(src_metadata) + TLS_CRYPT_V2_TAG_SIZE</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                             + sizeof(uint16_t));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint16_t net_len =3D=
 htons((uint16_t)(sizeof(src_key-&gt;keys) + BLENZ(src_metadata)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
          + TLS_CRYPT_V2_TAG_SIZE + sizeof(uint16_t)));</span><br><span>   =
  hmac_ctx_t *hmac_ctx =3D server_key-&gt;hmac;</span><br><span>     hmac_c=
tx_reset(hmac_ctx);</span><br><span>     hmac_ctx_update(hmac_ctx, (void *)=
&amp;net_len, sizeof(net_len));</span><br><span>@@ -391,7 +391,7 @@</span><=
br><span>     ASSERT(cipher_ctx_reset(cipher_ctx, tag));</span><br><span> <=
/span><br><span>     /* Overflow check (OpenSSL requires an extra block in =
the dst buffer) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (buf_forward_capacity(&amp;work) &lt; (sizeof(src_key-&gt;keys) + BLEN(=
src_metadata) + sizeof(net_len)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (buf_forward_capacity(&amp;work) &lt; (sizeof(src_key-&g=
t;keys) + BLENZ(src_metadata) + sizeof(net_len)</span><br><span>           =
                             + cipher_ctx_block_size(cipher_ctx)))</span><b=
r><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: could not =
crypt: insufficient space in dst&quot;);</span><br><span>@@ -439,7 +439,7 @=
@</span><br><span>     uint16_t net_len =3D 0;</span><br><span>     const u=
int8_t *tag =3D BPTR(&amp;wrapped_client_key);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (BLEN(&amp;wrapped_client=
_key) &lt; sizeof(net_len))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (BLENZ(&amp;wrapped_client_key) &lt; sizeof(net_len))</span>=
<br><span>     {</span><br><span>         CRYPT_ERROR(&quot;failed to read =
length&quot;);</span><br><span>     }</span><br><span>@@ -589,7 +589,7 @@</=
span><br><span>     struct buffer wrapped_client_key =3D *buf;</span><br><s=
pan>     uint16_t net_len =3D 0;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (BLEN(&amp;wrapped_client_key) &lt; siz=
eof(net_len))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (BLENZ(&amp;wrapped_client_key) &lt; sizeof(net_len))</span><br><span>    =
 {</span><br><span>         msg(D_TLS_ERRORS, &quot;Can not read tls-crypt-=
v2 client key length&quot;);</span><br><span>         return false;</span><=
br><span>diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c</span><br><sp=
an>index a6a6e93..d8f49c6 100644</span><br><span>--- a/src/openvpn/vlan.c</=
span><br><span>+++ b/src/openvpn/vlan.c</span><br><span>@@ -85,7 +85,7 @@</=
span><br><span>     uint16_t vid;</span><br><span> </span><br><span>     /*=
 assume untagged frame */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (BLEN(buf) &lt; sizeof(*ethhdr))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(*ethhdr))</span><br>=
<span>     {</span><br><span>         goto drop;</span><br><span>     }</sp=
an><br><span>@@ -109,7 +109,7 @@</span><br><span>     }</span><br><span> </=
span><br><span>     /* tagged frame */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (BLEN(buf) &lt; sizeof(*vlanhdr))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(*vlanh=
dr))</span><br><span>     {</span><br><span>         goto drop;</span><br><=
span>     }</span><br><span>@@ -184,7 +184,7 @@</span><br><span>     const =
struct openvpn_ethhdr *ethhdr;</span><br><span>     struct openvpn_8021qhdr=
 *vlanhdr;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (BLEN(buf) &lt; sizeof(*ethhdr))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (BLENZ(buf) &lt; sizeof(*ethhdr))</span><=
br><span>     {</span><br><span>         goto drop;</span><br><span>     }<=
/span><br><span>@@ -197,7 +197,7 @@</span><br><span>          */</span><br>=
<span> </span><br><span>         /* Frame too small for header type? */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt=
; sizeof(*vlanhdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (BLENZ(buf) &lt; sizeof(*vlanhdr))</span><br><span>         {</s=
pan><br><span>             goto drop;</span><br><span>         }</span><br>=
<span>@@ -263,7 +263,7 @@</span><br><span>     const struct openvpn_8021qhd=
r *vlanhdr;</span><br><span>     uint16_t vid;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (BLEN(buf) &lt; sizeof(st=
ruct openvpn_8021qhdr))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (BLENZ(buf) &lt; sizeof(struct openvpn_8021qhdr))</span><br><spa=
n>     {</span><br><span>         /* frame too small to be VLAN-tagged */</=
span><br><span>         return false;</span><br><span>diff --git a/tests/un=
it_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</sp=
an><br><span>index 0cfb918..ab53131 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvpn=
/test_buffer.c</span><br><span>@@ -49,9 +49,9 @@</span><br><span> #define t=
eststr2  &quot;two&quot;</span><br><span> #define teststr3  &quot;three&quo=
t;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define assert_buf_equals_str(buf, str)       \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    assert_int_equal(BLEN(buf), strlen(str)); \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(=
BPTR(buf), str, BLEN(buf));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define assert_buf_equals_str(buf, str)        \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(BLENZ(buf), strle=
n(str)); \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_memory_equal(BPTR(buf), str, BLENZ(buf));</span><br><span> </span><br><sp=
an> static void</span><br><span> test_buffer_printf_catrunc(void **state)</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/=
unit_tests/openvpn/test_crypto.c</span><br><span>index 12ddaba..de8f9fe 100=
644</span><br><span>--- a/tests/unit_tests/openvpn/test_crypto.c</span><br>=
<span>+++ b/tests/unit_tests/openvpn/test_crypto.c</span><br><span>@@ -70,7=
 +70,7 @@</span><br><span> </span><br><span>     assert_true(crypto_pem_dec=
ode(&quot;TESTKEYNAME&quot;, &amp;dec_buf, &amp;pem_buf));</span><br><span>=
     assert_int_equal(BLEN(&amp;src_buf), BLEN(&amp;dec_buf));</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;=
src_buf), BPTR(&amp;dec_buf), BLEN(&amp;src_buf));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;src_buf), =
BPTR(&amp;dec_buf), BLENZ(&amp;src_buf));</span><br><span> </span><br><span=
>     gc_free(&amp;gc);</span><br><span> }</span><br><span>diff --git a/tes=
ts/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</spa=
n><br><span>index b08e4c2..5bf1562 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_pkt.c</span><br><span>@@ -549,7 +549,7 @@</span><br><span>     struct buf=
fer buf2 =3D</span><br><span>         tls_reset_standalone(&amp;tas.tls_wra=
p, &amp;tas, &amp;client_id, &amp;server_id, header, false);</span><br><spa=
n>     assert_int_equal(BLEN(&amp;buf), BLEN(&amp;buf2));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;buf),=
 BPTR(&amp;buf2), BLEN(&amp;buf));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), BPTR(&amp;buf2), BLE=
NZ(&amp;buf));</span><br><span> </span><br><span>     free_tls_pre_decrypt_=
state(&amp;state);</span><br><span>     free_buf(&amp;tas.workbuf);</span><=
br><span>@@ -586,7 +586,7 @@</span><br><span>     struct buffer buf2 =3D tl=
s_reset_standalone(&amp;tas_client.tls_wrap, &amp;tas_client, &amp;client_i=
d,</span><br><span>                                               &amp;serv=
er_id, header, false);</span><br><span>     assert_int_equal(BLEN(&amp;buf)=
, BLEN(&amp;buf2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  assert_memory_equal(BPTR(&amp;buf), BPTR(&amp;buf2), BLEN(&amp;buf));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal=
(BPTR(&amp;buf), BPTR(&amp;buf2), BLENZ(&amp;buf));</span><br><span> </span=
><br><span>     free_tls_pre_decrypt_state(&amp;state);</span><br><span> </=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/uni=
t_tests/openvpn/test_ssl.c</span><br><span>index 7bf5396..cfa30a8 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++=
 b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -344,9 +344,9 @@<=
/span><br><span> </span><br><span>         /* copy source to input buf */</=
span><br><span>         buf =3D work;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        buf_p =3D buf_write_alloc(&amp;buf, BLEN(&amp;src))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_p =3D =
buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>         ASSERT=
(buf_p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        memcp=
y(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src)=
);</span><br><span> </span><br><span>         /* initialize work buffer wit=
h buf.headroom bytes of prepend capacity */</span><br><span>         ASSERT=
(buf_init(&amp;encrypt_workspace, frame.buf.headroom));</span><br><span>@@ =
-390,9 +390,9 @@</span><br><span> </span><br><span>     /* copy source to i=
nput buf */</span><br><span>     buf =3D work;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    buf_p =3D buf_write_alloc(&amp;buf, BLEN(&amp;=
src));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_p =3D=
 buf_write_alloc(&amp;buf, BLENZ(&amp;src));</span><br><span>     ASSERT(bu=
f_p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    memcpy(buf_p=
, BPTR(&amp;src), BLEN(&amp;src));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memcpy(buf_p, BPTR(&amp;src), BLENZ(&amp;src));</span><b=
r><span> </span><br><span>     ASSERT(buf_init(&amp;encrypt_workspace, fram=
e.buf.headroom));</span><br><span>     openvpn_encrypt(&amp;buf, encrypt_wo=
rkspace, co);</span><br><span>@@ -688,9 +688,9 @@</span><br><span> </span><=
br><span>     /* copy source to input buf */</span><br><span>     buf =3D w=
ork;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_p =3D buf=
_write_alloc(&amp;buf, BLEN(&amp;src));</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    buf_p =3D buf_write_alloc(&amp;buf, BLENZ(&amp;src)=
);</span><br><span>     ASSERT(buf_p);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    memcpy(buf_p, BPTR(&amp;src), BLEN(&amp;src));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(buf_p, BPTR(&amp=
;src), BLENZ(&amp;src));</span><br><span> </span><br><span>     /* initiali=
ze work buffer with buf.headroom bytes of prepend capacity */</span><br><sp=
an>     ASSERT(buf_init(&amp;encrypt_workspace, frame.buf.headroom));</span=
><br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/u=
nit_tests/openvpn/test_tls_crypt.c</span><br><span>index e2b2e38..596f0e0 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>=
@@ -225,7 +225,7 @@</span><br><span>     assert_true(BLEN(&amp;ctx-&gt;sour=
ce) &lt; BLEN(&amp;ctx-&gt;ciphertext));</span><br><span>     assert_true(t=
ls_crypt_unwrap(&amp;ctx-&gt;ciphertext, &amp;ctx-&gt;unwrapped, &amp;ctx-&=
gt;co));</span><br><span>     assert_int_equal(BLEN(&amp;ctx-&gt;source), B=
LEN(&amp;ctx-&gt;unwrapped));</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    assert_memory_equal(BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-&g=
t;unwrapped), BLEN(&amp;ctx-&gt;source));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;ctx-&gt;source), BP=
TR(&amp;ctx-&gt;unwrapped), BLENZ(&amp;ctx-&gt;source));</span><br><span> }=
</span><br><span> </span><br><span> </span><br><span>@@ -259,7 +259,7 @@</s=
pan><br><span>                                       0x33, 0x7b, 0x9c, 0xfb=
, 0x56, 0xe1, 0xf1, 0x3a, 0x87, 0x0e,</span><br><span>                     =
                  0x66, 0x47, 0xdf, 0xa1, 0x95, 0xc9, 0x2c, 0x17, 0xa0, 0x1=
5,</span><br><span>                                       0xba, 0x49, 0x67,=
 0xa1, 0x1d, 0x55, 0xea, 0x1a, 0x06, 0xa7 };</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;rctx-&gt;work), ex=
pected_ciphertext, buf_len(&amp;rctx-&gt;work));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;rctx-&gt;wor=
k), expected_ciphertext, BLENZ(&amp;rctx-&gt;work));</span><br><span>     t=
ls_wrap_free(&amp;session.tls_wrap_reneg);</span><br><span> </span><br><spa=
n>     /* Use previous tls-crypt key as 0x00, with xor we should have the s=
ame key</span><br><span>@@ -273,7 +273,7 @@</span><br><span>     tls_crypt_=
wrap(&amp;ctx-&gt;source, &amp;rctx-&gt;work, &amp;rctx-&gt;opt);</span><br=
><span>     assert_int_equal(buf_len(&amp;ctx-&gt;source) + 40, buf_len(&am=
p;rctx-&gt;work));</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    assert_memory_equal(BPTR(&amp;rctx-&gt;work), expected_c=
iphertext, buf_len(&amp;rctx-&gt;work));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;rctx-&gt;work), expe=
cted_ciphertext, BLENZ(&amp;rctx-&gt;work));</span><br><span>     tls_wrap_=
free(&amp;session.tls_wrap_reneg);</span><br><span> </span><br><span>     /=
* XOR should not force a different key */</span><br><span>@@ -289,7 +289,7 =
@@</span><br><span> </span><br><span>     /* Skip packet id */</span><br><s=
pan>     buf_advance(&amp;rctx-&gt;work, 8);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    assert_memory_not_equal(BPTR(&amp;rctx-&gt;work)=
, expected_ciphertext, buf_len(&amp;rctx-&gt;work));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_not_equal(BPTR(&amp;rct=
x-&gt;work), expected_ciphertext, BLENZ(&amp;rctx-&gt;work));</span><br><sp=
an>     tls_wrap_free(&amp;session.tls_wrap_reneg);</span><br><span> </span=
><br><span> </span><br><span>@@ -312,7 +312,7 @@</span><br><span>     asser=
t_true(BLEN(&amp;ctx-&gt;source) &lt; BLEN(&amp;ctx-&gt;ciphertext));</span=
><br><span>     assert_true(tls_crypt_unwrap(&amp;ctx-&gt;ciphertext, &amp;=
ctx-&gt;unwrapped, &amp;ctx-&gt;co));</span><br><span>     assert_int_equal=
(BLEN(&amp;ctx-&gt;source), BLEN(&amp;ctx-&gt;unwrapped));</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;ctx-=
&gt;source), BPTR(&amp;ctx-&gt;unwrapped), BLEN(&amp;ctx-&gt;source));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(=
BPTR(&amp;ctx-&gt;source), BPTR(&amp;ctx-&gt;unwrapped), BLENZ(&amp;ctx-&gt=
;source));</span><br><span> }</span><br><span> </span><br><span> /**</span>=
<br><span>@@ -333,7 +333,7 @@</span><br><span>     assert_true(BLEN(&amp;ct=
x-&gt;source) &lt; BLEN(&amp;ctx-&gt;ciphertext));</span><br><span>     ass=
ert_true(tls_crypt_unwrap(&amp;ctx-&gt;ciphertext, &amp;ctx-&gt;unwrapped, =
&amp;ctx-&gt;co));</span><br><span>     assert_int_equal(BLEN(&amp;ctx-&gt;=
source), BLEN(&amp;ctx-&gt;unwrapped));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    assert_memory_equal(BPTR(&amp;ctx-&gt;source), BPTR(&=
amp;ctx-&gt;unwrapped), BLEN(&amp;ctx-&gt;source));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;ctx-&gt=
;source), BPTR(&amp;ctx-&gt;unwrapped), BLENZ(&amp;ctx-&gt;source));</span>=
<br><span> }</span><br><span> </span><br><span> /**</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1132?usp=3Demail">change 1132</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1132?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4e75ba1dbc6d9a0f75298bc900f=
713b67e60d096 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1132 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ozKj0+MCPHc=--

