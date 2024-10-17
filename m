From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 07:01:26 +0000
In-Reply-To: <gerrit.1727597930000.I0fd48191babe4fe5c56f10eb3ba88182ffb075d1@...2715...>
References: <gerrit.1727597930000.I0fd48191babe4fe5c56f10eb3ba88182ffb075d1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., steffan@...1856...,
 max@...2606...
Message-ID: <af7334f28374f264aa4e9d25697533a4cfdc38ea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="B0Sg73Bx5YE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Improve data channel
 crypto error messages
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: syzzer <steffan@...1856...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, MaxF <max@...2606...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--B0Sg73Bx5YE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 syzzer. ( http://gerrit.openvpn.net/c/openvpn/+/774?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by MaxF


Change subject: Improve data channel crypto error messages
......................................................................

Improve data channel crypto error messages

 * Make decryption error messages better understandable.
 * Increase verbosity level for authentication errors, because those can
   be expected on bad connections.

Change-Id: I0fd48191babe4fe5c56f10eb3ba88182ffb075d1
Signed-off-by: Steffan Karger <steffan@...1856...>
Acked-by: MaxF <max@...2606...>
Message-Id: <20241017064955.23959-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
569.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 12 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/774/2

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 12ad0b9..064e59e 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -459,14 +459,14 @@
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            data_len))
     {
-        CRYPT_ERROR("cipher update failed");
+        CRYPT_ERROR("packet decryption failed");
     }

     ASSERT(buf_inc_len(&work, outlen));
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
     {
-        CRYPT_ERROR("cipher final failed");
+        CRYPT_DROP("packet tag authentication failed");
     }
     ASSERT(buf_inc_len(&work, outlen));

@@ -538,7 +538,7 @@
             /* Compare locally computed HMAC with packet HMAC */
             if (memcmp_constant_time(local_hmac, BPTR(buf), hmac_len))
             {
-                CRYPT_ERROR("packet HMAC authentication failed");
+                CRYPT_DROP("packet HMAC authentication failed");
             }

             ASSERT(buf_advance(buf, hmac_len));
@@ -572,26 +572,26 @@
             /* ctx->cipher was already initialized with key & keylen */
             if (!cipher_ctx_reset(ctx->cipher, iv_buf))
             {
-                CRYPT_ERROR("cipher init failed");
+                CRYPT_ERROR("decrypt initialization failed");
             }

             /* Buffer overflow check (should never happen) */
             if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cip=
her)))
             {
-                CRYPT_ERROR("potential buffer overflow");
+                CRYPT_ERROR("packet too big to decrypt");
             }

             /* Decrypt packet ID, payload */
             if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR=
(buf), BLEN(buf)))
             {
-                CRYPT_ERROR("cipher update failed");
+                CRYPT_ERROR("packet decryption failed");
             }
             ASSERT(buf_inc_len(&work, outlen));

             /* Flush the decryption buffer */
             if (!cipher_ctx_final(ctx->cipher, BPTR(&work) + outlen, &outl=
en))
             {
-                CRYPT_ERROR("cipher final failed");
+                CRYPT_DROP("packet authentication failed, dropping.");
             }
             ASSERT(buf_inc_len(&work, outlen));

diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 61184bc..d91de74 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -288,8 +288,11 @@
                                  *   security operation functions. */
 };

-#define CRYPT_ERROR(format) \
-    do { msg(D_CRYPT_ERRORS, "%s: " format, error_prefix); goto error_exit=
; } while (false)
+#define CRYPT_ERROR_EXIT(flags, format) \
+    do { msg(flags, "%s: " format, error_prefix); goto error_exit; } while=
 (false)
