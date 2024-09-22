From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 22 Sep 2024 14:15:37 +0000
References: <gerrit.1727014533000.I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <cd87cad85d446712f70b3d505e4e56ea29a65c41-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hD143hGxLEU="; charset=UTF-8
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

--hD143hGxLEU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail

to review the following change.


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
M src/openvpn/comp-lz4.c
M src/openvpn/comp.h
M src/openvpn/dco.c
M src/openvpn/lzo.c
M src/openvpn/options.c
6 files changed, 19 insertions(+), 269 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/755/1

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
index 267f680b..decf0d9 100644
--- a/src/openvpn/comp.h
+++ b/src/openvpn/comp.h
@@ -33,7 +33,8 @@

 /* Compression flags */
 #define COMP_F_ADAPTIVE             (1<<0) /* COMP_ALG_LZO only */
-#define COMP_F_ALLOW_COMPRESS       (1<<1) /* not only downlink is compres=
sed but also uplink */
+/*Removed */
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
index 649f48b..4745ddf 100644
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7e2bcc60
Gerrit-Change-Number: 755
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--hD143hGxLEU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove support for compression on send<br><br>We can&#39;t di=
sable compression support on receive because<br>that would break too many c=
onfigurations out there. But<br>we can remove the support for compressing o=
utgoing traffic,<br>it was disabled by default anyway.<br><br>Makes --allow=
-compression yes is an alias for<br>--allow-compression asym and removes al=
l resulting dead code.<br><br>Change-Id: I402ba016b75cfcfec4fc8b2b01cc4eca7=
e2bcc60<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---=
<br>M Changes.rst<br>M src/openvpn/comp-lz4.c<br>M src/openvpn/comp.h<br>M =
src/openvpn/dco.c<br>M src/openvpn/lzo.c<br>M src/openvpn/options.c<br>6 fi=
les changed, 19 insertions(+), 269 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/55/755/1</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/C=
hanges.rst b/Changes.rst</span><br><span>index 439352a..b9287ce 100644</spa=
n><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</span><br><=
span>@@ -46,6 +46,12 @@</span><br><span>     Support for building with Open=
SSL 1.0.2 has been removed. The minimum</span><br><span>     supported Open=
SSL version is now 1.1.0.</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+Compression on send</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    OpenVPN 2.7 will never compress data before sen=
ding. Decompression of</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    received data is still supported.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ``--allow-compression yes`` is now an alias for</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``--allow-compress=
ion asym``.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> Overview of changes in 2.6</span><br><span> =3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span> =
</span><br><span>diff --git a/src/openvpn/comp-lz4.c b/src/openvpn/comp-lz4=
.c</span><br><span>index ac020a4..f9eee11 100644</span><br><span>--- a/src/=
openvpn/comp-lz4.c</span><br><span>+++ b/src/openvpn/comp-lz4.c</span><br><=
span>@@ -55,129 +55,11 @@</span><br><span> {</span><br><span> }</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-do_lz4_compress(struct bu=
ffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     struct buffer *work,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                struct compress_context *compctx,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                const struct frame *frame)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * In order to attempt compression, length must be at=
 least COMPRESS_THRESHOLD.</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     * and asymmetric compression must be disabled</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-     */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    if (buf-&gt;len &gt;=3D COMPRESS_THRESHOLD &amp;&am=
p; (compctx-&gt;flags &amp; COMP_F_ALLOW_COMPRESS))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const size_t ps =3D frame-&gt;buf.payload_size;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        int zlen_max =3D =
ps + COMP_EXTRA_BUFFER(ps);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int zlen;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_=
init(work, frame-&gt;buf.headroom));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        ASSERT(buf_safe(work, zlen_max));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (buf-&gt;len &gt; ps)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            dmsg(D_COMP_ERRORS, &quot;LZ4 compression buffer o=
verflow&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            return false;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        zlen =3D LZ4_compr=
ess_default((const char *)BPTR(buf), (char *)BPTR(work), BLEN(buf), zlen_ma=
x);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (zlen &lt;=3D 0)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            dmsg(D_COMP_ERRORS, &quot;LZ4 c=
ompression error&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            buf-&gt;len =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            return false;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(bu=
f_safe(work, zlen));</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       work-&gt;len =3D zlen;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_COMP, &quot;LZ4 com=
press %d -&gt; %d&quot;, buf-&gt;len, work-&gt;len);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        compctx-&gt;pre_compress +=3D buf-&=
gt;len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        compct=
x-&gt;post_compress +=3D work-&gt;len;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    return false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><sp=
an> lz4_compress(struct buffer *buf, struct buffer work,</span><br><span>  =
            struct compress_context *compctx,</span><br><span>             =
 const struct frame *frame)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bool compressed;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    compressed =3D do_lz4_=
compress(buf, &amp;work, compctx, frame);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* On error do_lz4_compress sets buf len to zero, just return */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len =3D=3D 0)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* did compression save us anything? */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        uint8_t comp_head_byte =3D NO_COMPRESS_BYTE_SWAP;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (compressed &amp;&amp; work=
.len &lt; buf-&gt;len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 *buf =3D work;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      comp_head_byte =3D LZ4_COMPRESS_BYTE;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            uint8_t *he=
ad =3D BPTR(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        uint8_t *tail  =3D BEND(buf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ASSERT(buf_safe(buf, 1));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            ++buf-&gt;len;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            /* move head byte of payload to tail */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            *tail =3D *head;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            *head =3D =
comp_head_byte;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-lz4v2_compress(struct buffer *b=
uf, struct buffer work,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-               struct compress_context *compctx,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-               const struct frame *frame)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    bool compressed;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=3D 0)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    compressed =3D do_=
lz4_compress(buf, &amp;work, compctx, frame);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* On Error just return */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (buf-&gt;len =3D=3D 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* did compression save us anything=
?  Include 2 byte compression header</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-     * in calculation */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (compressed &amp;&amp; work.len + 2 &lt; buf-&gt;l=
en)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_prepend(&amp;wo=
rk, 2));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8=
_t *head =3D BPTR(&amp;work);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        head[0] =3D COMP_ALGV2_INDICATOR_BYTE;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        head[1] =3D COMP_ALGV2_LZ4_BYTE;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        *buf =3D work;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        compv2_escape_data_ifneeded(buf);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span> }</span><br><span> </spa=
n><br><span> static void</span><br><span>@@ -305,7 +187,7 @@</span><br><spa=
n>     &quot;lz4v2&quot;,</span><br><span>     lz4v2_compress_init,</span><=
br><span>     lz4_compress_uninit,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    lz4v2_compress,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    lz4_compress,</span><br><span>     lz4v2_decompress</span>=
<br><span> };</span><br><span> #endif /* ENABLE_LZ4 */</span><br><span>diff=
 --git a/src/openvpn/comp.h b/src/openvpn/comp.h</span><br><span>index 267f=
