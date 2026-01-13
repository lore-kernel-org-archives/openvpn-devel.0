From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 07:23:25 +0000
In-Reply-To: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
References: <gerrit.1768227561000.I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a29613efd2ac22011d701ecbd90f18e87cc8472d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x7C3Xbry4uI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: socks: Fix wrong
 success check in socks_username_password_auth
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

--x7C3Xbry4uI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: socks: Fix wrong success check in socks_username_password_a=
uth
......................................................................

socks: Fix wrong success check in socks_username_password_auth

Due to wrong boolean operator the function did not
correctly detect when the authentication failed.

Reported-By: Joshua Rogers <contact@...2949...>
Found-By: ZeroPath (https://zeropath.com)
Github: openvpn-private-issues#4
Change-Id: I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1466
Message-Id: <20260112180304.8742-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
219.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socks.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1466/2

diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 671d33c..078b4e1 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -143,7 +143,7 @@
     }

     /* VER =3D 5, SUCCESS =3D 0 --> auth success */
-    if (buf[0] !=3D 5 && buf[1] !=3D 0)
+    if (buf[0] !=3D 5 || buf[1] !=3D 0)
     {
         msg(D_LINK_ERRORS, "socks_username_password_auth: server refused t=
he authentication");
         goto cleanup;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13b411fb3e8b913ae049c6ca8a1cf5a2edbab0fb
Gerrit-Change-Number: 1466
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x7C3Xbry4uI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">socks: Fix wrong success check in s=
ocks_username_password_auth<br><br>Due to wrong boolean operator the functi=
on did not<br>correctly detect when the authentication failed.<br><br>Repor=
ted-By: Joshua Rogers &lt;contact@...2949...&gt;<br>Found-By: ZeroPath (htt=
ps://zeropath.com)<br>Github: openvpn-private-issues#4<br>Change-Id: I13b41=
1fb3e8b913ae049c6ca8a1cf5a2edbab0fb<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>=
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1466<br>Message-Id: &lt;=
20260112180304.8742-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg35219.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socks.c<br>1 file=
 changed, 1 insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1466/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index 67=
1d33c..078b4e1 100644</span><br><span>--- a/src/openvpn/socks.c</span><br><=
span>+++ b/src/openvpn/socks.c</span><br><span>@@ -143,7 +143,7 @@</span><b=
r><span>     }</span><br><span> </span><br><span>     /* VER =3D 5, SUCCESS=
 =3D 0 --&gt; auth success */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (buf[0] !=3D 5 &amp;&amp; buf[1] !=3D 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (buf[0] !=3D 5 || buf[1] !=3D 0)=
</span><br><span>     {</span><br><span>         msg(D_LINK_ERRORS, &quot;s=
ocks_username_password_auth: server refused the authentication&quot;);</spa=
n><br><span>         goto cleanup;</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demai=
l">change 1466</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1466?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13b411fb3e8b913ae049c6ca8a1=
cf5a2edbab0fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1466 </div>
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

--x7C3Xbry4uI=--

