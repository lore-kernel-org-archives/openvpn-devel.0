From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 12 Mar 2024 13:43:23 +0000
In-Reply-To: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
References: <gerrit.1707991289000.Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <769be1dd7c2d68440a4b7cacf7bc974dae37e3c3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e7Dv8q+veuw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Http-proxy: fix bug
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

--e7Dv8q+veuw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail

to look at the new patch set (#8).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Http-proxy: fix bug preventing proxy credentials caching
......................................................................

Http-proxy: fix bug preventing proxy credentials caching

Caching proxy credentials was not working due to the
lack of handling already defined creds in get_user_pass(),
which prevented the caching from working properly.

Fix this issue by getting the value of c->first_time,
that indicates if we're at the first iteration
of the main loop and use it as second argument of the
get_user_pass_http(). Otherwise, on SIGUSR1 or SIGHUP
upon instance context restart credentials would be erased
every time.

The nocache member has been added to the struct
http_proxy_options and also a getter method to retrieve
that option from ssl has been added, by doing this
we're able to erase previous queried user credentials
to ensure correct operation.

Fixes: Trac #1187
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a1a78a
---
M doc/man-sections/generic-options.rst
M src/openvpn/init.c
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M src/openvpn/ssl.c
M src/openvpn/ssl.h
7 files changed, 38 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/23/523/8

diff --git a/doc/man-sections/generic-options.rst b/doc/man-sections/generi=
c-options.rst
index f8a0f48..1fb17f7 100644
--- a/doc/man-sections/generic-options.rst
+++ b/doc/man-sections/generic-options.rst
@@ -19,9 +19,6 @@
   When using ``--auth-nocache`` in combination with a user/password file
   and ``--chroot`` or ``--daemon``, make sure to use an absolute path.

-  This directive does not affect the ``--http-proxy`` username/password.
-  It is always cached.
-
 --cd dir
   Change directory to ``dir`` prior to reading any files such as
   configuration files, key files, scripts, etc. ``dir`` should be an
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 52b3931..fdee199 100644
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
index 94a88f9..d276a1a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1650,6 +1650,7 @@
     SHOW_STR(auth_file);
     SHOW_STR(auth_file_up);
     SHOW_BOOL(inline_creds);
+    SHOW_BOOL(nocache);
     SHOW_STR(http_version);
     SHOW_STR(user_agent);
     for  (i =3D 0; i < MAX_CUSTOM_HTTP_HEADER && o->custom_headers[i].name=
; i++)
@@ -3151,6 +3152,11 @@
         ce->flags |=3D CE_DISABLED;
     }

+    if (ce->http_proxy_options)
+    {
+        ce->http_proxy_options->nocache =3D ssl_get_auth_nocache();
+    }
+
     /* our socks code is not fully IPv6 enabled yet (TCP works, UDP not)
      * so fall back to IPv4-only (trac #1221)
      */
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index eeb3989..4570fbc 100644
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
@@ -288,9 +288,14 @@
                       auth_file,
                       UP_TYPE_PROXY,
                       flags);
-        p->queried_creds =3D true;
-        p->up =3D static_proxy_user_pass;
+        static_proxy_user_pass.nocache =3D p->options.nocache;
     }
+
+    /*
+     * Using cached credentials
+     */
+    p->queried_creds =3D true;
+    p->up =3D static_proxy_user_pass;
 }

 #if 0
@@ -542,7 +547,7 @@
      * we know whether we need any. */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM2)
     {
-        get_user_pass_http(p, true);
+        get_user_pass_http(p, p->options.first_time);
     }

 #if !NTLM
@@ -656,6 +661,11 @@
         || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, false);
+
+        if (p->up.nocache)
+        {
+            clear_user_pass_http();
+        }
     }

     /* are we being called again after getting the digest server nonce in =
the previous transaction? */
@@ -1031,13 +1041,6 @@
             }
             goto error;
         }
