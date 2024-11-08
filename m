From: Gert Doering <gert@...1296...>
Date: Fri,  8 Nov 2024 18:38:51 +0100
Message-ID: <20241108173851.436-1-gert@...1296...>
In-Reply-To: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
References: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Remove support for compression on send
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

We can't disable compression support on receive because
that would break too many configurations out there. But
we can remove the support for compressing outgoing traffic,
it was disabled by default anyway.

Makes "--allow-compression yes" an alias for
"--allow-compression asym" and removes all resulting dead code.

Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/755
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/Changes.rst b/Changes.rst
index 7d19577..a6cc3be 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -59,6 +59,12 @@
     Support for building with OpenSSL 1.0.2 has been removed. The minimum
     supported OpenSSL version is now 1.1.0.
 
+Compression on send
+    OpenVPN 2.7 will never compress data before sending. Decompression of
+    received data is still supported.
+    ``--allow-compression yes`` is now an alias for
+    ``--allow-compression asym``.
+
 Overview of changes in 2.6
 ==========================
 
diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst
index 8b061d2..05f87cc 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -10,17 +10,11 @@
   dangerous option.  This option allows controlling the behaviour of
   OpenVPN when compression is used and allowed.
 
-  Valid syntaxes:
-  ::
-
-      allow-compression
-      allow-compression mode
-
   The ``mode`` argument can be one of the following values:
 
   :code:`asym`
-      OpenVPN will only *decompress downlink packets* but *not compress
-      uplink packets*.  This also allows migrating to disable compression
+      OpenVPN will only *decompress incoming packets* but *not compress
+      outgoing packets*.  This also allows migrating to disable compression
       when changing both server and client configurations to remove
       compression at the same time is not a feasible option.
 
@@ -30,7 +24,9 @@
       framing (stub).
 
   :code:`yes`
-      OpenVPN will send and receive compressed packets.
+      **DEPRECATED** This option is an alias for :code:`asym`. Previously
+      it did enable compression for outgoing packets, but OpenVPN never
+      compresses packets on send now.
 
 --auth alg
   Authenticate data channel packets and (if enabled) ``tls-auth`` control
@@ -135,48 +131,26 @@
   entirely sure that the above does not apply to your traffic, you are
   advised to *not* enable compression.
 
+  For this reason compression support was removed from current versions
+  of OpenVPN. It will still decompress compressed packets received via
+  a VPN connection but it will never compress any outgoing packets.
+
 --comp-lzo mode
   **DEPRECATED** Enable LZO compression algorithm.  Compression is
   generally not recommended.  VPN tunnels which uses compression are
   suspectible to the VORALCE attack vector.
 
-  Use LZO compression -- may add up to 1 byte per packet for incompressible
-  data. ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
-  (default).
+  Allows the other side of the connection to use LZO compression. Due
+  to difference in packet format this may add 1 additional byte per packet.
+  With current versions of OpenVPN no actual compression will happen.
 