680b..decf0d9 100644</span><br><span>--- a/src/openvpn/comp.h</span><br><sp=
an>+++ b/src/openvpn/comp.h</span><br><span>@@ -33,7 +33,8 @@</span><br><sp=
an> </span><br><span> /* Compression flags */</span><br><span> #define COMP=
_F_ADAPTIVE             (1&lt;&lt;0) /* COMP_ALG_LZO only */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#define COMP_F_ALLOW_COMPRESS       =
(1&lt;&lt;1) /* not only downlink is compressed but also uplink */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/*Removed */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*#define COMP_F_ALLOW_COMPRESS    =
   (1&lt;&lt;1) / * not only downlink is compressed but also uplink * / */<=
/span><br><span> #define COMP_F_SWAP                 (1&lt;&lt;2) /* initia=
l command byte is swapped with last byte in buffer to preserve payload alig=
nment */</span><br><span> #define COMP_F_ADVERTISE_STUBS_ONLY (1&lt;&lt;3) =
/* tell server that we only support compression stubs */</span><br><span> #=
define COMP_F_ALLOW_STUB_ONLY      (1&lt;&lt;4) /* Only accept stub compres=
sion, even with COMP_F_ADVERTISE_STUBS_ONLY</span><br><span>diff --git a/sr=
c/openvpn/dco.c b/src/openvpn/dco.c</span><br><span>index 7f0d53d..49f08d6 =
100644</span><br><span>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/op=
envpn/dco.c</span><br><span>@@ -413,8 +413,7 @@</span><br><span> </span><br=
><span> #if defined(USE_COMP)</span><br><span>     if (o-&gt;comp.alg !=3D =
COMP_ALG_UNDEF</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 || o-&gt;comp.flags &amp; COMP_F_ALLOW_ASYM</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        || o-&gt;comp.flags &amp; COMP_F_ALLOW_COMPR=
ESS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || o-&g=
t;comp.flags &amp; COMP_F_ALLOW_ASYM)</span><br><span>     {</span><br><spa=
n>         msg(msglevel, &quot;Note: &#39;--allow-compression&#39; is not s=
et to &#39;no&#39;, disabling data channel offload.&quot;);</span><br><span=
> </span><br><span>diff --git a/src/openvpn/lzo.c b/src/openvpn/lzo.c</span=
><br><span>index bab2d78..a3cf3c1 100644</span><br><span>--- a/src/openvpn/=
lzo.c</span><br><span>+++ b/src/openvpn/lzo.c</span><br><span>@@ -39,54 +39=
,6 @@</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * Perform adaptive compre=
ssion housekeeping.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param ac the adap=
tive compression state structure.</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ret=
urn</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-lzo_adaptive_compress_test(struct lzo_adaptive=
_compress *ac)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    const bool save =3D ac-=
&gt;compress_state;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  const time_t local_now =3D now;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
ac-&gt;compress_state)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (loc=
al_now &gt;=3D ac-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (ac-&gt;n_total &gt; AC_MIN_BYTES</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                &amp;&amp; (ac-&gt;n_total - ac-&gt;n_=
comp) &lt; (ac-&gt;n_total / (100 / AC_SAVE_PCT)))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                ac-&gt;compress_state =3D true;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                ac-&gt;next =
=3D local_now + AC_OFF_SEC;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 ac-&gt;next =3D local_now + AC_SAMP_SEC;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            dmsg(D_COMP, &quot;lzo_adaptive_compress_test: comp=
=3D%d total=3D%d&quot;, ac-&gt;n_comp, ac-&gt;n_total);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            ac-&gt;n_total =3D ac-&gt;n_c=
omp =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (local_now &gt;=3D ac-&gt;next)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            ac-&gt;next =3D local_now + AC_SAMP_SEC;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            ac-&gt;n_total =
=3D ac-&gt;n_comp =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            ac-&gt;compress_state =3D false;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ac-&gt;compress=
_state !=3D save)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_COMP_=
LOW, &quot;Adaptive compression state %s&quot;, (ac-&gt;compress_state ? &q=
uot;OFF&quot; : &quot;ON&quot;));</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !ac-&gt;compre=
ss_state;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br>=
<span> </span><br><span> static inline void</span><br><span> lzo_adaptive_c=
ompress_data(struct lzo_adaptive_compress *ac, int n_total, int n_comp)</sp=
an><br><span>@@ -118,92 +70,13 @@</span><br><span>     compctx-&gt;wu.lzo.w=
mem =3D NULL;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-static inline bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-lzo_compression_enabled(struct compress_context *=
compctx)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (!(compctx-&gt;flags &amp;=
 COMP_F_ALLOW_COMPRESS))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retur=
n false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (compctx-&gt;flags &amp; COMP_F_ADAPTIVE)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            return lzo_adaptive_compres=
s_test(&amp;compctx-&gt;wu.lzo.ac);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
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
n/options.c b/src/openvpn/options.c</span><br><span>index 649f48b..4745ddf =
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
</span><br><span>         {</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail">chang=
e 755</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/755?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I402ba016b75cfcfec4fc8b2b01c=
c4eca7e2bcc60 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 755 </div>
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


--hD143hGxLEU=--

