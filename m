From: "syzzer (Code Review)" <gerrit@...515...>
Date: Sun, 29 Sep 2024 08:18:54 +0000
References: <gerrit.1727597930000.I0fd48191babe4fe5c56f10eb3ba88182ffb075d1@...2715...>
Reply-To: steffan@...1856..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c3f2b7b20d867f4cd686a918ec93f53869ec40ff-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EiW/QCM+G/w="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EiW/QCM+G/w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/774?usp=3Demail

to review the following change.


Change subject: Improve data channel crypto error messages
......................................................................

Improve data channel crypto error messages

 * Make decryption error messages better understandable.
 * Increase verbosity level for authentication errors, because those can
   be expected on bad connections.

Change-Id: I0fd48191babe4fe5c56f10eb3ba88182ffb075d1
Signed-off-by: Steffan Karger <steffan@...1856...>
---
M src/openvpn/crypto.c
M src/openvpn/crypto.h
2 files changed, 12 insertions(+), 9 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/774/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: syzzer <steffan@...1856...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--EiW/QCM+G/w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>syzzer would like plaisthos and flichtenheld to <strong>review</strong> =
this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/774?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Improve data channel crypto error messages<br><br> * Make dec=
ryption error messages better understandable.<br> * Increase verbosity leve=
l for authentication errors, because those can<br>   be expected on bad con=
nections.<br><br>Change-Id: I0fd48191babe4fe5c56f10eb3ba88182ffb075d1<br>Si=
gned-off-by: Steffan Karger &lt;steffan@...1856...&gt;<br>---<br>M src/open=
vpn/crypto.c<br>M src/openvpn/crypto.h<br>2 files changed, 12 insertions(+)=
, 9 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/74/774/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/crypto.c b/src/openv=
pn/crypto.c</span><br><span>index 12ad0b9..064e59e 100644</span><br><span>-=
-- a/src/openvpn/crypto.c</span><br><span>+++ b/src/openvpn/crypto.c</span>=
<br><span>@@ -459,14 +459,14 @@</span><br><span>     if (!cipher_ctx_update=
(ctx-&gt;cipher, BPTR(&amp;work), &amp;outlen, BPTR(buf),</span><br><span> =
                           data_len))</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;cipher upd=
ate failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       CRYPT_ERROR(&quot;packet decryption failed&quot;);</span><br><span> =
    }</span><br><span> </span><br><span>     ASSERT(buf_inc_len(&amp;work, =
outlen));</span><br><span>     if (!cipher_ctx_final_check_tag(ctx-&gt;ciph=
er, BPTR(&amp;work) + outlen,</span><br><span>                             =
        &amp;outlen, tag_ptr, tag_size))</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        CRYPT_ERROR(&quot;cipher =
final failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        CRYPT_DROP(&quot;packet tag authentication failed&quot;);</span><b=
r><span>     }</span><br><span>     ASSERT(buf_inc_len(&amp;work, outlen));=
</span><br><span> </span><br><span>@@ -538,7 +538,7 @@</span><br><span>    =
         /* Compare locally computed HMAC with packet HMAC */</span><br><sp=
an>             if (memcmp_constant_time(local_hmac, BPTR(buf), hmac_len))<=
/span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                CRYPT_ERROR(&quot;packet HMAC authentication faile=
d&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      CRYPT_DROP(&quot;packet HMAC authentication failed&quot;);</span><br>=
<span>             }</span><br><span> </span><br><span>             ASSERT(=
buf_advance(buf, hmac_len));</span><br><span>@@ -572,26 +572,26 @@</span><b=
r><span>             /* ctx-&gt;cipher was already initialized with key &am=
p; keylen */</span><br><span>             if (!cipher_ctx_reset(ctx-&gt;cip=
her, iv_buf))</span><br><span>             {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                CRYPT_ERROR(&quot;cipher init failed=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     CRYPT_ERROR(&quot;decrypt initialization failed&quot;);</span><br><spa=
n>             }</span><br><span> </span><br><span>             /* Buffer o=
verflow check (should never happen) */</span><br><span>             if (!bu=
f_safe(&amp;work, buf-&gt;len + cipher_ctx_block_size(ctx-&gt;cipher)))</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                CRYPT_ERROR(&quot;potential buffer overflow&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                CRYPT=
_ERROR(&quot;packet too big to decrypt&quot;);</span><br><span>            =
 }</span><br><span> </span><br><span>             /* Decrypt packet ID, pay=
load */</span><br><span>             if (!cipher_ctx_update(ctx-&gt;cipher,=
 BPTR(&amp;work), &amp;outlen, BPTR(buf), BLEN(buf)))</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    CRYPT_ERROR(&quot;cipher update failed&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                CRYPT_ERROR(&quot;packet dec=
ryption failed&quot;);</span><br><span>             }</span><br><span>     =
        ASSERT(buf_inc_len(&amp;work, outlen));</span><br><span> </span><br=
><span>             /* Flush the decryption buffer */</span><br><span>     =
        if (!cipher_ctx_final(ctx-&gt;cipher, BPTR(&amp;work) + outlen, &am=
p;outlen))</span><br><span>             {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                CRYPT_ERROR(&quot;cipher final failed&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   CRYPT_DROP(&quot;packet authentication failed, dropping.&quot;);</span><=
br><span>             }</span><br><span>             ASSERT(buf_inc_len(&am=
p;work, outlen));</span><br><span> </span><br><span>diff --git a/src/openvp=
n/crypto.h b/src/openvpn/crypto.h</span><br><span>index 61184bc..d91de74 10=
0644</span><br><span>--- a/src/openvpn/crypto.h</span><br><span>+++ b/src/o=
penvpn/crypto.h</span><br><span>@@ -288,8 +288,11 @@</span><br><span>      =
                            *   security operation functions. */</span><br>=
<span> };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define CRYPT_ERROR(format) \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    do { msg(D_CRYPT_ERRORS, &quot;%s: &quot; format, error_p=
refix); goto error_exit; } while (false)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#define CRYPT_ERROR_EXIT(flags, format) \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    do { msg(flags, &quot;%s: &q=
uot; format, error_prefix); goto error_exit; } while (false)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define CRYPT_ERROR(format) CRYPT_ERROR_EXIT(D_CRYPT_=
ERRORS, format)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#def=
ine CRYPT_DROP(format) CRYPT_ERROR_EXIT(D_MULTI_DROPPED, format)</span><br>=
<span> </span><br><span> /**</span><br><span>  * Minimal IV length for AEAD=
 mode ciphers (in bytes):</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/774?usp=3Demail">change =
774</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/774?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0fd48191babe4fe5c56f10eb3ba=
88182ffb075d1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 774 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: syzzer &lt;steffan@...1856...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--EiW/QCM+G/w=--