-  In a server mode setup, it is possible to selectively turn compression
-  on or off for individual clients.
+  ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`
+  but there is no actual change in behavior anymore.
 
-  First, make sure the client-side config file enables selective
-  compression by having at least one ``--comp-lzo`` directive, such as
-  ``--comp-lzo no``. This will turn off compression by default, but allow
-  a future directive push from the server to dynamically change the
-  :code:`on`/:code:`off`/:code:`adaptive` setting.
-
-  Next in a ``--client-config-dir`` file, specify the compression setting
-  for the client, for example:
-  ::
-
-    comp-lzo yes
-    push "comp-lzo yes"
-
-  The first line sets the ``comp-lzo`` setting for the server side of the
-  link, the second sets the client side.
 
 --comp-noadapt
-  **DEPRECATED** When used in conjunction with ``--comp-lzo``, this option
-  will disable OpenVPN's adaptive compression algorithm. Normally, adaptive
-  compression is enabled with ``--comp-lzo``.
-
-  Adaptive compression tries to optimize the case where you have
-  compression enabled, but you are sending predominantly incompressible
-  (or pre-compressed) packets over the tunnel, such as an FTP or rsync
-  transfer of a large, compressed file. With adaptive compression, OpenVPN
-  will periodically sample the compression process to measure its
-  efficiency. If the data being sent over the tunnel is already
-  compressed, the compression efficiency will be very low, triggering
-  openvpn to disable compression for a period of time until the next
-  re-sample test.
+  **DEPRECATED** This option does not have any effect anymore since current
+  versions of OpenVPN never compress outgoing packets.
 
 --key-direction
   Alternative way of specifying the optional direction parameter for the
diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4.c
index ac020a4..b35df4a 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -55,129 +55,40 @@
 {
 }
 
-static bool
-do_lz4_compress(struct buffer *buf,
-                struct buffer *work,
-                struct compress_context *compctx,
-                const struct frame *frame)
-{
-    /*
-     * In order to attempt compression, length must be at least COMPRESS_THRESHOLD.
-     * and asymmetric compression must be disabled
-     */
-    if (buf->len >= COMPRESS_THRESHOLD && (compctx->flags & COMP_F_ALLOW_COMPRESS))
-    {
-        const size_t ps = frame->buf.payload_size;
-        int zlen_max = ps + COMP_EXTRA_BUFFER(ps);
-        int zlen;
-
-        ASSERT(buf_init(work, frame->buf.headroom));
-        ASSERT(buf_safe(work, zlen_max));
-
-        if (buf->len > ps)
-        {
-            dmsg(D_COMP_ERRORS, "LZ4 compression buffer overflow");
-            buf->len = 0;
-            return false;
-        }
-
-        zlen = LZ4_compress_default((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf), zlen_max);
-
-        if (zlen <= 0)
-        {
-            dmsg(D_COMP_ERRORS, "LZ4 compression error");
-            buf->len = 0;
-            return false;
-        }
-
-        ASSERT(buf_safe(work, zlen));
-        work->len = zlen;
-
-
-        dmsg(D_COMP, "LZ4 compress %d -> %d", buf->len, work->len);
-        compctx->pre_compress += buf->len;
-        compctx->post_compress += work->len;
-        return true;
-    }
-    return false;
-}
-
-
+/* Doesn't do any actual compression anymore */
 static void
 lz4_compress(struct buffer *buf, struct buffer work,
              struct compress_context *compctx,
              const struct frame *frame)
 {
-    bool compressed;
     if (buf->len <= 0)
     {
         return;
     }
 
-    compressed = do_lz4_compress(buf, &work, compctx, frame);
+    uint8_t comp_head_byte = NO_COMPRESS_BYTE_SWAP;
+    uint8_t *head = BPTR(buf);
+    uint8_t *tail = BEND(buf);
+    ASSERT(buf_safe(buf, 1));
+    ++buf->len;
 
-    /* On error do_lz4_compress sets buf len to zero, just return */
-    if (buf->len == 0)
-    {
-        return;
-    }
-
-    /* did compression save us anything? */
-    {
-        uint8_t comp_head_byte = NO_COMPRESS_BYTE_SWAP;
-        if (compressed && work.len < buf->len)
-        {
-            *buf = work;
-            comp_head_byte = LZ4_COMPRESS_BYTE;
-        }
-
-        {
-            uint8_t *head = BPTR(buf);
-            uint8_t *tail  = BEND(buf);
-            ASSERT(buf_safe(buf, 1));
-            ++buf->len;
-
-            /* move head byte of payload to tail */
-            *tail = *head;
-            *head = comp_head_byte;
-        }
-    }
+    /* move head byte of payload to tail */
+    *tail = *head;
+    *head = comp_head_byte;
 }
 
-
+/* Doesn't do any actual compression anymore */
 static void
 lz4v2_compress(struct buffer *buf, struct buffer work,
                struct compress_context *compctx,
                const struct frame *frame)
 {
-    bool compressed;
     if (buf->len <= 0)
     {
         return;
     }
 
-    compressed = do_lz4_compress(buf, &work, compctx, frame);
-
-    /* On Error just return */
-    if (buf->len == 0)
-    {
-        return;
-    }
-
-    /* did compression save us anything?  Include 2 byte compression header
-     * in calculation */
-    if (compressed && work.len + 2 < buf->len)
-    {
-        ASSERT(buf_prepend(&work, 2));
-        uint8_t *head = BPTR(&work);
-        head[0] = COMP_ALGV2_INDICATOR_BYTE;
-        head[1] = COMP_ALGV2_LZ4_BYTE;
-        *buf = work;
-    }
-    else
-    {
-        compv2_escape_data_ifneeded(buf);
-    }
+    compv2_escape_data_ifneeded(buf);
 }
 
 static void
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 267f680b..7eed331 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -32,8 +32,10 @@
  * outside of the USE_COMP define */
 
 /* Compression flags */
-#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
-#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compressed but also uplink */
+/* Removed
+ #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
+ #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compressed but also outgoing * /
+ */
 #define COMP_F_SWAP                 (1<<2) /* initial command byte is swapped with last byte in buffer to preserve payload alignment */
 #define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only support compression stubs */
 #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 38f934a..dcc80d3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -426,8 +426,7 @@
 
 #if defined(USE_COMP)
     if (o->comp.alg != COMP_ALG_UNDEF
-        || o->comp.flags & COMP_F_ALLOW_ASYM
-        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
+        || o->comp.flags & COMP_F_ALLOW_ASYM)
     {
         msg(msglevel, "Note: '--allow-compression' is not set to 'no', disabling data channel offload.");
 
diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index bab2d78..5cd5ea2 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -39,61 +39,6 @@
 
 #include "memdbg.h"
 
-/**
- * Perform adaptive compression housekeeping.
- *
- * @param ac the adaptive compression state structure.
- *
- * @return
- */
-static bool
-lzo_adaptive_compress_test(struct lzo_adaptive_compress *ac)
-{
-    const bool save = ac->compress_state;
-    const time_t local_now = now;
-
-    if (!ac->compress_state)
-    {
-        if (local_now >= ac->next)
-        {
-            if (ac->n_total > AC_MIN_BYTES
-                && (ac->n_total - ac->n_comp) < (ac->n_total / (100 / AC_SAVE_PCT)))
-            {
-                ac->compress_state = true;
-                ac->next = local_now + AC_OFF_SEC;
-            }
-            else
-            {
-                ac->next = local_now + AC_SAMP_SEC;
-            }
-            dmsg(D_COMP, "lzo_adaptive_compress_test: comp=%d total=%d", ac->n_comp, ac->n_total);
-            ac->n_total = ac->n_comp = 0;
-        }
-    }
-    else
-    {
-        if (local_now >= ac->next)
-        {
-            ac->next = local_now + AC_SAMP_SEC;
-            ac->n_total = ac->n_comp = 0;
-            ac->compress_state = false;
-        }
-    }
-
-    if (ac->compress_state != save)
-    {
-        dmsg(D_COMP_LOW, "Adaptive compression state %s", (ac->compress_state ? "OFF" : "ON"));
-    }
-
-    return !ac->compress_state;
-}
-
-static inline void
-lzo_adaptive_compress_data(struct lzo_adaptive_compress *ac, int n_total, int n_comp)
-{
-    ac->n_total += n_total;
-    ac->n_comp += n_comp;
-}
 
 static void
 lzo_compress_init(struct compress_context *compctx)
@@ -118,92 +63,13 @@
     compctx->wu.lzo.wmem = NULL;
 }
 
-static inline bool
-lzo_compression_enabled(struct compress_context *compctx)
-{
-    if (!(compctx->flags & COMP_F_ALLOW_COMPRESS))
-    {
-        return false;
-    }
-    else
-    {
-        if (compctx->flags & COMP_F_ADAPTIVE)
-        {
-            return lzo_adaptive_compress_test(&compctx->wu.lzo.ac);
-        }
-        else
-        {
-            return true;
-        }
-    }
-}
-
 static void
 lzo_compress(struct buffer *buf, struct buffer work,
              struct compress_context *compctx,
              const struct frame *frame)
 {
-    lzo_uint zlen = 0;
-    int err;
-    bool compressed = false;
-
-    if (buf->len <= 0)
-    {
-        return;
-    }
-
-    /*
-     * In order to attempt compression, length must be at least COMPRESS_THRESHOLD,
-     * and our adaptive level must give the OK.
-     */
-    if (buf->len >= COMPRESS_THRESHOLD && lzo_compression_enabled(compctx))
-    {
-        const size_t ps = frame->buf.payload_size;
-        ASSERT(buf_init(&work, frame->buf.headroom));
-        ASSERT(buf_safe(&work, ps + COMP_EXTRA_BUFFER(ps)));
-
-        if (buf->len > ps)
-        {
-            dmsg(D_COMP_ERRORS, "LZO compression buffer overflow");
-            buf->len = 0;
-            return;
-        }
-
-        err = LZO_COMPRESS(BPTR(buf), BLEN(buf), BPTR(&work), &zlen, compctx->wu.lzo.wmem);
-        if (err != LZO_E_OK)
-        {
-            dmsg(D_COMP_ERRORS, "LZO compression error: %d", err);
-            buf->len = 0;
-            return;
-        }
-
-        ASSERT(buf_safe(&work, zlen));
-        work.len = zlen;
-        compressed = true;
-
-        dmsg(D_COMP, "LZO compress %d -> %d", buf->len, work.len);
-        compctx->pre_compress += buf->len;
-        compctx->post_compress += work.len;
-
-        /* tell adaptive level about our success or lack thereof in getting any size reduction */
-        if (compctx->flags & COMP_F_ADAPTIVE)
-        {
-            lzo_adaptive_compress_data(&compctx->wu.lzo.ac, buf->len, work.len);
-        }
-    }
-
-    /* did compression save us anything ? */
-    if (compressed && work.len < buf->len)
-    {
-        uint8_t *header = buf_prepend(&work, 1);
-        *header = LZO_COMPRESS_BYTE;
-        *buf = work;
-    }
-    else
-    {
-        uint8_t *header = buf_prepend(buf, 1);
-        *header = NO_COMPRESS_BYTE;
-    }
+    uint8_t *header = buf_prepend(buf, 1);
+    *header = NO_COMPRESS_BYTE;
 }
 
 static void
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 61f6285..1beb0ee 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5715,17 +5715,10 @@
 {
     if (comp_non_stub_enabled(info))
     {
-        /*
-         * Check if already displayed the strong warning and enabled full
-         * compression
-         */
-        if (!(info->flags & COMP_F_ALLOW_COMPRESS))
-        {
-            msg(M_WARN, "WARNING: Compression for receiving enabled. "
-                "Compression has been used in the past to break encryption. "
-                "Sent packets are not compressed unless \"allow-compression yes\" "
-                "is also set.");
-        }
+        msg(M_WARN, "WARNING: Compression for receiving enabled. "
+            "Compression has been used in the past to break encryption. "
+            "Compression support is deprecated and we recommend to disable "
+            "it completely.");
     }
 }
 
@@ -8435,18 +8428,14 @@
         }
         else if (streq(p[1], "asym"))
         {
-            options->comp.flags &= ~COMP_F_ALLOW_COMPRESS;
             options->comp.flags |= COMP_F_ALLOW_ASYM;
         }
         else if (streq(p[1], "yes"))
         {
-            msg(M_WARN, "WARNING: Compression for sending and receiving enabled. Compression has "
-                "been used in the past to break encryption. Allowing compression allows "
-                "attacks that break encryption. Using \"--allow-compression yes\" is "
-                "strongly discouraged for common usage. See --compress in the manual "
-                "page for more information ");
+            msg(M_WARN, "DEPRECATED OPTION: \"--allow-compression yes\" has been removed. "
+                "We will use \"asym\" mode instead. See the manual page for more information.");
 
-            options->comp.flags |= COMP_F_ALLOW_COMPRESS;
+            options->comp.flags |= COMP_F_ALLOW_ASYM;
         }
         else
         {
@@ -8461,45 +8450,29 @@
 
         /* All lzo variants do not use swap */
         options->comp.flags &= ~COMP_F_SWAP;
+        options->comp.alg = COMP_ALG_LZO;
 
-        if (p[1] && streq(p[1], "no"))
+        if (p[1])
         {
-            options->comp.alg = COMP_ALG_STUB;
-            options->comp.flags &= ~COMP_F_ADAPTIVE;
-        }
-        else if (p[1])
-        {
-            if (streq(p[1], "yes"))
+            if (streq(p[1], "no"))
             {
-                options->comp.alg = COMP_ALG_LZO;
-                options->comp.flags &= ~COMP_F_ADAPTIVE;
+                options->comp.alg = COMP_ALG_STUB;
             }
-            else if (streq(p[1], "adaptive"))
-            {
-                options->comp.alg = COMP_ALG_LZO;
-                options->comp.flags |= COMP_F_ADAPTIVE;
-            }
-            else
+            /* There is no actual difference anymore between these variants.
+             * We never compress. On the server side we replace this with
+             * --compress migrate later anyway.
+             */
+            else if (!(streq(p[1], "yes") || streq(p[1], "adaptive")))
             {
                 msg(msglevel, "bad comp-lzo option: %s -- must be 'yes', 'no', or 'adaptive'", p[1]);
                 goto err;
             }
         }
-        else
-        {
-            options->comp.alg = COMP_ALG_LZO;
-            options->comp.flags |= COMP_F_ADAPTIVE;
-        }
         show_compression_warning(&options->comp);
     }
     else if (streq(p[0], "comp-noadapt") && !p[1])
     {
-        /*
-         * We do not need to check here if we allow compression since
-         * it only modifies a flag if compression is enabled
-         */
-        VERIFY_PERMISSION(OPT_P_COMP);
-        options->comp.flags &= ~COMP_F_ADAPTIVE;
+        /* NO-OP since we never compress anymore */
     }
     else if (streq(p[0], "compress") && !p[2])
     {
@@ -8528,7 +8501,7 @@
         else if (streq(alg, "lzo"))
         {
             options->comp.alg = COMP_ALG_LZO;
-            options->comp.flags &= ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
+            options->comp.flags &= ~COMP_F_SWAP;
         }
         else if (streq(alg, "lz4"))
         {

