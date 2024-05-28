From: "ssbssa (Code Review)" <gerrit@...515...>
Date: Tue, 28 May 2024 17:28:02 +0000
References: <gerrit.1716917280000.Ia2c3e4c5c83ecccce1618c43b489dbe811de5351@...2715...>
Reply-To: ssbssa@...360..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a382fb2c47ccc4d0efd8622f0f89d35bcd9ffbe0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DYBxQyOLuiY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DYBxQyOLuiY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail

to review the following change.


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
---
M doc/man-sections/windows-options.rst
M src/openvpn/cryptoapi.c
2 files changed, 111 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/621/1

diff --git a/doc/man-sections/windows-options.rst b/doc/man-sections/window=
s-options.rst
index e87291f..3e66355 100644
--- a/doc/man-sections/windows-options.rst
+++ b/doc/man-sections/windows-options.rst
@@ -55,6 +55,12 @@

      cryptoapicert "ISSUER:Sample CA"

+  To select a certificate based on a certificate's template name or
+  OID of the template:
+  ::
+
+     cryptoapicert "TMPL:1.3.6.1.4..."
+
   The first non-expired certificate found in the user's store or the
   machine store that matches the select-string is used.

diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index f7e5b67..0810086 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -178,6 +178,94 @@
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
+find_oid(DWORD keytype, const void *key, DWORD groupid, bool fallback)
+{
+    const CRYPT_OID_INFO *info =3D NULL;
+
+    /* force resolve from local as first step */
+    info =3D CryptFindOIDInfo(keytype, (void*)key,
+                            groupid | CRYPT_OID_DISABLE_SEARCH_DS_FLAG);
+
+    /* try proper resolve if not found yet, also including AD */
+    if (!info)
+    {
+        info =3D CryptFindOIDInfo(keytype, (void*)key, groupid);
+    }
+
+    /* fall back to all groups if not found yet and fallback requested */
+    if (!info && fallback && groupid)
+    {
+        info =3D CryptFindOIDInfo(keytype, (void*)key, 0);
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
+            const CERT_TEMPLATE_EXT *cte =3D (const CERT_TEMPLATE_EXT*)pve=
xt;
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
ROUP_ID, true);
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
@@ -186,6 +274,7 @@
      * SUBJ:<certificate substring to match>
      * THUMB:<certificate thumbprint hex value>, e.g.
      *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9 df 7a b6 =
28
+     * TMPL:<template name>
      * The first matching certificate that has not expired is returned.
      */
     const CERT_CONTEXT *rv =3D NULL;
@@ -218,6 +307,12 @@
             goto out;
         }
     }
