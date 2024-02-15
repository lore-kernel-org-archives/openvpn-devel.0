From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 15 Feb 2024 10:01:31 +0000
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <10eb2954e1a1f458c3f7b920ca2b395e0dccddbd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aVCySFP9XWc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Http-proxy: Fix bug
 preventing proxy credentials caching.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aVCySFP9XWc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail

to review the following change.


Change subject: Http-proxy: Fix bug preventing proxy credentials caching.
......................................................................

Http-proxy: Fix bug preventing proxy credentials caching.

Previously, the caching of proxy credentials was not working
due to the missing of handling already defined creds in
get_user_pass_http(), which prevented the caching from working correctly.

This issue has been solved by rewriting the get_user_pass_http().
This method now sets the appropriate flags based on whether
credentials are defined, have been queried before, or are inline.
It then calls the get_user_pass() to retrieve the credentials
and store them in a static variable, 'static_proxy_user_pass',
which will be used for subsequent requests. If credentials
were not previously defined, or caching is not allowed, creds
are queried again.

Fixes: Trac #1187
Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
3 files changed, 31 insertions(+), 27 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/523/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1e..3f5301f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1858,6 +1858,7 @@
     SHOW_BOOL(persist_local_ip);
     SHOW_BOOL(persist_remote_ip);
     SHOW_BOOL(persist_key);
+    SHOW_BOOL(ce.http_proxy_options->nocache);

 #if PASSTOS_CAPABILITY
     SHOW_BOOL(passtos);
@@ -8978,6 +8979,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         ssl_set_auth_nocache();
+        options->ce.http_proxy_options->nocache =3D true;
     }
     else if (streq(p[0], "auth-token") && p[1] && !p[2])
     {
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index eeb3989..a4af720 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -257,40 +257,41 @@
 }

 static void
-get_user_pass_http(struct http_proxy_info *p, const bool force)
+get_user_pass_http(struct http_proxy_info *p)
 {
-    /*
-     * in case of forced (re)load, make sure the static storage is set as
-     * undefined, otherwise get_user_pass() won't try to load any credenti=
al
-     */
-    if (force)
+    static bool is_first_time =3D true;
+    unsigned int flags =3D GET_USER_PASS_MANAGEMENT;
+
+    if (p->queried_creds && !p->options.nocache)
     {
-        clear_user_pass_http();
+        flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED;
     }

-    if (!static_proxy_user_pass.defined)
+    if (p->options.inline_creds)
     {
-        unsigned int flags =3D GET_USER_PASS_MANAGEMENT;
-        const char *auth_file =3D p->options.auth_file;
-        if (p->options.auth_file_up)
-        {
-            auth_file =3D p->options.auth_file_up;
-        }
-        if (p->queried_creds)
-        {
-            flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED;
-        }
-        if (p->options.inline_creds)
-        {
-            flags |=3D GET_USER_PASS_INLINE_CREDS;
-        }
+        flags |=3D GET_USER_PASS_INLINE_CREDS;
+    }
+
+    if (!static_proxy_user_pass.defined || (is_first_time && !p->options.n=
ocache) )
+    {
         get_user_pass(&static_proxy_user_pass,
-                      auth_file,
+                      p->options.auth_file,
                       UP_TYPE_PROXY,
                       flags);
-        p->queried_creds =3D true;
-        p->up =3D static_proxy_user_pass;
+        is_first_time =3D false;
     }
+
+    else
+    {
+        get_user_pass(&static_proxy_user_pass,
+                      p->options.auth_file,
+                      UP_TYPE_PROXY,
+                      flags);
+        static_proxy_user_pass.defined =3D !p->options.nocache;
+    }
+
+    p->queried_creds =3D true;
+    p->up =3D static_proxy_user_pass;
 }

 #if 0
@@ -542,7 +543,7 @@
      * we know whether we need any. */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM2)
     {
-        get_user_pass_http(p, true);
+        get_user_pass_http(p);
     }

 #if !NTLM
@@ -655,7 +656,7 @@
         || p->auth_method =3D=3D HTTP_AUTH_DIGEST
         || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
     {
-        get_user_pass_http(p, false);
+        get_user_pass_http(p);
     }

     /* are we being called again after getting the digest server nonce in =
the previous transaction? */
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 4e78772..b8b4ca9 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -57,6 +57,7 @@
     const char *user_agent;
     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
     bool inline_creds; /* auth_file_up is inline credentials */
