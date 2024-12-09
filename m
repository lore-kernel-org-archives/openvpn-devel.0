From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Dec 2024 20:09:45 +0000
In-Reply-To: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
References: <gerrit.1733766865000.If472398d4ff8323de485f084a07160b365dfc501@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <9d77e6708aea37f27bf32ca8a91ef17ec8024673-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="l4aRDN0uElQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--l4aRDN0uElQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/82=
6?usp=3Demail )

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
Gerrit-MessageType: merged

--l4aRDN0uElQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/826?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix memory leak in ntlm_support<br><br>Not rea=
lly important but prevents running the NTLM<br>t_client tests with ASAN ena=
bled.<br><br>Change-Id: If472398d4ff8323de485f084a07160b365dfc501<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Lev Stipak=
ov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20241209194957.358-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg30049.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M tests/ntlm_support.c<br>1 file changed, 8 insertions(+)=
, 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c</span><br><span=
>index ccf8962..18d555a 100644</span><br><span>--- a/tests/ntlm_support.c</=
span><br><span>+++ b/tests/ntlm_support.c</span><br><span>@@ -33,11 +33,11 =
@@</span><br><span> int</span><br><span> main(void)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(ENABLE_CRYPTO_=
OPENSSL)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    crypto_lo=
ad_provider(&quot;legacy&quot;);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    crypto_load_provider(&quot;default&quot;);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> #ifdef NTLM</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYP=
TO_OPENSSL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    prov=
ider_t *legacy =3D crypto_load_provider(&quot;legacy&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    provider_t *def =3D crypto_loa=
d_provider(&quot;default&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span>     if (!md_valid(&quot;MD4&quot;))</s=
pan><br><span>     {</span><br><span>         msg(M_FATAL, &quot;MD4 not su=
pported&quot;);</span><br><span>@@ -46,6 +46,10 @@</span><br><span>     {</=
span><br><span>         msg(M_FATAL, &quot;MD5 not supported&quot;);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    crypto_unload_provider(&quot;legacy&quot;, legacy);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    crypto_unload_provider(=
&quot;default&quot;, def);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span> #else  /* ifdef NTLM */</span><br><span>    =
 msg(M_FATAL, &quot;NTLM support not compiled in&quot;);</span><br><span> #=
endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/826?usp=3Demail">change 826</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/826?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--l4aRDN0uElQ=--

