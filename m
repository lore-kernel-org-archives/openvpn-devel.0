From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:36:23 +0000
References: <gerrit.1700480182000.I91f739f5cb43386b2ce767cf3603a76e6b93e216@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <27edbc35477fa10a89a73be7eadba0fc3b71d705-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gm3RW8+jzM0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gm3RW8+jzM0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/450?usp=3Demail

to review the following change.


Change subject: Introduce report_command_status helper function
......................................................................

Introduce report_command_status helper function

Instead of repeating near identical code several times
in manage.c, use a small helper function instead.

Change-Id: I91f739f5cb43386b2ce767cf3603a76e6b93e216
---
M src/openvpn/manage.c
1 file changed, 21 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/450/1

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index feb62b2..3cf392a 100644
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
+                report_command_status(status, "client_auth");
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--Gm3RW8+jzM0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/450?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Introduce report_command_status helper function<br><br>Instea=
d of repeating near identical code several times<br>in manage.c, use a smal=
l helper function instead.<br><br>Change-Id: I91f739f5cb43386b2ce767cf3603a=
76e6b93e216<br>---<br>M src/openvpn/manage.c<br>1 file changed, 21 insertio=
ns(+), 24 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/50/450/1</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src=
/openvpn/manage.c</span><br><span>index feb62b2..3cf392a 100644</span><br><=
span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c<=
/span><br><span>@@ -284,6 +284,24 @@</span><br><span> #endif</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Small function to report the =
success or failure of a command to</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * the management interface</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+r=
eport_command_status(const bool status, const char *command)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (status)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        msg(M_CLIENT, &quot;SUCCESS: %s command succeeded&quot;, comma=
nd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_CLIENT, &quot;ERROR: %s command failed&q=
uot;, command);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span>=
<br><span> man_delete_unix_socket(struct management *man)</span><br><span> =
{</span><br><span>@@ -974,14 +992,7 @@</span><br><span>                    =
                     NULL,</span><br><span>                                =
         man-&gt;connection.in_extra);</span><br><span>                 man=
-&gt;connection.in_extra =3D NULL;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                if (status)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    msg(M_CLIENT, &quot;SUCCESS: client-auth=
 command succeeded&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                msg(M_CLIENT, &quot;ERROR: client-auth command failed&quot;=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                repor=
t_command_status(status, &quot;client_auth&quot;);</span><br><span>        =
     }</span><br><span>             else</span><br><span>             {</sp=
an><br><span>@@ -1260,14 +1271,7 @@</span><br><span>     if (man-&gt;persis=
t.callback.proxy_cmd)</span><br><span>     {</span><br><span>         const=
 bool status =3D (*man-&gt;persist.callback.proxy_cmd)(man-&gt;persist.call=
back.arg, p);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (status)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_CLIE=
NT, &quot;SUCCESS: proxy command succeeded&quot;);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        msg(M_CLIENT, &quot;ERROR: proxy command failed&quot;);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        report_command_status(status, &qu=
ot;proxy&quot;);</span><br><span>     }</span><br><span>     else</span><br=
><span>     {</span><br><span>@@ -1281,14 +1285,7 @@</span><br><span>     i=
f (man-&gt;persist.callback.remote_cmd)</span><br><span>     {</span><br><s=
pan>         const bool status =3D (*man-&gt;persist.callback.remote_cmd)(m=
an-&gt;persist.callback.arg, p);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (status)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         msg(M_CLIENT, &quot;SUCCESS: remote command succeeded&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            msg(M_CLIENT, &quot;ERROR: remote command faile=
d&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        report_command=
_status(status, &quot;remote&quot;);</span><br><span>     }</span><br><span=
>     else</span><br><span>     {</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/450?usp=3Demail"=
>change 450</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/450?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I91f739f5cb43386b2ce767cf360=
3a76e6b93e216 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 450 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--Gm3RW8+jzM0=--

