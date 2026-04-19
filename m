From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 13:37:05 +0000
In-Reply-To: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
References: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <a1f7cd9c57c477dcbbca43ed06042cb8eb5d06e6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Yhcu+ijaJ20="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: verify_x509_name:
 Improve the error message on failure
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Yhcu+ijaJ20=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
24?usp=3Demail )

Change subject: verify_x509_name: Improve the error message on failure
......................................................................

verify_x509_name: Improve the error message on failure

Print the actual string that was used for the match instead of the
whole subject.

Github: closes OpenVPN/openvpn#992

Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1624
Message-Id: <20260414055830.17032-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
606.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/ssl_verify.c
1 file changed, 22 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d44f25f..21b516d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -369,21 +369,32 @@
     /* verify X509 name or username against --verify-x509-[user]name */
     if (opt->verify_x509_type !=3D VERIFY_X509_NONE)
     {
-        if ((opt->verify_x509_type =3D=3D VERIFY_X509_SUBJECT_DN
-             && strcmp(opt->verify_x509_name, subject) =3D=3D 0)
-            || (opt->verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN
-                && strcmp(opt->verify_x509_name, common_name) =3D=3D 0)
-            || (opt->verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN_PREFIX
-                && strncmp(opt->verify_x509_name, common_name, strlen(opt-=
>verify_x509_name)) =3D=3D 0))
+        const char *err_fmt =3D "VERIFY X509NAME ERROR: %s, must be %s";
+        const char *match_str =3D common_name;
+        bool verified =3D false;
+        switch (opt->verify_x509_type)
         {
-            msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
+            case VERIFY_X509_SUBJECT_DN:
+                match_str =3D subject;
+                verified =3D !strcmp(opt->verify_x509_name, match_str);
+                break;
+            case VERIFY_X509_SUBJECT_RDN:
+                verified =3D !strcmp(opt->verify_x509_name, match_str);
+                break;
+            case VERIFY_X509_SUBJECT_RDN_PREFIX:
+                err_fmt =3D "VERIFY X509NAME ERROR: %s, must start with %s=
";
+                verified =3D !strncmp(opt->verify_x509_name, match_str, st=
rlen(opt->verify_x509_name));
+                break;
+            default:
+                ASSERT(0); /* should not happen */
+                break;
         }
-        else
+        if (!verified)
         {
-            msg(D_HANDSHAKE, "VERIFY X509NAME ERROR: %s, must be %s", subj=
ect,
-                opt->verify_x509_name);
-            return FAILURE; /* Reject connection */
+            msg(D_HANDSHAKE, err_fmt, match_str, opt->verify_x509_name);
+            return FAILURE;
         }
+        msg(D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
     }

     return SUCCESS;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Gerrit-Change-Number: 1624
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>

--Yhcu+ijaJ20=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1624?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">verify_x509_name: Improve the error message on f=
ailure<br><br>Print the actual string that was used for the match instead o=
f the<br>whole subject.<br><br>Github: closes OpenVPN/openvpn#992<br><br>Ch=
ange-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a<br>Signed-off-by: Selva =
Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvp=
n@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1624=
<br>Message-Id: &lt;20260414055830.17032-1-gert@...1296...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36606.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/ssl_verify.c<br>1 file changed, 22 insertions(+), 11 deletions(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><=
br><span>index d44f25f..21b516d 100644</span><br><span>--- a/src/openvpn/ss=
l_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@=
@ -369,21 +369,32 @@</span><br><span>     /* verify X509 name or username a=
gainst --verify-x509-[user]name */</span><br><span>     if (opt-&gt;verify_=
x509_type !=3D VERIFY_X509_NONE)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if ((opt-&gt;verify_x509_type =3D=
=3D VERIFY_X509_SUBJECT_DN</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-             &amp;&amp; strcmp(opt-&gt;verify_x509_name, subject) =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || =
(opt-&gt;verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; strcmp(opt-&g=
t;verify_x509_name, common_name) =3D=3D 0)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            || (opt-&gt;verify_x509_type =3D=3D VERIFY=
_X509_SUBJECT_RDN_PREFIX</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                &amp;&amp; strncmp(opt-&gt;verify_x509_name, common_name=
, strlen(opt-&gt;verify_x509_name)) =3D=3D 0))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        const char *err_fmt =3D &quot;VERIFY X50=
9NAME ERROR: %s, must be %s&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        const char *match_str =3D common_name;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        bool verified =3D false;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        switch (opt-=
&gt;verify_x509_type)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(D_HANDSHAKE, &quot;VERIFY X509NA=
ME OK: %s&quot;, subject);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            case VERIFY_X509_SUBJECT_DN:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                match_str =3D subject;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                verified =3D=
 !strcmp(opt-&gt;verify_x509_name, match_str);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                break;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            case VERIFY_X509_SUBJECT_RDN:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                verifie=
d =3D !strcmp(opt-&gt;verify_x509_name, match_str);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            case VERIFY_X509_SUBJECT_R=
DN_PREFIX:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       err_fmt =3D &quot;VERIFY X509NAME ERROR: %s, must start with %s&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                v=
erified =3D !strncmp(opt-&gt;verify_x509_name, match_str, strlen(opt-&gt;ve=
rify_x509_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            default:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                ASSERT(0); /* should not happen */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span>  =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!verifie=
d)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            msg(D_HANDSHAKE, &quot;VERIFY X509NAME ERROR: %s, must =
be %s&quot;, subject,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                opt-&gt;verify_x509_name);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            return FAILURE; /* Reject connection */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_HAND=
SHAKE, err_fmt, match_str, opt-&gt;verify_x509_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return FAILURE;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  msg(D_HANDSHAKE, &quot;VERIFY X509NAME OK: %s&quot;, subject);</span><br>=
<span>     }</span><br><span> </span><br><span>     return SUCCESS;</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1624?usp=3Demail">change 1624</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1624?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd56=
3a07ace6bd38a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1624 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;antonio@...2726...&gt; </=
div>

</body></html>=

--Yhcu+ijaJ20=--

