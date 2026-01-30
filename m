From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:11:16 +0000
References: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a315d508c3052af7438b97ab68ae16140460e9f1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Te2/Gm5u5Sk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Te2/Gm5u5Sk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail

to review the following change.


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
---
M src/openvpn/ssl_verify_openssl.c
1 file changed, 5 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1507/1

diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index 58f665c..90a8a51 100644
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
@@ -139,17 +133,15 @@
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
@@ -157,11 +149,12 @@
             switch (name->type)
             {
                 case GEN_EMAIL:
-                    if (ASN1_STRING_to_UTF8((unsigned char **)&buf, name->=
d.ia5) < 0)
+                    char *buf =3D NULL;
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23cc00aee47aef007ab2e7d50b52c6de299505db
Gerrit-Change-Number: 1507
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Te2/Gm5u5Sk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl_verify_openssl: Clean up extract_x509_e=
xtension<br><br>* Avoid sign-compare warning when comparing string<br>  len=
gths<br>* Use the nicer alias rfc822Name instead of the general ia5<br>  fr=
om the GENERAL_NAME union.<br>* Use the official ASN1_STRING_length API ins=
tead of accessing<br>  the struct directly.<br>* C11 changes<br><br>Change-=
Id: I23cc00aee47aef007ab2e7d50b52c6de299505db<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.=
c<br>1 file changed, 5 insertions(+), 16 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1507/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_v=
erify_openssl.c</span><br><span>index 58f665c..90a8a51 100644</span><br><sp=
an>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn=
/ssl_verify_openssl.c</span><br><span>@@ -118,16 +118,10 @@</span><br><span=
>     return nid =3D=3D NID_subject_alt_name || nid =3D=3D NID_issuer_alt_n=
ame;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic igno=
red &quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> static bool</span><br><span> extract_x509_extension(X509 *cert,=
 char *fieldname, char *out, size_t size)</span><br><span> {</span><br><spa=
n>     bool retval =3D false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    char *buf =3D 0;</span><br><span> </span><br><span>     if (!x5=
09_username_field_ext_supported(fieldname))</span><br><span>     {</span><b=
r><span>@@ -139,17 +133,15 @@</span><br><span>     GENERAL_NAMES *extension=
s =3D X509_get_ext_d2i(cert, nid, NULL, NULL);</span><br><span>     if (ext=
ensions)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        int numalts;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        int i;</span><br><span>         /* get amount of alternati=
ves,</span><br><span>          * RFC2459 claims there MUST be at least</spa=
n><br><span>          * one, but we don&#39;t depend on it...</span><br><sp=
an>          */</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        numalts =3D sk_GENERAL_NAME_num(extensions);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        int numalts =3D sk_GEN=
ERAL_NAME_num(extensions);</span><br><span> </span><br><span>         /* lo=
op through all alternatives */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        for (i =3D 0; i &lt; numalts; i++)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; numalts;=
 i++)</span><br><span>         {</span><br><span>             /* get a hand=
le to alternative name number i */</span><br><span>             const GENER=
AL_NAME *name =3D sk_GENERAL_NAME_value(extensions, i);</span><br><span>@@ =
-157,11 +149,12 @@</span><br><span>             switch (name-&gt;type)</spa=
n><br><span>             {</span><br><span>                 case GEN_EMAIL:=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    i=
f (ASN1_STRING_to_UTF8((unsigned char **)&amp;buf, name-&gt;d.ia5) &lt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
char *buf =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    if (ASN1_STRING_to_UTF8((unsigned char **)&amp;buf, nam=
e-&gt;d.rfc822Name) &lt; 0)</span><br><span>                     {</span><b=
r><span>                         continue;</span><br><span>                =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     if (strlen(buf) !=3D name-&gt;d.ia5-&gt;length)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if ((ssize_t)strlen(b=
uf) !=3D ASN1_STRING_length(name-&gt;d.rfc822Name))</span><br><span>       =
              {</span><br><span>                         msg(D_TLS_ERRORS, =
&quot;ASN1 ERROR: string contained terminating zero&quot;);</span><br><span=
>                         OPENSSL_free(buf);</span><br><span>@@ -185,10 +17=
8,6 @@</span><br><span>     return retval;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /*</span><br><span>  * Extract a field from an X509 subject na=
me.</span><br><span>  *</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail">change 1=
507</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23cc00aee47aef007ab2e7d50b5=
2c6de299505db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Te2/Gm5u5Sk=--

