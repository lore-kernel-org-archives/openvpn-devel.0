From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 25 Mar 2026 13:30:36 +0000
References: <gerrit.1774445432000.Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <e9d5f159a5d216613bfd5fbe71769a081b7ad10b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JLwnLXQXAIU="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JLwnLXQXAIU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1588?usp=3Demail )


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1588/1

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index fc14789..f39f34a 100644
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
+    const ASN1_STRING *asn1 =3D asn1 =3D X509_NAME_ENTRY_get_data(x509ne);
     if (!asn1)
     {
         return FAILURE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1588?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c0a
Gerrit-Change-Number: 1588
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JLwnLXQXAIU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1588?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Use const specifices in  extract_x509_field_ssl<br><br>The new OpenSSL =
4.0 will return const objects from these objects, so<br>make them const in =
our code as well.<br><br>Change-Id: Ia43bb88d9ddf2e82c638011353a64c770f2c2c=
0a<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/o=
penvpn/ssl_verify_openssl.c<br>1 file changed, 2 insertions(+), 4 deletions=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/88/1588/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_open=
ssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index fc14789..f39=
f34a 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><b=
r><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ -195,8 +1=
95,6 @@</span><br><span> {</span><br><span>     int lastpos =3D -1;</span><=
br><span>     int tmp =3D -1;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    X509_NAME_ENTRY *x509ne =3D NULL;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASN1_STRING *asn1 =3D NULL;</span><br><span>   =
  unsigned char *buf =3D NULL;</span><br><span> </span><br><span>     ASN1_=
OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);</span><br><span>@@ -=
222,13 +220,13 @@</span><br><span>         return FAILURE;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    x509ne =3D X509_NAME_get_entry(x509, lastpos);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const X509_NAME_ENTRY *x509ne =3D X50=
9_NAME_get_entry(x509, lastpos);</span><br><span>     if (!x509ne)</span><b=
r><span>     {</span><br><span>         return FAILURE;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    asn1 =3D X509_NAME_ENTRY_get_data(x509ne);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const ASN1_STRING *asn1 =3D asn1 =3D X509_NA=
ME_ENTRY_get_data(x509ne);</span><br><span>     if (!asn1)</span><br><span>=
     {</span><br><span>         return FAILURE;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/15=
88?usp=3Demail">change 1588</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1588?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia43bb88d9ddf2e82c638011353a=
64c770f2c2c0a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1588 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--JLwnLXQXAIU=--

