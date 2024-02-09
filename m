From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 9 Feb 2024 14:59:26 +0000
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2659e8205b31b1f158a1761215f4db065ae019a8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qzkS8xEXWcg="; charset=UTF-8
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

--qzkS8xEXWcg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+1 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/06/506/3

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
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn=
/test_ssl.c
index 8c1fb5b..2ccfa45 100644
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--qzkS8xEXWcg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement support for AEAD tag at the end<br>=
<br>Using the AEAD tag at the end is the standard way of doing AEAD. Severa=
l<br>APIs even only support the tag at the end (e.g. mbed TLS). Having the =
tag at<br>the front or end makes no difference for security but allows stre=
aming HW<br>implementations like NICs to be much more efficient as they do =
not need to<br>buffer a whole packet content and encrypt it to finally writ=
e the tag but<br>instead just add the calculated tag at the end of processi=
ng.<br><br>Change-Id: I00821d75342daf3f813b829812d648fe298bea81<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/crypto.=
c<br>M src/openvpn/crypto.h<br>M src/openvpn/init.c<br>M src/openvpn/option=
s.c<br>M src/openvpn/push.c<br>M tests/unit_tests/openvpn/test_ssl.c<br>6 f=
iles changed, 80 insertions(+), 26 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/06/506/3</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index 2fca131..9=
988ebe 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>++=
+ b/src/openvpn/crypto.c</span><br><span>@@ -104,14 +104,10 @@</span><br><s=
pan>         ASSERT(cipher_ctx_reset(ctx-&gt;cipher, iv));</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* Reserve space for authentication tag */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    mac_out =3D buf_write_alloc(&amp;work, mac_=
len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(mac_o=
ut);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
     dmsg(D_PACKET_CONTENT, &quot;ENCRYPT FROM: %s&quot;, format_hex(BPTR(b=
uf), BLEN(buf), 80, &amp;gc));</span><br><span> </span><br><span>     /* Bu=
ffer overflow check */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;c=
ipher)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!bu=
f_safe(&amp;work, buf-&gt;len + mac_len + cipher_ctx_block_size(ctx-&gt;cip=
her)))</span><br><span>     {</span><br><span>         msg(D_CRYPT_ERRORS,<=
/span><br><span>             &quot;ENCRYPT: buffer size error, bc=3D%d bo=
=3D%d bl=3D%d wc=3D%d wo=3D%d wl=3D%d&quot;,</span><br><span>@@ -121,9 +117=
,16 @@</span><br><span>     }</span><br><span> </span><br><span>     /* For=
 AEAD ciphers, authenticate Additional Data, including opcode */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(cipher_ctx_update_ad(=
ctx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work) - mac_len));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update_ad(c=
tx-&gt;cipher, BPTR(&amp;work), BLEN(&amp;work)));</span><br><span>     dms=
g(D_PACKET_CONTENT, &quot;ENCRYPT AD: %s&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-         format_hex(BPTR(&amp;work), BLEN(&amp;wo=
rk) - mac_len, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+         format_hex(BPTR(&amp;work), BLEN(&amp;work), 0, &amp;gc))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!(opt-&gt;flags &amp; CO_AEAD=
_TAG_AT_THE_END))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Reser=
ve space for authentication tag */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        mac_out =3D buf_write_alloc(&amp;work, mac_len);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mac_out)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan> </span><br><span>     /* Encrypt packet ID, payload */</span><br><span=
>     ASSERT(cipher_ctx_update(ctx-&gt;cipher, BEND(&amp;work), &amp;outlen=
, BPTR(buf), BLEN(buf)));</span><br><span>@@ -133,6 +136,14 @@</span><br><s=
pan>     ASSERT(cipher_ctx_final(ctx-&gt;cipher, BEND(&amp;work), &amp;outl=
en));</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if =
the tag is at end the end, allocate it now */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; CO_AEAD_TAG_AT_THE_EN=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Reserve space for au=
thentication tag */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        mac_out =3D buf_write_alloc(&amp;work, mac_len);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        ASSERT(mac_out);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     /* Write authentication t=
ag */</span><br><span>     ASSERT(cipher_ctx_get_tag(ctx-&gt;cipher, mac_ou=
t, mac_len));</span><br><span> </span><br><span>@@ -353,7 +364,6 @@</span><=
br><span>     static const char error_prefix[] =3D &quot;AEAD Decrypt error=
&quot;;</span><br><span>     struct packet_id_net pin =3D { 0 };</span><br>=
<span>     const struct key_ctx *ctx =3D &amp;opt-&gt;key_ctx_bi.decrypt;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t *tag_ptr =
=3D NULL;</span><br><span>     int outlen;</span><br><span>     struct gc_a=
rena gc;</span><br><span> </span><br><span>@@ -406,19 +416,29 @@</span><br>=
<span> </span><br><span>     /* keep the tag value to feed in later */</spa=
n><br><span>     const int tag_size =3D OPENVPN_AEAD_TAG_LENGTH;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; tag_siz=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf-&gt;l=
en &lt; tag_size + 1)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing tag&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        CRYPT_ERROR(&quot;=
missing tag or no payload&quot;);</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    tag_ptr =3D BPTR(buf);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_advance(buf, tag_siz=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    const int ad_size =3D BPTR(buf=
) - ad_start;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t *tag_ptr =3D =
NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int data_l=
en =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (opt-&gt;flags &amp; C=
O_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dat=
a_len =3D BLEN(buf) - tag_size;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        tag_ptr =3D BPTR(buf) + data_len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   tag_ptr =3D BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        ASSERT(buf_advance(buf, tag_size));</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        data_len =3D BLEN(buf);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span>     dmsg(D_PACKET_CONTENT, &q=
uot;DECRYPT MAC: %s&quot;, format_hex(tag_ptr, tag_size, 0, &amp;gc));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if (buf-&gt;len &lt; 1)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        CRYPT_ERROR(&quot;missing payload&quot;);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     dmsg(D_PACKET_CONTENT=
, &quot;DECRYPT FROM: %s&quot;, format_hex(BPTR(buf), BLEN(buf), 0, &amp;gc=
));</span><br><span> </span><br><span>     /* Buffer overflow check (should=
 never fail) */</span><br><span>@@ -427,20 +447,19 @@</span><br><span>     =
    CRYPT_ERROR(&quot;potential buffer overflow&quot;);</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* feed =
in tag and the authenticated data */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        const int ad_size =3D BPTR(buf) - ad_start - tag_siz=
e;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(ciph=
er_ctx_update_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        dmsg(D_PACKET_CONTENT, &quot;DECRYP=
T AD: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
       format_hex(BPTR(buf) - ad_size - tag_size, ad_size, 0, &amp;gc));</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* feed in tag and the authenticated data */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(cipher_ctx_update=
_ad(ctx-&gt;cipher, ad_start, ad_size));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    dmsg(D_PACKET_CONTENT, &quot;DECRYPT AD: %s&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         format_hex=
(ad_start, ad_size, 0, &amp;gc));</span><br><span> </span><br><span>     /*=
 Decrypt and authenticate packet */</span><br><span>     if (!cipher_ctx_up=
date(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                           BLEN(buf=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
           data_len))</span><br><span>     {</span><br><span>         CRYPT=
_ERROR(&quot;cipher update failed&quot;);</span><br><span>     }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ASSERT(b=
uf_inc_len(&amp;work, outlen));</span><br><span>     if (!cipher_ctx_final_=
check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</span><br><span>       =
                              &amp;outlen, tag_ptr, tag_size))</span><br><s=
pan>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><spa=
n>index 4201524..95a5b31 100644</span><br><span>--- a/src/openvpn/crypto.h<=
/span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -279,6 +279,1=
0 @@</span><br><span>     /**&lt; Bit-flag indicating that renegotiations a=
re using tls-crypt</span><br><span>      *   with a TLS-EKM derived key.</s=
pan><br><span>      */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define CO_AEAD_TAG_AT_THE_END  (1&lt;&lt;8)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /**&lt; Bit-flag indicating that the AEAD t=
ag is at the end of the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     *   packet.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     */</span><br><span> </span><br><span>     unsigned int flags;        =
 /**&lt; Bit-flags determining behavior of</span><br><span>                =
                  *   security operation functions. */</span><br><span>diff=
 --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index c5cc=
154..cd37b36 100644</span><br><span>--- a/src/openvpn/init.c</span><br><spa=
n>+++ b/src/openvpn/init.c</span><br><span>@@ -2323,6 +2323,10 @@</span><br=
><span>         {</span><br><span>             buf_printf(&amp;out, &quot; =
dyn-tls-crypt&quot;);</span><br><span>         }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (o-&gt;imported_protocol_flags &amp=
; CO_AEAD_TAG_AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        buf_printf(&amp;out, &quot; aead-tag-end&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span=
><br><span> </span><br><span>     if (buf_len(&amp;out) &gt; strlen(header)=
)</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.=
c</span><br><span>index 2c79a1e..39f00c0 100644</span><br><span>--- a/src/o=
penvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><spa=
n>@@ -8686,6 +8686,10 @@</span><br><span>                 options-&gt;impor=
ted_protocol_flags |=3D CO_USE_DYNAMIC_TLS_CRYPT;</span><br><span>         =
    }</span><br><span> #endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            else if (streq(p[j], &quot;aead-tag-end&quot;))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                options-&gt;imp=
orted_protocol_flags |=3D CO_AEAD_TAG_AT_THE_END;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span>             el=
se</span><br><span>             {</span><br><span>                 msg(msgl=
evel, &quot;Unknown protocol-flags flag: %s&quot;, p[j]);</span><br><span>d=
iff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 2=
249434..e4c122c 100644</span><br><span>--- a/src/openvpn/push.c</span><br><=
span>+++ b/src/openvpn/push.c</span><br><span>@@ -29,6 +29,7 @@</span><br><=
span> </span><br><span> #include &quot;push.h&quot;</span><br><span> #inclu=
de &quot;options.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;crypto.h&quot;</span><br><span> #include &quot;ssl.h&qu=
ot;</span><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #in=
clude &quot;ssl_ncp.h&quot;</span><br><span>@@ -686,6 +687,11 @@</span><br>=
<span>         buf_printf(&amp;proto_flags, &quot; dyn-tls-crypt&quot;);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (o-&gt;imported_protocol_flags &amp; CO_AEAD_TAG_=
AT_THE_END)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&am=
p;proto_flags, &quot; aead-tag-end&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span>     if (buf_len(&amp;proto_flags) &gt; 0)</span>=
<br><span>     {</span><br><span>         push_option_fmt(gc, push_list, M_=
USAGE, &quot;protocol-flags%s&quot;, buf_str(&amp;proto_flags));</span><br>=
<span>diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/o=
penvpn/test_ssl.c</span><br><span>index 8c1fb5b..2ccfa45 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/test_ssl.c</span><br><span>+++ b/tests/=
unit_tests/openvpn/test_ssl.c</span><br><span>@@ -265,6 +265,17 @@</span><b=
r><span> </span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* This adds a few more methods than strictly ne=
cessary but this allows</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * us to see which exact test was run from the backtrace of the test</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * when it fails */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+run_data_channel_with_cipher_e=
nd(const char *cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct cryp=
to_options co =3D init_crypto_options(cipher, &quot;none&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    co.flags |=3D CO_AEAD_TAG_=
AT_THE_END;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    do_d=
ata_channel_round_trip(&amp;co);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    uninit_crypto_options(&amp;co);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span> </span><br><span> static vo=
id</span><br><span> run_data_channel_with_cipher(const char *cipher, const =
char *auth)</span><br><span>@@ -274,21 +285,25 @@</span><br><span>     unin=
it_crypto_options(&amp;co);</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void<=
/span><br><span> test_data_channel_roundtrip_aes_128_gcm(void **state)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
un_data_channel_with_cipher_end(&quot;AES-128-GCM&quot;);</span><br><span> =
    run_data_channel_with_cipher(&quot;AES-128-GCM&quot;, &quot;none&quot;)=
;</span><br><span> }</span><br><span> </span><br><span> static void</span><=
br><span> test_data_channel_roundtrip_aes_192_gcm(void **state)</span><br><=
span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data=
_channel_with_cipher_end(&quot;AES-192-GCM&quot;);</span><br><span>     run=
_data_channel_with_cipher(&quot;AES-192-GCM&quot;, &quot;none&quot;);</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n> test_data_channel_roundtrip_aes_256_gcm(void **state)</span><br><span> {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    run_data_channe=
l_with_cipher_end(&quot;AES-256-GCM&quot;);</span><br><span>     run_data_c=
hannel_with_cipher(&quot;AES-256-GCM&quot;, &quot;none&quot;);</span><br><s=
pan> }</span><br><span> </span><br><span>@@ -318,6 +333,8 @@</span><br><spa=
n>         skip();</span><br><span>         return;</span><br><span>     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    run_data_channel_with_cipher_end(&q=
uot;ChaCha20-Poly1305&quot;);</span><br><span>     run_data_channel_with_ci=
pher(&quot;ChaCha20-Poly1305&quot;, &quot;none&quot;);</span><br><span> }</=
span><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/506?usp=3Demail">change 506</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/506?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I00821d75342daf3f813b829812d=
648fe298bea81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qzkS8xEXWcg=--

