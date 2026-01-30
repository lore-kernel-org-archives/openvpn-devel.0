From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 30 Jan 2026 16:34:38 +0000
In-Reply-To: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
References: <gerrit.1769789455000.I23cc00aee47aef007ab2e7d50b52c6de299505db@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <08fcd6baa8d44ecbcb0dab562fee43f0f68194e3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Y9IMFnyVPok="; charset=UTF-8
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

--Y9IMFnyVPok=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail

to look at the new patch set (#2).


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
1 file changed, 6 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1507/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--Y9IMFnyVPok=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">ssl_verify_openssl: Clean up extract_x509_extens=
ion<br><br>* Avoid sign-compare warning when comparing string<br>  lengths<=
br>* Use the nicer alias rfc822Name instead of the general ia5<br>  from th=
e GENERAL_NAME union.<br>* Use the official ASN1_STRING_length API instead =
of accessing<br>  the struct directly.<br>* C11 changes<br><br>Change-Id: I=
23cc00aee47aef007ab2e7d50b52c6de299505db<br>Signed-off-by: Frank Lichtenhel=
d &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/ssl_verify_openssl.c<br>=
1 file changed, 6 insertions(+), 17 deletions(-)<br><br></pre><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/07/1507/2</pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><=
span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify=
_openssl.c</span><br><span>index 58f665c..46401cd 100644</span><br><span>--=
- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/openvpn/ssl_=
verify_openssl.c</span><br><span>@@ -118,16 +118,10 @@</span><br><span>    =
 return nid =3D=3D NID_subject_alt_name || nid =3D=3D NID_issuer_alt_name;<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &=
quot;-Wsign-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> static bool</span><br><span> extract_x509_extension(X509 *cert, char=
 *fieldname, char *out, size_t size)</span><br><span> {</span><br><span>   =
  bool retval =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    char *buf =3D 0;</span><br><span> </span><br><span>     if (!x509_us=
ername_field_ext_supported(fieldname))</span><br><span>     {</span><br><sp=
an>@@ -139,29 +133,28 @@</span><br><span>     GENERAL_NAMES *extensions =3D=
 X509_get_ext_d2i(cert, nid, NULL, NULL);</span><br><span>     if (extensio=
ns)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        int numalts;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int i;</span><br><span>         /* get amount of alternatives,<=
/span><br><span>          * RFC2459 claims there MUST be at least</span><br=
><span>          * one, but we don&#39;t depend on it...</span><br><span>  =
        */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        numalts =3D sk_GENERAL_NAME_num(extensions);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        int numalts =3D sk_GENERAL_=
NAME_num(extensions);</span><br><span> </span><br><span>         /* loop th=
rough all alternatives */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        for (i =3D 0; i &lt; numalts; i++)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; numalts; i++)</=
span><br><span>         {</span><br><span>             /* get a handle to a=
lternative name number i */</span><br><span>             const GENERAL_NAME=
 *name =3D sk_GENERAL_NAME_value(extensions, i);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            char *buf =3D NULL;</span><br><spa=
n> </span><br><span>             switch (name-&gt;type)</span><br><span>   =
          {</span><br><span>                 case GEN_EMAIL:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    if (ASN1_STRING_=
to_UTF8((unsigned char **)&amp;buf, name-&gt;d.ia5) &lt; 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    if (ASN1_STRING=
_to_UTF8((unsigned char **)&amp;buf, name-&gt;d.rfc822Name) &lt; 0)</span><=
br><span>                     {</span><br><span>                         co=
ntinue;</span><br><span>                     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    if (strlen(buf) !=3D name-&gt;=
d.ia5-&gt;length)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  if ((ssize_t)strlen(buf) !=3D ASN1_STRING_length(name-&gt=
;d.rfc822Name))</span><br><span>                     {</span><br><span>    =
                     msg(D_TLS_ERRORS, &quot;ASN1 ERROR: string contained t=
erminating zero&quot;);</span><br><span>                         OPENSSL_fr=
ee(buf);</span><br><span>@@ -175,7 +168,7 @@</span><br><span>              =
       break;</span><br><span> </span><br><span>                 default:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg=
(D_TLS_DEBUG, &quot;%s: ignoring general name field type %i&quot;, __func__=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  msg(D_TLS_DEBUG, &quot;%s: ignoring general name field type %d&quot;, __f=
unc__,</span><br><span>                         name-&gt;type);</span><br><=
span>                     break;</span><br><span>             }</span><br><=
span>@@ -185,10 +178,6 @@</span><br><span>     return retval;</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> /*</span><br><span>  * Extract a field from=
 an X509 subject name.</span><br><span>  *</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?us=
p=3Demail">change 1507</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1507?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23cc00aee47aef007ab2e7d50b5=
2c6de299505db </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1507 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--Y9IMFnyVPok=--

