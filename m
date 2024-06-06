From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 6 Jun 2024 11:33:44 +0000
In-Reply-To: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
References: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 ssbssa@...360..., openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1d3942f9482a9fc2dccbd71cddcfc2d995ac82d4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ByfT9xsOa2o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Implement Windows CA
 template match for Crypto-API selector
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ssbssa <ssbssa@...360...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, selvanair <selva.nair@...277...>

--ByfT9xsOa2o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ssbssa. ( http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail )


Change subject: Implement Windows CA template match for Crypto-API selector
......................................................................

Implement Windows CA template match for Crypto-API selector

The certificate selection process for the Crypto API certificates
is currently fixed to match on subject or identifier. Especially
if certificates that are used for OpenVPN are managed by a Windows CA,
it is appropriate to select the certificate to use by the template
that it is generated from, especially on domain-joined clients which
automatically acquire/renew the corresponding certificate.

The attached match implements the match on TMPL: with either a template
name (which is looked up through CryptFindOIDInfo) or by specifying the
OID of the template directly, which then is matched against the
corresponding X509 extensions specifying the template that the certificate
was generated from.

The logic requires to walk all certificates in the underlying store and
to match the certificate extensions directly. The hook which is
implemented in the certificate selection logic is generic to allow
other Crypto-API certificate matches to also be implemented at some
point in the future.

The logic to match the certificate template is taken from the
implementation in the .NET core runtime, see Pal.Windows/FindPal.cs in
in the implementation of System.Security.Cryptography.X509Certificates.

Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351
Signed-off-by: Heiko Wundram <heiko.wundram@...2614...>
Signed-off-by: Hannes Domani <ssbssa@...360...>
Acked-by: Selva Nair <selva.nair@...277...>
Message-Id: <20240606103441.26598-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
726.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/windows-options.rst
M src/openvpn/cryptoapi.c
2 files changed, 105 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/621/3

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/window=
s-options.rst
index e87291f..1955869 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -55,6 +55,13 @@

      cryptoapicert "ISSUER:Sample CA"

+  To select a certificate based on a certificate's template name or
+  OID of the template:
+  ::
+
+     cryptoapicert "TMPL:Name of Template"
+     cryptoapicert "TMPL:1.3.6.1.4..."
+
   The first non-expired certificate found in the user's store or the
   machine store that matches the select-string is used.

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index f7e5b67..67dc382 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -178,6 +178,87 @@
     return i;
 }

+static void *
+decode_object(struct gc_arena *gc, LPCSTR struct_type,
+              const CRYPT_OBJID_BLOB *val, DWORD flags, DWORD *cb)
+{
+    /* get byte count for decoding */
+    BYTE *buf;
+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct=
_type,
+                           val->pbData, val->cbData, flags, NULL, cb))
+    {
+        return NULL;
+    }
+
+    /* do the actual decode */
+    buf =3D gc_malloc(*cb, false, gc);
+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct=
_type,
+                           val->pbData, val->cbData, flags, buf, cb))
+    {
+        return NULL;
+    }
+
+    return buf;
+}
+
+static const CRYPT_OID_INFO *
+find_oid(DWORD keytype, const void *key, DWORD groupid)
+{
+    const CRYPT_OID_INFO *info =3D NULL;
+
+    /* try proper resolve, also including AD */
+    info =3D CryptFindOIDInfo(keytype, (void *)key, groupid);
+
+    /* fall back to all groups if not found yet */
+    if (!info && groupid)
+    {
+        info =3D CryptFindOIDInfo(keytype, (void *)key, 0);
+    }
+
+    return info;
+}
+
+static bool
+test_certificate_template(const char *cert_prop, const CERT_CONTEXT *cert_=
ctx)
+{
+    const CERT_INFO *info =3D cert_ctx->pCertInfo;
+    const CERT_EXTENSION *ext;
+    DWORD cbext;
+    void *pvext;
+    struct gc_arena gc =3D gc_new();
+    const WCHAR *tmpl_name =3D wide_string(cert_prop, &gc);
+
+    /* check for V2 extension (Windows 2003+) */
+    ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info->cExtension=
, info->rgExtension);
+    if (ext)
+    {
+        pvext =3D decode_object(&gc, X509_CERTIFICATE_TEMPLATE, &ext->Valu=
e, 0, &cbext);
+        if (pvext && cbext >=3D sizeof(CERT_TEMPLATE_EXT))
+        {
+            const CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pv=
ext;
+            if (!stricmp(cert_prop, cte->pszObjId))
+            {
+                /* found direct OID match with certificate property specif=
ied */
+                gc_free(&gc);
+                return true;
+            }
+
+            const CRYPT_OID_INFO *tmpl_oid =3D find_oid(CRYPT_OID_INFO_NAM=
E_KEY, tmpl_name,
+                                                      CRYPT_TEMPLATE_OID_G=
ROUP_ID);
+            if (tmpl_oid && !stricmp(tmpl_oid->pszOID, cte->pszObjId))
+            {
+                /* found OID match in extension against resolved key */
+                gc_free(&gc);
+                return true;
+            }
+        }
+    }
+
+    /* no extension found, exit */
+    gc_free(&gc);
+    return false;
+}
+
 static const CERT_CONTEXT *
 find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
 {
@@ -186,6 +267,7 @@
      * SUBJ:<certificate substring to match>
      * THUMB:<certificate thumbprint hex value>, e.g.
      *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9 df 7a b6 =
28
+     * TMPL:<template name or OID>
      * The first matching certificate that has not expired is returned.
      */
     const CERT_CONTEXT *rv =3D NULL;
@@ -218,6 +300,12 @@
             goto out;
         }
     }
