From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Mar 2026 08:27:25 +0000
In-Reply-To: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
References: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6dc427189c3923af6faeda75ccb738f259542bfb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z7T8NJiZOWw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl_verify_openssl:
 Clean up extract_x509_extension
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

--Z7T8NJiZOWw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: ssl_verify_openssl: Clean up extract_x509_extension
......................................................................

ssl_verify_openssl: Clean up extract_x509_extension

* Avoid sign-compare warning when comparing string
  lengths
* Use the nicer alias rfc822Name instead of the general ia5
  from the GENERAL_NAME union.
* Use the official ASN1_STRING_length API instead of accessing
  the struct directly.
* C11 changes

Change-Id: I23cc00aee47aef007ab2e7d50b52c6de299505db
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1507
Message-Id: <20260309133236.29732-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
980.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 6 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1507/8

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 58f665c..46401cd 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -118,16 +118,10 @@
     return nid =3D=3D NID_subject_alt_name || nid =3D=3D NID_issuer_alt_na=
me;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 static bool
 extract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)
 {
     bool retval =3D false;
-    char *buf =3D 0;

     if (!x509_username_field_ext_supported(fieldname))
     {
@@ -139,29 +133,28 @@
     GENERAL_NAMES *extensions =3D X509_get_ext_d2i(cert, nid, NULL, NULL);
     if (extensions)
     {
-        int numalts;
-        int i;
         /* get amount of alternatives,
          * RFC2459 claims there MUST be at least
          * one, but we don't depend on it...
          */

-        numalts =3D sk_GENERAL_NAME_num(extensions);
+        int numalts =3D sk_GENERAL_NAME_num(extensions);

         /* loop through all alternatives */
-        for (i =3D 0; i < numalts; i++)
+        for (int i =3D 0; i < numalts; i++)
         {
             /* get a handle to alternative name number i */
             const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(extensions,=
 i);
+            char *buf =3D NULL;

             switch (name->type)
             {
                 case GEN_EMAIL:
-                    if (ASN1_STRING_to_UTF8((unsigned char **)&buf, name->=
d.ia5) < 0)
+                    if (ASN1_STRING_to_UTF8((unsigned char **)&buf, name->=
d.rfc822Name) < 0)
                     {
                         continue;
                     }
-                    if (strlen(buf) !=3D name->d.ia5->length)
+                    if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name-=
>d.rfc822Name))
                     {
                         msg(D_TLS_ERRORS, "ASN1 ERROR: string contained te=
rminating zero");
                         OPENSSL_free(buf);
@@ -175,7 +168,7 @@
                     break;

                 default:
-                    msg(D_TLS_DEBUG, "%s: ignoring general name field type=
 %i", __func__,
+                    msg(D_TLS_DEBUG, "%s: ignoring general name field type=
 %d", __func__,
                         name->type);
                     break;
             }
@@ -185,10 +178,6 @@
     return retval;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 /*
  * Extract a field from an X509 subject name.
  *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23cc00aee47aef007ab2e7d50b52c6de299505db
Gerrit-Change-Number: 1507
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z7T8NJiZOWw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">ssl_verify_openssl: Clean up ex=
tract_x509_extension<br><br>* Avoid sign-compare warning when comparing str=
ing<br>  lengths<br>* Use the nicer alias rfc822Name instead of the general=
 ia5<br>  from the GENERAL_NAME union.<br>* Use the official ASN1_STRING_le=
ngth API instead of accessing<br>  the struct directly.<br>* C11 changes<br=
><br>Change-Id: I23cc00aee47aef007ab2e7d50b52c6de299505db<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;a=
rne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1507<br>Message-Id: &lt;20260309133236.29732-1-frank@...2641...&gt;<b=
r>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg=
35980.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M src/openvpn/ssl_verify_openssl.c<br>1 file changed, 6 insertions(+), 17 =
deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/07/1507/8</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ve=
rify_openssl.c b/src/openvpn/ssl_verify_openssl.c</span><br><span>index 58f=
665c..46401cd 100644</span><br><span>--- a/src/openvpn/ssl_verify_openssl.c=
</span><br><span>+++ b/src/openvpn/ssl_verify_openssl.c</span><br><span>@@ =
-118,16 +118,10 @@</span><br><span>     return nid =3D=3D NID_subject_alt_n=
ame || nid =3D=3D NID_issuer_alt_name;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
 || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span> static bool</span><br><span> =
extract_x509_extension(X509 *cert, char *fieldname, char *out, size_t size)=
</span><br><span> {</span><br><span>     bool retval =3D false;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    char *buf =3D 0;</span><br><s=
pan> </span><br><span>     if (!x509_username_field_ext_supported(fieldname=
))</span><br><span>     {</span><br><span>@@ -139,29 +133,28 @@</span><br><=
span>     GENERAL_NAMES *extensions =3D X509_get_ext_d2i(cert, nid, NULL, N=
ULL);</span><br><span>     if (extensions)</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int numalts;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span> =
        /* get amount of alternatives,</span><br><span>          * RFC2459 =
claims there MUST be at least</span><br><span>          * one, but we don&#=
39;t depend on it...</span><br><span>          */</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        numalts =3D sk_GENERA=
L_NAME_num(extensions);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        int numalts =3D sk_GENERAL_NAME_num(extensions);</span><br><spa=
n> </span><br><span>         /* loop through all alternatives */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; num=
alts; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
or (int i =3D 0; i &lt; numalts; i++)</span><br><span>         {</span><br>=
<span>             /* get a handle to alternative name number i */</span><b=
r><span>             const GENERAL_NAME *name =3D sk_GENERAL_NAME_value(ext=
ensions, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     char *buf =3D NULL;</span><br><span> </span><br><span>             swi=
tch (name-&gt;type)</span><br><span>             {</span><br><span>        =
         case GEN_EMAIL:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    if (ASN1_STRING_to_UTF8((unsigned char **)&amp;buf, =
name-&gt;d.ia5) &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    if (ASN1_STRING_to_UTF8((unsigned char **)&amp;buf,=
 name-&gt;d.rfc822Name) &lt; 0)</span><br><span>                     {</spa=
n><br><span>                         continue;</span><br><span>            =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         if (strlen(buf) !=3D name-&gt;d.ia5-&gt;length)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    if ((ssize_t)strle=
n(buf) !=3D ASN1_STRING_length(name-&gt;d.rfc822Name))</span><br><span>    =
                 {</span><br><span>                         msg(D_TLS_ERROR=
S, &quot;ASN1 ERROR: string contained terminating zero&quot;);</span><br><s=
pan>                         OPENSSL_free(buf);</span><br><span>@@ -175,7 +=
168,7 @@</span><br><span>                     break;</span><br><span> </spa=
n><br><span>                 default:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                    msg(D_TLS_DEBUG, &quot;%s: ignoring gen=
eral name field type %i&quot;, __func__,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    msg(D_TLS_DEBUG, &quot;%s: ignorin=
g general name field type %d&quot;, __func__,</span><br><span>             =
            name-&gt;type);</span><br><span>                     break;</sp=
an><br><span>             }</span><br><span>@@ -185,10 +178,6 @@</span><br>=
<span>     return retval;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC =
diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</=
span><br><span>  * Extract a field from an X509 subject name.</span><br><sp=
an>  *</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail">change 1507</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1507?usp=3Demail"/><meta itemprop=3D"name" con=
tent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23cc00aee47aef007ab2e7d50b5=
2c6de299505db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Z7T8NJiZOWw=--

