From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 9 Nov 2024 10:42:48 +0000
In-Reply-To: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
References: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <179e1fcb73a1aa68f5c3b1f361c1a077acc0e2ab-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CebQ+OMcYps="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 compression on send
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

--CebQ+OMcYps=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/75=
5?usp=3Demail )

Change subject: Remove support for compression on send
......................................................................

Remove support for compression on send

We can't disable compression support on receive because
that would break too many configurations out there. But
we can remove the support for compressing outgoing traffic,
it was disabled by default anyway.

Makes "--allow-compression yes" an alias for
"--allow-compression asym" and removes all resulting dead code.

Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241108173851.436-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
718.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/protocol-options.rst
M src/openvpn/comp-lz4.c
M src/openvpn/comp.h
M src/openvpn/dco.c
M src/openvpn/lzo.c
M src/openvpn/options.c
7 files changed, 58 insertions(+), 327 deletions(-)




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
 =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D

diff --git a/doc/man-sections/protocol-options.rst b/doc/man-sections/proto=
col-options.rst
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
-     * In order to attempt compression, length must be at least COMPRESS_T=
HRESHOLD.
-     * and asymmetric compression must be disabled
-     */
-    if (buf->len >=3D COMPRESS_THRESHOLD && (compctx->flags & COMP_F_ALLOW=
_COMPRESS))
-    {
-        const size_t ps =3D frame->buf.payload_size;
-        int zlen_max =3D ps + COMP_EXTRA_BUFFER(ps);
-        int zlen;
-
-        ASSERT(buf_init(work, frame->buf.headroom));
-        ASSERT(buf_safe(work, zlen_max));
-
-        if (buf->len > ps)
-        {
-            dmsg(D_COMP_ERRORS, "LZ4 compression buffer overflow");
-            buf->len =3D 0;
-            return false;
-        }
-
-        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (char *)BPT=
R(work), BLEN(buf), zlen_max);
-
-        if (zlen <=3D 0)
-        {
-            dmsg(D_COMP_ERRORS, "LZ4 compression error");
-            buf->len =3D 0;
-            return false;
-        }
-
-        ASSERT(buf_safe(work, zlen));
-        work->len =3D zlen;
-
-
-        dmsg(D_COMP, "LZ4 compress %d -> %d", buf->len, work->len);
-        compctx->pre_compress +=3D buf->len;
-        compctx->post_compress +=3D work->len;
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
     if (buf->len <=3D 0)
     {
         return;
     }

-    compressed =3D do_lz4_compress(buf, &work, compctx, frame);
+    uint8_t comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;
+    uint8_t *head =3D BPTR(buf);
+    uint8_t *tail =3D BEND(buf);
+    ASSERT(buf_safe(buf, 1));
+    ++buf->len;

-    /* On error do_lz4_compress sets buf len to zero, just return */
-    if (buf->len =3D=3D 0)
-    {
-        return;
-    }
-
-    /* did compression save us anything? */
-    {
-        uint8_t comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;
-        if (compressed && work.len < buf->len)
-        {
-            *buf =3D work;
-            comp_head_byte =3D LZ4_COMPRESS_BYTE;
-        }
-
-        {
-            uint8_t *head =3D BPTR(buf);
-            uint8_t *tail  =3D BEND(buf);
-            ASSERT(buf_safe(buf, 1));
-            ++buf->len;
-
-            /* move head byte of payload to tail */
-            *tail =3D *head;
-            *head =3D comp_head_byte;
-        }
-    }
+    /* move head byte of payload to tail */
+    *tail =3D *head;
+    *head =3D comp_head_byte;
 }