+    else if (!strncmp(cert_prop, "TMPL:", 5))
+    {
+        cert_prop +=3D 5;
+        find_param =3D NULL;
+        find_type =3D CERT_FIND_HAS_PRIVATE_KEY;
+    }
     else
     {
         msg(M_NONFATAL, "Error in cryptoapicert: unsupported certificate s=
pecification <%s>", cert_prop);
@@ -230,11 +318,18 @@
         /* this frees previous rv, if not NULL */
         rv =3D CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | =
PKCS_7_ASN_ENCODING,
                                         0, find_type, find_param, rv);
-        if (rv)
+        if (!rv)
         {
-            validity =3D CertVerifyTimeValidity(NULL, rv->pCertInfo);
+            break;
         }
-        if (!rv || validity =3D=3D 0)
+        /* if searching by template name, check now if it matches */
+        if (find_type =3D=3D CERT_FIND_HAS_PRIVATE_KEY
+            && !test_certificate_template(cert_prop, rv))
+        {
+            continue;
+        }
+        validity =3D CertVerifyTimeValidity(NULL, rv->pCertInfo);
+        if (validity =3D=3D 0)
         {
             break;
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351
Gerrit-Change-Number: 621
Gerrit-PatchSet: 3
Gerrit-Owner: ssbssa <ssbssa@...360...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-MessageType: newpatchset

--ByfT9xsOa2o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by ssbssa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621=
?usp=3Demail">View Change</a></p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Implement Windows CA template match for Crypt=
o-API selector<br><br>The certificate selection process for the Crypto API =
certificates<br>is currently fixed to match on subject or identifier. Espec=
ially<br>if certificates that are used for OpenVPN are managed by a Windows=
 CA,<br>it is appropriate to select the certificate to use by the template<=
br>that it is generated from, especially on domain-joined clients which<br>=
automatically acquire/renew the corresponding certificate.<br><br>The attac=
hed match implements the match on TMPL: with either a template<br>name (whi=
ch is looked up through CryptFindOIDInfo) or by specifying the<br>OID of th=
e template directly, which then is matched against the<br>corresponding X50=
9 extensions specifying the template that the certificate<br>was generated =
from.<br><br>The logic requires to walk all certificates in the underlying =
store and<br>to match the certificate extensions directly. The hook which i=
s<br>implemented in the certificate selection logic is generic to allow<br>=
other Crypto-API certificate matches to also be implemented at some<br>poin=
t in the future.<br><br>The logic to match the certificate template is take=
n from the<br>implementation in the .NET core runtime, see Pal.Windows/Find=
Pal.cs in<br>in the implementation of System.Security.Cryptography.X509Cert=
ificates.<br><br>Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351<br>Si=
gned-off-by: Heiko Wundram &lt;heiko.wundram@...2614...&gt;<br>Signed-off-b=
y: Hannes Domani &lt;ssbssa@...360...&gt;<br>Acked-by: Selva Nair &lt;selva=
.nair@...277...&gt;<br>Message-Id: &lt;20240606103441.26598-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg28726.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M doc/man-sections/windows-options.rst<br>M src/openvpn/cryptoapi.=
c<br>2 files changed, 105 insertions(+), 3 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/621/3</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/doc/man-sections/windows-options.rst b/doc/man-sections/windows-opti=
ons.rst</span><br><span>index e87291f..1955869 100644</span><br><span>--- a=
/doc/man-sections/windows-options.rst</span><br><span>+++ b/doc/man-section=
s/windows-options.rst</span><br><span>@@ -55,6 +55,13 @@</span><br><span> <=
/span><br><span>      cryptoapicert &quot;ISSUER:Sample CA&quot;</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  To select =
a certificate based on a certificate&#39;s template name or</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+  OID of the template:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+  ::</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     cryptoapicert &quot;TMPL:Name of Template&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     cryptoapicert &quot;TMPL:1.3=
.6.1.4...&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span>   The first non-expired certificate found in the user&#39;s s=
tore or the</span><br><span>   machine store that matches the select-string=
 is used.</span><br><span> </span><br><span>diff --git a/src/openvpn/crypto=
api.c b/src/openvpn/cryptoapi.c</span><br><span>index f7e5b67..67dc382 1006=
44</span><br><span>--- a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/=
openvpn/cryptoapi.c</span><br><span>@@ -178,6 +178,87 @@</span><br><span>  =
   return i;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+static void *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+decode_object(struct gc_arena *gc, LPCSTR struct_ty=
pe,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              co=
nst CRYPT_OBJID_BLOB *val, DWORD flags, DWORD *cb)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* get byte count for decoding */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    BYTE *buf;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    if (!CryptDecodeObject(X509_ASN_ENCODING | PK=
CS_7_ASN_ENCODING, struct_type,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                           val-&gt;pbData, val-&gt;cbData, flag=
s, NULL, cb))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* do the actual decode */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf =3D gc_malloc(*cb, false, gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!CryptDecodeOb=
ject(X509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           val-&gt;p=
bData, val-&gt;cbData, flags, buf, cb))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static const CRYPT_OID_INFO *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+find_oid(DWORD keytype, const void *key, DWORD groupid)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const CRYPT_OID_INFO *info =3D NULL=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* try proper resolve, also inclu=
ding AD */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    info =
=3D CryptFindOIDInfo(keytype, (void *)key, groupid);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* fall back to all groups if not found yet */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!info &amp;&amp; grou=
pid)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        info =3D CryptFindOID=
Info(keytype, (void *)key, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return info;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+test_certificate_template(const char *cert_prop, const CERT_CONTEXT =
*cert_ctx)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    const CERT_INFO *info =
=3D cert_ctx-&gt;pCertInfo;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const CERT_EXTENSION *ext;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    DWORD cbext;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    void *pvext;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    const WCHAR *tmpl_name =3D wide_string(ce=
rt_prop, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* check for V2 =
extension (Windows 2003+) */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ext =3D CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info-&gt=
;cExtension, info-&gt;rgExtension);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (ext)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   pvext =3D decode_object(&amp;gc, X509_CERTIFICATE_TEMPLATE, &amp;ext-&gt=
;Value, 0, &amp;cbext);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (pvext &amp;&amp; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            const CERT_TEMPLATE=
_EXT *cte =3D (const CERT_TEMPLATE_EXT *)pvext;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            if (!stricmp(cert_prop, cte-&gt;psz=
ObjId))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /*=
 found direct OID match with certificate property specified */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                gc_free(&amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                re=
turn true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            const CRYPT_OID_INFO *=
tmpl_oid =3D find_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
                 CRYPT_TEMPLATE_OID_GROUP_ID);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (tmpl_oid &amp;&amp; !stricmp(tmp=
l_oid-&gt;pszOID, cte-&gt;pszObjId))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                /* found OID match in extension against resolved=
 key */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                return true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /* no extension found, exit */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static const CERT_CONTE=
XT *</span><br><span> find_certificate_in_store(const char *cert_prop, HCER=
TSTORE cert_store)</span><br><span> {</span><br><span>@@ -186,6 +267,7 @@</=
span><br><span>      * SUBJ:&lt;certificate substring to match&gt;</span><b=
r><span>      * THUMB:&lt;certificate thumbprint hex value&gt;, e.g.</span>=
<br><span>      *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9=
 df 7a b6 28</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
TMPL:&lt;template name or OID&gt;</span><br><span>      * The first matchin=
g certificate that has not expired is returned.</span><br><span>      */</s=
pan><br><span>     const CERT_CONTEXT *rv =3D NULL;</span><br><span>@@ -218=
,6 +300,12 @@</span><br><span>             goto out;</span><br><span>      =
   }</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    else if (!strncmp(cert_prop, &quot;TMPL:&quot;, 5))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cert_prop +=3D 5;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        find_param =3D NULL;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        find_type =3D CERT_FIN=
D_HAS_PRIVATE_KEY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span>     else</span><br><span>     {</span><br><span>     =
    msg(M_NONFATAL, &quot;Error in cryptoapicert: unsupported certificate s=
pecification &lt;%s&gt;&quot;, cert_prop);</span><br><span>@@ -230,11 +318,=
18 @@</span><br><span>         /* this frees previous rv, if not NULL */</s=
pan><br><span>         rv =3D CertFindCertificateInStore(cert_store, X509_A=
SN_ENCODING | PKCS_7_ASN_ENCODING,</span><br><span>                        =
                 0, find_type, find_param, rv);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (rv)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (!rv)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            validity =3D CertVe=
rifyTimeValidity(NULL, rv-&gt;pCertInfo);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            break;</span><br><span>         }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!rv || validity =
=3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /*=
 if searching by template name, check now if it matches */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (find_type =3D=3D CERT_FI=
ND_HAS_PRIVATE_KEY</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &amp;&amp; !test_certificate_template(cert_prop, rv))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            continue;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        validity =3D CertVerifyTimeValidity(NULL=
, rv-&gt;pCertInfo);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (validity =3D=3D 0)</span><br><span>         {</span><br><span>=
             break;</span><br><span>         }</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621=
?usp=3Demail">change 621</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b48=
9dbe811de5351 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 621 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ssbssa &lt;ssbssa@...360...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ByfT9xsOa2o=--

