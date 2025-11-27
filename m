From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 11:59:54 +0000
In-Reply-To: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
References: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <c2ccbbea7df620c8a5b798cd0c3c0be6695b621a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oXOgzLz8tFg="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oXOgzLz8tFg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
88?usp=3Demail )

Change subject: extract_x509_field_ssl(): verify that X509_NAME is not NULL.
......................................................................

extract_x509_field_ssl(): verify that X509_NAME is not NULL.

This seems to be unlikely to ever happen, but this check won't harm
- as a matter of coding convention, we do not ensure this inside
extract_x509_field_ssl(), but in the (single) caller.

While at it, fix pre-C99 local-variable indent block, and missing {}
block in else/#endif construction.

Reported-By: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Antonio Quartulli <antonio@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1388
Message-Id: <20251127113517.1352-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
748.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 14 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 40d117b..6cb04ee 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -202,8 +202,8 @@
     X509_NAME_ENTRY *x509ne =3D NULL;
     ASN1_STRING *asn1 =3D NULL;
     unsigned char *buf =3D NULL;
-    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);

+    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_name, 0);
     if (field_name_obj =3D=3D NULL)
     {
         msg(D_TLS_ERRORS, "Invalid X509 attribute name '%s'", field_name);
@@ -244,11 +244,9 @@

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
@@ -278,12 +276,21 @@
     }
     else
 #endif /* ifdef ENABLE_X509ALTUSERNAME */
+    {
+        X509_NAME *x509_subject_name =3D X509_get_subject_name(peer_cert);
+        if (x509_subject_name =3D=3D NULL)
+        {
+            msg(D_TLS_ERRORS, "X509 subject name is NULL");
+            return FAILURE;
+        }
+
         if (FAILURE
-            =3D=3D extract_x509_field_ssl(X509_get_subject_name(peer_cert)=
, x509_username_field,
+            =3D=3D extract_x509_field_ssl(x509_subject_name, x509_username=
_field,
                                       common_name, cn_len))
         {
             return FAILURE;
         }
+    }

     return SUCCESS;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Gerrit-Change-Number: 1388
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oXOgzLz8tFg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1388?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">extract_x509_field_ssl(): verify that X509_NAME =
is not NULL.<br><br>This seems to be unlikely to ever happen, but this chec=
k won&#39;t harm<br>- as a matter of coding convention, we do not ensure th=
is inside<br>extract_x509_field_ssl(), but in the (single) caller.<br><br>W=
hile at it, fix pre-C99 local-variable indent block, and missing {}<br>bloc=
k in else/#endif construction.<br><br>Reported-By: Joshua Rogers &lt;contac=
t@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/)<br><br>Chang=
e-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>Acked-by: Antonio Quartulli &lt;antonio@...1665...=
726...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1388<br>Me=
ssage-Id: &lt;20251127113517.1352-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34748.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl=
_verify_openssl.c<br>1 file changed, 14 insertions(+), 7 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_o=
penssl.c</span><br><span>index 40d117b..6cb04ee 100644</span><br><span>--- =
a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ve=
rify_openssl.c</span><br><span>@@ -202,8 +202,8 @@</span><br><span>     X50=
9_NAME_ENTRY *x509ne =3D NULL;</span><br><span>     ASN1_STRING *asn1 =3D N=
ULL;</span><br><span>     unsigned char *buf =3D NULL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    ASN1_OBJECT *field_name_obj =3D OBJ_tx=
t2obj(field_name, 0);</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASN1_OBJECT *field_name_obj =3D OBJ_txt2obj(field_n=
ame, 0);</span><br><span>     if (field_name_obj =3D=3D NULL)</span><br><sp=
an>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;Invalid X509 att=
ribute name &#39;%s&#39;&quot;, field_name);</span><br><span>@@ -244,11 +24=
4,9 @@</span><br><span> </span><br><span>     strncpynt(out, (char *)buf, s=
ize);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const =
result_t ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        OPENSSL_free(buf);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return ret;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const result_t ret =3D (strlen((ch=
ar *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    OPENSSL_free(buf);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }</span><br><span=
> </span><br><span> result_t</span><br><span>@@ -278,12 +276,21 @@</span><b=
r><span>     }</span><br><span>     else</span><br><span> #endif /* ifdef E=
NABLE_X509ALTUSERNAME */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        X=
509_NAME *x509_subject_name =3D X509_get_subject_name(peer_cert);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (x509_subject_name=
 =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(=
D_TLS_ERRORS, &quot;X509 subject name is NULL&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return FAILURE;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if (FAILURE</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            =3D=3D extrac=
t_x509_field_ssl(X509_get_subject_name(peer_cert), x509_username_field,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            =3D=3D extr=
act_x509_field_ssl(x509_subject_name, x509_username_field,</span><br><span>=
                                       common_name, cn_len))</span><br><spa=
n>         {</span><br><span>             return FAILURE;</span><br><span> =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span> </span><br><span>     return SUCCESS;</span><br><span> }</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1388?usp=3Demail">change 1388</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1388?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523=
684539294ac8b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1388 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--oXOgzLz8tFg=--

