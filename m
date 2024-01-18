From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Jan 2024 17:49:29 +0000
In-Reply-To: <gerrit.1705068839000.Iec74e88f86cd15328f993b6cdd0317ebda81563c@...2715...>
References: <gerrit.1705068839000.Iec74e88f86cd15328f993b6cdd0317ebda81563c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6c153abf5da1fc4d1fcdeb34df369739eecfecd7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Jomh2E6wwq8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: NTLM: when NTLMv1 is
 requested, try NTLMv2 instead
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

--Jomh2E6wwq8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/500?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: NTLM: when NTLMv1 is requested, try NTLMv2 instead
......................................................................

NTLM: when NTLMv1 is requested, try NTLMv2 instead

Commit 21910ebc2ee8a6138eb2af8d38056d2b94e59f9c removed
support for NTLMv1 authentication. This adjusts the
behavior for existing configurations that specify
"ntlm" keyword.

Do not error out hard, instead just try to upgrade. This
should work fine in many cases and will avoid breaking
user configs unnecessarily on upgrade.

In addition it fixes an issue with the mentioned patch
where "auto" wasn't working correctly for NTLM anymore.

Change-Id: Iec74e88f86cd15328f993b6cdd0317ebda81563c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240118151242.12169-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20240118151242.12169-1=
-gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M Changes.rst
M doc/man-sections/proxy-options.rst
M src/openvpn/proxy.c
3 files changed, 18 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/500/2

diff --git a/Changes.rst b/Changes.rst
index 69c811d..58cb3db 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -12,8 +12,13 @@
     ``--allow-deprecated-insecure-static-crypto`` but will be removed in
     OpenVPN 2.8.

-NTLMv1 support has been removed because it is completely insecure.
-    NTLMv2 support is still available, but will removed in a future releas=
e.
+NTLMv1 authentication support for HTTP proxies has been removed.
+    This is considered an insecure method of authentication that uses
+    obsolete crypto algorithms.
+    NTLMv2 support is still available, but will be removed in a future
+    release.
+    When configured to authenticate with NTLMv1 (``ntlm`` keyword in
+    ``--http-proxy``) OpenVPN will try NTLMv2 instead.


 Overview of changes in 2.6
diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-op=
tions.rst
index ad49c60..38c4578 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -48,6 +48,8 @@
      </http-proxy-user-pass>

   Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.
+  :code:`ntlm` now is an alias for :code:`ntlm2`; i.e. OpenVPN will always
+  attempt to use NTLMv2 authentication.

 --http-proxy-user-pass userpass
   Overwrite the username/password information for ``--http-proxy``. If spe=
cified
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index e081532..2e8d7a8 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -497,7 +497,7 @@
         msg(M_FATAL, "HTTP_PROXY: server not specified");
     }

-    ASSERT( o->port);
+    ASSERT(o->port);

     ALLOC_OBJ_CLEAR(p, struct http_proxy_info);
     p->options =3D *o;
@@ -517,7 +517,8 @@
 #if NTLM
         else if (!strcmp(o->auth_method_string, "ntlm"))
         {
-            msg(M_FATAL, "ERROR: NTLM v1 support has been removed. For now=
, you can use NTLM v2 by selecting ntlm2 but it is deprecated as well.");
+            msg(M_WARN, "NTLM v1 authentication has been removed in OpenVP=
N 2.7. Will try to use NTLM v2 authentication.");
+            p->auth_method =3D HTTP_AUTH_NTLM2;
         }
         else if (!strcmp(o->auth_method_string, "ntlm2"))
         {
@@ -531,7 +532,9 @@
         }
     }

-    /* only basic and NTLM/NTLMv2 authentication supported so far */
+    /* When basic or NTLMv2 authentication is requested, get credentials n=
ow.
+     * In case of "auto" negotiation credentials will be retrieved later o=
nce
+     * we know whether we need any. */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM2)
     {
         get_user_pass_http(p, true);
@@ -644,7 +647,8 @@

     /* get user/pass if not previously given */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC
-        || p->auth_method =3D=3D HTTP_AUTH_DIGEST)
+        || p->auth_method =3D=3D HTTP_AUTH_DIGEST
+        || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, false);
     }
@@ -748,7 +752,7 @@
         {
             processed =3D true;
         }
-        else if ((p->auth_method =3D=3D HTTP_AUTH_NTLM2) && !processed) /*=
 check for NTLM */
