From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 17:06:56 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6cbc9897ca18366995708019da89a417ff6fea86-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KVUjO4qRASY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_openssl:
 Avoid conversion warning in x509_verify_cert_ku
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, mandree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KVUjO4qRASY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by mandree, Code-Review+2 by cron2


Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................

ssl_verify_openssl: Avoid conversion warning in x509_verify_cert_ku

Just use the correct types.

v2:
 - Change type of expected_len argument to size_t

Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1445
Message-Id: <20260119122058.14865-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
322.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
3 files changed, 5 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1445/5

diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index 0a2de03..9272cae 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -240,7 +240,7 @@
  *                      if key usage is not enabled, or the values do not =
match.
  */
 result_t x509_verify_cert_ku(openvpn_x509_cert_t *x509, const unsigned *co=
nst expected_ku,
-                             int expected_len);
+                             size_t expected_len);

 /*
  * Verify X.509 extended key usage extension field.
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 80396f8..9d89a1d 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -486,7 +486,7 @@
 }

 result_t
-x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned *const expected=
_ku, int expected_len)
+x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned int *const expe=
cted_ku, size_t expected_len)
 {
     msg(D_HANDSHAKE, "Validating certificate key usage");

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 4f6573d..60d5756 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -670,13 +670,8 @@
     return FAILURE;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 result_t
-x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku, int exp=
ected_len)
+x509_verify_cert_ku(X509 *x509, const unsigned int *const expected_ku, siz=
e_t expected_len)
 {
     ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usage, NULL, NU=
LL);

@@ -693,8 +688,8 @@
         return SUCCESS;
     }

-    unsigned nku =3D 0;
-    for (size_t i =3D 0; i < 8; i++)
+    unsigned int nku =3D 0;
+    for (int i =3D 0; i < 8; i++)
     {
         if (ASN1_BIT_STRING_get_bit(ku, i))
         {
@@ -734,10 +729,6 @@
     return fFound;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 result_t
 x509_verify_cert_eku(X509 *x509, const char *const expected_oid)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Gerrit-Change-Number: 1445
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KVUjO4qRASY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+1 by mandree, Code-Review+2 by cron2</p><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">ssl_verif=
y_openssl: Avoid conversion warning in x509_verify_cert_ku<br><br>Just use =
the correct types.<br><br>v2:<br> - Change type of expected_len argument to=
 size_t<br><br>Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049<br>Sign=
ed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/op=
envpn/+/1445<br>Message-Id: &lt;20260119122058.14865-1-gert@...1296...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g35322.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M src/openvpn/ssl_verify_backend.h<br>M src/openvpn/ssl_verify_mbedtls.c<=
br>M src/openvpn/ssl_verify_openssl.c<br>3 files changed, 5 insertions(+), =
14 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/45/1445/5</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl=
_verify_backend.h b/src/openvpn/ssl_verify_backend.h</span><br><span>index =
0a2de03..9272cae 100644</span><br><span>--- a/src/openvpn/ssl_verify_backen=
d.h</span><br><span>+++ b/src/openvpn/ssl_verify_backend.h</span><br><span>=
@@ -240,7 +240,7 @@</span><br><span>  *                      if key usage i=
s not enabled, or the values do not match.</span><br><span>  */</span><br><=
span> result_t x509_verify_cert_ku(openvpn_x509_cert_t *x509, const unsigne=
d *const expected_ku,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                             int expected_len);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                             size_t expected_le=
n);</span><br><span> </span><br><span> /*</span><br><span>  * Verify X.509 =
extended key usage extension field.</span><br><span>diff --git a/src/openvp=
n/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</span><br><span>i=
ndex 80396f8..9d89a1d 100644</span><br><span>--- a/src/openvpn/ssl_verify_m=
bedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls.c</span><br><=
span>@@ -486,7 +486,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> result_t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-x509_veri=
fy_cert_ku(mbedtls_x509_crt *cert, const unsigned *const expected_ku, int e=
xpected_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+x509_ve=
rify_cert_ku(mbedtls_x509_crt *cert, const unsigned int *const expected_ku,=
 size_t expected_len)</span><br><span> {</span><br><span>     msg(D_HANDSHA=
KE, &quot;Validating certificate key usage&quot;);</span><br><span> </span>=
<br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_v=
erify_openssl.c</span><br><span>index 4f6573d..60d5756 100644</span><br><sp=
an>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn=
/ssl_verify_openssl.c</span><br><span>@@ -670,13 +670,8 @@</span><br><span>=
     return FAILURE;</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clan=
g__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagn=
ostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC=
 diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> result_t</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-x509_verify_cert_ku(X509 *x509, const unsigned *const expected=
_ku, int expected_len)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+x509_verify_cert_ku(X509 *x509, const unsigned int *const expected_ku, s=
ize_t expected_len)</span><br><span> {</span><br><span>     ASN1_BIT_STRING=
 *ku =3D X509_get_ext_d2i(x509, NID_key_usage, NULL, NULL);</span><br><span=
> </span><br><span>@@ -693,8 +688,8 @@</span><br><span>         return SUCC=
ESS;</span><br><span>     }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    unsigned nku =3D 0;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; 8; i++)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int nku =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0;=
 i &lt; 8; i++)</span><br><span>     {</span><br><span>         if (ASN1_BI=
T_STRING_get_bit(ku, i))</span><br><span>         {</span><br><span>@@ -734=
,10 +729,6 @@</span><br><span>     return fFound;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> result_t</span><br><span> x509_verify_cert_eku(X509 *x5=
09, const char *const expected_oid)</span><br><span> {</span><br><span></sp=
an><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1445?usp=3Demail">change 1445</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1445?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d=
9df2b66763049 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--KVUjO4qRASY=--

