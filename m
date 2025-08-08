MIME-Version: 1.0
References: <CAOh3LPMK7T2gduJXrKaQRDvPZdjCiBJtCqXWiFT0xj4TAaj2LA@...278...>
 <CAOh3LPOuZ2U+4sSndv0nKmR604VTeFF1ZJzU2nMgMeX+TVGQkg@...278...>
In-Reply-To: <CAOh3LPOuZ2U+4sSndv0nKmR604VTeFF1ZJzU2nMgMeX+TVGQkg@...278...>
From: Jon Chiappetta <root@...2904...>
Date: Fri, 8 Aug 2025 14:49:54 -0400
Message-ID: <CAOh3LPMdF0i5h9sSfvNUTpwLaVA3OexuB6u0SA5igap2SONi3w@...278...>
Content-Type: multipart/alternative; boundary="000000000000d7201d063bdf0a69"
Subject: Re: [Openvpn-devel] Bulk mode - Feature request - Patch diff
 [updated]
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--000000000000d7201d063bdf0a69
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[one last self reply]

I did some work today to fix a potential issue with my read tun method
where it may not read from the file descriptor upon reconnection. I believe
it should be fixed now just in case anyone is still interested in a change
like this.

Example POC Pull Request Link:
https://github.com/OpenVPN/openvpn/pull/814/files

$ cat 0001-bulk-mode.patch
From 28d43ff49984f2d3c787fa791d0a7a548ac80fad Mon Sep 17 00:00:00 2001
From: Jon Chiappetta <root@...2904...>
Date: Wed, 6 Aug 2025 16:33:18 -0400
Subject: [PATCH] bulk mode

---
 src/openvpn/forward.c | 225 ++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/forward.h |   4 +
 src/openvpn/init.c    |  57 +++++++++++
 src/openvpn/mtu.c     |  10 +-
 src/openvpn/mtu.h     |  13 +++
 src/openvpn/multi.c   |   7 +-
 src/openvpn/openvpn.h |  10 ++
 src/openvpn/options.c |   8 ++
 src/openvpn/options.h |   3 +
 9 files changed, 325 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 75ca9d5c..b9d96482 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -46,6 +46,9 @@

 #include "mstats.h"

+#include <sys/select.h>
+#include <sys/time.h>
+
 counter_type link_read_bytes_global;  /* GLOBAL */
 counter_type link_write_bytes_global; /* GLOBAL */

@@ -78,6 +81,34 @@ show_wait_status(struct context *c)

 #endif /* ifdef ENABLE_DEBUG */

+bool check_bulk_mode(struct context *c)
+{
+    if ((c->c2.frame.bulk_size > 0) && (c->c1.tuntap !=3D NULL) &&
(c->c2.buffers !=3D NULL))
+    {
+        return true;
+    }
+    return false;
+}
+
+void xfer_io(struct context *c, struct context *b)
+{
+    //dmsg(M_INFO, "BULK MODE xfer_io c [%d] [%p] [%p] [%d] [%d] [%d]",
c->c2.frame.bulk_size, c->c1.tuntap, c->c2.buffers, BLEN(&c->c2.buf),
BLEN(&c->c2.to_tun), BLEN(&c->c2.to_link));
+    //dmsg(M_INFO, "BULK MODE xfer_io b [%d] [%p] [%p] [%d] [%d] [%d]",
b->c2.frame.bulk_size, b->c1.tuntap, b->c2.buffers, BLEN(&b->c2.buf),
BLEN(&b->c2.to_tun), BLEN(&b->c2.to_link));
+    int plen =3D 0;
+    if (check_bulk_mode(b))
+    {
+        int leng =3D (b->c2.buffers->bufs_indx + 1);
+        for (int x =3D 0; x < leng; ++x)
+        {
+            plen =3D BLEN(&b->c2.bufs[x]);
+            if (plen < 1) { c->c2.bufs[x].len =3D 0; }
+            else { c->c2.bufs[x] =3D b->c2.bufs[x]; }
+        }
+        c->c2.buffers->bufs_indx =3D b->c2.buffers->bufs_indx;
+        b->c2.buffers->bufs_indx =3D -1;
+    }
+}
+
 static void
 check_tls_errors_co(struct context *c)
 {
@@ -605,6 +636,21 @@ buffer_turnover(const uint8_t *orig_buf, struct buffer
*dest_stub, struct buffer
     }
 }

+uint8_t *buff_prepsize(uint8_t *buff, int *size)
+{
+    buff[0] =3D ((*size >> 8) & 0xff);
+    buff[1] =3D ((*size >> 0) & 0xff);
+    buff +=3D 2;
+    return buff;
+}
+
+uint8_t *buff_postsize(uint8_t *buff, int *size)
+{
+    *size =3D ((buff[0] << 8) + (buff[1] << 0));
+    buff +=3D 2;
+    return buff;
+}
+
 /*
  * Compress, fragment, encrypt and HMAC-sign an outgoing packet.
  * Input: c->c2.buf
@@ -1031,6 +1077,7 @@ process_incoming_link_part1(struct context *c, struct
link_socket_info *lsi, boo
         fprintf(stderr, "R");
     }
 #endif
+
     msg(D_LINK_RW, "%s READ [%d] from %s: %s", proto2ascii(lsi->proto,
lsi->af, true),
         BLEN(&c->c2.buf), print_link_socket_actual(&c->c2.from, &gc),
PROTO_DUMP(&c->c2.buf, &gc));

@@ -1211,6 +1258,26 @@ process_incoming_link_part2(struct context *c,
struct link_socket_info *lsi,
     }
 }

+void process_incoming_link_part3(struct context *c)
+{
+    int leng =3D BLEN(&c->c2.buf);
+    if (leng > 0)
+    {
+        if (check_bulk_mode(c))
+        {
+            c->c2.buffers->send_tun_max.offset =3D TUN_BAT_OFF;
+            c->c2.buffers->send_tun_max.len =3D leng;
+            bcopy(BPTR(&c->c2.buf), BPTR(&c->c2.buffers->send_tun_max),
leng);
+            c->c2.to_tun.offset +=3D 2;
+            c->c2.buf.offset +=3D 2;
+        }
+    }
+    else
+    {
+        buf_reset(&c->c2.to_tun);
+    }
+}
+
 static void
 process_incoming_link(struct context *c, struct link_socket *sock)
 {
@@ -1221,6 +1288,7 @@ process_incoming_link(struct context *c, struct
link_socket *sock)

     process_incoming_link_part1(c, lsi, false);
     process_incoming_link_part2(c, lsi, orig_buf);
+    process_incoming_link_part3(c);

     perf_pop();
 }
@@ -1321,7 +1389,7 @@ process_incoming_dco(struct context *c)
  */

 void
-read_incoming_tun(struct context *c)
+read_incoming_tun_part2(struct context *c)
 {
     /*
      * Setup for read() call on TUN/TAP device.
@@ -1382,6 +1450,54 @@ read_incoming_tun(struct context *c)
     perf_pop();
 }

+void read_incoming_tun_part3(struct context *c)
+{
+    fd_set rfds;
+    struct timeval timo;
+    if (check_bulk_mode(c))
+    {
+        int plen =3D 0, pidx =3D -1;
+        int fdno =3D c->c1.tuntap->fd;
+        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
+        {
+            int leng =3D plen, indx =3D (pidx + 1);
+            if (indx >=3D TUN_BAT_MIN) { break; }
+            if (leng < 1)
+            {
+                FD_ZERO(&rfds);
+                FD_SET(fdno, &rfds);
+                timo.tv_sec =3D 0;
+                timo.tv_usec =3D 0;
+                select(fdno+1, &rfds, NULL, NULL, &timo);
+                if (FD_ISSET(fdno, &rfds))
+                {
+                    read_incoming_tun_part2(c);
+                    plen =3D BLEN(&c->c2.buf);
+                } else { break; }
+            }
+            leng =3D plen;
+            if (leng > 0)
+            {
+                c->c2.buffers->read_tun_bufs[indx].offset =3D TUN_BAT_OFF;
+                c->c2.buffers->read_tun_bufs[indx].len =3D leng;
+                bcopy(BPTR(&c->c2.buf),
BPTR(&c->c2.buffers->read_tun_bufs[indx]), leng);
+                c->c2.bufs[indx] =3D c->c2.buffers->read_tun_bufs[indx];
+                pidx =3D indx;
+            } else { break; }
+            plen =3D 0;
+        }
+        c->c2.buffers->bufs_indx =3D pidx;
+    }
+}
+
+void read_incoming_tun(struct context *c)
+{
+    if (c->c2.frame.bulk_size <=3D 0) {
+        read_incoming_tun_part2(c);
+    }
+    read_incoming_tun_part3(c);
+}
+
 /**
  * Drops UDP packets which OS decided to route via tun.
  *
@@ -1469,7 +1585,7 @@ drop_if_recursive_routing(struct context *c, struct
buffer *buf)
  */

 void
-process_incoming_tun(struct context *c, struct link_socket *out_sock)
+process_incoming_tun_part2(struct context *c, struct link_socket *out_sock)
 {
     struct gc_arena gc =3D gc_new();

@@ -1488,7 +1604,7 @@ process_incoming_tun(struct context *c, struct
link_socket *out_sock)
 #endif

     /* Show packet content */
-    dmsg(D_TUN_RW, "TUN READ [%d]", BLEN(&c->c2.buf));
+    dmsg(D_TUN_RW, "TUN READ [%d] [%d]", BLEN(&c->c2.buf),
c->c2.frame.buf.payload_size);

     if (c->c2.buf.len > 0)
     {
@@ -1512,7 +1628,9 @@ process_incoming_tun(struct context *c, struct
link_socket *out_sock)
     }
     if (c->c2.buf.len > 0)
     {
+        if ((c->c2.buffers =3D=3D NULL) || (c->c2.buffers->flag_ciph !=3D =
-2)) {
         encrypt_sign(c, true);
+        }
     }
     else
     {
@@ -1522,6 +1640,65 @@ process_incoming_tun(struct context *c, struct
link_socket *out_sock)
     gc_free(&gc);
 }

+void process_incoming_tun_part3(struct context *c, struct link_socket
*out_sock)
+{
+    if (c->c2.buf.len > 0)
+    {
+        if (check_bulk_mode(c))
+        {
+            c->c2.buffers->flag_ciph =3D -2;
+            c->c2.buffers->read_tun_max.offset =3D TUN_BAT_OFF;
+            c->c2.buffers->read_tun_max.len =3D 0;
+            uint8_t *temp =3D BPTR(&c->c2.buffers->read_tun_max);
+            int plen =3D 0, fdno =3D c->c1.tuntap->fd;
+            int maxl =3D 0, leng =3D (c->c2.buffers->bufs_indx + 1);
+            if ((fdno > 0) && (leng > 0))
+            {
+                for (int x =3D 0; x < leng; ++x)
+                {
+                    c->c2.buf =3D c->c2.bufs[x];
+                    process_incoming_tun_part2(c, out_sock);
+                    if (BLEN(&c->c2.buf) < 1)
+                    {
+                        c->c2.bufs[x].len =3D 0;
+                    }
+                }
+                for (int x =3D 0; x < leng; ++x)
+                {
+                    plen =3D c->c2.bufs[x].len;
+                    if (plen > 0)
+                    {
+                        temp =3D buff_prepsize(temp, &plen);
+                        bcopy(BPTR(&c->c2.bufs[x]), temp, plen);
+                        temp +=3D plen; maxl +=3D (plen + 2);
+                    }
+                }
+                if (maxl > 0)
+                {
+                    c->c2.buffers->read_tun_max.offset =3D TUN_BAT_OFF;
+                    c->c2.buffers->read_tun_max.len =3D maxl;
+                    c->c2.buf =3D c->c2.buffers->read_tun_max;
+                    encrypt_sign(c, true);
+                }
+            }
+            c->c2.buffers->bufs_indx =3D -1;
+            c->c2.buffers->flag_ciph =3D -1;
+        }
+    }
+    else
+    {
+        buf_reset(&c->c2.to_link);
+    }
+}
+
+void process_incoming_tun(struct context *c, struct link_socket *out_sock)
+{
+    if (c->c2.frame.bulk_size <=3D 0) {
+        process_incoming_tun_part2(c, out_sock);
+    }
+    process_incoming_tun_part3(c, out_sock);
+}
+
 /**
  * Forges a IPv6 ICMP packet with a no route to host error code from the
  * IPv6 packet in buf and sends it directly back to the client via the tun
@@ -1748,7 +1925,7 @@ process_outgoing_link(struct context *c, struct
link_socket *sock)

     perf_push(PERF_PROC_OUT_LINK);

-    if (c->c2.to_link.len > 0 && c->c2.to_link.len <=3D
c->c2.frame.buf.payload_size)
+    if (c->c2.to_link.len > 0 && (c->c2.to_link.len <=3D
c->c2.frame.buf.payload_size || c->c2.frame.bulk_size > 0))
     {
         /*
          * Setup for call to send/sendto which will send
@@ -1793,6 +1970,7 @@ process_outgoing_link(struct context *c, struct
link_socket *sock)
                 fprintf(stderr, "W");
             }
 #endif
+
             msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
                 proto2ascii(sock->info.proto, sock->info.af, true),
BLEN(&c->c2.to_link),
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
PROTO_DUMP(&c->c2.to_link, &gc));
@@ -1892,7 +2070,7 @@ process_outgoing_link(struct context *c, struct
link_socket *sock)
  */

 void
-process_outgoing_tun(struct context *c, struct link_socket *in_sock)
+process_outgoing_tun_part2(struct context *c, struct link_socket *in_sock)
 {
     /*
      * Set up for write() call to TUN/TAP
@@ -1912,7 +2090,7 @@ process_outgoing_tun(struct context *c, struct
link_socket *in_sock)
     process_ip_header(c, PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER |
PIPV4_CLIENT_NAT | PIP_OUTGOING,
                       &c->c2.to_tun, in_sock);

-    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size)
+    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size ||
c->c2.frame.bulk_size > 0)
     {
         /*
          * Write to TUN/TAP device.
@@ -1925,7 +2103,8 @@ process_outgoing_tun(struct context *c, struct
link_socket *in_sock)
             fprintf(stderr, "w");
         }
 #endif
-        dmsg(D_TUN_RW, "TUN WRITE [%d]", BLEN(&c->c2.to_tun));
+
+        dmsg(D_TUN_RW, "TUN WRITE [%d] [%d]", BLEN(&c->c2.to_tun),
c->c2.frame.buf.payload_size);

 #ifdef PACKET_TRUNCATION_CHECK
         ipv4_packet_size_verify(BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun),
TUNNEL_TYPE(c->c1.tuntap),
@@ -1981,6 +2160,38 @@ process_outgoing_tun(struct context *c, struct
link_socket *in_sock)
     perf_pop();
 }

+void process_outgoing_tun_part3(struct context *c, struct link_socket
*in_sock)
+{
+    if (check_bulk_mode(c))
+    {
+        int maxl =3D 0, plen =3D 0;
+        int leng =3D BLEN(&c->c2.buffers->send_tun_max);
+        uint8_t *temp =3D BPTR(&c->c2.buffers->send_tun_max);
+        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
+        {
+            temp =3D buff_postsize(temp, &plen);
+            if ((leng > 0) && (plen > 0) && ((maxl + plen) < leng))
+            {
+                c->c2.to_tun =3D c->c2.buffers->to_tun_max;
+                c->c2.to_tun.offset =3D TUN_BAT_OFF;
+                c->c2.to_tun.len =3D plen;
+                bcopy(temp, BPTR(&c->c2.to_tun), plen);
+                temp +=3D plen; maxl +=3D (plen + 2);
+                process_outgoing_tun_part2(c, in_sock);
+            } else { break; }
+        }
+    }
+    buf_reset(&c->c2.to_tun);
+}
+
+void process_outgoing_tun(struct context *c, struct link_socket *in_sock)
+{
+    if (c->c2.frame.bulk_size <=3D 0) {
+        process_outgoing_tun_part2(c, in_sock);
+    }
+    process_outgoing_tun_part3(c, in_sock);
+}
+
 void
 pre_select(struct context *c)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index d5641491..9fda1583 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -79,6 +79,8 @@ void pre_select(struct context *c);

 void process_io(struct context *c, struct link_socket *sock);

+void xfer_io(struct context *c, struct context *b);
+

 /**********************************************************************/
 /**
@@ -196,6 +198,8 @@ bool process_incoming_link_part1(struct context *c,
struct link_socket_info *lsi
 void process_incoming_link_part2(struct context *c, struct
link_socket_info *lsi,
                                  const uint8_t *orig_buf);

+void process_incoming_link_part3(struct context *c);
+
 /**
  * Transfers \c float_sa data extracted from an incoming DCO
  * PEER_FLOAT_NTF to \c out_osaddr for later processing.
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 40ae2c8c..bbdbad46 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2971,6 +2971,10 @@ frame_finalize_options(struct context *c, const
struct options *o)
     tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
 #endif

+    if (frame->bulk_size > 0) {
+        payload_size =3D frame->tun_mtu;
+    }
+
     frame->buf.payload_size =3D payload_size;
     frame->buf.headroom =3D headroom;
     frame->buf.tailroom =3D tailroom;
@@ -3473,6 +3477,9 @@ do_init_frame_tls(struct context *c)
     if (c->c2.tls_multi)
     {
         tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
+        if (c->c2.frame.bulk_size > 0) {
+            c->c2.tls_multi->opt.frame.buf.payload_size =3D
c->c2.frame.tun_mtu;
+        }
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=3D
c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control
Channel MTU parms");

@@ -3536,6 +3543,14 @@ do_init_frame(struct context *c)
         c->c2.frame.extra_tun +=3D c->options.ce.tun_mtu_extra;
     }

+    /*
+     * Adjust bulk size based on the --bulk-mode parameter.
+     */
+    if (c->options.ce.bulk_mode)
+    {
+        c->c2.frame.bulk_size =3D c->options.ce.tun_mtu;
+    }
+
     /*
      * Fill in the blanks in the frame parameters structure,
      * make sure values are rational, etc.
@@ -3676,9 +3691,41 @@ init_context_buffers(const struct frame *frame)

     size_t buf_size =3D BUF_SIZE(frame);

+    if (frame->bulk_size > 0) {
+        size_t off_size =3D (frame->buf.headroom + TUN_BAT_OFF +
frame->buf.tailroom);
+        buf_size =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, off_size);
+    }
+
+    dmsg(M_INFO, "MEM NEW [%ld] [%d+%d+%d]", buf_size,
frame->buf.headroom, frame->buf.payload_size, frame->buf.tailroom);
+
     b->read_link_buf =3D alloc_buf(buf_size);
     b->read_tun_buf =3D alloc_buf(buf_size);

+    if (frame->bulk_size > 0) {
+        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
+        {
+            size_t part_size =3D BUF_SIZE(frame);
+            b->read_tun_bufs[x] =3D alloc_buf(part_size);
+            b->read_tun_bufs[x].offset =3D TUN_BAT_OFF;
+            b->read_tun_bufs[x].len =3D 0;
+        }
+
+        b->read_tun_max =3D alloc_buf(buf_size);
+        b->read_tun_max.offset =3D TUN_BAT_OFF;
+        b->read_tun_max.len =3D 0;
+
+        b->send_tun_max =3D alloc_buf(buf_size);
+        b->send_tun_max.offset =3D TUN_BAT_OFF;
+        b->send_tun_max.len =3D 0;
+
+        b->to_tun_max =3D alloc_buf(buf_size);
+        b->to_tun_max.offset =3D TUN_BAT_OFF;
+        b->to_tun_max.len =3D 0;
+    }
+
+    b->bufs_indx =3D -1;
+    b->flag_ciph =3D -1;
+
     b->aux_buf =3D alloc_buf(buf_size);

     b->encrypt_buf =3D alloc_buf(buf_size);
@@ -3701,6 +3748,16 @@ free_context_buffers(struct context_buffers *b)
         free_buf(&b->read_tun_buf);
         free_buf(&b->aux_buf);

+        if (b->to_tun_max.data) {
+            free_buf(&b->to_tun_max);
+            free_buf(&b->send_tun_max);
+            free_buf(&b->read_tun_max);
+            for (int x =3D 0; x < TUN_BAT_MAX; ++x)
+            {
+                free_buf(&b->read_tun_bufs[x]);
+            }
+        }
+
 #ifdef USE_COMP
         free_buf(&b->compress_buf);
         free_buf(&b->decompress_buf);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index a419e32d..7e35c837 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -41,9 +41,15 @@ void
 alloc_buf_sock_tun(struct buffer *buf, const struct frame *frame)
 {
     /* allocate buffer for overlapped I/O */
-    *buf =3D alloc_buf(BUF_SIZE(frame));
+    size_t alen =3D BUF_SIZE(frame);
+    size_t blen =3D frame->buf.payload_size;
+    if (frame->bulk_size > 0) {
+        alen =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_OFF);
+        blen =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_NOP);
+    }
+    *buf =3D alloc_buf(alen);
     ASSERT(buf_init(buf, frame->buf.headroom));
-    buf->len =3D frame->buf.payload_size;
+    buf->len =3D blen;
     ASSERT(buf_safe(buf, 0));
 }

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 925ef0bf..eb799fb3 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -58,6 +58,14 @@
  */
 #define TUN_MTU_MIN 100

+/*
+ * Bulk mode static define values.
+ */
+#define TUN_BAT_MIN        6
+#define TUN_BAT_MAX        9
+#define TUN_BAT_OFF        256
+#define TUN_BAT_NOP        0
+
 /*
  * Default MTU of network over which tunnel data will pass by TCP/UDP.
  */
@@ -152,6 +160,10 @@ struct frame
                             *   which defaults to 0 for tun and 32
                             *   (\c TAP_MTU_EXTRA_DEFAULT) for tap.
                             *   */
+
+    int bulk_size;              /**< Signal to the init frame function
+                                 *   to allow for bulk mode TCP transfers.
+                                 *   */
 };

 /* Forward declarations, to prevent includes */
@@ -171,6 +183,7 @@ struct options;
  * larger than the headroom.
  */
 #define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size +
(f)->buf.tailroom)
+#define BAT_SIZE(a, b, c) ((a * b) + c)

 /*
  * Function prototypes.
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e1ce32ab..9e089703 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3414,6 +3414,7 @@ multi_process_incoming_link(struct multi_context *m,
struct multi_instance *inst
                 }

                 process_incoming_link_part2(c, lsi, orig_buf);
+                process_incoming_link_part3(c);
             }
             perf_pop();

@@ -3558,9 +3559,7 @@ multi_process_incoming_tun(struct multi_context *m,
const unsigned int mpp_flags
         const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid =3D 0;

-#ifdef MULTI_DEBUG_EVENT_LOOP
-        printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
-#endif
+        msg(D_MULTI_DEBUG, "TUN -> TCP/UDP [%d]", BLEN(&m->top.c2.buf));

         if (m->pending)
         {
@@ -3610,6 +3609,8 @@ multi_process_incoming_tun(struct multi_context *m,
const unsigned int mpp_flags
                         {
                             /* transfer packet pointer from top-level
context buffer to instance */
                             c->c2.buf =3D m->top.c2.buf;
+                            /* todo determine if to call this
(multi_process_incoming_tun) for each bulk item read? */
+                            xfer_io(c, &m->top);
                         }
                         else
                         {
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index cd99cd40..21fa8967 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -112,6 +112,14 @@ struct context_buffers
      */
     struct buffer read_link_buf;
     struct buffer read_tun_buf;
+
+    struct buffer read_tun_bufs[TUN_BAT_MAX];
+    struct buffer read_tun_max;
+    struct buffer send_tun_max;
+    struct buffer to_tun_max;
+
+    int bufs_indx;
+    int flag_ciph;
 };

 /*
@@ -376,6 +384,8 @@ struct context_2
     struct buffer to_tun;
     struct buffer to_link;

+    struct buffer bufs[TUN_BAT_MAX];
+
     /* should we print R|W|r|w to console on packet transfers? */
     bool log_rw;

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c54032d8..041d17d0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -304,6 +304,7 @@ static const char usage_message[] =3D
     "                  'maybe' -- Use per-route hints\n"
     "                  'yes'   -- Always DF (Don't Fragment)\n"
     "--mtu-test      : Empirically measure and report MTU.\n"
