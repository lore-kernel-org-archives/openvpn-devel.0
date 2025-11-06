From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 6 Nov 2025 13:34:44 +0000
References: <gerrit.1762436081000.I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bfc22abde3b948468966fdb1b65c484546dff339-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="otij2s7Dsfg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: pkcs11_openssl:
 Silence a conversion warning
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

--otij2s7Dsfg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3Demail

to review the following change.


Change subject: pkcs11_openssl: Silence a conversion warning
......................................................................

pkcs11_openssl: Silence a conversion warning

The only caller of this function uses a constant
for this parameter, so this is all quite safe. Add
an ASSERT for good measure anyway to make the assumption
explicit.

Change-Id: I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/pkcs11_openssl.c
1 file changed, 2 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/1352/1

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index f619b95..1d527db 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -428,18 +428,12 @@
     return dn;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 pkcs11_certificate_serial(pkcs11h_certificate_t certificate, char *serial,=
 size_t serial_len)
 {
     X509 *x509 =3D NULL;
     BIO *bio =3D NULL;
     int ret =3D 1;
-    int n;

     if ((x509 =3D pkcs11h_openssl_getX509(certificate)) =3D=3D NULL)
     {
@@ -454,7 +448,8 @@
     }

     i2a_ASN1_INTEGER(bio, X509_get_serialNumber(x509));
-    n =3D BIO_read(bio, serial, serial_len - 1);
+    ASSERT(serial_len <=3D INT_MAX);
+    int n =3D BIO_read(bio, serial, (int)serial_len - 1);

     if (n < 0)
     {
@@ -474,8 +469,4 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #endif /* defined(ENABLE_PKCS11) && defined(ENABLE_OPENSSL) */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995
Gerrit-Change-Number: 1352
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--otij2s7Dsfg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">pkcs11_openssl: Silence a conversion warnin=
g<br><br>The only caller of this function uses a constant<br>for this param=
eter, so this is all quite safe. Add<br>an ASSERT for good measure anyway t=
o make the assumption<br>explicit.<br><br>Change-Id: I6079bf9e7f6b37cb2e2d7=
f28851a77d0b08be995<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>M src/openvpn/pkcs11_openssl.c<br>1 file changed, 2 inserti=
ons(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/52/1352/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c</span><br><span>index =
f619b95..1d527db 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl.c<=
/span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</span><br><span>@@ -428,=
18 +428,12 @@</span><br><span>     return dn;</span><br><span> }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__=
GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> pkc=
s11_certificate_serial(pkcs11h_certificate_t certificate, char *serial, siz=
e_t serial_len)</span><br><span> {</span><br><span>     X509 *x509 =3D NULL=
;</span><br><span>     BIO *bio =3D NULL;</span><br><span>     int ret =3D =
1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int n;</span><b=
r><span> </span><br><span>     if ((x509 =3D pkcs11h_openssl_getX509(certif=
icate)) =3D=3D NULL)</span><br><span>     {</span><br><span>@@ -454,7 +448,=
8 @@</span><br><span>     }</span><br><span> </span><br><span>     i2a_ASN1=
_INTEGER(bio, X509_get_serialNumber(x509));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    n =3D BIO_read(bio, serial, serial_len - 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(serial_len &l=
t;=3D INT_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int n =3D BIO_read(bio, serial, (int)serial_len - 1);</span><br><span> </sp=
an><br><span>     if (n &lt; 0)</span><br><span>     {</span><br><span>@@ -=
474,8 +469,4 @@</span><br><span>     return ret;</span><br><span> }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> #endif /* defined(ENABLE_PKCS11) &amp;&amp; defined(ENAB=
LE_OPENSSL) */</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3Demail">change 1352</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6079bf9e7f6b37cb2e2d7f28851=
a77d0b08be995 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1352 </div>
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

--otij2s7Dsfg=--

