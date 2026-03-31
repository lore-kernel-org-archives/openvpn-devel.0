From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 16:24:02 +0000
In-Reply-To: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
References: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <7aab1892181f4b58d6447e4aa12fb6460ec34256-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nr5IAMbk4Qg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not access
 internals of ASN1_INTEGER to print hex of serial
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nr5IAMbk4Qg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded a new patch set (#2). ( http://gerrit.openvpn.net/c/=
openvpn/+/1589?usp=3Demail )


Change subject: Do not access internals of ASN1_INTEGER to print hex of ser=
ial
......................................................................

Do not access internals of ASN1_INTEGER to print hex of serial

OpenSSL 4.0 does not allow internal access to to these data structures
anymore. So use public methods to get the serial data and convert it to
hex.

Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 16 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1589/2

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 367f81a..558f004 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -255,17 +255,19 @@
     }
     else if (strcmp(LN_serialNumber, x509_username_field) =3D=3D 0)
     {
-        ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer_cert);
-        struct gc_arena gc =3D gc_new();
-        char *serial =3D format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1=
_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &gc);
+        const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer_cert);
+
+        BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);
+        char *serial =3D BN_bn2hex(bn_serial);
+        BN_free(bn_serial);

         if (!serial || cn_len <=3D strlen(serial) + 2)
         {
-            gc_free(&gc);
+            OPENSSL_free(serial);
             return FAILURE;
         }
         snprintf(common_name, cn_len, "0x%s", serial);
-        gc_free(&gc);
+        OPENSSL_free(serial);
     }
     else
     {
@@ -310,8 +312,16 @@
 backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
     const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);
+    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);
+    int len_serial =3D BN_num_bytes(bn_serial);
+    unsigned char *buf =3D malloc(len_serial);
+    BN_bn2binpad(bn_serial, buf, len_serial);

-    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length=
(asn1_i), 0, 1, ":", gc);
+    char *ret =3D format_hex_ex(buf, len_serial, 0, 1, ":", gc);
+    free(buf);
+    BN_free(bn_serial);
+
+    return ret;
 }

 result_t

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1589?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Gerrit-Change-Number: 1589
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--nr5IAMbk4Qg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos <strong=
>uploaded patch set #2</strong> to this change.</p><p><a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1589?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Do not access internals of ASN1_INTEGER to print hex of serial<br><br>O=
penSSL 4.0 does not allow internal access to to these data structures<br>an=
ymore. So use public methods to get the serial data and convert it to<br>he=
x.<br><br>Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30<br>Signed-of=
f-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_veri=
fy_openssl.c<br>1 file changed, 16 insertions(+), 6 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/89/1589/2</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/op=
envpn/ssl_verify_openssl.c</span><br><span>index 367f81a..558f004 100644</s=
pan><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/=
src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -255,17 +255,19 @@</spa=
n><br><span>     }</span><br><span>     else if (strcmp(LN_serialNumber, x5=
09_username_field) =3D=3D 0)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASN1_INTEGER *asn1_i =3D X509_get_s=
erialNumber(peer_cert);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        char *serial =3D format_hex_ex(ASN1_STRING_get=
0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const ASN1=
_INTEGER *asn1_i =3D X509_get_serialNumber(peer_cert);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *s=
erial =3D BN_bn2hex(bn_serial);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        BN_free(bn_serial);</span><br><span> </span><br><span> =
        if (!serial || cn_len &lt;=3D strlen(serial) + 2)</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          OPENSSL_free(serial);</span><br><span>             return FAILURE=
;</span><br><span>         }</span><br><span>         snprintf(common_name,=
 cn_len, &quot;0x%s&quot;, serial);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        OPENSSL_free(serial);</span><br><span>     }</s=
pan><br><span>     else</span><br><span>     {</span><br><span>@@ -310,8 +3=
12,16 @@</span><br><span> backend_x509_get_serial_hex(openvpn_x509_cert_t *=
cert, struct gc_arena *gc)</span><br><span> {</span><br><span>     const AS=
N1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    BIGNUM *bn_serial =3D ASN1_INTEGER_to=
_BN(asn1_i, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int len_serial =3D BN_num_bytes(bn_serial);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unsigned char *buf =3D malloc(len_serial);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BN_bn2binpad(bn_s=
erial, buf, len_serial);</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return format_hex_ex(ASN1_STRING_get0_data(asn1_i)=
, ASN1_STRING_length(asn1_i), 0, 1, &quot;:&quot;, gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char *ret =3D format_hex_ex(buf, le=
n_serial, 0, 1, &quot;:&quot;, gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    free(buf);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    BN_free(bn_serial);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
return ret;</span><br><span> }</span><br><span> </span><br><span> result_t<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1589?usp=3Demail">change 1589</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1589?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5158fbb0762443ea4954e5745f5=
20e83e019ed30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1589 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--nr5IAMbk4Qg=--

