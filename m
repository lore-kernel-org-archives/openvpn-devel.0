From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Aug 2024 12:30:12 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...,
 lstipakov@...277...
Message-ID: <3c6b6fa176b3784e1bbfba6594f0f868e9343a3b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="W16/RuP0V1M="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement support
 for AEAD tag at the end
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, syzzer <steffan@...1856...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--W16/RuP0V1M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa, syzzer.

cron2 has uploaded a new patch set (#9) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by stipa, Code-Review+2 by flichtenheld, Code-Review-1 by syz=
zer


Change subject: Implement support for AEAD tag at the end
......................................................................

Implement support for AEAD tag at the end

Using the AEAD tag at the end is the standard way of doing AEAD. Several
APIs even only support the tag at the end (e.g. mbed TLS). Having the tag at
the front or end makes no difference for security but allows streaming HW
implementations like NICs to be much more efficient as they do not need to
buffer a whole packet content and encrypt it to finally write the tag but
instead just add the calculated tag at the end of processing.

Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240214132719.3031492-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
239.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/push.c
M tests/unit_tests/openvpn/test_ssl.c
6 files changed, 80 insertions(+), 26 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/506/9

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 207f145..c226727 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -104,14 +104,10 @@
         ASSERT(cipher_ctx_reset(ctx->cipher, iv));
     }

-    /* Reserve space for authentication tag */
-    mac_out =3D buf_write_alloc(&work, mac_len);
-    ASSERT(mac_out);
-
     dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(=
buf), 80, &gc));

     /* Buffer overflow check */
-    if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx->c=
ipher)))
     {
         msg(D_CRYPT_ERRORS,
             "ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d w=
o=3D%d wl=3D%d",
@@ -121,9 +117,16 @@
     }

     /* For AEAD ciphers, authenticate Additional Data, including opcode */
-    ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work) - ma=
c_len));
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work)));
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
-         format_hex(BPTR(&work), BLEN(&work) - mac_len, 0, &gc));
+         format_hex(BPTR(&work), BLEN(&work), 0, &gc));
+
+    if (!(opt->flags & CO_AEAD_TAG_AT_THE_END))
+    {
+        /* Reserve space for authentication tag */
+        mac_out =3D buf_write_alloc(&work, mac_len);
+        ASSERT(mac_out);
+    }

     /* Encrypt packet ID, payload */
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf),=
 BLEN(buf)));
@@ -133,6 +136,14 @@
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));

+    /* if the tag is at end the end, allocate it now */
+    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        /* Reserve space for authentication tag */
+        mac_out =3D buf_write_alloc(&work, mac_len);
+        ASSERT(mac_out);
+    }
+
     /* Write authentication tag */
     ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, mac_len));

@@ -353,7 +364,6 @@
     static const char error_prefix[] =3D "AEAD Decrypt error";
     struct packet_id_net pin =3D { 0 };
     const struct key_ctx *ctx =3D &opt->key_ctx_bi.decrypt;
-    uint8_t *tag_ptr =3D NULL;
     int outlen;
     struct gc_arena gc;

@@ -406,19 +416,29 @@

     /* keep the tag value to feed in later */
     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;
-    if (buf->len < tag_size)
+    if (buf->len < tag_size + 1)
     {
-        CRYPT_ERROR("missing tag");
+        CRYPT_ERROR("missing tag or no payload");
     }
-    tag_ptr =3D BPTR(buf);
-    ASSERT(buf_advance(buf, tag_size));
+
+    const int ad_size =3D BPTR(buf) - ad_start;
+
+    uint8_t *tag_ptr =3D NULL;
+    int data_len =3D 0;
+
+    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        data_len =3D BLEN(buf) - tag_size;
+        tag_ptr =3D BPTR(buf) + data_len;
+    }
+    else
+    {
+        tag_ptr =3D BPTR(buf);
+        ASSERT(buf_advance(buf, tag_size));
+        data_len =3D BLEN(buf);
+    }
+
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size=
, 0, &gc));
-
-    if (buf->len < 1)
-    {
-        CRYPT_ERROR("missing payload");
-    }
-
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(=
buf), 0, &gc));

     /* Buffer overflow check (should never fail) */
@@ -427,20 +447,19 @@
         CRYPT_ERROR("potential buffer overflow");
     }

-    {
-        /* feed in tag and the authenticated data */
-        const int ad_size =3D BPTR(buf) - ad_start - tag_size;
-        ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
-        dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
-             format_hex(BPTR(buf) - ad_size - tag_size, ad_size, 0, &gc));
-    }
+
+    /* feed in tag and the authenticated data */
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
+    dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
+         format_hex(ad_start, ad_size, 0, &gc));

     /* Decrypt and authenticate packet */
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
-                           BLEN(buf)))
+                           data_len))
     {
         CRYPT_ERROR("cipher update failed");
     }
