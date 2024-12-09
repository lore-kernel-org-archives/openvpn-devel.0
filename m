From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Dec 2024 20:09:43 +0000
In-Reply-To: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
References: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <9d77e6708aea37f27bf32ca8a91ef17ec8024673-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QR2dWNGiOp8="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--QR2dWNGiOp8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: Fix memory leak in ntlm_support
......................................................................

Fix memory leak in ntlm_support

Not really important but prevents running the NTLM
t_client tests with ASAN enabled.

Change-Id: If472398d4ff8323de485f084a07160b365dfc501
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20241209194957.358-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
049.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/ntlm_support.c
1 file changed, 8 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/826/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--QR2dWNGiOp8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/826?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix memory leak in ntlm_support<br><br>Not really im=
portant but prevents running the NTLM<br>t_client tests with ASAN enabled.<=
br><br>Change-Id: If472398d4ff8323de485f084a07160b365dfc501<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Lev Stipakov &lt=
;lstipakov@...277...&gt;<br>Message-Id: &lt;20241209194957.358-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg30049.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M tests/ntlm_support.c<br>1 file changed, 8 insertions(+), 4 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/26/826/2</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/tests/ntlm_support.c b/tests/ntlm_supp=
ort.c</span><br><span>index ccf8962..18d555a 100644</span><br><span>--- a/t=
ests/ntlm_support.c</span><br><span>+++ b/tests/ntlm_support.c</span><br><s=
pan>@@ -33,11 +33,11 @@</span><br><span> int</span><br><span> main(void)</s=
pan><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if d=
efined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    crypto_load_provider(&quot;legacy&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    crypto_load_provider(&quot;default&quot=
;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span> #ifdef NTLM</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    provider_t *legacy =3D crypto_load_provider(&quot;legacy&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    provider_=
t *def =3D crypto_load_provider(&quot;default&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     if (!md_valid=
(&quot;MD4&quot;))</span><br><span>     {</span><br><span>         msg(M_FA=
TAL, &quot;MD4 not supported&quot;);</span><br><span>@@ -46,6 +46,10 @@</sp=
an><br><span>     {</span><br><span>         msg(M_FATAL, &quot;MD5 not sup=
ported&quot;);</span><br><span>     }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    crypto_unload_provider(&quot;legacy&q=
uot;, legacy);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
rypto_unload_provider(&quot;default&quot;, def);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span> #else  /* ifdef NTLM *=
/</span><br><span>     msg(M_FATAL, &quot;NTLM support not compiled in&quot=
;);</span><br><span> #endif</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail">chang=
e 826</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If472398d4ff8323de485f084a07=
160b365dfc501 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 826 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--QR2dWNGiOp8=--

