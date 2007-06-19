Message-ID: <4677F4A8.5030208@...1032...>
Date: Tue, 19 Jun 2007 18:22:16 +0300
From: =?ISO-8859-1?Q?Siim_P=F5der?= <siim@...1032...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------080905040200070107090903"
Subject: [Openvpn-devel] Packing small packets to a bigger packet
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------080905040200070107090903
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

Hi!

I see my openvpn handling a lot of small packets (around 100 bytes) at a
high rate. I have seen packing smaller packets into one bigger packet
suggested but the idea always rejected for various reasons.

Anyways, I made a little patch to do that (works agains 2.1rc4), and did
a couple of quick tests. I run 50 ping -i 0 -s 153 for 30 seconds,
observing CPU usage and made note of bytes transfered over the link. In
both cases, 18.7MB was pushed back and forth (pings, you know).

I looked at CPU usage with top, so it is a tad subjective measure, but
with multipacketing the cpu usage was mostly something like 10%-15%, but
without it more like 20% (I used UDP transport with TLS layer).

So it can probably give an advantage in some cases.

I submit the patch to your scrutiny

Siim P=F5der


--------------080905040200070107090903
Content-Type: text/x-patch;
 name="openvpn-2.1~rc2-multipacket.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="openvpn-2.1~rc2-multipacket.patch"

diff -aur openvpn-2.1~rc2/forward.c openvpn-2.1~rc2-multipacket/forward.c
--- openvpn-2.1~rc2/forward.c	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1~rc2-multipacket/forward.c	2007-06-18 17:12:36.000000000 +0300
@@ -867,6 +867,69 @@
 }
 
 /*
+ * Pack multiple packets into the buffer
+ * Output: c->c2.buf
+ */
+
+void
+read_incoming_tun_mp(struct context *c)
+{
+  int readlen = 0, packets = 0;
+  BLEN (&c->c2.buf) = 0;
+
+  ASSERT (buf_init (&c->c2.buf, FRAME_HEADROOM (&c->c2.frame)));
+  ASSERT (buf_safe (&c->c2.buf, MAX_RW_SIZE_TUN (&c->c2.frame)));
+
+  /* First check if there was a packet left out from last batch and use that one */
+  if (BLEN (&c->c2.from_tun_of) != 0)
+  {
+    memcpy(BPTR (&c->c2.buf), BPTR (&c->c2.from_tun_of), BLEN (&c->c2.from_tun_of));
+    BLEN (&c->c2.buf) = BLEN (&c->c2.from_tun_of);
+    BLEN (&c->c2.from_tun_of) = 0;
+  }
+
+  /* Read more packets to fill the buffer */
+  while (MAX_RW_SIZE_TUN (&c->c2.frame) - BLEN (&c->c2.buf) - 2 > 0)
+  {
+    readlen = read_tun (c->c1.tuntap, BPTR (&c->c2.buf) + BLEN (&c->c2.buf) + 2, MAX_RW_SIZE_TUN (&c->c2.frame));
+    if (readlen > 0)
+    {
+      packets++;
+      *(uint16_t*) (BPTR (&c->c2.buf) + BLEN (&c->c2.buf)) = readlen;
+      BLEN (&c->c2.buf) += readlen + 2;
+    }
+    else
+      break;
+  }
+
+  /* Last packet does not fit MTU, keep it post-buffer for retrieval next time around */
+  if (BLEN (&c->c2.buf) > MAX_RW_SIZE_TUN (&c->c2.frame))
+  {
+    BLEN (&c->c2.buf) -= readlen + 2;
+    memcpy(&c->c2.from_tun_of, &c->c2.buf, sizeof(struct buffer));
+    c->c2.from_tun_of.offset += BLEN (&c->c2.buf);
+    BLEN (&c->c2.from_tun_of) = readlen + 2;
+#ifdef PACKET_TRUNCATION_CHECK
+    ipv4_packet_size_verify (BPTR (&c->c2.from_tun_of) + c->c2.from_tun_of.offset + 2,
+			     BLEN (&c->c2.from_tun_of) - 2,
+			     TUNNEL_TYPE (c->c1.tuntap),
+			     "READ_TUN",
+			     &c->c2.n_trunc_tun_read);
+#endif
+  }
+#ifdef PACKET_TRUNCATION_CHECK
+  else if (packets == 1)
+  {
+    ipv4_packet_size_verify (BPTR (&c->c2.buf) + 2,
+			     BLEN (&c->c2.buf) - 2,
+			     TUNNEL_TYPE (c->c1.tuntap),
+			     "READ_TUN",
+			     &c->c2.n_trunc_tun_read);
+  }
+#endif
+}
+
+/*
  * Output: c->c2.buf
  */
 
