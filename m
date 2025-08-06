MIME-Version: 1.0
From: Jon Chiappetta <root@...2904...>
Date: Wed, 6 Aug 2025 19:50:16 -0400
Message-ID: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q@...278...>
Content-Type: multipart/alternative; boundary="0000000000006630a3063bbb0152"
References: <CAOh3LPMvAFtZ7rdBVYZ2raErtNM2=F-r1WQv9+YZE+6SxRfM8Q.ref@...278...>
Subject: [Openvpn-devel] Bulk mode - Feature request - Patch diff
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--0000000000006630a3063bbb0152
Content-Type: text/plain; charset="UTF-8"

I was still working on looking into some potential limited access to
gerrit. I manually ported the diff from the 2.6 source code I was able to
compile and run with over to the generalized master branch which doesn't
contain any configure/makefile so I am not able to build/run that version
at the moment (untested). I made some changes to try and optimize some
parts and cover more edge cases and I also put in a command line option to
use this feature otherwise it should not affect the rest of the code base
if the option is omitted.

In the meantime I created an initial example pull request to gauge if
anyone is actually interested in this work and/or if anyone has any general
initial thoughts or feedback on code quality as I am actually using this
right now personally.

In the case that anyone is interested in such a change I will paste the
generated patch diff below otherwise I will continue to run this
experimental build at home here and see what happens! :)

Thanks,
Jon C

https://github.com/OpenVPN/openvpn/pull/814/files

$ cat 0001-bulk-mode.patch
From 1b15b4aed623e7490d72ed7e21c3873a05630dd1 Mon Sep 17 00:00:00 2001
From: Jon Chiappetta <root@...2904...>
Date: Wed, 6 Aug 2025 16:33:18 -0400
Subject: [PATCH] bulk mode

---
 src/openvpn/forward.c | 226 ++++++++++++++++++++++++++++++++++++++++--
 src/openvpn/forward.h |   4 +
 src/openvpn/init.c    |  46 +++++++++
 src/openvpn/mtu.c     |  10 +-
 src/openvpn/mtu.h     |  13 +++
 src/openvpn/multi.c   |   7 +-
 src/openvpn/openvpn.h |  10 ++
 src/openvpn/options.c |   8 ++
 src/openvpn/options.h |   3 +
 9 files changed, 315 insertions(+), 12 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 75ca9d5c..37249802 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -46,6 +46,9 @@

 #include "mstats.h"

+#include <sys/select.h>
+#include <sys/time.h>
+
 counter_type link_read_bytes_global;  /* GLOBAL */
 counter_type link_write_bytes_global; /* GLOBAL */

@@ -78,6 +81,32 @@ show_wait_status(struct context *c)

 #endif /* ifdef ENABLE_DEBUG */

+bool check_bulk_mode(struct context *c)
+{
+    if ((c->c2.frame.bulk_size > 0) && (c->c1.tuntap != NULL) &&
(c->c2.buffers != NULL))
+    {
+        return true;
+    }
+    return false;
+}
+
+void xfer_io(struct context *c, struct context *b)
+{
+    int plen = 0;
+    if (check_bulk_mode(b))
+    {
+        int leng = (b->c2.buffers->bufs_indx + 1);
+        for (int x = 0; x < leng; ++x)
+        {
+            plen = BLEN(&b->c2.bufs[x]);
+            if (plen < 1) { c->c2.bufs[x].len = 0; }
+            else { c->c2.bufs[x] = b->c2.bufs[x]; }
+        }
+        c->c2.buffers->bufs_indx = b->c2.buffers->bufs_indx;
+        b->c2.buffers->bufs_indx = -1;
+    }
+}
+
 static void
 check_tls_errors_co(struct context *c)
 {
@@ -605,6 +634,21 @@ buffer_turnover(const uint8_t *orig_buf, struct buffer
*dest_stub, struct buffer
     }
 }