+    "--bulk-mode     : Use bulk TUN/TCP reads/writes.\n"
 #ifdef ENABLE_FRAGMENT
     "--fragment max  : Enable internal datagram fragmentation so that no
UDP\n"
     "                  datagrams are sent which are larger than max
bytes.\n"
@@ -3005,6 +3006,9 @@ options_postprocess_mutate_ce(struct options *o,
struct connection_entry *ce)
             ce->tun_mtu_extra_defined =3D true;
             ce->tun_mtu_extra =3D TAP_MTU_EXTRA_DEFAULT;
         }
+        if (ce->proto !=3D PROTO_TCP && ce->proto !=3D PROTO_TCP_SERVER &&
ce->proto !=3D PROTO_TCP_CLIENT) {
+            ce->bulk_mode =3D false;
+        }
     }

     /*
@@ -9926,6 +9930,10 @@ add_option(struct options *options, char *p[], bool
is_inline, const char *file,
             goto err;
         }
     }
+    else if (streq(p[0], "bulk-mode"))
+    {
+        options->ce.bulk_mode =3D true;
+    }
     else
     {
         int i;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 38e67c8d..d1b0586d 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -174,6 +174,9 @@ struct connection_entry

     /* Allow only client that support resending the wrapped client key */
     bool tls_crypt_v2_force_cookie;
+
+    /* Bulk mode allows for multiple tun reads + larger tcp writes */
+    bool bulk_mode;
 };

 struct remote_entry
--
2.39.5 (Apple Git-154)







On Fri, Aug 8, 2025 at 10:23=E2=80=AFAM Jon Chiappetta <root@...2904...> wr=
ote:

