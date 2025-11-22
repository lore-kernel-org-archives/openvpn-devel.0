From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 22 Nov 2025 19:06:02 +0000
References: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6a64fb4fafabb18826f224b8274b866c67a0daa0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n8ysQIf2Bho="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 extract_x509_field_ssl(): verify that X509_NAME is not NULL.
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

--n8ysQIf2Bho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail

to review the following change.


Change subject: extract_x509_field_ssl(): verify that X509_NAME is not NULL.
......................................................................

extract_x509_field_ssl(): verify that X509_NAME is not NULL.

This seems to be unlikely to ever happen, but this check won't harm.

While at it, fix pre-C99 local-variable indent block.

Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 10 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1388/1

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 40d117b..ccbbcc9 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -202,8 +202,14 @@
     X509_NAME_ENTRY *x509ne =3D NULL;
     ASN1_STRING *asn1 =3D NULL;
     unsigned char *buf =3D NULL;
-    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);

+    if (x509 =3D=3D NULL)
+    {
+        msg(D_TLS_ERRORS, "X509 subject name is NULL");
+        return FAILURE;
+    }
+
+    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
     if (field_name_obj =3D=3D NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name);
@@ -244,11 +250,9 @@

     strncpynt(out, (char *)buf, size);

-    {
-        const result_t ret =3D (strlen((char *)buf) < size) ? SUCCESS : FA=
ILURE;
-        OPENSSL_free(buf);
-        return ret;
-    }
+    const result_t ret =3D (strlen((char *)buf) < size) ? SUCCESS : FAILUR=
E;
+    OPENSSL_free(buf);
+    return ret;
 }

 result_t

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Gerrit-Change-Number: 1388
Gerrit-PatchSet: 1
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--n8ysQIf2Bho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>cron2 would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">extract_x509_field_ssl(): verify that X509_=
NAME is not NULL.<br><br>This seems to be unlikely to ever happen, but this=
 check won&#39;t harm.<br><br>While at it, fix pre-C99 local-variable inden=
t block.<br><br>Reported-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Fo=
und-by: ZeroPath (https://zeropath.com/)<br><br>Change-Id: I1e9c7eee06bf5f2=
e8aed8cd2523684539294ac8b<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<br>1 file changed, 10 in=
sertions(+), 6 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/88/1388/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br>=
<span>index 40d117b..ccbbcc9 100644</span><br><span>--- a/src/openvpn/ssl_v=
erify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</spa=
n><br><span>@@ -202,8 +202,14 @@</span><br><span>     X509_NAME_ENTRY *x509=
ne =3D NULL;</span><br><span>     ASN1_STRING *asn1 =3D NULL;</span><br><sp=
an>     unsigned char *buf =3D NULL;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, =
0);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (x509 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_TLS_ERRORS, &quot;X509 subject name is NULL&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        return FAILURE;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);<=
/span><br><span>     if (field_name_obj =3D=3D NULL)</span><br><span>     {=
</span><br><span>         msg(D_TLS_ERRORS, &quot;Invalid X509 attribute na=
me &#39;%s&#39;&quot;, field_name);</span><br><span>@@ -244,11 +250,9 @@</s=
pan><br><span> </span><br><span>     strncpynt(out, (char *)buf, size);</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const result_t =
ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        OPENSSL_free(buf);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const result_t ret =3D (strlen((char *)buf)=
 &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    OPENSSL_free(buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span> </span>=
<br><span> result_t</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail">change 1388<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523=
684539294ac8b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1388 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--n8ysQIf2Bho=--

