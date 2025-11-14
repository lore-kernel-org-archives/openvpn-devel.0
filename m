From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 17:33:51 +0000
References: <gerrit.1763141628000.I3f11423834814bab5d653f160fc2326dae4c0e8e@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <222f5b7e99f83a1203f6ff862f5ecb7c67604941-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xLvBU1GLiP4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xLvBU1GLiP4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demail

to review the following change.


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
---
M src/openvpn/tls_crypt.c
1 file changed, 6 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/1379/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3f11423834814bab5d653f160fc2326dae4c0e8e
Gerrit-Change-Number: 1379
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--xLvBU1GLiP4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">tls_crypt: Avoid some conversion warnings<b=
r><br>The casts should be safe, since one is a constant<br>(but got type fr=
om sizeof()) and the other is<br>limited by the buffer length.<br><br>While=
 here make the code in tls_crypt_v2_wrap_client_key<br>as little easier to =
follow.<br><br>Change-Id: I3f11423834814bab5d653f160fc2326dae4c0e8e<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openv=
pn/tls_crypt.c<br>1 file changed, 6 insertions(+), 14 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/79/1379/1</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/t=
ls_crypt.c</span><br><span>index a808de3..ab719b3 100644</span><br><span>--=
- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt.c</=
span><br><span>@@ -205,11 +205,6 @@</span><br><span>     return false;</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot=
;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>=
 bool</span><br><span> tls_crypt_unwrap(const struct buffer *src, struct bu=
ffer *dst, struct crypto_options *opt)</span><br><span> {</span><br><span>@=
@ -246,7 +241,7 @@</span><br><span>             CRYPT_ERROR(&quot;cipher re=
set failed&quot;);</span><br><span>         }</span><br><span>         if (=
!cipher_ctx_update(ctx-&gt;cipher, BPTR(dst), &amp;outlen, BPTR(src) + TLS_=
CRYPT_OFF_CT,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                       BLEN(src) - TLS_CRYPT_OFF_CT))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                               BLEN(src) =
- (int)TLS_CRYPT_OFF_CT))</span><br><span>         {</span><br><span>      =
       CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span>     =
    }</span><br><span>@@ -381,8 +376,9 @@</span><br><span>         msg(M_WA=
RN, &quot;ERROR: could not write tag&quot;);</span><br><span>         retur=
n false;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    uint16_t net_len =3D htons(sizeof(src_key-&gt;keys) + BLEN(sr=
c_metadata) + TLS_CRYPT_V2_TAG_SIZE</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                             + sizeof(uint16_t));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const int data_len =3D BLEN=
(src_metadata) + sizeof(src_key-&gt;keys) + sizeof(uint16_t);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    const int tagged_len =3D data=
_len + TLS_CRYPT_TAG_SIZE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    const uint16_t net_len =3D htons((uint16_t)tagged_len);</span><b=
r><span>     hmac_ctx_t *hmac_ctx =3D server_key-&gt;hmac;</span><br><span>=
     hmac_ctx_reset(hmac_ctx);</span><br><span>     hmac_ctx_update(hmac_ct=
x, (void *)&amp;net_len, sizeof(net_len));</span><br><span>@@ -396,8 +392,8=
 @@</span><br><span>     ASSERT(cipher_ctx_reset(cipher_ctx, tag));</span><=
br><span> </span><br><span>     /* Overflow check (OpenSSL requires an extr=
a block in the dst buffer) */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (buf_forward_capacity(&amp;work) &lt; (sizeof(src_key-&gt;ke=
ys) + BLEN(src_metadata) + sizeof(net_len)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                       + cipher_ctx_bl=
ock_size(cipher_ctx)))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int padded_len =3D data_len + cipher_ctx_block_size(cipher_ctx=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_forwa=
rd_capacity(&amp;work) &lt; padded_len)</span><br><span>     {</span><br><s=
pan>         msg(M_WARN, &quot;ERROR: could not crypt: insufficient space i=
n dst&quot;);</span><br><span>         return false;</span><br><span>@@ -41=
8,10 +414,6 @@</span><br><span>     return buf_copy(wkc, &amp;work);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><span> tls_cr=
ypt_v2_unwrap_client_key(struct key2 *client_key, struct buffer *metadata,<=
/span><br><span>                                struct buffer wrapped_clien=
t_key, struct key_ctx *server_key)</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demai=
l">change 1379</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1379?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3f11423834814bab5d653f160fc=
2326dae4c0e8e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1379 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--xLvBU1GLiP4=--

