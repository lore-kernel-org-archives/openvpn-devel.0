From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 26 Mar 2026 14:18:59 +0000
In-Reply-To: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
References: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <291dfddf3fbbce1d2b9587f7b49343cb805c4617-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mvODuSiuv5k="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Use const
 specifices in extract_x509_field_ssl
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mvODuSiuv5k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
88?usp=3Demail )

Change subject: Use const specifices in extract_x509_field_ssl
......................................................................

Use const specifices in extract_x509_field_ssl

The new OpenSSL 4.0 will return const objects from these objects, so
make them const in our code as well.

Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1588
Message-Id: <20260326110658.25741-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
291.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 2 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index d96879b..08946cd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -195,8 +195,6 @@
 {
     int lastpos =3D -1;
     int tmp =3D -1;
-    X509_NAME_ENTRY *x509ne =3D NULL;
-    ASN1_STRING *asn1 =3D NULL;
     unsigned char *buf =3D NULL;

     ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
@@ -222,13 +220,13 @@
         return FAILURE;
     }

-    x509ne =3D X509_NAME_get_entry(x509, lastpos);
+    const X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);
     if (!x509ne)
     {
         return FAILURE;
     }

-    asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
+    const ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
         return FAILURE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Gerrit-Change-Number: 1588
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mvODuSiuv5k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1588?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Use const specifices in extract_x509_field_ssl<b=
r><br>The new OpenSSL 4.0 will return const objects from these objects, so<=
br>make them const in our code as well.<br><br>Change-Id: Ia43bb88d9ddf2e82=
c638011353a64c770f2c2c0a<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...=
&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit URL:=
 https://gerrit.openvpn.net/c/openvpn/+/1588<br>Message-Id: &lt;20260326110=
658.25741-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvp=
n-devel@lists.sourceforge.net/msg36291.html<br>Signed-off-by: Gert Doering =
&lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<br>1 f=
ile changed, 2 insertions(+), 4 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c</span><br><span>index d96879b..08946cd 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_openssl.c</span><br><span>@@ -195,8 +195,6 @@</span><br><span> {</span=
><br><span>     int lastpos =3D -1;</span><br><span>     int tmp =3D -1;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    X509_NAME_ENTRY *x50=
9ne =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASN1=
_STRING *asn1 =3D NULL;</span><br><span>     unsigned char *buf =3D NULL;</=
span><br><span> </span><br><span>     ASN1_OBJECT *field_name_obj =3D OBJ_t=
xt2obj(field_name, 0);</span><br><span>@@ -222,13 +220,13 @@</span><br><spa=
n>         return FAILURE;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    x509ne =3D X509_NAME_get_=
entry(x509, lastpos);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const X509_NAME_ENTRY *x509ne =3D X509_NAME_get_entry(x509, lastpos);=
</span><br><span>     if (!x509ne)</span><br><span>     {</span><br><span> =
        return FAILURE;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    asn1 =3D X509_NAME_ENTRY_get=
_data(x509ne);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst ASN1_STRING *asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</span><br><spa=
n>     if (!asn1)</span><br><span>     {</span><br><span>         return FA=
ILURE;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail">change 1588</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1588?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a=
64c770f2c2c0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1588 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--mvODuSiuv5k=--

