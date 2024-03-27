From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 27 Mar 2024 10:34:05 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <0ef1dfe70bdb28d895d704a9e659c741c93eedd4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DOtP/gi8O14="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DOtP/gi8O14=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail

to look at the new patch set (#4).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


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
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/push.c
M tests/unit_tests/openvpn/test_ssl.c
6 files changed, 80 insertions(+), 26 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/506/4

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5d05cc4..9758c8c 100644
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
=20
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
index 02205e7..c56ce48 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2312,6 +2312,10 @@
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
index 768332d..cb8ff88 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8683,6 +8683,10 @@
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
index 1b406b9..10806ac 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -29,6 +29,7 @@

 #include "push.h"
 #include "options.h"
+#include "crypto.h"
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
@@ -686,6 +687,11 @@
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
index a9a3137..8d73858 100644
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--DOtP/gi8O14=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">View Chang=
e</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is=
 unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Implement support for AEAD tag at the end<br><br>Using th=
e AEAD tag at the end is the standard way of doing AEAD. Several<br>APIs ev=
en only support the tag at the end (e.g. mbed TLS). Having the tag at<br>th=
e front or end makes no difference for security but allows streaming HW<br>=
implementations like NICs to be much more efficient as they do not need to<=
br>buffer a whole packet content and encrypt it to finally write the tag bu=
t<br>instead just add the calculated tag at the end of processing.<br><br>C=
hange-Id: I00821d75342daf3f813b829812d648fe298bea81<br>Signed-off-by: Arne =
Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/o=
penvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M src=
/openvpn/push.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>6 files changed=
, 80 insertions(+), 26 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/06/506/4</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/c=
rypto.c b/src/openvpn/crypto.c</span><br><span>index 5d05cc4..9758c8c 10064=
4</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b/src/open=
vpn/crypto.c</span><br><span>@@ -104,14 +104,10 @@</span><br><span>        =
 ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv));</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Re=
serve space for authentication tag */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    mac_out =3D buf_write_alloc(&amp;work, mac_len);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mac_out);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     dmsg(D_=
PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(bu=
f), 80, &amp;gc));</span><br><span> </span><br><span>     /* Buffer overflo=
w check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!bu=
f_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_safe(&amp;=
work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cipher)))</span=
><br><span>     {</span><br><span>         msg(D_CRYPT_ERRORS,</span><br><s=
pan>             &quot;ENCRYPT: buffer size error, bc=3D%d bo=3D%d bl=3D%d =
wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br><span>@@ -121,9 +117,16 @@</span><=
br><span>     }</span><br><span> </span><br><span>     /* For AEAD ciphers,=
 authenticate Additional Data, including opcode */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher=