+
     ASSERT(buf_inc_len(&work, outlen));
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 85a0bfe..61184bc 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -279,6 +279,10 @@
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
+#define CO_AEAD_TAG_AT_THE_END  (1<<8)
+    /**< Bit-flag indicating that the AEAD tag is at the end of the
+     *   packet.
+     */

     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a49e563..3100100 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2328,6 +2328,10 @@
         {
             buf_printf(&out, " dyn-tls-crypt");
         }
+        if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+        {
+            buf_printf(&out, " aead-tag-end");
+        }
     }

     if (buf_len(&out) > strlen(header))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ba9b05e..d2ef895 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8692,6 +8692,10 @@
                 options->imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_C=
RYPT;
             }
 #endif
+            else if (streq(p[j], "aead-tag-end"))
+            {
+                options->imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_E=
ND;
+            }
             else
             {
                 msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index d220eeb..6c06374 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -29,6 +29,7 @@

 #include "push.h"
 #include "options.h"
+#include "crypto.h"
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
@@ -688,6 +689,11 @@
         buf_printf(&proto_flags, " dyn-tls-crypt");
     }

+    if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        buf_printf(&proto_flags, " aead-tag-end");
+    }
+
     if (buf_len(&proto_flags) > 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, "protocol-flags%s", buf_st=
r(&proto_flags));
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 5da5b1c..a4b2101 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -265,6 +265,17 @@

 }

+/* This adds a few more methods than strictly necessary but this allows
+ * us to see which exact test was run from the backtrace of the test
+ * when it fails */
+static void
+run_data_channel_with_cipher_end(const char *cipher)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, "none");
+    co.flags |=3D CO_AEAD_TAG_AT_THE_END;
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}

 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
@@ -274,21 +285,25 @@
     uninit_crypto_options(&co);
 }

+
 static void
 test_data_channel_roundtrip_aes_128_gcm(void **state)
 {
+    run_data_channel_with_cipher_end("AES-128-GCM");
     run_data_channel_with_cipher("AES-128-GCM", "none");
 }

 static void
 test_data_channel_roundtrip_aes_192_gcm(void **state)
 {
+    run_data_channel_with_cipher_end("AES-192-GCM");
     run_data_channel_with_cipher("AES-192-GCM", "none");
 }

 static void
 test_data_channel_roundtrip_aes_256_gcm(void **state)
 {
+    run_data_channel_with_cipher_end("AES-256-GCM");
     run_data_channel_with_cipher("AES-256-GCM", "none");
 }

@@ -318,6 +333,8 @@
         skip();
         return;
     }
+
+    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
     run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Gerrit-Change-Number: 506
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-Reviewer: syzzer <steffan@...1856...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: syzzer <steffan@...1856...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--W16/RuP0V1M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: stipa, syzzer. </p>
<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
506?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+1 by stipa, Code-Review+2 by flichtenheld, Code-Review-1 by syz=
zer</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Implement support for AEAD tag at the end<br><br>Using the AEAD tag at =
the end is the standard way of doing AEAD. Several<br>APIs even only suppor=
t the tag at the end (e.g. mbed TLS). Having the tag at<br>the front or end=
 makes no difference for security but allows streaming HW<br>implementation=
