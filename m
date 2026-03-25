From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 15:08:18 +0000
In-Reply-To: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
References: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ab66cd904a2b2e41cd5d4c2f35cc3b6c49f8246c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TFIfNn2mhY4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TFIfNn2mhY4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Use const specifices in  extract_x509_field_ssl
......................................................................

Use const specifices in  extract_x509_field_ssl

The new OpenSSL 4.0 will return const objects from these objects, so
make them const in our code as well.

Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 2 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1588/2

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 46401cd..4c492a3 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Gerrit-Change-Number: 1588
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--TFIfNn2mhY4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Use const specifices in  ext=
ract_x509_field_ssl<br><br>The new OpenSSL 4.0 will return const objects fr=
om these objects, so<br>make them const in our code as well.<br><br>Change-=
Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a<br>Signed-off-by: Arne Schwab=
e &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<br>1=
 file changed, 2 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1588/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c</span><br><span>index 46401cd..4c492a3 100644</span><br><span>--- =
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

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a=
64c770f2c2c0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1588 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--TFIfNn2mhY4=--

