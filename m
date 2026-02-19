From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:00:40 +0000
In-Reply-To: <gerrit.1771414879000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
References: <gerrit.1771414879000.I632368451923116e0a169ddb5b6e86a8f8486afc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b1142adb69400234bdba393c4b1ca2ced602b367-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bcod3V74nvs="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: auth-pam: fix
 discards 'const' qualifier from pointer target type
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

--bcod3V74nvs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1543?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: auth-pam: fix discards 'const' qualifier from pointer targe=
t type
......................................................................

auth-pam: fix discards 'const' qualifier from pointer target type

strstr now returns const char*.

Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1543
Message-Id: <20260218214712.27119-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
728.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/plugins/auth-pam/utils.c
1 file changed, 1 insertion(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/1543/2

diff --git a/src/plugins/auth-pam/utils.c b/src/plugins/auth-pam/utils.c
index d7b544a..a4d2d0b 100644
--- a/src/plugins/auth-pam/utils.c
+++ b/src/plugins/auth-pam/utils.c
@@ -66,12 +66,11 @@
     /* state: all parameters are valid */

     const char *searching =3D tosearch;
-    char *scratch;

     char temp[templen + 1];
     temp[0] =3D 0;

-    scratch =3D strstr(searching, searchfor);
+    const char *scratch =3D strstr(searching, searchfor);
     if (!scratch)
     {
         return strdup(tosearch);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1543?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc
Gerrit-Change-Number: 1543
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bcod3V74nvs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1543?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">auth-pam: fix discards &#39;const&#=
39; qualifier from pointer target type<br><br>strstr now returns const char=
*.<br><br>Change-Id: I632368451923116e0a169ddb5b6e86a8f8486afc<br>Signed-of=
f-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering =
&lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn=
/+/1543<br>Message-Id: &lt;20260218214712.27119-1-gert@...1296...&gt;<br>UR=
L: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3572=
8.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M s=
rc/plugins/auth-pam/utils.c<br>1 file changed, 1 insertion(+), 2 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/43/1543/2</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/plugins/auth-pam/utils.c=
 b/src/plugins/auth-pam/utils.c</span><br><span>index d7b544a..a4d2d0b 1006=
44</span><br><span>--- a/src/plugins/auth-pam/utils.c</span><br><span>+++ b=
/src/plugins/auth-pam/utils.c</span><br><span>@@ -66,12 +66,11 @@</span><br=
><span>     /* state: all parameters are valid */</span><br><span> </span><=
br><span>     const char *searching =3D tosearch;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    char *scratch;</span><br><span> </span><br>=
<span>     char temp[templen + 1];</span><br><span>     temp[0] =3D 0;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    scra=
tch =3D strstr(searching, searchfor);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *scratch =3D strstr(searching, searchfor);=
</span><br><span>     if (!scratch)</span><br><span>     {</span><br><span>=
         return strdup(tosearch);</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1543?usp=3Demail=
">change 1543</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1543?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I632368451923116e0a169ddb5b6=
e86a8f8486afc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1543 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--bcod3V74nvs=--