s like NICs to be much more efficient as they do not need to<br>buffer a wh=
ole packet content and encrypt it to finally write the tag but<br>instead j=
ust add the calculated tag at the end of processing.<br><br>Change-Id: I008=
21d75342daf3f813b829812d648fe298bea81<br>Signed-off-by: Arne Schwabe &lt;ar=
ne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Message-Id: &lt;20240214132719.3031492-1-frank@...2641...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28239.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/crypto.c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/op=
envpn/options.c<br>M src/openvpn/push.c<br>M tests/unit_tests/openvpn/test_=
ssl.c<br>6 files changed, 80 insertions(+), 26 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/506/9</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>inde=
x 207f145..c226727 100644</span><br><span>--- a/src/openvpn/crypto.c</span>=
<br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -104,14 +104,10 @@<=
/span><br><span>         ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv));</spa=
n><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    /* Reserve space for authentication tag */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    mac_out =3D buf_write_alloc(&am=
p;work, mac_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
ASSERT(mac_out);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, forma=
t_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span> </span><br><spa=
n>     /* Buffer overflow check */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_si=
ze(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!buf_safe(&amp;work, buf-&gt;len + mac_len + cipher_ctx_block_size=
(ctx-&gt;cipher)))</span><br><span>     {</span><br><span>         msg(D_CR=
YPT_ERRORS,</span><br><span>             &quot;ENCRYPT: buffer size error, =
bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br><span>@@ -=
121,9 +117,16 @@</span><br><span>     }</span><br><span> </span><br><span> =
    /* For AEAD ciphers, authenticate Additional Data, including opcode */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_=
update_ad(ctx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work) - mac_len));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_u=
pdate_ad(ctx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work)));</span><br><spa=
n>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-         format_hex(BPTR(&amp;work), BL=
EN(&amp;work) - mac_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+         format_hex(BPTR(&amp;work), BLEN(&amp;work), 0,=
 &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(opt-&gt;flags &am=
p; CO_AEAD_TAG_AT_THE_END))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* Reserve space for authentication tag */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_alloc(&amp;work, mac=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(mac_out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span> </span><br><span>     /* Encrypt packet ID, payload */</span=
><br><span>     ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work), &=
amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>@@ -133,6 +136,14 @@</s=
pan><br><span>     ASSERT(cipher_ctx_final(ctx-&gt;cipher, BEND(&amp;work),=
 &amp;outlen));</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen))=
;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* if the tag is at end the end, allocate it now */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; CO_AEAD_TAG=
_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Reserve sp=
ace for authentication tag */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mac_out);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Write authen=
tication tag */</span><br><span>     ASSERT(cipher_ctx_get_tag(ctx-&gt;ciph=
er, mac_out, mac_len));</span><br><span> </span><br><span>@@ -353,7 +364,6 =
@@</span><br><span>     static const char error_prefix[] =3D &quot;AEAD Dec=
rypt error&quot;;</span><br><span>     struct packet_id_net pin =3D { 0 };<=
/span><br><span>     const struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.=
decrypt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *=
tag_ptr =3D NULL;</span><br><span>     int outlen;</span><br><span>     str=
uct gc_arena gc;</span><br><span> </span><br><span>@@ -406,19 +416,29 @@</s=
pan><br><span> </span><br><span>     /* keep the tag value to feed in later=
 */</span><br><span>     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt;=
 tag_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (b=
uf-&gt;len &lt; tag_size + 1)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing tag&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        CRYPT_ERR=
OR(&quot;missing tag or no payload&quot;);</span><br><span>     }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    tag_ptr =3D BPTR(buf);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_advance(buf=
, tag_size));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int ad_size =3D=
 BPTR(buf) - ad_start;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *tag=
_ptr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt data_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flag=
s &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      data_len =3D BLEN(buf) - tag_size;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tag_ptr =3D BPTR(buf) + data_len;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        tag_ptr =3D BPTR(buf);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ASSERT(buf_advance(buf, tag_size));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        data_len =3D BLEN(buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     dmsg(D_PACKET_CO=
NTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;g=
c));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; 1)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing payload&quot;)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     dmsg(D_PACKET_=
CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 0, =
&amp;gc));</span><br><span> </span><br><span>     /* Buffer overflow check =
(should never fail) */</span><br><span>@@ -427,20 +447,19 @@</span><br><spa=
n>         CRYPT_ERROR(&quot;potential buffer overflow&quot;);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* feed in tag and the authenticated data */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        const int ad_size =3D BPTR(buf) - ad_start - =
tag_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSE=
RT(cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot=
;DECRYPT AD: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-             format_hex(BPTR(buf) - ad_size - tag_size, ad_size, 0, &amp;g=
c));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /* feed in tag and the authenticated data */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx=
_update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         for=
mat_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span><br><span>=
     /* Decrypt and authenticate packet */</span><br><span>     if (!cipher=
_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                           B=
LEN(buf)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                  data_len))</span><br><span>     {</span><br><span>       =
  CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     A=
SSERT(buf_inc_len(&amp;work, outlen));</span><br><span>     if (!cipher_ctx=
_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</span><br><span>=
                                     &amp;outlen, tag_ptr, tag_size))</span=
><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><=
br><span>index 85a0bfe..61184bc 100644</span><br><span>--- a/src/openvpn/cr=
ypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -279,6=
 +279,10 @@</span><br><span>     /**&lt; Bit-flag indicating that renegotia=
tions are using tls-crypt</span><br><span>      *   with a TLS-EKM derived =
key.</span><br><span>      */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#define CO_AEAD_TAG_AT_THE_END  (1&lt;&lt;8)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag indicating that the=
 AEAD tag is at the end of the</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     *   packet.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     */</span><br><span> </span><br><span>     unsigned int flags; =
        /**&lt; Bit-flags determining behavior of</span><br><span>         =
                         *   security operation functions. */</span><br><sp=
