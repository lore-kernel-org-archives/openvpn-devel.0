From: "selvanair (Code Review)" <gerrit@...515...>
Date: Thu, 9 Apr 2026 01:36:04 +0000
References: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <7c42735bcfb874cb92a81ae2084bf779776300a7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6erYe6E65sY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6erYe6E65sY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail

to review the following change.


Change subject: verify_x509_name: Improve the error message on failure
......................................................................

verify_x509_name: Improve the error message on failure

Print the actual string that was used for the match instead of the
whole subject.

Github: closes OpenVPN/openvpn#992

Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpn/ssl_verify.c
1 file changed, 22 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1624/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Gerrit-Change-Number: 1624
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6erYe6E65sY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">verify_x509_name: Improve the error message=
 on failure<br><br>Print the actual string that was used for the match inst=
ead of the<br>whole subject.<br><br>Github: closes OpenVPN/openvpn#992<br><=
br>Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a<br>Signed-off-by: S=
elva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpn/ssl_verify.c=
<br>1 file changed, 22 insertions(+), 11 deletions(-)<br><br></pre><pre cla=
ss=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1624/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c<=
/span><br><span>index d44f25f..21b516d 100644</span><br><span>--- a/src/ope=
nvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br>=
<span>@@ -369,21 +369,32 @@</span><br><span>     /* verify X509 name or use=
rname against --verify-x509-[user]name */</span><br><span>     if (opt-&gt;=
verify_x509_type !=3D VERIFY_X509_NONE)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if ((opt-&gt;verify_x509_t=
ype =3D=3D VERIFY_X509_SUBJECT_DN</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-             &amp;&amp; strcmp(opt-&gt;verify_x509_name, subjec=
t) =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   || (opt-&gt;verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; strcmp(=
opt-&gt;verify_x509_name, common_name) =3D=3D 0)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            || (opt-&gt;verify_x509_type =3D=3D =
VERIFY_X509_SUBJECT_RDN_PREFIX</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                &amp;&amp; strncmp(opt-&gt;verify_x509_name, commo=
n_name, strlen(opt-&gt;verify_x509_name)) =3D=3D 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const char *err_fmt =3D &quot;VER=
IFY X509NAME ERROR: %s, must be %s&quot;;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        const char *match_str =3D common_name;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        bool verified =3D =
false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        switc=
h (opt-&gt;verify_x509_type)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            msg(D_HANDSHAKE, &quot;VERIFY=
 X509NAME OK: %s&quot;, subject);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            case VERIFY_X509_SUBJECT_DN:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                match_str =3D subject;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                verif=
ied =3D !strcmp(opt-&gt;verify_x509_name, match_str);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            case VERIFY_X509_SUBJECT_R=
DN:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
verified =3D !strcmp(opt-&gt;verify_x509_name, match_str);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            case VERIFY_X509_SUBJ=
ECT_RDN_PREFIX:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            err_fmt =3D &quot;VERIFY X509NAME ERROR: %s, must start with %s=
&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    verified =3D !strncmp(opt-&gt;verify_x509_name, match_str, strlen(opt-&=
gt;verify_x509_name));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                break;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            default:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                ASSERT(0); /* should not happen */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><spa=
n>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!ver=
ified)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            msg(D_HANDSHAKE, &quot;VERIFY X509NAME ERROR: %s, m=
ust be %s&quot;, subject,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                opt-&gt;verify_x509_name);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            return FAILURE; /* Reject connection *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_=
HANDSHAKE, err_fmt, match_str, opt-&gt;verify_x509_name);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            return FAILURE;</span><br=
><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      msg(D_HANDSHAKE, &quot;VERIFY X509NAME OK: %s&quot;, subject);</span>=
<br><span>     }</span><br><span> </span><br><span>     return SUCCESS;</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1624?usp=3Demail">change 1624</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1624?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd56=
3a07ace6bd38a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1624 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--6erYe6E65sY=--

