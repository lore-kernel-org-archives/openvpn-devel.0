From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Mar 2026 14:06:55 +0000
In-Reply-To: <gerrit.1774267774000.I8adffc3152b5b502a820a8ae0f901717e4831f81@...2715...>
References: <gerrit.1774267774000.I8adffc3152b5b502a820a8ae0f901717e4831f81@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a502029fb6fdfe617cc82f9a402bd2294405fb32-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6iN3+6ajaBk="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: ssl_verify_openssl:
 use official ASN1_STRING_ API
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

--6iN3+6ajaBk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
84?usp=3Demail )

Change subject: ssl_verify_openssl: use official ASN1_STRING_ API
......................................................................

ssl_verify_openssl: use official ASN1_STRING_ API

ASN1_STRING are now opaque types in OpenSSL 4.x =E2=80=94 the internal data=
 and
length fields are no longer directly accessible. Use the accessor API
instead. Accessors have been available since OpenSSL 1.1.0

The ASN1_STRING_length accessor is already in use, but not consistently
applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0_data
which allows for successful build of OpenSSL 4.x

Change-Id: I8adffc3152b5b502a820a8ae0f901717e4831f81
Signed-off-by: Rudi Heitbaum <rudi@...2993...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1584
Message-Id: <20260323121908.730-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
254.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 4 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 46401cd..d96879b 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -259,7 +259,7 @@
     {
         ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer_cert);
         struct gc_arena gc =3D gc_new();
-        char *serial =3D format_hex_ex(asn1_i->data, asn1_i->length, 0, 1 =
| FHE_CAPS, NULL, &gc);
+        char *serial =3D format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1=
_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &gc);

         if (!serial || cn_len <=3D strlen(serial) + 2)
         {
@@ -313,7 +313,7 @@
 {
     const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);

-    return format_hex_ex(asn1_i->data, asn1_i->length, 0, 1, ":", gc);
+    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length=
(asn1_i), 0, 1, ":", gc);
 }

 result_t
@@ -626,7 +626,7 @@
         {
             ASN1_BIT_STRING *ns;
             ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NUL=
L, NULL);
-            result =3D (ns && ns->length > 0 && (ns->data[0] & NS_SSL_CLIE=
NT)) ? SUCCESS : FAILURE;
+            result =3D (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_g=
et0_data(ns)[0] & NS_SSL_CLIENT)) ? SUCCESS : FAILURE;
             if (result =3D=3D SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a client certificate yet=
 it's purpose "
@@ -654,7 +654,7 @@
         {
             ASN1_BIT_STRING *ns;
             ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NUL=
L, NULL);
-            result =3D (ns && ns->length > 0 && (ns->data[0] & NS_SSL_SERV=
ER)) ? SUCCESS : FAILURE;
+            result =3D (ns && ASN1_STRING_length(ns) > 0 && (ASN1_STRING_g=
et0_data(ns)[0] & NS_SSL_SERVER)) ? SUCCESS : FAILURE;
             if (result =3D=3D SUCCESS)
             {
                 msg(M_WARN, "X509: Certificate is a server certificate yet=
 it's purpose "

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1584?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8adffc3152b5b502a820a8ae0f901717e4831f81
Gerrit-Change-Number: 1584
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6iN3+6ajaBk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1584?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_verify_openssl: use official ASN1_STRING_ AP=
I<br><br>ASN1_STRING are now opaque types in OpenSSL 4.x =E2=80=94 the inte=
rnal data and<br>length fields are no longer directly accessible. Use the a=
ccessor API<br>instead. Accessors have been available since OpenSSL 1.1.0<b=
r><br>The ASN1_STRING_length accessor is already in use, but not consistent=
ly<br>applied. Standardise on using ASN1_STRING_length and ASN1_STRING_get0=
_data<br>which allows for successful build of OpenSSL 4.x<br><br>Change-Id:=
 I8adffc3152b5b502a820a8ae0f901717e4831f81<br>Signed-off-by: Rudi Heitbaum =
&lt;rudi@...2993...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2639...=
..&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1584<br>Messag=
e-Id: &lt;20260323121908.730-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg36254.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_veri=
fy_openssl.c<br>1 file changed, 4 insertions(+), 4 deletions(-)<br><br></pr=
e>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c</span><br><span>index 46401cd..d96879b 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_openssl.c</span><br><span>@@ -259,7 +259,7 @@</span><br><span>     {</=
span><br><span>         ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(peer=
_cert);</span><br><span>         struct gc_arena gc =3D gc_new();</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        char *serial =3D format=
_hex_ex(asn1_i-&gt;data, asn1_i-&gt;length, 0, 1 | FHE_CAPS, NULL, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        char *seri=
al =3D format_hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1=
_i), 0, 1 | FHE_CAPS, NULL, &amp;gc);</span><br><span> </span><br><span>   =
      if (!serial || cn_len &lt;=3D strlen(serial) + 2)</span><br><span>   =
      {</span><br><span>@@ -313,7 +313,7 @@</span><br><span> {</span><br><s=
pan>     const ASN1_INTEGER *asn1_i =3D X509_get_serialNumber(cert);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 format_hex_ex(asn1_i-&gt;data, asn1_i-&gt;length, 0, 1, &quot;:&quot;, gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return format_=
hex_ex(ASN1_STRING_get0_data(asn1_i), ASN1_STRING_length(asn1_i), 0, 1, &qu=
ot;:&quot;, gc);</span><br><span> }</span><br><span> </span><br><span> resu=
lt_t</span><br><span>@@ -626,7 +626,7 @@</span><br><span>         {</span><=
br><span>             ASN1_BIT_STRING *ns;</span><br><span>             ns =
=3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            result =3D (ns &=
amp;&amp; ns-&gt;length &gt; 0 &amp;&amp; (ns-&gt;data[0] &amp; NS_SSL_CLIE=
NT)) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            result =3D (ns &amp;&amp; ASN1_STRING_length(ns) &gt; 0 &=
amp;&amp; (ASN1_STRING_get0_data(ns)[0] &amp; NS_SSL_CLIENT)) ? SUCCESS : F=
AILURE;</span><br><span>             if (result =3D=3D SUCCESS)</span><br><=
span>             {</span><br><span>                 msg(M_WARN, &quot;X509=
: Certificate is a client certificate yet it&#39;s purpose &quot;</span><br=
><span>@@ -654,7 +654,7 @@</span><br><span>         {</span><br><span>     =
        ASN1_BIT_STRING *ns;</span><br><span>             ns =3D X509_get_e=
xt_d2i(peer_cert, NID_netscape_cert_type, NULL, NULL);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            result =3D (ns &amp;&amp; ns-&=
gt;length &gt; 0 &amp;&amp; (ns-&gt;data[0] &amp; NS_SSL_SERVER)) ? SUCCESS=
 : FAILURE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    result =3D (ns &amp;&amp; ASN1_STRING_length(ns) &gt; 0 &amp;&amp; (ASN=
1_STRING_get0_data(ns)[0] &amp; NS_SSL_SERVER)) ? SUCCESS : FAILURE;</span>=
<br><span>             if (result =3D=3D SUCCESS)</span><br><span>         =
    {</span><br><span>                 msg(M_WARN, &quot;X509: Certificate =
is a server certificate yet it&#39;s purpose &quot;</span><br><span></span>=
<br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1584?usp=3Demail">change 1584</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
584?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8adffc3152b5b502a820a8ae0f9=
01717e4831f81 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1584 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--6iN3+6ajaBk=--

