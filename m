From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 21 Jul 2023 13:55:42 +0000
References: <gerrit.1689947729000.Ifb961a4df2b8b8300633192e1a268669f6f41a35@...2715...>
Reply-To: frank@...2641..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ff6115082a1d2eb813204ef3e0e1579c894f4edc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RmWOsQ+NrfE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Make
 cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, selvanair <selva.nair@...277...>

--RmWOsQ+NrfE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: selvanair.

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/312?usp=3Demail )


Change subject: Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant
......................................................................

Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant

- Do not use non-literal initializers for static objects
- Replace empty initializer {} by {0}

Change-Id: Ifb961a4df2b8b8300633192e1a268669f6f41a35
Signed-off-by: Selva Nair <selva.nair@...277...>
Co-authored-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/cert_data.h
M tests/unit_tests/openvpn/test_cryptoapi.c
2 files changed, 20 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/12/312/1

diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/openvp=
n/cert_data.h
index 33de35e..0886b07 100644
--- a/tests/unit_tests/openvpn/cert_data.h
+++ b/tests/unit_tests/openvpn/cert_data.h
@@ -79,7 +79,7 @@
     "HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n"
     "KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA=3D=3D\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key2 =3D key1;
+#define key2 key1
 static const char *const hash2 =3D "FA18FD34BAABE47D6E2910E080F421C109CA97=
F5";
 static const char *const cname2 =3D "ovpn-test-ec2";

@@ -159,8 +159,8 @@
     "353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n"
     "mXSa4c8=3D\n"
     "-----END CERTIFICATE-----\n";
-static const char *const key4 =3D key3;
+#define key4 key3
 static const char *const hash4 =3D "E1401D4497C944783E3D62CDBD2A1F69F5E507=
1E";
-static const char *const cname4 =3D cname3; /* same CN as that of cert3 */
+#define cname4 cname3 /* same CN as that of cert3 */
=20
 #endif /* CERT_DATA_H */
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index e64a1de..0859b58 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -104,17 +104,26 @@
     const char *const friendly_name;    /* identifies certs loaded to the =
store -- keep unique */
     const char *hash;                   /* SHA1 fingerprint */
     int valid;                          /* nonzero if certificate has not =
expired */
-} certs[] =3D {
-    {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  hash1,=
  1},
-    {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  hash2,=
  1},
-    {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  hash3,=
  1},
-    {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  hash4,=
  0},
-    {}
-};
+} certs[5];

 static bool certs_loaded;
 static HCERTSTORE user_store;

+/* Fill-in certs[] array */
+void
+init_cert_data()
+{
+    struct test_cert certs_local[] =3D {
+        {cert1,  key1,  cname1,  "OVPN TEST CA1",  "OVPN Test Cert 1",  ha=
sh1,  1},
+        {cert2,  key2,  cname2,  "OVPN TEST CA2",  "OVPN Test Cert 2",  ha=
sh2,  1},
+        {cert3,  key3,  cname3,  "OVPN TEST CA1",  "OVPN Test Cert 3",  ha=
sh3,  1},
+        {cert4,  key4,  cname4,  "OVPN TEST CA2",  "OVPN Test Cert 4",  ha=
sh4,  0},
+        {0}
+    };
+    assert(sizeof(certs_local) =3D=3D sizeof(certs));
+    memcpy(certs, certs_local, sizeof(certs_local));
+}
+
 /* Lookup a certificate in our certificate/key db */
 static struct test_cert *
 lookup_cert(const char *friendly_name)
@@ -136,6 +145,7 @@
     {
         return;
     }
+    init_cert_data();
     user_store =3D CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM=
_STORE_CURRENT_USER
                                |CERT_STORE_OPEN_EXISTING_FLAG, L"MY");
     assert_non_null(user_store);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/312?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ifb961a4df2b8b8300633192e1a268669f6f41a35
Gerrit-Change-Number: 312
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-MessageType: newchange

--RmWOsQ+NrfE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: selvanair. </p>
<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/312?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant<br><br>=
- Do not use non-literal initializers for static objects<br>- Replace empty=
 initializer {} by {0}<br><br>Change-Id: Ifb961a4df2b8b8300633192e1a268669f=