> [replying to my own update thread]
>
> I pushed an update to the PR with the following small changes:
>
> - rebased to the latest master commit
> - increased the data buffer size to be slightly bigger than the read
> buffer size
> - copied two more buf resets so that the additional bulk forward functions
> match the present logic checks
>
> Example updated pull request:
> https://github.com/OpenVPN/openvpn/pull/814/files
>
> $ cat 0001-bulk-mode.patch
> From 2ce0b023d105e7ecc289a414cd26f7ebc8bcbcaf Mon Sep 17 00:00:00 2001
> From: Jon Chiappetta <root@...2904...>
> Date: Wed, 6 Aug 2025 16:33:18 -0400
> Subject: [PATCH] bulk mode
>
> ---
>  src/openvpn/forward.c | 228 ++++++++++++++++++++++++++++++++++++++++--
>  src/openvpn/forward.h |   4 +
>  src/openvpn/init.c    |  57 +++++++++++
>  src/openvpn/mtu.c     |  10 +-
>  src/openvpn/mtu.h     |  13 +++
>  src/openvpn/multi.c   |   7 +-
>  src/openvpn/openvpn.h |  10 ++
>  src/openvpn/options.c |   8 ++
>  src/openvpn/options.h |   3 +
>  9 files changed, 328 insertions(+), 12 deletions(-)
>
> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
> index 75ca9d5c..0af983e9 100644
> --- a/src/openvpn/forward.c
> +++ b/src/openvpn/forward.c
> @@ -46,6 +46,9 @@
>
>  #include "mstats.h"
>
> +#include <sys/select.h>
> +#include <sys/time.h>
> +
>  counter_type link_read_bytes_global;  /* GLOBAL */
>  counter_type link_write_bytes_global; /* GLOBAL */
>
> @@ -78,6 +81,32 @@ show_wait_status(struct context *c)
>
>  #endif /* ifdef ENABLE_DEBUG */
>
> +bool check_bulk_mode(struct context *c)
> +{
> +    if ((c->c2.frame.bulk_size > 0) && (c->c1.tuntap !=3D NULL) &&
> (c->c2.buffers !=3D NULL))
> +    {
> +        return true;
> +    }
> +    return false;
> +}
> +
> +void xfer_io(struct context *c, struct context *b)
> +{
> +    int plen =3D 0;
> +    if (check_bulk_mode(b))
> +    {
> +        int leng =3D (b->c2.buffers->bufs_indx + 1);
> +        for (int x =3D 0; x < leng; ++x)
> +        {
> +            plen =3D BLEN(&b->c2.bufs[x]);
> +            if (plen < 1) { c->c2.bufs[x].len =3D 0; }
> +            else { c->c2.bufs[x] =3D b->c2.bufs[x]; }
> +        }
> +        c->c2.buffers->bufs_indx =3D b->c2.buffers->bufs_indx;
> +        b->c2.buffers->bufs_indx =3D -1;
> +    }
> +}
> +
>  static void
>  check_tls_errors_co(struct context *c)
>  {
> @@ -605,6 +634,21 @@ buffer_turnover(const uint8_t *orig_buf, struct
> buffer *dest_stub, struct buffer
>      }
>  }
>
> +uint8_t *buff_prepsize(uint8_t *buff, int *size)
> +{
> +    buff[0] =3D ((*size >> 8) & 0xff);
> +    buff[1] =3D ((*size >> 0) & 0xff);
> +    buff +=3D 2;
> +    return buff;
> +}
> +
> +uint8_t *buff_postsize(uint8_t *buff, int *size)
> +{
> +    *size =3D ((buff[0] << 8) + (buff[1] << 0));
> +    buff +=3D 2;
> +    return buff;
> +}
> +
>  /*
>   * Compress, fragment, encrypt and HMAC-sign an outgoing packet.
>   * Input: c->c2.buf
> @@ -1031,6 +1075,7 @@ process_incoming_link_part1(struct context *c,
> struct link_socket_info *lsi, boo
>          fprintf(stderr, "R");
>      }
>  #endif
> +
>      msg(D_LINK_RW, "%s READ [%d] from %s: %s", proto2ascii(lsi->proto,
> lsi->af, true),
>          BLEN(&c->c2.buf), print_link_socket_actual(&c->c2.from, &gc),
> PROTO_DUMP(&c->c2.buf, &gc));
>
> @@ -1211,6 +1256,27 @@ process_incoming_link_part2(struct context *c,
> struct link_socket_info *lsi,
>      }
>  }
>
> +void process_incoming_link_part3(struct context *c)
> +{
> +    int leng =3D BLEN(&c->c2.buf);
> +    if (leng > 0)
> +    {
> +        if (check_bulk_mode(c))
> +        {
> +            c->c2.buffers->send_tun_max.offset =3D TUN_BAT_OFF;
> +            c->c2.buffers->send_tun_max.len =3D leng;
> +            bcopy(BPTR(&c->c2.buf), BPTR(&c->c2.buffers->send_tun_max),
> leng);
> +            //dmsg(M_INFO, "FWD BAT LINK 0 [%d] [%d] [%d] [%d] [%d]",
> BLEN(&c->c2.buf), BLEN(&c->c2.to_tun), BLEN(&c->c2.buffers->read_link_buf=
),
> BLEN(&c->c2.buffers->read_link_buf), BLEN(&c->c2.buffers->send_tun_max));
> +            c->c2.to_tun.offset +=3D 2;
> +            c->c2.buf.offset +=3D 2;
> +        }
> +    }
> +    else
> +    {
> +        buf_reset(&c->c2.to_tun);
> +    }
> +}
> +
>  static void
>  process_incoming_link(struct context *c, struct link_socket *sock)
>  {
> @@ -1221,6 +1287,7 @@ process_incoming_link(struct context *c, struct
> link_socket *sock)
>
>      process_incoming_link_part1(c, lsi, false);
>      process_incoming_link_part2(c, lsi, orig_buf);
> +    process_incoming_link_part3(c);
>
>      perf_pop();
>  }
> @@ -1321,7 +1388,7 @@ process_incoming_dco(struct context *c)
>   */
>
>  void
> -read_incoming_tun(struct context *c)
> +read_incoming_tun_part2(struct context *c)
>  {
>      /*
>       * Setup for read() call on TUN/TAP device.
> @@ -1382,6 +1449,55 @@ read_incoming_tun(struct context *c)
>      perf_pop();
>  }
>
> +void read_incoming_tun_part3(struct context *c)
> +{
> +    fd_set rfds;
> +    struct timeval timo;
> +    if (check_bulk_mode(c))
> +    {
> +        int plen =3D 0;
> +        int fdno =3D c->c1.tuntap->fd;
> +        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
> +        {
> +            int leng =3D plen;
> +            int indx =3D (c->c2.buffers->bufs_indx + 1);
> +            if (indx >=3D TUN_BAT_MIN) { break; }
> +            if (leng < 1)
> +            {
> +                FD_ZERO(&rfds);
> +                FD_SET(fdno, &rfds);
> +                timo.tv_sec =3D 0;
> +                timo.tv_usec =3D 0;
> +                select(fdno+1, &rfds, NULL, NULL, &timo);
> +                if (FD_ISSET(fdno, &rfds))
> +                {
> +                    read_incoming_tun_part2(c);
> +                    plen =3D BLEN(&c->c2.buf);
> +                } else { break; }
> +            }
> +            //dmsg(M_INFO, "FWD BAT READ 0 [%d] [%d] [%d] [%d] [%d]",
> c->c2.buffers->bufs_indx + 1, fdno, BLEN(&c->c2.buf),
> BLEN(&c->c2.buffers->read_tun_buf), BLEN(&c->c2.buffers->read_tun_max));
> +            leng =3D plen;
> +            if (leng > 0)
> +            {
> +                c->c2.buffers->read_tun_bufs[indx].offset =3D TUN_BAT_OF=
F;
> +                c->c2.buffers->read_tun_bufs[indx].len =3D leng;
> +                bcopy(BPTR(&c->c2.buf),
> BPTR(&c->c2.buffers->read_tun_bufs[indx]), leng);
> +                c->c2.bufs[indx] =3D c->c2.buffers->read_tun_bufs[indx];
> +                c->c2.buffers->bufs_indx =3D indx;
> +            } else { break; }
> +            plen =3D 0;
> +        }
> +    }
> +}
> +
> +void read_incoming_tun(struct context *c)
> +{
> +    if (c->c2.frame.bulk_size <=3D 0) {
> +        read_incoming_tun_part2(c);
> +    }
> +    read_incoming_tun_part3(c);
> +}
> +
>  /**
>   * Drops UDP packets which OS decided to route via tun.
>   *
> @@ -1469,7 +1585,7 @@ drop_if_recursive_routing(struct context *c, struct
> buffer *buf)
>   */
>
>  void
> -process_incoming_tun(struct context *c, struct link_socket *out_sock)
> +process_incoming_tun_part2(struct context *c, struct link_socket
> *out_sock)
>  {
>      struct gc_arena gc =3D gc_new();
>
> @@ -1488,7 +1604,7 @@ process_incoming_tun(struct context *c, struct
> link_socket *out_sock)
>  #endif
>
>      /* Show packet content */
> -    dmsg(D_TUN_RW, "TUN READ [%d]", BLEN(&c->c2.buf));
> +    dmsg(D_TUN_RW, "TUN READ [%d] [%d]", BLEN(&c->c2.buf),
> c->c2.frame.buf.payload_size);
>
>      if (c->c2.buf.len > 0)
>      {
> @@ -1512,7 +1628,9 @@ process_incoming_tun(struct context *c, struct
> link_socket *out_sock)
>      }
>      if (c->c2.buf.len > 0)
>      {
> +        if ((c->c2.buffers =3D=3D NULL) || (c->c2.buffers->flag_ciph !=
=3D -2)) {
>          encrypt_sign(c, true);
> +        }
>      }
>      else
>      {
> @@ -1522,6 +1640,67 @@ process_incoming_tun(struct context *c, struct
> link_socket *out_sock)
>      gc_free(&gc);
>  }
>
> +void process_incoming_tun_part3(struct context *c, struct link_socket
> *out_sock)
> +{
> +    if (c->c2.buf.len > 0)
> +    {
> +        if (check_bulk_mode(c))
> +        {
> +            c->c2.buffers->flag_ciph =3D -2;
> +            c->c2.buffers->read_tun_max.offset =3D TUN_BAT_OFF;
> +            c->c2.buffers->read_tun_max.len =3D 0;
> +            uint8_t *temp =3D BPTR(&c->c2.buffers->read_tun_max);
> +            int plen =3D 0, fdno =3D c->c1.tuntap->fd;
> +            int maxl =3D 0, leng =3D (c->c2.buffers->bufs_indx + 1);
> +            if ((fdno > 0) && (leng > 0))
> +            {
> +                for (int x =3D 0; x < leng; ++x)
> +                {
> +                    c->c2.buf =3D c->c2.bufs[x];
> +                    //dmsg(M_INFO, "FWD BAT INPT 0 [%d] [%d] [%d] [%d]
> [%d]", x, fdno, BLEN(&c->c2.buf), BLEN(&c->c2.buffers->read_tun_buf),
> BLEN(&c->c2.bufs[x]));
> +                    process_incoming_tun_part2(c, out_sock);
> +                    if (BLEN(&c->c2.buf) < 1)
> +                    {
> +                        c->c2.bufs[x].len =3D 0;
> +                    }
> +                }
> +                for (int x =3D 0; x < leng; ++x)
> +                {
> +                    plen =3D c->c2.bufs[x].len;
> +                    if (plen > 0)
> +                    {
> +                        temp =3D buff_prepsize(temp, &plen);
> +                        bcopy(BPTR(&c->c2.bufs[x]), temp, plen);
> +                        temp +=3D plen; maxl +=3D (plen + 2);
> +                    }
> +                }
> +                if (maxl > 0)
> +                {
> +                    c->c2.buffers->read_tun_max.offset =3D TUN_BAT_OFF;
> +                    c->c2.buffers->read_tun_max.len =3D maxl;
> +                    c->c2.buf =3D c->c2.buffers->read_tun_max;
> +                    //dmsg(M_INFO, "FWD BAT INPT 1 [%d] [%d] [%d] [%d]
> [%d]", maxl, fdno, BLEN(&c->c2.buf), BLEN(&c->c2.buffers->read_tun_buf),
> BLEN(&c->c2.buffers->read_tun_max));
> +                    encrypt_sign(c, true);
> +                }
> +            }
> +            c->c2.buffers->bufs_indx =3D -1;
> +            c->c2.buffers->flag_ciph =3D -1;
> +        }
> +    }
> +    else
> +    {
> +        buf_reset(&c->c2.to_link);
> +    }
> +}
> +
> +void process_incoming_tun(struct context *c, struct link_socket *out_soc=
k)
> +{
> +    if (c->c2.frame.bulk_size <=3D 0) {
> +        process_incoming_tun_part2(c, out_sock);
> +    }
> +    process_incoming_tun_part3(c, out_sock);
> +}
> +
>  /**
>   * Forges a IPv6 ICMP packet with a no route to host error code from the
>   * IPv6 packet in buf and sends it directly back to the client via the t=
un
> @@ -1748,7 +1927,7 @@ process_outgoing_link(struct context *c, struct
> link_socket *sock)
>
>      perf_push(PERF_PROC_OUT_LINK);
>
> -    if (c->c2.to_link.len > 0 && c->c2.to_link.len <=3D
> c->c2.frame.buf.payload_size)
> +    if (c->c2.to_link.len > 0 && (c->c2.to_link.len <=3D
> c->c2.frame.buf.payload_size || c->c2.frame.bulk_size > 0))
>      {
>          /*
>           * Setup for call to send/sendto which will send
> @@ -1793,6 +1972,7 @@ process_outgoing_link(struct context *c, struct
> link_socket *sock)
>                  fprintf(stderr, "W");
>              }
>  #endif
> +
>              msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
>                  proto2ascii(sock->info.proto, sock->info.af, true),
> BLEN(&c->c2.to_link),
>                  print_link_socket_actual(c->c2.to_link_addr, &gc),
> PROTO_DUMP(&c->c2.to_link, &gc));
> @@ -1892,7 +2072,7 @@ process_outgoing_link(struct context *c, struct
> link_socket *sock)
>   */
>
>  void
> -process_outgoing_tun(struct context *c, struct link_socket *in_sock)
> +process_outgoing_tun_part2(struct context *c, struct link_socket *in_soc=
k)
>  {
>      /*
>       * Set up for write() call to TUN/TAP
> @@ -1912,7 +2092,7 @@ process_outgoing_tun(struct context *c, struct
> link_socket *in_sock)
>      process_ip_header(c, PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER |
> PIPV4_CLIENT_NAT | PIP_OUTGOING,
>                        &c->c2.to_tun, in_sock);
>
> -    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size)
> +    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size ||
> c->c2.frame.bulk_size > 0)
>      {
>          /*
>           * Write to TUN/TAP device.
> @@ -1925,7 +2105,8 @@ process_outgoing_tun(struct context *c, struct
> link_socket *in_sock)
>              fprintf(stderr, "w");
>          }
>  #endif
> -        dmsg(D_TUN_RW, "TUN WRITE [%d]", BLEN(&c->c2.to_tun));
> +
> +        dmsg(D_TUN_RW, "TUN WRITE [%d] [%d]", BLEN(&c->c2.to_tun),
> c->c2.frame.buf.payload_size);
>
>  #ifdef PACKET_TRUNCATION_CHECK
>          ipv4_packet_size_verify(BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun),
> TUNNEL_TYPE(c->c1.tuntap),
> @@ -1981,6 +2162,39 @@ process_outgoing_tun(struct context *c, struct
> link_socket *in_sock)
>      perf_pop();
>  }
>
> +void process_outgoing_tun_part3(struct context *c, struct link_socket
> *in_sock)
> +{
> +    if (check_bulk_mode(c))
> +    {
> +        int maxl =3D 0, plen =3D 0;
> +        int leng =3D BLEN(&c->c2.buffers->send_tun_max);
> +        uint8_t *temp =3D BPTR(&c->c2.buffers->send_tun_max);
> +        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
> +        {
> +            temp =3D buff_postsize(temp, &plen);
> +            if ((leng > 0) && (plen > 0) && ((maxl + plen) < leng))
> +            {
> +                c->c2.to_tun =3D c->c2.buffers->to_tun_max;
> +                c->c2.to_tun.offset =3D TUN_BAT_OFF;
> +                c->c2.to_tun.len =3D plen;
> +                bcopy(temp, BPTR(&c->c2.to_tun), plen);
> +                temp +=3D plen; maxl +=3D (plen + 2);
> +                //dmsg(M_INFO, "FWD BAT OUTP 1 [%d] [%d] [%d] [%d]", x,
> BLEN(&c->c2.buf), BLEN(&c->c2.to_tun), BLEN(&c->c2.buffers->read_link_buf=
));
> +                process_outgoing_tun_part2(c, in_sock);
> +            } else { break; }
> +        }
> +    }
> +    buf_reset(&c->c2.to_tun);
> +}
> +
> +void process_outgoing_tun(struct context *c, struct link_socket *in_sock)
> +{
> +    if (c->c2.frame.bulk_size <=3D 0) {
> +        process_outgoing_tun_part2(c, in_sock);
> +    }
> +    process_outgoing_tun_part3(c, in_sock);
> +}
> +
>  void
>  pre_select(struct context *c)
>  {
> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
> index d5641491..9fda1583 100644
> --- a/src/openvpn/forward.h
> +++ b/src/openvpn/forward.h
> @@ -79,6 +79,8 @@ void pre_select(struct context *c);
>
>  void process_io(struct context *c, struct link_socket *sock);
>
> +void xfer_io(struct context *c, struct context *b);
> +
>
>  /**********************************************************************/
>  /**
> @@ -196,6 +198,8 @@ bool process_incoming_link_part1(struct context *c,
> struct link_socket_info *lsi
>  void process_incoming_link_part2(struct context *c, struct
> link_socket_info *lsi,
>                                   const uint8_t *orig_buf);
>
> +void process_incoming_link_part3(struct context *c);
> +
>  /**
>   * Transfers \c float_sa data extracted from an incoming DCO
>   * PEER_FLOAT_NTF to \c out_osaddr for later processing.
> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
> index 40ae2c8c..bbdbad46 100644
> --- a/src/openvpn/init.c
> +++ b/src/openvpn/init.c
> @@ -2971,6 +2971,10 @@ frame_finalize_options(struct context *c, const
> struct options *o)
>      tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
>  #endif
>
> +    if (frame->bulk_size > 0) {
> +        payload_size =3D frame->tun_mtu;
> +    }
> +
>      frame->buf.payload_size =3D payload_size;
>      frame->buf.headroom =3D headroom;
>      frame->buf.tailroom =3D tailroom;
> @@ -3473,6 +3477,9 @@ do_init_frame_tls(struct context *c)
>      if (c->c2.tls_multi)
>      {
>          tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
> +        if (c->c2.frame.bulk_size > 0) {
> +            c->c2.tls_multi->opt.frame.buf.payload_size =3D
> c->c2.frame.tun_mtu;
> +        }
>          ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=3D
> c->c2.frame.buf.payload_size);
>          frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control
> Channel MTU parms");
>
> @@ -3536,6 +3543,14 @@ do_init_frame(struct context *c)
>          c->c2.frame.extra_tun +=3D c->options.ce.tun_mtu_extra;
>      }
>
> +    /*
> +     * Adjust bulk size based on the --bulk-mode parameter.
> +     */
> +    if (c->options.ce.bulk_mode)
> +    {
> +        c->c2.frame.bulk_size =3D c->options.ce.tun_mtu;
> +    }
> +
>      /*
>       * Fill in the blanks in the frame parameters structure,
>       * make sure values are rational, etc.
> @@ -3676,9 +3691,41 @@ init_context_buffers(const struct frame *frame)
>
>      size_t buf_size =3D BUF_SIZE(frame);
>
> +    if (frame->bulk_size > 0) {
> +        size_t off_size =3D (frame->buf.headroom + TUN_BAT_OFF +
> frame->buf.tailroom);
> +        buf_size =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, off_size);
> +    }
> +
> +    dmsg(M_INFO, "MEM NEW [%ld] [%d+%d+%d]", buf_size,
> frame->buf.headroom, frame->buf.payload_size, frame->buf.tailroom);
> +
>      b->read_link_buf =3D alloc_buf(buf_size);
>      b->read_tun_buf =3D alloc_buf(buf_size);
>
> +    if (frame->bulk_size > 0) {
> +        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
> +        {
> +            size_t part_size =3D BUF_SIZE(frame);
> +            b->read_tun_bufs[x] =3D alloc_buf(part_size);
> +            b->read_tun_bufs[x].offset =3D TUN_BAT_OFF;
> +            b->read_tun_bufs[x].len =3D 0;
> +        }
> +
> +        b->read_tun_max =3D alloc_buf(buf_size);
> +        b->read_tun_max.offset =3D TUN_BAT_OFF;
> +        b->read_tun_max.len =3D 0;
> +
> +        b->send_tun_max =3D alloc_buf(buf_size);
> +        b->send_tun_max.offset =3D TUN_BAT_OFF;
> +        b->send_tun_max.len =3D 0;
> +
> +        b->to_tun_max =3D alloc_buf(buf_size);
> +        b->to_tun_max.offset =3D TUN_BAT_OFF;
> +        b->to_tun_max.len =3D 0;
> +    }
> +
> +    b->bufs_indx =3D -1;
> +    b->flag_ciph =3D -1;
> +
>      b->aux_buf =3D alloc_buf(buf_size);
>
>      b->encrypt_buf =3D alloc_buf(buf_size);
> @@ -3701,6 +3748,16 @@ free_context_buffers(struct context_buffers *b)
>          free_buf(&b->read_tun_buf);
>          free_buf(&b->aux_buf);
>
> +        if (b->to_tun_max.data) {
> +            free_buf(&b->to_tun_max);
> +            free_buf(&b->send_tun_max);
> +            free_buf(&b->read_tun_max);
> +            for (int x =3D 0; x < TUN_BAT_MAX; ++x)
> +            {
> +                free_buf(&b->read_tun_bufs[x]);
> +            }
> +        }
> +
>  #ifdef USE_COMP
>          free_buf(&b->compress_buf);
>          free_buf(&b->decompress_buf);
> diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
> index a419e32d..7e35c837 100644
> --- a/src/openvpn/mtu.c
> +++ b/src/openvpn/mtu.c
> @@ -41,9 +41,15 @@ void
>  alloc_buf_sock_tun(struct buffer *buf, const struct frame *frame)
>  {
>      /* allocate buffer for overlapped I/O */
> -    *buf =3D alloc_buf(BUF_SIZE(frame));
> +    size_t alen =3D BUF_SIZE(frame);
> +    size_t blen =3D frame->buf.payload_size;
> +    if (frame->bulk_size > 0) {
> +        alen =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_OFF);
> +        blen =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_NOP);
> +    }
> +    *buf =3D alloc_buf(alen);
>      ASSERT(buf_init(buf, frame->buf.headroom));
> -    buf->len =3D frame->buf.payload_size;
> +    buf->len =3D blen;
>      ASSERT(buf_safe(buf, 0));
>  }
>
> diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
> index 925ef0bf..eb799fb3 100644
> --- a/src/openvpn/mtu.h
> +++ b/src/openvpn/mtu.h
> @@ -58,6 +58,14 @@
>   */
>  #define TUN_MTU_MIN 100
>
> +/*
> + * Bulk mode static define values.
> + */
> +#define TUN_BAT_MIN        6
> +#define TUN_BAT_MAX        9
> +#define TUN_BAT_OFF        256
> +#define TUN_BAT_NOP        0
> +
>  /*
>   * Default MTU of network over which tunnel data will pass by TCP/UDP.
>   */
> @@ -152,6 +160,10 @@ struct frame
>                              *   which defaults to 0 for tun and 32
>                              *   (\c TAP_MTU_EXTRA_DEFAULT) for tap.
>                              *   */
> +
> +    int bulk_size;              /**< Signal to the init frame function
> +                                 *   to allow for bulk mode TCP transfer=
s.
> +                                 *   */
>  };
>
>  /* Forward declarations, to prevent includes */
> @@ -171,6 +183,7 @@ struct options;
>   * larger than the headroom.
>   */
>  #define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size +
> (f)->buf.tailroom)
> +#define BAT_SIZE(a, b, c) ((a * b) + c)
>
>  /*
>   * Function prototypes.
> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
> index e1ce32ab..9e089703 100644
> --- a/src/openvpn/multi.c
> +++ b/src/openvpn/multi.c
> @@ -3414,6 +3414,7 @@ multi_process_incoming_link(struct multi_context *m,
> struct multi_instance *inst
>                  }
>
>                  process_incoming_link_part2(c, lsi, orig_buf);
> +                process_incoming_link_part3(c);
>              }
>              perf_pop();
>
> @@ -3558,9 +3559,7 @@ multi_process_incoming_tun(struct multi_context *m,
> const unsigned int mpp_flags
>          const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
>          int16_t vid =3D 0;
>
> -#ifdef MULTI_DEBUG_EVENT_LOOP
> -        printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
> -#endif
> +        msg(D_MULTI_DEBUG, "TUN -> TCP/UDP [%d]", BLEN(&m->top.c2.buf));
>
>          if (m->pending)
>          {
> @@ -3610,6 +3609,8 @@ multi_process_incoming_tun(struct multi_context *m,
> const unsigned int mpp_flags
>                          {
>                              /* transfer packet pointer from top-level
> context buffer to instance */
>                              c->c2.buf =3D m->top.c2.buf;
> +                            /* todo determine if to call this
> (multi_process_incoming_tun) for each bulk item read? */
> +                            xfer_io(c, &m->top);
>                          }
>                          else
>                          {
> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
> index cd99cd40..21fa8967 100644
> --- a/src/openvpn/openvpn.h
> +++ b/src/openvpn/openvpn.h
> @@ -112,6 +112,14 @@ struct context_buffers
>       */
>      struct buffer read_link_buf;
>      struct buffer read_tun_buf;
> +
> +    struct buffer read_tun_bufs[TUN_BAT_MAX];
> +    struct buffer read_tun_max;
> +    struct buffer send_tun_max;
> +    struct buffer to_tun_max;
> +
> +    int bufs_indx;
> +    int flag_ciph;
>  };
>
>  /*
> @@ -376,6 +384,8 @@ struct context_2
>      struct buffer to_tun;
>      struct buffer to_link;
>
> +    struct buffer bufs[TUN_BAT_MAX];
> +
>      /* should we print R|W|r|w to console on packet transfers? */
>      bool log_rw;
>
> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
> index c54032d8..041d17d0 100644
> --- a/src/openvpn/options.c
> +++ b/src/openvpn/options.c
> @@ -304,6 +304,7 @@ static const char usage_message[] =3D
>      "                  'maybe' -- Use per-route hints\n"
>      "                  'yes'   -- Always DF (Don't Fragment)\n"
>      "--mtu-test      : Empirically measure and report MTU.\n"
> +    "--bulk-mode     : Use bulk TUN/TCP reads/writes.\n"
>  #ifdef ENABLE_FRAGMENT
>      "--fragment max  : Enable internal datagram fragmentation so that no
> UDP\n"
>      "                  datagrams are sent which are larger than max
> bytes.\n"
> @@ -3005,6 +3006,9 @@ options_postprocess_mutate_ce(struct options *o,
> struct connection_entry *ce)
>              ce->tun_mtu_extra_defined =3D true;
>              ce->tun_mtu_extra =3D TAP_MTU_EXTRA_DEFAULT;
>          }
> +        if (ce->proto !=3D PROTO_TCP && ce->proto !=3D PROTO_TCP_SERVER =
&&
> ce->proto !=3D PROTO_TCP_CLIENT) {
> +            ce->bulk_mode =3D false;
> +        }
>      }
>
>      /*
> @@ -9926,6 +9930,10 @@ add_option(struct options *options, char *p[], bool
> is_inline, const char *file,
>              goto err;
>          }
>      }
> +    else if (streq(p[0], "bulk-mode"))
> +    {
> +        options->ce.bulk_mode =3D true;
> +    }
>      else
>      {
>          int i;
> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
> index 38e67c8d..d1b0586d 100644
> --- a/src/openvpn/options.h
> +++ b/src/openvpn/options.h
> @@ -174,6 +174,9 @@ struct connection_entry
>
>      /* Allow only client that support resending the wrapped client key */
>      bool tls_crypt_v2_force_cookie;
> +
> +    /* Bulk mode allows for multiple tun reads + larger tcp writes */
> +    bool bulk_mode;
>  };
>
>  struct remote_entry
> --
> 2.39.5 (Apple Git-154)
>
>
>
>
> On Thu, Aug 7, 2025 at 2:29=E2=80=AFPM Jon Chiappetta <root@...2904...> w=
rote:
>
>> Thanks to Gert's help on this, I was able to finally configure and
>> compile and run and test the bulk mode changes against the latest git
>> source code to ensure everything still works correctly.
>>
>> I also fixed up some other issues like properly freeing the extra buffer
>> allocations and removing the unneeded batched data prefixes and converti=
ng
>> a remaining while loop to a max limited for loop and properly resetting =
the
>> outgoing tun buffer pointer at the end of the write method when finished.
>>
>> Thanks,
>> Jon C
>>
>> Example updated pull request:
>> https://github.com/OpenVPN/openvpn/pull/814/files
>>
>> git formatted diff patch:
>>
>> From 985e88a9af26a39554f113f37ee18032a2f41c3e Mon Sep 17 00:00:00 2001
>> From: Jon Chiappetta <root@...2904...>
>> Date: Wed, 6 Aug 2025 16:33:18 -0400
>> Subject: [PATCH] bulk mode
>>
>> ---
>>  src/openvpn/forward.c | 217 ++++++++++++++++++++++++++++++++++++++++--
>>  src/openvpn/forward.h |   4 +
>>  src/openvpn/init.c    |  56 +++++++++++
>>  src/openvpn/mtu.c     |  10 +-
>>  src/openvpn/mtu.h     |  13 +++
>>  src/openvpn/multi.c   |   7 +-
>>  src/openvpn/openvpn.h |  10 ++
>>  src/openvpn/options.c |   8 ++
>>  src/openvpn/options.h |   3 +
>>  9 files changed, 316 insertions(+), 12 deletions(-)
>>
>> diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
>> index 75ca9d5c..d9a98607 100644
>> --- a/src/openvpn/forward.c
>> +++ b/src/openvpn/forward.c
>> @@ -46,6 +46,9 @@
>>
>>  #include "mstats.h"
>>
>> +#include <sys/select.h>
>> +#include <sys/time.h>
>> +
>>  counter_type link_read_bytes_global;  /* GLOBAL */
>>  counter_type link_write_bytes_global; /* GLOBAL */
>>
>> @@ -78,6 +81,32 @@ show_wait_status(struct context *c)
>>
>>  #endif /* ifdef ENABLE_DEBUG */
>>
>> +bool check_bulk_mode(struct context *c)
>> +{
>> +    if ((c->c2.frame.bulk_size > 0) && (c->c1.tuntap !=3D NULL) &&
>> (c->c2.buffers !=3D NULL))
>> +    {
>> +        return true;
>> +    }
>> +    return false;
>> +}
>> +
>> +void xfer_io(struct context *c, struct context *b)
>> +{
>> +    int plen =3D 0;
>> +    if (check_bulk_mode(b))
>> +    {
>> +        int leng =3D (b->c2.buffers->bufs_indx + 1);
>> +        for (int x =3D 0; x < leng; ++x)
>> +        {
>> +            plen =3D BLEN(&b->c2.bufs[x]);
>> +            if (plen < 1) { c->c2.bufs[x].len =3D 0; }
>> +            else { c->c2.bufs[x] =3D b->c2.bufs[x]; }
>> +        }
>> +        c->c2.buffers->bufs_indx =3D b->c2.buffers->bufs_indx;
>> +        b->c2.buffers->bufs_indx =3D -1;
>> +    }
>> +}
>> +
>>  static void
>>  check_tls_errors_co(struct context *c)
>>  {
>> @@ -605,6 +634,21 @@ buffer_turnover(const uint8_t *orig_buf, struct
>> buffer *dest_stub, struct buffer
>>      }
>>  }
>>
>> +uint8_t *buff_prepsize(uint8_t *buff, int *size)
>> +{
>> +    buff[0] =3D ((*size >> 8) & 0xff);
>> +    buff[1] =3D ((*size >> 0) & 0xff);
>> +    buff +=3D 2;
>> +    return buff;
>> +}
>> +
>> +uint8_t *buff_postsize(uint8_t *buff, int *size)
>> +{
>> +    *size =3D ((buff[0] << 8) + (buff[1] << 0));
>> +    buff +=3D 2;
>> +    return buff;
>> +}
>> +
>>  /*
>>   * Compress, fragment, encrypt and HMAC-sign an outgoing packet.
>>   * Input: c->c2.buf
>> @@ -1031,6 +1075,7 @@ process_incoming_link_part1(struct context *c,
>> struct link_socket_info *lsi, boo
>>          fprintf(stderr, "R");
>>      }
>>  #endif
>> +
>>      msg(D_LINK_RW, "%s READ [%d] from %s: %s", proto2ascii(lsi->proto,
>> lsi->af, true),
>>          BLEN(&c->c2.buf), print_link_socket_actual(&c->c2.from, &gc),
>> PROTO_DUMP(&c->c2.buf, &gc));
>>
>> @@ -1211,6 +1256,23 @@ process_incoming_link_part2(struct context *c,
>> struct link_socket_info *lsi,
>>      }
>>  }
>>
>> +void process_incoming_link_part3(struct context *c)
>> +{
>> +    int leng =3D BLEN(&c->c2.to_tun);
>> +    if (leng > 0)
>> +    {
>> +        if (check_bulk_mode(c))
>> +        {
>> +            c->c2.buffers->send_tun_max.offset =3D TUN_BAT_OFF;
>> +            c->c2.buffers->send_tun_max.len =3D leng;
>> +            bcopy(BPTR(&c->c2.to_tun),
>> BPTR(&c->c2.buffers->send_tun_max), leng);
>> +            //dmsg(M_INFO, "FWD BAT LINK 0 [%d] [%d] [%d] [%d] [%d]",
>> BLEN(&c->c2.buf), BLEN(&c->c2.to_tun), BLEN(&c->c2.buffers->read_link_bu=
f),
>> BLEN(&c->c2.buffers->read_link_buf), BLEN(&c->c2.buffers->send_tun_max));
>> +            c->c2.to_tun.offset +=3D 2;
>> +            c->c2.buf.offset +=3D 2;
>> +        }
>> +    }
>> +}
>> +
>>  static void
>>  process_incoming_link(struct context *c, struct link_socket *sock)
>>  {
>> @@ -1221,6 +1283,7 @@ process_incoming_link(struct context *c, struct
>> link_socket *sock)
>>
>>      process_incoming_link_part1(c, lsi, false);
>>      process_incoming_link_part2(c, lsi, orig_buf);
>> +    process_incoming_link_part3(c);
>>
>>      perf_pop();
>>  }
>> @@ -1321,7 +1384,7 @@ process_incoming_dco(struct context *c)
>>   */
>>
>>  void
>> -read_incoming_tun(struct context *c)
>> +read_incoming_tun_part2(struct context *c)
>>  {
>>      /*
>>       * Setup for read() call on TUN/TAP device.
>> @@ -1382,6 +1445,55 @@ read_incoming_tun(struct context *c)
>>      perf_pop();
>>  }
>>
>> +void read_incoming_tun_part3(struct context *c)
>> +{
>> +    fd_set rfds;
>> +    struct timeval timo;
>> +    if (check_bulk_mode(c))
>> +    {
>> +        int plen =3D 0;
>> +        int fdno =3D c->c1.tuntap->fd;
>> +        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
>> +        {
>> +            int leng =3D plen;
>> +            int indx =3D (c->c2.buffers->bufs_indx + 1);
>> +            if (indx >=3D TUN_BAT_MIN) { break; }
>> +            if (leng < 1)
>> +            {
>> +                FD_ZERO(&rfds);
>> +                FD_SET(fdno, &rfds);
>> +                timo.tv_sec =3D 0;
>> +                timo.tv_usec =3D 0;
>> +                select(fdno+1, &rfds, NULL, NULL, &timo);
>> +                if (FD_ISSET(fdno, &rfds))
>> +                {
>> +                    read_incoming_tun_part2(c);
>> +                    plen =3D BLEN(&c->c2.buf);
>> +                } else { break; }
>> +            }
>> +            //dmsg(M_INFO, "FWD BAT READ 0 [%d] [%d] [%d] [%d] [%d]",
>> c->c2.buffers->bufs_indx + 1, fdno, BLEN(&c->c2.buf),
>> BLEN(&c->c2.buffers->read_tun_buf), BLEN(&c->c2.buffers->read_tun_max));
>> +            leng =3D plen;
>> +            if (leng > 0)
>> +            {
>> +                c->c2.buffers->read_tun_bufs[indx].offset =3D TUN_BAT_O=
FF;
>> +                c->c2.buffers->read_tun_bufs[indx].len =3D leng;
>> +                bcopy(BPTR(&c->c2.buf),
>> BPTR(&c->c2.buffers->read_tun_bufs[indx]), leng);
>> +                c->c2.bufs[indx] =3D c->c2.buffers->read_tun_bufs[indx];
>> +                c->c2.buffers->bufs_indx =3D indx;
>> +            } else { break; }
>> +            plen =3D 0;
>> +        }
>> +    }
>> +}
>> +
>> +void read_incoming_tun(struct context *c)
>> +{
>> +    if (c->c2.frame.bulk_size <=3D 0) {
>> +        read_incoming_tun_part2(c);
>> +    }
>> +    read_incoming_tun_part3(c);
>> +}
>> +
>>  /**
>>   * Drops UDP packets which OS decided to route via tun.
>>   *
>> @@ -1469,7 +1581,7 @@ drop_if_recursive_routing(struct context *c, struct
>> buffer *buf)
>>   */
>>
>>  void
>> -process_incoming_tun(struct context *c, struct link_socket *out_sock)
>> +process_incoming_tun_part2(struct context *c, struct link_socket
>> *out_sock)
>>  {
>>      struct gc_arena gc =3D gc_new();
>>
>> @@ -1488,7 +1600,7 @@ process_incoming_tun(struct context *c, struct
>> link_socket *out_sock)
>>  #endif
>>
>>      /* Show packet content */
>> -    dmsg(D_TUN_RW, "TUN READ [%d]", BLEN(&c->c2.buf));
>> +    dmsg(D_TUN_RW, "TUN READ [%d] [%d]", BLEN(&c->c2.buf),
>> c->c2.frame.buf.payload_size);
>>
>>      if (c->c2.buf.len > 0)
>>      {
>> @@ -1512,7 +1624,9 @@ process_incoming_tun(struct context *c, struct
>> link_socket *out_sock)
>>      }
>>      if (c->c2.buf.len > 0)
>>      {
>> +        if ((c->c2.buffers =3D=3D NULL) || (c->c2.buffers->flag_ciph !=
=3D -2))
>> {
>>          encrypt_sign(c, true);
>> +        }
>>      }
>>      else
>>      {
>> @@ -1522,6 +1636,60 @@ process_incoming_tun(struct context *c, struct
>> link_socket *out_sock)
>>      gc_free(&gc);
>>  }
>>
>> +void process_incoming_tun_part3(struct context *c, struct link_socket
>> *out_sock)
>> +{
>> +    if (check_bulk_mode(c))
>> +    {
>> +        c->c2.buffers->flag_ciph =3D -2;
>> +        c->c2.buffers->read_tun_max.offset =3D TUN_BAT_OFF;
>> +        c->c2.buffers->read_tun_max.len =3D 0;
>> +        uint8_t *temp =3D BPTR(&c->c2.buffers->read_tun_max);
>> +        int plen =3D 0, fdno =3D c->c1.tuntap->fd;
>> +        int maxl =3D 0, leng =3D (c->c2.buffers->bufs_indx + 1);
>> +        if ((fdno > 0) && (leng > 0))
>> +        {
>> +            for (int x =3D 0; x < leng; ++x)
>> +            {
>> +                c->c2.buf =3D c->c2.bufs[x];
>> +                //dmsg(M_INFO, "FWD BAT INPT 0 [%d] [%d] [%d] [%d]
>> [%d]", x, fdno, BLEN(&c->c2.buf), BLEN(&c->c2.buffers->read_tun_buf),
>> BLEN(&c->c2.bufs[x]));
>> +                process_incoming_tun_part2(c, out_sock);
>> +                if (BLEN(&c->c2.buf) < 1)
>> +                {
>> +                    c->c2.bufs[x].len =3D 0;
>> +                }
>> +            }
>> +            for (int x =3D 0; x < leng; ++x)
>> +            {
>> +                plen =3D c->c2.bufs[x].len;
>> +                if (plen > 0)
>> +                {
>> +                    temp =3D buff_prepsize(temp, &plen);
>> +                    bcopy(BPTR(&c->c2.bufs[x]), temp, plen);
>> +                    temp +=3D plen; maxl +=3D (plen + 2);
>> +                }
>> +            }
>> +            if (maxl > 0)
>> +            {
>> +                c->c2.buffers->read_tun_max.offset =3D TUN_BAT_OFF;
>> +                c->c2.buffers->read_tun_max.len =3D maxl;
>> +                c->c2.buf =3D c->c2.buffers->read_tun_max;
>> +                //dmsg(M_INFO, "FWD BAT INPT 1 [%d] [%d] [%d] [%d]
>> [%d]", maxl, fdno, BLEN(&c->c2.buf), BLEN(&c->c2.buffers->read_tun_buf),
>> BLEN(&c->c2.buffers->read_tun_max));
>> +                encrypt_sign(c, true);
>> +            }
>> +        }
>> +        c->c2.buffers->bufs_indx =3D -1;
>> +        c->c2.buffers->flag_ciph =3D -1;
>> +    }
>> +}
>> +
>> +void process_incoming_tun(struct context *c, struct link_socket
>> *out_sock)
>> +{
>> +    if (c->c2.frame.bulk_size <=3D 0) {
>> +        process_incoming_tun_part2(c, out_sock);
>> +    }
>> +    process_incoming_tun_part3(c, out_sock);
>> +}
>> +
>>  /**
>>   * Forges a IPv6 ICMP packet with a no route to host error code from the
>>   * IPv6 packet in buf and sends it directly back to the client via the
>> tun
>> @@ -1748,7 +1916,7 @@ process_outgoing_link(struct context *c, struct
>> link_socket *sock)
>>
>>      perf_push(PERF_PROC_OUT_LINK);
>>
>> -    if (c->c2.to_link.len > 0 && c->c2.to_link.len <=3D
>> c->c2.frame.buf.payload_size)
>> +    if (c->c2.to_link.len > 0 && (c->c2.to_link.len <=3D
>> c->c2.frame.buf.payload_size || c->c2.frame.bulk_size > 0))
>>      {
>>          /*
>>           * Setup for call to send/sendto which will send
>> @@ -1793,6 +1961,7 @@ process_outgoing_link(struct context *c, struct
>> link_socket *sock)
>>                  fprintf(stderr, "W");
>>              }
>>  #endif
>> +
>>              msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
>>                  proto2ascii(sock->info.proto, sock->info.af, true),
>> BLEN(&c->c2.to_link),
>>                  print_link_socket_actual(c->c2.to_link_addr, &gc),
>> PROTO_DUMP(&c->c2.to_link, &gc));
>> @@ -1892,7 +2061,7 @@ process_outgoing_link(struct context *c, struct
>> link_socket *sock)
>>   */
>>
>>  void
>> -process_outgoing_tun(struct context *c, struct link_socket *in_sock)
>> +process_outgoing_tun_part2(struct context *c, struct link_socket
>> *in_sock)
>>  {
>>      /*
>>       * Set up for write() call to TUN/TAP
>> @@ -1912,7 +2081,7 @@ process_outgoing_tun(struct context *c, struct
>> link_socket *in_sock)
>>      process_ip_header(c, PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER |
>> PIPV4_CLIENT_NAT | PIP_OUTGOING,
>>                        &c->c2.to_tun, in_sock);
>>
>> -    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size)
>> +    if (c->c2.to_tun.len <=3D c->c2.frame.buf.payload_size ||
>> c->c2.frame.bulk_size > 0)
>>      {
>>          /*
>>           * Write to TUN/TAP device.
>> @@ -1925,7 +2094,8 @@ process_outgoing_tun(struct context *c, struct
>> link_socket *in_sock)
>>              fprintf(stderr, "w");
>>          }
>>  #endif
>> -        dmsg(D_TUN_RW, "TUN WRITE [%d]", BLEN(&c->c2.to_tun));
>> +
>> +        dmsg(D_TUN_RW, "TUN WRITE [%d] [%d]", BLEN(&c->c2.to_tun),
>> c->c2.frame.buf.payload_size);
>>
>>  #ifdef PACKET_TRUNCATION_CHECK
>>          ipv4_packet_size_verify(BPTR(&c->c2.to_tun),
>> BLEN(&c->c2.to_tun), TUNNEL_TYPE(c->c1.tuntap),
>> @@ -1981,6 +2151,39 @@ process_outgoing_tun(struct context *c, struct
>> link_socket *in_sock)
>>      perf_pop();
>>  }
>>
>> +void process_outgoing_tun_part3(struct context *c, struct link_socket
>> *in_sock)
>> +{
>> +    if (check_bulk_mode(c))
>> +    {
>> +        int maxl =3D 0, plen =3D 0;
>> +        int leng =3D BLEN(&c->c2.buffers->send_tun_max);
>> +        uint8_t *temp =3D BPTR(&c->c2.buffers->send_tun_max);
>> +        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
>> +        {
>> +            temp =3D buff_postsize(temp, &plen);
>> +            if ((leng > 0) && (plen > 0) && ((maxl + plen) < leng))
>> +            {
>> +                c->c2.to_tun =3D c->c2.buffers->to_tun_max;
>> +                c->c2.to_tun.offset =3D TUN_BAT_OFF;
>> +                c->c2.to_tun.len =3D plen;
>> +                bcopy(temp, BPTR(&c->c2.to_tun), plen);
>> +                temp +=3D plen; maxl +=3D (plen + 2);
>> +                //dmsg(M_INFO, "FWD BAT OUTP 1 [%d] [%d] [%d] [%d]", x,
>> BLEN(&c->c2.buf), BLEN(&c->c2.to_tun), BLEN(&c->c2.buffers->read_link_bu=
f));
>> +                process_outgoing_tun_part2(c, in_sock);
>> +            } else { break; }
>> +        }
>> +        buf_reset(&c->c2.to_tun);
>> +    }
>> +}
>> +
>> +void process_outgoing_tun(struct context *c, struct link_socket *in_soc=
k)
>> +{
>> +    if (c->c2.frame.bulk_size <=3D 0) {
>> +        process_outgoing_tun_part2(c, in_sock);
>> +    }
>> +    process_outgoing_tun_part3(c, in_sock);
>> +}
>> +
>>  void
>>  pre_select(struct context *c)
>>  {
>> diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
>> index d5641491..9fda1583 100644
>> --- a/src/openvpn/forward.h
>> +++ b/src/openvpn/forward.h
>> @@ -79,6 +79,8 @@ void pre_select(struct context *c);
>>
>>  void process_io(struct context *c, struct link_socket *sock);
>>
>> +void xfer_io(struct context *c, struct context *b);
>> +
>>
>>  /**********************************************************************/
>>  /**
>> @@ -196,6 +198,8 @@ bool process_incoming_link_part1(struct context *c,
>> struct link_socket_info *lsi
>>  void process_incoming_link_part2(struct context *c, struct
>> link_socket_info *lsi,
>>                                   const uint8_t *orig_buf);
>>
>> +void process_incoming_link_part3(struct context *c);
>> +
>>  /**
>>   * Transfers \c float_sa data extracted from an incoming DCO
>>   * PEER_FLOAT_NTF to \c out_osaddr for later processing.
>> diff --git a/src/openvpn/init.c b/src/openvpn/init.c
>> index 40ae2c8c..0849dfce 100644
>> --- a/src/openvpn/init.c
>> +++ b/src/openvpn/init.c
>> @@ -2971,6 +2971,10 @@ frame_finalize_options(struct context *c, const
>> struct options *o)
>>      tailroom +=3D COMP_EXTRA_BUFFER(payload_size);
>>  #endif
>>
>> +    if (frame->bulk_size > 0) {
>> +        payload_size =3D frame->tun_mtu;
>> +    }
>> +
>>      frame->buf.payload_size =3D payload_size;
>>      frame->buf.headroom =3D headroom;
>>      frame->buf.tailroom =3D tailroom;
>> @@ -3473,6 +3477,9 @@ do_init_frame_tls(struct context *c)
>>      if (c->c2.tls_multi)
>>      {
>>          tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
>> +        if (c->c2.frame.bulk_size > 0) {
>> +            c->c2.tls_multi->opt.frame.buf.payload_size =3D
>> c->c2.frame.tun_mtu;
>> +        }
>>          ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=3D
>> c->c2.frame.buf.payload_size);
>>          frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control
>> Channel MTU parms");
>>
>> @@ -3536,6 +3543,14 @@ do_init_frame(struct context *c)
>>          c->c2.frame.extra_tun +=3D c->options.ce.tun_mtu_extra;
>>      }
>>
>> +    /*
>> +     * Adjust bulk size based on the --bulk-mode parameter.
>> +     */
>> +    if (c->options.ce.bulk_mode)
>> +    {
>> +        c->c2.frame.bulk_size =3D c->options.ce.tun_mtu;
>> +    }
>> +
>>      /*
>>       * Fill in the blanks in the frame parameters structure,
>>       * make sure values are rational, etc.
>> @@ -3676,9 +3691,40 @@ init_context_buffers(const struct frame *frame)
>>
>>      size_t buf_size =3D BUF_SIZE(frame);
>>
>> +    if (frame->bulk_size > 0) {
>> +        buf_size =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu,
>> frame->buf.headroom + frame->buf.tailroom);
>> +    }
>> +
>> +    dmsg(M_INFO, "MEM NEW [%ld] [%d+%d+%d]", buf_size,
>> frame->buf.headroom, frame->buf.payload_size, frame->buf.tailroom);
>> +
>>      b->read_link_buf =3D alloc_buf(buf_size);
>>      b->read_tun_buf =3D alloc_buf(buf_size);
>>
>> +    if (frame->bulk_size > 0) {
>> +        for (int x =3D 0; x < TUN_BAT_MAX; ++x)
>> +        {
>> +            size_t part_size =3D BUF_SIZE(frame);
>> +            b->read_tun_bufs[x] =3D alloc_buf(part_size);
>> +            b->read_tun_bufs[x].offset =3D TUN_BAT_OFF;
>> +            b->read_tun_bufs[x].len =3D 0;
>> +        }
>> +
>> +        b->read_tun_max =3D alloc_buf(buf_size);
>> +        b->read_tun_max.offset =3D TUN_BAT_OFF;
>> +        b->read_tun_max.len =3D 0;
>> +
>> +        b->send_tun_max =3D alloc_buf(buf_size);
>> +        b->send_tun_max.offset =3D TUN_BAT_OFF;
>> +        b->send_tun_max.len =3D 0;
>> +
>> +        b->to_tun_max =3D alloc_buf(buf_size);
>> +        b->to_tun_max.offset =3D TUN_BAT_OFF;
>> +        b->to_tun_max.len =3D 0;
>> +    }
>> +
>> +    b->bufs_indx =3D -1;
>> +    b->flag_ciph =3D -1;
>> +
>>      b->aux_buf =3D alloc_buf(buf_size);
>>
>>      b->encrypt_buf =3D alloc_buf(buf_size);
>> @@ -3701,6 +3747,16 @@ free_context_buffers(struct context_buffers *b)
>>          free_buf(&b->read_tun_buf);
>>          free_buf(&b->aux_buf);
>>
>> +        if (b->to_tun_max.data) {
>> +            free_buf(&b->to_tun_max);
>> +            free_buf(&b->send_tun_max);
>> +            free_buf(&b->read_tun_max);
>> +            for (int x =3D 0; x < TUN_BAT_MAX; ++x)
>> +            {
>> +                free_buf(&b->read_tun_bufs[x]);
>> +            }
>> +        }
>> +
>>  #ifdef USE_COMP
>>          free_buf(&b->compress_buf);
>>          free_buf(&b->decompress_buf);
>> diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
>> index a419e32d..7e35c837 100644
>> --- a/src/openvpn/mtu.c
>> +++ b/src/openvpn/mtu.c
>> @@ -41,9 +41,15 @@ void
>>  alloc_buf_sock_tun(struct buffer *buf, const struct frame *frame)
>>  {
>>      /* allocate buffer for overlapped I/O */
>> -    *buf =3D alloc_buf(BUF_SIZE(frame));
>> +    size_t alen =3D BUF_SIZE(frame);
>> +    size_t blen =3D frame->buf.payload_size;
>> +    if (frame->bulk_size > 0) {
>> +        alen =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_OFF);
>> +        blen =3D BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_NOP);
>> +    }
>> +    *buf =3D alloc_buf(alen);
>>      ASSERT(buf_init(buf, frame->buf.headroom));
>> -    buf->len =3D frame->buf.payload_size;
>> +    buf->len =3D blen;
>>      ASSERT(buf_safe(buf, 0));
>>  }
>>
>> diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
>> index 925ef0bf..eb799fb3 100644
>> --- a/src/openvpn/mtu.h
>> +++ b/src/openvpn/mtu.h
>> @@ -58,6 +58,14 @@
>>   */
>>  #define TUN_MTU_MIN 100
>>
>> +/*
>> + * Bulk mode static define values.
>> + */
>> +#define TUN_BAT_MIN        6
>> +#define TUN_BAT_MAX        9
>> +#define TUN_BAT_OFF        256
>> +#define TUN_BAT_NOP        0
>> +
>>  /*
>>   * Default MTU of network over which tunnel data will pass by TCP/UDP.
>>   */
>> @@ -152,6 +160,10 @@ struct frame
>>                              *   which defaults to 0 for tun and 32
>>                              *   (\c TAP_MTU_EXTRA_DEFAULT) for tap.
>>                              *   */
>> +
>> +    int bulk_size;              /**< Signal to the init frame function
>> +                                 *   to allow for bulk mode TCP
>> transfers.
>> +                                 *   */
>>  };
>>
>>  /* Forward declarations, to prevent includes */
>> @@ -171,6 +183,7 @@ struct options;
>>   * larger than the headroom.
>>   */
>>  #define BUF_SIZE(f) ((f)->buf.headroom + (f)->buf.payload_size +
>> (f)->buf.tailroom)
>> +#define BAT_SIZE(a, b, c) ((a * b) + c)
>>
>>  /*
>>   * Function prototypes.
>> diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
>> index e1ce32ab..9e089703 100644
>> --- a/src/openvpn/multi.c
>> +++ b/src/openvpn/multi.c
>> @@ -3414,6 +3414,7 @@ multi_process_incoming_link(struct multi_context
>> *m, struct multi_instance *inst
>>                  }
>>
>>                  process_incoming_link_part2(c, lsi, orig_buf);
>> +                process_incoming_link_part3(c);
>>              }
>>              perf_pop();
>>
>> @@ -3558,9 +3559,7 @@ multi_process_incoming_tun(struct multi_context *m,
>> const unsigned int mpp_flags
>>          const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
>>          int16_t vid =3D 0;
>>
>> -#ifdef MULTI_DEBUG_EVENT_LOOP
>> -        printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
>> -#endif
>> +        msg(D_MULTI_DEBUG, "TUN -> TCP/UDP [%d]", BLEN(&m->top.c2.buf));
>>
>>          if (m->pending)
>>          {
>> @@ -3610,6 +3609,8 @@ multi_process_incoming_tun(struct multi_context *m,
>> const unsigned int mpp_flags
>>                          {
>>                              /* transfer packet pointer from top-level
>> context buffer to instance */
>>                              c->c2.buf =3D m->top.c2.buf;
>> +                            /* todo determine if to call this
>> (multi_process_incoming_tun) for each bulk item read? */
>> +                            xfer_io(c, &m->top);
>>                          }
>>                          else
>>                          {
>> diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
>> index cd99cd40..21fa8967 100644
>> --- a/src/openvpn/openvpn.h
>> +++ b/src/openvpn/openvpn.h
>> @@ -112,6 +112,14 @@ struct context_buffers
>>       */
>>      struct buffer read_link_buf;
>>      struct buffer read_tun_buf;
>> +
>> +    struct buffer read_tun_bufs[TUN_BAT_MAX];
>> +    struct buffer read_tun_max;
>> +    struct buffer send_tun_max;
>> +    struct buffer to_tun_max;
>> +
>> +    int bufs_indx;
>> +    int flag_ciph;
>>  };
>>
>>  /*
>> @@ -376,6 +384,8 @@ struct context_2
>>      struct buffer to_tun;
>>      struct buffer to_link;
>>
>> +    struct buffer bufs[TUN_BAT_MAX];
>> +
>>      /* should we print R|W|r|w to console on packet transfers? */
>>      bool log_rw;
>>
>> diff --git a/src/openvpn/options.c b/src/openvpn/options.c
>> index c54032d8..041d17d0 100644
>> --- a/src/openvpn/options.c
>> +++ b/src/openvpn/options.c
>> @@ -304,6 +304,7 @@ static const char usage_message[] =3D
>>      "                  'maybe' -- Use per-route hints\n"
>>      "                  'yes'   -- Always DF (Don't Fragment)\n"
>>      "--mtu-test      : Empirically measure and report MTU.\n"
>> +    "--bulk-mode     : Use bulk TUN/TCP reads/writes.\n"
>>  #ifdef ENABLE_FRAGMENT
>>      "--fragment max  : Enable internal datagram fragmentation so that no
>> UDP\n"
>>      "                  datagrams are sent which are larger than max
>> bytes.\n"
>> @@ -3005,6 +3006,9 @@ options_postprocess_mutate_ce(struct options *o,
>> struct connection_entry *ce)
>>              ce->tun_mtu_extra_defined =3D true;
>>              ce->tun_mtu_extra =3D TAP_MTU_EXTRA_DEFAULT;
>>          }
>> +        if (ce->proto !=3D PROTO_TCP && ce->proto !=3D PROTO_TCP_SERVER=
 &&
>> ce->proto !=3D PROTO_TCP_CLIENT) {
>> +            ce->bulk_mode =3D false;
>> +        }
>>      }
>>
>>      /*
>> @@ -9926,6 +9930,10 @@ add_option(struct options *options, char *p[],
>> bool is_inline, const char *file,
>>              goto err;
>>          }
>>      }
>> +    else if (streq(p[0], "bulk-mode"))
>> +    {
>> +        options->ce.bulk_mode =3D true;
>> +    }
>>      else
>>      {
>>          int i;
>> diff --git a/src/openvpn/options.h b/src/openvpn/options.h
>> index 38e67c8d..d1b0586d 100644
>> --- a/src/openvpn/options.h
>> +++ b/src/openvpn/options.h
>> @@ -174,6 +174,9 @@ struct connection_entry
>>
>>      /* Allow only client that support resending the wrapped client key =
*/
>>      bool tls_crypt_v2_force_cookie;
>> +
>> +    /* Bulk mode allows for multiple tun reads + larger tcp writes */
>> +    bool bulk_mode;
>>  };
>>
>>  struct remote_entry
>> --
>> 2.39.5 (Apple Git-154)
>>
>>

