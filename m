From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 4 Apr 2026 20:18:47 +0000
In-Reply-To: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
References: <gerrit.1774445432000.I5158fbb0762443ea4954e5745f520e83e019ed30@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e50492cc9bea1ba544c6ebf6f4e83c13a9ae3d42-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Cn1w6P8Qthw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Cn1w6P8Qthw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

cron2 has uploaded a new patch set (#7) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1589?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Do not access internals of ASN1_INTEGER to print hex of ser=
ial
......................................................................

Do not access internals of ASN1_INTEGER to print hex of serial

OpenSSL 4.0 does not allow internal access to to these data structures
anymore. So use public methods to get the serial data and convert it to
hex.

Change-Id: I5158fbb0762443ea4954e5745f520e83e019ed30
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1589
Message-Id: <20260404155726.7696-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
459.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 16 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1589/7

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 96ca1a4..115b8d2 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -260,17 +260,19 @@
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
@@ -315,8 +317,16 @@
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
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Cn1w6P8Qthw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1589?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Do not access internals of A=
SN1_INTEGER to print hex of serial<br><br>OpenSSL 4.0 does not allow intern=
al access to to these data structures<br>anymore. So use public methods to =
get the serial data and convert it to<br>hex.<br><br>Change-Id: I5158fbb076=
2443ea4954e5745f520e83e019ed30<br>Signed-off-by: Arne Schwabe &lt;arne@...1386...=
227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerri=
t URL: https://gerrit.openvpn.net/c/openvpn/+/1589<br>Message-Id: &lt;20260=
404155726.7696-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg36459.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<b=
r>1 file changed, 16 insertions(+), 6 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1589/7<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_ver=
ify_openssl.c</span><br><span>index 96ca1a4..115b8d2 100644</span><br><span=
>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/s=
sl_verify_openssl.c</span><br><span>@@ -260,17 +260,19 @@</span><br><span> =
    }</span><br><span>     else if (strcmp(LN_serialNumber, x509_username_f=
ield) =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(pee=
r_cert);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        struc=
t gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        char *serial =3D format_hex_ex(ASN1_STRING_get0_data(asn1_i),=
 ASN1_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &amp;gc);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const ASN1_INTEGER *asn1_=
i =3D X509_get_serialNumber(peer_cert);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        char *serial =3D BN_bn=
2hex(bn_serial);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     BN_free(bn_serial);</span><br><span> </span><br><span>         if (!se=
rial || cn_len &lt;=3D strlen(serial) + 2)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            gc_free(&amp;gc=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            OPENS=
SL_free(serial);</span><br><span>             return FAILURE;</span><br><sp=
an>         }</span><br><span>         snprintf(common_name, cn_len, &quot;=
0x%s&quot;, serial);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        OPENSSL_free(serial);</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>@@ -315,8 +317,16 @@</span>=
<br><span> backend_x509_get_serial_hex(openvpn_x509_cert_t *cert, struct gc=
_arena *gc)</span><br><span> {</span><br><span>     const ASN1_INTEGER *asn=
1_i =3D X509_get_serialNumber(cert);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    BIGNUM *bn_serial =3D ASN1_INTEGER_to_BN(asn1_i, NULL)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len_serial=
 =3D BN_num_bytes(bn_serial);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    unsigned char *buf =3D malloc(len_serial);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    BN_bn2binpad(bn_serial, buf, len_s=
erial);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_len=
gth(asn1_i), 0, 1, &quot;:&quot;, gc);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    char *ret =3D format_hex_ex(buf, len_serial, 0, 1, &=
quot;:&quot;, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   free(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    BN=
_free(bn_serial);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span=
><br><span> }</span><br><span> </span><br><span> result_t</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1589?usp=3Demail">change 1589</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1589?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I5158fbb0762443ea4954e5745f5=
20e83e019ed30 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1589 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--Cn1w6P8Qthw=--

