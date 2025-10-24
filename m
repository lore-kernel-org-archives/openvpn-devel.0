From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:47 +0000
References: <gerrit.1761324750000.If3331a2d0477634af077b4c29963dbec6d04e17b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7cfc68a081d9125a65bc5d3f94c2ee6ffd9d838c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9gH0UVhGepM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9gH0UVhGepM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail

to review the following change.


Change subject: pkcs11: Avoid some conversion warnings
......................................................................

pkcs11: Avoid some conversion warnings

Since we translate between different APIs
casts are unavoidable. Make sure they are safe.

Change-Id: If3331a2d0477634af077b4c29963dbec6d04e17b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/pkcs11.c
1 file changed, 13 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1296/1

diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index ce64135..a253503 100644
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

@@ -531,7 +530,13 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If3331a2d0477634af077b4c29963dbec6d04e17b
Gerrit-Change-Number: 1296
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9gH0UVhGepM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1296?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">pkcs11: Avoid some conversion warnings<br><=
br>Since we translate between different APIs<br>casts are unavoidable. Make=
 sure they are safe.<br><br>Change-Id: If3331a2d0477634af077b4c29963dbec6d0=
4e17b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<b=
r>M src/openvpn/pkcs11.c<br>1 file changed, 13 insertions(+), 12 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/96/1296/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/pkcs11.c b/src/o=
penvpn/pkcs11.c</span><br><span>index ce64135..a253503 100644</span><br><sp=
an>--- a/src/openvpn/pkcs11.c</span><br><span>+++ b/src/openvpn/pkcs11.c</s=
pan><br><span>@@ -53,18 +53,17 @@</span><br><span> }</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-__mysleep(const unsign=
ed long usec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+__mysl=
eep(unsigned long usec)</span><br><span> {</span><br><span> #if defined(_WI=
N32)</span><br><span>     Sleep(usec / 1000);</span><br><span> #else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    usleep(usec);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (usec &gt; UINT_MAX)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        usec =3D UINT_MAX;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    usleep((useconds_t)usec);</span><br><=
span> #endif</span><br><span> }</span><br><span> </span><br><span>@@ -531,7=
 +530,13 @@</span><br><span>         goto cleanup;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (openvpn_base64_encode(certificate_blob, certificate_blob_size, &amp;inte=
rnal_base64) =3D=3D -1)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (certificate_blob_size &gt; INT_MAX)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        msg(M_WARN, &quot;PKCS#11: Invalid certificate size %=
zu&quot;, certificate_blob_size);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto cleanup;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (openvpn_b=
ase64_encode(certificate_blob, (int)certificate_blob_size, &amp;internal_ba=
se64) =3D=3D -1)</span><br><span>     {</span><br><span>         msg(M_WARN=
, &quot;PKCS#11: Cannot encode certificate&quot;);</span><br><span>        =
 goto cleanup;</span><br><span>@@ -563,10 +568,6 @@</span><br><span>     re=
turn success;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
op</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><s=
pan> tls_ctx_use_pkcs11(struct tls_root_ctx *const ssl_ctx, bool pkcs11_id_=
management,</span><br><span>                    const char *const pkcs11_id=
)</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1296?usp=3Demail">change 1296</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1296?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If3331a2d0477634af077b4c2996=
3dbec6d04e17b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1296 </div>
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

--9gH0UVhGepM=--

