From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 12 Nov 2025 15:45:15 +0000
In-Reply-To: <gerrit.1761324750000.If3331a2d0477634af077b4c29963dbec6d04e17b@...2715...>
References: <gerrit.1761324750000.If3331a2d0477634af077b4c29963dbec6d04e17b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <105ee238e64c9b6212f33a7ba9171904f00cb27b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6jcivfoCWWE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11: Avoid some
 conversion warnings
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

--6jcivfoCWWE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: pkcs11: Avoid some conversion warnings
......................................................................

pkcs11: Avoid some conversion warnings

Since we translate between different APIs
casts are unavoidable. Make sure they are safe.

Change-Id: If3331a2d0477634af077b4c29963dbec6d04e17b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1296
Message-Id: <20251111172531.7754-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
328.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/pkcs11.c
1 file changed, 13 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1296/4

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 9afb181..14118a9 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -53,18 +53,17 @@
 }
 #endif

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
-__mysleep(const unsigned long usec)
+__mysleep(unsigned long usec)
 {
 #if defined(_WIN32)
     Sleep(usec / 1000);
 #else
-    usleep(usec);
+    if (usec > UINT_MAX)
+    {
+        usec =3D UINT_MAX;
+    }
+    usleep((useconds_t)usec);
 #endif
 }

@@ -528,7 +527,13 @@
         goto cleanup;
     }

-    if (openvpn_base64_encode(certificate_blob, certificate_blob_size, &in=
ternal_base64) =3D=3D -1)
+    if (certificate_blob_size > INT_MAX)
+    {
+        msg(M_WARN, "PKCS#11: Invalid certificate size %zu", certificate_b=
lob_size);
+        goto cleanup;
+    }
+
+    if (openvpn_base64_encode(certificate_blob, (int)certificate_blob_size=
, &internal_base64) =3D=3D -1)
     {
         msg(M_WARN, "PKCS#11: Cannot encode certificate");
         goto cleanup;
@@ -563,10 +568,6 @@
     return success;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 tls_ctx_use_pkcs11(struct tls_root_ctx *const ssl_ctx, bool pkcs11_id_mana=
gement,
                    const char *const pkcs11_id)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If3331a2d0477634af077b4c29963dbec6d04e17b
Gerrit-Change-Number: 1296
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6jcivfoCWWE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">pkcs11: Avoid some conversion w=
arnings<br><br>Since we translate between different APIs<br>casts are unavo=
idable. Make sure they are safe.<br><br>Change-Id: If3331a2d0477634af077b4c=
29963dbec6d04e17b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL=
: https://gerrit.openvpn.net/c/openvpn/+/1296<br>Message-Id: &lt;2025111117=
2531.7754-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg34328.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M src/openvpn/pkcs11.c<br>1 file changed,=
 13 insertions(+), 12 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/96/1296/4</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c</span><br><span>index 9af=
b181..14118a9 100644</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><=
span>+++ b/src/openvpn/pkcs11.c</span><br><span>@@ -53,18 +53,17 @@</span><=
br><span> }</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static void</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-__mysleep(const unsigned long usec)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+__mysleep(unsigned long usec)</span><br><span> =
{</span><br><span> #if defined(_WIN32)</span><br><span>     Sleep(usec / 10=
00);</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    usleep(usec);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (usec &gt; UINT_MAX)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      usec =3D UINT_MAX;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uslee=
p((useconds_t)usec);</span><br><span> #endif</span><br><span> }</span><br><=
span> </span><br><span>@@ -528,7 +527,13 @@</span><br><span>         goto c=
leanup;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (openvpn_base64_encode(certificate_blob, =
certificate_blob_size, &amp;internal_base64) =3D=3D -1)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (certificate_blob_size &gt; INT_=
MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;PKC=
S#11: Invalid certificate size %zu&quot;, certificate_blob_size);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        goto cleanup;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (openvpn_base64_encode(certificate_blob, (int)certifi=
cate_blob_size, &amp;internal_base64) =3D=3D -1)</span><br><span>     {</sp=
an><br><span>         msg(M_WARN, &quot;PKCS#11: Cannot encode certificate&=
quot;);</span><br><span>         goto cleanup;</span><br><span>@@ -563,10 +=
568,6 @@</span><br><span>     return success;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span> int</span><br><span> tls_ctx_use_pkcs11(struct tls_root_ctx=
 *const ssl_ctx, bool pkcs11_id_management,</span><br><span>               =
     const char *const pkcs11_id)</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail=
">change 1296</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If3331a2d0477634af077b4c2996=
3dbec6d04e17b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1296 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--6jcivfoCWWE=--

