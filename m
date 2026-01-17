From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 17 Jan 2026 16:25:39 +0000
In-Reply-To: <gerrit.1765907598000.I99bc4692526f9143a913e29b266a1816295dfd51@...2715...>
References: <gerrit.1765907598000.I99bc4692526f9143a913e29b266a1816295dfd51@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <252f8aa7baf84a44ee701cd6cfe65c9bfd042dd3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LwFw/N1OWPQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: crypto_openssl: Fix
 various conversion warnings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LwFw/N1OWPQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1446?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: crypto_openssl: Fix various conversion warnings
......................................................................

crypto_openssl: Fix various conversion warnings

EVP_CIPHER_CTX_flags is documented to output
int in OpenSSL, but is actually unsigned long
in OpenSSL 3.
In libressl it is correctly documented to output
unsigned long.

Change-Id: I99bc4692526f9143a913e29b266a1816295dfd51
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1446
Message-Id: <20260116172010.25278-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
311.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto_openssl.c
1 file changed, 4 insertions(+), 13 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1446/5

diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 64882f5..ed39efa 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -896,11 +896,6 @@
     return EVP_CIPHER_CTX_mode(ctx);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 cipher_ctx_mode_cbc(const cipher_ctx_t *ctx)
 {
@@ -909,7 +904,7 @@
         return false;
     }

-    int flags =3D EVP_CIPHER_CTX_flags(ctx);
+    unsigned long flags =3D EVP_CIPHER_CTX_flags(ctx);
     int mode =3D EVP_CIPHER_CTX_mode(ctx);

     return mode =3D=3D EVP_CIPH_CBC_MODE
@@ -940,7 +935,7 @@
 {
     if (ctx)
     {
-        int flags =3D EVP_CIPHER_CTX_flags(ctx);
+        unsigned long flags =3D EVP_CIPHER_CTX_flags(ctx);
         if (flags & EVP_CIPH_FLAG_AEAD_CIPHER)
         {
             return true;
@@ -995,8 +990,8 @@
 cipher_ctx_final_check_tag(EVP_CIPHER_CTX *ctx, uint8_t *dst, int *dst_len=
, uint8_t *tag,
                            size_t tag_len)
 {
-    ASSERT(tag_len < SIZE_MAX);
-    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, tag_len, tag))
+    ASSERT(tag_len < INT_MAX);
+    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_CTRL_AEAD_SET_TAG, (int)tag_len, tag=
))
     {
         return 0;
     }
@@ -1004,10 +999,6 @@
     return cipher_ctx_final(ctx, dst, dst_len);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  *
  * Generic message digest information functions

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1446?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I99bc4692526f9143a913e29b266a1816295dfd51
Gerrit-Change-Number: 1446
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LwFw/N1OWPQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1446?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">crypto_openssl: Fix various convers=
ion warnings<br><br>EVP_CIPHER_CTX_flags is documented to output<br>int in =
OpenSSL, but is actually unsigned long<br>in OpenSSL 3.<br>In libressl it i=
s correctly documented to output<br>unsigned long.<br><br>Change-Id: I99bc4=
692526f9143a913e29b266a1816295dfd51<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1446<br>Message-Id: &lt;=
20260116172010.25278-1-gert@...1296...&gt;<br>URL: https://www.mail-archive=
.com/openvpn-devel@lists.sourceforge.net/msg35311.html<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/crypto_openssl.c=
<br>1 file changed, 4 insertions(+), 13 deletions(-)<br><br></pre><pre clas=
s=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1446/5=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_ope=
nssl.c</span><br><span>index 64882f5..ed39efa 100644</span><br><span>--- a/=
src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_opens=
sl.c</span><br><span>@@ -896,11 +896,6 @@</span><br><span>     return EVP_C=
IPHER_CTX_mode(ctx);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> bool</span><br><span> cipher_ctx_mode_cbc(const c=
ipher_ctx_t *ctx)</span><br><span> {</span><br><span>@@ -909,7 +904,7 @@</s=
pan><br><span>         return false;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int flags =3D E=
VP_CIPHER_CTX_flags(ctx);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    unsigned long flags =3D EVP_CIPHER_CTX_flags(ctx);</span><br><spa=
n>     int mode =3D EVP_CIPHER_CTX_mode(ctx);</span><br><span> </span><br><=
span>     return mode =3D=3D EVP_CIPH_CBC_MODE</span><br><span>@@ -940,7 +9=
35,7 @@</span><br><span> {</span><br><span>     if (ctx)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int flags=
 =3D EVP_CIPHER_CTX_flags(ctx);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        unsigned long flags =3D EVP_CIPHER_CTX_flags(ctx);</spa=
n><br><span>         if (flags &amp; EVP_CIPH_FLAG_AEAD_CIPHER)</span><br><=
span>         {</span><br><span>             return true;</span><br><span>@=
@ -995,8 +990,8 @@</span><br><span> cipher_ctx_final_check_tag(EVP_CIPHER_C=
TX *ctx, uint8_t *dst, int *dst_len, uint8_t *tag,</span><br><span>        =
                    size_t tag_len)</span><br><span> {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ASSERT(tag_len &lt; SIZE_MAX);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_CIPHER_CTX_ctrl(=
ctx, EVP_CTRL_AEAD_SET_TAG, tag_len, tag))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    ASSERT(tag_len &lt; INT_MAX);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (!EVP_CIPHER_CTX_ctrl(ctx, EVP_=
CTRL_AEAD_SET_TAG, (int)tag_len, tag))</span><br><span>     {</span><br><sp=
an>         return 0;</span><br><span>     }</span><br><span>@@ -1004,10 +9=
99,6 @@</span><br><span>     return cipher_ctx_final(ctx, dst, dst_len);</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  *</span><br=
><span>  * Generic message digest information functions</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1446?usp=3Demail">change 1446</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1446?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I99bc4692526f9143a913e29b266=
a1816295dfd51 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1446 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--LwFw/N1OWPQ=--