+uint8_t *buff_prepsize(uint8_t *buff, int *size)
+{
+    buff[0] = ((*size >> 8) & 0xff);
+    buff[1] = ((*size >> 0) & 0xff);
+    buff += 2;
+    return buff;
+}
+
+uint8_t *buff_postsize(uint8_t *buff, int *size)
+{
+    *size = ((buff[0] << 8) + (buff[1] << 0));
+    buff += 2;
+    return buff;
+}
+
 /*
  * Compress, fragment, encrypt and HMAC-sign an outgoing packet.
  * Input: c->c2.buf
@@ -1031,6 +1075,7 @@ process_incoming_link_part1(struct context *c, struct
link_socket_info *lsi, boo
         fprintf(stderr, "R");
     }
 #endif
+
     msg(D_LINK_RW, "%s READ [%d] from %s: %s", proto2ascii(lsi->proto,
lsi->af, true),
         BLEN(&c->c2.buf), print_link_socket_actual(&c->c2.from, &gc),
PROTO_DUMP(&c->c2.buf, &gc));

@@ -1211,6 +1256,28 @@ process_incoming_link_part2(struct context *c,
struct link_socket_info *lsi,
     }
 }

+void process_incoming_link_part3(struct context *c)
+{
+    int leng = BLEN(&c->c2.to_tun);
+    if (leng > 0)
+    {
+        if (check_bulk_mode(c))
+        {
+            c->c2.buffers->send_tun_max.len = 0;
+            uint8_t *temp = BPTR(&c->c2.to_tun);
+            if ((temp[0] == 0xff) && (temp[1] == 0x13) && (temp[2] ==
0x37) && (temp[3] == 0xff))
+            {
+                c->c2.buffers->send_tun_max.offset = TUN_BAT_OFF;
+                c->c2.buffers->send_tun_max.len = leng;
+                bcopy(BPTR(&c->c2.to_tun),
BPTR(&c->c2.buffers->send_tun_max), leng);
+                //dmsg(M_INFO, "FWD BAT LINK 0 [%d] [%d] [%d] [%d] [%d]",
BLEN(&c->c2.buf), BLEN(&c->c2.to_tun), BLEN(&c->c2.buffers->read_link_buf),
BLEN(&c->c2.buffers->read_link_buf), BLEN(&c->c2.buffers->send_tun_max));
+            }
+            c->c2.to_tun.offset += 6;
+            c->c2.buf.offset += 6;
+        }
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
+        int plen = 0;
+        int fdno = c->c1.tuntap->fd;
+        while ((c->c2.buffers->bufs_indx + 1) < TUN_BAT_MIN)
+        {
+            int leng = plen;
+            int indx = (c->c2.buffers->bufs_indx + 1);
+            if (leng < 1)
+            {
+                FD_ZERO(&rfds);
+                FD_SET(fdno, &rfds);
+                timo.tv_sec = 0;
+                timo.tv_usec = 0;
+                select(fdno+1, &rfds, NULL, NULL, &timo);
+                if (FD_ISSET(fdno, &rfds))
+                {
+                    read_incoming_tun_part2(c);
+                    plen = BLEN(&c->c2.buf);
+                } else { break; }
+            }
+            //dmsg(M_INFO, "FWD BAT READ 0 [%d] [%d] [%d] [%d] [%d]",
c->c2.buffers->bufs_indx + 1, fdno, BLEN(&c->c2.buf),
BLEN(&c->c2.buffers->read_tun_buf), BLEN(&c->c2.buffers->read_tun_max));
+            leng = plen;
+            if (leng > 0)
+            {
+                c->c2.buffers->read_tun_bufs[indx].offset = TUN_BAT_OFF;
+                c->c2.buffers->read_tun_bufs[indx].len = leng;
+                bcopy(BPTR(&c->c2.buf),
BPTR(&c->c2.buffers->read_tun_bufs[indx]), leng);
+                c->c2.bufs[indx] = c->c2.buffers->read_tun_bufs[indx];
+                c->c2.buffers->bufs_indx = indx;
+            } else { break; }
+            plen = 0;
+        }
+    }
+}
+
+void read_incoming_tun(struct context *c)
+{
+    if (c->c2.frame.bulk_size <= 0) {
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
     struct gc_arena gc = gc_new();

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
+        if ((c->c2.buffers == NULL) || (c->c2.buffers->flag_ciph != -2)) {
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
+    if (check_bulk_mode(c))
+    {
+        c->c2.buffers->flag_ciph = -2;
+        c->c2.buffers->read_tun_max.offset = TUN_BAT_OFF;
+        c->c2.buffers->read_tun_max.len = 0;
+        uint8_t *temp = BPTR(&c->c2.buffers->read_tun_max);
+        int plen = 0, fdno = c->c1.tuntap->fd;
+        int maxl = 0, leng = (c->c2.buffers->bufs_indx + 1);
+        if ((fdno > 0) && (leng > 0))
+        {
+            for (int x = 0; x < leng; ++x)
+            {
+                c->c2.buf = c->c2.bufs[x];
+                //dmsg(M_INFO, "FWD BAT INPT 0 [%d] [%d] [%d] [%d] [%d]",
x, fdno, BLEN(&c->c2.buf), BLEN(&c->c2.buffers->read_tun_buf),
BLEN(&c->c2.bufs[x]));
+                process_incoming_tun_part2(c, out_sock);
+                if (BLEN(&c->c2.buf) < 1)
+                {
+                    c->c2.bufs[x].len = 0;
+                }
+            }
+            for (int x = 0; x < leng; ++x)
+            {
+                plen = c->c2.bufs[x].len;
+                if (plen > 0)
+                {
+                    if (maxl < 1)
+                    {
+                        temp[0] = 0xff; temp[1] = 0x13; temp[2] = 0x37;
temp[3] = 0xff;
+                        temp += 4; maxl += 4;
+                    }
+                    temp = buff_prepsize(temp, &plen);
+                    bcopy(BPTR(&c->c2.bufs[x]), temp, plen);
+                    temp += plen; maxl += (plen + 2);
+                }
+            }
+            if (maxl > 0)
+            {
+                c->c2.buffers->read_tun_max.offset = TUN_BAT_OFF;
+                c->c2.buffers->read_tun_max.len = maxl;
+                c->c2.buf = c->c2.buffers->read_tun_max;
+                //dmsg(M_INFO, "FWD BAT INPT 1 [%d] [%d] [%d] [%d] [%d]",
maxl, fdno, BLEN(&c->c2.buf), BLEN(&c->c2.buffers->read_tun_buf),
BLEN(&c->c2.buffers->read_tun_max));
+                encrypt_sign(c, true);
+            }
+        }
+        c->c2.buffers->bufs_indx = -1;
+        c->c2.buffers->flag_ciph = -1;
+    }
+}
+
+void process_incoming_tun(struct context *c, struct link_socket *out_sock)
+{
+    if (c->c2.frame.bulk_size <= 0) {
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

-    if (c->c2.to_link.len > 0 && c->c2.to_link.len <=
c->c2.frame.buf.payload_size)
+    if (c->c2.to_link.len > 0 && (c->c2.to_link.len <=
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

-    if (c->c2.to_tun.len <= c->c2.frame.buf.payload_size)
+    if (c->c2.to_tun.len <= c->c2.frame.buf.payload_size ||
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
@@ -1981,6 +2160,39 @@ process_outgoing_tun(struct context *c, struct
link_socket *in_sock)
     perf_pop();
 }

+void process_outgoing_tun_part3(struct context *c, struct link_socket
*in_sock)
+{
+    if (check_bulk_mode(c))
+    {
+        int maxl = 0, plen = 0;
+        int leng = BLEN(&c->c2.buffers->send_tun_max);
+        uint8_t *temp = BPTR(&c->c2.buffers->send_tun_max);
+        temp += 4; maxl += 4;
+        for (int x = 0; x < TUN_BAT_MAX; ++x)
+        {
+            temp = buff_postsize(temp, &plen);
+            if ((leng > 0) && (plen > 0) && ((maxl + plen) < leng))
+            {
+                c->c2.to_tun = c->c2.buffers->to_tun_max;
+                c->c2.to_tun.offset = TUN_BAT_OFF;
+                c->c2.to_tun.len = plen;
+                bcopy(temp, BPTR(&c->c2.to_tun), plen);
+                temp += plen; maxl += (plen + 2);
+                //dmsg(M_INFO, "FWD BAT OUTP 1 [%d] [%d] [%d] [%d]", x,
BLEN(&c->c2.buf), BLEN(&c->c2.to_tun), BLEN(&c->c2.buffers->read_link_buf));
+                process_outgoing_tun_part2(c, in_sock);
+            } else { break; }
+        }
+    }
+}
+
+void process_outgoing_tun(struct context *c, struct link_socket *in_sock)
+{
+    if (c->c2.frame.bulk_size <= 0) {
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
index 40ae2c8c..47818bbb 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2971,6 +2971,10 @@ frame_finalize_options(struct context *c, const
struct options *o)
     tailroom += COMP_EXTRA_BUFFER(payload_size);
 #endif

+    if (frame->bulk_size > 0) {
+        payload_size = frame->tun_mtu;
+    }
+
     frame->buf.payload_size = payload_size;
     frame->buf.headroom = headroom;
     frame->buf.tailroom = tailroom;
@@ -3473,6 +3477,9 @@ do_init_frame_tls(struct context *c)
     if (c->c2.tls_multi)
     {
         tls_multi_init_finalize(c->c2.tls_multi, c->options.ce.tls_mtu);
+        if (c->c2.frame.bulk_size > 0) {
+            c->c2.tls_multi->opt.frame.buf.payload_size =
c->c2.frame.tun_mtu;
+        }
         ASSERT(c->c2.tls_multi->opt.frame.buf.payload_size <=
c->c2.frame.buf.payload_size);
         frame_print(&c->c2.tls_multi->opt.frame, D_MTU_INFO, "Control
Channel MTU parms");

@@ -3536,6 +3543,14 @@ do_init_frame(struct context *c)
         c->c2.frame.extra_tun += c->options.ce.tun_mtu_extra;
     }

+    /*
+     * Adjust bulk size based on the --bulk-mode parameter.
+     */
+    if (c->options.ce.bulk_mode)
+    {
+        c->c2.frame.bulk_size = c->options.ce.tun_mtu;
+    }
+
     /*
      * Fill in the blanks in the frame parameters structure,
      * make sure values are rational, etc.
@@ -3676,9 +3691,40 @@ init_context_buffers(const struct frame *frame)

     size_t buf_size = BUF_SIZE(frame);

+    if (frame->bulk_size > 0) {
+        buf_size = BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu,
frame->buf.headroom + frame->buf.tailroom);
+    }
+
+    dmsg(M_INFO, "MEM NEW [%ld] [%d+%d+%d]", buf_size,
frame->buf.headroom, frame->buf.payload_size, frame->buf.tailroom);
+
     b->read_link_buf = alloc_buf(buf_size);
     b->read_tun_buf = alloc_buf(buf_size);

+    if (frame->bulk_size > 0) {
+        for (int x = 0; x < TUN_BAT_MAX; ++x)
+        {
+            size_t part_size = BUF_SIZE(frame);
+            b->read_tun_bufs[x] = alloc_buf(part_size);
+            b->read_tun_bufs[x].offset = TUN_BAT_OFF;
+            b->read_tun_bufs[x].len = 0;
+        }
+
+        b->read_tun_max = alloc_buf(buf_size);
+        b->read_tun_max.offset = TUN_BAT_OFF;
+        b->read_tun_max.len = 0;
+
+        b->send_tun_max = alloc_buf(buf_size);
+        b->send_tun_max.offset = TUN_BAT_OFF;
+        b->send_tun_max.len = 0;
+
+        b->to_tun_max = alloc_buf(buf_size);
+        b->to_tun_max.offset = TUN_BAT_OFF;
+        b->to_tun_max.len = 0;
+    }
+
+    b->bufs_indx = -1;
+    b->flag_ciph = -1;
+
     b->aux_buf = alloc_buf(buf_size);

     b->encrypt_buf = alloc_buf(buf_size);
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index a419e32d..7e35c837 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -41,9 +41,15 @@ void
 alloc_buf_sock_tun(struct buffer *buf, const struct frame *frame)
 {
     /* allocate buffer for overlapped I/O */
