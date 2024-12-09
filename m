From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 9 Dec 2024 17:54:27 +0000
References: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5254714c1a270a4f4c43ab6a1aa66f11fbf86e28-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5lmcXpBvwpM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix memory leak in
 ntlm_support
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

--5lmcXpBvwpM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail

to review the following change.


Change subject: Fix memory leak in ntlm_support
......................................................................

Fix memory leak in ntlm_support

Not really important but prevents running the NTLM
t_client tests with ASAN enabled.

Change-Id: If472398d4ff8323de485f084a07160b365dfc501
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/ntlm_support.c
1 file changed, 8 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/826/1

diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
index ccf8962..18d555a 100644
--- a/tests/ntlm_support.c
+++ b/tests/ntlm_support.c
@@ -33,11 +33,11 @@
 int
 main(void)
 {
-#if defined(ENABLE_CRYPTO_OPENSSL)
-    crypto_load_provider("legacy");
-    crypto_load_provider("default");
-#endif
 #ifdef NTLM
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    provider_t *legacy =3D crypto_load_provider("legacy");
+    provider_t *def =3D crypto_load_provider("default");
+#endif
     if (!md_valid("MD4"))
     {
         msg(M_FATAL, "MD4 not supported");
@@ -46,6 +46,10 @@
     {
         msg(M_FATAL, "MD5 not supported");
     }
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    crypto_unload_provider("legacy", legacy);
+    crypto_unload_provider("default", def);
+#endif
 #else  /* ifdef NTLM */
     msg(M_FATAL, "NTLM support not compiled in");
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If472398d4ff8323de485f084a07160b365dfc501
Gerrit-Change-Number: 826
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--5lmcXpBvwpM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix memory leak in ntlm_support<br><br>Not really important b=
ut prevents running the NTLM<br>t_client tests with ASAN enabled.<br><br>Ch=
ange-Id: If472398d4ff8323de485f084a07160b365dfc501<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/ntlm_support.c<br>1 =
file changed, 8 insertions(+), 4 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/26/826/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tes=
ts/ntlm_support.c b/tests/ntlm_support.c</span><br><span>index ccf8962..18d=
555a 100644</span><br><span>--- a/tests/ntlm_support.c</span><br><span>+++ =
b/tests/ntlm_support.c</span><br><span>@@ -33,11 +33,11 @@</span><br><span>=
 int</span><br><span> main(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_OPENSSL)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_load_provider(&quot=
;legacy&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cr=
ypto_load_provider(&quot;default&quot;);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span> #ifdef NTLM</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    provider_t *legacy =
=3D crypto_load_provider(&quot;legacy&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    provider_t *def =3D crypto_load_provider(&quo=
t;default&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span>     if (!md_valid(&quot;MD4&quot;))</span><br><span> =
    {</span><br><span>         msg(M_FATAL, &quot;MD4 not supported&quot;);=
</span><br><span>@@ -46,6 +46,10 @@</span><br><span>     {</span><br><span>=
         msg(M_FATAL, &quot;MD5 not supported&quot;);</span><br><span>     =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE=
_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 crypto_unload_provider(&quot;legacy&quot;, legacy);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    crypto_unload_provider(&quot;default&=
quot;, def);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif<=
/span><br><span> #else  /* ifdef NTLM */</span><br><span>     msg(M_FATAL, =
&quot;NTLM support not compiled in&quot;);</span><br><span> #endif</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/826?usp=3Demail">change 826</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
826?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If472398d4ff8323de485f084a07=
160b365dfc501 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 826 </div>
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


--5lmcXpBvwpM=--