+        else if (p->auth_method =3D=3D HTTP_AUTH_NTLM2 && !processed) /* c=
heck for NTLM */
         {
 #if NTLM
             /* look for the phase 2 response */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/500?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iec74e88f86cd15328f993b6cdd0317ebda81563c
Gerrit-Change-Number: 500
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--Jomh2E6wwq8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/500?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">NTLM: when NTLMv1 is requested, try NTLMv2 inste=
ad<br><br>Commit 21910ebc2ee8a6138eb2af8d38056d2b94e59f9c removed<br>suppor=
t for NTLMv1 authentication. This adjusts the<br>behavior for existing conf=
igurations that specify<br>&quot;ntlm&quot; keyword.<br><br>Do not error ou=
t hard, instead just try to upgrade. This<br>should work fine in many cases=
 and will avoid breaking<br>user configs unnecessarily on upgrade.<br><br>I=
n addition it fixes an issue with the mentioned patch<br>where &quot;auto&q=
uot; wasn&#39;t working correctly for NTLM anymore.<br><br>Change-Id: Iec74=
e88f86cd15328f993b6cdd0317ebda81563c<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2477...=
.&gt;<br>Message-Id: &lt;20240118151242.12169-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/search?l=3Dmid&amp;q=3D20240118151242.12169-1=
-gert@...1296...<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M Changes.rst<br>M doc/man-sections/proxy-options.rst<br>M src/openv=
pn/proxy.c<br>3 files changed, 18 insertions(+), 7 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/500/2</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/Changes.rst b/Changes.rst</span><br><span>index 69c811d..58c=
b3db 100644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes=
.rst</span><br><span>@@ -12,8 +12,13 @@</span><br><span>     ``--allow-depr=
ecated-insecure-static-crypto`` but will be removed in</span><br><span>    =
 OpenVPN 2.8.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-NTLMv1 support has been removed because it is completely insecure=
.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NTLMv2 support i=
s still available, but will removed in a future release.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+NTLMv1 authentication support for HTTP=
 proxies has been removed.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    This is considered an insecure method of authentication that use=
s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    obsolete crypt=
o algorithms.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    NT=
LMv2 support is still available, but will be removed in a future</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    release.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    When configured to authenticate w=
ith NTLMv1 (``ntlm`` keyword in</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    ``--http-proxy``) OpenVPN will try NTLMv2 instead.</span><b=
r><span> </span><br><span> </span><br><span> Overview of changes in 2.6</sp=
an><br><span>diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sect=
ions/proxy-options.rst</span><br><span>index ad49c60..38c4578 100644</span>=
<br><span>--- a/doc/man-sections/proxy-options.rst</span><br><span>+++ b/do=
c/man-sections/proxy-options.rst</span><br><span>@@ -48,6 +48,8 @@</span><b=
r><span>      &lt;/http-proxy-user-pass&gt;</span><br><span> </span><br><sp=
an>   Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`ntlm` now is =
an alias for :code:`ntlm2`; i.e. OpenVPN will always</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  attempt to use NTLMv2 authentication.</=
span><br><span> </span><br><span> --http-proxy-user-pass userpass</span><br=
><span>   Overwrite the username/password information for ``--http-proxy``.=
 If specified</span><br><span>diff --git a/src/openvpn/proxy.c b/src/openvp=
n/proxy.c</span><br><span>index e081532..2e8d7a8 100644</span><br><span>---=
 a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br>=
<span>@@ -497,7 +497,7 @@</span><br><span>         msg(M_FATAL, &quot;HTTP_=
PROXY: server not specified&quot;);</span><br><span>     }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT( o-&gt;po=
rt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(o-&g=
t;port);</span><br><span> </span><br><span>     ALLOC_OBJ_CLEAR(p, struct h=
ttp_proxy_info);</span><br><span>     p-&gt;options =3D *o;</span><br><span=
>@@ -517,7 +517,8 @@</span><br><span> #if NTLM</span><br><span>         els=
e if (!strcmp(o-&gt;auth_method_string, &quot;ntlm&quot;))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 msg(M_FATAL, &quot;ERROR: NTLM v1 support has been removed. For now, you c=
an use NTLM v2 by selecting ntlm2 but it is deprecated as well.&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_WARN,=
 &quot;NTLM v1 authentication has been removed in OpenVPN 2.7. Will try to =
use NTLM v2 authentication.&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            p-&gt;auth_method =3D HTTP_AUTH_NTLM2;</span><b=
r><span>         }</span><br><span>         else if (!strcmp(o-&gt;auth_met=
hod_string, &quot;ntlm2&quot;))</span><br><span>         {</span><br><span>=
@@ -531,7 +532,9 @@</span><br><span>         }</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* on=
ly basic and NTLM/NTLMv2 authentication supported so far */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* When basic or NTLMv2 authent=
ication is requested, get credentials now.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * In case of &quot;auto&quot; negotiation crede=
ntials will be retrieved later once</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+     * we know whether we need any. */</span><br><span>    =
 if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;auth_method =3D=3D H=
TTP_AUTH_NTLM2)</span><br><span>     {</span><br><span>         get_user_pa=
ss_http(p, true);</span><br><span>@@ -644,7 +647,8 @@</span><br><span> </sp=
an><br><span>     /* get user/pass if not previously given */</span><br><sp=
an>     if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        || p-&gt;auth_method =3D=3D HTTP_AU=
TH_DIGEST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        |=
| p-&gt;auth_method =3D=3D HTTP_AUTH_DIGEST</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        || p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2=
)</span><br><span>     {</span><br><span>         get_user_pass_http(p, fal=
se);</span><br><span>     }</span><br><span>@@ -748,7 +752,7 @@</span><br><=
span>         {</span><br><span>             processed =3D true;</span><br>=
<span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   else if ((p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2) &amp;&amp; !processe=
d) /* check for NTLM */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        else if (p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2 &amp;&amp; !p=
rocessed) /* check for NTLM */</span><br><span>         {</span><br><span> =
#if NTLM</span><br><span>             /* look for the phase 2 response */</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/500?usp=3Demail">change 500</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/500?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec74e88f86cd15328f993b6cdd0=
317ebda81563c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 500 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Jomh2E6wwq8=--

