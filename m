From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Mar 2026 14:06:53 +0000
In-Reply-To: <gerrit.1774267774000.I8adffc3152b5b502a820a8ae0f901717e4831f81@...2715...>
References: <gerrit.1774267774000.I8adffc3152b5b502a820a8ae0f901717e4831f81@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a502029fb6fdfe617cc82f9a402bd2294405fb32-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qRAJcMuIaTU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qRAJcMuIaTU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1584?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/1584/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8adffc3152b5b502a820a8ae0f901717e4831f81
Gerrit-Change-Number: 1584
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qRAJcMuIaTU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1584?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl_verify_openssl: use officia=
l ASN1_STRING_ API<br><br>ASN1_STRING are now opaque types in OpenSSL 4.x =
=E2=80=94 the internal data and<br>length fields are no longer directly acc=
essible. Use the accessor API<br>instead. Accessors have been available sin=
ce OpenSSL 1.1.0<br><br>The ASN1_STRING_length accessor is already in use, =
but not consistently<br>applied. Standardise on using ASN1_STRING_length an=
d ASN1_STRING_get0_data<br>which allows for successful build of OpenSSL 4.x=
<br><br>Change-Id: I8adffc3152b5b502a820a8ae0f901717e4831f81<br>Signed-off-=
by: Rudi Heitbaum &lt;rudi@...2993...&gt;<br>Acked-by: Arne Schwabe &lt;arn=
e-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvp=
n/+/1584<br>Message-Id: &lt;20260323121908.730-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36254=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpn/ssl_verify_openssl.c<br>1 file changed, 4 insertions(+), 4 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/84/1584/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_o=
penssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 46401cd..=
d96879b 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span=
><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -259,7=
 +259,7 @@</span><br><span>     {</span><br><span>         ASN1_INTEGER *as=
n1_i =3D X509_get_serialNumber(peer_cert);</span><br><span>         struct =
gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        char *serial =3D format_hex_ex(asn1_i-&gt;data, asn1_i-&gt;leng=
th, 0, 1 | FHE_CAPS, NULL, &amp;gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        char *serial =3D format_hex_ex(ASN1_STRING_get0_da=
ta(asn1_i), ASN1_STRING_length(asn1_i), 0, 1 | FHE_CAPS, NULL, &amp;gc);</s=
pan><br><span> </span><br><span>         if (!serial || cn_len &lt;=3D strl=
en(serial) + 2)</span><br><span>         {</span><br><span>@@ -313,7 +313,7=
 @@</span><br><span> {</span><br><span>     const ASN1_INTEGER *asn1_i =3D =
X509_get_serialNumber(cert);</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    return format_hex_ex(asn1_i-&gt;data, asn1_i-&=
gt;length, 0, 1, &quot;:&quot;, gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return format_hex_ex(ASN1_STRING_get0_data(asn1_i), AS=
N1_STRING_length(asn1_i), 0, 1, &quot;:&quot;, gc);</span><br><span> }</spa=
n><br><span> </span><br><span> result_t</span><br><span>@@ -626,7 +626,7 @@=
</span><br><span>         {</span><br><span>             ASN1_BIT_STRING *n=
s;</span><br><span>             ns =3D X509_get_ext_d2i(peer_cert, NID_nets=
cape_cert_type, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            result =3D (ns &amp;&amp; ns-&gt;length &gt; 0 &amp;&amp=
; (ns-&gt;data[0] &amp; NS_SSL_CLIENT)) ? SUCCESS : FAILURE;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            result =3D (ns &amp;&a=
mp; ASN1_STRING_length(ns) &gt; 0 &amp;&amp; (ASN1_STRING_get0_data(ns)[0] =
&amp; NS_SSL_CLIENT)) ? SUCCESS : FAILURE;</span><br><span>             if =
(result =3D=3D SUCCESS)</span><br><span>             {</span><br><span>    =
             msg(M_WARN, &quot;X509: Certificate is a client certificate ye=
t it&#39;s purpose &quot;</span><br><span>@@ -654,7 +654,7 @@</span><br><sp=
an>         {</span><br><span>             ASN1_BIT_STRING *ns;</span><br><=
span>             ns =3D X509_get_ext_d2i(peer_cert, NID_netscape_cert_type=
, NULL, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     result =3D (ns &amp;&amp; ns-&gt;length &gt; 0 &amp;&amp; (ns-&gt;data=
[0] &amp; NS_SSL_SERVER)) ? SUCCESS : FAILURE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            result =3D (ns &amp;&amp; ASN1_STRIN=
G_length(ns) &gt; 0 &amp;&amp; (ASN1_STRING_get0_data(ns)[0] &amp; NS_SSL_S=
ERVER)) ? SUCCESS : FAILURE;</span><br><span>             if (result =3D=3D=
 SUCCESS)</span><br><span>             {</span><br><span>                 m=
sg(M_WARN, &quot;X509: Certificate is a server certificate yet it&#39;s pur=
pose &quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1584?usp=3Demail">change 1584</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1584?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--qRAJcMuIaTU=--

