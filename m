From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Sun, 5 Apr 2026 20:39:32 +0000
References: <gerrit.1775421558000.Iacf06c113e8db5b7c78270f361ee76938ef1db47@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4f2cccf635770788e5749919b258ee363650f4f7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e6nggZyKaAU="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove various
 redundant conditionals
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

--e6nggZyKaAU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1613?usp=3Demail

to review the following change.


Change subject: Remove various redundant conditionals
......................................................................

Remove various redundant conditionals

These are all already proven to be true by
surrounding code.

Identified by cppcheck.

Change-Id: Iacf06c113e8db5b7c78270f361ee76938ef1db47
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/manage.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/platform.c
M src/openvpn/ssl_verify.c
M src/openvpnserv/interactive.c
6 files changed, 8 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/1613/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6cab7db..d776908 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1551,10 +1551,7 @@
         }
         else
         {
-            if (p[1])
-            {
-                man_state(man, p[1]);
-            }
+            man_state(man, p[1]);
             if (p[2])
             {
                 man_state(man, p[2]);
@@ -2457,7 +2454,7 @@
         {
             buffer_list_advance(man->connection.out, sent);
         }
-        else if (sent < 0)
+        else
         {
             if (man_io_error(man, "send"))
             {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 22f8b54..7882f32 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1869,7 +1869,7 @@
     {
         msg(M_INFO, "PUSH: No NCP or OCC cipher data received from peer.");

-        if (o->enable_ncp_fallback && !tls_multi->remote_ciphername)
+        if (o->enable_ncp_fallback)
         {
             msg(M_INFO,
                 "Using data channel cipher '%s' since "
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 713dcf4..200e3cd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5304,7 +5304,7 @@
         struct dns_server *server =3D
             dns_server_get(&options->dns_options.servers, priority, &optio=
ns->dns_options.gc);

-        if (streq(p[3], "address") && p[4])
+        if (streq(p[3], "address"))
         {
             for (int i =3D 4; p[i]; ++i)
             {
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 3a6b272..9fa9363 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -572,7 +572,7 @@
             close(fd);
             return retfname;
         }
-        else if (fd =3D=3D -1 && errno !=3D EEXIST)
+        else if (errno !=3D EEXIST)
         {
             /* Something else went wrong, no need to retry.  */
             msg(M_WARN | M_ERRNO, "Could not create temporary file '%s'", =
retfname);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d44f25f..99df49c 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -895,7 +895,7 @@
         {
             /* Must have at least three lines. further lines are ignored f=
or
              * forward compatibility */
-            if (!lines->head || !lines->head->next || !lines->head->next->=
next)
+            if (!lines->head->next || !lines->head->next->next)
             {
                 msg(M_WARN, "auth pending control file is not at least "
                             "three lines long.");
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c96d3f2..322461e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -486,7 +486,7 @@
     sud->directory =3D data;
     len =3D wcslen(sud->directory) + 1;
     size -=3D len;
-    if (size <=3D 0)
+    if (size =3D=3D 0)
     {
         MsgToEventLog(M_ERR, L"Startup data ends at working directory");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_=
event);
@@ -496,7 +496,7 @@
     sud->options =3D sud->directory + len;
     len =3D wcslen(sud->options) + 1;
     size -=3D len;
-    if (size <=3D 0)
+    if (size =3D=3D 0)
     {
         MsgToEventLog(M_ERR, L"Startup data ends at command line options");
         ReturnError(pipe, ERROR_STARTUP_DATA, L"GetStartupData", 1, &exit_=
event);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1613?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacf06c113e8db5b7c78270f361ee76938ef1db47
Gerrit-Change-Number: 1613
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--e6nggZyKaAU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1613?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Remove various redundant conditionals<br><b=
r>These are all already proven to be true by<br>surrounding code.<br><br>Id=
entified by cppcheck.<br><br>Change-Id: Iacf06c113e8db5b7c78270f361ee76938e=
f1db47<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M src/openvpn/manage.c<br>M src/openvpn/multi.c<br>M src/openvpn/options=
.c<br>M src/openvpn/platform.c<br>M src/openvpn/ssl_verify.c<br>M src/openv=
pnserv/interactive.c<br>6 files changed, 8 insertions(+), 11 deletions(-)<b=
r><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/13/1613/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openv=
pn/manage.c</span><br><span>index 6cab7db..d776908 100644</span><br><span>-=
-- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span>=
<br><span>@@ -1551,10 +1551,7 @@</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (p[1])</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                man_state(man, p[1]);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            man_state(man, p[1]);</span><br><span>   =
          if (p[2])</span><br><span>             {</span><br><span>        =
         man_state(man, p[2]);</span><br><span>@@ -2457,7 +2454,7 @@</span>=
<br><span>         {</span><br><span>             buffer_list_advance(man-&=
gt;connection.out, sent);</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        else if (sent &lt; 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span>    =
     {</span><br><span>             if (man_io_error(man, &quot;send&quot;)=
)</span><br><span>             {</span><br><span>diff --git a/src/openvpn/m=
ulti.c b/src/openvpn/multi.c</span><br><span>index 22f8b54..7882f32 100644<=
/span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn=
/multi.c</span><br><span>@@ -1869,7 +1869,7 @@</span><br><span>     {</span=
><br><span>         msg(M_INFO, &quot;PUSH: No NCP or OCC cipher data recei=
ved from peer.&quot;);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (o-&gt;enable_ncp_fallback &amp;&amp; !tls_mu=
lti-&gt;remote_ciphername)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (o-&gt;enable_ncp_fallback)</span><br><span>         {</s=
pan><br><span>             msg(M_INFO,</span><br><span>                 &qu=
ot;Using data channel cipher &#39;%s&#39; since &quot;</span><br><span>diff=
 --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>inde=
x 713dcf4..200e3cd 100644</span><br><span>--- a/src/openvpn/options.c</span=
><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5304,7 +5304,7 @=
@</span><br><span>         struct dns_server *server =3D</span><br><span>  =
           dns_server_get(&amp;options-&gt;dns_options.servers, priority, &=
amp;options-&gt;dns_options.gc);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (streq(p[3], &quot;address&quot;) &=
amp;&amp; p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (streq(p[3], &quot;address&quot;))</span><br><span>         {</span>=
<br><span>             for (int i =3D 4; p[i]; ++i)</span><br><span>       =
      {</span><br><span>diff --git a/src/openvpn/platform.c b/src/openvpn/p=
latform.c</span><br><span>index 3a6b272..9fa9363 100644</span><br><span>---=
 a/src/openvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c</spa=
n><br><span>@@ -572,7 +572,7 @@</span><br><span>             close(fd);</sp=
an><br><span>             return retfname;</span><br><span>         }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if (fd =3D=3D =
-1 &amp;&amp; errno !=3D EEXIST)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else if (errno !=3D EEXIST)</span><br><span>         {=
</span><br><span>             /* Something else went wrong, no need to retr=
y.  */</span><br><span>             msg(M_WARN | M_ERRNO, &quot;Could not c=
reate temporary file &#39;%s&#39;&quot;, retfname);</span><br><span>diff --=
git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>i=
ndex d44f25f..99df49c 100644</span><br><span>--- a/src/openvpn/ssl_verify.c=
</span><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -895,7 +=
895,7 @@</span><br><span>         {</span><br><span>             /* Must ha=
ve at least three lines. further lines are ignored for</span><br><span>    =
          * forward compatibility */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (!lines-&gt;head || !lines-&gt;head-&gt;next =
|| !lines-&gt;head-&gt;next-&gt;next)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (!lines-&gt;head-&gt;next || !lines-&gt;he=
ad-&gt;next-&gt;next)</span><br><span>             {</span><br><span>      =
           msg(M_WARN, &quot;auth pending control file is not at least &quo=
t;</span><br><span>                             &quot;three lines long.&quo=
t;);</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openv=
pnserv/interactive.c</span><br><span>index c96d3f2..322461e 100644</span><b=
r><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openv=
pnserv/interactive.c</span><br><span>@@ -486,7 +486,7 @@</span><br><span>  =
   sud-&gt;directory =3D data;</span><br><span>     len =3D wcslen(sud-&gt;=
directory) + 1;</span><br><span>     size -=3D len;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (size &lt;=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (size =3D=3D 0)</span><br><span>=
     {</span><br><span>         MsgToEventLog(M_ERR, L&quot;Startup data en=
ds at working directory&quot;);</span><br><span>         ReturnError(pipe, =
ERROR_STARTUP_DATA, L&quot;GetStartupData&quot;, 1, &amp;exit_event);</span=
><br><span>@@ -496,7 +496,7 @@</span><br><span>     sud-&gt;options =3D sud=
-&gt;directory + len;</span><br><span>     len =3D wcslen(sud-&gt;options) =
+ 1;</span><br><span>     size -=3D len;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    if (size &lt;=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (size =3D=3D 0)</span><br><span>     {</span>=
<br><span>         MsgToEventLog(M_ERR, L&quot;Startup data ends at command=
 line options&quot;);</span><br><span>         ReturnError(pipe, ERROR_STAR=
TUP_DATA, L&quot;GetStartupData&quot;, 1, &amp;exit_event);</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1613?usp=3Demail">change 1613</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1613?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacf06c113e8db5b7c78270f361e=
e76938ef1db47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1613 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--e6nggZyKaAU=--