-    *buf = alloc_buf(BUF_SIZE(frame));
+    size_t alen = BUF_SIZE(frame);
+    size_t blen = frame->buf.payload_size;
+    if (frame->bulk_size > 0) {
+        alen = BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_OFF);
+        blen = BAT_SIZE(TUN_BAT_MAX, frame->tun_mtu, TUN_BAT_NOP);
+    }
+    *buf = alloc_buf(alen);
     ASSERT(buf_init(buf, frame->buf.headroom));
-    buf->len = frame->buf.payload_size;
+    buf->len = blen;
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
         const int dev_type = TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid = 0;

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
                             c->c2.buf = m->top.c2.buf;
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
@@ -304,6 +304,7 @@ static const char usage_message[] =
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
             ce->tun_mtu_extra_defined = true;
             ce->tun_mtu_extra = TAP_MTU_EXTRA_DEFAULT;
         }
+        if (ce->proto != PROTO_TCP && ce->proto != PROTO_TCP_SERVER &&
ce->proto != PROTO_TCP_CLIENT) {
+            ce->bulk_mode = false;
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
+        options->ce.bulk_mode = true;
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

--0000000000006630a3063bbb0152
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>I was=C2=A0still working on looking into some potenti=
al limited access to gerrit. I manually ported the diff from the 2.6 source=
 code I was able to compile and run with over to the generalized master bra=
nch which doesn&#39;t contain any configure/makefile so I am not able to bu=
ild/run that version at the moment (untested). I made some changes to try a=
nd optimize some parts and cover more edge cases and I also put in a comman=
d line option to use this feature otherwise it should not affect the rest o=
f the code base if the option is omitted.=C2=A0</div><div><br></div><div>In=
 the meantime=C2=A0I created=C2=A0an initial example pull request to gauge =
if anyone is actually interested in this work and/or if anyone has any gene=
ral initial thoughts or feedback on code quality as I am actually using thi=
s right now personally.=C2=A0</div><div><br></div>In the case that anyone i=
s interested in such a change I will paste the generated patch diff below o=
therwise I will continue to run this experimental build at home here and se=
e what happens! :)=C2=A0<div><br></div><div>Thanks,</div><div>Jon C</div><d=
iv><br></div><div><a href=3D"https://github.com/OpenVPN/openvpn/pull/814/fi=
les">https://github.com/OpenVPN/openvpn/pull/814/files</a><br></div><div><b=
r></div><div>$ cat 0001-bulk-mode.patch<br>From 1b15b4aed623e7490d72ed7e21c=
3873a05630dd1 Mon Sep 17 00:00:00 2001<br>From: Jon Chiappetta &lt;<a href=
=3D"mailto:root@...2904...">root@...2904...</a>&gt;<br>Date: Wed, 6 Aug 202=
5 16:33:18 -0400<br>Subject: [PATCH] bulk mode<br><br>---<br>=C2=A0src/open=
vpn/forward.c | 226 ++++++++++++++++++++++++++++++++++++++++--<br>=C2=A0src=
/openvpn/forward.h | =C2=A0 4 +<br>=C2=A0src/openvpn/init.c =C2=A0 =C2=A0| =
=C2=A046 +++++++++<br>=C2=A0src/openvpn/mtu.c =C2=A0 =C2=A0 | =C2=A010 +-<b=
r>=C2=A0src/openvpn/mtu.h =C2=A0 =C2=A0 | =C2=A013 +++<br>=C2=A0src/openvpn=
/multi.c =C2=A0 | =C2=A0 7 +-<br>=C2=A0src/openvpn/openvpn.h | =C2=A010 ++<=
br>=C2=A0src/openvpn/options.c | =C2=A0 8 ++<br>=C2=A0src/openvpn/options.h=
 | =C2=A0 3 +<br>=C2=A09 files changed, 315 insertions(+), 12 deletions(-)<=