, BPTR(&amp;work), BLEN(&amp;work) - mac_len));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher,=
 BPTR(&amp;work), BLEN(&amp;work)));</span><br><span>     dmsg(D_PACKET_CON=
TENT, &quot;ENCRYPT AD: %s&quot;,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-         format_hex(BPTR(&amp;work), BLEN(&amp;work) - mac_len,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
    format_hex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!(opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_EN=
D))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* Reserve space for a=
uthentication tag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mac_out);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><b=
r><span>     /* Encrypt packet ID, payload */</span><br><span>     ASSERT(c=
ipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen, BPTR(buf), B=
LEN(buf)));</span><br><span>@@ -133,6 +136,14 @@</span><br><span>     ASSER=
T(cipher_ctx_final(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen));</span><b=
r><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if the tag is at =
end the end, allocate it now */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Reserve space for authentication t=
ag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mac_ou=
t =3D buf_write_alloc(&amp;work, mac_len);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        ASSERT(mac_out);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     /* Write authentication tag */</span><b=
r><span>     ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_out, mac_len));<=
/span><br><span> </span><br><span>@@ -353,7 +364,6 @@</span><br><span>     =
static const char error_prefix[] =3D &quot;AEAD Decrypt error&quot;;</span>=
<br><span>     struct packet_id_net pin =3D { 0 };</span><br><span>     con=
st struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *tag_ptr =3D NULL;</span>=
<br><span>     int outlen;</span><br><span>     struct gc_arena gc;</span><=
br><span> </span><br><span>@@ -406,19 +416,29 @@</span><br><span> </span><b=
r><span>     /* keep the tag value to feed in later */</span><br><span>    =
 const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; tag_size)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    if (buf-&gt;len &lt; tag_size=
 + 1)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        CRYPT_ERROR(&quot;missing tag&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        CRYPT_ERROR(&quot;missing tag or =
no payload&quot;);</span><br><span>     }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    tag_ptr =3D BPTR(buf);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(buf_advance(buf, tag_size));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    const int ad_size =3D BPTR(buf) - ad_start;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    uint8_t *tag_ptr =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int data_len =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_T=
HE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        data_len =3D BLEN(=
buf) - tag_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     tag_ptr =3D BPTR(buf) + data_len;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tag_ptr =3D =
BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        A=
SSERT(buf_advance(buf, tag_size));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        data_len =3D BLEN(buf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT MAC=
: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (buf-&gt;len &lt; 1)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        CRYPT_ERROR(&quot;missing payload&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;DECRYPT =
FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 0, &amp;gc));</span><br><s=
pan> </span><br><span>     /* Buffer overflow check (should never fail) */<=
/span><br><span>@@ -427,20 +447,19 @@</span><br><span>         CRYPT_ERROR(=
&quot;potential buffer overflow&quot;);</span><br><span>     }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        /* feed in tag and the a=
uthenticated data */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const int ad_size =3D BPTR(buf) - ad_start - tag_size;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(cipher_ctx_update_ad=
(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-             format_he=
x(BPTR(buf) - ad_size - tag_size, ad_size, 0, &amp;gc));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* feed in tag and the authenticated data */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update_ad(ctx-&gt;ciph=
er, ad_start, ad_size));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+         format_hex(ad_start, ad_si=
ze, 0, &amp;gc));</span><br><span> </span><br><span>     /* Decrypt and aut=
henticate packet */</span><br><span>     if (!cipher_ctx_update(ctx-&gt;cip=
her, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                           BLEN(buf)))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                           data_=
len))</span><br><span>     {</span><br><span>         CRYPT_ERROR(&quot;cip=
her update failed&quot;);</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     ASSERT(buf_inc_len(&amp;=
work, outlen));</span><br><span>     if (!cipher_ctx_final_check_tag(ctx-&g=
t;cipher, BPTR(&amp;work) + outlen,</span><br><span>                       =
              &amp;outlen, tag_ptr, tag_size))</span><br><span>diff --git a=
/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><span>index 85a0bfe.=
.61184bc 100644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>=
+++ b/src/openvpn/crypto.h</span><br><span>@@ -279,6 +279,10 @@</span><br><=
span>     /**&lt; Bit-flag indicating that renegotiations are using tls-cry=
pt</span><br><span>      *   with a TLS-EKM derived key.</span><br><span>  =
    */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CO_AE=
AD_TAG_AT_THE_END  (1&lt;&lt;8)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /**&lt; Bit-flag indicating that the AEAD tag is at the end=
 of the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *   pac=
ket.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><=
br><span> </span><br><span>     unsigned int flags;         /**&lt; Bit-fla=
gs determining behavior of</span><br><span>                                =
  *   security operation functions. */</span><br><span>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</span><br><span>index 02205e7..c56ce48 100=
644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/open=
vpn/init.c</span><br><span>@@ -2312,6 +2312,10 @@</span><br><span>         =
{</span><br><span>             buf_printf(&amp;out, &quot; dyn-tls-crypt&qu=
ot;);</span><br><span>         }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if (o-&gt;imported_protocol_flags &amp; CO_AEAD_TAG_AT=
_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_prin=
tf(&amp;out, &quot; aead-tag-end&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </sp=
an><br><span>     if (buf_len(&amp;out) &gt; strlen(header))</span><br><spa=
n>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><spa=
n>index 768332d..cb8ff88 100644</span><br><span>--- a/src/openvpn/options.c=
</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -8683,6 +86=
83,10 @@</span><br><span>                 options-&gt;imported_protocol_fla=
gs |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><br><span>             }</span><br>=
<span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      else if (streq(p[j], &quot;aead-tag-end&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                options-&gt;imported_protocol_f=
lags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span>             else</span><br><sp=
an>             {</span><br><span>                 msg(msglevel, &quot;Unkn=
own protocol-flags flag: %s&quot;, p[j]);</span><br><span>diff --git a/src/=
openvpn/push.c b/src/openvpn/push.c</span><br><span>index 1b406b9..10806ac =
100644</span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/o=
penvpn/push.c</span><br><span>@@ -29,6 +29,7 @@</span><br><span> </span><br=
><span> #include &quot;push.h&quot;</span><br><span> #include &quot;options=
.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &q=
uot;crypto.h&quot;</span><br><span> #include &quot;ssl.h&quot;</span><br><s=
pan> #include &quot;ssl_verify.h&quot;</span><br><span> #include &quot;ssl_=
ncp.h&quot;</span><br><span>@@ -686,6 +687,11 @@</span><br><span>         b=
uf_printf(&amp;proto_flags, &quot; dyn-tls-crypt&quot;);</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (o-&gt;imported_protocol_flags &amp; CO_AEAD_TAG_AT_THE_END)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;proto_flags, &=
quot; aead-tag-end&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (buf_len(&amp;proto_flags) &gt; 0)</span><br><span>     {=
</span><br><span>         push_option_fmt(gc, push_list, M_USAGE, &quot;pro=
tocol-flags%s&quot;, buf_str(&amp;proto_flags));</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.=
c</span><br><span>index a9a3137..8d73858 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/unit_tests/openv=
pn/test_ssl.c</span><br><span>@@ -265,6 +265,17 @@</span><br><span> </span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+/* This adds a few more methods than strictly necessary but this=
 allows</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * us to see=
 which exact test was run from the backtrace of the test</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * when it fails */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+run_data_channel_with_cipher_end(const char *c=
ipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct crypto_options co =
=3D init_crypto_options(cipher, &quot;none&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    co.flags |=3D CO_AEAD_TAG_AT_THE_END;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_data_channel_ro=
und_trip(&amp;co);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   uninit_crypto_options(&amp;co);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span> </span><br><span> static void</span><br><=
span> run_data_channel_with_cipher(const char *cipher, const char *auth)</s=
pan><br><span>@@ -274,21 +285,25 @@</span><br><span>     uninit_crypto_opti=
ons(&amp;co);</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><spa=
n> test_data_channel_roundtrip_aes_128_gcm(void **state)</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channe=
l_with_cipher_end(&quot;AES-128-GCM&quot;);</span><br><span>     run_data_c=
hannel_with_cipher(&quot;AES-128-GCM&quot;, &quot;none&quot;);</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span> test=
_data_channel_roundtrip_aes_192_gcm(void **state)</span><br><span> {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_=
cipher_end(&quot;AES-192-GCM&quot;);</span><br><span>     run_data_channel_=
with_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;);</span><br><span> }<=
/span><br><span> </span><br><span> static void</span><br><span> test_data_c=
hannel_roundtrip_aes_256_gcm(void **state)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher_=
end(&quot;AES-256-GCM&quot;);</span><br><span>     run_data_channel_with_ci=
pher(&quot;AES-256-GCM&quot;, &quot;none&quot;);</span><br><span> }</span><=
br><span> </span><br><span>@@ -318,6 +333,8 @@</span><br><span>         ski=
p();</span><br><span>         return;</span><br><span>     }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    run_data_channel_with_cipher_end(&quot;ChaCha20-P=
oly1305&quot;);</span><br><span>     run_data_channel_with_cipher(&quot;Cha=
Cha20-Poly1305&quot;, &quot;none&quot;);</span><br><span> }</span><br><span=
> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/506?usp=3Demail">change 506</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--DOtP/gi8O14=--

