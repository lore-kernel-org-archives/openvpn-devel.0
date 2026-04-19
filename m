From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 15:56:10 +0000
In-Reply-To: <gerrit.1775421558000.Iacf06c113e8db5b7c78270f361ee76938ef1db47@...2715...>
References: <gerrit.1775421558000.Iacf06c113e8db5b7c78270f361ee76938ef1db47@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <925fa506e239403e9f0e62bbb4c68b8db25c9cd5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3FeM4Tr3cXk="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3FeM4Tr3cXk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/16=
13?usp=3Demail )

Change subject: Remove various redundant conditionals
......................................................................

Remove various redundant conditionals

These are all already proven to be true by
surrounding code.

Identified by cppcheck.

Change-Id: Iacf06c113e8db5b7c78270f361ee76938ef1db47
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1613
Message-Id: <20260419135116.22170-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
666.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/platform.c
M src/openvpn/ssl_verify.c
M src/openvpnserv/interactive.c
6 files changed, 8 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index c22a2a4..2a3023c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1625,10 +1625,7 @@
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
@@ -2542,7 +2539,7 @@
         {
             buffer_list_advance(man->connection.out, sent);
         }
-        else if (sent < 0)
+        else
         {
             if (man_io_error(man, "send"))
             {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index fe210ee..06e3758 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1837,7 +1837,7 @@
     {
         msg(M_INFO, "PUSH: No NCP or OCC cipher data received from peer.");

-        if (o->enable_ncp_fallback && !tls_multi->remote_ciphername)
+        if (o->enable_ncp_fallback)
         {
             msg(M_INFO,
                 "Using data channel cipher '%s' since "
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 70af6d2..0c2866c 100644
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
index 21b516d..0804d2d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -906,7 +906,7 @@
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
index 4268214..473a8d3 100644
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iacf06c113e8db5b7c78270f361ee76938ef1db47
Gerrit-Change-Number: 1613
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3FeM4Tr3cXk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1613?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Remove various redundant conditionals<br><br>The=
se are all already proven to be true by<br>surrounding code.<br><br>Identif=
ied by cppcheck.<br><br>Change-Id: Iacf06c113e8db5b7c78270f361ee76938ef1db4=
7<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn=
.net/c/openvpn/+/1613<br>Message-Id: &lt;20260419135116.22170-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg36666.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/manage.c<br>M src/openvpn/multi.c<br>M src/openvpn=
/options.c<br>M src/openvpn/platform.c<br>M src/openvpn/ssl_verify.c<br>M s=
rc/openvpnserv/interactive.c<br>6 files changed, 8 insertions(+), 11 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span=
>index c22a2a4..2a3023c 100644</span><br><span>--- a/src/openvpn/manage.c</=
span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -1625,10 +1625=
,7 @@</span><br><span>         }</span><br><span>         else</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     if (p[1])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 man_state(man, p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       man_state(man, p[1]);</span><br><span>             if (p[2])</span><=
br><span>             {</span><br><span>                 man_state(man, p[2=
]);</span><br><span>@@ -2542,7 +2539,7 @@</span><br><span>         {</span>=
<br><span>             buffer_list_advance(man-&gt;connection.out, sent);</=
span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        else if (sent &lt; 0)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        else</span><br><span>         {</span><br><span>     =
        if (man_io_error(man, &quot;send&quot;))</span><br><span>          =
   {</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c=
</span><br><span>index fe210ee..06e3758 100644</span><br><span>--- a/src/op=
envpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ =
-1837,7 +1837,7 @@</span><br><span>     {</span><br><span>         msg(M_IN=
FO, &quot;PUSH: No NCP or OCC cipher data received from peer.&quot;);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
f (o-&gt;enable_ncp_fallback &amp;&amp; !tls_multi-&gt;remote_ciphername)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (o-&gt;ena=
ble_ncp_fallback)</span><br><span>         {</span><br><span>             m=
sg(M_INFO,</span><br><span>                 &quot;Using data channel cipher=
 &#39;%s&#39; since &quot;</span><br><span>diff --git a/src/openvpn/options=
.c b/src/openvpn/options.c</span><br><span>index 70af6d2..0c2866c 100644</s=
pan><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn=
/options.c</span><br><span>@@ -5304,7 +5304,7 @@</span><br><span>         s=
truct dns_server *server =3D</span><br><span>             dns_server_get(&a=
mp;options-&gt;dns_options.servers, priority, &amp;options-&gt;dns_options.=
gc);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (streq(p[3], &quot;address&quot;) &amp;&amp; p[4])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (streq(p[3], &quot;ad=
dress&quot;))</span><br><span>         {</span><br><span>             for (=
int i =3D 4; p[i]; ++i)</span><br><span>             {</span><br><span>diff=
 --git a/src/openvpn/platform.c b/src/openvpn/platform.c</span><br><span>in=
dex 3a6b272..9fa9363 100644</span><br><span>--- a/src/openvpn/platform.c</s=
pan><br><span>+++ b/src/openvpn/platform.c</span><br><span>@@ -572,7 +572,7=
 @@</span><br><span>             close(fd);</span><br><span>             re=
turn retfname;</span><br><span>         }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else if (fd =3D=3D -1 &amp;&amp; errno !=3D EEX=
IST)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if=
 (errno !=3D EEXIST)</span><br><span>         {</span><br><span>           =
  /* Something else went wrong, no need to retry.  */</span><br><span>     =
        msg(M_WARN | M_ERRNO, &quot;Could not create temporary file &#39;%s=
&#39;&quot;, retfname);</span><br><span>diff --git a/src/openvpn/ssl_verify=
.c b/src/openvpn/ssl_verify.c</span><br><span>index 21b516d..0804d2d 100644=
</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/o=
penvpn/ssl_verify.c</span><br><span>@@ -906,7 +906,7 @@</span><br><span>   =
      {</span><br><span>             /* Must have at least three lines. fur=
ther lines are ignored for</span><br><span>              * forward compatib=
ility */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            i=
f (!lines-&gt;head || !lines-&gt;head-&gt;next || !lines-&gt;head-&gt;next-=
&gt;next)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  if (!lines-&gt;head-&gt;next || !lines-&gt;head-&gt;next-&gt;next)</span>=
<br><span>             {</span><br><span>                 msg(M_WARN, &quot=
;auth pending control file is not at least &quot;</span><br><span>         =
                    &quot;three lines long.&quot;);</span><br><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 4268214..473a8d3 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -486,7 +486,7 @@</span><br><span>     sud-&gt;directory =3D dat=
a;</span><br><span>     len =3D wcslen(sud-&gt;directory) + 1;</span><br><s=
pan>     size -=3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (size &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (size =3D=3D 0)</span><br><span>     {</span><br><span>       =
  MsgToEventLog(M_ERR, L&quot;Startup data ends at working directory&quot;)=
;</span><br><span>         ReturnError(pipe, ERROR_STARTUP_DATA, L&quot;Get=
StartupData&quot;, 1, &amp;exit_event);</span><br><span>@@ -496,7 +496,7 @@=
</span><br><span>     sud-&gt;options =3D sud-&gt;directory + len;</span><b=
r><span>     len =3D wcslen(sud-&gt;options) + 1;</span><br><span>     size=
 -=3D len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (siz=
e &lt;=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(size =3D=3D 0)</span><br><span>     {</span><br><span>         MsgToEventL=
og(M_ERR, L&quot;Startup data ends at command line options&quot;);</span><b=
r><span>         ReturnError(pipe, ERROR_STARTUP_DATA, L&quot;GetStartupDat=
a&quot;, 1, &amp;exit_event);</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1613?usp=3Demail">ch=
ange 1613</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1613?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iacf06c113e8db5b7c78270f361e=
e76938ef1db47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1613 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--3FeM4Tr3cXk=--

