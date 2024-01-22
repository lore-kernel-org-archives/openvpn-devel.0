From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 22 Jan 2024 12:46:54 +0000
In-Reply-To: <gerrit.1705068839000.I6f402db2fb73f1206fbc1139c47d2bf4378376fa@...2715...>
References: <gerrit.1705068839000.I6f402db2fb73f1206fbc1139c47d2bf4378376fa@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c05aacaa8acc19f8fd3591b0d27c640d481b273f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1SCq+m6abe4="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1SCq+m6abe4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/499?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240122092122.8591-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
099.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
3 files changed, 11 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/499/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6975cbe..2c79a1e 100644
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
@@ -6833,7 +6835,7 @@
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
index 2e8d7a8..eeb3989 100644
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--1SCq+m6abe4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/499?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">--http-proxy-user-pass: allow to specify in either o=
rder with --http-proxy<br><br>Previously, when using a third argument to --=
http-proxy other<br>than auto/auto-nct, order did matter between --http-pro=
xy and<br>--http-proxy-user-pass. Always prefer --http-proxy-user-pass<br>w=
hen given.<br><br>Change-Id: I6f402db2fb73f1206fbc1139c47d2bf4378376fa<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert =
Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20240122092122.8591-1-ge=
rt@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1199...=
sourceforge.net/msg28099.html<br>Signed-off-by: Gert Doering &lt;gert@...1711...=
96...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/proxy.c<br>M s=
rc/openvpn/proxy.h<br>3 files changed, 11 insertions(+), 3 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/99/499/=
2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span>=
<br><span>index 6975cbe..2c79a1e 100644</span><br><span>--- a/src/openvpn/o=
ptions.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -16=
49,6 +1649,8 @@</span><br><span>     SHOW_STR(port);</span><br><span>     S=
HOW_STR(auth_method_string);</span><br><span>     SHOW_STR(auth_file);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_STR(auth_file_u=
p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(in=
line_creds);</span><br><span>     SHOW_STR(http_version);</span><br><span> =
    SHOW_STR(user_agent);</span><br><span>     for  (i =3D 0; i &lt; MAX_CU=
STOM_HTTP_HEADER &amp;&amp; o-&gt;custom_headers[i].name; i++)</span><br><s=
pan>@@ -6833,7 +6835,7 @@</span><br><span>         struct http_proxy_option=
s *ho;</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INLIN=
E);</span><br><span>         ho =3D init_http_proxy_options_once(&amp;optio=
ns-&gt;ce.http_proxy_options, &amp;options-&gt;gc);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ho-&gt;auth_file =3D p[1];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        ho-&gt;auth_file_up =
=3D p[1];</span><br><span>         ho-&gt;inline_creds =3D is_inline;</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;http-prox=
y-retry&quot;) || streq(p[0], &quot;socks-proxy-retry&quot;))</span><br><sp=
an>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>i=
ndex 2e8d7a8..eeb3989 100644</span><br><span>--- a/src/openvpn/proxy.c</spa=
n><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -271,6 +271,11 @@<=
/span><br><span>     if (!static_proxy_user_pass.defined)</span><br><span> =
    {</span><br><span>         unsigned int flags =3D GET_USER_PASS_MANAGEM=
ENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const c=
har *auth_file =3D p-&gt;options.auth_file;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (p-&gt;options.auth_file_up)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            auth_file =3D p-&gt;options.a=
uth_file_up;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span>         if (p-&gt;queried_creds)</span><br><span>      =
   {</span><br><span>             flags |=3D GET_USER_PASS_PREVIOUS_CREDS_F=
AILED;</span><br><span>@@ -280,7 +285,7 @@</span><br><span>             fla=
gs |=3D GET_USER_PASS_INLINE_CREDS;</span><br><span>         }</span><br><s=
pan>         get_user_pass(&amp;static_proxy_user_pass,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                      p-&gt;options.auth_=
file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
        auth_file,</span><br><span>                       UP_TYPE_PROXY,</s=
pan><br><span>                       flags);</span><br><span>         p-&gt=
;queried_creds =3D true;</span><br><span>diff --git a/src/openvpn/proxy.h b=
/src/openvpn/proxy.h</span><br><span>index 7900244..4e78772 100644</span><b=
r><span>--- a/src/openvpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy.h=
</span><br><span>@@ -52,10 +52,11 @@</span><br><span> </span><br><span>    =
 const char *auth_method_string;</span><br><span>     const char *auth_file=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *au=
th_file_up; /* specified with --http-proxy-user-pass */</span><br><span>   =
  const char *http_version;</span><br><span>     const char *user_agent;</s=
pan><br><span>     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP=
_HEADER];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool inl=
ine_creds;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
inline_creds; /* auth_file_up is inline credentials */</span><br><span> };<=
/span><br><span> </span><br><span> struct http_proxy_options_simple {</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/499?usp=3Demail">change 499</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/499?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6f402db2fb73f1206fbc1139c47=
d2bf4378376fa </div>
<div style=3D"display:none"> Gerrit-Change-Number: 499 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--1SCq+m6abe4=--

