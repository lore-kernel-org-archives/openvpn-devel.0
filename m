From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 22 Sep 2024 14:21:47 +0000
In-Reply-To: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
References: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1bac6906ed267075ff190483ec6f19115d69e9ae-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CV2o/fEyQZ0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CV2o/fEyQZ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail

to look at the new patch set (#2).


Change subject: Remove support for compression on send
......................................................................

Remove support for compression on send

We can't disable compression support on receive because
that would break too many configurations out there. But
we can remove the support for compressing outgoing traffic,
it was disabled by default anyway.

Makes --allow-compression yes is an alias for
--allow-compression asym and removes all resulting dead code.

Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M Changes.rst
M doc/man-sections/protocol-options.rst
M src/openvpn/comp-lz4.c
M src/openvpn/comp.h
M src/openvpn/dco.c
M src/openvpn/lzo.c
M src/openvpn/options.c
7 files changed, 45 insertions(+), 331 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/755/2

diff --git a/Changes.rst b/Changes.rst
index 439352a..b9287ce 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -46,6 +46,12 @@
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
index 8b061d2..37e2240 100644
--- a/doc/man-sections/protocol-options.rst
+++ b/doc/man-sections/protocol-options.rst
@@ -30,7 +30,9 @@
       framing (stub).

   :code:`yes`
-      OpenVPN will send and receive compressed packets.
+      **DEPRECATED** This option is an alias for :code:`asym`. Previously
+      it did enable compression for uplink packets, but OpenVPN never
+      compresses uplink packets now.

 --auth alg
   Authenticate data channel packets and (if enabled) ``tls-auth`` control
@@ -135,48 +137,26 @@
   entirely sure that the above does not apply to your traffic, you are
   advised to *not* enable compression.

+  For this reason compression support was removed from current versions
+  of OpenVPN. It will still decompress compressed packets removed via
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
+  to difference in packet format this may adds 1 additional byte per packe=
t.
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
index ac020a4..f9eee11 100644
--- a/src/openvpn/comp-lz4.c
+++ b/src/openvpn/comp-lz4.c
@@ -55,129 +55,11 @@
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
 static void
 lz4_compress(struct buffer *buf, struct buffer work,
              struct compress_context *compctx,
              const struct frame *frame)
 {
-    bool compressed;
-    if (buf->len <=3D 0)
-    {
-        return;
-    }
-
-    compressed =3D do_lz4_compress(buf, &work, compctx, frame);
-
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
-}
-
-
-static void
-lz4v2_compress(struct buffer *buf, struct buffer work,
-               struct compress_context *compctx,
-               const struct frame *frame)
-{
-    bool compressed;
-    if (buf->len <=3D 0)
-    {
-        return;
-    }
-
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
 }

 static void
@@ -305,7 +187,7 @@
     "lz4v2",
     lz4v2_compress_init,
     lz4_compress_uninit,
-    lz4v2_compress,
+    lz4_compress,
     lz4v2_decompress
 };
 #endif /* ENABLE_LZ4 */
diff --git a/src/openvpn/comp.h b/src/openvpn/comp.h
index 267f680b..ed6a563 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -32,8 +32,9 @@
  * outside of the USE_COMP define */

 /* Compression flags */
-#define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
-#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compres=
sed but also uplink */
+/*Removed */
+/*#define COMP_F_ADAPTIVE             (1<<0) / * COMP_ALG_LZO only */
+/*#define COMP_F_ALLOW_COMPRESS       (1<<1) / * not only downlink is comp=
ressed but also uplink * / */
 #define COMP_F_SWAP                 (1<<2) /* initial command byte is swap=
ped with last byte in buffer to preserve payload alignment */
 #define COMP_F_ADVERTISE_STUBS_ONLY (1<<3) /* tell server that we only sup=
port compression stubs */
 #define COMP_F_ALLOW_STUB_ONLY      (1<<4) /* Only accept stub compression=
