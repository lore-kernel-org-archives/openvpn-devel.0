From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 10:24:19 +0000
In-Reply-To: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
References: <gerrit.1763838359000.I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <04666b9a9077281b5bbe3f88607e2e42323d5d9e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZT4LaqBi4QY="; charset=UTF-8
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

--ZT4LaqBi4QY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, ordex, plaisthos.

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by ordex


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
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 14 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1388/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b
Gerrit-Change-Number: 1388
Gerrit-PatchSet: 2
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: ordex <antonio@...2726...>

--ZT4LaqBi4QY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, ordex, plaisthos. </p>
<p>cron2 <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by ordex</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">extract_x509_field_ssl(): verify th=
at X509_NAME is not NULL.<br><br>This seems to be unlikely to ever happen, =
but this check won&#39;t harm<br>- as a matter of coding convention, we do =
not ensure this inside<br>extract_x509_field_ssl(), but in the (single) cal=
ler.<br><br>While at it, fix pre-C99 local-variable indent block, and missi=
ng {}<br>block in else/#endif construction.<br><br>Reported-By: Joshua Roge=
rs &lt;contact@...2949...&gt;<br>Found-by: ZeroPath (https://zeropath.com/)=
<br><br>Change-Id: I1e9c7eee06bf5f2e8aed8cd2523684539294ac8b<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/ssl_verify=
_openssl.c<br>1 file changed, 14 insertions(+), 7 deletions(-)<br><br></pre=
><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/88/1388/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/open=
vpn/ssl_verify_openssl.c</span><br><span>index 40d117b..6cb04ee 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_openssl.c</span><br><span>@@ -202,8 +202,8 @@</span><b=
r><span>     X509_NAME_ENTRY *x509ne =3D NULL;</span><br><span>     ASN1_ST=
RING *asn1 =3D NULL;</span><br><span>     unsigned char *buf =3D NULL;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASN1_OBJECT *field_nam=
e_obj =3D OBJ_txt2obj(field_name, 0);</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    ASN1_OBJECT *field_name_obj =3D OBJ=
_txt2obj(field_name, 0);</span><br><span>     if (field_name_obj =3D=3D NUL=
L)</span><br><span>     {</span><br><span>         msg(D_TLS_ERRORS, &quot;=
Invalid X509 attribute name &#39;%s&#39;&quot;, field_name);</span><br><spa=
n>@@ -244,11 +244,9 @@</span><br><span> </span><br><span>     strncpynt(out=
, (char *)buf, size);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        const result_t ret =3D (strlen((char *)buf) &lt; size) ? SUCCESS =
: FAILURE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        OPE=
NSSL_free(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return ret;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    const result_t ret=
 =3D (strlen((char *)buf) &lt; size) ? SUCCESS : FAILURE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    OPENSSL_free(buf);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span><br><span> }=
</span><br><span> </span><br><span> result_t</span><br><span>@@ -278,12 +27=
6,21 @@</span><br><span>     }</span><br><span>     else</span><br><span> #=
endif /* ifdef ENABLE_X509ALTUSERNAME */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        X509_NAME *x509_subject_name =3D X509_get_subject_name(peer_=
cert);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (x=
509_subject_name =3D=3D NULL)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            msg(D_TLS_ERRORS, &quot;X509 subject name is NULL&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return FAILUR=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         i=
f (FAILURE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 =3D=3D extract_x509_field_ssl(X509_get_subject_name(peer_cert), x509_usern=
ame_field,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   =3D=3D extract_x509_field_ssl(x509_subject_name, x509_username_field,</s=
pan><br><span>                                       common_name, cn_len))<=
/span><br><span>         {</span><br><span>             return FAILURE;</sp=
an><br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span> </span><br><span>     return SUCCESS;</span><br>=
<span> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail">change 1388</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1388?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1e9c7eee06bf5f2e8aed8cd2523=
684539294ac8b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1388 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--ZT4LaqBi4QY=--