-
+/* Doesn't do any actual compression anymore */
 static void
 lz4v2_compress(struct buffer *buf, struct buffer work,
                struct compress_context *compctx,
                const struct frame *frame)
 {
-    bool compressed;
     if (buf->len <=3D 0)
     {
         return;
     }

-    compressed =3D do_lz4_compress(buf, &work, compctx, frame);
-
-    /* On Error just return */
-    if (buf->len =3D=3D 0)
-    {
-        return;
-    }
-
-    /* did compression save us anything?  Include 2 byte compression header
-     * in calculation */
-    if (compressed && work.len + 2 < buf->len)
-    {
-        ASSERT(buf_prepend(&work, 2));
-        uint8_t *head =3D BPTR(&work);
-        head[0] =3D COMP_ALGV2_INDICATOR_BYTE;
-        head[1] =3D COMP_ALGV2_LZ4_BYTE;
-        *buf =3D work;
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
-#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compres=
sed but also uplink */
+/* Removed
+ #define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only * /
+ #define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only incoming is compr=
essed but also outgoing * /
+ */
 #define COMP_F_SWAP                 (1<<2) /* initial command byte is swap=
ped with last byte in buffer to preserve payload alignment */
 #define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only sup=
port compression stubs */
 #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression=
, even with COMP_F_ADVERTISE_STUBS_ONLY
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 38f934a..dcc80d3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -426,8 +426,7 @@

 #if defined(USE_COMP)
     if (o->comp.alg !=3D COMP_ALG_UNDEF
-        || o->comp.flags & COMP_F_ALLOW_ASYM
-        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
+        || o->comp.flags & COMP_F_ALLOW_ASYM)
     {
         msg(msglevel, "Note: '--allow-compression' is not set to 'no', dis=
abling data channel offload.");

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
-    const bool save =3D ac->compress_state;
-    const time_t local_now =3D now;
-
-    if (!ac->compress_state)
-    {
-        if (local_now >=3D ac->next)
-        {
-            if (ac->n_total > AC_MIN_BYTES
-                && (ac->n_total - ac->n_comp) < (ac->n_total / (100 / AC_S=
AVE_PCT)))
-            {
-                ac->compress_state =3D true;
-                ac->next =3D local_now + AC_OFF_SEC;
-            }
-            else
-            {
-                ac->next =3D local_now + AC_SAMP_SEC;
-            }
-            dmsg(D_COMP, "lzo_adaptive_compress_test: comp=3D%d total=3D%d=
", ac->n_comp, ac->n_total);
-            ac->n_total =3D ac->n_comp =3D 0;
-        }
-    }
-    else
-    {
-        if (local_now >=3D ac->next)
-        {
-            ac->next =3D local_now + AC_SAMP_SEC;
-            ac->n_total =3D ac->n_comp =3D 0;
-            ac->compress_state =3D false;
-        }
-    }
-
-    if (ac->compress_state !=3D save)
-    {
-        dmsg(D_COMP_LOW, "Adaptive compression state %s", (ac->compress_st=
ate ? "OFF" : "ON"));
-    }
-
-    return !ac->compress_state;
-}
-
-static inline void
-lzo_adaptive_compress_data(struct lzo_adaptive_compress *ac, int n_total, =
int n_comp)
-{
-    ac->n_total +=3D n_total;
-    ac->n_comp +=3D n_comp;
-}

 static void
 lzo_compress_init(struct compress_context *compctx)
@@ -118,92 +63,13 @@
     compctx->wu.lzo.wmem =3D NULL;
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
-    lzo_uint zlen =3D 0;
-    int err;
-    bool compressed =3D false;
-
-    if (buf->len <=3D 0)
-    {
-        return;
-    }
-
-    /*
-     * In order to attempt compression, length must be at least COMPRESS_T=
HRESHOLD,
-     * and our adaptive level must give the OK.
-     */
-    if (buf->len >=3D COMPRESS_THRESHOLD && lzo_compression_enabled(compct=
x))
-    {
-        const size_t ps =3D frame->buf.payload_size;
-        ASSERT(buf_init(&work, frame->buf.headroom));
-        ASSERT(buf_safe(&work, ps + COMP_EXTRA_BUFFER(ps)));
-
-        if (buf->len > ps)
-        {
-            dmsg(D_COMP_ERRORS, "LZO compression buffer overflow");
-            buf->len =3D 0;
-            return;
-        }
-
-        err =3D LZO_COMPRESS(BPTR(buf), BLEN(buf), BPTR(&work), &zlen, com=
pctx->wu.lzo.wmem);
-        if (err !=3D LZO_E_OK)
-        {
-            dmsg(D_COMP_ERRORS, "LZO compression error: %d", err);
-            buf->len =3D 0;
-            return;
-        }
-
-        ASSERT(buf_safe(&work, zlen));
-        work.len =3D zlen;
-        compressed =3D true;
-
-        dmsg(D_COMP, "LZO compress %d -> %d", buf->len, work.len);
-        compctx->pre_compress +=3D buf->len;
-        compctx->post_compress +=3D work.len;
-
-        /* tell adaptive level about our success or lack thereof in gettin=
g any size reduction */
-        if (compctx->flags & COMP_F_ADAPTIVE)
-        {
-            lzo_adaptive_compress_data(&compctx->wu.lzo.ac, buf->len, work=
.len);
-        }
-    }
-
-    /* did compression save us anything ? */
-    if (compressed && work.len < buf->len)
-    {
-        uint8_t *header =3D buf_prepend(&work, 1);
-        *header =3D LZO_COMPRESS_BYTE;
-        *buf =3D work;
-    }
-    else
-    {
-        uint8_t *header =3D buf_prepend(buf, 1);
-        *header =3D NO_COMPRESS_BYTE;
-    }
+    uint8_t *header =3D buf_prepend(buf, 1);
+    *header =3D NO_COMPRESS_BYTE;
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
-                "Compression has been used in the past to break encryption=
. "
-                "Sent packets are not compressed unless \"allow-compressio=
n yes\" "
-                "is also set.");
-        }
+        msg(M_WARN, "WARNING: Compression for receiving enabled. "
+            "Compression has been used in the past to break encryption. "
+            "Compression support is deprecated and we recommend to disable=
 "
+            "it completely.");
     }
 }

