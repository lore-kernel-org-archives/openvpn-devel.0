From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 13:37:00 +0000
In-Reply-To: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
References: <gerrit.1775698562000.I6e7947ab81cf229f0d27714dd563a07ace6bd38a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <a1f7cd9c57c477dcbbca43ed06042cb8eb5d06e6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TSKAkA6BaOI="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TSKAkA6BaOI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/24/1624/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a
Gerrit-Change-Number: 1624
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <antonio@...2726...>

--TSKAkA6BaOI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">verify_x509_name: Improve the e=
rror message on failure<br><br>Print the actual string that was used for th=
e match instead of the<br>whole subject.<br><br>Github: closes OpenVPN/open=
vpn#992<br><br>Change-Id: I6e7947ab81cf229f0d27714dd563a07ace6bd38a<br>Sign=
ed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Arne Schwab=
e &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net=
/c/openvpn/+/1624<br>Message-Id: &lt;20260414055830.17032-1-gert@...1296...=
&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg36606.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/ssl_verify.c<br>1 file changed, 22 insertions(+), 11 d=
eletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/24/1624/2</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/ssl_ver=
ify.c b/src/openvpn/ssl_verify.c</span><br><span>index d44f25f..21b516d 100=
644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify.c</span><br><span>@@ -369,21 +369,32 @@</span><br><spa=
n>     /* verify X509 name or username against --verify-x509-[user]name */<=
/span><br><span>     if (opt-&gt;verify_x509_type !=3D VERIFY_X509_NONE)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if ((opt-&gt;verify_x509_type =3D=3D VERIFY_X509_SUBJECT_DN</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; strcmp=
(opt-&gt;verify_x509_name, subject) =3D=3D 0)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            || (opt-&gt;verify_x509_type =3D=3D VER=
IFY_X509_SUBJECT_RDN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               &amp;&amp; strcmp(opt-&gt;verify_x509_name, common_name) =3D=
=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || =
(opt-&gt;verify_x509_type =3D=3D VERIFY_X509_SUBJECT_RDN_PREFIX</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; strncm=
p(opt-&gt;verify_x509_name, common_name, strlen(opt-&gt;verify_x509_name)) =
=3D=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst char *err_fmt =3D &quot;VERIFY X509NAME ERROR: %s, must be %s&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *m=
atch_str =3D common_name;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        bool verified =3D false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        switch (opt-&gt;verify_x509_type)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(D_HANDSHAKE, &quot;VERIFY X509NAME OK: %s&quot;, subject);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            case VERIFY_X509_=
SUBJECT_DN:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        match_str =3D subject;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                verified =3D !strcmp(opt-&gt;verify_x509_name, m=
atch_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      case VERIFY_X509_SUBJECT_RDN:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                verified =3D !strcmp(opt-&gt;verify_x509_na=
me, match_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           case VERIFY_X509_SUBJECT_RDN_PREFIX:</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                err_fmt =3D &quot;VERIFY X509NA=
ME ERROR: %s, must start with %s&quot;;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                verified =3D !strncmp(opt-&gt;verify_x5=
09_name, match_str, strlen(opt-&gt;verify_x509_name));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            default:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                ASSERT(0); /* should=
 not happen */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           break;</span><br><span>         }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        if (!verified)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_HANDSHAKE, &q=
uot;VERIFY X509NAME ERROR: %s, must be %s&quot;, subject,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                opt-&gt;verify_x509_nam=
e);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            return=
 FAILURE; /* Reject connection */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            msg(D_HANDSHAKE, err_fmt, match_str, opt-&gt;veri=
fy_x509_name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       return FAILURE;</span><br><span>         }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(D_HANDSHAKE, &quot;VERIFY X509NAM=
E OK: %s&quot;, subject);</span><br><span>     }</span><br><span> </span><b=
r><span>     return SUCCESS;</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail">cha=
nge 1624</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1624?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--TSKAkA6BaOI=--

