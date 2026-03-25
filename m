From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 13:30:38 +0000
References: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <b470f6534134b90a6881a9a11ce19ceaed0e77ec-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZlWhPTHXSlg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: [WIP] Do not access
 interal of ASN1_INTEGER to print hex of serial
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZlWhPTHXSlg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1589?usp=3Demail )


Change subject: [WIP] Do not access interal of ASN1_INTEGER to print hex of=
 serial
......................................................................

[WIP] Do not access interal of ASN1_INTEGER to print hex of serial

OpenSSL 4.0 does not allow internal access to to these data structures
anymore. So use public methods to get the serial data and convert it to
hex.

TODO: check this does not change the output format
Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 17 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1589/1

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index f39f34a..7d37d17 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -255,17 +255,19 @@
     }
     else if (strcmp(LN_serialNumber, x509_username_field) =3D=3D 0)
     {
-        ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer_cert);
-        struct gc_arena gc =3D gc_new();
-        char *serial =3D format_hex_ex(asn1_i->data, asn1_i->length, 0, 1 =
| FHE_CAPS, NULL, &gc);
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
@@ -310,8 +312,17 @@
 backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)
 {
     const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);
+    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);
+    int len_serial =3D BN_num_bytes(bn_serial);
+    unsigned char *buf =3D malloc(len_serial);
+    BN_bn2binpad(bn_serial, buf, len_serial);

-    return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
+
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Gerrit-Change-Number: 1589
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZlWhPTHXSlg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1589?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">[WIP] Do not access interal of ASN1_INTEGER to print hex of serial<br><=
br>OpenSSL 4.0 does not allow internal access to to these data structures<b=
r>anymore. So use public methods to get the serial data and convert it to<b=
r>hex.<br><br>TODO: check this does not change the output format<br>Change-=
Id: I5158fbb0762443ea4954e5745f520e83e019ed30<br>Signed-off-by: Arne Schwab=
e &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<br>1=
 file changed, 17 insertions(+), 6 deletions(-)<br><br></pre><pre class=3D"=
blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1589/1</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_=
openssl.c</span><br><span>index f39f34a..7d37d17 100644</span><br><span>---=
 a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_v=
erify_openssl.c</span><br><span>@@ -255,17 +255,19 @@</span><br><span>     =
}</span><br><span>     else if (strcmp(LN_serialNumber, x509_username_field=
) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer_ce=
rt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct gc=
_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        char *serial =3D format_hex_ex(asn1_i-&gt;data, asn1_i-&gt;length=
, 0, 1 | FHE_CAPS, NULL, &amp;gc);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber=
(peer_cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        BIGNUM *bn_serial =
=3D ASN1_INTEGER_to_BN(asn1_i, NULL);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        char *serial =3D BN_bn2hex(bn_serial);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        BN_free(bn_serial);</s=
pan><br><span> </span><br><span>         if (!serial || cn_len &lt;=3D strl=
en(serial) + 2)</span><br><span>         {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            gc_free(&amp;gc);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            OPENSSL_free(serial);</span><br>=
<span>             return FAILURE;</span><br><span>         }</span><br><sp=
an>         snprintf(common_name, cn_len, &quot;0x%s&quot;, serial);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        OPENSSL_free(s=
erial);</span><br><span>     }</span><br><span>     else</span><br><span>  =
   {</span><br><span>@@ -310,8 +312,17 @@</span><br><span> backend_x509_get=
_serial_hex(openvpn_x509_cert_t *cert, struct gc_arena *gc)</span><br><span=
> {</span><br><span>     const ASN1_INTEGER *asn1_i =3D X509_get_serialNumb=
er(cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BIGNUM=
 *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    int len_serial =3D BN_num_bytes(bn_serial=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned char=
 *buf =3D malloc(len_serial);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    BN_bn2binpad(bn_serial, buf, len_serial);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return format_hex_e=
x(asn1_i-&gt;data, asn1_i-&gt;length, 0, 1, &quot;:&quot;, gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    char *ret =3D format_hex_ex(buf, len_serial, 0=
, 1, &quot;:&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    BN_free(bn_serial);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;=
</span><br><span> }</span><br><span> </span><br><span> result_t</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1589?usp=3Demail">change 1589</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1589?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5158fbb0762443ea4954e5745f5=
20e83e019ed30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1589 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ZlWhPTHXSlg=--

