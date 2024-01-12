From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Jan 2024 14:14:09 +0000
References: <gerrit.1705068839000.Iec74e88f86cd15328f993b6cdd0317ebda81563c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <5cf59510bcf2f3efe2531d82075991a765373faa-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ef1tDOPsmjE="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ef1tDOPsmjE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/500?usp=3Demail

to review the following change.


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
---
M Changes.rst
M doc/man-sections/proxy-options.rst
M src/openvpn/proxy.c
3 files changed, 18 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/500/1

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
index e2324f4..eeb3989 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -502,7 +502,7 @@
         msg(M_FATAL, "HTTP_PROXY: server not specified");
     }

-    ASSERT( o->port);
+    ASSERT(o->port);

     ALLOC_OBJ_CLEAR(p, struct http_proxy_info);
     p->options =3D *o;
@@ -522,7 +522,8 @@
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
@@ -536,7 +537,9 @@
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
@@ -649,7 +652,8 @@

     /* get user/pass if not previously given */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC
-        || p->auth_method =3D=3D HTTP_AUTH_DIGEST)
+        || p->auth_method =3D=3D HTTP_AUTH_DIGEST
+        || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, false);
     }
@@ -753,7 +757,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ef1tDOPsmjE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/500?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">NTLM: when NTLMv1 is requested, try NTLMv2 instead<br><br>Com=
mit 21910ebc2ee8a6138eb2af8d38056d2b94e59f9c removed<br>support for NTLMv1 =
authentication. This adjusts the<br>behavior for existing configurations th=
at specify<br>&quot;ntlm&quot; keyword.<br><br>Do not error out hard, inste=
ad just try to upgrade. This<br>should work fine in many cases and will avo=
id breaking<br>user configs unnecessarily on upgrade.<br><br>In addition it=
 fixes an issue with the mentioned patch<br>where &quot;auto&quot; wasn&#39=
;t working correctly for NTLM anymore.<br><br>Change-Id: Iec74e88f86cd15328=
f993b6cdd0317ebda81563c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>---<br>M Changes.rst<br>M doc/man-sections/proxy-options.rst<b=
r>M src/openvpn/proxy.c<br>3 files changed, 18 insertions(+), 7 deletions(-=
)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00=
/500/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>index=
 69c811d..58cb3db 100644</span><br><span>--- a/Changes.rst</span><br><span>=
+++ b/Changes.rst</span><br><span>@@ -12,8 +12,13 @@</span><br><span>     `=
`--allow-deprecated-insecure-static-crypto`` but will be removed in</span><=
br><span>     OpenVPN 2.8.</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-NTLMv1 support has been removed because it is comple=
tely insecure.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    NTL=
Mv2 support is still available, but will removed in a future release.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+NTLMv1 authentication sup=
port for HTTP proxies has been removed.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    This is considered an insecure method of authentica=
tion that uses</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    o=
bsolete crypto algorithms.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    NTLMv2 support is still available, but will be removed in a futu=
re</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    release.</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    When configured to a=
uthenticate with NTLMv1 (``ntlm`` keyword in</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ``--http-proxy``) OpenVPN will try NTLMv2 inst=
ead.</span><br><span> </span><br><span> </span><br><span> Overview of chang=
es in 2.6</span><br><span>diff --git a/doc/man-sections/proxy-options.rst b=
/doc/man-sections/proxy-options.rst</span><br><span>index ad49c60..38c4578 =
100644</span><br><span>--- a/doc/man-sections/proxy-options.rst</span><br><=
span>+++ b/doc/man-sections/proxy-options.rst</span><br><span>@@ -48,6 +48,=
8 @@</span><br><span>      &lt;/http-proxy-user-pass&gt;</span><br><span> <=
/span><br><span>   Note that support for NTLMv1 proxies was removed with Op=
enVPN 2.7.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  :code:`=
ntlm` now is an alias for :code:`ntlm2`; i.e. OpenVPN will always</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+  attempt to use NTLMv2 authe=
ntication.</span><br><span> </span><br><span> --http-proxy-user-pass userpa=
ss</span><br><span>   Overwrite the username/password information for ``--h=
ttp-proxy``. If specified</span><br><span>diff --git a/src/openvpn/proxy.c =
b/src/openvpn/proxy.c</span><br><span>index e2324f4..eeb3989 100644</span><=
br><span>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.=
c</span><br><span>@@ -502,7 +502,7 @@</span><br><span>         msg(M_FATAL,=
 &quot;HTTP_PROXY: server not specified&quot;);</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSE=
RT( o-&gt;port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 ASSERT(o-&gt;port);</span><br><span> </span><br><span>     ALLOC_OBJ_CLEAR=
(p, struct http_proxy_info);</span><br><span>     p-&gt;options =3D *o;</sp=
an><br><span>@@ -522,7 +522,8 @@</span><br><span> #if NTLM</span><br><span>=
         else if (!strcmp(o-&gt;auth_method_string, &quot;ntlm&quot;))</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(M_FATAL, &quot;ERROR: NTLM v1 support has been removed. Fo=
r now, you can use NTLM v2 by selecting ntlm2 but it is deprecated as well.=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 msg(M_WARN, &quot;NTLM v1 authentication has been removed in OpenVPN 2.7. =
Will try to use NTLM v2 authentication.&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            p-&gt;auth_method =3D HTTP_AUTH_NTL=
M2;</span><br><span>         }</span><br><span>         else if (!strcmp(o-=
&gt;auth_method_string, &quot;ntlm2&quot;))</span><br><span>         {</spa=
n><br><span>@@ -536,7 +537,9 @@</span><br><span>         }</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    /* only basic and NTLM/NTLMv2 authentication supported so far */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* When basic or NT=
LMv2 authentication is requested, get credentials now.</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * In case of &quot;auto&quot; negot=
iation credentials will be retrieved later once</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * we know whether we need any. */</span><b=
r><span>     if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;auth_met=
hod =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><span>        =
 get_user_pass_http(p, true);</span><br><span>@@ -649,7 +652,8 @@</span><br=
><span> </span><br><span>     /* get user/pass if not previously given */</=
span><br><span>     if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        || p-&gt;auth_method =3D=
=3D HTTP_AUTH_DIGEST)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        || p-&gt;auth_method =3D=3D HTTP_AUTH_DIGEST</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        || p-&gt;auth_method =3D=3D HTTP=
_AUTH_NTLM2)</span><br><span>     {</span><br><span>         get_user_pass_=
http(p, false);</span><br><span>     }</span><br><span>@@ -753,7 +757,7 @@<=
/span><br><span>         {</span><br><span>             processed =3D true;=
</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        else if ((p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2) &amp;&amp=
; !processed) /* check for NTLM */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        else if (p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2 &a=
mp;&amp; !processed) /* check for NTLM */</span><br><span>         {</span>=
<br><span> #if NTLM</span><br><span>             /* look for the phase 2 re=
sponse */</span><br><span></span><br></pre><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/500?usp=3Demail">change 500</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/500?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iec74e88f86cd15328f993b6cdd0=
317ebda81563c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 500 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ef1tDOPsmjE=--