--000000000000d7201d063bdf0a69
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">[one last self reply]<div><br></div><div>I did some work t=
oday to fix a potential issue with my read tun method where it may not read=
 from the file descriptor upon reconnection. I believe it should be fixed n=
ow just in case anyone is still interested in a change like this.=C2=A0</di=
v><div><br></div><div>Example POC Pull Request Link:=C2=A0<a href=3D"https:=
//github.com/OpenVPN/openvpn/pull/814/files" rel=3D"nofollow" style=3D"font=
-family:monospace,sans-serif;font-size:14px;background:repeat rgb(254,254,2=
54);box-sizing:inherit;margin:0px;padding:0px;vertical-align:baseline;outli=
ne:currentcolor;color:rgb(0,153,204);text-decoration:none">https://github.c=
om/OpenVPN/openvpn/pull/814/files</a></div><div><br></div><div>$ cat 0001-b=
ulk-mode.patch<br>From 28d43ff49984f2d3c787fa791d0a7a548ac80fad Mon Sep 17 =
00:00:00 2001<br>From: Jon Chiappetta &lt;<a href=3D"mailto:root@...2904...=
">root@...2904...</a>&gt;<br>Date: Wed, 6 Aug 2025 16:33:18 -0400<br>Subjec=
t: [PATCH] bulk mode<br><br>---<br>=C2=A0src/openvpn/forward.c | 225 ++++++=
++++++++++++++++++++++++++++++++++--<br>=C2=A0src/openvpn/forward.h | =C2=
=A0 4 +<br>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0| =C2=A057 +++++++++++<br>=
=C2=A0src/openvpn/mtu.c =C2=A0 =C2=A0 | =C2=A010 +-<br>=C2=A0src/openvpn/mt=
u.h =C2=A0 =C2=A0 | =C2=A013 +++<br>=C2=A0src/openvpn/multi.c =C2=A0 | =C2=
=A0 7 +-<br>=C2=A0src/openvpn/openvpn.h | =C2=A010 ++<br>=C2=A0src/openvpn/=
options.c | =C2=A0 8 ++<br>=C2=A0src/openvpn/options.h | =C2=A0 3 +<br>=C2=
=A09 files changed, 325 insertions(+), 12 deletions(-)<br><br>diff --git a/=
src/openvpn/forward.c b/src/openvpn/forward.c<br>index 75ca9d5c..b9d96482 1=
00644<br>--- a/src/openvpn/forward.c<br>+++ b/src/openvpn/forward.c<br>@@ -=
46,6 +46,9 @@<br><br>=C2=A0#include &quot;mstats.h&quot;<br><br>+#include &=
lt;sys/select.h&gt;<br>+#include &lt;sys/time.h&gt;<br>+<br>=C2=A0counter_t=
ype link_read_bytes_global; =C2=A0/* GLOBAL */<br>=C2=A0counter_type link_w=
rite_bytes_global; /* GLOBAL */<br><br>@@ -78,6 +81,34 @@ show_wait_status(=
struct context *c)<br><br>=C2=A0#endif /* ifdef ENABLE_DEBUG */<br><br>+boo=
l check_bulk_mode(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0if ((c-&gt;c2.=
frame.bulk_size &gt; 0) &amp;&amp; (c-&gt;c1.tuntap !=3D NULL) &amp;&amp; (=
c-&gt;c2.buffers !=3D NULL))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0return true;<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0return false;<br>+=
}<br>+<br>+void xfer_io(struct context *c, struct context *b)<br>+{<br>+ =
=C2=A0 =C2=A0//dmsg(M_INFO, &quot;BULK MODE xfer_io c [%d] [%p] [%p] [%d] [=
%d] [%d]&quot;, c-&gt;c2.frame.bulk_size, c-&gt;c1.tuntap, c-&gt;c2.buffers=
, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.t=
o_link));<br>+ =C2=A0 =C2=A0//dmsg(M_INFO, &quot;BULK MODE xfer_io b [%d] [=
%p] [%p] [%d] [%d] [%d]&quot;, b-&gt;c2.frame.bulk_size, b-&gt;c1.tuntap, b=
-&gt;c2.buffers, BLEN(&amp;b-&gt;c2.buf), BLEN(&amp;b-&gt;c2.to_tun), BLEN(=
&amp;b-&gt;c2.to_link));<br>+ =C2=A0 =C2=A0int plen =3D 0;<br>+ =C2=A0 =C2=
=A0if (check_bulk_mode(b))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0int leng =3D (b-&gt;c2.buffers-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0for (int x =3D 0; x &lt; leng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D BLEN(&amp;b=
-&gt;c2.bufs[x]);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (plen &l=
t; 1) { c-&gt;c2.bufs[x].len =3D 0; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0else { c-&gt;c2.bufs[x] =3D b-&gt;c2.bufs[x]; }<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;buf=
s_indx =3D b-&gt;c2.buffers-&gt;bufs_indx;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
b-&gt;c2.buffers-&gt;bufs_indx =3D -1;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=
=C2=A0static void<br>=C2=A0check_tls_errors_co(struct context *c)<br>=C2=A0=
{<br>@@ -605,6 +636,21 @@ buffer_turnover(const uint8_t *orig_buf, struct b=
uffer *dest_stub, struct buffer<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><br>=
+uint8_t *buff_prepsize(uint8_t *buff, int *size)<br>+{<br>+ =C2=A0 =C2=A0b=
uff[0] =3D ((*size &gt;&gt; 8) &amp; 0xff);<br>+ =C2=A0 =C2=A0buff[1] =3D (=
(*size &gt;&gt; 0) &amp; 0xff);<br>+ =C2=A0 =C2=A0buff +=3D 2;<br>+ =C2=A0 =
=C2=A0return buff;<br>+}<br>+<br>+uint8_t *buff_postsize(uint8_t *buff, int=
 *size)<br>+{<br>+ =C2=A0 =C2=A0*size =3D ((buff[0] &lt;&lt; 8) + (buff[1] =
&lt;&lt; 0));<br>+ =C2=A0 =C2=A0buff +=3D 2;<br>+ =C2=A0 =C2=A0return buff;=
<br>+}<br>+<br>=C2=A0/*<br>=C2=A0 * Compress, fragment, encrypt and HMAC-si=
gn an outgoing packet.<br>=C2=A0 * Input: c-&gt;c2.buf<br>@@ -1031,6 +1077,=
7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info=
 *lsi, boo<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;R&quo=
t;);<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>+<br>=C2=A0 =C2=A0 =C2=A0m=
sg(D_LINK_RW, &quot;%s READ [%d] from %s: %s&quot;, proto2ascii(lsi-&gt;pro=
to, lsi-&gt;af, true),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BLEN(&amp;c-&gt=
;c2.buf), print_link_socket_actual(&amp;c-&gt;c2.from, &amp;gc), PROTO_DUMP=
(&amp;c-&gt;c2.buf, &amp;gc));<br><br>@@ -1211,6 +1258,26 @@ process_incomi=
ng_link_part2(struct context *c, struct link_socket_info *lsi,<br>=C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0}<br><br>+void process_incoming_link_part3(struct c=
ontext *c)<br>+{<br>+ =C2=A0 =C2=A0int leng =3D BLEN(&amp;c-&gt;c2.buf);<br=
>+ =C2=A0 =C2=A0if (leng &gt; 0)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;send_tun_max.=
offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt=
;c2.buffers-&gt;send_tun_max.len =3D leng;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.buf), BPTR(&amp;c-&gt;c2.buffers-&gt=
;send_tun_max), leng);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;=
c2.to_tun.offset +=3D 2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&g=
t;c2.buf.offset +=3D 2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0buf_reset(&amp;c-&gt;c2.to_tun);<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=
=C2=A0static void<br>=C2=A0process_incoming_link(struct context *c, struct =
link_socket *sock)<br>=C2=A0{<br>@@ -1221,6 +1288,7 @@ process_incoming_lin=
k(struct context *c, struct link_socket *sock)<br><br>=C2=A0 =C2=A0 =C2=A0p=
rocess_incoming_link_part1(c, lsi, false);<br>=C2=A0 =C2=A0 =C2=A0process_i=
ncoming_link_part2(c, lsi, orig_buf);<br>+ =C2=A0 =C2=A0process_incoming_li=
nk_part3(c);<br><br>=C2=A0 =C2=A0 =C2=A0perf_pop();<br>=C2=A0}<br>@@ -1321,=
7 +1389,7 @@ process_incoming_dco(struct context *c)<br>=C2=A0 */<br><br>=
=C2=A0void<br>-read_incoming_tun(struct context *c)<br>+read_incoming_tun_p=
art2(struct context *c)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=
=A0 =C2=A0 * Setup for read() call on TUN/TAP device.<br>@@ -1382,6 +1450,5=
4 @@ read_incoming_tun(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0perf_pop()=
;<br>=C2=A0}<br><br>+void read_incoming_tun_part3(struct context *c)<br>+{<=
br>+ =C2=A0 =C2=A0fd_set rfds;<br>+ =C2=A0 =C2=A0struct timeval timo;<br>+ =
=C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int plen =3D 0, pidx =3D -1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
int fdno =3D c-&gt;c1.tuntap-&gt;fd;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (i=
nt x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D plen, indx =3D (pidx=
 + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (indx &gt;=3D TUN_B=
AT_MIN) { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (leng &=
lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FD_ZERO(&amp;rfds);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FD_SET(fdno, &amp;rfds);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timo.tv_sec =3D 0=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timo.tv_usec =
=3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select(f=
dno+1, &amp;rfds, NULL, NULL, &amp;timo);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (FD_ISSET(fdno, &amp;rfds))<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_incoming_tun_part2(c);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
plen =3D BLEN(&amp;c-&gt;c2.buf);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0leng =3D plen;<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (leng &gt; 0)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_bufs[indx].offset =3D TU=
N_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&g=
t;c2.buffers-&gt;read_tun_bufs[indx].len =3D leng;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.buf), BPTR(&=
amp;c-&gt;c2.buffers-&gt;read_tun_bufs[indx]), leng);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.bufs[indx] =3D c-&gt;c2.b=
uffers-&gt;read_tun_bufs[indx];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0pidx =3D indx;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D=
 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt=
;c2.buffers-&gt;bufs_indx =3D pidx;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+void=
 read_incoming_tun(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.=
frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0read_incoming_=
tun_part2(c);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0read_incoming_tun_part3=
(c);<br>+}<br>+<br>=C2=A0/**<br>=C2=A0 * Drops UDP packets which OS decided=
 to route via tun.<br>=C2=A0 *<br>@@ -1469,7 +1585,7 @@ drop_if_recursive_r=
outing(struct context *c, struct buffer *buf)<br>=C2=A0 */<br><br>=C2=A0voi=
d<br>-process_incoming_tun(struct context *c, struct link_socket *out_sock)=
<br>+process_incoming_tun_part2(struct context *c, struct link_socket *out_=
sock)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br=
><br>@@ -1488,7 +1604,7 @@ process_incoming_tun(struct context *c, struct l=
ink_socket *out_sock)<br>=C2=A0#endif<br><br>=C2=A0 =C2=A0 =C2=A0/* Show pa=
cket content */<br>- =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN READ [%d]&quot;,=
 BLEN(&amp;c-&gt;c2.buf));<br>+ =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN READ =
[%d] [%d]&quot;, BLEN(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);=
<br><br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.buf.len &gt; 0)<br>=C2=A0 =C2=A0 =
=C2=A0{<br>@@ -1512,7 +1628,9 @@ process_incoming_tun(struct context *c, st=
ruct link_socket *out_sock)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0if (c-&gt;c2.buf.len &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if ((c-&gt;c2.buffers =3D=3D NULL) || (c-&gt;c2.buffers-&gt;f=
lag_ciph !=3D -2)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encrypt_sign(c, t=
rue);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =
=C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -1522,6 +1640,65 @@ proces=
s_incoming_tun(struct context *c, struct link_socket *out_sock)<br>=C2=A0 =
=C2=A0 =C2=A0gc_free(&amp;gc);<br>=C2=A0}<br><br>+void process_incoming_tun=
_part3(struct context *c, struct link_socket *out_sock)<br>+{<br>+ =C2=A0 =
=C2=A0if (c-&gt;c2.buf.len &gt; 0)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;flag_ciph =
=3D -2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;=
read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D 0;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =3D BPTR(&amp;c-&gt;c2.buffers-&gt=
;read_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int plen =3D =
0, fdno =3D c-&gt;c1.tuntap-&gt;fd;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0int maxl =3D 0, leng =3D (c-&gt;c2.buffers-&gt;bufs_indx + 1);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fdno &gt; 0) &amp;&amp; (leng=
 &gt; 0))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; leng;=
 ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;=
c2.buf =3D c-&gt;c2.bufs[x];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_tun_part2(c, out_sock);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (BL=
EN(&amp;c-&gt;c2.buf) &lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.bufs[x].len =3D 0;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; l=
eng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen=
 =3D c-&gt;c2.bufs[x].len;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (plen &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff=
_prepsize(temp, &amp;plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.bufs[x]),=
 temp, plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0temp +=3D plen; maxl +=3D (plen + 2);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (maxl &gt; 0)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_t=
un_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D ma=
xl;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c2.buf =3D c-&gt;c2.buffers-&gt;read_tun_max;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encrypt_sign(c, true=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_indx =3D -1;<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;flag_ciph =3D -1;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0else<br>+ =C2=
=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_reset(&amp;c-&gt;c2.to_link=
);<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+void process_incoming_tun(struct cont=
ext *c, struct link_socket *out_sock)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.=
frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incomi=
ng_tun_part2(c, out_sock);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0process_in=
coming_tun_part3(c, out_sock);<br>+}<br>+<br>=C2=A0/**<br>=C2=A0 * Forges a=
 IPv6 ICMP packet with a no route to host error code from the<br>=C2=A0 * I=
Pv6 packet in buf and sends it directly back to the client via the tun<br>@=
@ -1748,7 +1925,7 @@ process_outgoing_link(struct context *c, struct link_s=
ocket *sock)<br><br>=C2=A0 =C2=A0 =C2=A0perf_push(PERF_PROC_OUT_LINK);<br><=
br>- =C2=A0 =C2=A0if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; c-&gt;c2.to_li=
nk.len &lt;=3D c-&gt;c2.frame.buf.payload_size)<br>+ =C2=A0 =C2=A0if (c-&gt=
;c2.to_link.len &gt; 0 &amp;&amp; (c-&gt;c2.to_link.len &lt;=3D c-&gt;c2.fr=
ame.buf.payload_size || c-&gt;c2.frame.bulk_size &gt; 0))<br>=C2=A0 =C2=A0 =
=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 * Setup for call to send/sendto which will send<br>@@ -1793,6 +1=
970,7 @@ process_outgoing_link(struct context *c, struct link_socket *sock)=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(s=
tderr, &quot;W&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}=
<br>=C2=A0#endif<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ms=
g(D_LINK_RW, &quot;%s WRITE [%d] to %s: %s&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proto2ascii(sock-&gt;info.proto, s=
ock-&gt;<a href=3D"http://info.af">info.af</a>, true), BLEN(&amp;c-&gt;c2.t=
o_link),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p=
rint_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc), PROTO_DUMP(&amp;c-=
&gt;c2.to_link, &amp;gc));<br>@@ -1892,7 +2070,7 @@ process_outgoing_link(s=
truct context *c, struct link_socket *sock)<br>=C2=A0 */<br><br>=C2=A0void<=
br>-process_outgoing_tun(struct context *c, struct link_socket *in_sock)<br=
>+process_outgoing_tun_part2(struct context *c, struct link_socket *in_sock=
)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 * Set up for=
 write() call to TUN/TAP<br>@@ -1912,7 +2090,7 @@ process_outgoing_tun(stru=
ct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0process_=
ip_header(c, PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PI=
P_OUTGOING,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;c2.to_tun, in_sock);<br><br>- =C2=A0 =C2=
=A0if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payload_size)<br>+ =
=C2=A0 =C2=A0if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payload_siz=
e || c-&gt;c2.frame.bulk_size &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Write=
 to TUN/TAP device.<br>@@ -1925,7 +2103,8 @@ process_outgoing_tun(struct co=
ntext *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;w&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0#endif<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0dmsg(D_TUN_R=
W, &quot;TUN WRITE [%d]&quot;, BLEN(&amp;c-&gt;c2.to_tun));<br>+<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN WRITE [%d] [%d]&quot;, BLE=
N(&amp;c-&gt;c2.to_tun), c-&gt;c2.frame.buf.payload_size);<br><br>=C2=A0#if=
def PACKET_TRUNCATION_CHECK<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipv4_packe=
t_size_verify(BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun), TUNNE=
L_TYPE(c-&gt;c1.tuntap),<br>@@ -1981,6 +2160,38 @@ process_outgoing_tun(str=
uct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0perf_po=
p();<br>=C2=A0}<br><br>+void process_outgoing_tun_part3(struct context *c, =
struct link_socket *in_sock)<br>+{<br>+ =C2=A0 =C2=A0if (check_bulk_mode(c)=
)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl =3D 0, plen =
=3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D BLEN(&amp;c-&gt;c2.buff=
ers-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =3D BP=
TR(&amp;c-&gt;c2.buffers-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff_postsize(t=
emp, &amp;plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((leng &g=
t; 0) &amp;&amp; (plen &gt; 0) &amp;&amp; ((maxl + plen) &lt; leng))<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun =3D c-&gt;c2.buffers-&gt;to_tun=
_max;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.=
to_tun.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.len =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(temp, BPTR(&amp;c-&gt;c2.to_tun), p=
len);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp +=3D=
 plen; maxl +=3D (plen + 2);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0process_outgoing_tun_part2(c, in_sock);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0buf_reset(&amp;c-&gt;c2.to_tun);=
<br>+}<br>+<br>+void process_outgoing_tun(struct context *c, struct link_so=
cket *in_sock)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_size &lt;=3D=
 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0process_outgoing_tun_part2(c, in_sock=
);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0process_outgoing_tun_part3(c, in_s=
ock);<br>+}<br>+<br>=C2=A0void<br>=C2=A0pre_select(struct context *c)<br>=
=C2=A0{<br>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h<br>in=
dex d5641491..9fda1583 100644<br>--- a/src/openvpn/forward.h<br>+++ b/src/o=
penvpn/forward.h<br>@@ -79,6 +79,8 @@ void pre_select(struct context *c);<b=
r><br>=C2=A0void process_io(struct context *c, struct link_socket *sock);<b=
r><br>+void xfer_io(struct context *c, struct context *b);<br>+<br><br>=C2=
=A0/**********************************************************************/=
<br>=C2=A0/**<br>@@ -196,6 +198,8 @@ bool process_incoming_link_part1(struc=
t context *c, struct link_socket_info *lsi<br>=C2=A0void process_incoming_l=
ink_part2(struct context *c, struct link_socket_info *lsi,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t *orig_buf);<br><br>+void proc=
ess_incoming_link_part3(struct context *c);<br>+<br>=C2=A0/**<br>=C2=A0 * T=
ransfers \c float_sa data extracted from an incoming DCO<br>=C2=A0 * PEER_F=
LOAT_NTF to \c out_osaddr for later processing.<br>diff --git a/src/openvpn=
/init.c b/src/openvpn/init.c<br>index 40ae2c8c..bbdbad46 100644<br>--- a/sr=
c/openvpn/init.c<br>+++ b/src/openvpn/init.c<br>@@ -2971,6 +2971,10 @@ fram=
e_finalize_options(struct context *c, const struct options *o)<br>=C2=A0 =
=C2=A0 =C2=A0tailroom +=3D COMP_EXTRA_BUFFER(payload_size);<br>=C2=A0#endif=
<br><br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0payload_size =3D frame-&gt;tun_mtu;<br>+ =C2=A0 =C2=A0}<br>+<=
br>=C2=A0 =C2=A0 =C2=A0frame-&gt;buf.payload_size =3D payload_size;<br>=C2=
=A0 =C2=A0 =C2=A0frame-&gt;buf.headroom =3D headroom;<br>=C2=A0 =C2=A0 =C2=
=A0frame-&gt;buf.tailroom =3D tailroom;<br>@@ -3473,6 +3477,9 @@ do_init_fr=
ame_tls(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.tls_multi)<b=
r>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls_multi_init=
_finalize(c-&gt;c2.tls_multi, c-&gt;options.ce.tls_mtu);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.tls_multi-&gt;opt.frame.buf.payload_size =
=3D c-&gt;c2.frame.tun_mtu;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(c-&gt;c2.tls_multi-&gt;opt.frame.buf.payload=
_size &lt;=3D c-&gt;c2.frame.buf.payload_size);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0frame_print(&amp;c-&gt;c2.tls_multi-&gt;opt.frame, D_MTU_INFO, &q=
uot;Control Channel MTU parms&quot;);<br><br>@@ -3536,6 +3543,14 @@ do_init=
_frame(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.fra=
me.extra_tun +=3D c-&gt;options.ce.tun_mtu_extra;<br>=C2=A0 =C2=A0 =C2=A0}<=
br><br>+ =C2=A0 =C2=A0/*<br>+ =C2=A0 =C2=A0 * Adjust bulk size based on the=
 --bulk-mode parameter.<br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0if (c-&gt;o=
ptions.ce.bulk_mode)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-=
&gt;c2.frame.bulk_size =3D c-&gt;options.ce.tun_mtu;<br>+ =C2=A0 =C2=A0}<br=
>+<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 * Fill in the blanks i=
n the frame parameters structure,<br>=C2=A0 =C2=A0 =C2=A0 * make sure value=
s are rational, etc.<br>@@ -3676,9 +3691,41 @@ init_context_buffers(const s=
truct frame *frame)<br><br>=C2=A0 =C2=A0 =C2=A0size_t buf_size =3D BUF_SIZE=
(frame);<br><br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0size_t off_size =3D (frame-&gt;buf.headroom + TUN_B=
AT_OFF + frame-&gt;buf.tailroom);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_size =
=3D BAT_SIZE(TUN_BAT_MAX, frame-&gt;tun_mtu, off_size);<br>+ =C2=A0 =C2=A0}=
<br>+<br>+ =C2=A0 =C2=A0dmsg(M_INFO, &quot;MEM NEW [%ld] [%d+%d+%d]&quot;, =
buf_size, frame-&gt;buf.headroom, frame-&gt;buf.payload_size, frame-&gt;buf=
.tailroom);<br>+<br>=C2=A0 =C2=A0 =C2=A0b-&gt;read_link_buf =3D alloc_buf(b=
uf_size);<br>=C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_buf =3D alloc_buf(buf_size)=
;<br><br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t par=
t_size =3D BUF_SIZE(frame);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
-&gt;read_tun_bufs[x] =3D alloc_buf(part_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_bufs[x].offset =3D TUN_BAT_OFF;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_bufs[x].len =3D 0;<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;r=
ead_tun_max =3D alloc_buf(buf_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;=
read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;=
read_tun_max.len =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;send_tun=
_max =3D alloc_buf(buf_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;send_tu=
n_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;send_tu=
n_max.len =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;to_tun_max =3D =
alloc_buf(buf_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;to_tun_max.offse=
t =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;to_tun_max.len =3D=
 0;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0b-&gt;bufs_indx =3D -1;<br>+=
 =C2=A0 =C2=A0b-&gt;flag_ciph =3D -1;<br>+<br>=C2=A0 =C2=A0 =C2=A0b-&gt;aux=
_buf =3D alloc_buf(buf_size);<br><br>=C2=A0 =C2=A0 =C2=A0b-&gt;encrypt_buf =
=3D alloc_buf(buf_size);<br>@@ -3701,6 +3748,16 @@ free_context_buffers(str=
uct context_buffers *b)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;=
b-&gt;read_tun_buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&=
gt;aux_buf);<br><br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (b-&gt;to_tun_max.data)=
 {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;to_tun=
_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;se=
nd_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-=
&gt;read_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x=
 =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_bu=
f(&amp;b-&gt;read_tun_bufs[x]);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>=C2=A0#ifdef USE_COMP<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;compress_buf);<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;decompress_buf);<br>diff --=
git a/src/openvpn/mtu.c b/src/openvpn/mtu.c<br>index a419e32d..7e35c837 100=
644<br>--- a/src/openvpn/mtu.c<br>+++ b/src/openvpn/mtu.c<br>@@ -41,9 +41,1=
5 @@ void<br>=C2=A0alloc_buf_sock_tun(struct buffer *buf, const struct fram=
e *frame)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/* allocate buffer for overlapp=
ed I/O */<br>- =C2=A0 =C2=A0*buf =3D alloc_buf(BUF_SIZE(frame));<br>+ =C2=
=A0 =C2=A0size_t alen =3D BUF_SIZE(frame);<br>+ =C2=A0 =C2=A0size_t blen =
=3D frame-&gt;buf.payload_size;<br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &=
gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0alen =3D BAT_SIZE(TUN_BAT_MAX, fra=
me-&gt;tun_mtu, TUN_BAT_OFF);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0blen =3D BAT_=
SIZE(TUN_BAT_MAX, frame-&gt;tun_mtu, TUN_BAT_NOP);<br>+ =C2=A0 =C2=A0}<br>+=
 =C2=A0 =C2=A0*buf =3D alloc_buf(alen);<br>=C2=A0 =C2=A0 =C2=A0ASSERT(buf_i=
nit(buf, frame-&gt;buf.headroom));<br>- =C2=A0 =C2=A0buf-&gt;len =3D frame-=
&gt;buf.payload_size;<br>+ =C2=A0 =C2=A0buf-&gt;len =3D blen;<br>=C2=A0 =C2=
=A0 =C2=A0ASSERT(buf_safe(buf, 0));<br>=C2=A0}<br><br>diff --git a/src/open=
vpn/mtu.h b/src/openvpn/mtu.h<br>index 925ef0bf..eb799fb3 100644<br>--- a/s=
rc/openvpn/mtu.h<br>+++ b/src/openvpn/mtu.h<br>@@ -58,6 +58,14 @@<br>=C2=A0=
 */<br>=C2=A0#define TUN_MTU_MIN 100<br><br>+/*<br>+ * Bulk mode static def=
ine values.<br>+ */<br>+#define TUN_BAT_MIN =C2=A0 =C2=A0 =C2=A0 =C2=A06<br=
>+#define TUN_BAT_MAX =C2=A0 =C2=A0 =C2=A0 =C2=A09<br>+#define TUN_BAT_OFF =
=C2=A0 =C2=A0 =C2=A0 =C2=A0256<br>+#define TUN_BAT_NOP =C2=A0 =C2=A0 =C2=A0=
 =C2=A00<br>+<br>=C2=A0/*<br>=C2=A0 * Default MTU of network over which tun=
nel data will pass by TCP/UDP.<br>=C2=A0 */<br>@@ -152,6 +160,10 @@ struct =
frame<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 which defaults to 0 for tun =
and 32<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 (\c TAP_MTU_EXTRA_DEFAULT=
) for tap.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 */<br>+<br>+ =C2=A0 =
=C2=A0int bulk_size; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt=
; Signal to the init frame function<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 * =C2=A0 to allow for bulk mode TCP transfers.<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 * =C2=A0 */<br>=C2=A0};<br><br>=C2=A0/* Forward declar=
ations, to prevent includes */<br>@@ -171,6 +183,7 @@ struct options;<br>=
=C2=A0 * larger than the headroom.<br>=C2=A0 */<br>=C2=A0#define BUF_SIZE(f=
) ((f)-&gt;buf.headroom + (f)-&gt;buf.payload_size + (f)-&gt;buf.tailroom)<=
br>+#define BAT_SIZE(a, b, c) ((a * b) + c)<br><br>=C2=A0/*<br>=C2=A0 * Fun=
ction prototypes.<br>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c=
<br>index e1ce32ab..9e089703 100644<br>--- a/src/openvpn/multi.c<br>+++ b/s=
rc/openvpn/multi.c<br>@@ -3414,6 +3414,7 @@ multi_process_incoming_link(str=
uct multi_context *m, struct multi_instance *inst<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_link_part2(c, lsi, o=
rig_buf);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proce=
ss_incoming_link_part3(c);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perf_pop();<br><br>=
@@ -3558,9 +3559,7 @@ multi_process_incoming_tun(struct multi_context *m, c=
onst unsigned int mpp_flags<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int =
dev_type =3D TUNNEL_TYPE(m-&gt;top.c1.tuntap);<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0int16_t vid =3D 0;<br><br>-#ifdef MULTI_DEBUG_EVENT_LOOP<br>- =C2=
=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&=
amp;m-&gt;top.c2.buf));<br>-#endif<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_MU=
LTI_DEBUG, &quot;TUN -&gt; TCP/UDP [%d]&quot;, BLEN(&amp;m-&gt;top.c2.buf))=
;<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (m-&gt;pending)<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0{<br>@@ -3610,6 +3609,8 @@ multi_process_incoming_t=
un(struct multi_context *m, const unsigned int mpp_flags<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* transfer packet pointer from top-l=
evel context buffer to instance */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;=
c2.buf =3D m-&gt;top.c2.buf;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* todo determine i=
f to call this (multi_process_incoming_tun) for each bulk item read? */<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0xfer_io(c, &amp;m-&gt;top);<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>diff --git a/src/openvpn/open=
vpn.h b/src/openvpn/openvpn.h<br>index cd99cd40..21fa8967 100644<br>--- a/s=
rc/openvpn/openvpn.h<br>+++ b/src/openvpn/openvpn.h<br>@@ -112,6 +112,14 @@=
 struct context_buffers<br>=C2=A0 =C2=A0 =C2=A0 */<br>=C2=A0 =C2=A0 =C2=A0s=
truct buffer read_link_buf;<br>=C2=A0 =C2=A0 =C2=A0struct buffer read_tun_b=
uf;<br>+<br>+ =C2=A0 =C2=A0struct buffer read_tun_bufs[TUN_BAT_MAX];<br>+ =
=C2=A0 =C2=A0struct buffer read_tun_max;<br>+ =C2=A0 =C2=A0struct buffer se=
nd_tun_max;<br>+ =C2=A0 =C2=A0struct buffer to_tun_max;<br>+<br>+ =C2=A0 =
=C2=A0int bufs_indx;<br>+ =C2=A0 =C2=A0int flag_ciph;<br>=C2=A0};<br><br>=
=C2=A0/*<br>@@ -376,6 +384,8 @@ struct context_2<br>=C2=A0 =C2=A0 =C2=A0str=
uct buffer to_tun;<br>=C2=A0 =C2=A0 =C2=A0struct buffer to_link;<br><br>+ =
=C2=A0 =C2=A0struct buffer bufs[TUN_BAT_MAX];<br>+<br>=C2=A0 =C2=A0 =C2=A0/=
* should we print R|W|r|w to console on packet transfers? */<br>=C2=A0 =C2=
=A0 =C2=A0bool log_rw;<br><br>diff --git a/src/openvpn/options.c b/src/open=
vpn/options.c<br>index c54032d8..041d17d0 100644<br>--- a/src/openvpn/optio=
ns.c<br>+++ b/src/openvpn/options.c<br>@@ -304,6 +304,7 @@ static const cha=
r usage_message[] =3D<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;maybe&#39; -- Use per-route h=
ints\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;yes&#39; =C2=A0 -- Always DF (Don&#39;t=
 Fragment)\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--mtu-test =C2=A0 =C2=A0 =
=C2=A0: Empirically measure and report MTU.\n&quot;<br>+ =C2=A0 =C2=A0&quot=
;--bulk-mode =C2=A0 =C2=A0 : Use bulk TUN/TCP reads/writes.\n&quot;<br>=C2=
=A0#ifdef ENABLE_FRAGMENT<br>=C2=A0 =C2=A0 =C2=A0&quot;--fragment max =C2=
=A0: Enable internal datagram fragmentation so that no UDP\n&quot;<br>=C2=
=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0datagrams are sent which are larger than max bytes.\n&quot;<br=
>@@ -3005,6 +3006,9 @@ options_postprocess_mutate_ce(struct options *o, str=
uct connection_entry *ce)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ce-&gt;tun_mtu_extra_defined =3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0ce-&gt;tun_mtu_extra =3D TAP_MTU_EXTRA_DEFAULT;<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ce-&gt=
;proto !=3D PROTO_TCP &amp;&amp; ce-&gt;proto !=3D PROTO_TCP_SERVER &amp;&a=
mp; ce-&gt;proto !=3D PROTO_TCP_CLIENT) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0ce-&gt;bulk_mode =3D false;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0/*<br>@@ -9926,6 +9930,=
10 @@ add_option(struct options *options, char *p[], bool is_inline, const =
char *file,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0else if (streq(p[0], &quot;bulk-mode&quot;))<br>+ =C2=A0 =C2=A0{<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;ce.bulk_mode =3D true;<br>+ =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>diff --git a/src/openvpn/options.h b/src/=
openvpn/options.h<br>index 38e67c8d..d1b0586d 100644<br>--- a/src/openvpn/o=
ptions.h<br>+++ b/src/openvpn/options.h<br>@@ -174,6 +174,9 @@ struct conne=
ction_entry<br><br>=C2=A0 =C2=A0 =C2=A0/* Allow only client that support re=
sending the wrapped client key */<br>=C2=A0 =C2=A0 =C2=A0bool tls_crypt_v2_=
force_cookie;<br>+<br>+ =C2=A0 =C2=A0/* Bulk mode allows for multiple tun r=
eads + larger tcp writes */<br>+ =C2=A0 =C2=A0bool bulk_mode;<br>=C2=A0};<b=
r><br>=C2=A0struct remote_entry<br>--<br>2.39.5 (Apple Git-154)<br><br><br>=
</div><div><br></div><div><br></div><div><br></div><div><br></div></div><br=
><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"ltr" class=3D=
"gmail_attr">On Fri, Aug 8, 2025 at 10:23=E2=80=AFAM Jon Chiappetta &lt;<a =
href=3D"mailto:root@...2904...">root@...2904...</a>&gt; wrote:<br></div><bl=
ockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-lef=
t-width:1px;border-left-style:solid;border-left-color:rgb(204,204,204);padd=
ing-left:1ex"><div dir=3D"ltr">[replying to my own update thread]<div><br><=
/div><div>I pushed an update to the PR with the following small changes:</d=
iv><div><br></div><div>- rebased to the latest master commit<br>- increased=
 the data buffer size to be slightly bigger than the read buffer size<br>- =
copied two more buf resets so that the additional bulk forward functions ma=
tch the present logic checks<br></div><div><br></div><div>Example updated p=
ull request:=C2=A0<a href=3D"https://github.com/OpenVPN/openvpn/pull/814/fi=
les" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/814/files</a=
></div><div><br></div><div>$ cat 0001-bulk-mode.patch<br>From 2ce0b023d105e=
7ecc289a414cd26f7ebc8bcbcaf Mon Sep 17 00:00:00 2001<br>From: Jon Chiappett=
a &lt;<a href=3D"mailto:root@...2904..." target=3D"_blank">root@...2904...<=
/a>&gt;<br>Date: Wed, 6 Aug 2025 16:33:18 -0400<br>Subject: [PATCH] bulk mo=
de<br><br>---<br>=C2=A0src/openvpn/forward.c | 228 ++++++++++++++++++++++++=
++++++++++++++++--<br>=C2=A0src/openvpn/forward.h | =C2=A0 4 +<br>=C2=A0src=
/openvpn/init.c =C2=A0 =C2=A0| =C2=A057 +++++++++++<br>=C2=A0src/openvpn/mt=
u.c =C2=A0 =C2=A0 | =C2=A010 +-<br>=C2=A0src/openvpn/mtu.h =C2=A0 =C2=A0 | =
=C2=A013 +++<br>=C2=A0src/openvpn/multi.c =C2=A0 | =C2=A0 7 +-<br>=C2=A0src=
/openvpn/openvpn.h | =C2=A010 ++<br>=C2=A0src/openvpn/options.c | =C2=A0 8 =
++<br>=C2=A0src/openvpn/options.h | =C2=A0 3 +<br>=C2=A09 files changed, 32=
8 insertions(+), 12 deletions(-)<br><br>diff --git a/src/openvpn/forward.c =
b/src/openvpn/forward.c<br>index 75ca9d5c..0af983e9 100644<br>--- a/src/ope=
nvpn/forward.c<br>+++ b/src/openvpn/forward.c<br>@@ -46,6 +46,9 @@<br><br>=
=C2=A0#include &quot;mstats.h&quot;<br><br>+#include &lt;sys/select.h&gt;<b=
r>+#include &lt;sys/time.h&gt;<br>+<br>=C2=A0counter_type link_read_bytes_g=
lobal; =C2=A0/* GLOBAL */<br>=C2=A0counter_type link_write_bytes_global; /*=
 GLOBAL */<br><br>@@ -78,6 +81,32 @@ show_wait_status(struct context *c)<br=
><br>=C2=A0#endif /* ifdef ENABLE_DEBUG */<br><br>+bool check_bulk_mode(str=
uct context *c)<br>+{<br>+ =C2=A0 =C2=A0if ((c-&gt;c2.frame.bulk_size &gt; =
0) &amp;&amp; (c-&gt;c1.tuntap !=3D NULL) &amp;&amp; (c-&gt;c2.buffers !=3D=
 NULL))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br=
>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0return false;<br>+}<br>+<br>+void xfer_=
io(struct context *c, struct context *b)<br>+{<br>+ =C2=A0 =C2=A0int plen =
=3D 0;<br>+ =C2=A0 =C2=A0if (check_bulk_mode(b))<br>+ =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D (b-&gt;c2.buffers-&gt;bufs_indx + 1=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; leng; ++x)<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0plen =3D BLEN(&amp;b-&gt;c2.bufs[x]);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (plen &lt; 1) { c-&gt;c2.bufs[x].len =3D 0; }<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else { c-&gt;c2.bufs[x] =3D b-&gt;c2.bufs=
[x]; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-=
&gt;c2.buffers-&gt;bufs_indx =3D b-&gt;c2.buffers-&gt;bufs_indx;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;c2.buffers-&gt;bufs_indx =3D -1;<br>+ =C2=A0 =
=C2=A0}<br>+}<br>+<br>=C2=A0static void<br>=C2=A0check_tls_errors_co(struct=
 context *c)<br>=C2=A0{<br>@@ -605,6 +634,21 @@ buffer_turnover(const uint8=
_t *orig_buf, struct buffer *dest_stub, struct buffer<br>=C2=A0 =C2=A0 =C2=
=A0}<br>=C2=A0}<br><br>+uint8_t *buff_prepsize(uint8_t *buff, int *size)<br=
>+{<br>+ =C2=A0 =C2=A0buff[0] =3D ((*size &gt;&gt; 8) &amp; 0xff);<br>+ =C2=
=A0 =C2=A0buff[1] =3D ((*size &gt;&gt; 0) &amp; 0xff);<br>+ =C2=A0 =C2=A0bu=
ff +=3D 2;<br>+ =C2=A0 =C2=A0return buff;<br>+}<br>+<br>+uint8_t *buff_post=
size(uint8_t *buff, int *size)<br>+{<br>+ =C2=A0 =C2=A0*size =3D ((buff[0] =
&lt;&lt; 8) + (buff[1] &lt;&lt; 0));<br>+ =C2=A0 =C2=A0buff +=3D 2;<br>+ =
=C2=A0 =C2=A0return buff;<br>+}<br>+<br>=C2=A0/*<br>=C2=A0 * Compress, frag=
ment, encrypt and HMAC-sign an outgoing packet.<br>=C2=A0 * Input: c-&gt;c2=
.buf<br>@@ -1031,6 +1075,7 @@ process_incoming_link_part1(struct context *c=
, struct link_socket_info *lsi, boo<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fp=
rintf(stderr, &quot;R&quot;);<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>+=
<br>=C2=A0 =C2=A0 =C2=A0msg(D_LINK_RW, &quot;%s READ [%d] from %s: %s&quot;=
, proto2ascii(lsi-&gt;proto, lsi-&gt;af, true),<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0BLEN(&amp;c-&gt;c2.buf), print_link_socket_actual(&amp;c-&gt;c2.f=
rom, &amp;gc), PROTO_DUMP(&amp;c-&gt;c2.buf, &amp;gc));<br><br>@@ -1211,6 +=
1256,27 @@ process_incoming_link_part2(struct context *c, struct link_socke=
t_info *lsi,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><br>+void process_incom=
ing_link_part3(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0int leng =3D BLEN=
(&amp;c-&gt;c2.buf);<br>+ =C2=A0 =C2=A0if (leng &gt; 0)<br>+ =C2=A0 =C2=A0{=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buff=
ers-&gt;send_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;send_tun_max.len =3D leng;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.buf), BPTR(&=
amp;c-&gt;c2.buffers-&gt;send_tun_max), leng);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT LINK 0 [%d] [%d] [%d] [%d]=
 [%d]&quot;, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.to_tun), BLEN(&amp=
;c-&gt;c2.buffers-&gt;read_link_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_l=
ink_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;send_tun_max));<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.offset +=3D 2;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf.offset +=3D 2;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0else<br>+ =C2=A0 =
=C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_reset(&amp;c-&gt;c2.to_tun);<br=
>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=C2=A0static void<br>=C2=A0process_incoming=
_link(struct context *c, struct link_socket *sock)<br>=C2=A0{<br>@@ -1221,6=
 +1287,7 @@ process_incoming_link(struct context *c, struct link_socket *so=
ck)<br><br>=C2=A0 =C2=A0 =C2=A0process_incoming_link_part1(c, lsi, false);<=
br>=C2=A0 =C2=A0 =C2=A0process_incoming_link_part2(c, lsi, orig_buf);<br>+ =
=C2=A0 =C2=A0process_incoming_link_part3(c);<br><br>=C2=A0 =C2=A0 =C2=A0per=
f_pop();<br>=C2=A0}<br>@@ -1321,7 +1388,7 @@ process_incoming_dco(struct co=
ntext *c)<br>=C2=A0 */<br><br>=C2=A0void<br>-read_incoming_tun(struct conte=
xt *c)<br>+read_incoming_tun_part2(struct context *c)<br>=C2=A0{<br>=C2=A0 =
=C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 * Setup for read() call on TUN/TAP =
device.<br>@@ -1382,6 +1449,55 @@ read_incoming_tun(struct context *c)<br>=
=C2=A0 =C2=A0 =C2=A0perf_pop();<br>=C2=A0}<br><br>+void read_incoming_tun_p=
art3(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0fd_set rfds;<br>+ =C2=A0 =
=C2=A0struct timeval timo;<br>+ =C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =
=C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int plen =3D 0;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0int fdno =3D c-&gt;c1.tuntap-&gt;fd;<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0for (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D =
plen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int indx =3D (c-&gt;c2.=
buffers-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (indx &gt;=3D TUN_BAT_MIN) { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (leng &lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FD_ZERO(&a=
mp;rfds);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FD_SE=
T(fdno, &amp;rfds);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0timo.tv_sec =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0timo.tv_usec =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0select(fdno+1, &amp;rfds, NULL, NULL, &amp;timo);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (FD_ISSET(fdno, &amp=
;rfds))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_i=
ncoming_tun_part2(c);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0plen =3D BLEN(&amp;c-&gt;c2.buf);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { break; }<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0//dmsg(M_INFO, &quot;FWD BAT READ 0 [%d] [%d] [%d] [%d] [%d]&quot;, c=
-&gt;c2.buffers-&gt;bufs_indx + 1, fdno, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp=
;c-&gt;c2.buffers-&gt;read_tun_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tu=
n_max));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0leng =3D plen;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (leng &gt; 0)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_bufs[indx].offset =3D TUN=
_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt=
;c2.buffers-&gt;read_tun_bufs[indx].len =3D leng;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.buf), BPTR(&amp=
;c-&gt;c2.buffers-&gt;read_tun_bufs[indx]), leng);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.bufs[indx] =3D c-&gt;c2.buff=
ers-&gt;read_tun_bufs[indx];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_indx =3D indx;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0plen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0}<br>+}<br>+<br>+void read_incoming_tun(struct context *c)<br>+{<br>+=
 =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0read_incoming_tun_part2(c);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0read_incoming_tun_part3(c);<br>+}<br>+<br>=C2=A0/**<br>=C2=A0 * Drops=
 UDP packets which OS decided to route via tun.<br>=C2=A0 *<br>@@ -1469,7 +=
1585,7 @@ drop_if_recursive_routing(struct context *c, struct buffer *buf)<=
br>=C2=A0 */<br><br>=C2=A0void<br>-process_incoming_tun(struct context *c, =
struct link_socket *out_sock)<br>+process_incoming_tun_part2(struct context=
 *c, struct link_socket *out_sock)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0struct=
 gc_arena gc =3D gc_new();<br><br>@@ -1488,7 +1604,7 @@ process_incoming_tu=
n(struct context *c, struct link_socket *out_sock)<br>=C2=A0#endif<br><br>=
=C2=A0 =C2=A0 =C2=A0/* Show packet content */<br>- =C2=A0 =C2=A0dmsg(D_TUN_=
RW, &quot;TUN READ [%d]&quot;, BLEN(&amp;c-&gt;c2.buf));<br>+ =C2=A0 =C2=A0=
dmsg(D_TUN_RW, &quot;TUN READ [%d] [%d]&quot;, BLEN(&amp;c-&gt;c2.buf), c-&=
gt;c2.frame.buf.payload_size);<br><br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.buf.=
len &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -1512,7 +1628,9 @@ process_incom=
ing_tun(struct context *c, struct link_socket *out_sock)<br>=C2=A0 =C2=A0 =
=C2=A0}<br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.buf.len &gt; 0)<br>=C2=A0 =C2=
=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((c-&gt;c2.buffers =3D=3D NU=
LL) || (c-&gt;c2.buffers-&gt;flag_ciph !=3D -2)) {<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0encrypt_sign(c, true);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0{<=
br>@@ -1522,6 +1640,67 @@ process_incoming_tun(struct context *c, struct li=
nk_socket *out_sock)<br>=C2=A0 =C2=A0 =C2=A0gc_free(&amp;gc);<br>=C2=A0}<br=
><br>+void process_incoming_tun_part3(struct context *c, struct link_socket=
 *out_sock)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.buf.len &gt; 0)<br>+ =C2=
=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
c-&gt;c2.buffers-&gt;flag_ciph =3D -2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.=
len =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =3D =
BPTR(&amp;c-&gt;c2.buffers-&gt;read_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int plen =3D 0, fdno =3D c-&gt;c1.tuntap-&gt;fd;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl =3D 0, leng =3D (c-&gt;c2.bu=
ffers-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
((fdno &gt; 0) &amp;&amp; (leng &gt; 0))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
for (int x =3D 0; x &lt; leng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D c-&gt;c2.bufs[x];<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &=
quot;FWD BAT INPT 0 [%d] [%d] [%d] [%d] [%d]&quot;, x, fdno, BLEN(&amp;c-&g=
t;c2.buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tun_buf), BLEN(&amp;c-&gt;c2=
.bufs[x]));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0process_incoming_tun_part2(c, out_sock);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (BLEN(&amp;c-&gt;=
c2.buf) &lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.bufs[x].len =3D 0;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; leng; ++x)<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D c-&g=
t;c2.bufs[x].len;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (plen &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff_prepsize(tem=
p, &amp;plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.bufs[x]), temp, plen);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0temp +=3D plen; maxl +=3D (plen + 2);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (maxl &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.offset =
=3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D maxl;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.=
buf =3D c-&gt;c2.buffers-&gt;read_tun_max;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT INPT=
 1 [%d] [%d] [%d] [%d] [%d]&quot;, maxl, fdno, BLEN(&amp;c-&gt;c2.buf), BLE=
N(&amp;c-&gt;c2.buffers-&gt;read_tun_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;r=
ead_tun_max));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0encrypt_sign(c, true);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_indx=
 =3D -1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt=
;flag_ciph =3D -1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br=
>+ =C2=A0 =C2=A0else<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0bu=
f_reset(&amp;c-&gt;c2.to_link);<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+void pro=
cess_incoming_tun(struct context *c, struct link_socket *out_sock)<br>+{<br=
>+ =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0process_incoming_tun_part2(c, out_sock);<br>+ =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0process_incoming_tun_part3(c, out_sock);<br>+}<br>+<=
br>=C2=A0/**<br>=C2=A0 * Forges a IPv6 ICMP packet with a no route to host =
error code from the<br>=C2=A0 * IPv6 packet in buf and sends it directly ba=
ck to the client via the tun<br>@@ -1748,7 +1927,7 @@ process_outgoing_link=
(struct context *c, struct link_socket *sock)<br><br>=C2=A0 =C2=A0 =C2=A0pe=
rf_push(PERF_PROC_OUT_LINK);<br><br>- =C2=A0 =C2=A0if (c-&gt;c2.to_link.len=
 &gt; 0 &amp;&amp; c-&gt;c2.to_link.len &lt;=3D c-&gt;c2.frame.buf.payload_=
size)<br>+ =C2=A0 =C2=A0if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; (c-&gt;c=
2.to_link.len &lt;=3D c-&gt;c2.frame.buf.payload_size || c-&gt;c2.frame.bul=
k_size &gt; 0))<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Setup for call to send/sendto=
 which will send<br>@@ -1793,6 +1972,7 @@ process_outgoing_link(struct cont=
ext *c, struct link_socket *sock)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;W&quot;);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>+<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_LINK_RW, &quot;%s WRITE [%d] to %s:=
 %s&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0proto2ascii(sock-&gt;info.proto, sock-&gt;<a href=3D"http://info.af" tar=
get=3D"_blank">info.af</a>, true), BLEN(&amp;c-&gt;c2.to_link),<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0print_link_socket_ac=
tual(c-&gt;c2.to_link_addr, &amp;gc), PROTO_DUMP(&amp;c-&gt;c2.to_link, &am=
p;gc));<br>@@ -1892,7 +2072,7 @@ process_outgoing_link(struct context *c, s=
truct link_socket *sock)<br>=C2=A0 */<br><br>=C2=A0void<br>-process_outgoin=
g_tun(struct context *c, struct link_socket *in_sock)<br>+process_outgoing_=
tun_part2(struct context *c, struct link_socket *in_sock)<br>=C2=A0{<br>=C2=
=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 * Set up for write() call to TU=
N/TAP<br>@@ -1912,7 +2092,7 @@ process_outgoing_tun(struct context *c, stru=
ct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0process_ip_header(c, PIP_MS=
SFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIENT_NAT | PIP_OUTGOING,<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&amp;c-&gt;c2.to_tun, in_sock);<br><br>- =C2=A0 =C2=A0if (c-&gt;c2.to=
_tun.len &lt;=3D c-&gt;c2.frame.buf.payload_size)<br>+ =C2=A0 =C2=A0if (c-&=
gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payload_size || c-&gt;c2.frame.=
bulk_size &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * Write to TUN/TAP device.<b=
r>@@ -1925,7 +2105,8 @@ process_outgoing_tun(struct context *c, struct link=
_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprint=
f(stderr, &quot;w&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0#=
endif<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN WRITE [%d]&q=
uot;, BLEN(&amp;c-&gt;c2.to_tun));<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0dms=
g(D_TUN_RW, &quot;TUN WRITE [%d] [%d]&quot;, BLEN(&amp;c-&gt;c2.to_tun), c-=
&gt;c2.frame.buf.payload_size);<br><br>=C2=A0#ifdef PACKET_TRUNCATION_CHECK=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipv4_packet_size_verify(BPTR(&amp;c-&=
gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun), TUNNEL_TYPE(c-&gt;c1.tuntap),<br=
>@@ -1981,6 +2162,39 @@ process_outgoing_tun(struct context *c, struct link=
_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0perf_pop();<br>=C2=A0}<br><br>+voi=
d process_outgoing_tun_part3(struct context *c, struct link_socket *in_sock=
)<br>+{<br>+ =C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl =3D 0, plen =3D 0;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0int leng =3D BLEN(&amp;c-&gt;c2.buffers-&gt;send_tun_max);<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =3D BPTR(&amp;c-&gt;c2.buffers-&=
gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; =
TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff_postsize(temp, &amp;plen);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((leng &gt; 0) &amp;&amp; (plen &g=
t; 0) &amp;&amp; ((maxl + plen) &lt; leng))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0c-&gt;c2.to_tun =3D c-&gt;c2.buffers-&gt;to_tun_max;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.offset =3D TUN=
_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt=
;c2.to_tun.len =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0bcopy(temp, BPTR(&amp;c-&gt;c2.to_tun), plen);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp +=3D plen; maxl +=3D (plen +=
 2);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_I=
NFO, &quot;FWD BAT OUTP 1 [%d] [%d] [%d] [%d]&quot;, x, BLEN(&amp;c-&gt;c2.=
buf), BLEN(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.buffers-&gt;read_link_=
buf));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_=
outgoing_tun_part2(c, in_sock);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<=
br>+ =C2=A0 =C2=A0buf_reset(&amp;c-&gt;c2.to_tun);<br>+}<br>+<br>+void proc=
ess_outgoing_tun(struct context *c, struct link_socket *in_sock)<br>+{<br>+=
 =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0process_outgoing_tun_part2(c, in_sock);<br>+ =C2=A0 =C2=A0}<br=
>+ =C2=A0 =C2=A0process_outgoing_tun_part3(c, in_sock);<br>+}<br>+<br>=C2=
=A0void<br>=C2=A0pre_select(struct context *c)<br>=C2=A0{<br>diff --git a/s=
rc/openvpn/forward.h b/src/openvpn/forward.h<br>index d5641491..9fda1583 10=
0644<br>--- a/src/openvpn/forward.h<br>+++ b/src/openvpn/forward.h<br>@@ -7=
9,6 +79,8 @@ void pre_select(struct context *c);<br><br>=C2=A0void process_=
io(struct context *c, struct link_socket *sock);<br><br>+void xfer_io(struc=
t context *c, struct context *b);<br>+<br><br>=C2=A0/**********************=
************************************************/<br>=C2=A0/**<br>@@ -196,6=
 +198,8 @@ bool process_incoming_link_part1(struct context *c, struct link_=
socket_info *lsi<br>=C2=A0void process_incoming_link_part2(struct context *=
c, struct link_socket_info *lsi,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 const uint8_t *orig_buf);<br><br>+void process_incoming_link_part3(s=
truct context *c);<br>+<br>=C2=A0/**<br>=C2=A0 * Transfers \c float_sa data=
 extracted from an incoming DCO<br>=C2=A0 * PEER_FLOAT_NTF to \c out_osaddr=
 for later processing.<br>diff --git a/src/openvpn/init.c b/src/openvpn/ini=
t.c<br>index 40ae2c8c..bbdbad46 100644<br>--- a/src/openvpn/init.c<br>+++ b=
/src/openvpn/init.c<br>@@ -2971,6 +2971,10 @@ frame_finalize_options(struct=
 context *c, const struct options *o)<br>=C2=A0 =C2=A0 =C2=A0tailroom +=3D =
COMP_EXTRA_BUFFER(payload_size);<br>=C2=A0#endif<br><br>+ =C2=A0 =C2=A0if (=
frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0payload_size =
=3D frame-&gt;tun_mtu;<br>+ =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0fram=
e-&gt;buf.payload_size =3D payload_size;<br>=C2=A0 =C2=A0 =C2=A0frame-&gt;b=
uf.headroom =3D headroom;<br>=C2=A0 =C2=A0 =C2=A0frame-&gt;buf.tailroom =3D=
 tailroom;<br>@@ -3473,6 +3477,9 @@ do_init_frame_tls(struct context *c)<br=
>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.tls_multi)<br>=C2=A0 =C2=A0 =C2=A0{<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls_multi_init_finalize(c-&gt;c2.tls_mult=
i, c-&gt;options.ce.tls_mtu);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.=
frame.bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&=
gt;c2.tls_multi-&gt;opt.frame.buf.payload_size =3D c-&gt;c2.frame.tun_mtu;<=
br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSE=
RT(c-&gt;c2.tls_multi-&gt;opt.frame.buf.payload_size &lt;=3D c-&gt;c2.frame=
.buf.payload_size);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0frame_print(&amp;c=
-&gt;c2.tls_multi-&gt;opt.frame, D_MTU_INFO, &quot;Control Channel MTU parm=
s&quot;);<br><br>@@ -3536,6 +3543,14 @@ do_init_frame(struct context *c)<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.frame.extra_tun +=3D c-&gt;opti=
ons.ce.tun_mtu_extra;<br>=C2=A0 =C2=A0 =C2=A0}<br><br>+ =C2=A0 =C2=A0/*<br>=
+ =C2=A0 =C2=A0 * Adjust bulk size based on the --bulk-mode parameter.<br>+=
 =C2=A0 =C2=A0 */<br>+ =C2=A0 =C2=A0if (c-&gt;options.ce.bulk_mode)<br>+ =
=C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.frame.bulk_size =3D=
 c-&gt;options.ce.tun_mtu;<br>+ =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0=
/*<br>=C2=A0 =C2=A0 =C2=A0 * Fill in the blanks in the frame parameters str=
ucture,<br>=C2=A0 =C2=A0 =C2=A0 * make sure values are rational, etc.<br>@@=
 -3676,9 +3691,41 @@ init_context_buffers(const struct frame *frame)<br><br=
>=C2=A0 =C2=A0 =C2=A0size_t buf_size =3D BUF_SIZE(frame);<br><br>+ =C2=A0 =
=C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0siz=
e_t off_size =3D (frame-&gt;buf.headroom + TUN_BAT_OFF + frame-&gt;buf.tail=
room);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_size =3D BAT_SIZE(TUN_BAT_MAX, f=
rame-&gt;tun_mtu, off_size);<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0dms=
g(M_INFO, &quot;MEM NEW [%ld] [%d+%d+%d]&quot;, buf_size, frame-&gt;buf.hea=
droom, frame-&gt;buf.payload_size, frame-&gt;buf.tailroom);<br>+<br>=C2=A0 =
=C2=A0 =C2=A0b-&gt;read_link_buf =3D alloc_buf(buf_size);<br>=C2=A0 =C2=A0 =
=C2=A0b-&gt;read_tun_buf =3D alloc_buf(buf_size);<br><br>+ =C2=A0 =C2=A0if =
(frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =
=3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0size_t part_size =3D BUF_SIZE(frame);=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_bufs[x] =3D a=
lloc_buf(part_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;re=
ad_tun_bufs[x].offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0b-&gt;read_tun_bufs[x].len =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_max =3D alloc_buf(=
buf_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_max.offset =3D TU=
N_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_max.len =3D 0;<br=
>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;send_tun_max =3D alloc_buf(buf_siz=
e);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;send_tun_max.offset =3D TUN_BAT_O=
FF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;send_tun_max.len =3D 0;<br>+<br>+=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;to_tun_max =3D alloc_buf(buf_size);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;to_tun_max.offset =3D TUN_BAT_OFF;<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;to_tun_max.len =3D 0;<br>+ =C2=A0 =C2=A0}<=
br>+<br>+ =C2=A0 =C2=A0b-&gt;bufs_indx =3D -1;<br>+ =C2=A0 =C2=A0b-&gt;flag=
_ciph =3D -1;<br>+<br>=C2=A0 =C2=A0 =C2=A0b-&gt;aux_buf =3D alloc_buf(buf_s=
ize);<br><br>=C2=A0 =C2=A0 =C2=A0b-&gt;encrypt_buf =3D alloc_buf(buf_size);=
<br>@@ -3701,6 +3748,16 @@ free_context_buffers(struct context_buffers *b)<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;read_tun_buf);<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;aux_buf);<br><br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (b-&gt;to_tun_max.data) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;to_tun_max);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;send_tun_max);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;read_tun_max);<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; TUN_BA=
T_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;read_tun_b=
ufs[x]);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>+<br>=C2=A0#ifdef USE_COMP<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_buf(&amp;b-&gt;compress_buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0free_buf(&amp;b-&gt;decompress_buf);<br>diff --git a/src/openvpn/mtu=
.c b/src/openvpn/mtu.c<br>index a419e32d..7e35c837 100644<br>--- a/src/open=
vpn/mtu.c<br>+++ b/src/openvpn/mtu.c<br>@@ -41,9 +41,15 @@ void<br>=C2=A0al=
loc_buf_sock_tun(struct buffer *buf, const struct frame *frame)<br>=C2=A0{<=
br>=C2=A0 =C2=A0 =C2=A0/* allocate buffer for overlapped I/O */<br>- =C2=A0=
 =C2=A0*buf =3D alloc_buf(BUF_SIZE(frame));<br>+ =C2=A0 =C2=A0size_t alen =
=3D BUF_SIZE(frame);<br>+ =C2=A0 =C2=A0size_t blen =3D frame-&gt;buf.payloa=
d_size;<br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0alen =3D BAT_SIZE(TUN_BAT_MAX, frame-&gt;tun_mtu, TUN_BAT_=
OFF);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0blen =3D BAT_SIZE(TUN_BAT_MAX, frame-=
&gt;tun_mtu, TUN_BAT_NOP);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0*buf =3D a=
lloc_buf(alen);<br>=C2=A0 =C2=A0 =C2=A0ASSERT(buf_init(buf, frame-&gt;buf.h=
eadroom));<br>- =C2=A0 =C2=A0buf-&gt;len =3D frame-&gt;buf.payload_size;<br=
>+ =C2=A0 =C2=A0buf-&gt;len =3D blen;<br>=C2=A0 =C2=A0 =C2=A0ASSERT(buf_saf=
e(buf, 0));<br>=C2=A0}<br><br>diff --git a/src/openvpn/mtu.h b/src/openvpn/=
mtu.h<br>index 925ef0bf..eb799fb3 100644<br>--- a/src/openvpn/mtu.h<br>+++ =
b/src/openvpn/mtu.h<br>@@ -58,6 +58,14 @@<br>=C2=A0 */<br>=C2=A0#define TUN=
_MTU_MIN 100<br><br>+/*<br>+ * Bulk mode static define values.<br>+ */<br>+=
#define TUN_BAT_MIN =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>+#define TUN_BAT_MAX =
=C2=A0 =C2=A0 =C2=A0 =C2=A09<br>+#define TUN_BAT_OFF =C2=A0 =C2=A0 =C2=A0 =
=C2=A0256<br>+#define TUN_BAT_NOP =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>+<br>=C2=
=A0/*<br>=C2=A0 * Default MTU of network over which tunnel data will pass b=
y TCP/UDP.<br>=C2=A0 */<br>@@ -152,6 +160,10 @@ struct frame<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0* =C2=A0 which defaults to 0 for tun and 32<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 (\c TAP_MTU_EXTRA_DEFAULT) for tap.<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 */<br>+<br>+ =C2=A0 =C2=A0int bulk_size=
; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt; Signal to the ini=
t frame function<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 to all=
ow for bulk mode TCP transfers.<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 *=
 =C2=A0 */<br>=C2=A0};<br><br>=C2=A0/* Forward declarations, to prevent inc=
ludes */<br>@@ -171,6 +183,7 @@ struct options;<br>=C2=A0 * larger than the=
 headroom.<br>=C2=A0 */<br>=C2=A0#define BUF_SIZE(f) ((f)-&gt;buf.headroom =
+ (f)-&gt;buf.payload_size + (f)-&gt;buf.tailroom)<br>+#define BAT_SIZE(a, =
b, c) ((a * b) + c)<br><br>=C2=A0/*<br>=C2=A0 * Function prototypes.<br>dif=
f --git a/src/openvpn/multi.c b/src/openvpn/multi.c<br>index e1ce32ab..9e08=
9703 100644<br>--- a/src/openvpn/multi.c<br>+++ b/src/openvpn/multi.c<br>@@=
 -3414,6 +3414,7 @@ multi_process_incoming_link(struct multi_context *m, st=
ruct multi_instance *inst<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0process_incoming_link_part2(c, lsi, orig_buf);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_link_part3(c)=
;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perf_pop();<br><br>@@ -3558,9 +3559,7 @@ mul=
ti_process_incoming_tun(struct multi_context *m, const unsigned int mpp_fla=
gs<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int dev_type =3D TUNNEL_TYPE(=
m-&gt;top.c1.tuntap);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int16_t vid =3D =
0;<br><br>-#ifdef MULTI_DEBUG_EVENT_LOOP<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0pr=
intf(&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));<br=
>-#endif<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_MULTI_DEBUG, &quot;TUN -&gt;=
 TCP/UDP [%d]&quot;, BLEN(&amp;m-&gt;top.c2.buf));<br><br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (m-&gt;pending)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<=
br>@@ -3610,6 +3609,8 @@ multi_process_incoming_tun(struct multi_context *m=
, const unsigned int mpp_flags<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0/* transfer packet pointer from top-level context buffer to insta=
nce */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D m-&gt;top.c2.buf;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* todo determine if to call this (multi_proces=
s_incoming_tun) for each bulk item read? */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xf=
er_io(c, &amp;m-&gt;top);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>diff --git a/src/openvpn/openvpn.h b/src/openvpn/open=
vpn.h<br>index cd99cd40..21fa8967 100644<br>--- a/src/openvpn/openvpn.h<br>=
+++ b/src/openvpn/openvpn.h<br>@@ -112,6 +112,14 @@ struct context_buffers<=
br>=C2=A0 =C2=A0 =C2=A0 */<br>=C2=A0 =C2=A0 =C2=A0struct buffer read_link_b=
uf;<br>=C2=A0 =C2=A0 =C2=A0struct buffer read_tun_buf;<br>+<br>+ =C2=A0 =C2=
=A0struct buffer read_tun_bufs[TUN_BAT_MAX];<br>+ =C2=A0 =C2=A0struct buffe=
r read_tun_max;<br>+ =C2=A0 =C2=A0struct buffer send_tun_max;<br>+ =C2=A0 =
=C2=A0struct buffer to_tun_max;<br>+<br>+ =C2=A0 =C2=A0int bufs_indx;<br>+ =
=C2=A0 =C2=A0int flag_ciph;<br>=C2=A0};<br><br>=C2=A0/*<br>@@ -376,6 +384,8=
 @@ struct context_2<br>=C2=A0 =C2=A0 =C2=A0struct buffer to_tun;<br>=C2=A0=
 =C2=A0 =C2=A0struct buffer to_link;<br><br>+ =C2=A0 =C2=A0struct buffer bu=
fs[TUN_BAT_MAX];<br>+<br>=C2=A0 =C2=A0 =C2=A0/* should we print R|W|r|w to =
console on packet transfers? */<br>=C2=A0 =C2=A0 =C2=A0bool log_rw;<br><br>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>index c54032d=
8..041d17d0 100644<br>--- a/src/openvpn/options.c<br>+++ b/src/openvpn/opti=
ons.c<br>@@ -304,6 +304,7 @@ static const char usage_message[] =3D<br>=C2=
=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;maybe&#39; -- Use per-route hints\n&quot;<br>=C2=A0 =C2=
=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0&#39;yes&#39; =C2=A0 -- Always DF (Don&#39;t Fragment)\n&quot;<br>=C2=
=A0 =C2=A0 =C2=A0&quot;--mtu-test =C2=A0 =C2=A0 =C2=A0: Empirically measure=
 and report MTU.\n&quot;<br>+ =C2=A0 =C2=A0&quot;--bulk-mode =C2=A0 =C2=A0 =
: Use bulk TUN/TCP reads/writes.\n&quot;<br>=C2=A0#ifdef ENABLE_FRAGMENT<br=
>=C2=A0 =C2=A0 =C2=A0&quot;--fragment max =C2=A0: Enable internal datagram =
fragmentation so that no UDP\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0datagrams are sent w=
hich are larger than max bytes.\n&quot;<br>@@ -3005,6 +3006,9 @@ options_po=
stprocess_mutate_ce(struct options *o, struct connection_entry *ce)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;tun_mtu_extra_defined =
=3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;tun_mtu=
_extra =3D TAP_MTU_EXTRA_DEFAULT;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; ce=
-&gt;proto !=3D PROTO_TCP_SERVER &amp;&amp; ce-&gt;proto !=3D PROTO_TCP_CLI=
ENT) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;bulk_mode =3D f=
alse;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=
=A0 =C2=A0 =C2=A0/*<br>@@ -9926,6 +9930,10 @@ add_option(struct options *op=
tions, char *p[], bool is_inline, const char *file,<br>=C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0else if (streq(p[0], &quot;bul=
k-mode&quot;))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0options-=
&gt;ce.bulk_mode =3D true;<br>+ =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0else<=
br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>dif=
f --git a/src/openvpn/options.h b/src/openvpn/options.h<br>index 38e67c8d..=
d1b0586d 100644<br>--- a/src/openvpn/options.h<br>+++ b/src/openvpn/options=
.h<br>@@ -174,6 +174,9 @@ struct connection_entry<br><br>=C2=A0 =C2=A0 =C2=
=A0/* Allow only client that support resending the wrapped client key */<br=
>=C2=A0 =C2=A0 =C2=A0bool tls_crypt_v2_force_cookie;<br>+<br>+ =C2=A0 =C2=
=A0/* Bulk mode allows for multiple tun reads + larger tcp writes */<br>+ =
=C2=A0 =C2=A0bool bulk_mode;<br>=C2=A0};<br><br>=C2=A0struct remote_entry<b=
r>--<br>2.39.5 (Apple Git-154)<br></div><div><br></div><div><br></div><div>=
<br></div></div><br><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gm=
ail_attr">On Thu, Aug 7, 2025 at 2:29=E2=80=AFPM Jon Chiappetta &lt;<a href=
=3D"mailto:root@...2904..." target=3D"_blank">root@...2904...</a>&gt; wrote=
:<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.=
8ex;border-left-width:1px;border-left-style:solid;border-left-color:rgb(204=
,204,204);padding-left:1ex"><div dir=3D"ltr">Thanks to Gert&#39;s help on t=
his, I was able to finally configure and compile and run and test the bulk =
mode changes against the latest git source code to ensure everything still =
works correctly.=C2=A0<div><br></div><div>I also fixed up some=C2=A0other i=
ssues like properly freeing the extra buffer allocations and removing the u=
nneeded batched data prefixes and converting a remaining while loop to a ma=
x limited for loop and properly resetting the outgoing tun buffer pointer a=
t the end of the write method when finished.=C2=A0</div><div><br></div><div=
>Thanks,<br></div><div>Jon C</div><div><br></div><div><div>Example updated =
pull request:=C2=A0<a href=3D"https://github.com/OpenVPN/openvpn/pull/814/f=
iles" target=3D"_blank">https://github.com/OpenVPN/openvpn/pull/814/files</=
a></div><div><br></div>git formatted diff patch:</div><div><br></div><div>F=
rom 985e88a9af26a39554f113f37ee18032a2f41c3e Mon Sep 17 00:00:00 2001<br>Fr=
om: Jon Chiappetta &lt;<a href=3D"mailto:root@...2904..." target=3D"_blank"=
>root@...2904...</a>&gt;<br>Date: Wed, 6 Aug 2025 16:33:18 -0400<br>Subject=
: [PATCH] bulk mode<br><br>---<br>=C2=A0src/openvpn/forward.c | 217 +++++++=
+++++++++++++++++++++++++++++++++--<br>=C2=A0src/openvpn/forward.h | =C2=A0=
 4 +<br>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0| =C2=A056 +++++++++++<br>=C2=
