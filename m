From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 16:36:34 +0000
References: <gerrit.1758731785000.Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b9fcb733620d69dd275e4b9b4665d9cb523aa2d2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fEOZYRJMuSk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_epoch: Clean
 up type handling in ovpn_expand_label()
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

--fEOZYRJMuSk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1218?usp=3Demail

to review the following change.


Change subject: crypto_epoch: Clean up type handling in ovpn_expand_label()
......................................................................

crypto_epoch: Clean up type handling in ovpn_expand_label()

- Add explicit casts where we have checked the value and
  need to put it into a smaller type.
- Adapt some types to actual usage.

Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_epoch.h
2 files changed, 8 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1218/1

diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 7026ff8..4149b6a 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -72,14 +72,9 @@
     hmac_ctx_free(hmac_ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t =
*label, size_t label_len,
-                  const uint8_t *context, size_t context_len, uint8_t *out=
, uint16_t out_len)
+                  const uint8_t *context, size_t context_len, uint8_t *out=
, int out_len)
 {
     if (secret_len !=3D 32 || label_len > 250 || context_len > 255 || labe=
l_len < 1)
     {
@@ -89,22 +84,23 @@
          * need need to be in range */
         return false;
     }
+    ASSERT(out_len <=3D UINT16_MAX);

     struct gc_arena gc =3D gc_new();
     /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn ",
      * 1 byte for context len byte and 1 byte for label len byte */
     const uint8_t *label_prefix =3D (const uint8_t *)("ovpn ");
-    int prefix_len =3D 5;
+    uint8_t prefix_len =3D 5;

-    int hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + context_le=
n;
+    size_t hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + context=
_len;
     struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, &gc);

-    buf_write_u16(&hkdf_label, out_len);
-    buf_write_u8(&hkdf_label, prefix_len + label_len);
+    buf_write_u16(&hkdf_label, (uint16_t)out_len);
+    buf_write_u8(&hkdf_label, prefix_len + (uint8_t)label_len);
     buf_write(&hkdf_label, label_prefix, prefix_len);
     buf_write(&hkdf_label, label, label_len);

-    buf_write_u8(&hkdf_label, context_len);
+    buf_write_u8(&hkdf_label, (uint8_t)context_len);
     if (context_len > 0)
     {
         buf_write(&hkdf_label, context, context_len);
@@ -168,10 +164,6 @@
     key->epoch =3D epoch_key->epoch;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 epoch_init_send_key_ctx(struct crypto_options *co)
 {
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index 33ca741..a6fa116 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -60,7 +60,7 @@
  */
 bool ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uin=
t8_t *label,
                        size_t label_len, const uint8_t *context, size_t co=
ntext_len, uint8_t *out,
-                       uint16_t out_len);
+                       int out_len);

 /**
  * Generate a data channel key pair from the epoch key

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1218?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3
Gerrit-Change-Number: 1218
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--fEOZYRJMuSk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1218?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">crypto_epoch: Clean up type handling in ovpn_expand_label()<=
br><br>- Add explicit casts where we have checked the value and<br>  need t=
o put it into a smaller type.<br>- Adapt some types to actual usage.<br><br=
>Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3<br>Signed-off-by: Fra=
nk Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/crypto_epoc=
h.c<br>M src/openvpn/crypto_epoch.h<br>2 files changed, 8 insertions(+), 16=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/18/1218/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto_epoch.c b/src/o=
penvpn/crypto_epoch.c</span><br><span>index 7026ff8..4149b6a 100644</span><=
br><span>--- a/src/openvpn/crypto_epoch.c</span><br><span>+++ b/src/openvpn=
/crypto_epoch.c</span><br><span>@@ -72,14 +72,9 @@</span><br><span>     hma=
c_ctx_free(hmac_ctx);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> bool</span><br><span> ovpn_expand_label(const ui=
nt8_t *secret, size_t secret_len, const uint8_t *label, size_t label_len,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  const=
 uint8_t *context, size_t context_len, uint8_t *out, uint16_t out_len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                  const =
uint8_t *context, size_t context_len, uint8_t *out, int out_len)</span><br>=
<span> {</span><br><span>     if (secret_len !=3D 32 || label_len &gt; 250 =
|| context_len &gt; 255 || label_len &lt; 1)</span><br><span>     {</span><=
br><span>@@ -89,22 +84,23 @@</span><br><span>          * need need to be in=
 range */</span><br><span>         return false;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(out_len &lt;=
=3D UINT16_MAX);</span><br><span> </span><br><span>     struct gc_arena gc =
=3D gc_new();</span><br><span>     /* 2 byte for the outlen encoded as uint=
16, 5 bytes for &quot;ovpn &quot;,</span><br><span>      * 1 byte for conte=
xt len byte and 1 byte for label len byte */</span><br><span>     const uin=
t8_t *label_prefix =3D (const uint8_t *)(&quot;ovpn &quot;);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    int prefix_len =3D 5;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t prefix_len =3D 5;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
int hkdf_label_len =3D 2 + prefix_len + 1 + label_len + 1 + context_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t hkdf_label_=
len =3D 2 + prefix_len + 1 + label_len + 1 + context_len;</span><br><span> =
    struct buffer hkdf_label =3D alloc_buf_gc(hkdf_label_len, &amp;gc);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf=
_write_u16(&amp;hkdf_label, out_len);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    buf_write_u8(&amp;hkdf_label, prefix_len + label_len);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write_u16(&a=
mp;hkdf_label, (uint16_t)out_len);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_write_u8(&amp;hkdf_label, prefix_len + (uint8_t)labe=
l_len);</span><br><span>     buf_write(&amp;hkdf_label, label_prefix, prefi=
x_len);</span><br><span>     buf_write(&amp;hkdf_label, label, label_len);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
buf_write_u8(&amp;hkdf_label, context_len);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    buf_write_u8(&amp;hkdf_label, (uint8_t)context_=
len);</span><br><span>     if (context_len &gt; 0)</span><br><span>     {</=
span><br><span>         buf_write(&amp;hkdf_label, context, context_len);</=
span><br><span>@@ -168,10 +164,6 @@</span><br><span>     key-&gt;epoch =3D =
epoch_key-&gt;epoch;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagn=
ostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static vo=
id</span><br><span> epoch_init_send_key_ctx(struct crypto_options *co)</spa=
n><br><span> {</span><br><span>diff --git a/src/openvpn/crypto_epoch.h b/sr=
c/openvpn/crypto_epoch.h</span><br><span>index 33ca741..a6fa116 100644</spa=
n><br><span>--- a/src/openvpn/crypto_epoch.h</span><br><span>+++ b/src/open=
vpn/crypto_epoch.h</span><br><span>@@ -60,7 +60,7 @@</span><br><span>  */</=
span><br><span> bool ovpn_expand_label(const uint8_t *secret, size_t secret=
_len, const uint8_t *label,</span><br><span>                        size_t =
label_len, const uint8_t *context, size_t context_len, uint8_t *out,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                       uint1=
6_t out_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                 int out_len);</span><br><span> </span><br><span> /**</span=
><br><span>  * Generate a data channel key pair from the epoch key</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1218?usp=3Demail">change 1218</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1218?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad717f0ff3c79ae199c8be5f93b=
c51bf258c68c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1218 </div>
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


--fEOZYRJMuSk=--