, even with COMP_F_ADVERTISE_STUBS_ONLY
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7f0d53d..49f08d6 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -413,8 +413,7 @@

 #if defined(USE_COMP)
     if (o->comp.alg !=3D COMP_ALG_UNDEF
-        || o->comp.flags & COMP_F_ALLOW_ASYM
-        || o->comp.flags & COMP_F_ALLOW_COMPRESS)
+        || o->comp.flags & COMP_F_ALLOW_ASYM)
     {
         msg(msglevel, "Note: '--allow-compression' is not set to 'no', dis=
abling data channel offload.");

diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c
index bab2d78..a3cf3c1 100644
--- a/src/openvpn/lzo.c
+++ b/src/openvpn/lzo.c
@@ -39,54 +39,6 @@

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

 static inline void
 lzo_adaptive_compress_data(struct lzo_adaptive_compress *ac, int n_total, =
int n_comp)
@@ -118,92 +70,13 @@
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
index 649f48b..4fee671 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--CV2o/fEyQZ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Remove support for compression on send<br><br>We can&#39;t disable=
 compression support on receive because<br>that would break too many config=
urations out there. But<br>we can remove the support for compressing outgoi=
ng traffic,<br>it was disabled by default anyway.<br><br>Makes --allow-comp=
ression yes is an alias for<br>--allow-compression asym and removes all res=
ulting dead code.<br><br>Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc=
60<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M=
 Changes.rst<br>M doc/man-sections/protocol-options.rst<br>M src/openvpn/co=
mp-lz4.c<br>M src/openvpn/comp.h<br>M src/openvpn/dco.c<br>M src/openvpn/lz=
o.c<br>M src/openvpn/options.c<br>7 files changed, 45 insertions(+), 331 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/55/755/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><s=
pan>index 439352a..b9287ce 100644</span><br><span>--- a/Changes.rst</span><=
br><span>+++ b/Changes.rst</span><br><span>@@ -46,6 +46,12 @@</span><br><sp=
an>     Support for building with OpenSSL 1.0.2 has been removed. The minim=
um</span><br><span>     supported OpenSSL version is now 1.1.0.</span><br><=
span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Compression o=
n send</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    OpenVPN 2=
.7 will never compress data before sending. Decompression of</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    received data is still support=
ed.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``--allow-co=
mpression yes`` is now an alias for</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ``--allow-compression asym``.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> Overview of changes in 2.6<=
/span><br><span> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D</span><br><span> </span><br><span>diff --git a/doc/ma=
n-sections/protocol-options.rst b/doc/man-sections/protocol-options.rst</sp=
an><br><span>index 8b061d2..37e2240 100644</span><br><span>--- a/doc/man-se=
ctions/protocol-options.rst</span><br><span>+++ b/doc/man-sections/protocol=
-options.rst</span><br><span>@@ -30,7 +30,9 @@</span><br><span>       frami=
ng (stub).</span><br><span> </span><br><span>   :code:`yes`</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      OpenVPN will send and receive c=
ompressed packets.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     **DEPRECATED** This option is an alias for :code:`asym`. Previously</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      it did enable co=
mpression for uplink packets, but OpenVPN never</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      compresses uplink packets now.</span><br>=
<span> </span><br><span> --auth alg</span><br><span>   Authenticate data ch=
annel packets and (if enabled) ``tls-auth`` control</span><br><span>@@ -135=
,48 +137,26 @@</span><br><span>   entirely sure that the above does not app=
ly to your traffic, you are</span><br><span>   advised to *not* enable comp=
ression.</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+  For this reason compression support was removed from current versi=
ons</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  of OpenVPN. It=
 will still decompress compressed packets removed via</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  a VPN connection but it will never comp=
ress any outgoing packets.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> --comp-lzo mode</span><br><span>   **DEPRECATED** =
Enable LZO compression algorithm.  Compression is</span><br><span>   genera=
lly not recommended.  VPN tunnels which uses compression are</span><br><spa=
n>   suspectible to the VORALCE attack vector.</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-  Use LZO compression -- may add=
 up to 1 byte per packet for incompressible</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-  data. ``mode`` may be :code:`yes`, :code:`no`, or :=
code:`adaptive`</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  (def=
ault).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  Allows the =
other side of the connection to use LZO compression. Due</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+  to difference in packet format this =
may adds 1 additional byte per packet.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+  With current versions of OpenVPN no actual compression=
 will happen.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  In a server mode setup, it is possible to selectively turn comp=
ression</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  on or off fo=
r individual clients.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  ``mode`` may be :code:`yes`, :code:`no`, or :code:`adaptive`</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  but there is no actual chang=
e in behavior anymore.</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-  First, make sure the client-side config file enables s=
elective</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  compression=
 by having at least one ``--comp-lzo`` directive, such as</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  ``--comp-lzo no``. This will turn off=
 compression by default, but allow</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-  a future directive push from the server to dynamically chang=
e the</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  :code:`on`/:co=
de:`off`/:code:`adaptive` setting.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  Next i=
n a ``--client-config-dir`` file, specify the compression setting</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-  for the client, for example:<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ::</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    comp-lzo yes</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    push &quot;comp-lzo yes&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-  The first line sets the ``comp-lzo`` setting for the server side of the<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-  link, the second set=
s the client side.</span><br><span> </span><br><span> --comp-noadapt</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-  **DEPRECATED** When used i=
n conjunction with ``--comp-lzo``, this option</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  will disable OpenVPN&#39;s adaptive compression =
algorithm. Normally, adaptive</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-  compression is enabled with ``--comp-lzo``.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-  Adaptive compression tries to optimize the case where you have=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  compression enabled=
, but you are sending predominantly incompressible</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-  (or pre-compressed) packets over the tunnel,=
 such as an FTP or rsync</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-  transfer of a large, compressed file. With adaptive compression, OpenV=
PN</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  will periodically=
 sample the compression process to measure its</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-  efficiency. If the data being sent over the tunn=
el is already</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  compre=
ssed, the compression efficiency will be very low, triggering</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  openvpn to disable compression fo=
r a period of time until the next</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-  re-sample test.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+  **DEPRECATED** This option does not have any effect anymore sin=
ce current</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  version=
s of OpenVPN never compress outgoing packets.</span><br><span> </span><br><=
span> --key-direction</span><br><span>   Alternative way of specifying the =
optional direction parameter for the</span><br><span>diff --git a/src/openv=
pn/comp-lz4.c b/src/openvpn/comp-lz4.c</span><br><span>index ac020a4..f9eee=
11 100644</span><br><span>--- a/src/openvpn/comp-lz4.c</span><br><span>+++ =
b/src/openvpn/comp-lz4.c</span><br><span>@@ -55,129 +55,11 @@</span><br><sp=
an> {</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-do_lz4_compress(struct buffer *buf,</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                struct buffer *work,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                struct compress_con=
text *compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         const struct frame *frame)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * In order to at=
tempt compression, length must be at least COMPRESS_THRESHOLD.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-     * and asymmetric compression =
must be disabled</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len=
 &gt;=3D COMPRESS_THRESHOLD &amp;&amp; (compctx-&gt;flags &amp; COMP_F_ALLO=
W_COMPRESS))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const size_t ps =
=3D frame-&gt;buf.payload_size;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        int zlen_max =3D ps + COMP_EXTRA_BUFFER(ps);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        int zlen;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ASSERT(buf_init(work, frame-&gt;buf.headroom));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_safe(w=
ork, zlen_max));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (buf-&gt;len &g=
t; ps)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP_ERR=
ORS, &quot;LZ4 compression buffer overflow&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            buf-&gt;len =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        zlen =3D LZ4_compress_default((const char *)BPTR(buf), (=
char *)BPTR(work), BLEN(buf), zlen_max);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (zlen &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    dmsg(D_COMP_ERRORS, &quot;LZ4 compression error&quot;);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len =3D 0;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            return false;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ASSERT(buf_safe(work, zlen));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        work-&gt;len =3D zlen;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        dmsg(D_COMP, &quot;LZ4 compress %d -&gt; %d&quot;, buf-&gt;len, wo=
rk-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        c=
ompctx-&gt;pre_compress +=3D buf-&gt;len;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        compctx-&gt;post_compress +=3D work-&gt;len;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    return false;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> static void</span><br><span> lz4_compress(struct buffer *buf, stru=
ct buffer work,</span><br><span>              struct compress_context *comp=
ctx,</span><br><span>              const struct frame *frame)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool compres=
sed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;l=
en &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    compressed =3D do_lz4_compress(buf, &amp;work, compctx, frame);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /* On error do_lz4_compress sets buf l=
en to zero, just return */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (buf-&gt;len =3D=3D 0)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* did compression save us anything? */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        uint8_t comp_head_byte =3D NO_CO=
MPRESS_BYTE_SWAP;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (compressed &amp;&amp; work.len &lt; buf-&gt;len)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            *buf =3D work;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            comp_head_byte =3D LZ4_COMPRESS_BYT=
E;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            uint8_t *head =3D BPTR(buf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            uint8_t *tail  =3D BEND(buf);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ASSERT(buf_=
safe(buf, 1));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ++buf-&gt;len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* move hea=
d byte of payload to tail */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            *tail =3D *head;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            *head =3D comp_head_byte;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-lz4v2_compress(struct buffer *buf, struct buffer work,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-               struct compress_cont=
ext *compctx,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
       const struct frame *frame)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool=
 compressed;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (b=
uf-&gt;len &lt;=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    compressed =3D do_lz4_compress(buf, &amp;work, compctx,=
 frame);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    /* On Error just return */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* did compression save us anything?  Include 2 byte compression heade=
r</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * in calculatio=
n */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (compresse=
d &amp;&amp; work.len + 2 &lt; buf-&gt;len)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        ASSERT(buf_prepend(&amp;work, 2));</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        uint8_t *head =3D BPTR(&amp;work);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        head[0] =3D COMP_AL=
GV2_INDICATOR_BYTE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      head[1] =3D COMP_ALGV2_LZ4_BYTE;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        *buf =3D work;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        compv2_escape_data_=
ifneeded(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span>@@ -305,7 +187,7 @@</span><br><span>     &quot;lz4v2&quot;,</span><br=
><span>     lz4v2_compress_init,</span><br><span>     lz4_compress_uninit,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    lz4v2_compress,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    lz4_compress,</spa=
n><br><span>     lz4v2_decompress</span><br><span> };</span><br><span> #end=
if /* ENABLE_LZ4 */</span><br><span>diff --git a/src/openvpn/comp.h b/src/o=
penvpn/comp.h</span><br><span>index 267f680b..ed6a563 100644</span><br><spa=
n>--- a/src/openvpn/comp.h</span><br><span>+++ b/src/openvpn/comp.h</span><=
br><span>@@ -32,8 +32,9 @@</span><br><span>  * outside of the USE_COMP defi=
ne */</span><br><span> </span><br><span> /* Compression flags */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ADAPTIVE         =
    (1&lt;&lt;0) /* COMP_ALG_LZO only */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) /* not =
only downlink is compressed but also uplink */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/*Removed */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/*#define COMP_F_ADAPTIVE             (1&lt;&lt;0) / * =
COMP_ALG_LZO only */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/*#define COMP_F_ALLOW_COMPRESS       (1&lt;&lt;1) / * not only downlink i=
s compressed but also uplink * / */</span><br><span> #define COMP_F_SWAP   =
              (1&lt;&lt;2) /* initial command byte is swapped with last byt=
e in buffer to preserve payload alignment */</span><br><span> #define COMP_=
F_ADVERTISE_STUBS_ONLY (1&lt;&lt;3) /* tell server that we only support com=
pression stubs */</span><br><span> #define COMP_F_ALLOW_STUB_ONLY      (1&l=
t;&lt;4) /* Only accept stub compression, even with COMP_F_ADVERTISE_STUBS_=
ONLY</span><br><span>diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c</sp=
an><br><span>index 7f0d53d..49f08d6 100644</span><br><span>--- a/src/openvp=
n/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><br><span>@@ -413,8 +=
413,7 @@</span><br><span> </span><br><span> #if defined(USE_COMP)</span><br=
><span>     if (o-&gt;comp.alg !=3D COMP_ALG_UNDEF</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        || o-&gt;comp.flags &amp; COMP_F_ALLOW=
_ASYM</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        || o-&gt=
;comp.flags &amp; COMP_F_ALLOW_COMPRESS)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        || o-&gt;comp.flags &amp; COMP_F_ALLOW_ASYM)</=
span><br><span>     {</span><br><span>         msg(msglevel, &quot;Note: &#=
39;--allow-compression&#39; is not set to &#39;no&#39;, disabling data chan=
nel offload.&quot;);</span><br><span> </span><br><span>diff --git a/src/ope=
nvpn/lzo.c b/src/openvpn/lzo.c</span><br><span>index bab2d78..a3cf3c1 10064=
4</span><br><span>--- a/src/openvpn/lzo.c</span><br><span>+++ b/src/openvpn=
/lzo.c</span><br><span>@@ -39,54 +39,6 @@</span><br><span> </span><br><span=
> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- * Perform adaptive compression housekeeping.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * @param ac the adaptive compression state structure.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * @return</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lzo_adapti=
ve_compress_test(struct lzo_adaptive_compress *ac)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const bool save =3D ac-&gt;compress_state;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    const time_t local_now =3D now;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (!ac-&gt;compress_state)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (local_now &gt;=3D ac-&gt;next)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (ac-&gt;n_total &gt; AC_MIN_=
BYTES</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
&amp;&amp; (ac-&gt;n_total - ac-&gt;n_comp) &lt; (ac-&gt;n_total / (100 / A=
C_SAVE_PCT)))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
ac-&gt;compress_state =3D true;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                ac-&gt;next =3D local_now + AC_OFF_SEC;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                ac-&gt;next =3D local_now + AC_SAMP=
_SEC;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP,=
 &quot;lzo_adaptive_compress_test: comp=3D%d total=3D%d&quot;, ac-&gt;n_com=
p, ac-&gt;n_total);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          ac-&gt;n_total =3D ac-&gt;n_comp =3D 0;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (local_now &gt;=3D=
 ac-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ac-&gt;n=
ext =3D local_now + AC_SAMP_SEC;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            ac-&gt;n_total =3D ac-&gt;n_comp =3D 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            ac-&gt;compress_state =
=3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (ac-&gt;compress_state !=3D save)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        dmsg(D_COMP_LOW, &quot;Adaptive compression state=
 %s&quot;, (ac-&gt;compress_state ? &quot;OFF&quot; : &quot;ON&quot;));</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    return !ac-&gt;compress_state;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span> </span><br><span> static inlin=
e void</span><br><span> lzo_adaptive_compress_data(struct lzo_adaptive_comp=
ress *ac, int n_total, int n_comp)</span><br><span>@@ -118,92 +70,13 @@</sp=
an><br><span>     compctx-&gt;wu.lzo.wmem =3D NULL;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static i=
nline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-lzo_compres=
sion_enabled(struct compress_context *compctx)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (!(compctx-&gt;flags &amp; COMP_F_ALLOW_COMPRESS))</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        return false;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (compctx-=
&gt;flags &amp; COMP_F_ADAPTIVE)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           return lzo_adaptive_compress_test(&amp;compctx-&gt;wu.lzo.ac);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            return true;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static =
void</span><br><span> lzo_compress(struct buffer *buf, struct buffer work,<=
/span><br><span>              struct compress_context *compctx,</span><br><=
span>              const struct frame *frame)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    lzo_uint zlen =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int err;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    bool compressed =3D false;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-     * In order to attempt compression, =
length must be at least COMPRESS_THRESHOLD,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-     * and our adaptive level must give the OK.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &gt;=3D COMPRESS_THRE=
SHOLD &amp;&amp; lzo_compression_enabled(compctx))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const size_t ps =3D frame-&gt;buf.payload_size;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_init(&amp=
;work, frame-&gt;buf.headroom));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        ASSERT(buf_safe(&amp;work, ps + COMP_EXTRA_BUFFER(ps)));=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if (buf-&gt;len &gt; ps)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP_ERRORS, &quot;LZO c=
ompression buffer overflow&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            buf-&gt;len =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            return;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        err =
=3D LZO_COMPRESS(BPTR(buf), BLEN(buf), BPTR(&amp;work), &amp;zlen, compctx-=
&gt;wu.lzo.wmem);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (err !=3D LZO_E_OK)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     dmsg(D_COMP_ERRORS, &quot;LZO compression error: %d&quot;, err);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf-&gt;len =3D=
 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        ASSERT(buf_safe(&amp;work, zlen));</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        work.len =3D zlen;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        compressed =3D true=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_COMP, &quot;LZO compress %=
d -&gt; %d&quot;, buf-&gt;len, work.len);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        compctx-&gt;pre_compress +=3D buf-&gt;len;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        compctx-&gt;post_c=
ompress +=3D work.len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* tell adap=
tive level about our success or lack thereof in getting any size reduction =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (compctx=
-&gt;flags &amp; COMP_F_ADAPTIVE)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            lzo_adaptive_compress_data(&amp;compctx-&gt;wu.lzo.ac, buf-&gt;=
len, work.len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    /* did compression save us anything ? */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (compressed &amp;&amp; wo=
rk.len &lt; buf-&gt;len)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8=
_t *header =3D buf_prepend(&amp;work, 1);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *header =3D LZO_COMPRESS_BYTE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        *buf =3D work;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 uint8_t *header =3D buf_prepend(buf, 1);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        *header =3D NO_COMPRESS_BYTE;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    uint8_t *header =3D buf_prepend(buf, 1);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    *header =3D NO_COMPRESS_=
BYTE;</span><br><span> }</span><br><span> </span><br><span> static void</sp=
an><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</sp=
an><br><span>index 649f48b..4fee671 100644</span><br><span>--- a/src/openvp=
n/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ =
-5715,17 +5715,10 @@</span><br><span> {</span><br><span>     if (comp_non_s=
tub_enabled(info))</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /*</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * Check if already displayed the strong warning and enabl=
ed full</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * com=
pression</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!(info-&gt;=
flags &amp; COMP_F_ALLOW_COMPRESS))</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(M_WARN, &quot;WARNING: Compression for receiving enabled.=
 &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  &quot;Compression has been used in the past to break encryption. &quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;S=
ent packets are not compressed unless \&quot;allow-compression yes\&quot; &=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
&quot;is also set.&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   msg(M_WARN, &quot;WARNING: Compression for receiving enabled. &quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;Compr=
ession has been used in the past to break encryption. &quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;Compression supp=
ort is deprecated and we recommend to disable &quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;it completely.&quot;);<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
>@@ -8435,18 +8428,14 @@</span><br><span>         }</span><br><span>       =
  else if (streq(p[1], &quot;asym&quot;))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp=
.flags &amp;=3D ~COMP_F_ALLOW_COMPRESS;</span><br><span>             option=
s-&gt;comp.flags |=3D COMP_F_ALLOW_ASYM;</span><br><span>         }</span><=
br><span>         else if (streq(p[1], &quot;yes&quot;))</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            m=
sg(M_WARN, &quot;WARNING: Compression for sending and receiving enabled. Co=
mpression has &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               &quot;been used in the past to break encryption. Allowing co=
mpression allows &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                &quot;attacks that break encryption. Using \&quot;--allow=
-compression yes\&quot; is &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;strongly discouraged for common usage. Se=
e --compress in the manual &quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                &quot;page for more information &quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN, &q=
uot;DEPRECATED OPTION: \&quot;--allow-compression yes\&quot; has been remov=
ed. &quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       &quot;We will use \&quot;asym\&quot; mode instead. See the manual pa=
ge for more information.&quot;);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            options-&gt;comp.flags |=3D COMP_F=
_ALLOW_COMPRESS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         options-&gt;comp.flags |=3D COMP_F_ALLOW_ASYM;</span><br><span>   =
      }</span><br><span>         else</span><br><span>         {</span><br>=
<span>@@ -8461,45 +8450,29 @@</span><br><span> </span><br><span>         /*=
 All lzo variants do not use swap */</span><br><span>         options-&gt;c=
omp.flags &amp;=3D ~COMP_F_SWAP;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        options-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p[1] &a=
mp;&amp; streq(p[1], &quot;no&quot;))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (p[1])</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp.alg =
=3D COMP_ALG_STUB;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         options-&gt;comp.flags &amp;=3D ~COMP_F_ADAPTIVE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        else if (p[1])</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            if (streq(p[1], &quot;yes&quot;))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            if (streq(p[1], &quot;n=
o&quot;))</span><br><span>             {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                options-&gt;comp.alg =3D COMP_ALG_LZO;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                options=
-&gt;comp.flags &amp;=3D ~COMP_F_ADAPTIVE;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                options-&gt;comp.alg =3D COMP_ALG_ST=
UB;</span><br><span>             }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            else if (streq(p[1], &quot;adaptive&quot;))</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;comp.alg=
 =3D COMP_ALG_LZO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             options-&gt;comp.flags |=3D COMP_F_ADAPTIVE;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            /* There is no actual difference anymo=
re between these variants.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * We never compress. On the server side we replace this=
 with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             *=
 --compress migrate later anyway.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else if (!(streq(p[1], &quot;yes&quot;) || streq(p[1]=
, &quot;adaptive&quot;)))</span><br><span>             {</span><br><span>  =
               msg(msglevel, &quot;bad comp-lzo option: %s -- must be &#39;=
yes&#39;, &#39;no&#39;, or &#39;adaptive&#39;&quot;, p[1]);</span><br><span=
>                 goto err;</span><br><span>             }</span><br><span>=
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;comp.alg=
 =3D COMP_ALG_LZO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         options-&gt;comp.flags |=3D COMP_F_ADAPTIVE;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>         show_com=
pression_warning(&amp;options-&gt;comp);</span><br><span>     }</span><br><=
span>     else if (streq(p[0], &quot;comp-noadapt&quot;) &amp;&amp; !p[1])<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         *=
 We do not need to check here if we allow compression since</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-         * it only modifies a flag if=
 compression is enabled</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-         */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
VERIFY_PERMISSION(OPT_P_COMP);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        options-&gt;comp.flags &amp;=3D ~COMP_F_ADAPTIVE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        /* NO-OP since we ne=
ver compress anymore */</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;compress&quot;) &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span>@@ -8528,7 +8501,7 @@</span><br><span>         else if (s=
treq(alg, &quot;lzo&quot;))</span><br><span>         {</span><br><span>    =
         options-&gt;comp.alg =3D COMP_ALG_LZO;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            options-&gt;comp.flags &amp;=3D ~(COM=
P_F_ADAPTIVE | COMP_F_SWAP);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            options-&gt;comp.flags &amp;=3D ~COMP_F_SWAP;</span><b=
r><span>         }</span><br><span>         else if (streq(alg, &quot;lz4&q=
uot;))</span><br><span>         {</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail"=
>change 755</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I402ba016b75cfcfec4fc8b2b01c=
c4eca7e2bcc60 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 755 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--CV2o/fEyQZ0=--