-
-        /* clear state */
-        if (p->options.auth_retry)
-        {
-            clear_user_pass_http();
-        }
-        store_proxy_authenticate(p, NULL);
     }

     /* check return code, success =3D 200 */
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
Gerrit-PatchSet: 8
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--e7Dv8q+veuw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #8</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Http-proxy: fix bug preventing proxy credenti=
als caching<br><br>Caching proxy credentials was not working due to the<br>=
lack of handling already defined creds in get_user_pass(),<br>which prevent=
ed the caching from working properly.<br><br>Fix this issue by getting the =
value of c-&gt;first_time,<br>that indicates if we&#39;re at the first iter=
ation<br>of the main loop and use it as second argument of the<br>get_user_=
pass_http(). Otherwise, on SIGUSR1 or SIGHUP<br>upon instance context resta=
rt credentials would be erased<br>every time.<br><br>The nocache member has=
 been added to the struct<br>http_proxy_options and also a getter method to=
 retrieve<br>that option from ssl has been added, by doing this<br>we&#39;r=
e able to erase previous queried user credentials<br>to ensure correct oper=
ation.<br><br>Fixes: Trac #1187<br>Signed-off-by: Gianmarco De Gregori &lt;=
gianmarco@...2726...&gt;<br>Change-Id: Ia3e06c0832c4ca0ab868c845279fb71c01a=
1a78a<br>---<br>M doc/man-sections/generic-options.rst<br>M src/openvpn/ini=
t.c<br>M src/openvpn/options.c<br>M src/openvpn/proxy.c<br>M src/openvpn/pr=
oxy.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl.h<br>7 files changed, 38 =
insertions(+), 14 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/23/523/8</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sections/g=
eneric-options.rst b/doc/man-sections/generic-options.rst</span><br><span>i=
ndex f8a0f48..1fb17f7 100644</span><br><span>--- a/doc/man-sections/generic=
-options.rst</span><br><span>+++ b/doc/man-sections/generic-options.rst</sp=
an><br><span>@@ -19,9 +19,6 @@</span><br><span>   When using ``--auth-nocac=
he`` in combination with a user/password file</span><br><span>   and ``--ch=
root`` or ``--daemon``, make sure to use an absolute path.</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  This directive doe=
s not affect the ``--http-proxy`` username/password.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-  It is always cached.</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> --cd dir</span><br><span=
>   Change directory to ``dir`` prior to reading any files such as</span><b=
r><span>   configuration files, key files, scripts, etc. ``dir`` should be =
an</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</sp=
an><br><span>index 52b3931..fdee199 100644</span><br><span>--- a/src/openvp=
n/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -697,6=
 +697,8 @@</span><br><span> </span><br><span>     if (c-&gt;options.ce.http=
_proxy_options)</span><br><span>     {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        c-&gt;options.ce.http_proxy_options-&gt;first_ti=
me =3D c-&gt;first_time;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>         /* Possible HTTP proxy user/pass input */</s=
pan><br><span>         c-&gt;c1.http_proxy =3D http_proxy_new(c-&gt;options=
.ce.http_proxy_options);</span><br><span>         if (c-&gt;c1.http_proxy)<=
/span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c<=
/span><br><span>index 94a88f9..d276a1a 100644</span><br><span>--- a/src/ope=
nvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>=
@@ -1650,6 +1650,7 @@</span><br><span>     SHOW_STR(auth_file);</span><br><=
span>     SHOW_STR(auth_file_up);</span><br><span>     SHOW_BOOL(inline_cre=
ds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SHOW_BOOL(n=
ocache);</span><br><span>     SHOW_STR(http_version);</span><br><span>     =
SHOW_STR(user_agent);</span><br><span>     for  (i =3D 0; i &lt; MAX_CUSTOM=
_HTTP_HEADER &amp;&amp; o-&gt;custom_headers[i].name; i++)</span><br><span>=
@@ -3151,6 +3152,11 @@</span><br><span>         ce-&gt;flags |=3D CE_DISABL=
ED;</span><br><span>     }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (ce-&gt;http_proxy_options)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        ce-&gt;http_proxy_options-&gt;nocache =3D=
 ssl_get_auth_nocache();</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     /* our socks code is not fully IPv6 enabled yet (TCP works, UD=
P not)</span><br><span>      * so fall back to IPv4-only (trac #1221)</span=
><br><span>      */</span><br><span>diff --git a/src/openvpn/proxy.c b/src/=
openvpn/proxy.c</span><br><span>index eeb3989..4570fbc 100644</span><br><sp=
an>--- a/src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</spa=
n><br><span>@@ -276,7 +276,7 @@</span><br><span>         {</span><br><span>=
             auth_file =3D p-&gt;options.auth_file_up;</span><br><span>    =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (p-&=
gt;queried_creds)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (p-&gt;queried_creds &amp;&amp; !static_proxy_user_pass.nocache)</=
span><br><span>         {</span><br><span>             flags |=3D GET_USER_=
PASS_PREVIOUS_CREDS_FAILED;</span><br><span>         }</span><br><span>@@ -=
288,9 +288,14 @@</span><br><span>                       auth_file,</span><b=
r><span>                       UP_TYPE_PROXY,</span><br><span>             =
          flags);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    p-&gt;queried_creds =3D true;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        p-&gt;up =3D static_proxy_user_pass;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        static_proxy_user_pass.nocache=
 =3D p-&gt;options.nocache;</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * Using cached credentials</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   p-&gt;queried_creds =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    p-&gt;up =3D static_proxy_user_pass;</span><br><span> }</s=
