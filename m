From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Jan 2024 14:14:08 +0000
References: <gerrit.1705068839000.I6f402db2fb73f1206fbc1139c47d2bf4378376fa@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <57157c23530a1bdd1e4e62d97ecf23369cd3159e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vCI7bLkr02k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]:
 --http-proxy-user-pass: allow to specify in either order with --http-...
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

--vCI7bLkr02k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/499?usp=3Demail

to review the following change.


Change subject: --http-proxy-user-pass: allow to specify in either order wi=
th --http-proxy
......................................................................

--http-proxy-user-pass: allow to specify in either order with --http-proxy

Previously, when using a third argument to --http-proxy other
than auto/auto-nct, order did matter between --http-proxy and
--http-proxy-user-pass. Always prefer --http-proxy-user-pass
when given.

Change-Id: I6f402db2fb73f1206fbc1139c47d2bf4378376fa
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
3 files changed, 11 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/499/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f54f276..e393511 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1649,6 +1649,8 @@
     SHOW_STR(port);
     SHOW_STR(auth_method_string);
     SHOW_STR(auth_file);
+    SHOW_STR(auth_file_up);
+    SHOW_BOOL(inline_creds);
     SHOW_STR(http_version);
     SHOW_STR(user_agent);
     for  (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name=
; i++)
@@ -6824,7 +6826,7 @@
         struct http_proxy_options *ho;
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);
         ho =3D init_http_proxy_options_once(&options->ce.http_proxy_option=
s, &options->gc);
-        ho->auth_file =3D p[1];
+        ho->auth_file_up =3D p[1];
         ho->inline_creds =3D is_inline;
     }
     else if (streq(p[0], "http-proxy-retry") || streq(p[0], "socks-proxy-r=
etry"))
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index e081532..e2324f4 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -271,6 +271,11 @@
     if (!static_proxy_user_pass.defined)
     {
         unsigned int flags =3D GET_USER_PASS_MANAGEMENT;
+        const char *auth_file =3D p->options.auth_file;
+        if (p->options.auth_file_up)
+        {
+            auth_file =3D p->options.auth_file_up;
+        }
         if (p->queried_creds)
         {
             flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED;
@@ -280,7 +285,7 @@
             flags |=3D GET_USER_PASS_INLINE_CREDS;
         }
         get_user_pass(&static_proxy_user_pass,
-                      p->options.auth_file,
+                      auth_file,
                       UP_TYPE_PROXY,
                       flags);
         p->queried_creds =3D true;
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 7900244..4e78772 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -52,10 +52,11 @@

     const char *auth_method_string;
     const char *auth_file;
+    const char *auth_file_up; /* specified with --http-proxy-user-pass */
     const char *http_version;
     const char *user_agent;
     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
-    bool inline_creds;
+    bool inline_creds; /* auth_file_up is inline credentials */
 };

 struct http_proxy_options_simple {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/499?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6f402db2fb73f1206fbc1139c47d2bf4378376fa
Gerrit-Change-Number: 499
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--vCI7bLkr02k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/499?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">--http-proxy-user-pass: allow to specify in either order with=
 --http-proxy<br><br>Previously, when using a third argument to --http-prox=
y other<br>than auto/auto-nct, order did matter between --http-proxy and<br=
>--http-proxy-user-pass. Always prefer --http-proxy-user-pass<br>when given=
.<br><br>Change-Id: I6f402db2fb73f1206fbc1139c47d2bf4378376fa<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/opt=
ions.c<br>M src/openvpn/proxy.c<br>M src/openvpn/proxy.h<br>3 files changed=
, 11 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/99/499/1</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/op=
tions.c b/src/openvpn/options.c</span><br><span>index f54f276..e393511 1006=
44</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/op=
envpn/options.c</span><br><span>@@ -1649,6 +1649,8 @@</span><br><span>     =
SHOW_STR(port);</span><br><span>     SHOW_STR(auth_method_string);</span><b=
r><span>     SHOW_STR(auth_file);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    SHOW_STR(auth_file_up);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    SHOW_BOOL(inline_creds);</span><br><span>     SHO=
W_STR(http_version);</span><br><span>     SHOW_STR(user_agent);</span><br><=
span>     for  (i =3D 0; i &lt; MAX_CUSTOM_HTTP_HEADER &amp;&amp; o-&gt;cus=
tom_headers[i].name; i++)</span><br><span>@@ -6824,7 +6826,7 @@</span><br><=
span>         struct http_proxy_options *ho;</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_GENERAL|OPT_P_INLINE);</span><br><span>         ho =3D i=
nit_http_proxy_options_once(&amp;options-&gt;ce.http_proxy_options, &amp;op=
tions-&gt;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ho-&gt;auth_file =3D p[1];</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ho-&gt;auth_file_up =3D p[1];</span><br><span>         ho-&=
gt;inline_creds =3D is_inline;</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;http-proxy-retry&quot;) || streq(p[0], &quot;soc=
ks-proxy-retry&quot;))</span><br><span>diff --git a/src/openvpn/proxy.c b/s=
rc/openvpn/proxy.c</span><br><span>index e081532..e2324f4 100644</span><br>=
<span>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</=
span><br><span>@@ -271,6 +271,11 @@</span><br><span>     if (!static_proxy_=
user_pass.defined)</span><br><span>     {</span><br><span>         unsigned=
 int flags =3D GET_USER_PASS_MANAGEMENT;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const char *auth_file =3D p-&gt;options.auth_f=
ile;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p-&=
gt;options.auth_file_up)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       auth_file =3D p-&gt;options.auth_file_up;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span>         if (p-&gt;q=
ueried_creds)</span><br><span>         {</span><br><span>             flags=
 |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED;</span><br><span>@@ -280,7 +285,7=
 @@</span><br><span>             flags |=3D GET_USER_PASS_INLINE_CREDS;</sp=
an><br><span>         }</span><br><span>         get_user_pass(&amp;static_=
proxy_user_pass,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                 p-&gt;options.auth_file,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                      auth_file,</span><br><span>    =
                   UP_TYPE_PROXY,</span><br><span>                       fl=
ags);</span><br><span>         p-&gt;queried_creds =3D true;</span><br><spa=
n>diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h</span><br><span>in=
dex 7900244..4e78772 100644</span><br><span>--- a/src/openvpn/proxy.h</span=
><br><span>+++ b/src/openvpn/proxy.h</span><br><span>@@ -52,10 +52,11 @@</s=
pan><br><span> </span><br><span>     const char *auth_method_string;</span>=
<br><span>     const char *auth_file;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *auth_file_up; /* specified with --http-pr=
oxy-user-pass */</span><br><span>     const char *http_version;</span><br><=
span>     const char *user_agent;</span><br><span>     struct http_custom_h=
eader custom_headers[MAX_CUSTOM_HTTP_HEADER];</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    bool inline_creds;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    bool inline_creds; /* auth_file_up is inline=
 credentials */</span><br><span> };</span><br><span> </span><br><span> stru=
ct http_proxy_options_simple {</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/499?usp=3Demail">ch=
ange 499</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/499?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f402db2fb73f1206fbc1139c47=
d2bf4378376fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 499 </div>
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


--vCI7bLkr02k=--

