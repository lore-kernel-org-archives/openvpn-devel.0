From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 21 Nov 2023 19:18:27 +0000
In-Reply-To: <gerrit.1700480182000.I91f739f5cb43386b2ce767cf3603a76e6b93e216@...2715...>
References: <gerrit.1700480182000.I91f739f5cb43386b2ce767cf3603a76e6b93e216@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b9f7dea35ec08b3d0973796175441762f713bf93-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MpO5KM3gLfY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Introduce
 report_command_status helper function
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

--MpO5KM3gLfY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/450?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Introduce report_command_status helper function
......................................................................

Introduce report_command_status helper function

Instead of repeating near identical code several times
in manage.c, use a small helper function instead.

Change-Id: I91f739f5cb43386b2ce767cf3603a76e6b93e216
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
Message-Id: <20231121104254.15701-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
525.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 21 insertions(+), 24 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/450/2

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index feb62b2..27b6f90 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -284,6 +284,24 @@
 #endif
 }

+
+/**
+ * Small function to report the success or failure of a command to
+ * the management interface
+ */
+static void
+report_command_status(const bool status, const char *command)
+{
+    if (status)
+    {
+        msg(M_CLIENT, "SUCCESS: %s command succeeded", command);
+    }
+    else
+    {
+        msg(M_CLIENT, "ERROR: %s command failed", command);
+    }
+}
+
 static void
 man_delete_unix_socket(struct management *man)
 {
@@ -974,14 +992,7 @@
                                         NULL,
                                         man->connection.in_extra);
                 man->connection.in_extra =3D NULL;
-                if (status)
-                {
-                    msg(M_CLIENT, "SUCCESS: client-auth command succeeded"=
);
-                }
-                else
-                {
-                    msg(M_CLIENT, "ERROR: client-auth command failed");
-                }
+                report_command_status(status, "client-auth");
             }
             else
             {
@@ -1260,14 +1271,7 @@
     if (man->persist.callback.proxy_cmd)
     {
         const bool status =3D (*man->persist.callback.proxy_cmd)(man->pers=
ist.callback.arg, p);
-        if (status)
-        {
-            msg(M_CLIENT, "SUCCESS: proxy command succeeded");
-        }
-        else
-        {
-            msg(M_CLIENT, "ERROR: proxy command failed");
-        }
+        report_command_status(status, "proxy");
     }
     else
     {
@@ -1281,14 +1285,7 @@
     if (man->persist.callback.remote_cmd)
     {
         const bool status =3D (*man->persist.callback.remote_cmd)(man->per=
sist.callback.arg, p);
-        if (status)
-        {
-            msg(M_CLIENT, "SUCCESS: remote command succeeded");
-        }
-        else
-        {
-            msg(M_CLIENT, "ERROR: remote command failed");
-        }
+        report_command_status(status, "remote");
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/450?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I91f739f5cb43386b2ce767cf3603a76e6b93e216
Gerrit-Change-Number: 450
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--MpO5KM3gLfY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
450?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Introduce report_command_status helper functi=
on<br><br>Instead of repeating near identical code several times<br>in mana=
ge.c, use a small helper function instead.<br><br>Change-Id: I91f739f5cb433=
86b2ce767cf3603a76e6b93e216<br>Acked-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Message-=
Id: &lt;20231121104254.15701-1-frank@...2641...&gt;<br>URL: https://www.mai=
l-archive.com/openvpn-devel@lists.sourceforge.net/msg27525.html<br>Signed-o=
ff-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/manage.=
c<br>1 file changed, 21 insertions(+), 24 deletions(-)<br><br></pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/50/450/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>index feb=
62b2..27b6f90 100644</span><br><span>--- a/src/openvpn/manage.c</span><br><=
span>+++ b/src/openvpn/manage.c</span><br><span>@@ -284,6 +284,24 @@</span>=
<br><span> #endif</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * Small function to report the success or failure of a command to</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * the management interface<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+report_command_status(const bool status, con=
st char *command)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (status)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, &quot;SUCCESS: %=
s command succeeded&quot;, command);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_CLIENT, =
&quot;ERROR: %s command failed&quot;, command);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> static void</span><br><span> man_delete_unix_socket(struct ma=
nagement *man)</span><br><span> {</span><br><span>@@ -974,14 +992,7 @@</spa=
n><br><span>                                         NULL,</span><br><span>=
                                         man-&gt;connection.in_extra);</spa=
n><br><span>                 man-&gt;connection.in_extra =3D NULL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if (status)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(M_CL=
IENT, &quot;SUCCESS: client-auth command succeeded&quot;);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    msg(M_CLIENT, &quot;ERROR: =
client-auth command failed&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                report_command_status(status, &quot;client-auth&=
quot;);</span><br><span>             }</span><br><span>             else</s=
pan><br><span>             {</span><br><span>@@ -1260,14 +1271,7 @@</span><=
br><span>     if (man-&gt;persist.callback.proxy_cmd)</span><br><span>     =
{</span><br><span>         const bool status =3D (*man-&gt;persist.callback=
.proxy_cmd)(man-&gt;persist.callback.arg, p);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (status)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_CLIENT, &quot;SUCCESS: proxy command succeeded&=
quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;ERROR: proxy co=
mmand failed&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        rep=
ort_command_status(status, &quot;proxy&quot;);</span><br><span>     }</span=
><br><span>     else</span><br><span>     {</span><br><span>@@ -1281,14 +12=
85,7 @@</span><br><span>     if (man-&gt;persist.callback.remote_cmd)</span=
><br><span>     {</span><br><span>         const bool status =3D (*man-&gt;=
persist.callback.remote_cmd)(man-&gt;persist.callback.arg, p);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (status)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &quot;SUCCESS: remote =
command succeeded&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIENT, &qu=
ot;ERROR: remote command failed&quot;);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        report_command_status(status, &quot;remote&quot;);</span><b=
r><span>     }</span><br><span>     else</span><br><span>     {</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/450?usp=3Demail">change 450</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/450=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I91f739f5cb43386b2ce767cf360=
3a76e6b93e216 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 450 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--MpO5KM3gLfY=--