pan><br><span> </span><br><span> #if 0</span><br><span>@@ -542,7 +547,7 @@<=
/span><br><span>      * we know whether we need any. */</span><br><span>   =
  if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;auth_method =3D=3D =
HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        get_user_pass_http(p, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        get_user_pass_http(p, p-&gt;opti=
ons.first_time);</span><br><span>     }</span><br><span> </span><br><span> =
#if !NTLM</span><br><span>@@ -656,6 +661,11 @@</span><br><span>         || =
p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br>=
<span>         get_user_pass_http(p, false);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (p-&gt;up.nocache)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            clear_user_pass_http();</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span>     }</span><br><span> </s=
pan><br><span>     /* are we being called again after getting the digest se=
rver nonce in the previous transaction? */</span><br><span>@@ -1031,13 +104=
1,6 @@</span><br><span>             }</span><br><span>             goto err=
or;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* c=
lear state */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (p-&gt;options.auth_retry)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        clear_user_pass_http();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      store_proxy_authenticate(p, NULL);</span><br><span>     }</span><br><=
span> </span><br><span>     /* check return code, success =3D 200 */</span>=
<br><span>diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h</span><br>=
<span>index 4e78772..474cfc9 100644</span><br><span>--- a/src/openvpn/proxy=
.h</span><br><span>+++ b/src/openvpn/proxy.h</span><br><span>@@ -57,6 +57,8=
 @@</span><br><span>     const char *user_agent;</span><br><span>     struc=
t http_custom_header custom_headers[MAX_CUSTOM_HTTP_HEADER];</span><br><spa=
n>     bool inline_creds; /* auth_file_up is inline credentials */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    bool first_time; /* indi=
cates if we need to wipe user creds at the first iteration of the main loop=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool nocache=
;</span><br><span> };</span><br><span> </span><br><span> struct http_proxy_=
options_simple {</span><br><span>diff --git a/src/openvpn/ssl.c b/src/openv=
pn/ssl.c</span><br><span>index 33c8670..d174dad 100644</span><br><span>--- =
a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><br><span=
>@@ -335,6 +335,15 @@</span><br><span> }</span><br><span> </span><br><span>=
 /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Get the passw=
ord caching</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ssl_get_auth_nocache()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    return passbuf.nocache;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span=
><br><span>  * Set an authentication token</span><br><span>  */</span><br><=
span> void</span><br><span>diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl=
.h</span><br><span>index 71b99db..dd6538c 100644</span><br><span>--- a/src/=
openvpn/ssl.h</span><br><span>+++ b/src/openvpn/ssl.h</span><br><span>@@ -3=
97,6 +397,11 @@</span><br><span> void ssl_set_auth_nocache(void);</span><br=
><span> </span><br><span> /*</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Getter method for retrieving the auth-nocache option.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+bool ssl_get_auth_nocache();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/*</span><br><span>  * Purge any stored authentication =
information, both for key files and tunnel</span><br><span>  * authenticati=
on. If PCKS #11 is enabled, purge authentication for that too.</span><br><s=
pan>  * Note that auth_token is not cleared.</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?u=
sp=3Demail">change 523</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/523?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3e06c0832c4ca0ab868c845279=
fb71c01a1a78a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 523 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--e7Dv8q+veuw=--

