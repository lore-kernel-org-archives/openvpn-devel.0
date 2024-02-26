From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 26 Feb 2024 18:28:29 +0000
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6bf7e0bedc10a71f08679f2e3664a0b6b5eb6d64-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JzbXgCjUJ/A="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Http-proxy: fix bug
 preventing proxy credentials caching
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

--JzbXgCjUJ/A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail

to look at the new patch set (#2).


Change subject: Http-proxy: fix bug preventing proxy credentials caching
......................................................................

Http-proxy: fix bug preventing proxy credentials caching

Previously, the caching of proxy credentials was not working
due to the missing of handling already defined creds in
get_user_pass(), which prevented the caching from working
properly.

This issue has been solved by getting the c->first_time
parameter that indicates if we're at the first iteration
of the main loop and use it as second argument of the
get_user_pass_http() otherwise on SIGUSR1 or SIGHUP at
the restart of the context instance credentials would be erase.

The nocache option has been added to the struct
http_proxy_options and also a getter method to retrieve
that option from ssl has been added, by doing this
we're able to erase previous queried user credentials
to ensure correct operation.

Fixes: Trac #1187
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
---
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
6 files changed, 39 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/523/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b4308..dc1ee8d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -697,6 +697,8 @@

     if (c->options.ce.http_proxy_options)
     {
+        c->options.ce.http_proxy_options->first_time =3D c->first_time;
+
         /* Possible HTTP proxy user/pass input */
         c->c1.http_proxy =3D http_proxy_new(c->options.ce.http_proxy_optio=
ns);
         if (c->c1.http_proxy)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1e..0d22df9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3123,6 +3123,10 @@
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_CLIENT;
+            if (ce->http_proxy_options)
+            {
+                ce->http_proxy_options->nocache =3D ssl_get_auth_nocache();
+            }
         }
     }

diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index eeb3989..ff50539 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -276,7 +276,7 @@
         {
             auth_file =3D p->options.auth_file_up;
         }
-        if (p->queried_creds)
+        if (p->queried_creds && !static_proxy_user_pass.nocache)
         {
             flags |=3D GET_USER_PASS_PREVIOUS_CREDS_FAILED;
         }
@@ -288,6 +288,16 @@
                       auth_file,
                       UP_TYPE_PROXY,
                       flags);
+        static_proxy_user_pass.nocache =3D p->options.nocache;
+        p->queried_creds =3D true;
+        p->up =3D static_proxy_user_pass;
+    }
+
+    /*
+     * Using cached credentials
+     */
+    else if (!static_proxy_user_pass.nocache)
+    {
         p->queried_creds =3D true;
         p->up =3D static_proxy_user_pass;
     }
@@ -542,7 +552,7 @@
      * we know whether we need any. */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM2)
     {
-        get_user_pass_http(p, true);
+        get_user_pass_http(p, p->options.first_time);
     }

 #if !NTLM
@@ -553,6 +563,7 @@
 #endif

     p->defined =3D true;
+    p->options.nocache =3D o->nocache;
     return p;
 }

@@ -656,6 +667,10 @@
         || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, false);
+        if (p->up.nocache)
+        {
+            clear_user_pass_http();
+        }
     }

     /* are we being called again after getting the digest server nonce in =
the previous transaction? */
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 4e78772..474cfc9 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -57,6 +57,8 @@
     const char *user_agent;
     struct http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];
     bool inline_creds; /* auth_file_up is inline credentials */
+    bool first_time; /* indicates if we need to wipe user creds at the fir=
st iteration of the main loop */
+    bool nocache;
 };

 struct http_proxy_options_simple {
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33c8670..d174dad 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -335,6 +335,15 @@
 }

 /*
+ * Get the password caching
+ */
+bool
+ssl_get_auth_nocache()
+{
+    return passbuf.nocache;
+}
+
+/*
  * Set an authentication token
  */
 void
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 71b99db..dd6538c 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -397,6 +397,11 @@
 void ssl_set_auth_nocache(void);

 /*
+ * Getter method for retrieving the auth-nocache option.
+ */
+bool ssl_get_auth_nocache();
+
+/*
  * Purge any stored authentication information, both for key files and tun=
nel
  * authentication. If PCKS #11 is enabled, purge authentication for that t=
oo.
  * Note that auth_token is not cleared.

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
Gerrit-Change-Number: 523
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: newpatchset

--JzbXgCjUJ/A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Http-proxy: fix bug preventing proxy credentials caching<br><br>Previ=
ously, the caching of proxy credentials was not working<br>due to the missi=
ng of handling already defined creds in<br>get_user_pass(), which prevented=
 the caching from working<br>properly.<br><br>This issue has been solved by=
 getting the c-&gt;first_time<br>parameter that indicates if we&#39;re at t=
he first iteration<br>of the main loop and use it as second argument of the=
<br>get_user_pass_http() otherwise on SIGUSR1 or SIGHUP at<br>the restart o=
f the context instance credentials would be erase.<br><br>The nocache optio=
n has been added to the struct<br>http_proxy_options and also a getter meth=
od to retrieve<br>that option from ssl has been added, by doing this<br>we&=
#39;re able to erase previous queried user credentials<br>to ensure correct=
 operation.<br><br>Fixes: Trac #1187<br>Signed-off-by: Gianmarco De Gregori=
 &lt;gianmarco@...2726...&gt;<br>Change-Id: Ia3e06c0832c4ca0ab868c845279fb7=
1c01a1a78a<br>---<br>M src/openvpn/init.c<br>M src/openvpn/options.c<br>M s=
rc/openvpn/proxy.c<br>M src/openvpn/proxy.h<br>M src/openvpn/ssl.c<br>M src=
/openvpn/ssl.h<br>6 files changed, 39 insertions(+), 2 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/523/2</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>=
index 52b4308..dc1ee8d 100644</span><br><span>--- a/src/openvpn/init.c</spa=
n><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -697,6 +697,8 @@</s=
pan><br><span> </span><br><span>     if (c-&gt;options.ce.http_proxy_option=
s)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        c-&gt;options.ce.http_proxy_options-&gt;first_time =3D c-&gt;=
first_time;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>         /* Possible HTTP proxy user/pass input */</span><br><span=
>         c-&gt;c1.http_proxy =3D http_proxy_new(c-&gt;options.ce.http_prox=
y_options);</span><br><span>         if (c-&gt;c1.http_proxy)</span><br><sp=
an>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><sp=
an>index 2c79a1e..0d22df9 100644</span><br><span>--- a/src/openvpn/options.=
c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -3123,6 +3=
123,10 @@</span><br><span>         if (ce-&gt;proto =3D=3D PROTO_TCP)</span=
><br><span>         {</span><br><span>             ce-&gt;proto =3D PROTO_T=
CP_CLIENT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (ce-&gt;http_proxy_options)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                ce-&gt;http_proxy_options-&gt;nocache =3D ssl_get_a=
uth_nocache();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span>         }</span><br><span>     }</span><br><span>=
 </span><br><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</s=
