From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 25 Feb 2026 23:40:55 +0000
In-Reply-To: <gerrit.1772061272000.I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35@...2715...>
References: <gerrit.1772061272000.I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f8822cbd5a533d7f0b0601f1e667302cae10df8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WM2JHJpYM5k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Document management
 client versions
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

--WM2JHJpYM5k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1552?usp=3Demail

to look at the new patch set (#2).


Change subject: Document management client versions
......................................................................

Document management client versions

Also add an enum to keep track of client version updates.

Change-Id: I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M doc/management-notes.txt
M src/openvpn/manage.c
2 files changed, 20 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/1552/2

diff --git a/doc/management-notes.txt b/doc/management-notes.txt
index 86b74f3..41e2a91 100644
--- a/doc/management-notes.txt
+++ b/doc/management-notes.txt
@@ -496,6 +496,10 @@
 version. This was fixed starting version 4: clients should expect
 "SUCCESS: .. " message only when setting the version to >=3D 4.

+Minimum client version required for certain features is listed below:
+    >PK_SIGN:[base64]           -- version 2 or greater
+    >PK_SIGN:[base64],[alg]     -- version 3 or greater
+
 COMMAND -- auth-retry
 ---------------------

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 03ff5b3..d26c9b2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -61,6 +61,17 @@
 /* tag for blank username/password */
 static const char blank_up[] =3D "[[BLANK]]";

+/*
+ * Management client versions indicating feature support in client.
+ * Append new values as needed but do not change exisiting ones.
+ */
+enum mcv
+{
+    MCV_DEFAULT =3D 1,
+    MCV_PKSIGN =3D 2,
+    MCV_PKSIGN_ALG =3D 3,
+};
+
 struct management *management; /* GLOBAL */

 /* static forward declarations */
@@ -1333,8 +1344,8 @@
     if (version)
     {
         man->connection.client_version =3D atoi(version);
-        /* Prior to version 3, we missed to respond to this command. Ackno=
wledge only if version >=3D 4 */
-        if (man->connection.client_version >=3D 4)
+        /* Until MCV_PKSIGN_ALG, we missed to respond to this command. Ack=
nowledge only if version is newer */
+        if (man->connection.client_version > MCV_PKSIGN_ALG)
         {
             msg(M_CLIENT, "SUCCESS: Management client version set to %d", =
man->connection.client_version);
         }
@@ -2656,7 +2667,7 @@
             man->connection.es =3D event_set_init(&maxevents, EVENT_METHOD=
_FAST);
         }

-        man->connection.client_version =3D 1; /* default version */
+        man->connection.client_version =3D MCV_DEFAULT; /* default version=
 */

         /*
          * Listen/connect socket
@@ -3776,14 +3787,14 @@
     const char *desc =3D "pk-sign";
     struct buffer buf_data =3D alloc_buf(strlen(b64_data) + strlen(algorit=
hm) + 20);

-    if (man->connection.client_version <=3D 1)
+    if (man->connection.client_version <=3D MCV_DEFAULT)
     {
         prompt =3D "RSA_SIGN";
         desc =3D "rsa-sign";
     }

     buf_write(&buf_data, b64_data, (int)strlen(b64_data));
-    if (man->connection.client_version > 2)
+    if (man->connection.client_version >=3D MCV_PKSIGN_ALG)
     {
         buf_write(&buf_data, ",", (int)strlen(","));
         buf_write(&buf_data, algorithm, (int)strlen(algorithm));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1552?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1c01fa1bc7d65ac060b334724feb56ef4d0b5d35
Gerrit-Change-Number: 1552
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--WM2JHJpYM5k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1552?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Document management client versions<br><br>Also add=
 an enum to keep track of client version updates.<br><br>Change-Id: I1c01fa=
1bc7d65ac060b334724feb56ef4d0b5d35<br>Signed-off-by: Selva Nair &lt;selva.n=
air@...277...&gt;<br>---<br>M doc/management-notes.txt<br>M src/openvpn/man=
age.c<br>2 files changed, 20 insertions(+), 5 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/=
1552/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/doc/management-notes.txt b/doc/management-notes=
.txt</span><br><span>index 86b74f3..41e2a91 100644</span><br><span>--- a/do=
c/management-notes.txt</span><br><span>+++ b/doc/management-notes.txt</span=
><br><span>@@ -496,6 +496,10 @@</span><br><span> version. This was fixed st=
arting version 4: clients should expect</span><br><span> &quot;SUCCESS: .. =
&quot; message only when setting the version to &gt;=3D 4.</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Minimum client ver=
sion required for certain features is listed below:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    &gt;PK_SIGN:[base64]           -- ver=
sion 2 or greater</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  &gt;PK_SIGN:[base64],[alg]     -- version 3 or greater</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> COMMAND -- auth-retr=
y</span><br><span> ---------------------</span><br><span> </span><br><span>=
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c</span><br><span>in=
dex 03ff5b3..d26c9b2 100644</span><br><span>--- a/src/openvpn/manage.c</spa=
n><br><span>+++ b/src/openvpn/manage.c</span><br><span>@@ -61,6 +61,17 @@</=
span><br><span> /* tag for blank username/password */</span><br><span> stat=
ic const char blank_up[] =3D &quot;[[BLANK]]&quot;;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Management client versions indicating =
feature support in client.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Append new values as needed but do not change exisiting ones.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+enum mcv</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    MCV_DEFAULT =3D 1,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    MCV_PKSIGN =3D 2,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    MCV_PKSIGN_ALG =3D 3,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> struct management *management; /* GLOBAL */</span><br><s=
pan> </span><br><span> /* static forward declarations */</span><br><span>@@=
 -1333,8 +1344,8 @@</span><br><span>     if (version)</span><br><span>     =
{</span><br><span>         man-&gt;connection.client_version =3D atoi(versi=
on);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Prior =
to version 3, we missed to respond to this command. Acknowledge only if ver=
sion &gt;=3D 4 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (man-&gt;connection.client_version &gt;=3D 4)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Until MCV_PKSIGN_ALG, we misse=
d to respond to this command. Acknowledge only if version is newer */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (man-&gt;conne=
ction.client_version &gt; MCV_PKSIGN_ALG)</span><br><span>         {</span>=
<br><span>             msg(M_CLIENT, &quot;SUCCESS: Management client versi=
on set to %d&quot;, man-&gt;connection.client_version);</span><br><span>   =
      }</span><br><span>@@ -2656,7 +2667,7 @@</span><br><span>             =
man-&gt;connection.es =3D event_set_init(&amp;maxevents, EVENT_METHOD_FAST)=
;</span><br><span>         }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        man-&gt;connection.client_version =3D 1; /=
* default version */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        man-&gt;connection.client_version =3D MCV_DEFAULT; /* default vers=
ion */</span><br><span> </span><br><span>         /*</span><br><span>      =
    * Listen/connect socket</span><br><span>@@ -3776,14 +3787,14 @@</span><=
br><span>     const char *desc =3D &quot;pk-sign&quot;;</span><br><span>   =
  struct buffer buf_data =3D alloc_buf(strlen(b64_data) + strlen(algorithm)=
 + 20);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (man-&gt;connection.client_version &lt;=3D 1)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (man-&gt;connection.client_vers=
ion &lt;=3D MCV_DEFAULT)</span><br><span>     {</span><br><span>         pr=
ompt =3D &quot;RSA_SIGN&quot;;</span><br><span>         desc =3D &quot;rsa-=
sign&quot;;</span><br><span>     }</span><br><span> </span><br><span>     b=
uf_write(&amp;buf_data, b64_data, (int)strlen(b64_data));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (man-&gt;connection.client_versi=
on &gt; 2)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
an-&gt;connection.client_version &gt;=3D MCV_PKSIGN_ALG)</span><br><span>  =
   {</span><br><span>         buf_write(&amp;buf_data, &quot;,&quot;, (int)=
strlen(&quot;,&quot;));</span><br><span>         buf_write(&amp;buf_data, a=
lgorithm, (int)strlen(algorithm));</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1552?usp=3Demai=
l">change 1552</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1552?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1c01fa1bc7d65ac060b334724fe=
b56ef4d0b5d35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1552 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--WM2JHJpYM5k=--