=A0src/openvpn/mtu.c =C2=A0 =C2=A0 | =C2=A010 +-<br>=C2=A0src/openvpn/mtu.h=
 =C2=A0 =C2=A0 | =C2=A013 +++<br>=C2=A0src/openvpn/multi.c =C2=A0 | =C2=A0 =
7 +-<br>=C2=A0src/openvpn/openvpn.h | =C2=A010 ++<br>=C2=A0src/openvpn/opti=
ons.c | =C2=A0 8 ++<br>=C2=A0src/openvpn/options.h | =C2=A0 3 +<br>=C2=A09 =
files changed, 316 insertions(+), 12 deletions(-)<br><br>diff --git a/src/o=
penvpn/forward.c b/src/openvpn/forward.c<br>index 75ca9d5c..d9a98607 100644=
<br>--- a/src/openvpn/forward.c<br>+++ b/src/openvpn/forward.c<br>@@ -46,6 =
+46,9 @@<br><br>=C2=A0#include &quot;mstats.h&quot;<br><br>+#include &lt;sy=
s/select.h&gt;<br>+#include &lt;sys/time.h&gt;<br>+<br>=C2=A0counter_type l=
ink_read_bytes_global; =C2=A0/* GLOBAL */<br>=C2=A0counter_type link_write_=
bytes_global; /* GLOBAL */<br><br>@@ -78,6 +81,32 @@ show_wait_status(struc=
t context *c)<br><br>=C2=A0#endif /* ifdef ENABLE_DEBUG */<br><br>+bool che=
ck_bulk_mode(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0if ((c-&gt;c2.frame=
.bulk_size &gt; 0) &amp;&amp; (c-&gt;c1.tuntap !=3D NULL) &amp;&amp; (c-&gt=
;c2.buffers !=3D NULL))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0return true;<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0return false;<br>+}<b=
r>+<br>+void xfer_io(struct context *c, struct context *b)<br>+{<br>+ =C2=
=A0 =C2=A0int plen =3D 0;<br>+ =C2=A0 =C2=A0if (check_bulk_mode(b))<br>+ =
=C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D (b-&gt;c2.buffe=
rs-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x =
&lt; leng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0plen =3D BLEN(&amp;b-&gt;c2.bufs[x]);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (plen &lt; 1) { c-&gt;c2.bufs[x].len =3D =
0; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else { c-&gt;c2.bufs[x] =
=3D b-&gt;c2.bufs[x]; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_indx =3D b-&gt;c2.buffers-&gt;bu=
fs_indx;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;c2.buffers-&gt;bufs_indx =3D=
 -1;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=C2=A0static void<br>=C2=A0check_tls=
_errors_co(struct context *c)<br>=C2=A0{<br>@@ -605,6 +634,21 @@ buffer_tur=
nover(const uint8_t *orig_buf, struct buffer *dest_stub, struct buffer<br>=
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><br>+uint8_t *buff_prepsize(uint8_t *bu=
ff, int *size)<br>+{<br>+ =C2=A0 =C2=A0buff[0] =3D ((*size &gt;&gt; 8) &amp=
; 0xff);<br>+ =C2=A0 =C2=A0buff[1] =3D ((*size &gt;&gt; 0) &amp; 0xff);<br>=
+ =C2=A0 =C2=A0buff +=3D 2;<br>+ =C2=A0 =C2=A0return buff;<br>+}<br>+<br>+u=
int8_t *buff_postsize(uint8_t *buff, int *size)<br>+{<br>+ =C2=A0 =C2=A0*si=
ze =3D ((buff[0] &lt;&lt; 8) + (buff[1] &lt;&lt; 0));<br>+ =C2=A0 =C2=A0buf=
f +=3D 2;<br>+ =C2=A0 =C2=A0return buff;<br>+}<br>+<br>=C2=A0/*<br>=C2=A0 *=
 Compress, fragment, encrypt and HMAC-sign an outgoing packet.<br>=C2=A0 * =
Input: c-&gt;c2.buf<br>@@ -1031,6 +1075,7 @@ process_incoming_link_part1(st=
ruct context *c, struct link_socket_info *lsi, boo<br>=C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0fprintf(stderr, &quot;R&quot;);<br>=C2=A0 =C2=A0 =C2=A0}<br>=
=C2=A0#endif<br>+<br>=C2=A0 =C2=A0 =C2=A0msg(D_LINK_RW, &quot;%s READ [%d] =
from %s: %s&quot;, proto2ascii(lsi-&gt;proto, lsi-&gt;af, true),<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0BLEN(&amp;c-&gt;c2.buf), print_link_socket_actua=
l(&amp;c-&gt;c2.from, &amp;gc), PROTO_DUMP(&amp;c-&gt;c2.buf, &amp;gc));<br=
><br>@@ -1211,6 +1256,23 @@ process_incoming_link_part2(struct context *c, =
struct link_socket_info *lsi,<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><br>+v=
oid process_incoming_link_part3(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0=
int leng =3D BLEN(&amp;c-&gt;c2.to_tun);<br>+ =C2=A0 =C2=A0if (leng &gt; 0)=
<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (check_bulk_mode(c)=
)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0c-&gt;c2.buffers-&gt;send_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;send_tun_max.len=
 =3D leng;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-=
&gt;c2.to_tun), BPTR(&amp;c-&gt;c2.buffers-&gt;send_tun_max), leng);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT LINK =
0 [%d] [%d] [%d] [%d] [%d]&quot;, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;=
c2.to_tun), BLEN(&amp;c-&gt;c2.buffers-&gt;read_link_buf), BLEN(&amp;c-&gt;=
c2.buffers-&gt;read_link_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;send_tun_max)=
);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.offset +=
=3D 2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf.offset +=
=3D 2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=
=C2=A0static void<br>=C2=A0process_incoming_link(struct context *c, struct =
link_socket *sock)<br>=C2=A0{<br>@@ -1221,6 +1283,7 @@ process_incoming_lin=
k(struct context *c, struct link_socket *sock)<br><br>=C2=A0 =C2=A0 =C2=A0p=
rocess_incoming_link_part1(c, lsi, false);<br>=C2=A0 =C2=A0 =C2=A0process_i=
ncoming_link_part2(c, lsi, orig_buf);<br>+ =C2=A0 =C2=A0process_incoming_li=
nk_part3(c);<br><br>=C2=A0 =C2=A0 =C2=A0perf_pop();<br>=C2=A0}<br>@@ -1321,=
7 +1384,7 @@ process_incoming_dco(struct context *c)<br>=C2=A0 */<br><br>=
=C2=A0void<br>-read_incoming_tun(struct context *c)<br>+read_incoming_tun_p=
art2(struct context *c)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=
=A0 =C2=A0 * Setup for read() call on TUN/TAP device.<br>@@ -1382,6 +1445,5=
5 @@ read_incoming_tun(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0perf_pop()=
;<br>=C2=A0}<br><br>+void read_incoming_tun_part3(struct context *c)<br>+{<=
br>+ =C2=A0 =C2=A0fd_set rfds;<br>+ =C2=A0 =C2=A0struct timeval timo;<br>+ =
=C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0int plen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int fdno =3D =
c-&gt;c1.tuntap-&gt;fd;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x=
 &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0int indx =3D (c-&gt;c2.buffers-&gt;bufs_indx + 1);<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (indx &gt;=3D TUN_BAT_MIN) { =
break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (leng &lt; 1)<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FD_ZERO(&amp;rfds);<br>+ =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0FD_SET(fdno, &amp;rfds);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timo.tv_sec =3D 0;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0timo.tv_usec =3D 0;<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0select(fdno+1, &am=
p;rfds, NULL, NULL, &amp;timo);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0if (FD_ISSET(fdno, &amp;rfds))<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0read_incoming_tun_part2(c);<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D BLEN=
(&amp;c-&gt;c2.buf);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT REA=
D 0 [%d] [%d] [%d] [%d] [%d]&quot;, c-&gt;c2.buffers-&gt;bufs_indx + 1, fdn=
o, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tun_buf), B=
LEN(&amp;c-&gt;c2.buffers-&gt;read_tun_max));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0leng =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (leng &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt=
;read_tun_bufs[indx].offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_bufs[indx].len=
 =3D leng;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcop=
y(BPTR(&amp;c-&gt;c2.buf), BPTR(&amp;c-&gt;c2.buffers-&gt;read_tun_bufs[ind=
x]), leng);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&=
gt;c2.bufs[indx] =3D c-&gt;c2.buffers-&gt;read_tun_bufs[indx];<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_i=
ndx =3D indx;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { break;=
 }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D 0;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+void read_incoming=
_tun(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_siz=
e &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0read_incoming_tun_part2(c);<=
br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0read_incoming_tun_part3(c);<br>+}<br>=
+<br>=C2=A0/**<br>=C2=A0 * Drops UDP packets which OS decided to route via =
tun.<br>=C2=A0 *<br>@@ -1469,7 +1581,7 @@ drop_if_recursive_routing(struct =
context *c, struct buffer *buf)<br>=C2=A0 */<br><br>=C2=A0void<br>-process_=
incoming_tun(struct context *c, struct link_socket *out_sock)<br>+process_i=
ncoming_tun_part2(struct context *c, struct link_socket *out_sock)<br>=C2=
=A0{<br>=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<br><br>@@ -148=
8,7 +1600,7 @@ process_incoming_tun(struct context *c, struct link_socket *=
out_sock)<br>=C2=A0#endif<br><br>=C2=A0 =C2=A0 =C2=A0/* Show packet content=
 */<br>- =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN READ [%d]&quot;, BLEN(&amp;c=
-&gt;c2.buf));<br>+ =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN READ [%d] [%d]&qu=
ot;, BLEN(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);<br><br>=C2=
=A0 =C2=A0 =C2=A0if (c-&gt;c2.buf.len &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>@=
@ -1512,7 +1624,9 @@ process_incoming_tun(struct context *c, struct link_so=
cket *out_sock)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c=
2.buf.len &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
if ((c-&gt;c2.buffers =3D=3D NULL) || (c-&gt;c2.buffers-&gt;flag_ciph !=3D =
-2)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encrypt_sign(c, true);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0e=
lse<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -1522,6 +1636,60 @@ process_incoming_tun=
(struct context *c, struct link_socket *out_sock)<br>=C2=A0 =C2=A0 =C2=A0gc=
_free(&amp;gc);<br>=C2=A0}<br><br>+void process_incoming_tun_part3(struct c=
ontext *c, struct link_socket *out_sock)<br>+{<br>+ =C2=A0 =C2=A0if (check_=
bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.=
buffers-&gt;flag_ciph =3D -2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buff=
ers-&gt;read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0uint8_t *temp =3D BPTR(&amp;c-&gt;c2.buffers-&gt;read_tun_max);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0int plen =3D 0, fdno =3D c-&gt;c1.tuntap-&gt;fd;=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl =3D 0, leng =3D (c-&gt;c2.buffers=
-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((fdno &gt; 0) &amp=
;&amp; (leng &gt; 0))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; leng; ++x)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D c-&gt;c2.bufs[x];<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT INPT =
0 [%d] [%d] [%d] [%d] [%d]&quot;, x, fdno, BLEN(&amp;c-&gt;c2.buf), BLEN(&a=
mp;c-&gt;c2.buffers-&gt;read_tun_buf), BLEN(&amp;c-&gt;c2.bufs[x]));<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_tun=
_part2(c, out_sock);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0if (BLEN(&amp;c-&gt;c2.buf) &lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.bufs[x].len =3D 0;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =
=3D 0; x &lt; leng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D c-&gt;c2=
.bufs[x].len;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0i=
f (plen &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0temp =3D buff_prepsize(temp, &amp;plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.bu=
fs[x]), temp, plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0temp +=3D plen; maxl +=3D (plen + 2);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (max=
l &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_=
max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D maxl;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D c-&gt;c2.b=
uffers-&gt;read_tun_max;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT INPT 1 [%d] [%d] [%d] [%d] [%d]&quot=
;, maxl, fdno, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read=
_tun_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tun_max));<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encrypt_sign(c, true);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0=
}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_indx =3D -1;<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;flag_ciph =3D -1;<br>+ =
=C2=A0 =C2=A0}<br>+}<br>+<br>+void process_incoming_tun(struct context *c, =
struct link_socket *out_sock)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.frame.bu=
lk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_tun_p=
art2(c, out_sock);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0process_incoming_t=
un_part3(c, out_sock);<br>+}<br>+<br>=C2=A0/**<br>=C2=A0 * Forges a IPv6 IC=
MP packet with a no route to host error code from the<br>=C2=A0 * IPv6 pack=
et in buf and sends it directly back to the client via the tun<br>@@ -1748,=
7 +1916,7 @@ process_outgoing_link(struct context *c, struct link_socket *s=
ock)<br><br>=C2=A0 =C2=A0 =C2=A0perf_push(PERF_PROC_OUT_LINK);<br><br>- =C2=
=A0 =C2=A0if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; c-&gt;c2.to_link.len &=
lt;=3D c-&gt;c2.frame.buf.payload_size)<br>+ =C2=A0 =C2=A0if (c-&gt;c2.to_l=
ink.len &gt; 0 &amp;&amp; (c-&gt;c2.to_link.len &lt;=3D c-&gt;c2.frame.buf.=
payload_size || c-&gt;c2.frame.bulk_size &gt; 0))<br>=C2=A0 =C2=A0 =C2=A0{<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 * Setup for call to send/sendto which will send<br>@@ -1793,6 +1961,7 @=
@ process_outgoing_link(struct context *c, struct link_socket *sock)<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, =
&quot;W&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=
=A0#endif<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_LIN=
K_RW, &quot;%s WRITE [%d] to %s: %s&quot;,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proto2ascii(sock-&gt;info.proto, sock-&gt=
;<a href=3D"http://info.af" target=3D"_blank">info.af</a>, true), BLEN(&amp=
;c-&gt;c2.to_link),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0print_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc), PROTO_D=
UMP(&amp;c-&gt;c2.to_link, &amp;gc));<br>@@ -1892,7 +2061,7 @@ process_outg=
oing_link(struct context *c, struct link_socket *sock)<br>=C2=A0 */<br><br>=
=C2=A0void<br>-process_outgoing_tun(struct context *c, struct link_socket *=
in_sock)<br>+process_outgoing_tun_part2(struct context *c, struct link_sock=
et *in_sock)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 *=
 Set up for write() call to TUN/TAP<br>@@ -1912,7 +2081,7 @@ process_outgoi=
ng_tun(struct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=
=A0process_ip_header(c, PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIPV4_CLIE=
NT_NAT | PIP_OUTGOING,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;c2.to_tun, in_sock);<br><br>- =
=C2=A0 =C2=A0if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payload_siz=
e)<br>+ =C2=A0 =C2=A0if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.pay=
load_size || c-&gt;c2.frame.bulk_size &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
* Write to TUN/TAP device.<br>@@ -1925,7 +2094,8 @@ process_outgoing_tun(st=
ruct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;w&quot;);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0dmsg(=
D_TUN_RW, &quot;TUN WRITE [%d]&quot;, BLEN(&amp;c-&gt;c2.to_tun));<br>+<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN WRITE [%d] [%d]&quot;=
, BLEN(&amp;c-&gt;c2.to_tun), c-&gt;c2.frame.buf.payload_size);<br><br>=C2=
=A0#ifdef PACKET_TRUNCATION_CHECK<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ipv4=
_packet_size_verify(BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun),=
 TUNNEL_TYPE(c-&gt;c1.tuntap),<br>@@ -1981,6 +2151,39 @@ process_outgoing_t=
un(struct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=A0p=
erf_pop();<br>=C2=A0}<br><br>+void process_outgoing_tun_part3(struct contex=
t *c, struct link_socket *in_sock)<br>+{<br>+ =C2=A0 =C2=A0if (check_bulk_m=
ode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl =3D 0,=
 plen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D BLEN(&amp;c-&gt;c=
2.buffers-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =
=3D BPTR(&amp;c-&gt;c2.buffers-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0for (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff_postsi=
ze(temp, &amp;plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((len=
g &gt; 0) &amp;&amp; (plen &gt; 0) &amp;&amp; ((maxl + plen) &lt; leng))<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun =3D c-&gt;c2.buffers-&gt;to_=
tun_max;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;=
c2.to_tun.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.len =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(temp, BPTR(&amp;c-&gt;c2.to_tun), =
plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp +=
=3D plen; maxl +=3D (plen + 2);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT OUTP 1 [%d] [%d] [%d] [%d]&qu=
ot;, x, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&g=
t;c2.buffers-&gt;read_link_buf));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0process_outgoing_tun_part2(c, in_sock);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_reset(&amp;c-&gt;c2.to_tun);<br=
>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+void process_outgoing_tun(struct context *=
c, struct link_socket *in_sock)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c2.frame.=
bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0process_outgoing_tun=
_part2(c, in_sock);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0process_outgoing_=
tun_part3(c, in_sock);<br>+}<br>+<br>=C2=A0void<br>=C2=A0pre_select(struct =
context *c)<br>=C2=A0{<br>diff --git a/src/openvpn/forward.h b/src/openvpn/=
forward.h<br>index d5641491..9fda1583 100644<br>--- a/src/openvpn/forward.h=
<br>+++ b/src/openvpn/forward.h<br>@@ -79,6 +79,8 @@ void pre_select(struct=
 context *c);<br><br>=C2=A0void process_io(struct context *c, struct link_s=
ocket *sock);<br><br>+void xfer_io(struct context *c, struct context *b);<b=
r>+<br><br>=C2=A0/*********************************************************=
*************/<br>=C2=A0/**<br>@@ -196,6 +198,8 @@ bool process_incoming_li=
nk_part1(struct context *c, struct link_socket_info *lsi<br>=C2=A0void proc=
ess_incoming_link_part2(struct context *c, struct link_socket_info *lsi,<br=
>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 const uint8_t *orig_buf);<br>=
<br>+void process_incoming_link_part3(struct context *c);<br>+<br>=C2=A0/**=
<br>=C2=A0 * Transfers \c float_sa data extracted from an incoming DCO<br>=
=C2=A0 * PEER_FLOAT_NTF to \c out_osaddr for later processing.<br>diff --gi=
t a/src/openvpn/init.c b/src/openvpn/init.c<br>index 40ae2c8c..0849dfce 100=
644<br>--- a/src/openvpn/init.c<br>+++ b/src/openvpn/init.c<br>@@ -2971,6 +=
2971,10 @@ frame_finalize_options(struct context *c, const struct options *=
o)<br>=C2=A0 =C2=A0 =C2=A0tailroom +=3D COMP_EXTRA_BUFFER(payload_size);<br=
>=C2=A0#endif<br><br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0payload_size =3D frame-&gt;tun_mtu;<br>+ =C2=A0 =
=C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0frame-&gt;buf.payload_size =3D payload_=
size;<br>=C2=A0 =C2=A0 =C2=A0frame-&gt;buf.headroom =3D headroom;<br>=C2=A0=
 =C2=A0 =C2=A0frame-&gt;buf.tailroom =3D tailroom;<br>@@ -3473,6 +3477,9 @@=
 do_init_frame_tls(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.t=
ls_multi)<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0tls=
_multi_init_finalize(c-&gt;c2.tls_multi, c-&gt;options.ce.tls_mtu);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.frame.bulk_size &gt; 0) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.tls_multi-&gt;opt.frame.buf.=
payload_size =3D c-&gt;c2.frame.tun_mtu;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ASSERT(c-&gt;c2.tls_multi-&gt;opt.fram=
e.buf.payload_size &lt;=3D c-&gt;c2.frame.buf.payload_size);<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0frame_print(&amp;c-&gt;c2.tls_multi-&gt;opt.frame, =
D_MTU_INFO, &quot;Control Channel MTU parms&quot;);<br><br>@@ -3536,6 +3543=
,14 @@ do_init_frame(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c2.frame.extra_tun +=3D c-&gt;options.ce.tun_mtu_extra;<br>=C2=A0 =
=C2=A0 =C2=A0}<br><br>+ =C2=A0 =C2=A0/*<br>+ =C2=A0 =C2=A0 * Adjust bulk si=
ze based on the --bulk-mode parameter.<br>+ =C2=A0 =C2=A0 */<br>+ =C2=A0 =
=C2=A0if (c-&gt;options.ce.bulk_mode)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0c-&gt;c2.frame.bulk_size =3D c-&gt;options.ce.tun_mtu;<br>=
+ =C2=A0 =C2=A0}<br>+<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 * F=
ill in the blanks in the frame parameters structure,<br>=C2=A0 =C2=A0 =C2=
=A0 * make sure values are rational, etc.<br>@@ -3676,9 +3691,40 @@ init_co=
ntext_buffers(const struct frame *frame)<br><br>=C2=A0 =C2=A0 =C2=A0size_t =
buf_size =3D BUF_SIZE(frame);<br><br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size=
 &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0buf_size =3D BAT_SIZE(TUN_BAT_MA=
X, frame-&gt;tun_mtu, frame-&gt;buf.headroom + frame-&gt;buf.tailroom);<br>=
+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0dmsg(M_INFO, &quot;MEM NEW [%ld] [%=
d+%d+%d]&quot;, buf_size, frame-&gt;buf.headroom, frame-&gt;buf.payload_siz=
e, frame-&gt;buf.tailroom);<br>+<br>=C2=A0 =C2=A0 =C2=A0b-&gt;read_link_buf=
 =3D alloc_buf(buf_size);<br>=C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_buf =3D all=
oc_buf(buf_size);<br><br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0size_t part_size =3D BUF_SIZE(frame);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0b-&gt;read_tun_bufs[x] =3D alloc_buf(part_size);<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_bufs[x].offset =3D TUN=
_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;read_tun_bufs=
[x].len =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0b-&gt;read_tun_max =3D alloc_buf(buf_size);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0b-&gt;read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0b-&gt;read_tun_max.len =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0b-&gt;send_tun_max =3D alloc_buf(buf_size);<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0b-&gt;send_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0b-&gt;send_tun_max.len =3D 0;<br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
-&gt;to_tun_max =3D alloc_buf(buf_size);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-=
&gt;to_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&g=
t;to_tun_max.len =3D 0;<br>+ =C2=A0 =C2=A0}<br>+<br>+ =C2=A0 =C2=A0b-&gt;bu=
fs_indx =3D -1;<br>+ =C2=A0 =C2=A0b-&gt;flag_ciph =3D -1;<br>+<br>=C2=A0 =
=C2=A0 =C2=A0b-&gt;aux_buf =3D alloc_buf(buf_size);<br><br>=C2=A0 =C2=A0 =
=C2=A0b-&gt;encrypt_buf =3D alloc_buf(buf_size);<br>@@ -3701,6 +3747,16 @@ =
free_context_buffers(struct context_buffers *b)<br>=C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_buf(&amp;b-&gt;read_tun_buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0free_buf(&amp;b-&gt;aux_buf);<br><br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if=
 (b-&gt;to_tun_max.data) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fr=
ee_buf(&amp;b-&gt;to_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0free_buf(&amp;b-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0free_buf(&amp;b-&gt;read_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt;read_tun_bufs[x]);<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+<br>=
=C2=A0#ifdef USE_COMP<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-=
&gt;compress_buf);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0free_buf(&amp;b-&gt=
;decompress_buf);<br>diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c<br>=
index a419e32d..7e35c837 100644<br>--- a/src/openvpn/mtu.c<br>+++ b/src/ope=
nvpn/mtu.c<br>@@ -41,9 +41,15 @@ void<br>=C2=A0alloc_buf_sock_tun(struct bu=
ffer *buf, const struct frame *frame)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/* =
allocate buffer for overlapped I/O */<br>- =C2=A0 =C2=A0*buf =3D alloc_buf(=
BUF_SIZE(frame));<br>+ =C2=A0 =C2=A0size_t alen =3D BUF_SIZE(frame);<br>+ =
=C2=A0 =C2=A0size_t blen =3D frame-&gt;buf.payload_size;<br>+ =C2=A0 =C2=A0=
if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0alen =3D =
BAT_SIZE(TUN_BAT_MAX, frame-&gt;tun_mtu, TUN_BAT_OFF);<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0blen =3D BAT_SIZE(TUN_BAT_MAX, frame-&gt;tun_mtu, TUN_BAT_NOP)=
;<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0*buf =3D alloc_buf(alen);<br>=C2=A0=
 =C2=A0 =C2=A0ASSERT(buf_init(buf, frame-&gt;buf.headroom));<br>- =C2=A0 =
=C2=A0buf-&gt;len =3D frame-&gt;buf.payload_size;<br>+ =C2=A0 =C2=A0buf-&gt=
;len =3D blen;<br>=C2=A0 =C2=A0 =C2=A0ASSERT(buf_safe(buf, 0));<br>=C2=A0}<=
br><br>diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h<br>index 925ef0bf=
..eb799fb3 100644<br>--- a/src/openvpn/mtu.h<br>+++ b/src/openvpn/mtu.h<br>=
@@ -58,6 +58,14 @@<br>=C2=A0 */<br>=C2=A0#define TUN_MTU_MIN 100<br><br>+/*=
<br>+ * Bulk mode static define values.<br>+ */<br>+#define TUN_BAT_MIN =C2=
=A0 =C2=A0 =C2=A0 =C2=A06<br>+#define TUN_BAT_MAX =C2=A0 =C2=A0 =C2=A0 =C2=
=A09<br>+#define TUN_BAT_OFF =C2=A0 =C2=A0 =C2=A0 =C2=A0256<br>+#define TUN=
_BAT_NOP =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>+<br>=C2=A0/*<br>=C2=A0 * Default =
MTU of network over which tunnel data will pass by TCP/UDP.<br>=C2=A0 */<br=
>@@ -152,6 +160,10 @@ struct frame<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=
=A0 which defaults to 0 for tun and 32<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =
=C2=A0 (\c TAP_MTU_EXTRA_DEFAULT) for tap.<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0* =C2=A0 */<br>+<br>+ =C2=A0 =C2=A0int bulk_size; =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt; Signal to the init frame function<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 to allow for bulk mode TCP =
transfers.<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 */<br>=C2=A0}=
;<br><br>=C2=A0/* Forward declarations, to prevent includes */<br>@@ -171,6=
 +183,7 @@ struct options;<br>=C2=A0 * larger than the headroom.<br>=C2=A0 =
*/<br>=C2=A0#define BUF_SIZE(f) ((f)-&gt;buf.headroom + (f)-&gt;buf.payload=
_size + (f)-&gt;buf.tailroom)<br>+#define BAT_SIZE(a, b, c) ((a * b) + c)<b=
r><br>=C2=A0/*<br>=C2=A0 * Function prototypes.<br>diff --git a/src/openvpn=
/multi.c b/src/openvpn/multi.c<br>index e1ce32ab..9e089703 100644<br>--- a/=
src/openvpn/multi.c<br>+++ b/src/openvpn/multi.c<br>@@ -3414,6 +3414,7 @@ m=
ulti_process_incoming_link(struct multi_context *m, struct multi_instance *=
inst<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=
<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_i=
ncoming_link_part2(c, lsi, orig_buf);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_link_part3(c);<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0perf_pop();<br><br>@@ -3558,9 +3559,7 @@ multi_process_incomin=
g_tun(struct multi_context *m, const unsigned int mpp_flags<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0const int dev_type =3D TUNNEL_TYPE(m-&gt;top.c1.tun=
tap);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int16_t vid =3D 0;<br><br>-#ifde=
f MULTI_DEBUG_EVENT_LOOP<br>- =C2=A0 =C2=A0 =C2=A0 =C2=A0printf(&quot;TUN -=
&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));<br>-#endif<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_MULTI_DEBUG, &quot;TUN -&gt; TCP/UDP [%d]&=
quot;, BLEN(&amp;m-&gt;top.c2.buf));<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (m-&gt;pending)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>@@ -3610,6 =
+3609,8 @@ multi_process_incoming_tun(struct multi_context *m, const unsign=
ed int mpp_flags<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* tra=
nsfer packet pointer from top-level context buffer to instance */<br>=C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D m-&gt;top.c2.buf;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0/* todo determine if to call this (multi_process_incoming_tun)=
 for each bulk item read? */<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0xfer_io(c, &amp;m-&=
gt;top);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<=
br>diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h<br>index cd99=
cd40..21fa8967 100644<br>--- a/src/openvpn/openvpn.h<br>+++ b/src/openvpn/o=
penvpn.h<br>@@ -112,6 +112,14 @@ struct context_buffers<br>=C2=A0 =C2=A0 =
=C2=A0 */<br>=C2=A0 =C2=A0 =C2=A0struct buffer read_link_buf;<br>=C2=A0 =C2=
=A0 =C2=A0struct buffer read_tun_buf;<br>+<br>+ =C2=A0 =C2=A0struct buffer =
read_tun_bufs[TUN_BAT_MAX];<br>+ =C2=A0 =C2=A0struct buffer read_tun_max;<b=
r>+ =C2=A0 =C2=A0struct buffer send_tun_max;<br>+ =C2=A0 =C2=A0struct buffe=
r to_tun_max;<br>+<br>+ =C2=A0 =C2=A0int bufs_indx;<br>+ =C2=A0 =C2=A0int f=
lag_ciph;<br>=C2=A0};<br><br>=C2=A0/*<br>@@ -376,6 +384,8 @@ struct context=
_2<br>=C2=A0 =C2=A0 =C2=A0struct buffer to_tun;<br>=C2=A0 =C2=A0 =C2=A0stru=
ct buffer to_link;<br><br>+ =C2=A0 =C2=A0struct buffer bufs[TUN_BAT_MAX];<b=
r>+<br>=C2=A0 =C2=A0 =C2=A0/* should we print R|W|r|w to console on packet =
transfers? */<br>=C2=A0 =C2=A0 =C2=A0bool log_rw;<br><br>diff --git a/src/o=
penvpn/options.c b/src/openvpn/options.c<br>index c54032d8..041d17d0 100644=
<br>--- a/src/openvpn/options.c<br>+++ b/src/openvpn/options.c<br>@@ -304,6=
 +304,7 @@ static const char usage_message[] =3D<br>=C2=A0 =C2=A0 =C2=A0&qu=
ot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;mayb=
e&#39; -- Use per-route hints\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&#39;yes&#39; =C2=A0=
 -- Always DF (Don&#39;t Fragment)\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot;--m=
tu-test =C2=A0 =C2=A0 =C2=A0: Empirically measure and report MTU.\n&quot;<b=
r>+ =C2=A0 =C2=A0&quot;--bulk-mode =C2=A0 =C2=A0 : Use bulk TUN/TCP reads/w=
rites.\n&quot;<br>=C2=A0#ifdef ENABLE_FRAGMENT<br>=C2=A0 =C2=A0 =C2=A0&quot=
;--fragment max =C2=A0: Enable internal datagram fragmentation so that no U=
DP\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0datagrams are sent which are larger than max by=
tes.\n&quot;<br>@@ -3005,6 +3006,9 @@ options_postprocess_mutate_ce(struct =
options *o, struct connection_entry *ce)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0ce-&gt;tun_mtu_extra_defined =3D true;<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;tun_mtu_extra =3D TAP_MTU_EXTRA_DE=
FAULT;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; ce-&gt;proto !=3D PROTO_TCP_S=
ERVER &amp;&amp; ce-&gt;proto !=3D PROTO_TCP_CLIENT) {<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;bulk_mode =3D false;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0/*<br>@@=
 -9926,6 +9930,10 @@ add_option(struct options *options, char *p[], bool is=
_inline, const char *file,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0goto err;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0=
}<br>+ =C2=A0 =C2=A0else if (streq(p[0], &quot;bulk-mode&quot;))<br>+ =C2=
=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0options-&gt;ce.bulk_mode =3D tr=
ue;<br>+ =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0=
{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i;<br>diff --git a/src/openvpn/o=
ptions.h b/src/openvpn/options.h<br>index 38e67c8d..d1b0586d 100644<br>--- =
a/src/openvpn/options.h<br>+++ b/src/openvpn/options.h<br>@@ -174,6 +174,9 =
@@ struct connection_entry<br><br>=C2=A0 =C2=A0 =C2=A0/* Allow only client =
that support resending the wrapped client key */<br>=C2=A0 =C2=A0 =C2=A0boo=
l tls_crypt_v2_force_cookie;<br>+<br>+ =C2=A0 =C2=A0/* Bulk mode allows for=
 multiple tun reads + larger tcp writes */<br>+ =C2=A0 =C2=A0bool bulk_mode=
;<br>=C2=A0};<br><br>=C2=A0struct remote_entry<br>--<br>2.39.5 (Apple Git-1=
54)<br></div><div><br></div></div>
</blockquote></div>
</blockquote></div>

--000000000000d7201d063bdf0a69--