6f41a35<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Co-aut=
hored-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/cert=
_data.h<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>2 files changed, =
20 insertions(+), 10 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/12/312/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_test=
s/openvpn/cert_data.h b/tests/unit_tests/openvpn/cert_data.h</span><br><spa=
n>index 33de35e..0886b07 100644</span><br><span>--- a/tests/unit_tests/open=
vpn/cert_data.h</span><br><span>+++ b/tests/unit_tests/openvpn/cert_data.h<=
/span><br><span>@@ -79,7 +79,7 @@</span><br><span>     &quot;HeTsAlHjfFEReV=
DiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZvJddL7Q\n&quot;</span><br><span>=
     &quot;KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFAa+k07ptRkOeablmFdXE81nVlA=3D=3D=
\n&quot;</span><br><span>     &quot;-----END CERTIFICATE-----\n&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static const char *const k=
ey2 =3D key1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#defin=
e key2 key1</span><br><span> static const char *const hash2 =3D &quot;FA18F=
D34BAABE47D6E2910E080F421C109CA97F5&quot;;</span><br><span> static const ch=
ar *const cname2 =3D &quot;ovpn-test-ec2&quot;;</span><br><span> </span><br=
><span>@@ -159,8 +159,8 @@</span><br><span>     &quot;353PpJJ9s2b/Fqoc4d7ud=
qhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\n&quot;</span><br><span>     &q=
uot;mXSa4c8=3D\n&quot;</span><br><span>     &quot;-----END CERTIFICATE-----=
\n&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static const=
 char *const key4 =3D key3;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define key4 key3</span><br><span> static const char *const hash4 =
=3D &quot;E1401D4497C944783E3D62CDBD2A1F69F5E5071E&quot;;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-static const char *const cname4 =3D cna=
me3; /* same CN as that of cert3 */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define cname4 cname3 /* same CN as that of cert3 */</span>=
<br><span> </span><br><span> #endif /* CERT_DATA_H */</span><br><span>diff =
--git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvp=
n/test_cryptoapi.c</span><br><span>index e64a1de..0859b58 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>@@ -104,17 +104,=
26 @@</span><br><span>     const char *const friendly_name;    /* identifie=
s certs loaded to the store -- keep unique */</span><br><span>     const ch=
ar *hash;                   /* SHA1 fingerprint */</span><br><span>     int=
 valid;                          /* nonzero if certificate has not expired =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-} certs[] =3D {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {cert1,  key1,  cname=
1,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Test Cert 1&quot;,  hash1,  1},<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {cert2,  key2,  cn=
ame2,  &quot;OVPN TEST CA2&quot;,  &quot;OVPN Test Cert 2&quot;,  hash2,  1=
},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {cert3,  key3, =
 cname3,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Test Cert 3&quot;,  hash3,=
  1},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {cert4,  key=
4,  cname4,  &quot;OVPN TEST CA2&quot;,  &quot;OVPN Test Cert 4&quot;,  has=
h4,  0},</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+} certs[5];</span><br><span> </span><br><span=
> static bool certs_loaded;</span><br><span> static HCERTSTORE user_store;<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 Fill-in certs[] array */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+init_cert=
_data()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct test_cert certs_loc=
al[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
cert1,  key1,  cname1,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Test Cert 1&=
quot;,  hash1,  1},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {cert2,  key2,  cname2,  &quot;OVPN TEST CA2&quot;,  &quot;OVPN Tes=
t Cert 2&quot;,  hash2,  1},</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {cert3,  key3,  cname3,  &quot;OVPN TEST CA1&quot;,  &quot=
;OVPN Test Cert 3&quot;,  hash3,  1},</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {cert4,  key4,  cname4,  &quot;OVPN TEST CA2&quot=
;,  &quot;OVPN Test Cert 4&quot;,  hash4,  0},</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {0}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert(sizeof(certs_local) =3D=3D sizeof(certs));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    memcpy(certs, certs_local, size=
of(certs_local));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*=
 Lookup a certificate in our certificate/key db */</span><br><span> static =
struct test_cert *</span><br><span> lookup_cert(const char *friendly_name)<=
/span><br><span>@@ -136,6 +145,7 @@</span><br><span>     {</span><br><span>=
         return;</span><br><span>     }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    init_cert_data();</span><br><span>     user_store =
=3D CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0, CERT_SYSTEM_STORE_CURRENT_U=
SER</span><br><span>                                |CERT_STORE_OPEN_EXISTI=
NG_FLAG, L&quot;MY&quot;);</span><br><span>     assert_non_null(user_store)=
;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/312?usp=3Demail">change 312</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/312?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb961a4df2b8b8300633192e1a2=
68669f6f41a35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 312 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--RmWOsQ+NrfE=--