@@ -8435,18 +8428,14 @@
         }
         else if (streq(p[1], "asym"))
         {
-            options->comp.flags &=3D ~COMP_F_ALLOW_COMPRESS;
             options->comp.flags |=3D COMP_F_ALLOW_ASYM;
         }
         else if (streq(p[1], "yes"))
         {
-            msg(M_WARN, "WARNING: Compression for sending and receiving en=
abled. Compression has "
-                "been used in the past to break encryption. Allowing compr=
ession allows "
-                "attacks that break encryption. Using \"--allow-compressio=
n yes\" is "
-                "strongly discouraged for common usage. See --compress in =
the manual "
-                "page for more information ");
+            msg(M_WARN, "DEPRECATED OPTION: \"--allow-compression yes\" ha=
s been removed. "
+                "We will use \"asym\" mode instead. See the manual page fo=
r more information.");

-            options->comp.flags |=3D COMP_F_ALLOW_COMPRESS;
+            options->comp.flags |=3D COMP_F_ALLOW_ASYM;
         }
         else
         {
@@ -8461,45 +8450,29 @@

         /* All lzo variants do not use swap */
         options->comp.flags &=3D ~COMP_F_SWAP;
+        options->comp.alg =3D COMP_ALG_LZO;

-        if (p[1] && streq(p[1], "no"))
+        if (p[1])
         {
-            options->comp.alg =3D COMP_ALG_STUB;
-            options->comp.flags &=3D ~COMP_F_ADAPTIVE;
-        }
-        else if (p[1])
-        {
-            if (streq(p[1], "yes"))
+            if (streq(p[1], "no"))
             {
-                options->comp.alg =3D COMP_ALG_LZO;
-                options->comp.flags &=3D ~COMP_F_ADAPTIVE;
+                options->comp.alg =3D COMP_ALG_STUB;
             }
-            else if (streq(p[1], "adaptive"))
-            {
-                options->comp.alg =3D COMP_ALG_LZO;
-                options->comp.flags |=3D COMP_F_ADAPTIVE;
-            }
-            else
+            /* There is no actual difference anymore between these variant=
s.
+             * We never compress. On the server side we replace this with
+             * --compress migrate later anyway.
+             */
+            else if (!(streq(p[1], "yes") || streq(p[1], "adaptive")))
             {
                 msg(msglevel, "bad comp-lzo option: %s -- must be 'yes', '=
no', or 'adaptive'", p[1]);
                 goto err;
             }
         }
-        else
-        {
-            options->comp.alg =3D COMP_ALG_LZO;
-            options->comp.flags |=3D COMP_F_ADAPTIVE;
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
-        options->comp.flags &=3D ~COMP_F_ADAPTIVE;
+        /* NO-OP since we never compress anymore */
     }
     else if (streq(p[0], "compress") && !p[2])
     {
@@ -8528,7 +8501,7 @@
         else if (streq(alg, "lzo"))
         {
             options->comp.alg =3D COMP_ALG_LZO;
-            options->comp.flags &=3D ~(COMP_F_ADAPTIVE | COMP_F_SWAP);
+            options->comp.flags &=3D ~COMP_F_SWAP;
         }
         else if (streq(alg, "lz4"))
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60
Gerrit-Change-Number: 755
Gerrit-PatchSet: 7
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--CebQ+OMcYps=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/755?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove support for compression on send<br><br>=
We can&#39;t disable compression support on receive because<br>that would b=
reak too many configurations out there. But<br>we can remove the support fo=
r compressing outgoing traffic,<br>it was disabled by default anyway.<br><b=
r>Makes &quot;--allow-compression yes&quot; an alias for<br>&quot;--allow-c=
ompression asym&quot; and removes all resulting dead code.<br><br>Change-Id=
: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60<br>Signed-off-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1186...=
.1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-I=
d: &lt;20241108173851.436-1-gert@...1296...&gt;<br>URL: https://www.mail-ar=
chive.com/openvpn-devel@lists.sourceforge.net/msg29718.html<br>Signed-off-b=
y: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M Changes.rst<br>M doc/ma=
n-sections/protocol-options.rst<br>M src/openvpn/comp-lz4.c<br>M src/openvp=
n/comp.h<br>M src/openvpn/dco.c<br>M src/openvpn/lzo.c<br>M src/openvpn/opt=
ions.c<br>7 files changed, 58 insertions(+), 327 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 7d19577..a6=
cc3be 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Change=
s.rst</span><br><span>@@ -59,6 +59,12 @@</span><br><span>     Support for b=
uilding with OpenSSL 1.0.2 has been removed. The minimum</span><br><span>  =
   supported OpenSSL version is now 1.1.0.</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+Compression on send</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2.7 will never compres=
s data before sending. Decompression of</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    received data is still supported.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ``--allow-compression yes`` is no=
w an alias for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    `=
`--allow-compression asym``.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span> Overview of changes in 2.6</span><br><span> =3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
</span><br><span> </span><br><span>diff --git a/doc/man-sections/protocol-o=
ptions.rst b/doc/man-sections/protocol-options.rst</span><br><span>index 8b=
061d2..05f87cc 100644</span><br><span>--- a/doc/man-sections/protocol-optio=
ns.rst</span><br><span>+++ b/doc/man-sections/protocol-options.rst</span><b=
r><span>@@ -10,17 +10,11 @@</span><br><span>   dangerous option.  This opti=
on allows controlling the behaviour of</span><br><span>   OpenVPN when comp=
ression is used and allowed.</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  Valid syntaxes:</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  ::</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      allow-compr=
ession</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      allow-com=
pression mode</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span>   The ``mode`` argument can be one of the following values:</span=
><br><span> </span><br><span>   :code:`asym`</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      OpenVPN will only *decompress downlink packets=
* but *not compress</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    uplink packets*.  This also allows migrating to disable compression</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      OpenVPN will only=
 *decompress incoming packets* but *not compress</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+      outgoing packets*.  This also allows mig=
rating to disable compression</span><br><span>       when changing both ser=
ver and client configurations to remove</span><br><span>       compression =
at the same time is not a feasible option.</span><br><span> </span><br><spa=
n>@@ -30,7 +24,9 @@</span><br><span>       framing (stub).</span><br><span>=
 </span><br><span>   :code:`yes`</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      OpenVPN will send and receive compressed packets.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      **DEPRECATED** This op=
tion is an alias for :code:`asym`. Previously</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      it did enable compression for outgoing pack=
ets, but OpenVPN never</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+      compresses packets on send now.</span><br><span> </span><br><span>=
 --auth alg</span><br><span>   Authenticate data channel packets and (if en=
abled) ``tls-auth`` control</span><br><span>@@ -135,48 +131,26 @@</span><br=
><span>   entirely sure that the above does not apply to your traffic, you =
are</span><br><span>   advised to *not* enable compression.</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  For this reason=
 compression support was removed from current versions</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+  of OpenVPN. It will still decompress c=
ompressed packets received via</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  a VPN connection but it will never compress any outgoing packe=
ts.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> --comp-lzo mode</span><br><span>   **DEPRECATED** Enable LZO compression =
algorithm.  Compression is</span><br><span>   generally not recommended.  V=
PN tunnels which uses compression are</span><br><span>   suspectible to the=
 VORALCE attack vector.</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  Use LZO compression -- may add up to 1 byte per packe=
t for incompressible</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
 data. ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-  (default).</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+  Allows the other side of the conne=
ction to use LZO compression. Due</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  to difference in packet format this may add 1 additional by=
te per packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Wit=
h current versions of OpenVPN no actual compression will happen.</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  In a server =
mode setup, it is possible to selectively turn compression</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-  on or off for individual clients.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  ``mode`` may be :cod=
e:`yes`, :code:`no`, or :code:`adaptive`</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  but there is no actual change in behavior anymore.</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Fir=
st, make sure the client-side config file enables selective</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-  compression by having at least one =
``--comp-lzo`` directive, such as</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  ``--comp-lzo no``. This will turn off compression by default,=
 but allow</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  a future =
directive push from the server to dynamically change the</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-  :code:`on`/:code:`off`/:code:`adaptive=
` setting.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  Next in a ``--client-config-di=
r`` file, specify the compression setting</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-  for the client, for example:</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  ::</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    comp-=
lzo yes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    push &quot=
;comp-lzo yes&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The first line sets t=
he ``comp-lzo`` setting for the server side of the</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  link, the second sets the client side.</span=
><br><span> </span><br><span> --comp-noadapt</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-  **DEPRECATED** When used in conjunction with ``--c=
omp-lzo``, this option</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  will disable OpenVPN&#39;s adaptive compression algorithm. Normally, ada=
ptive</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  compression is=
 enabled with ``--comp-lzo``.</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Adaptive co=
mpression tries to optimize the case where you have</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  compression enabled, but you are sending =
predominantly incompressible</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-  (or pre-compressed) packets over the tunnel, such as an FTP or rsy=
nc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  transfer of a lar=
ge, compressed file. With adaptive compression, OpenVPN</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  will periodically sample the compressio=
n process to measure its</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  efficiency. If the data being sent over the tunnel is already</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-  compressed, the compression =
efficiency will be very low, triggering</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  openvpn to disable compression for a period of time unt=
il the next</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  re-sampl=
e test.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  **DEPRECAT=
ED** This option does not have any effect anymore since current</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+  versions of OpenVPN never com=
press outgoing packets.</span><br><span> </span><br><span> --key-direction<=
/span><br><span>   Alternative way of specifying the optional direction par=
ameter for the</span><br><span>diff --git a/src/openvpn/comp-lz4.c b/src/op=
envpn/comp-lz4.c</span><br><span>index ac020a4..b35df4a 100644</span><br><s=
pan>--- a/src/openvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4=
.c</span><br><span>@@ -55,129 +55,40 @@</span><br><span> {</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-do_lz4_comp=
ress(struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                struct buffer *work,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                struct compress_context *compctx,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                const struct =
frame *frame)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * In order to attempt compression, len=
gth must be at least COMPRESS_THRESHOLD.</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-     * and asymmetric compression must be disabled</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &gt;=3D COMPRESS_THRE=
SHOLD &amp;&amp; (compctx-&gt;flags &amp; COMP_F_ALLOW_COMPRESS))</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        const size_t ps =3D frame-&gt;buf.paylo=
ad_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int z=
len_max =3D ps + COMP_EXTRA_BUFFER(ps);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int zlen;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ASSERT(buf_init(work, frame-&gt;buf.headroom));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        ASSERT(buf_safe(work, zlen_max));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (buf-&gt;len &gt; ps)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            dmsg(D_COMP_ERRORS, &quot;LZ4 compress=
ion buffer overflow&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            return false;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        zlen =
=3D LZ4_compress_default((const char *)BPTR(buf), (char *)BPTR(work), BLEN(=
buf), zlen_max);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (zlen &lt;=3D 0=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP_ERRORS, =
&quot;LZ4 compression error&quot;);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            buf-&gt;len =3D 0;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            return false;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  ASSERT(buf_safe(work, zlen));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        work-&gt;len =3D zlen;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_COMP, &q=
uot;LZ4 compress %d -&gt; %d&quot;, buf-&gt;len, work-&gt;len);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        compctx-&gt;pre_compress =
+=3D buf-&gt;len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    compctx-&gt;post_compress +=3D work-&gt;len;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    return false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* Doesn&#39;t do any actual compression anymore */</s=
pan><br><span> static void</span><br><span> lz4_compress(struct buffer *buf=
, struct buffer work,</span><br><span>              struct compress_context=
 *compctx,</span><br><span>              const struct frame *frame)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool c=
ompressed;</span><br><span>     if (buf-&gt;len &lt;=3D 0)</span><br><span>=
     {</span><br><span>         return;</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    compressed =
=3D do_lz4_compress(buf, &amp;work, compctx, frame);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    uint8_t comp_head_byte =3D NO_COMPRES=
S_BYTE_SWAP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t8_t *head =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    uint8_t *tail =3D BEND(buf);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(buf_safe(buf, 1));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ++buf-&gt;len;</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* On error do_lz4_compress=
 sets buf len to zero, just return */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (buf-&gt;len =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    /* did compression save us anyt=
hing? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t comp_head_byt=
e =3D NO_COMPRESS_BYTE_SWAP;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (compressed &amp;&amp; work.len &lt; buf-&gt;len)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            *buf =3D work;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            comp_head_byte =3D LZ4_C=
OMPRESS_BYTE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            uint8_t *head =3D BPTR(buf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            uint8_t *tail  =3D BEN=
D(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            AS=
SERT(buf_safe(buf, 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            ++buf-&gt;len;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /*=
 move head byte of payload to tail */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            *tail =3D *head;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            *head =3D comp_head_byte;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* move head byte of payload to tail */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    *tail =3D *head;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    *head =3D comp_head_byte;</span><=
br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Doesn&#3=
9;t do any actual compression anymore */</span><br><span> static void</span=
><br><span> lz4v2_compress(struct buffer *buf, struct buffer work,</span><b=
r><span>                struct compress_context *compctx,</span><br><span> =
               const struct frame *frame)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bool compressed;</span><br><span=
>     if (buf-&gt;len &lt;=3D 0)</span><br><span>     {</span><br><span>   =
      return;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    compressed =3D do_lz4_compress(buf, &a=
mp;work, compctx, frame);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* On Error j=
ust return */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
buf-&gt;len =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* did compression save us anything?  Include 2 byte co=
mpression header</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
* in calculation */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (compressed &amp;&amp; work.len + 2 &lt; buf-&gt;len)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        ASSERT(buf_prepend(&amp;work, 2));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        uint8_t *head =3D BPTR(&a=
mp;work);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        head=
[0] =3D COMP_ALGV2_INDICATOR_BYTE;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        head[1] =3D COMP_ALGV2_LZ4_BYTE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        *buf =3D work;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        comp=
v2_escape_data_ifneeded(buf);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co=
mpv2_escape_data_ifneeded(buf);</span><br><span> }</span><br><span> </span>=
<br><span> static void</span><br><span>diff --git a/src/openvpn/comp.h b/sr=
c/openvpn/comp.h</span><br><span>index 267f680b..7eed331 100644</span><br><=
span>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp.h</spa=
n><br><span>@@ -32,8 +32,10 @@</span><br><span>  * outside of the USE_COMP =
define */</span><br><span> </span><br><span> /* Compression flags */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ADAPTIVE     =
        (1&lt;&lt;0) /* COMP_ALG_LZO only */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) /* =
not only downlink is compressed but also uplink */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* Removed</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ #define COMP_F_ADAPTIVE             (1&lt;&lt;0) / *=
 COMP_ALG_LZO only * /</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ #define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) / * not only incoming =
is compressed but also outgoing * /</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span> #define COMP_F_SWAP                 (1=
&lt;&lt;2) /* initial command byte is swapped with last byte in buffer to p=
reserve payload alignment */</span><br><span> #define COMP_F_ADVERTISE_STUB=
S_ONLY (1&lt;&lt;3) /* tell server that we only support compression stubs *=
/</span><br><span> #define COMP_F_ALLOW_STUB_ONLY      (1&lt;&lt;4) /* Only=
 accept stub compression, even with COMP_F_ADVERTISE_STUBS_ONLY</span><br><=
span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>ind=
ex 38f934a..dcc80d3 100644</span><br><span>--- a/src/openvpn/dco.c</span><b=
r><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -426,8 +426,7 @@</span><=
br><span> </span><br><span> #if defined(USE_COMP)</span><br><span>     if (=
o-&gt;comp.alg !=3D COMP_ALG_UNDEF</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        || o-&gt;comp.flags &amp; COMP_F_ALLOW_ASYM</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        || o-&gt;comp.flags &amp=
; COMP_F_ALLOW_COMPRESS)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        || o-&gt;comp.flags &amp; COMP_F_ALLOW_ASYM)</span><br><span> =
    {</span><br><span>         msg(msglevel, &quot;Note: &#39;--allow-compr=
ession&#39; is not set to &#39;no&#39;, disabling data channel offload.&quo=
t;);</span><br><span> </span><br><span>diff --git a/src/openvpn/lzo.c b/src=
/openvpn/lzo.c</span><br><span>index bab2d78..5cd5ea2 100644</span><br><spa=
n>--- a/src/openvpn/lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br=
><span>@@ -39,61 +39,6 @@</span><br><span> </span><br><span> #include &quot=
;memdbg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Per=
form adaptive compression housekeeping.</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
* @param ac the adaptive compression state structure.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @return</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-lzo_adaptive_compress_test=
(struct lzo_adaptive_compress *ac)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    con=
st bool save =3D ac-&gt;compress_state;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const time_t local_now =3D now;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!ac-&gt;compress_state)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (local_now &gt;=3D ac-&gt;next)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (ac-&gt;n_total &gt; AC_MIN_BYTES</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; (ac-&gt=
;n_total - ac-&gt;n_comp) &lt; (ac-&gt;n_total / (100 / AC_SAVE_PCT)))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                ac-&gt;compress_st=
ate =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        ac-&gt;next =3D local_now + AC_OFF_SEC;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                ac-&gt;next =3D local_now + AC_SAMP_SEC;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP, &quot;lzo_adaptive=
_compress_test: comp=3D%d total=3D%d&quot;, ac-&gt;n_comp, ac-&gt;n_total);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ac-&gt;n_=
total =3D ac-&gt;n_comp =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (local_now &gt;=3D ac-&gt;next)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            ac-&gt;next =3D local_now +=
 AC_SAMP_SEC;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    ac-&gt;n_total =3D ac-&gt;n_comp =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            ac-&gt;compress_state =3D false;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (ac-&gt;compress_state !=3D save)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       dmsg(D_COMP_LOW, &quot;Adaptive compression state %s&quot;, (ac-&gt;=
compress_state ? &quot;OFF&quot; : &quot;ON&quot;));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn !ac-&gt;compress_state;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-lzo_adaptive_compress_data(struct lz=
o_adaptive_compress *ac, int n_total, int n_comp)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    ac-&gt;n_total +=3D n_total;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    ac-&gt;n_comp +=3D n_comp;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-}</span><br><span> </span><br><span> static voi=
d</span><br><span> lzo_compress_init(struct compress_context *compctx)</spa=
n><br><span>@@ -118,92 +63,13 @@</span><br><span>     compctx-&gt;wu.lzo.wm=
em =3D NULL;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-lzo_compression_enabled(struct compress_context *c=
ompctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!(compctx-&gt;flags &amp; =
COMP_F_ALLOW_COMPRESS))</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (compctx-&gt;flags &amp; COMP_F_ADAPTIVE)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            return lzo_adaptive_compress=
_test(&amp;compctx-&gt;wu.lzo.ac);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return t=
rue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span> static void</span><br><span> lzo_compress(str=
uct buffer *buf, struct buffer work,</span><br><span>              struct c=
ompress_context *compctx,</span><br><span>              const struct frame =
*frame)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    lzo_uint zlen =3D 0;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bool compressed =3D false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&=
gt;len &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
  * In order to attempt compression, length must be at least COMPRESS_THRES=
HOLD,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * and our a=
daptive level must give the OK.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (buf-&gt;len &gt;=3D COMPRESS_THRESHOLD &amp;&amp; lzo_compression_enabl=
ed(compctx))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const size_t ps =
=3D frame-&gt;buf.payload_size;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        ASSERT(buf_init(&amp;work, frame-&gt;buf.headroom));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_safe(&a=
mp;work, ps + COMP_EXTRA_BUFFER(ps)));</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (buf-&gt;len &gt; ps)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       dmsg(D_COMP_ERRORS, &quot;LZO compression buffer overflow&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ret=
urn;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        err =3D LZO_COMPRESS(BPTR(buf), BLEN(buf),=
 BPTR(&amp;work), &amp;zlen, compctx-&gt;wu.lzo.wmem);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (err !=3D LZO_E_OK)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP_ERRORS, &quot;LZO c=
ompression error: %d&quot;, err);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            buf-&gt;len =3D 0;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            return;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT=
(buf_safe(&amp;work, zlen));</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        work.len =3D zlen;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        compressed =3D true;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      dmsg(D_COMP, &quot;LZO compress %d -&gt; %d&quot;, buf-&gt;len, work.=
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        compctx-=
&gt;pre_compress +=3D buf-&gt;len;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        compctx-&gt;post_compress +=3D work.len;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        /* tell adaptive level about our success or lack=
 thereof in getting any size reduction */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (compctx-&gt;flags &amp; COMP_F_ADAPTIVE)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            lzo_adaptive_compress_da=
ta(&amp;compctx-&gt;wu.lzo.ac, buf-&gt;len, work.len);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* did compr=
ession save us anything ? */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (compressed &amp;&amp; work.len &lt; buf-&gt;len)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uint8_t *header =3D buf_prepend(&amp;work=
, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *header =
=3D LZO_COMPRESS_BYTE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        *buf =3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        uint8_t *header =3D buf_prepend(buf=
, 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *header =
=3D NO_COMPRESS_BYTE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *h=
eader =3D buf_prepend(buf, 1);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    *header =3D NO_COMPRESS_BYTE;</span><br><span> }</span><br><=
span> </span><br><span> static void</span><br><span>diff --git a/src/openvp=
n/options.c b/src/openvpn/options.c</span><br><span>index 61f6285..1beb0ee =
100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/sr=
c/openvpn/options.c</span><br><span>@@ -5715,17 +5715,10 @@</span><br><span=
> {</span><br><span>     if (comp_non_stub_enabled(info))</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-         * Check if already=
 displayed the strong warning and enabled full</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-         * compression</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if (!(info-&gt;flags &amp; COMP_F_ALLOW_COMPRESS))<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARN=
ING: Compression for receiving enabled. &quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                &quot;Compression has been used in=
 the past to break encryption. &quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                &quot;Sent packets are not compressed unles=
s \&quot;allow-compression yes\&quot; &quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                &quot;is also set.&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARNING: Compre=
ssion for receiving enabled. &quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;Compression has been used in the past to =
break encryption. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;Compression support is deprecated and we recommend t=
o disable &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;it completely.&quot;);</span><br><span>     }</span><br><spa=
n> }</span><br><span> </span><br><span>@@ -8435,18 +8428,14 @@</span><br><s=
pan>         }</span><br><span>         else if (streq(p[1], &quot;asym&quo=
t;))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            options-&gt;comp.flags &amp;=3D ~COMP_F_ALLOW_COMPRES=
S;</span><br><span>             options-&gt;comp.flags |=3D COMP_F_ALLOW_AS=
YM;</span><br><span>         }</span><br><span>         else if (streq(p[1]=
, &quot;yes&quot;))</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: Compression=
 for sending and receiving enabled. Compression has &quot;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                &quot;been used in the=
 past to break encryption. Allowing compression allows &quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                &quot;attacks that =
break encryption. Using \&quot;--allow-compression yes\&quot; is &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;str=
ongly discouraged for common usage. See --compress in the manual &quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;pag=
e for more information &quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            msg(M_WARN, &quot;DEPRECATED OPTION: \&quot;--allow=
-compression yes\&quot; has been removed. &quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                &quot;We will use \&quot;asym\=
&quot; mode instead. See the manual page for more information.&quot;);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    options-&gt;comp.flags |=3D COMP_F_ALLOW_COMPRESS;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            options-&gt;comp.flags |=3D =
COMP_F_ALLOW_ASYM;</span><br><span>         }</span><br><span>         else=
</span><br><span>         {</span><br><span>@@ -8461,45 +8450,29 @@</span><=
br><span> </span><br><span>         /* All lzo variants do not use swap */<=
/span><br><span>         options-&gt;comp.flags &amp;=3D ~COMP_F_SWAP;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;comp=
.alg =3D COMP_ALG_LZO;</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (p[1] &amp;&amp; streq(p[1], &quot;no&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[1])</=
span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            options-&gt;comp.alg =3D COMP_ALG_STUB;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp.flags &amp;=
=3D ~COMP_F_ADAPTIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else=
 if (p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (streq(p=
[1], &quot;yes&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (streq(p[1], &quot;no&quot;))</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                op=
tions-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                options-&gt;comp.flags &amp;=3D ~COMP_F_ADAP=
TIVE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  options-&gt;comp.alg =3D COMP_ALG_STUB;</span><br><span>             }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (str=
eq(p[1], &quot;adaptive&quot;))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                options-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                options-&gt;comp.flags |=
=3D COMP_F_ADAPTIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
/* There is no actual difference anymore between these variants.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+             * We never compre=
ss. On the server side we replace this with</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+             * --compress migrate later anyway.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+             */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (!(stre=
q(p[1], &quot;yes&quot;) || streq(p[1], &quot;adaptive&quot;)))</span><br><=
span>             {</span><br><span>                 msg(msglevel, &quot;ba=
d comp-lzo option: %s -- must be &#39;yes&#39;, &#39;no&#39;, or &#39;adapt=
ive&#39;&quot;, p[1]);</span><br><span>                 goto err;</span><br=
><span>             }</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            options-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp.flags |=3D =
COMP_F_ADAPTIVE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span>         show_compression_warning(&amp;options-&gt;com=
p);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;=
comp-noadapt&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        /*</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-         * We do not need to check here if we a=
llow compression since</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-         * it only modifies a flag if compression is enabled</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-         */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        VERIFY_PERMISSION(OPT_P_COMP);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;comp.f=
lags &amp;=3D ~COMP_F_ADAPTIVE;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* NO-OP since we never compress anymore */</span><br><=
span>     }</span><br><span>     else if (streq(p[0], &quot;compress&quot;)=
 &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -8528,7 +8501,=
7 @@</span><br><span>         else if (streq(alg, &quot;lzo&quot;))</span><=
br><span>         {</span><br><span>             options-&gt;comp.alg =3D C=
OMP_ALG_LZO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   options-&gt;comp.flags &amp;=3D ~(COMP_F_ADAPTIVE | COMP_F_SWAP);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;co=
mp.flags &amp;=3D ~COMP_F_SWAP;</span><br><span>         }</span><br><span>=
         else if (streq(alg, &quot;lz4&quot;))</span><br><span>         {</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/755?usp=3Demail">change 755</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/755?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I402ba016b75cfcfec4fc8b2b01c=
c4eca7e2bcc60 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 755 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--CebQ+OMcYps=--