+
+#define CRYPT_ERROR(format) CRYPT_ERROR_EXIT(D_CRYPT_ERRORS, format)
+#define CRYPT_DROP(format) CRYPT_ERROR_EXIT(D_MULTI_DROPPED, format)

 /**
  * Minimal IV length for AEAD mode ciphers (in bytes):

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/774?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0fd48191babe4fe5c56f10eb3ba88182ffb075d1
Gerrit-Change-Number: 774
Gerrit-PatchSet: 2
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--B0Sg73Bx5YE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by syzzer.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/774=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by MaxF</p><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">Improve data channel crypto error messages<br><br> * =
Make decryption error messages better understandable.<br> * Increase verbos=
ity level for authentication errors, because those can<br>   be expected on=
 bad connections.<br><br>Change-Id: I0fd48191babe4fe5c56f10eb3ba88182ffb075=
d1<br>Signed-off-by: Steffan Karger &lt;steffan@...1856...&gt;<br>Acked-by:=
 MaxF &lt;max@...2606...&gt;<br>Message-Id: &lt;20241017064955.23959-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg29569.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto.h<br>2 fil=
es changed, 12 insertions(+), 9 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/74/774/2</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/=
openvpn/crypto.c b/src/openvpn/crypto.c</span><br><span>index 12ad0b9..064e=
59e 100644</span><br><span>--- a/src/openvpn/crypto.c</span><br><span>+++ b=
/src/openvpn/crypto.c</span><br><span>@@ -459,14 +459,14 @@</span><br><span=
>     if (!cipher_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, =
BPTR(buf),</span><br><span>                            data_len))</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        CRYPT_ERROR(&quot;packet decryption fail=
ed&quot;);</span><br><span>     }</span><br><span> </span><br><span>     AS=
SERT(buf_inc_len(&amp;work, outlen));</span><br><span>     if (!cipher_ctx_=
final_check_tag(ctx-&gt;cipher, BPTR(&amp;work) + outlen,</span><br><span> =
                                    &amp;outlen, tag_ptr, tag_size))</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   CRYPT_ERROR(&quot;cipher final failed&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        CRYPT_DROP(&quot;packet tag authentica=
tion failed&quot;);</span><br><span>     }</span><br><span>     ASSERT(buf_=
inc_len(&amp;work, outlen));</span><br><span> </span><br><span>@@ -538,7 +5=
38,7 @@</span><br><span>             /* Compare locally computed HMAC with =
packet HMAC */</span><br><span>             if (memcmp_constant_time(local_=
hmac, BPTR(buf), hmac_len))</span><br><span>             {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                CRYPT_ERROR(&quot;pack=
et HMAC authentication failed&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                CRYPT_DROP(&quot;packet HMAC authenticati=
on failed&quot;);</span><br><span>             }</span><br><span> </span><b=
r><span>             ASSERT(buf_advance(buf, hmac_len));</span><br><span>@@=
 -572,26 +572,26 @@</span><br><span>             /* ctx-&gt;cipher was alre=
ady initialized with key &amp; keylen */</span><br><span>             if (!=
cipher_ctx_reset(ctx-&gt;cipher, iv_buf))</span><br><span>             {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                CRYPT_ER=
ROR(&quot;cipher init failed&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                CRYPT_ERROR(&quot;decrypt initialization f=
ailed&quot;);</span><br><span>             }</span><br><span> </span><br><s=
pan>             /* Buffer overflow check (should never happen) */</span><b=
r><span>             if (!buf_safe(&amp;work, buf-&gt;len + cipher_ctx_bloc=
k_size(ctx-&gt;cipher)))</span><br><span>             {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                CRYPT_ERROR(&quot;potenti=
al buffer overflow&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                CRYPT_ERROR(&quot;packet too big to decrypt&quot;);<=
/span><br><span>             }</span><br><span> </span><br><span>          =
   /* Decrypt packet ID, payload */</span><br><span>             if (!ciphe=
r_ctx_update(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf), BLEN(=
buf)))</span><br><span>             {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                CRYPT_ERROR(&quot;cipher update failed&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
CRYPT_ERROR(&quot;packet decryption failed&quot;);</span><br><span>        =
     }</span><br><span>             ASSERT(buf_inc_len(&amp;work, outlen));=
</span><br><span> </span><br><span>             /* Flush the decryption buf=
fer */</span><br><span>             if (!cipher_ctx_final(ctx-&gt;cipher, B=
PTR(&amp;work) + outlen, &amp;outlen))</span><br><span>             {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                CRYPT_ERROR=
(&quot;cipher final failed&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                CRYPT_DROP(&quot;packet authentication faile=
d, dropping.&quot;);</span><br><span>             }</span><br><span>       =
      ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br><=
span>diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h</span><br><sp=
an>index 61184bc..d91de74 100644</span><br><span>--- a/src/openvpn/crypto.h=
</span><br><span>+++ b/src/openvpn/crypto.h</span><br><span>@@ -288,8 +288,=
11 @@</span><br><span>                                  *   security operat=
ion functions. */</span><br><span> };</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#define CRYPT_ERROR(format) \</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    do { msg(D_CRYPT_ERRORS, &quo=
t;%s: &quot; format, error_prefix); goto error_exit; } while (false)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPT_ERROR_EXIT(f=
lags, format) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
do { msg(flags, &quot;%s: &quot; format, error_prefix); goto error_exit; } =
while (false)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CRYPT_ERROR(forma=
t) CRYPT_ERROR_EXIT(D_CRYPT_ERRORS, format)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define CRYPT_DROP(format) CRYPT_ERROR_EXIT(D_MULTI=
_DROPPED, format)</span><br><span> </span><br><span> /**</span><br><span>  =
* Minimal IV length for AEAD mode ciphers (in bytes):</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/774?usp=3Demail">change 774</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/774?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0fd48191babe4fe5c56f10eb3ba=
88182ffb075d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 774 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: MaxF &lt;max@...2606...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--B0Sg73Bx5YE=--

