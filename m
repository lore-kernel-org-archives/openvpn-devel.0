From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 25 Jan 2024 12:38:17 +0000
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7b5f4c01bb8b841ba64349804e2d44ecd34178ec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0tzd33YRv7o="; charset=UTF-8
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

--0tzd33YRv7o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail

to review the following change.


Change subject: Implement support for AEAD tag at the end
......................................................................

Implement support for AEAD tag at the end

Change-Id: I00821d75342daf3f813b829812d648fe298bea81
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/push.c
M src/openvpn/ssl.h
M tests/unit_tests/openvpn/test_ssl.c
7 files changed, 85 insertions(+), 26 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/506/1

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 2fca131..9988ebe 100644
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
=20
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
index 4201524..95a5b31 100644
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
index c5cc154..cd37b36 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2323,6 +2323,10 @@
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
index 2c79a1e..39f00c0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8686,6 +8686,10 @@
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
index 2249434..e4c122c 100644
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
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 71b99db..a1c67a2 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -107,6 +107,9 @@
 /** Support to dynamic tls-crypt (renegotiation with TLS-EKM derived tls-c=
rypt key) */
 #define IV_PROTO_DYN_TLS_CRYPT   (1<<9)

+/** Suport for the AEAD tag at the end a larger peer id and IV */
+#define IV_PROTO_DATA_V3        (1<<10)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"

diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 8c1fb5b..0ded052 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -266,6 +266,19 @@
 }


+/* This adds a few more methods that strictly necessary but this allows
+ * us to see which exact test was run from the backtrace of the test
+ * when it fails */
+
+static void
+run_data_channel_with_cipher_end(const char *cipher)
+{
+    struct crypto_options co =3D init_crypto_options(cipher, "none");
+    co.flags |=3D CO_AEAD_TAG_AT_THE_END;
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
+
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
 {
@@ -274,21 +287,25 @@
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

@@ -318,6 +335,8 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--0tzd33YRv7o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement support for AEAD tag at the end<br><br>Change-Id: I=
00821d75342daf3f813b829812d648fe298bea81<br>---<br>M src/openvpn/crypto.c<b=
r>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/options.c=
<br>M src/openvpn/push.c<br>M src/openvpn/ssl.h<br>M tests/unit_tests/openv=
pn/test_ssl.c<br>7 files changed, 85 insertions(+), 26 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/506/1</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><s=
pan>index 2fca131..9988ebe 100644</span><br><span>--- a/src/openvpn/crypto.=
c</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -104,14 +10=
4,10 @@</span><br><span>         ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv=
));</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    /* Reserve space for authentication tag */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    mac_out =3D buf_write_a=
lloc(&amp;work, mac_len);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    ASSERT(mac_out);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot=
;, format_hex(BPTR(buf), BLEN(buf), 80, &amp;gc));</span><br><span> </span>=
<br><span>     /* Buffer overflow check */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_=
block_size(ctx-&gt;cipher)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!buf_safe(&amp;work, buf-&gt;len + mac_len + cipher_ctx_bl=
ock_size(ctx-&gt;cipher)))</span><br><span>     {</span><br><span>         =
msg(D_CRYPT_ERRORS,</span><br><span>             &quot;ENCRYPT: buffer size=
 error, bc=3D%d bo=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br><s=
pan>@@ -121,9 +117,16 @@</span><br><span>     }</span><br><span> </span><br=
><span>     /* For AEAD ciphers, authenticate Additional Data, including op=
code */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cip=
her_ctx_update_ad(ctx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work) - mac_le=
n));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(ciph=
er_ctx_update_ad(ctx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work)));</span>=
<br><span>     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-         format_hex(BPTR(&amp;w=
ork), BLEN(&amp;work) - mac_len, 0, &amp;gc));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+         format_hex(BPTR(&amp;work), BLEN(&amp;w=
ork), 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(opt-&gt;f=
lags &amp; CO_AEAD_TAG_AT_THE_END))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        /* Reserve space for authentication tag */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        mac_out =3D buf_write_alloc(&amp;=
work, mac_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    ASSERT(mac_out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span> </span><br><span>     /* Encrypt packet ID, payload=
 */</span><br><span>     ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&amp=
;work), &amp;outlen, BPTR(buf), BLEN(buf)));</span><br><span>@@ -133,6 +136=
,14 @@</span><br><span>     ASSERT(cipher_ctx_final(ctx-&gt;cipher, BEND(&a=
mp;work), &amp;outlen));</span><br><span>     ASSERT(buf_inc_len(&amp;work,=
 outlen));</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* if the tag is at end the end, allocate it now */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; CO=
