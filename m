From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 16 Dec 2025 17:53:22 +0000
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <90ad906283534ffdf41ecefd668f2facce1591fe-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6JqKIYm9QlM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6JqKIYm9QlM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail

to review the following change.


Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................

ssl_verify_openssl: Avoid conversion warning in x509_verify_cert_ku

Just use the correct type.

Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 4 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1445/1

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 633f78d..92b0e98 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -674,11 +674,6 @@
     return FAILURE;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 result_t
 x509_verify_cert_ku(X509 *x509, const unsigned *const expected_ku, int exp=
ected_len)
 {
@@ -697,8 +692,8 @@
         return SUCCESS;
     }

-    unsigned nku =3D 0;
-    for (size_t i =3D 0; i < 8; i++)
+    unsigned int nku =3D 0;
+    for (int i =3D 0; i < 8; i++)
     {
         if (ASN1_BIT_STRING_get_bit(ku, i))
         {
@@ -716,7 +711,7 @@

     msg(D_HANDSHAKE, "Validating certificate key usage");
     result_t fFound =3D FAILURE;
-    for (size_t i =3D 0; fFound !=3D SUCCESS && i < expected_len; i++)
+    for (int i =3D 0; fFound !=3D SUCCESS && i < expected_len; i++)
     {
         if (expected_ku[i] !=3D 0 && (nku & expected_ku[i]) =3D=3D expecte=
d_ku[i])
         {
@@ -727,7 +722,7 @@
     if (fFound !=3D SUCCESS)
     {
         msg(D_TLS_ERRORS, "ERROR: Certificate has key usage %04x, expected=
 one of:", nku);
-        for (size_t i =3D 0; i < expected_len && expected_ku[i]; i++)
+        for (int i =3D 0; i < expected_len && expected_ku[i]; i++)
         {
             msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
         }
@@ -738,10 +733,6 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Gerrit-Change-Number: 1445
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6JqKIYm9QlM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_verify_openssl: Avoid conversion warnin=
g in x509_verify_cert_ku<br><br>Just use the correct type.<br><br>Change-Id=
: Ia6c3f0395bd6cd67064fe77420d9df2b66763049<br>Signed-off-by: Frank Lichten=
held &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<=
br>1 file changed, 4 insertions(+), 13 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1445/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_ver=
ify_openssl.c</span><br><span>index 633f78d..92b0e98 100644</span><br><span=
>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/s=
sl_verify_openssl.c</span><br><span>@@ -674,11 +674,6 @@</span><br><span>  =
   return FAILURE;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang_=
_)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnos=
tic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> result_t</span><br><span> x509_verify_cert_ku(X509 =
*x509, const unsigned *const expected_ku, int expected_len)</span><br><span=
> {</span><br><span>@@ -697,8 +692,8 @@</span><br><span>         return SUC=
CESS;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    unsigned nku =3D 0;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; i &lt; 8; i++)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int nku =3D 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0=
; i &lt; 8; i++)</span><br><span>     {</span><br><span>         if (ASN1_B=
IT_STRING_get_bit(ku, i))</span><br><span>         {</span><br><span>@@ -71=
6,7 +711,7 @@</span><br><span> </span><br><span>     msg(D_HANDSHAKE, &quot=
;Validating certificate key usage&quot;);</span><br><span>     result_t fFo=
und =3D FAILURE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (size_t i =3D 0; fFound !=3D SUCCESS &amp;&amp; i &lt; expected_len; i++=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; fFound !=3D SUCCESS &amp;&amp; i &lt; expected_len; i++)</span><br><spa=
n>     {</span><br><span>         if (expected_ku[i] !=3D 0 &amp;&amp; (nku=
 &amp; expected_ku[i]) =3D=3D expected_ku[i])</span><br><span>         {</s=
pan><br><span>@@ -727,7 +722,7 @@</span><br><span>     if (fFound !=3D SUCC=
ESS)</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quo=
t;ERROR: Certificate has key usage %04x, expected one of:&quot;, nku);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (size_t i =3D =
0; i &lt; expected_len &amp;&amp; expected_ku[i]; i++)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; expecte=
d_len &amp;&amp; expected_ku[i]; i++)</span><br><span>         {</span><br>=
<span>             msg(D_TLS_ERRORS, &quot; * %04x&quot;, expected_ku[i]);<=
/span><br><span>         }</span><br><span>@@ -738,10 +733,6 @@</span><br><=
span>     return fFound;</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__=
clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC d=
iagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> resul=
t_t</span><br><span> x509_verify_cert_eku(X509 *x509, const char *const exp=
ected_oid)</span><br><span> {</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">ch=
ange 1445</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d=
9df2b66763049 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1445 </div>
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

--6JqKIYm9QlM=--