@@ -881,21 +944,26 @@
   perf_push (PERF_READ_IN_TUN);
 
   c->c2.buf = c->c2.buffers->read_tun_buf;
+  if (c->options.multipacket)
+    read_incoming_tun_mp (c);
+  else
+  {
 #ifdef TUN_PASS_BUFFER
-  read_tun_buffered (c->c1.tuntap, &c->c2.buf, MAX_RW_SIZE_TUN (&c->c2.frame));
+    read_tun_buffered (c->c1.tuntap, &c->c2.buf, MAX_RW_SIZE_TUN (&c->c2.frame));
 #else
-  ASSERT (buf_init (&c->c2.buf, FRAME_HEADROOM (&c->c2.frame)));
-  ASSERT (buf_safe (&c->c2.buf, MAX_RW_SIZE_TUN (&c->c2.frame)));
-  c->c2.buf.len = read_tun (c->c1.tuntap, BPTR (&c->c2.buf), MAX_RW_SIZE_TUN (&c->c2.frame));
+    ASSERT (buf_init (&c->c2.buf, FRAME_HEADROOM (&c->c2.frame)));
+    ASSERT (buf_safe (&c->c2.buf, MAX_RW_SIZE_TUN (&c->c2.frame)));
+    c->c2.buf.len = read_tun (c->c1.tuntap, BPTR (&c->c2.buf), MAX_RW_SIZE_TUN (&c->c2.frame));
 #endif
 
 #ifdef PACKET_TRUNCATION_CHECK
-  ipv4_packet_size_verify (BPTR (&c->c2.buf),
-			   BLEN (&c->c2.buf),
-			   TUNNEL_TYPE (c->c1.tuntap),
-			   "READ_TUN",
-			   &c->c2.n_trunc_tun_read);
+    ipv4_packet_size_verify (BPTR (&c->c2.buf),
+			     BLEN (&c->c2.buf),
+			     TUNNEL_TYPE (c->c1.tuntap),
+			     "READ_TUN",
+			     &c->c2.n_trunc_tun_read);
 #endif
+  }
 
   /* Was TUN/TAP interface stopped? */
   if (tuntap_stop (c->c2.buf.len))
@@ -1160,6 +1228,25 @@
 #endif
       dmsg (D_TUN_RW, "TUN WRITE [%d]", BLEN (&c->c2.to_tun));
 