_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* R=
eserve space for authentication tag */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        mac_out =3D buf_write_alloc(&amp;work, mac_len);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mac_=
out);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /* Wri=
te authentication tag */</span><br><span>     ASSERT(cipher_ctx_get_tag(ctx=
-&gt;cipher, mac_out, mac_len));</span><br><span> </span><br><span>@@ -353,=
7 +364,6 @@</span><br><span>     static const char error_prefix[] =3D &quot=
;AEAD Decrypt error&quot;;</span><br><span>     struct packet_id_net pin =
=3D { 0 };</span><br><span>     const struct key_ctx *ctx =3D &amp;opt-&gt;=
key_ctx_bi.decrypt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint8_t *tag_ptr =3D NULL;</span><br><span>     int outlen;</span><br><sp=
an>     struct gc_arena gc;</span><br><span> </span><br><span>@@ -406,19 +4=
16,29 @@</span><br><span> </span><br><span>     /* keep the tag value to fe=
ed in later */</span><br><span>     const int tag_size =3D OPENVPN_AEAD_TAG=
_LENGTH;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&=
gt;len &lt; tag_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (buf-&gt;len &lt; tag_size + 1)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing=
 tag&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 CRYPT_ERROR(&quot;missing tag or no payload&quot;);</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tag_ptr =3D BPTR(=
buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_a=
dvance(buf, tag_size));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int a=
d_size =3D BPTR(buf) - ad_start;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ui=
nt8_t *tag_ptr =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int data_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (op=
t-&gt;flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        data_len =3D BLEN(buf) - tag_size;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        tag_ptr =3D BPTR(buf) + data_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        tag_ptr =3D BPTR(buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ASSERT(buf_advance(buf, tag_size));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        data_len =3D BLEN(=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     dmsg(D=
_PACKET_CONTENT, &quot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, tag_size,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; 1)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing payl=
oad&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     dmsg=
(D_PACKET_CONTENT, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN=
(buf), 0, &amp;gc));</span><br><span> </span><br><span>     /* Buffer overf=
low check (should never fail) */</span><br><span>@@ -427,20 +447,19 @@</spa=
n><br><span>         CRYPT_ERROR(&quot;potential buffer overflow&quot;);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        /* feed in tag and the authenticated data */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const int ad_size =3D BPTR(buf) - a=
d_start - tag_size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      ASSERT(cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_CONT=
ENT, &quot;DECRYPT AD: %s&quot;,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-             format_hex(BPTR(buf) - ad_size - tag_size, ad_size,=
 0, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* feed in tag and the authenticated=
 data */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
cipher_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECR=
YPT AD: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
       format_hex(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span>=
<br><span>     /* Decrypt and authenticate packet */</span><br><span>     i=
f (!cipher_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(bu=
f),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
         BLEN(buf)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           data_len))</span><br><span>     {</span><br><sp=
an>         CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span>=
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan>     ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span>     if (!=
cipher_ctx_final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</span>=
<br><span>                                     &amp;outlen, tag_ptr, tag_si=
ze))</span><br><span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto=
.h</span><br><span>index 4201524..95a5b31 100644</span><br><span>--- a/src/=
openvpn/crypto.h</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span=
>@@ -279,6 +279,10 @@</span><br><span>     /**&lt; Bit-flag indicating that=
 renegotiations are using tls-crypt</span><br><span>      *   with a TLS-EK=
M derived key.</span><br><span>      */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define CO_AEAD_TAG_AT_THE_END  (1&lt;&lt;8)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag indicatin=
g that the AEAD tag is at the end of the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     *   packet.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     */</span><br><span> </span><br><span>     unsigned i=
nt flags;         /**&lt; Bit-flags determining behavior of</span><br><span=
>                                  *   security operation functions. */</sp=
an><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br=
><span>index c5cc154..cd37b36 100644</span><br><span>--- a/src/openvpn/init=
.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -2323,6 +232=
3,10 @@</span><br><span>         {</span><br><span>             buf_printf(=
&amp;out, &quot; dyn-tls-crypt&quot;);</span><br><span>         }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;imported_pr=
otocol_flags &amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            buf_printf(&amp;out, &quot; aead-tag-end&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span>     }</span><br><span> </span><br><span>     if (buf_len(&amp;out) &g=
t; strlen(header))</span><br><span>diff --git a/src/openvpn/options.c b/src=
/openvpn/options.c</span><br><span>index 2c79a1e..39f00c0 100644</span><br>=
<span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options=
.c</span><br><span>@@ -8686,6 +8686,10 @@</span><br><span>                 =
options-&gt;imported_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><b=
r><span>             }</span><br><span> #endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            else if (streq(p[j], &quot;aead-tag-=
end&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  options-&gt;imported_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n>             else</span><br><span>             {</span><br><span>        =
         msg(msglevel, &quot;Unknown protocol-flags flag: %s&quot;, p[j]);<=
/span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/push.c</span>=
<br><span>index 2249434..e4c122c 100644</span><br><span>--- a/src/openvpn/p=
ush.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@@ -29,6 +29=
,7 @@</span><br><span> </span><br><span> #include &quot;push.h&quot;</span>=
<br><span> #include &quot;options.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;crypto.h&quot;</span><br><span> #inclu=
de &quot;ssl.h&quot;</span><br><span> #include &quot;ssl_verify.h&quot;</sp=
an><br><span> #include &quot;ssl_ncp.h&quot;</span><br><span>@@ -686,6 +687=
,11 @@</span><br><span>         buf_printf(&amp;proto_flags, &quot; dyn-tls=
-crypt&quot;);</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;imported_protocol_flags &=
amp; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   buf_printf(&amp;proto_flags, &quot; aead-tag-end&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     if (buf_len(&amp;proto_flag=
s) &gt; 0)</span><br><span>     {</span><br><span>         push_option_fmt(=
gc, push_list, M_USAGE, &quot;protocol-flags%s&quot;, buf_str(&amp;proto_fl=
ags));</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</=
span><br><span>index 71b99db..a1c67a2 100644</span><br><span>--- a/src/open=
vpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -107,6=
 +107,9 @@</span><br><span> /** Support to dynamic tls-crypt (renegotiation=
 with TLS-EKM derived tls-crypt key) */</span><br><span> #define IV_PROTO_D=
YN_TLS_CRYPT   (1&lt;&lt;9)</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/** Suport for the AEAD tag at the end a larger p=
eer id and IV */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine IV_PROTO_DATA_V3        (1&lt;&lt;10)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /* Default field in X509 to be use=
rname */</span><br><span> #define X509_USERNAME_FIELD_DEFAULT &quot;CN&quot=
;</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/t=
est_ssl.c b/tests/unit_tests/openvpn/test_ssl.c</span><br><span>index 8c1fb=
5b..0ded052 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_ssl.=
c</span><br><span>+++ b/tests/unit_tests/openvpn/test_ssl.c</span><br><span=
>@@ -266,6 +266,19 @@</span><br><span> }</span><br><span> </span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* This adds a few=
 more methods that strictly necessary but this allows</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * us to see which exact test was run fro=
m the backtrace of the test</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * when it fails */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+run_data_channel_wi=
th_cipher_end(const char *cipher)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct crypto_options co =3D init_crypto_options(cipher, &quot;none&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    co.flags |=3D C=
O_AEAD_TAG_AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    do_data_channel_round_trip(&amp;co);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    uninit_crypto_options(&amp;co);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> run_da=
ta_channel_with_cipher(const char *cipher, const char *auth)</span><br><spa=
n> {</span><br><span>@@ -274,21 +287,25 @@</span><br><span>     uninit_cryp=
to_options(&amp;co);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> test_data_channel_roundtrip_aes_128_gcm(void **state)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data=
_channel_with_cipher_end(&quot;AES-128-GCM&quot;);</span><br><span>     run=
_data_channel_with_cipher(&quot;AES-128-GCM&quot;, &quot;none&quot;);</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n> test_data_channel_roundtrip_aes_192_gcm(void **state)</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channe=
l_with_cipher_end(&quot;AES-192-GCM&quot;);</span><br><span>     run_data_c=
hannel_with_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;);</span><br><s=
pan> }</span><br><span> </span><br><span> static void</span><br><span> test=
_data_channel_roundtrip_aes_256_gcm(void **state)</span><br><span> {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_=
cipher_end(&quot;AES-256-GCM&quot;);</span><br><span>     run_data_channel_=
with_cipher(&quot;AES-256-GCM&quot;, &quot;none&quot;);</span><br><span> }<=
/span><br><span> </span><br><span>@@ -318,6 +335,8 @@</span><br><span>     =
    skip();</span><br><span>         return;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher_end(&quot;Cha=
Cha20-Poly1305&quot;);</span><br><span>     run_data_channel_with_cipher(&q=
uot;ChaCha20-Poly1305&quot;, &quot;none&quot;);</span><br><span> }</span><b=
r><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">change 506</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/506?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--0tzd33YRv7o=--