an>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>ind=
ex a49e563..3100100 100644</span><br><span>--- a/src/openvpn/init.c</span><=
br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2328,6 +2328,10 @@</s=
pan><br><span>         {</span><br><span>             buf_printf(&amp;out, =
&quot; dyn-tls-crypt&quot;);</span><br><span>         }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;imported_protocol_fla=
gs &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            buf_printf(&amp;out, &quot; aead-tag-end&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> </span><br><span>     if (buf_len(&amp;out) &gt; strlen(=
header))</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/o=
ptions.c</span><br><span>index ba9b05e..d2ef895 100644</span><br><span>--- =
a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><=
br><span>@@ -8692,6 +8692,10 @@</span><br><span>                 options-&g=
t;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><br><span>  =
           }</span><br><span> #endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            else if (streq(p[j], &quot;aead-tag-end&quot;)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                options-=
&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>        =
     else</span><br><span>             {</span><br><span>                 m=
sg(msglevel, &quot;Unknown protocol-flags flag: %s&quot;, p[j]);</span><br>=
<span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>=
index d220eeb..6c06374 100644</span><br><span>--- a/src/openvpn/push.c</spa=
n><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -29,6 +29,7 @@</spa=
n><br><span> </span><br><span> #include &quot;push.h&quot;</span><br><span>=
 #include &quot;options.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#include &quot;crypto.h&quot;</span><br><span> #include &quot;s=
sl.h&quot;</span><br><span> #include &quot;ssl_verify.h&quot;</span><br><sp=
an> #include &quot;ssl_ncp.h&quot;</span><br><span>@@ -688,6 +689,11 @@</sp=
an><br><span>         buf_printf(&amp;proto_flags, &quot; dyn-tls-crypt&quo=
t;);</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (o-&gt;imported_protocol_flags &amp; CO_AE=
AD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_pri=
ntf(&amp;proto_flags, &quot; aead-tag-end&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)=
</span><br><span>     {</span><br><span>         push_option_fmt(gc, push_l=
ist, M_USAGE, &quot;protocol-flags%s&quot;, buf_str(&amp;proto_flags));</sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_=
tests/openvpn/test_ssl.c</span><br><span>index 5da5b1c..a4b2101 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_ssl.c</span><br><span>@@ -265,6 +265,17 @@</=
span><br><span> </span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* This adds a few more methods than stri=
ctly necessary but this allows</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * us to see which exact test was run from the backtrace of the =
test</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when it fail=
s */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+run_data_channel_with_c=
ipher_end(const char *cipher)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct crypto_options co =3D init_crypto_options(cipher, &quot;none&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    co.flags |=3D CO_AE=
AD_TAG_AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   do_data_channel_round_trip(&amp;co);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    uninit_crypto_options(&amp;co);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> st=
atic void</span><br><span> run_data_channel_with_cipher(const char *cipher,=
 const char *auth)</span><br><span>@@ -274,21 +285,25 @@</span><br><span>  =
   uninit_crypto_options(&amp;co);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> stati=
c void</span><br><span> test_data_channel_roundtrip_aes_128_gcm(void **stat=
e)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    run_data_channel_with_cipher_end(&quot;AES-128-GCM&quot;);</span><br>=
<span>     run_data_channel_with_cipher(&quot;AES-128-GCM&quot;, &quot;none=
&quot;);</span><br><span> }</span><br><span> </span><br><span> static void<=
/span><br><span> test_data_channel_roundtrip_aes_192_gcm(void **state)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
un_data_channel_with_cipher_end(&quot;AES-192-GCM&quot;);</span><br><span> =
    run_data_channel_with_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;)=
;</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br><span> test_data_channel_roundtrip_aes_256_gcm(void **state)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data=
_channel_with_cipher_end(&quot;AES-256-GCM&quot;);</span><br><span>     run=
_data_channel_with_cipher(&quot;AES-256-GCM&quot;, &quot;none&quot;);</span=
><br><span> }</span><br><span> </span><br><span>@@ -318,6 +333,8 @@</span><=
br><span>         skip();</span><br><span>         return;</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher=
_end(&quot;ChaCha20-Poly1305&quot;);</span><br><span>     run_data_channel_=
with_cipher(&quot;ChaCha20-Poly1305&quot;, &quot;none&quot;);</span><br><sp=
an> }</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">change 50=
6</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: syzzer &lt;steffan@...1856...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: syzzer &lt;steffan@...2115...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--W16/RuP0V1M=--