pan><br><span>index eeb3989..ff50539 100644</span><br><span>--- a/src/openv=
pn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -27=
6,7 +276,7 @@</span><br><span>         {</span><br><span>             auth_=
file =3D p-&gt;options.auth_file_up;</span><br><span>         }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&gt;queried_creds)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (p-&gt;qu=
eried_creds &amp;&amp; !static_proxy_user_pass.nocache)</span><br><span>   =
      {</span><br><span>             flags |=3D GET_USER_PASS_PREVIOUS_CRED=
S_FAILED;</span><br><span>         }</span><br><span>@@ -288,6 +288,16 @@</=
span><br><span>                       auth_file,</span><br><span>          =
             UP_TYPE_PROXY,</span><br><span>                       flags);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        static_proxy=
_user_pass.nocache =3D p-&gt;options.nocache;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        p-&gt;queried_creds =3D true;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        p-&gt;up =3D static_pro=
xy_user_pass;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+     * Using cached credentials</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (!static_proxy_user_pass.nocache)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span>    =
     p-&gt;queried_creds =3D true;</span><br><span>         p-&gt;up =3D st=
atic_proxy_user_pass;</span><br><span>     }</span><br><span>@@ -542,7 +552=
,7 @@</span><br><span>      * we know whether we need any. */</span><br><sp=
an>     if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;auth_method =
=3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        get_user_pass_http(p, true);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        get_user_pass_http(p, p-&=
gt;options.first_time);</span><br><span>     }</span><br><span> </span><br>=
<span> #if !NTLM</span><br><span>@@ -553,6 +563,7 @@</span><br><span> #endi=
f</span><br><span> </span><br><span>     p-&gt;defined =3D true;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    p-&gt;options.nocache =3D =
o-&gt;nocache;</span><br><span>     return p;</span><br><span> }</span><br>=
<span> </span><br><span>@@ -656,6 +667,10 @@</span><br><span>         || p-=
&gt;auth_method =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><s=
pan>         get_user_pass_http(p, false);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (p-&gt;up.nocache)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            clear_user_pass_http();</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</s=
pan><br><span> </span><br><span>     /* are we being called again after get=
ting the digest server nonce in the previous transaction? */</span><br><spa=
n>diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h</span><br><span>in=
dex 4e78772..474cfc9 100644</span><br><span>--- a/src/openvpn/proxy.h</span=
><br><span>+++ b/src/openvpn/proxy.h</span><br><span>@@ -57,6 +57,8 @@</spa=
n><br><span>     const char *user_agent;</span><br><span>     struct http_c=
ustom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];</span><br><span>     b=
ool inline_creds; /* auth_file_up is inline credentials */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    bool first_time; /* indicates if=
 we need to wipe user creds at the first iteration of the main loop */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool nocache;</span>=
<br><span> };</span><br><span> </span><br><span> struct http_proxy_options_=
simple {</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c=
</span><br><span>index 33c8670..d174dad 100644</span><br><span>--- a/src/op=
envpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span>@@ -335=
,6 +335,15 @@</span><br><span> }</span><br><span> </span><br><span> /*</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get the password cach=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ssl_get_auth_nocache()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return passbuf.nocache;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><sp=
an>  * Set an authentication token</span><br><span>  */</span><br><span> vo=
id</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h</span=
><br><span>index 71b99db..dd6538c 100644</span><br><span>--- a/src/openvpn/=
ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -397,6 +39=
7,11 @@</span><br><span> void ssl_set_auth_nocache(void);</span><br><span> =
</span><br><span> /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Getter method for retrieving the auth-nocache option.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+bool ssl_get_auth_nocache();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span>  * Purge any stored authentication informat=
ion, both for key files and tunnel</span><br><span>  * authentication. If P=
CKS #11 is enabled, purge authentication for that too.</span><br><span>  * =
Note that auth_token is not cleared.</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Dema=
il">change 523</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279=
fb71c01a1a78a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JzbXgCjUJ/A=--

