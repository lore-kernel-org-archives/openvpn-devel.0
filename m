From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 4 Oct 2025 15:36:42 +0000
In-Reply-To: <gerrit.1758731785000.Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3@...2715...>
References: <gerrit.1758731785000.Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <f8982b21a375881d64578a7a006ffcac1751fdcd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dLBwe8gaUC8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dLBwe8gaUC8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1218?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: crypto_epoch: Clean up type handling in ovpn_expand_label()
......................................................................

crypto_epoch: Clean up type handling in ovpn_expand_label()

- Add explicit casts where we have checked the value and
  need to put it into a smaller type.
- Adapt some types to actual usage.

Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1218
Message-Id: <20251004061545.7277-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59242119/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_epoch.c
M src/openvpn/crypto_epoch.h
2 files changed, 8 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/18/1218/4

diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 7026ff8..f34dc8c 100644
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
+    ASSERT(out_len >=3D 0 && out_len <=3D UINT16_MAX);

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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3
Gerrit-Change-Number: 1218
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dLBwe8gaUC8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1218?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by MaxF</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">crypto_epoch: Clean up type handling=
 in ovpn_expand_label()<br><br>- Add explicit casts where we have checked t=
he value and<br>  need to put it into a smaller type.<br>- Adapt some types=
 to actual usage.<br><br>Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68=
c3<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by=
: MaxF &lt;max@...2606...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/o=
penvpn/+/1218<br>Message-Id: &lt;20251004061545.7277-1-gert@...1296...&gt;<=
br>URL: https://sourceforge.net/p/openvpn/mailman/message/59242119/<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/cry=
pto_epoch.c<br>M src/openvpn/crypto_epoch.h<br>2 files changed, 8 insertion=
s(+), 16 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/18/1218/4</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openv=
pn/crypto_epoch.c b/src/openvpn/crypto_epoch.c</span><br><span>index 7026ff=
8..f34dc8c 100644</span><br><span>--- a/src/openvpn/crypto_epoch.c</span><b=
r><span>+++ b/src/openvpn/crypto_epoch.c</span><br><span>@@ -72,14 +72,9 @@=
</span><br><span>     hmac_ctx_free(hmac_ctx);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_=
_GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> o=
vpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *l=
abel, size_t label_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                  const uint8_t *context, size_t context_len, uint8_t *ou=
t, uint16_t out_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                  const uint8_t *context, size_t context_len, uint8_t *out=
, int out_len)</span><br><span> {</span><br><span>     if (secret_len !=3D =
32 || label_len &gt; 250 || context_len &gt; 255 || label_len &lt; 1)</span=
><br><span>     {</span><br><span>@@ -89,22 +84,23 @@</span><br><span>     =
     * need need to be in range */</span><br><span>         return false;</=
span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    ASSERT(out_len &gt;=3D 0 &amp;&amp; out_len &lt;=3D UINT16_MAX);</spa=
n><br><span> </span><br><span>     struct gc_arena gc =3D gc_new();</span><=
br><span>     /* 2 byte for the outlen encoded as uint16, 5 bytes for &quot=
;ovpn &quot;,</span><br><span>      * 1 byte for context len byte and 1 byt=
e for label len byte */</span><br><span>     const uint8_t *label_prefix =
=3D (const uint8_t *)(&quot;ovpn &quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    int prefix_len =3D 5;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    uint8_t prefix_len =3D 5;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int hkdf_label_len =
=3D 2 + prefix_len + 1 + label_len + 1 + context_len;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t hkdf_label_len =3D 2 + prefix_=
len + 1 + label_len + 1 + context_len;</span><br><span>     struct buffer h=
kdf_label =3D alloc_buf_gc(hkdf_label_len, &amp;gc);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write_u16(&amp;hkd=
f_label, out_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 buf_write_u8(&amp;hkdf_label, prefix_len + label_len);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    buf_write_u16(&amp;hkdf_label, (uin=
t16_t)out_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_write_u8(&amp;hkdf_label, prefix_len + (uint8_t)label_len);</span><br><=
span>     buf_write(&amp;hkdf_label, label_prefix, prefix_len);</span><br><=
span>     buf_write(&amp;hkdf_label, label, label_len);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_write_u8(&amp;h=
kdf_label, context_len);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    buf_write_u8(&amp;hkdf_label, (uint8_t)context_len);</span><br><sp=
an>     if (context_len &gt; 0)</span><br><span>     {</span><br><span>    =
     buf_write(&amp;hkdf_label, context, context_len);</span><br><span>@@ -=
168,10 +164,6 @@</span><br><span>     key-&gt;epoch =3D epoch_key-&gt;epoch=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span> static void</span><br><span>=
 epoch_init_send_key_ctx(struct crypto_options *co)</span><br><span> {</spa=
n><br><span>diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_ep=
och.h</span><br><span>index 33ca741..a6fa116 100644</span><br><span>--- a/s=
rc/openvpn/crypto_epoch.h</span><br><span>+++ b/src/openvpn/crypto_epoch.h<=
/span><br><span>@@ -60,7 +60,7 @@</span><br><span>  */</span><br><span> boo=
l ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t=
 *label,</span><br><span>                        size_t label_len, const ui=
nt8_t *context, size_t context_len, uint8_t *out,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                       uint16_t out_len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                       in=
t out_len);</span><br><span> </span><br><span> /**</span><br><span>  * Gene=
rate a data channel key pair from the epoch key</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/12=
18?usp=3Demail">change 1218</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1218?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iad717f0ff3c79ae199c8be5f93b=
c51bf258c68c3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1218 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--dLBwe8gaUC8=--

