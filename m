From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 18:32:49 +0000
In-Reply-To: <gerrit.1763141628000.I3f11423834814bab5d653f160fc2326dae4c0e8e@...2715...>
References: <gerrit.1763141628000.I3f11423834814bab5d653f160fc2326dae4c0e8e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <befeaf5cd25e5f736b53f31750bd52566e1d3708-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ddIXdPJVX4A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tls_crypt: Avoid
 some conversion warnings
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

--ddIXdPJVX4A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
79?usp=3Demail )

Change subject: tls_crypt: Avoid some conversion warnings
......................................................................

tls_crypt: Avoid some conversion warnings

The casts should be safe, since one is a constant
(but got type from sizeof()) and the other is
limited by the buffer length.

While here make the code in tls_crypt_v2_wrap_client_key
as little easier to follow.

Change-Id: I3f11423834814bab5d653f160fc2326dae4c0e8e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1379
Message-Id: <20251116140754.17177-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
466.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tls_crypt.c
1 file changed, 6 insertions(+), 14 deletions(-)




diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index a808de3..ab719b3 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -205,11 +205,6 @@
     return false;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct cryp=
to_options *opt)
 {
@@ -246,7 +241,7 @@
             CRYPT_ERROR("cipher reset failed");
         }
         if (!cipher_ctx_update(ctx->cipher, BPTR(dst), &outlen, BPTR(src) =
+ TLS_CRYPT_OFF_CT,
-                               BLEN(src) - TLS_CRYPT_OFF_CT))
+                               BLEN(src) - (int)TLS_CRYPT_OFF_CT))
         {
             CRYPT_ERROR("cipher update failed");
         }
@@ -381,8 +376,9 @@
         msg(M_WARN, "ERROR: could not write tag");
         return false;
     }
-    uint16_t net_len =3D htons(sizeof(src_key->keys) + BLEN(src_metadata) =
+ TLS_CRYPT_V2_TAG_SIZE
-                             + sizeof(uint16_t));
+    const int data_len =3D BLEN(src_metadata) + sizeof(src_key->keys) + si=
zeof(uint16_t);
+    const int tagged_len =3D data_len + TLS_CRYPT_TAG_SIZE;
+    const uint16_t net_len =3D htons((uint16_t)tagged_len);
     hmac_ctx_t *hmac_ctx =3D server_key->hmac;
     hmac_ctx_reset(hmac_ctx);
     hmac_ctx_update(hmac_ctx, (void *)&net_len, sizeof(net_len));
@@ -396,8 +392,8 @@
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));

     /* Overflow check (OpenSSL requires an extra block in the dst buffer) =
*/
-    if (buf_forward_capacity(&work) < (sizeof(src_key->keys) + BLEN(src_me=
tadata) + sizeof(net_len)
-                                       + cipher_ctx_block_size(cipher_ctx)=
))
+    const int padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);
+    if (buf_forward_capacity(&work) < padded_len)
     {
         msg(M_WARN, "ERROR: could not crypt: insufficient space in dst");
         return false;
@@ -418,10 +414,6 @@
     return buf_copy(wkc, &work);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static bool
 tls_crypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *met=
adata,
                                struct buffer wrapped_client_key, struct ke=
y_ctx *server_key)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f11423834814bab5d653f160fc2326dae4c0e8e
Gerrit-Change-Number: 1379
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ddIXdPJVX4A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1379?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tls_crypt: Avoid some conversion warnings<br><br=
>The casts should be safe, since one is a constant<br>(but got type from si=
zeof()) and the other is<br>limited by the buffer length.<br><br>While here=
 make the code in tls_crypt_v2_wrap_client_key<br>as little easier to follo=
w.<br><br>Change-Id: I3f11423834814bab5d653f160fc2326dae4c0e8e<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering =
&lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn=
/+/1379<br>Message-Id: &lt;20251116140754.17177-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3446=
6.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M s=
rc/openvpn/tls_crypt.c<br>1 file changed, 6 insertions(+), 14 deletions(-)<=
br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br=
><span>index a808de3..ab719b3 100644</span><br><span>--- a/src/openvpn/tls_=
crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -2=
05,11 +205,6 @@</span><br><span>     return false;</span><br><span> }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defin=
ed(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><spa=
n> tls_crypt_unwrap(const struct buffer *src, struct buffer *dst, struct cr=
ypto_options *opt)</span><br><span> {</span><br><span>@@ -246,7 +241,7 @@</=
span><br><span>             CRYPT_ERROR(&quot;cipher reset failed&quot;);</=
span><br><span>         }</span><br><span>         if (!cipher_ctx_update(c=
tx-&gt;cipher, BPTR(dst), &amp;outlen, BPTR(src) + TLS_CRYPT_OFF_CT,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
   BLEN(src) - TLS_CRYPT_OFF_CT))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                               BLEN(src) - (int)TLS_CRYPT_OFF=
_CT))</span><br><span>         {</span><br><span>             CRYPT_ERROR(&=
quot;cipher update failed&quot;);</span><br><span>         }</span><br><spa=
n>@@ -381,8 +376,9 @@</span><br><span>         msg(M_WARN, &quot;ERROR: cou=
ld not write tag&quot;);</span><br><span>         return false;</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint16=
_t net_len =3D htons(sizeof(src_key-&gt;keys) + BLEN(src_metadata) + TLS_CR=
YPT_V2_TAG_SIZE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                       + sizeof(uint16_t));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    const int data_len =3D BLEN(src_metadata) + siz=
eof(src_key-&gt;keys) + sizeof(uint16_t);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    const int tagged_len =3D data_len + TLS_CRYPT_TAG=
_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uin=
t16_t net_len =3D htons((uint16_t)tagged_len);</span><br><span>     hmac_ct=
x_t *hmac_ctx =3D server_key-&gt;hmac;</span><br><span>     hmac_ctx_reset(=
hmac_ctx);</span><br><span>     hmac_ctx_update(hmac_ctx, (void *)&amp;net_=
len, sizeof(net_len));</span><br><span>@@ -396,8 +392,8 @@</span><br><span>=
     ASSERT(cipher_ctx_reset(cipher_ctx, tag));</span><br><span> </span><br=
><span>     /* Overflow check (OpenSSL requires an extra block in the dst b=
uffer) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (buf_=
forward_capacity(&amp;work) &lt; (sizeof(src_key-&gt;keys) + BLEN(src_metad=
ata) + sizeof(net_len)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                                       + cipher_ctx_block_size(cipher_ctx)=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int pad=
ded_len =3D data_len + cipher_ctx_block_size(cipher_ctx);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (buf_forward_capacity(&amp;wor=
k) &lt; padded_len)</span><br><span>     {</span><br><span>         msg(M_W=
ARN, &quot;ERROR: could not crypt: insufficient space in dst&quot;);</span>=
<br><span>         return false;</span><br><span>@@ -418,10 +414,6 @@</span=
><br><span>     return buf_copy(wkc, &amp;work);</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> static bool</span><br><span> tls_crypt_v2_unwrap_client_=
key(struct key2 *client_key, struct buffer *metadata,</span><br><span>     =
                           struct buffer wrapped_client_key, struct key_ctx=
 *server_key)</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demail">change 1379</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f11423834814bab5d653f160fc=
2326dae4c0e8e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1379 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ddIXdPJVX4A=--