br><br>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c<br>index =
75ca9d5c..37249802 100644<br>--- a/src/openvpn/forward.c<br>+++ b/src/openv=
pn/forward.c<br>@@ -46,6 +46,9 @@<br><br>=C2=A0#include &quot;mstats.h&quot=
;<br><br>+#include &lt;sys/select.h&gt;<br>+#include &lt;sys/time.h&gt;<br>=
+<br>=C2=A0counter_type link_read_bytes_global; =C2=A0/* GLOBAL */<br>=C2=
=A0counter_type link_write_bytes_global; /* GLOBAL */<br><br>@@ -78,6 +81,3=
2 @@ show_wait_status(struct context *c)<br><br>=C2=A0#endif /* ifdef ENABL=
E_DEBUG */<br><br>+bool check_bulk_mode(struct context *c)<br>+{<br>+ =C2=
=A0 =C2=A0if ((c-&gt;c2.frame.bulk_size &gt; 0) &amp;&amp; (c-&gt;c1.tuntap=
 !=3D NULL) &amp;&amp; (c-&gt;c2.buffers !=3D NULL))<br>+ =C2=A0 =C2=A0{<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =
=C2=A0return false;<br>+}<br>+<br>+void xfer_io(struct context *c, struct c=
ontext *b)<br>+{<br>+ =C2=A0 =C2=A0int plen =3D 0;<br>+ =C2=A0 =C2=A0if (ch=
eck_bulk_mode(b))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int l=
eng =3D (b-&gt;c2.buffers-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0for (int x =3D 0; x &lt; leng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D BLEN(&amp;b-&gt;c2.buf=
s[x]);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (plen &lt; 1) { c-&=
gt;c2.bufs[x].len =3D 0; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0el=
se { c-&gt;c2.bufs[x] =3D b-&gt;c2.bufs[x]; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;bufs_indx =3D b-&=
gt;c2.buffers-&gt;bufs_indx;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0b-&gt;c2.buffe=
rs-&gt;bufs_indx =3D -1;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>=C2=A0static voi=
d<br>=C2=A0check_tls_errors_co(struct context *c)<br>=C2=A0{<br>@@ -605,6 +=
634,21 @@ buffer_turnover(const uint8_t *orig_buf, struct buffer *dest_stub=
, struct buffer<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0}<br><br>+uint8_t *buff_p=
repsize(uint8_t *buff, int *size)<br>+{<br>+ =C2=A0 =C2=A0buff[0] =3D ((*si=
ze &gt;&gt; 8) &amp; 0xff);<br>+ =C2=A0 =C2=A0buff[1] =3D ((*size &gt;&gt; =
0) &amp; 0xff);<br>+ =C2=A0 =C2=A0buff +=3D 2;<br>+ =C2=A0 =C2=A0return buf=
f;<br>+}<br>+<br>+uint8_t *buff_postsize(uint8_t *buff, int *size)<br>+{<br=
>+ =C2=A0 =C2=A0*size =3D ((buff[0] &lt;&lt; 8) + (buff[1] &lt;&lt; 0));<br=
>+ =C2=A0 =C2=A0buff +=3D 2;<br>+ =C2=A0 =C2=A0return buff;<br>+}<br>+<br>=
=C2=A0/*<br>=C2=A0 * Compress, fragment, encrypt and HMAC-sign an outgoing =
packet.<br>=C2=A0 * Input: c-&gt;c2.buf<br>@@ -1031,6 +1075,7 @@ process_in=
coming_link_part1(struct context *c, struct link_socket_info *lsi, boo<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;R&quot;);<br>=C2=A0=
 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>+<br>=C2=A0 =C2=A0 =C2=A0msg(D_LINK_RW, =
&quot;%s READ [%d] from %s: %s&quot;, proto2ascii(lsi-&gt;proto, lsi-&gt;af=
, true),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0BLEN(&amp;c-&gt;c2.buf), prin=
t_link_socket_actual(&amp;c-&gt;c2.from, &amp;gc), PROTO_DUMP(&amp;c-&gt;c2=
.buf, &amp;gc));<br><br>@@ -1211,6 +1256,28 @@ process_incoming_link_part2(=
struct context *c, struct link_socket_info *lsi,<br>=C2=A0 =C2=A0 =C2=A0}<b=
r>=C2=A0}<br><br>+void process_incoming_link_part3(struct context *c)<br>+{=
<br>+ =C2=A0 =C2=A0int leng =3D BLEN(&amp;c-&gt;c2.to_tun);<br>+ =C2=A0 =C2=
=A0if (leng &gt; 0)<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if =
(check_bulk_mode(c))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;send_tun_max.len =3D 0;<br>=
+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =3D BPTR(&amp;c-&g=
t;c2.to_tun);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((temp[0] =
=3D=3D 0xff) &amp;&amp; (temp[1] =3D=3D 0x13) &amp;&amp; (temp[2] =3D=3D 0x=
37) &amp;&amp; (temp[3] =3D=3D 0xff))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&=
gt;c2.buffers-&gt;send_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;send_tun_max.=
len =3D leng;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0b=
copy(BPTR(&amp;c-&gt;c2.to_tun), BPTR(&amp;c-&gt;c2.buffers-&gt;send_tun_ma=
x), leng);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dm=
sg(M_INFO, &quot;FWD BAT LINK 0 [%d] [%d] [%d] [%d] [%d]&quot;, BLEN(&amp;c=
-&gt;c2.buf), BLEN(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.buffers-&gt;re=
ad_link_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_link_buf), BLEN(&amp;c-&g=
t;c2.buffers-&gt;send_tun_max));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.offse=
t +=3D 6;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf.offset=
 +=3D 6;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<b=
r>=C2=A0static void<br>=C2=A0process_incoming_link(struct context *c, struc=
t link_socket *sock)<br>=C2=A0{<br>@@ -1221,6 +1288,7 @@ process_incoming_l=
ink(struct context *c, struct link_socket *sock)<br><br>=C2=A0 =C2=A0 =C2=
=A0process_incoming_link_part1(c, lsi, false);<br>=C2=A0 =C2=A0 =C2=A0proce=
ss_incoming_link_part2(c, lsi, orig_buf);<br>+ =C2=A0 =C2=A0process_incomin=
g_link_part3(c);<br><br>=C2=A0 =C2=A0 =C2=A0perf_pop();<br>=C2=A0}<br>@@ -1=
321,7 +1389,7 @@ process_incoming_dco(struct context *c)<br>=C2=A0 */<br><b=
r>=C2=A0void<br>-read_incoming_tun(struct context *c)<br>+read_incoming_tun=
_part2(struct context *c)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =
=C2=A0 =C2=A0 * Setup for read() call on TUN/TAP device.<br>@@ -1382,6 +145=
0,54 @@ read_incoming_tun(struct context *c)<br>=C2=A0 =C2=A0 =C2=A0perf_po=
p();<br>=C2=A0}<br><br>+void read_incoming_tun_part3(struct context *c)<br>=
+{<br>+ =C2=A0 =C2=A0fd_set rfds;<br>+ =C2=A0 =C2=A0struct timeval timo;<br=
>+ =C2=A0 =C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0int plen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int fdno =
=3D c-&gt;c1.tuntap-&gt;fd;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0while ((c-&gt;c=
2.buffers-&gt;bufs_indx + 1) &lt; TUN_BAT_MIN)<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D plen;<br=
>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int indx =3D (c-&gt;c2.buffers-=
&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (leng =
&lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =
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
=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &q=
uot;FWD BAT READ 0 [%d] [%d] [%d] [%d] [%d]&quot;, c-&gt;c2.buffers-&gt;buf=
s_indx + 1, fdno, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.buffers-&gt;r=
ead_tun_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tun_max));<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0leng =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0if (leng &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&=
gt;c2.buffers-&gt;read_tun_bufs[indx].offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_t=
un_bufs[indx].len =3D leng;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0bcopy(BPTR(&amp;c-&gt;c2.buf), BPTR(&amp;c-&gt;c2.buffers-&gt;=
read_tun_bufs[indx]), leng);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0c-&gt;c2.bufs[indx] =3D c-&gt;c2.buffers-&gt;read_tun_bufs[in=
dx];<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.b=
uffers-&gt;bufs_indx =3D indx;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0plen =3D=
 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+vo=
id read_incoming_tun(struct context *c)<br>+{<br>+ =C2=A0 =C2=A0if (c-&gt;c=
2.frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0read_incomin=
g_tun_part2(c);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0read_incoming_tun_par=
t3(c);<br>+}<br>+<br>=C2=A0/**<br>=C2=A0 * Drops UDP packets which OS decid=
ed to route via tun.<br>=C2=A0 *<br>@@ -1469,7 +1585,7 @@ drop_if_recursive=
_routing(struct context *c, struct buffer *buf)<br>=C2=A0 */<br><br>=C2=A0v=
oid<br>-process_incoming_tun(struct context *c, struct link_socket *out_soc=
k)<br>+process_incoming_tun_part2(struct context *c, struct link_socket *ou=
t_sock)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0struct gc_arena gc =3D gc_new();<=
br><br>@@ -1488,7 +1604,7 @@ process_incoming_tun(struct context *c, struct=
 link_socket *out_sock)<br>=C2=A0#endif<br><br>=C2=A0 =C2=A0 =C2=A0/* Show =
packet content */<br>- =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN READ [%d]&quot=
;, BLEN(&amp;c-&gt;c2.buf));<br>+ =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN REA=
D [%d] [%d]&quot;, BLEN(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size=
);<br><br>=C2=A0 =C2=A0 =C2=A0if (c-&gt;c2.buf.len &gt; 0)<br>=C2=A0 =C2=A0=
 =C2=A0{<br>@@ -1512,7 +1628,9 @@ process_incoming_tun(struct context *c, s=
truct link_socket *out_sock)<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0if (c-&gt;c2.buf.len &gt; 0)<br>=C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0if ((c-&gt;c2.buffers =3D=3D NULL) || (c-&gt;c2.buffers-&gt;f=
lag_ciph !=3D -2)) {<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encrypt_sign(c, t=
rue);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =
=C2=A0 =C2=A0else<br>=C2=A0 =C2=A0 =C2=A0{<br>@@ -1522,6 +1640,65 @@ proces=
s_incoming_tun(struct context *c, struct link_socket *out_sock)<br>=C2=A0 =
=C2=A0 =C2=A0gc_free(&amp;gc);<br>=C2=A0}<br><br>+void process_incoming_tun=
_part3(struct context *c, struct link_socket *out_sock)<br>+{<br>+ =C2=A0 =
=C2=A0if (check_bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0c-&gt;c2.buffers-&gt;flag_ciph =3D -2;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0c-&gt;c2.buffers-&gt;read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D 0;<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0uint8_t *temp =3D BPTR(&amp;c-&gt;c2.buffers-&gt;re=
ad_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int plen =3D 0, fdno =3D c-&gt=
;c1.tuntap-&gt;fd;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl =3D 0, leng =3D=
 (c-&gt;c2.buffers-&gt;bufs_indx + 1);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (=
(fdno &gt; 0) &amp;&amp; (leng &gt; 0))<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int x =3D 0; x &lt; leng;=
 ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D c-&gt;c2.bufs[x];=
<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO,=
 &quot;FWD BAT INPT 0 [%d] [%d] [%d] [%d] [%d]&quot;, x, fdno, BLEN(&amp;c-=
&gt;c2.buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tun_buf), BLEN(&amp;c-&gt;=
c2.bufs[x]));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0p=
rocess_incoming_tun_part2(c, out_sock);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0if (BLEN(&amp;c-&gt;c2.buf) &lt; 1)<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.bufs[x].len =3D 0=
;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0for (int x =3D 0; x &lt; leng; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0plen =3D c-&gt;c2.bufs[x].len;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (plen &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (maxl &lt; 1)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp[0] =3D 0=
xff; temp[1] =3D 0x13; temp[2] =3D 0x37; temp[3] =3D 0xff;<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0te=
mp +=3D 4; maxl +=3D 4;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff_prepsize(temp, &amp;plen);<br>+ =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(=
BPTR(&amp;c-&gt;c2.bufs[x]), temp, plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp +=3D plen; maxl +=3D (plen + =
2);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0if (maxl &gt; 0)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.b=
uffers-&gt;read_tun_max.offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;read_tun_max.len =3D=
 maxl;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2=
.buf =3D c-&gt;c2.buffers-&gt;read_tun_max;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0//dmsg(M_INFO, &quot;FWD BAT INPT 1 [%d] [%d=
] [%d] [%d] [%d]&quot;, maxl, fdno, BLEN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&g=
t;c2.buffers-&gt;read_tun_buf), BLEN(&amp;c-&gt;c2.buffers-&gt;read_tun_max=
));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0encrypt_sig=
n(c, true);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=
=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;buf=
s_indx =3D -1;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buffers-&gt;flag_ci=
ph =3D -1;<br>+ =C2=A0 =C2=A0}<br>+}<br>+<br>+void process_incoming_tun(str=
uct context *c, struct link_socket *out_sock)<br>+{<br>+ =C2=A0 =C2=A0if (c=
-&gt;c2.frame.bulk_size &lt;=3D 0) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0proces=
s_incoming_tun_part2(c, out_sock);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0pr=
ocess_incoming_tun_part3(c, out_sock);<br>+}<br>+<br>=C2=A0/**<br>=C2=A0 * =
Forges a IPv6 ICMP packet with a no route to host error code from the<br>=
=C2=A0 * IPv6 packet in buf and sends it directly back to the client via th=
e tun<br>@@ -1748,7 +1925,7 @@ process_outgoing_link(struct context *c, str=
uct link_socket *sock)<br><br>=C2=A0 =C2=A0 =C2=A0perf_push(PERF_PROC_OUT_L=
INK);<br><br>- =C2=A0 =C2=A0if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; c-&g=
t;c2.to_link.len &lt;=3D c-&gt;c2.frame.buf.payload_size)<br>+ =C2=A0 =C2=
=A0if (c-&gt;c2.to_link.len &gt; 0 &amp;&amp; (c-&gt;c2.to_link.len &lt;=3D=
 c-&gt;c2.frame.buf.payload_size || c-&gt;c2.frame.bulk_size &gt; 0))<br>=
=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 * Setup for call to send/sendto which will send<br=
>@@ -1793,6 +1970,7 @@ process_outgoing_link(struct context *c, struct link=
_socket *sock)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0fprintf(stderr, &quot;W&quot;);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>+<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0msg(D_LINK_RW, &quot;%s WRITE [%d] to %s: %s&quot;,<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0proto2ascii(sock-&gt=
;info.proto, sock-&gt;<a href=3D"http://info.af">info.af</a>, true), BLEN(&=
amp;c-&gt;c2.to_link),<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0print_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc), PROT=
O_DUMP(&amp;c-&gt;c2.to_link, &amp;gc));<br>@@ -1892,7 +2070,7 @@ process_o=
utgoing_link(struct context *c, struct link_socket *sock)<br>=C2=A0 */<br><=
br>=C2=A0void<br>-process_outgoing_tun(struct context *c, struct link_socke=
t *in_sock)<br>+process_outgoing_tun_part2(struct context *c, struct link_s=
ocket *in_sock)<br>=C2=A0{<br>=C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=
=A0 * Set up for write() call to TUN/TAP<br>@@ -1912,7 +2090,7 @@ process_o=
utgoing_tun(struct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=
=A0 =C2=A0process_ip_header(c, PIP_MSSFIX | PIPV4_EXTRACT_DHCP_ROUTER | PIP=
V4_CLIENT_NAT | PIP_OUTGOING,<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&amp;c-&gt;c2.to_tun, in_sock);<br=
><br>- =C2=A0 =C2=A0if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.buf.payl=
oad_size)<br>+ =C2=A0 =C2=A0if (c-&gt;c2.to_tun.len &lt;=3D c-&gt;c2.frame.=
buf.payload_size || c-&gt;c2.frame.bulk_size &gt; 0)<br>=C2=A0 =C2=A0 =C2=
=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 * Write to TUN/TAP device.<br>@@ -1925,7 +2103,8 @@ process_outgoin=
g_tun(struct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0fprintf(stderr, &quot;w&quot;);<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0#endif<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0dmsg(D_TUN_RW, &quot;TUN WRITE [%d]&quot;, BLEN(&amp;c-&gt;c2.to_tun));<=
br>+<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0dmsg(D_TUN_RW, &quot;TUN WRITE [%d] [%=
d]&quot;, BLEN(&amp;c-&gt;c2.to_tun), c-&gt;c2.frame.buf.payload_size);<br>=
<br>=C2=A0#ifdef PACKET_TRUNCATION_CHECK<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0ipv4_packet_size_verify(BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.t=
o_tun), TUNNEL_TYPE(c-&gt;c1.tuntap),<br>@@ -1981,6 +2160,39 @@ process_out=
going_tun(struct context *c, struct link_socket *in_sock)<br>=C2=A0 =C2=A0 =
=C2=A0perf_pop();<br>=C2=A0}<br><br>+void process_outgoing_tun_part3(struct=
 context *c, struct link_socket *in_sock)<br>+{<br>+ =C2=A0 =C2=A0if (check=
_bulk_mode(c))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int maxl=
 =3D 0, plen =3D 0;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0int leng =3D BLEN(&amp;=
c-&gt;c2.buffers-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0uint8_t=
 *temp =3D BPTR(&amp;c-&gt;c2.buffers-&gt;send_tun_max);<br>+ =C2=A0 =C2=A0=
 =C2=A0 =C2=A0temp +=3D 4; maxl +=3D 4;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0for=
 (int x =3D 0; x &lt; TUN_BAT_MAX; ++x)<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0{<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp =3D buff_postsize(temp, &=
amp;plen);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if ((leng &gt; 0) =
&amp;&amp; (plen &gt; 0) &amp;&amp; ((maxl + plen) &lt; leng))<br>+ =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun =3D c-&gt;c2.buffers-&gt;to_tun_max;<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.to_tun.=
offset =3D TUN_BAT_OFF;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0c-&gt;c2.to_tun.len =3D plen;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0bcopy(temp, BPTR(&amp;c-&gt;c2.to_tun), plen);<b=
r>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0temp +=3D plen; =
maxl +=3D (plen + 2);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0//dmsg(M_INFO, &quot;FWD BAT OUTP 1 [%d] [%d] [%d] [%d]&quot;, x, BL=
EN(&amp;c-&gt;c2.buf), BLEN(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.buffe=
rs-&gt;read_link_buf));<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0process_outgoing_tun_part2(c, in_sock);<br>+ =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0} else { break; }<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br=
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
t a/src/openvpn/init.c b/src/openvpn/init.c<br>index 40ae2c8c..47818bbb 100=
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
=C2=A0b-&gt;encrypt_buf =3D alloc_buf(buf_size);<br>diff --git a/src/openvp=
n/mtu.c b/src/openvpn/mtu.c<br>index a419e32d..7e35c837 100644<br>--- a/src=
/openvpn/mtu.c<br>+++ b/src/openvpn/mtu.c<br>@@ -41,9 +41,15 @@ void<br>=C2=
=A0alloc_buf_sock_tun(struct buffer *buf, const struct frame *frame)<br>=C2=
=A0{<br>=C2=A0 =C2=A0 =C2=A0/* allocate buffer for overlapped I/O */<br>- =
=C2=A0 =C2=A0*buf =3D alloc_buf(BUF_SIZE(frame));<br>+ =C2=A0 =C2=A0size_t =
alen =3D BUF_SIZE(frame);<br>+ =C2=A0 =C2=A0size_t blen =3D frame-&gt;buf.p=
ayload_size;<br>+ =C2=A0 =C2=A0if (frame-&gt;bulk_size &gt; 0) {<br>+ =C2=
=A0 =C2=A0 =C2=A0 =C2=A0alen =3D BAT_SIZE(TUN_BAT_MAX, frame-&gt;tun_mtu, T=
UN_BAT_OFF);<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0blen =3D BAT_SIZE(TUN_BAT_MAX,=
 frame-&gt;tun_mtu, TUN_BAT_NOP);<br>+ =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0*bu=
f =3D alloc_buf(alen);<br>=C2=A0 =C2=A0 =C2=A0ASSERT(buf_init(buf, frame-&g=
t;buf.headroom));<br>- =C2=A0 =C2=A0buf-&gt;len =3D frame-&gt;buf.payload_s=
ize;<br>+ =C2=A0 =C2=A0buf-&gt;len =3D blen;<br>=C2=A0 =C2=A0 =C2=A0ASSERT(=
buf_safe(buf, 0));<br>=C2=A0}<br><br>diff --git a/src/openvpn/mtu.h b/src/o=
penvpn/mtu.h<br>index 925ef0bf..eb799fb3 100644<br>--- a/src/openvpn/mtu.h<=
br>+++ b/src/openvpn/mtu.h<br>@@ -58,6 +58,14 @@<br>=C2=A0 */<br>=C2=A0#def=
ine TUN_MTU_MIN 100<br><br>+/*<br>+ * Bulk mode static define values.<br>+ =
*/<br>+#define TUN_BAT_MIN =C2=A0 =C2=A0 =C2=A0 =C2=A06<br>+#define TUN_BAT=
_MAX =C2=A0 =C2=A0 =C2=A0 =C2=A09<br>+#define TUN_BAT_OFF =C2=A0 =C2=A0 =C2=
=A0 =C2=A0256<br>+#define TUN_BAT_NOP =C2=A0 =C2=A0 =C2=A0 =C2=A00<br>+<br>=
=C2=A0/*<br>=C2=A0 * Default MTU of network over which tunnel data will pas=
s by TCP/UDP.<br>=C2=A0 */<br>@@ -152,6 +160,10 @@ struct frame<br>=C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 which defaults to 0 for tun and 32<br>=C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 (\c TAP_MTU_EXTRA_DEFAULT) for tap.<br>=
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0* =C2=A0 */<br>+<br>+ =C2=A0 =C2=A0int bulk_=
size; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/**&lt; Signal to the=
 init frame function<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * =C2=A0 to =
allow for bulk mode TCP transfers.<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 * =C2=A0 */<br>=C2=A0};<br><br>=C2=A0/* Forward declarations, to preven=
t includes */<br>@@ -171,6 +183,7 @@ struct options;<br>=C2=A0 * larger tha=
n the headroom.<br>=C2=A0 */<br>=C2=A0#define BUF_SIZE(f) ((f)-&gt;buf.head=
room + (f)-&gt;buf.payload_size + (f)-&gt;buf.tailroom)<br>+#define BAT_SIZ=
E(a, b, c) ((a * b) + c)<br><br>=C2=A0/*<br>=C2=A0 * Function prototypes.<b=
r>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c<br>index e1ce32ab.=
.9e089703 100644<br>--- a/src/openvpn/multi.c<br>+++ b/src/openvpn/multi.c<=
br>@@ -3414,6 +3414,7 @@ multi_process_incoming_link(struct multi_context *=
m, struct multi_instance *inst<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0}<br><br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0process_incoming_link_part2(c, lsi, orig_buf);<br>+ =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0process_incoming_link_part=
3(c);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0perf_pop();<br><br>@@ -3558,9 +3559,7 @@=
 multi_process_incoming_tun(struct multi_context *m, const unsigned int mpp=
_flags<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0const int dev_type =3D TUNNEL_T=
YPE(m-&gt;top.c1.tuntap);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int16_t vid =
=3D 0;<br><br>-#ifdef MULTI_DEBUG_EVENT_LOOP<br>- =C2=A0 =C2=A0 =C2=A0 =C2=
=A0printf(&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf)=
);<br>-#endif<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0msg(D_MULTI_DEBUG, &quot;TUN =
-&gt; TCP/UDP [%d]&quot;, BLEN(&amp;m-&gt;top.c2.buf));<br><br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0if (m-&gt;pending)<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0{<br>@@ -3610,6 +3609,8 @@ multi_process_incoming_tun(struct multi_co=
ntext *m, const unsigned int mpp_flags<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0/* transfer packet pointer from top-level context buffe=
r to instance */<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0c-&gt;c2.buf =3D m-&gt;top=
.c2.buf;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* todo determine if to call this (mu=
lti_process_incoming_tun) for each bulk item read? */<br>+ =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0xfer_io(c, &amp;m-&gt;top);<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0else<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>diff --git a/src/openvpn/openvpn.h b/src/op=
envpn/openvpn.h<br>index cd99cd40..21fa8967 100644<br>--- a/src/openvpn/ope=
nvpn.h<br>+++ b/src/openvpn/openvpn.h<br>@@ -112,6 +112,14 @@ struct contex=
t_buffers<br>=C2=A0 =C2=A0 =C2=A0 */<br>=C2=A0 =C2=A0 =C2=A0struct buffer r=
ead_link_buf;<br>=C2=A0 =C2=A0 =C2=A0struct buffer read_tun_buf;<br>+<br>+ =
=C2=A0 =C2=A0struct buffer read_tun_bufs[TUN_BAT_MAX];<br>+ =C2=A0 =C2=A0st=
ruct buffer read_tun_max;<br>+ =C2=A0 =C2=A0struct buffer send_tun_max;<br>=
+ =C2=A0 =C2=A0struct buffer to_tun_max;<br>+<br>+ =C2=A0 =C2=A0int bufs_in=
dx;<br>+ =C2=A0 =C2=A0int flag_ciph;<br>=C2=A0};<br><br>=C2=A0/*<br>@@ -376=
,6 +384,8 @@ struct context_2<br>=C2=A0 =C2=A0 =C2=A0struct buffer to_tun;<=
br>=C2=A0 =C2=A0 =C2=A0struct buffer to_link;<br><br>+ =C2=A0 =C2=A0struct =
buffer bufs[TUN_BAT_MAX];<br>+<br>=C2=A0 =C2=A0 =C2=A0/* should we print R|=
W|r|w to console on packet transfers? */<br>=C2=A0 =C2=A0 =C2=A0bool log_rw=
;<br><br>diff --git a/src/openvpn/options.c b/src/openvpn/options.c<br>inde=
x c54032d8..041d17d0 100644<br>--- a/src/openvpn/options.c<br>+++ b/src/ope=
nvpn/options.c<br>@@ -304,6 +304,7 @@ static const char usage_message[] =3D=
<br>=C2=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0&#39;maybe&#39; -- Use per-route hints\n&quot;<br>=C2=
=A0 =C2=A0 =C2=A0&quot; =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0&#39;yes&#39; =C2=A0 -- Always DF (Don&#39;t Fragment)\n&quot;=
<br>=C2=A0 =C2=A0 =C2=A0&quot;--mtu-test =C2=A0 =C2=A0 =C2=A0: Empirically =
measure and report MTU.\n&quot;<br>+ =C2=A0 =C2=A0&quot;--bulk-mode =C2=A0 =
=C2=A0 : Use bulk TUN/TCP reads/writes.\n&quot;<br>=C2=A0#ifdef ENABLE_FRAG=
MENT<br>=C2=A0 =C2=A0 =C2=A0&quot;--fragment max =C2=A0: Enable internal da=
tagram fragmentation so that no UDP\n&quot;<br>=C2=A0 =C2=A0 =C2=A0&quot; =
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0datagrams are=
 sent which are larger than max bytes.\n&quot;<br>@@ -3005,6 +3006,9 @@ opt=
ions_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)<=
br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;tun_mtu_extra_def=
ined =3D true;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;tu=
n_mtu_extra =3D TAP_MTU_EXTRA_DEFAULT;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0}<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0if (ce-&gt;proto !=3D PROTO_TCP &amp;&=
amp; ce-&gt;proto !=3D PROTO_TCP_SERVER &amp;&amp; ce-&gt;proto !=3D PROTO_=
TCP_CLIENT) {<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0ce-&gt;bulk_mod=
e =3D false;<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>=
<br>=C2=A0 =C2=A0 =C2=A0/*<br>@@ -9926,6 +9930,10 @@ add_option(struct opti=
ons *options, char *p[], bool is_inline, const char *file,<br>=C2=A0 =C2=A0=
 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0goto err;<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0}<br>=C2=A0 =C2=A0 =C2=A0}<br>+ =C2=A0 =C2=A0else if (streq(p[0], &q=
uot;bulk-mode&quot;))<br>+ =C2=A0 =C2=A0{<br>+ =C2=A0 =C2=A0 =C2=A0 =C2=A0o=
ptions-&gt;ce.bulk_mode =3D true;<br>+ =C2=A0 =C2=A0}<br>=C2=A0 =C2=A0 =C2=
=A0else<br>=C2=A0 =C2=A0 =C2=A0{<br>=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0int i=
;<br>diff --git a/src/openvpn/options.h b/src/openvpn/options.h<br>index 38=
e67c8d..d1b0586d 100644<br>--- a/src/openvpn/options.h<br>+++ b/src/openvpn=
/options.h<br>@@ -174,6 +174,9 @@ struct connection_entry<br><br>=C2=A0 =C2=
=A0 =C2=A0/* Allow only client that support resending the wrapped client ke=
y */<br>=C2=A0 =C2=A0 =C2=A0bool tls_crypt_v2_force_cookie;<br>+<br>+ =C2=
=A0 =C2=A0/* Bulk mode allows for multiple tun reads + larger tcp writes */=
<br>+ =C2=A0 =C2=A0bool bulk_mode;<br>=C2=A0};<br><br>=C2=A0struct remote_e=
ntry<br>--<br>2.39.5 (Apple Git-154)<br></div><div><br></div><div><br><div>=
<br></div><div><br><div><br></div><div><br></div><div><br></div><div><br></=
div></div></div></div>

--0000000000006630a3063bbb0152--