+    else if (!strncmp(cert_prop, "TMPL:", 5))
+    {
+        cert_prop +=3D 5;
+        find_param =3D NULL;
+        find_type =3D CERT_FIND_ANY;
+    }
     else
     {
         msg(M_NONFATAL, "Error in cryptoapicert: unsupported certificate s=
pecification <%s>", cert_prop);
@@ -230,11 +325,18 @@
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
+        if (find_type =3D=3D CERT_FIND_ANY
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
Gerrit-PatchSet: 1
Gerrit-Owner: ssbssa <ssbssa@...360...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--DYBxQyOLuiY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ssbssa would like plaisthos and flichtenheld to <strong>review</strong> =
this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Implement Windows CA template match for Crypto-API selector<b=
r><br>The certificate selection process for the Crypto API certificates<br>=
is currently fixed to match on subject or identifier. Especially<br>if cert=
ificates that are used for OpenVPN are managed by a Windows CA,<br>it is ap=
propriate to select the certificate to use by the template<br>that it is ge=
nerated from, especially on domain-joined clients which<br>automatically ac=
quire/renew the corresponding certificate.<br><br>The attached match implem=
ents the match on TMPL: with either a template<br>name (which is looked up =
through CryptFindOIDInfo) or by specifying the<br>OID of the template direc=
tly, which then is matched against the<br>corresponding X509 extensions spe=
cifying the template that the certificate<br>was generated from.<br><br>The=
 logic requires to walk all certificates in the underlying store and<br>to =
match the certificate extensions directly. The hook which is<br>implemented=
 in the certificate selection logic is generic to allow<br>other Crypto-API=
 certificate matches to also be implemented at some<br>point in the future.=
<br><br>The logic to match the certificate template is taken from the<br>im=
plementation in the .NET core runtime, see Pal.Windows/FindPal.cs in<br>in =
the implementation of System.Security.Cryptography.X509Certificates.<br><br=
>Change-Id: Ia2c3e4c5c83ecccce1618c43b489dbe811de5351<br>Signed-off-by: Hei=
ko Wundram &lt;heiko.wundram@...2614...&gt;<br>Signed-off-by: Hannes Domani=
 &lt;ssbssa@...360...&gt;<br>---<br>M doc/man-sections/windows-options.rst<=
br>M src/openvpn/cryptoapi.c<br>2 files changed, 111 insertions(+), 3 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/21/621/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/doc/man-sections/windows-options.rst b/do=
c/man-sections/windows-options.rst</span><br><span>index e87291f..3e66355 1=
00644</span><br><span>--- a/doc/man-sections/windows-options.rst</span><br>=
<span>+++ b/doc/man-sections/windows-options.rst</span><br><span>@@ -55,6 +=
55,12 @@</span><br><span> </span><br><span>      cryptoapicert &quot;ISSUER=
:Sample CA&quot;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  To select a certificate based on a certificate&#39;s templ=
ate name or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OID of=
 the template:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  ::<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+     cryptoapicert &quot;TMPL:1.3.6.1.4=
...&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>   The first non-expired certificate found in the user&#39;s store o=
r the</span><br><span>   machine store that matches the select-string is us=
ed.</span><br><span> </span><br><span>diff --git a/src/openvpn/cryptoapi.c =
b/src/openvpn/cryptoapi.c</span><br><span>index f7e5b67..0810086 100644</sp=
an><br><span>--- a/src/openvpn/cryptoapi.c</span><br><span>+++ b/src/openvp=
n/cryptoapi.c</span><br><span>@@ -178,6 +178,94 @@</span><br><span>     ret=
urn i;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+static void *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+decode_object(struct gc_arena *gc, LPCSTR struct_type,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+              const CR=
YPT_OBJID_BLOB *val, DWORD flags, DWORD *cb)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /* get byte count for decoding */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    BYTE *buf;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!CryptDecodeObject(X509_ASN_ENCODING | PKCS_7_A=
SN_ENCODING, struct_type,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                           val-&gt;pbData, val-&gt;cbData, flags, NUL=
L, cb))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return NULL;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    /* do the actual decode */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf =3D gc_malloc(*cb, false, gc);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (!CryptDecodeObject(X=
509_ASN_ENCODING | PKCS_7_ASN_ENCODING, struct_type,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           val-&gt;pbData=
, val-&gt;cbData, flags, buf, cb))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        return NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return buf;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static const CRYPT_OID_INFO *</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+find_oid(DWORD keytype, const void *key, DWORD groupid, bool f=
allback)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const CRYPT_OID_INFO *inf=
o =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /* force resolve from l=
ocal as first step */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    info =3D CryptFindOIDInfo(keytype, (void*)key,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                            groupid | CRY=
PT_OID_DISABLE_SEARCH_DS_FLAG);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* =
try proper resolve if not found yet, also including AD */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!info)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        info =3D CryptFindOIDInfo(keytype, (void*)key, =
groupid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* fall back to all groups if not fou=
nd yet and fallback requested */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!info &amp;&amp; fallback &amp;&amp; groupid)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        info =3D CryptFindOIDInfo(keytype=
, (void*)key, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return info;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_cer=
tificate_template(const char *cert_prop, const CERT_CONTEXT *cert_ctx)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const CERT_INFO *info =3D cert_ctx-&g=
t;pCertInfo;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    con=
st CERT_EXTENSION *ext;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    DWORD cbext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    void *pvext;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const WCHAR *tmpl_name =3D wide_string(cert_prop, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* check for V2 extension (Wind=
ows 2003+) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ex=
t =3D CertFindExtension(szOID_CERTIFICATE_TEMPLATE, info-&gt;cExtension, in=
fo-&gt;rgExtension);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (ext)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        pvext =3D de=
code_object(&amp;gc, X509_CERTIFICATE_TEMPLATE, &amp;ext-&gt;Value, 0, &amp=
;cbext);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(pvext &amp;&amp; cbext &gt;=3D sizeof(CERT_TEMPLATE_EXT))</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            const CERT_TEMPLATE_EXT *cte =3D (=
const CERT_TEMPLATE_EXT*)pvext;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!stricmp(cert_prop, cte-&gt;pszObjId))</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                /* found direct OI=
D match with certificate property specified */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                gc_free(&amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            const CRYPT_OID_INFO *tmpl_oid =3D fin=
d_oid(CRYPT_OID_INFO_NAME_KEY, tmpl_name,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                                                     =
 CRYPT_TEMPLATE_OID_GROUP_ID, true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (tmpl_oid &amp;&amp; !stricmp(tmpl_oid-&gt;=
pszOID, cte-&gt;pszObjId))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                /* found OID match in extension against resolved key */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                gc_fre=
e(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /* no extension found, exit */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static const CERT_CONTEXT *</span=
><br><span> find_certificate_in_store(const char *cert_prop, HCERTSTORE cer=
t_store)</span><br><span> {</span><br><span>@@ -186,6 +274,7 @@</span><br><=
span>      * SUBJ:&lt;certificate substring to match&gt;</span><br><span>  =
    * THUMB:&lt;certificate thumbprint hex value&gt;, e.g.</span><br><span>=
      *     THUMB:f6 49 24 41 01 b4 fb 44 0c ce f4 36 ae d0 c4 c9 df 7a b6 =
28</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * TMPL:&lt;t=
emplate name&gt;</span><br><span>      * The first matching certificate tha=
t has not expired is returned.</span><br><span>      */</span><br><span>   =
  const CERT_CONTEXT *rv =3D NULL;</span><br><span>@@ -218,6 +307,12 @@</sp=
an><br><span>             goto out;</span><br><span>         }</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else =
if (!strncmp(cert_prop, &quot;TMPL:&quot;, 5))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        cert_prop +=3D 5;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        find_param =3D NULL;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        find_type =3D CERT_FIND_ANY;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     els=
e</span><br><span>     {</span><br><span>         msg(M_NONFATAL, &quot;Err=
or in cryptoapicert: unsupported certificate specification &lt;%s&gt;&quot;=
, cert_prop);</span><br><span>@@ -230,11 +325,18 @@</span><br><span>       =
  /* this frees previous rv, if not NULL */</span><br><span>         rv =3D=
 CertFindCertificateInStore(cert_store, X509_ASN_ENCODING | PKCS_7_ASN_ENCO=
DING,</span><br><span>                                         0, find_type=
, find_param, rv);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (rv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (!rv)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            validity =3D CertVerifyTimeValidity(NULL, rv-&gt=
;pCertInfo);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     break;</span><br><span>         }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (!rv || validity =3D=3D 0)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        /* if searching by template name=
, check now if it matches */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (find_type =3D=3D CERT_FIND_ANY</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !test_certificate_=
template(cert_prop, rv))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       continue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        valid=
ity =3D CertVerifyTimeValidity(NULL, rv-&gt;pCertInfo);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (validity =3D=3D 0)</span><b=
r><span>         {</span><br><span>             break;</span><br><span>    =
     }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/621?usp=3Demail">change 621</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/621?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia2c3e4c5c83ecccce1618c43b48=
9dbe811de5351 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 621 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ssbssa &lt;ssbssa@...360...&gt; =
</div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--DYBxQyOLuiY=--

