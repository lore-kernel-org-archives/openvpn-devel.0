From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 17 Dec 2025 14:25:27 +0000
In-Reply-To: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
References: <gerrit.1765907598000.Ia6c3f0395bd6cd67064fe77420d9df2b66763049@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 matthias.andree@...68..., openvpn-devel@lists.sourceforge.net
Message-ID: <292c983e225e0a7dbfb6318798850253baa3750b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7CNxiM/7ThE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, mandree <matthias.andree@...68...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7CNxiM/7ThE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello mandree, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail

to look at the new patch set (#2).


Change subject: ssl_verify_openssl: Avoid conversion warning in x509_verify=
_cert_ku
......................................................................

ssl_verify_openssl: Avoid conversion warning in x509_verify_cert_ku

Just use the correct types.

v2:
 - Change type of expected_len argument to size_t

Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/ssl_verify_backend.h
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
3 files changed, 5 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1445/2

diff --git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_back=
end.h
index 1d56533..d70f2df 100644
--- a/src/openvpn/ssl_verify_backend.h
+++ b/src/openvpn/ssl_verify_backend.h
@@ -243,7 +243,7 @@
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
index b7de550..a38f5e9 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -483,7 +483,7 @@
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
index 633f78d..ec7acf8 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -674,13 +674,8 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d9df2b66763049
Gerrit-Change-Number: 1445
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: mandree <matthias.andree@...68...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--7CNxiM/7ThE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_verify_openssl: Avoid conversion warning in =
x509_verify_cert_ku<br><br>Just use the correct types.<br><br>v2:<br> - Cha=
nge type of expected_len argument to size_t<br><br>Change-Id: Ia6c3f0395bd6=
cd67064fe77420d9df2b66763049<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>---<br>M src/openvpn/ssl_verify_backend.h<br>M src/openvp=
n/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_verify_openssl.c<br>3 files cha=
nged, 5 insertions(+), 14 deletions(-)<br><br></pre><pre class=3D"blocks" s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/1445/2</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl_verify_backend.h b/src/openvpn/ssl_verify_backend.h=
</span><br><span>index 1d56533..d70f2df 100644</span><br><span>--- a/src/op=
envpn/ssl_verify_backend.h</span><br><span>+++ b/src/openvpn/ssl_verify_bac=
kend.h</span><br><span>@@ -243,7 +243,7 @@</span><br><span>  *             =
         if key usage is not enabled, or the values do not match.</span><br=
><span>  */</span><br><span> result_t x509_verify_cert_ku(openvpn_x509_cert=
_t *x509, const unsigned *const expected_ku,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                             int expected_len);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
     size_t expected_len);</span><br><span> </span><br><span> /*</span><br>=
<span>  * Verify X.509 extended key usage extension field.</span><br><span>=
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c</span><br><span>index b7de550..a38f5e9 100644</span><br><span>--- a/s=
rc/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verif=
y_mbedtls.c</span><br><span>@@ -483,7 +483,7 @@</span><br><span> }</span><b=
r><span> </span><br><span> result_t</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned *c=
onst expected_ku, int expected_len)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+x509_verify_cert_ku(mbedtls_x509_crt *cert, const unsigned =
int *const expected_ku, size_t expected_len)</span><br><span> {</span><br><=
span>     msg(D_HANDSHAKE, &quot;Validating certificate key usage&quot;);</=
span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify_openss=
l.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 633f78d..ec7ac=
f8 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br>=
<span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -674,13 +67=
4,8 @@</span><br><span>     return FAILURE;</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GN=
UC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> result_t</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-x509_verify_cert_ku(X509 *x509, const =
unsigned *const expected_ku, int expected_len)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+x509_verify_cert_ku(X509 *x509, const unsigned i=
nt *const expected_ku, size_t expected_len)</span><br><span> {</span><br><s=
pan>     ASN1_BIT_STRING *ku =3D X509_get_ext_d2i(x509, NID_key_usage, NULL=
, NULL);</span><br><span> </span><br><span>@@ -697,8 +692,8 @@</span><br><s=
pan>         return SUCCESS;</span><br><span>     }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned nku =3D 0;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (size_t i =3D 0; =
i &lt; 8; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    u=
nsigned int nku =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    for (int i =3D 0; i &lt; 8; i++)</span><br><span>     {</span><br><s=
pan>         if (ASN1_BIT_STRING_get_bit(ku, i))</span><br><span>         {=
</span><br><span>@@ -738,10 +733,6 @@</span><br><span>     return fFound;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> result_t</span><br><span> x509_=
verify_cert_eku(X509 *x509, const char *const expected_oid)</span><br><span=
> {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1445?usp=3Demail">change 1445</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1445?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia6c3f0395bd6cd67064fe77420d=
9df2b66763049 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: mandree &lt;matthias.andree@...220...=
..68...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--7CNxiM/7ThE=--

