From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 11 Aug 2023 14:52:50 +0000
In-Reply-To: <gerrit.1690549401000.I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d@...2715...>
References: <gerrit.1690549401000.I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <882978641c96477f108b1c7397b5a36901ea9f5d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lGkNr0+rNXs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: options: Do not
 hide variables from parent scope
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

--lGkNr0+rNXs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/320?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: options: Do not hide variables from parent scope
......................................................................

options: Do not hide variables from parent scope

msglevel hides the function parameter of the same name,
which could lead to confusion. Use a unique name.

Change-Id: I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <d549c9b5e5d66624ef82f99206898ff8e43a5fb5-HTML@...2715...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
902.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 4 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/320/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 90d85be..d168163 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -9476,24 +9476,24 @@
     else
     {
         int i;
-        int msglevel =3D msglevel_fc;
+        int msglevel_unknown =3D msglevel_fc;
         /* Check if an option is in --ignore-unknown-option and
          * set warning level to non fatal */
         for (i =3D 0; options->ignore_unknown_option && options->ignore_un=
known_option[i]; i++)
         {
             if (streq(p[0], options->ignore_unknown_option[i]))
             {
-                msglevel =3D M_WARN;
+                msglevel_unknown =3D M_WARN;
                 break;
             }
         }
         if (file)
         {
-            msg(msglevel, "Unrecognized option or missing or extra paramet=
er(s) in %s:%d: %s (%s)", file, line, p[0], PACKAGE_VERSION);
+            msg(msglevel_unknown, "Unrecognized option or missing or extra=
 parameter(s) in %s:%d: %s (%s)", file, line, p[0], PACKAGE_VERSION);
         }
         else
         {
-            msg(msglevel, "Unrecognized option or missing or extra paramet=
er(s): --%s (%s)", p[0], PACKAGE_VERSION);
+            msg(msglevel_unknown, "Unrecognized option or missing or extra=
 parameter(s): --%s (%s)", p[0], PACKAGE_VERSION);
         }
     }
 err:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/320?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9f9d0f0d5ab03f8cdfd7ba7200f2d56613cc586d
Gerrit-Change-Number: 320
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--lGkNr0+rNXs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/320?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: Do not hide variables from parent scope=
<br><br>msglevel hides the function parameter of the same name,<br>which co=
uld lead to confusion. Use a unique name.<br><br>Change-Id: I9f9d0f0d5ab03f=
8cdfd7ba7200f2d56613cc586d<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov@...277...&gt;<br>Messa=
ge-Id: &lt;d549c9b5e5d66624ef82f99206898ff8e43a5fb5-HTML@...2715...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
902.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/options.c<br>1 file changed, 4 insertions(+), 4 deletions(-)<b=
r><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/32=
0/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</spa=
n><br><span>index 90d85be..d168163 100644</span><br><span>--- a/src/openvpn=
/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -=
9476,24 +9476,24 @@</span><br><span>     else</span><br><span>     {</span>=
<br><span>         int i;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        int msglevel =3D msglevel_fc;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int msglevel_unknown =3D msglevel_fc;</span><=
br><span>         /* Check if an option is in --ignore-unknown-option and</=
span><br><span>          * set warning level to non fatal */</span><br><spa=
n>         for (i =3D 0; options-&gt;ignore_unknown_option &amp;&amp; optio=
ns-&gt;ignore_unknown_option[i]; i++)</span><br><span>         {</span><br>=
<span>             if (streq(p[0], options-&gt;ignore_unknown_option[i]))</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                msglevel =3D M_WARN;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                msglevel_unknown =3D M_WARN;</span=
><br><span>                 break;</span><br><span>             }</span><br=
><span>         }</span><br><span>         if (file)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(m=
sglevel, &quot;Unrecognized option or missing or extra parameter(s) in %s:%=
d: %s (%s)&quot;, file, line, p[0], PACKAGE_VERSION);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel_unknown, &quot;U=
nrecognized option or missing or extra parameter(s) in %s:%d: %s (%s)&quot;=
, file, line, p[0], PACKAGE_VERSION);</span><br><span>         }</span><br>=
<span>         else</span><br><span>         {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;Unrecognized optio=
n or missing or extra parameter(s): --%s (%s)&quot;, p[0], PACKAGE_VERSION)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(ms=
glevel_unknown, &quot;Unrecognized option or missing or extra parameter(s):=
 --%s (%s)&quot;, p[0], PACKAGE_VERSION);</span><br><span>         }</span>=
<br><span>     }</span><br><span> err:</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/320?usp=3De=
mail">change 320</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/320?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9f9d0f0d5ab03f8cdfd7ba7200f=
2d56613cc586d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 320 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lGkNr0+rNXs=--

