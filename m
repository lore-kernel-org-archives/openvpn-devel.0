From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 8 Nov 2025 22:59:43 +0000
In-Reply-To: <gerrit.1762436081000.I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995@...2715...>
References: <gerrit.1762436081000.I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <32038c69d9a057aa6263de50744e829aefa1cf9e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="w5XYO/+/QL4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w5XYO/+/QL4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
52?usp=3Demail )

Change subject: pkcs11_openssl: Silence a conversion warning
......................................................................

pkcs11_openssl: Silence a conversion warning

The only caller of this function uses a constant
for this parameter, so this is all quite safe. Add
an ASSERT for good measure anyway to make the assumption
explicit.

Change-Id: I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1352
Message-Id: <20251106133936.30264-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
209.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/pkcs11_openssl.c
1 file changed, 2 insertions(+), 11 deletions(-)




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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6079bf9e7f6b37cb2e2d7f28851a77d0b08be995
Gerrit-Change-Number: 1352
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--w5XYO/+/QL4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1352?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">pkcs11_openssl: Silence a conversion warning<br>=
<br>The only caller of this function uses a constant<br>for this parameter,=
 so this is all quite safe. Add<br>an ASSERT for good measure anyway to mak=
e the assumption<br>explicit.<br><br>Change-Id: I6079bf9e7f6b37cb2e2d7f2885=
1a77d0b08be995<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;=
<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://g=
errit.openvpn.net/c/openvpn/+/1352<br>Message-Id: &lt;20251106133936.30264-=
1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg34209.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpn/pkcs11_openssl.c<br>1 file changed, 2=
 insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c=
</span><br><span>index f619b95..1d527db 100644</span><br><span>--- a/src/op=
envpn/pkcs11_openssl.c</span><br><span>+++ b/src/openvpn/pkcs11_openssl.c</=
span><br><span>@@ -428,18 +428,12 @@</span><br><span>     return dn;</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
int</span><br><span> pkcs11_certificate_serial(pkcs11h_certificate_t certif=
icate, char *serial, size_t serial_len)</span><br><span> {</span><br><span>=
     X509 *x509 =3D NULL;</span><br><span>     BIO *bio =3D NULL;</span><br=
><span>     int ret =3D 1;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int n;</span><br><span> </span><br><span>     if ((x509 =3D pkcs11=
h_openssl_getX509(certificate)) =3D=3D NULL)</span><br><span>     {</span><=
br><span>@@ -454,7 +448,8 @@</span><br><span>     }</span><br><span> </span=
><br><span>     i2a_ASN1_INTEGER(bio, X509_get_serialNumber(x509));</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    n =3D BIO_read(bio, seria=
l, serial_len - 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    ASSERT(serial_len &lt;=3D INT_MAX);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    int n =3D BIO_read(bio, serial, (int)serial_len - 1=
);</span><br><span> </span><br><span>     if (n &lt; 0)</span><br><span>   =
  {</span><br><span>@@ -474,8 +469,4 @@</span><br><span>     return ret;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span> #endif /* defined(ENABLE_PKCS11)=
 &amp;&amp; defined(ENABLE_OPENSSL) */</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3D=
email">change 1352</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1352?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6079bf9e7f6b37cb2e2d7f28851=
a77d0b08be995 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1352 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--w5XYO/+/QL4=--