+    bool nocache;
 };

 struct http_proxy_options_simple {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
Gerrit-Change-Number: 523
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--aVCySFP9XWc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Http-proxy: Fix bug preventing proxy credentials caching.<br>=
<br>Previously, the caching of proxy credentials was not working<br>due to =
the missing of handling already defined creds in<br>get_user_pass_http(), w=
hich prevented the caching from working correctly.<br><br>This issue has be=
en solved by rewriting the get_user_pass_http().<br>This method now sets th=
e appropriate flags based on whether<br>credentials are defined, have been =
queried before, or are inline.<br>It then calls the get_user_pass() to retr=
ieve the credentials<br>and store them in a static variable, &#39;static_pr=
oxy_user_pass&#39;,<br>which will be used for subsequent requests. If crede=
ntials<br>were not previously defined, or caching is not allowed, creds<br>=
are queried again.<br><br>Fixes: Trac #1187<br>Change-Id: Ia3e06c0832c4ca0a=
b868c845279fb71c01a1a78a<br>Signed-off-by: Gianmarco De Gregori &lt;gianmar=
co@...2726...&gt;<br>---<br>M src/openvpn/options.c<br>M src/openvpn/proxy.=
c<br>M src/openvpn/proxy.h<br>3 files changed, 31 insertions(+), 27 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/23/523/1</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options=
.c</span><br><span>index 2c79a1e..3f5301f 100644</span><br><span>--- a/src/=
openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><sp=
an>@@ -1858,6 +1858,7 @@</span><br><span>     SHOW_BOOL(persist_local_ip);<=
/span><br><span>     SHOW_BOOL(persist_remote_ip);</span><br><span>     SHO=
W_BOOL(persist_key);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    SHOW_BOOL(ce.http_proxy_options-&gt;nocache);</span><br><span> </span>=
<br><span> #if PASSTOS_CAPABILITY</span><br><span>     SHOW_BOOL(passtos);<=
/span><br><span>@@ -8978,6 +8979,7 @@</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         ssl_s=
et_auth_nocache();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       options-&gt;ce.http_proxy_options-&gt;nocache =3D true;</span><br><s=
pan>     }</span><br><span>     else if (streq(p[0], &quot;auth-token&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>inde=
x eeb3989..a4af720 100644</span><br><span>--- a/src/openvpn/proxy.c</span><=
br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -257,40 +257,41 @@</s=
pan><br><span> }</span><br><span> </span><br><span> static void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-get_user_pass_http(struct http_pr=
oxy_info *p, const bool force)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+get_user_pass_http(struct http_proxy_info *p)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-     * in case of forced (re)load, m=
ake sure the static storage is set as</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-     * undefined, otherwise get_user_pass() won&#39;t try t=
o load any credential</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (force)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static bool is_=
first_time =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    unsigned int flags =3D GET_USER_PASS_MANAGEMENT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (p-&gt;queried_creds &amp;&amp; !p-&gt;options.nocach=
e)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        clear_user_pass_http();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED;</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!static_proxy_user_pass.defined)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (p-&gt;options.inline_creds)</s=
pan><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       unsigned int flags =3D GET_USER_PASS_MANAGEMENT;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        const char *auth_file =3D p-&gt;o=
ptions.auth_file;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (p-&gt;options.auth_file_up)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            auth_file =3D p-&gt;options.auth_file_up;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (p-&gt;queried_creds)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FA=
ILED;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;options.in=
line_creds)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            flags |=3D=
 GET_USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     flags |=3D GET_USER_PASS_INLINE_CREDS;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
static_proxy_user_pass.defined || (is_first_time &amp;&amp; !p-&gt;options.=
nocache) )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span>         get_user_pass(&amp;static_proxy_user_pass,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                      auth_file,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
   p-&gt;options.auth_file,</span><br><span>                       UP_TYPE_=
PROXY,</span><br><span>                       flags);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        p-&gt;queried_creds =3D true;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        p-&gt;up =3D static=
_proxy_user_pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      is_first_time =3D false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ge=
t_user_pass(&amp;static_proxy_user_pass,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                      p-&gt;options.auth_file,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      UP_TY=
PE_PROXY,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
            flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        static_proxy_user_pass.defined =3D !p-&gt;options.nocache;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    p-&gt;queried_creds =3D true;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    p-&gt;up =3D static_proxy_user_pass;</span=
><br><span> }</span><br><span> </span><br><span> #if 0</span><br><span>@@ -=
542,7 +543,7 @@</span><br><span>      * we know whether we need any. */</sp=
an><br><span>     if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;aut=
h_method =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        get_user_pass_http(p, true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        get_user_pass_ht=
tp(p);</span><br><span>     }</span><br><span> </span><br><span> #if !NTLM<=
/span><br><span>@@ -655,7 +656,7 @@</span><br><span>         || p-&gt;auth_=
method =3D=3D HTTP_AUTH_DIGEST</span><br><span>         || p-&gt;auth_metho=
d =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        get_user_pass_http(p, false);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        get_user_pass_http(p);=
</span><br><span>     }</span><br><span> </span><br><span>     /* are we be=
ing called again after getting the digest server nonce in the previous tran=
saction? */</span><br><span>diff --git a/src/openvpn/proxy.h b/src/openvpn/=
proxy.h</span><br><span>index 4e78772..b8b4ca9 100644</span><br><span>--- a=
/src/openvpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy.h</span><br><s=
pan>@@ -57,6 +57,7 @@</span><br><span>     const char *user_agent;</span><b=
r><span>     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADE=
R];</span><br><span>     bool inline_creds; /* auth_file_up is inline crede=
ntials */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool n=
ocache;</span><br><span> };</span><br><span> </span><br><span> struct http_=
proxy_options_simple {</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">change 523=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279=
fb71c01a1a78a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--aVCySFP9XWc=--