+      /* if multiple packets are packed into one frame */
+      if (c->options.multipacket)
+      {
+        size = 0;
+	//fprintf(stderr, "Multipacketing\n");
+        while (size < BLEN (&c->c2.to_tun))
+	{
+#ifdef PACKET_TRUNCATION_CHECK
+          ipv4_packet_size_verify (BPTR (&c->c2.to_tun) + size + 2,
+			           *(uint16_t*) (BPTR (&c->c2.to_tun) + size),
+			           TUNNEL_TYPE (c->c1.tuntap),
+			           "WRITE_TUN",
+			           &c->c2.n_trunc_tun_write);
+#endif
+          size += write_tun (c->c1.tuntap, BPTR (&c->c2.to_tun) + size + 2, *(uint16_t*) (BPTR (&c->c2.to_tun) + size) ) + 2;
+	}
+      }
+      else /* not multipacket */
+      {
 #ifdef PACKET_TRUNCATION_CHECK
       ipv4_packet_size_verify (BPTR (&c->c2.to_tun),
 			       BLEN (&c->c2.to_tun),
@@ -1173,7 +1260,6 @@
 #else
       size = write_tun (c->c1.tuntap, BPTR (&c->c2.to_tun), BLEN (&c->c2.to_tun));
 #endif
-
       if (size > 0)
 	c->c2.tun_write_bytes += size;
       check_status (size, "write to TUN/TAP", NULL, c->c1.tuntap);
@@ -1192,6 +1278,7 @@
 	  /* indicate activity regarding --inactive parameter */
 	  register_activity (c, size);
 	}
+      }
     }
   else
     {
diff -aur openvpn-2.1~rc2/init.c openvpn-2.1~rc2-multipacket/init.c
--- openvpn-2.1~rc2/init.c	2006-11-23 23:35:20.000000000 +0200
+++ openvpn-2.1~rc2-multipacket/init.c	2007-06-18 16:11:50.000000000 +0300
@@ -1816,7 +1816,7 @@
   ALLOC_OBJ_CLEAR (b, struct context_buffers);
 
   b->read_link_buf = alloc_buf (BUF_SIZE (frame));
-  b->read_tun_buf = alloc_buf (BUF_SIZE (frame));
+  b->read_tun_buf = alloc_buf (BUF_SIZE (frame) * 2);
 
   b->aux_buf = alloc_buf (BUF_SIZE (frame));
 
@@ -1865,6 +1865,7 @@
 {
   c->c2.buffers = init_context_buffers (&c->c2.frame);
   c->c2.buffers_owned = true;
+  c->c2.from_tun_of.len = 0;
 }
 
 #ifdef ENABLE_FRAGMENT
Only in openvpn-2.1~rc2/install-win32: openvpn.nsi
diff -aur openvpn-2.1~rc2/openvpn.h openvpn-2.1~rc2-multipacket/openvpn.h
--- openvpn-2.1~rc2/openvpn.h	2006-11-23 23:34:40.000000000 +0200
+++ openvpn-2.1~rc2-multipacket/openvpn.h	2007-06-18 16:14:09.000000000 +0300
@@ -357,6 +357,7 @@
    * struct context_buffers.
    */
   struct buffer buf;
+  struct buffer from_tun_of;
   struct buffer to_tun;
   struct buffer to_link;
 
Only in openvpn-2.1~rc2: openvpn.spec
diff -aur openvpn-2.1~rc2/options.c openvpn-2.1~rc2-multipacket/options.c
--- openvpn-2.1~rc2/options.c	2007-02-28 05:50:35.000000000 +0200
+++ openvpn-2.1~rc2-multipacket/options.c	2007-06-18 16:11:50.000000000 +0300
@@ -298,6 +298,7 @@
   "--comp-noadapt  : Don't use adaptive compression when --comp-lzo\n"
   "                  is specified.\n"
 #endif
+  "--multipacket   : Pack consequtive small packets into one bigger packet.\n"
 #ifdef ENABLE_MANAGEMENT
   "--management ip port [pass] : Enable a TCP server on ip:port to handle\n"
   "                  management functions.  pass is a password file\n"
@@ -1177,6 +1178,8 @@
   SHOW_INT (lzo);
 #endif
 
+  SHOW_BOOL (multipacket);
+
   SHOW_STR (route_script);
   SHOW_STR (route_default_gateway);
   SHOW_INT (route_default_metric);
@@ -2004,6 +2007,8 @@
  * --comp-lzo
  * --fragment
  *
+ * --multipacket
+ *
  * Crypto Options:
  *
  * --cipher
@@ -2081,6 +2086,9 @@
     buf_printf (&out, ",comp-lzo");
 #endif
 
+  if (o->multipacket)
+    buf_printf (&out, ",multipacket");
+
 #ifdef ENABLE_FRAGMENT
   if (o->fragment)
     buf_printf (&out, ",mtu-dynamic");
@@ -4651,6 +4659,11 @@
       options->lzo &= ~LZO_ADAPTIVE;
     }
 #endif /* USE_LZO */
+  else if (streq (p[0], "multipacket"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->multipacket = true;
+    }
 #ifdef USE_CRYPTO
   else if (streq (p[0], "show-ciphers"))
     {
diff -aur openvpn-2.1~rc2/options.h openvpn-2.1~rc2-multipacket/options.h
--- openvpn-2.1~rc2/options.h	2006-10-16 01:30:21.000000000 +0300
+++ openvpn-2.1~rc2-multipacket/options.h	2007-06-18 16:14:09.000000000 +0300
@@ -236,6 +236,9 @@
   unsigned int lzo;
 #endif
 
+  /* pack consequtive small packets into one MTU-sized packet */
+  bool multipacket;
+
   /* buffer sizes */
   int rcvbuf;
   int sndbuf;


--------------080905040200070107090903--

