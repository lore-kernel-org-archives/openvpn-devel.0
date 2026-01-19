From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 17:06:58 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., matthias.andree@...68...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6cbc9897ca18366995708019da89a417ff6fea86-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OfU6/cOUfV4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: mandree <matthias.andree@...68...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OfU6/cOUfV4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
45?usp=3Demail )

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

Gerrit-MessageType: merged
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

--OfU6/cOUfV4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1445?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_verify_openssl: Avoid conversion warning in =
x509_verify_cert_ku<br><br>Just use the correct types.<br><br>v2:<br> - Cha=
nge type of expected_len argument to size_t<br><br>Change-Id: Ia6c3f0395bd6=
cd67064fe77420d9df2b66763049<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit =
URL: https://gerrit.openvpn.net/c/openvpn/+/1445<br>Message-Id: &lt;2026011=
9122058.14865-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg35322.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_verify_backend.h<br=
>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_openssl.c<b=
r>3 files changed, 5 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_b=
ackend.h</span><br><span>index 0a2de03..9272cae 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_backend.h</span><br><span>@@ -240,7 +240,7 @@</span><br><span>  *     =
                 if key usage is not enabled, or the values do not match.</=
span><br><span>  */</span><br><span> result_t x509_verify_cert_ku(openvpn_x=
509_cert_t *x509, const unsigned *const expected_ku,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                             int expected_l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
              size_t expected_len);</span><br><span> </span><br><span> /*</=
span><br><span>  * Verify X.509 extended key usage extension field.</span><=
br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_ve=
rify_mbedtls.c</span><br><span>index 80396f8..9d89a1d 100644</span><br><spa=
n>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/=
ssl_verify_mbedtls.c</span><br><span>@@ -486,7 +486,7 @@</span><br><span> }=
</span><br><span> </span><br><span> result_t</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-x509_verify_cert_ku(mbedtls_x509_crt *cert, const un=
signed *const expected_ku, int expected_len)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+x509_verify_cert_ku(mbedtls_x509_crt *cert, const =
unsigned int *const expected_ku, size_t expected_len)</span><br><span> {</s=
pan><br><span>     msg(D_HANDSHAKE, &quot;Validating certificate key usage&=
quot;);</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_veri=
fy_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 4f657=
3d..60d5756 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</=
span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -6=
70,13 +670,8 @@</span><br><span>     return FAILURE;</span><br><span> }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> result_t</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-x509_verify_cert_ku(X509 *x509=
, const unsigned *const expected_ku, int expected_len)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+x509_verify_cert_ku(X509 *x509, const un=
signed int *const expected_ku, size_t expected_len)</span><br><span> {</spa=
n><br><span>     ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usa=
ge, NULL, NULL);</span><br><span> </span><br><span>@@ -693,8 +688,8 @@</spa=
n><br><span>         return SUCCESS;</span><br><span>     }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned nku =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t=
 i =3D 0; i &lt; 8; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    unsigned int nku =3D 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; 8; i++)</span><br><span>     {</s=
pan><br><span>         if (ASN1_BIT_STRING_get_bit(ku, i))</span><br><span>=
         {</span><br><span>@@ -734,10 +729,6 @@</span><br><span>     return=
 fFound;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> result_t</span><br><s=
pan> x509_verify_cert_eku(X509 *x509, const char *const expected_oid)</span=
><br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">change 1445</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--OfU6/cOUfV4=--

