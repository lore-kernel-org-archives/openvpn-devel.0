From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 23 Sep 2023 10:29:34 +0000
In-Reply-To: <gerrit.1689947729000.Ifb961a4df2b8b8300633192e1a268669f6f41a35@...2715...>
References: <gerrit.1689947729000.Ifb961a4df2b8b8300633192e1a268669f6f41a35@...2715...>
Reply-To: gert@...1296..., heiko@...515..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <7a2d9458fc1d32eab57f5b58145eb6d607036e2b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Frz/TQwe/c0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, selvanair <selva.nair@...277...>
Cc: stipa <lstipakov@...277...>, d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Frz/TQwe/c0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/31=
2?usp=3Demail )

Change subject: Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant
......................................................................

Make cert_data.h and test_cryptoapi/pkcs11.c MSVC compliant

- Do not use non-literal initializers for static objects
- Replace empty initializer {} by {0}

Change-Id: Ifb961a4df2b8b8300633192e1a268669f6f41a35
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Heiko Hund <heiko@...515...>
Acked-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Co-authored-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20230922160405.167057-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
084.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/cert_data.h
M tests/unit_tests/openvpn/test_cryptoapi.c
2 files changed, 20 insertions(+), 10 deletions(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-MessageType: merged

--Frz/TQwe/c0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/312?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Make cert_data.h and test_cryptoapi/pkcs11.c M=
SVC compliant<br><br>- Do not use non-literal initializers for static objec=
ts<br>- Replace empty initializer {} by {0}<br><br>Change-Id: Ifb961a4df2b8=
b8300633192e1a268669f6f41a35<br>Signed-off-by: Selva Nair &lt;selva.nair@...1186...=
.277...&gt;<br>Acked-by: Heiko Hund &lt;heiko@...515...&gt;<br>Acked-by: Se=
lva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Lev Stipakov &lt;lstipak=
ov@...277...&gt;<br>Co-authored-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: =
&lt;20230922160405.167057-1-frank@...2641...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg27084.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openv=
pn/cert_data.h<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>2 files ch=
anged, 20 insertions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/cert_data.h b/tests/unit_tests/ope=
nvpn/cert_data.h</span><br><span>index 33de35e..0886b07 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/cert_data.h</span><br><span>+++ b/tests/=
unit_tests/openvpn/cert_data.h</span><br><span>@@ -79,7 +79,7 @@</span><br>=
<span>     &quot;HeTsAlHjfFEReVDiNCI9vMQLKFKKWnAorT2+iyRueA3bt2gchf863BBhZv=
JddL7Q\n&quot;</span><br><span>     &quot;KBa0osXw+eGBRAwsm7m1qCho3b3fN2nFA=
a+k07ptRkOeablmFdXE81nVlA=3D=3D\n&quot;</span><br><span>     &quot;-----END=
 CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static const char *const key2 =3D key1;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#define key2 key1</span><br><span> static const ch=
ar *const hash2 =3D &quot;FA18FD34BAABE47D6E2910E080F421C109CA97F5&quot;;</=
span><br><span> static const char *const cname2 =3D &quot;ovpn-test-ec2&quo=
t;;</span><br><span> </span><br><span>@@ -159,8 +159,8 @@</span><br><span> =
    &quot;353PpJJ9s2b/Fqoc4d7udqhQogA7jqbayTKhJxbT134l2NzqDROzuS0kXbX8bXCi\=
n&quot;</span><br><span>     &quot;mXSa4c8=3D\n&quot;</span><br><span>     =
&quot;-----END CERTIFICATE-----\n&quot;;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-static const char *const key4 =3D key3;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define key4 key3</span><br><span> s=
tatic const char *const hash4 =3D &quot;E1401D4497C944783E3D62CDBD2A1F69F5E=
5071E&quot;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-static co=
nst char *const cname4 =3D cname3; /* same CN as that of cert3 */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define cname4 cname3 /* same=
 CN as that of cert3 */</span><br><span> </span><br><span> #endif /* CERT_D=
ATA_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/test_cryptoa=
pi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>index e64a=
1de..0859b58 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_cry=
ptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryptoapi.c</s=
pan><br><span>@@ -104,17 +104,26 @@</span><br><span>     const char *const =
friendly_name;    /* identifies certs loaded to the store -- keep unique */=
</span><br><span>     const char *hash;                   /* SHA1 fingerpri=
nt */</span><br><span>     int valid;                          /* nonzero i=
f certificate has not expired */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-} certs[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {cert1,  key1,  cname1,  &quot;OVPN TEST CA1&quot;,  &quot;OVPN Te=
st Cert 1&quot;,  hash1,  1},</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    {cert2,  key2,  cname2,  &quot;OVPN TEST CA2&quot;,  &quot;OVPN=
 Test Cert 2&quot;,  hash2,  1},</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    {cert3,  key3,  cname3,  &quot;OVPN TEST CA1&quot;,  &quot;O=
VPN Test Cert 3&quot;,  hash3,  1},</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {cert4,  key4,  cname4,  &quot;OVPN TEST CA2&quot;,  &quo=
t;OVPN Test Cert 4&quot;,  hash4,  0},</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} certs[5];</sp=
an><br><span> </span><br><span> static bool certs_loaded;</span><br><span> =
static HCERTSTORE user_store;</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* Fill-in certs[] array */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+init_cert_data()</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct test_cert certs_local[] =3D {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {cert1,  key1,  cname1,  &quot;OVPN TEST CA1&q=
uot;,  &quot;OVPN Test Cert 1&quot;,  hash1,  1},</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {cert2,  key2,  cname2,  &quot;OVPN T=
EST CA2&quot;,  &quot;OVPN Test Cert 2&quot;,  hash2,  1},</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {cert3,  key3,  cname3,  &qu=
ot;OVPN TEST CA1&quot;,  &quot;OVPN Test Cert 3&quot;,  hash3,  1},</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {cert4,  key4,  cna=
me4,  &quot;OVPN TEST CA2&quot;,  &quot;OVPN Test Cert 4&quot;,  hash4,  0}=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {0}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert(sizeof(certs_local) =3D=3D s=
izeof(certs));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
emcpy(certs, certs_local, sizeof(certs_local));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> /* Lookup a certificate in our certificate/key =
db */</span><br><span> static struct test_cert *</span><br><span> lookup_ce=
rt(const char *friendly_name)</span><br><span>@@ -136,6 +145,7 @@</span><br=
><span>     {</span><br><span>         return;</span><br><span>     }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    init_cert_data();</sp=
an><br><span>     user_store =3D CertOpenStore(CERT_STORE_PROV_SYSTEM, 0, 0=
, CERT_SYSTEM_STORE_CURRENT_USER</span><br><span>                          =
      |CERT_STORE_OPEN_EXISTING_FLAG, L&quot;MY&quot;);</span><br><span>   =
  assert_non_null(user_store);</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/312?usp=3Demail">ch=
ange 312</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/312?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb961a4df2b8b8300633192e1a2=
68669f6f41a35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 312 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Frz/TQwe/c0=--

