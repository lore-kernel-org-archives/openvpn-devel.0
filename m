From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 25 Apr 2026 20:31:24 +0000
In-Reply-To: <gerrit.1776903146000.I4d46c3672691b159cbd98a17020c4f30782bc202@...2715...>
References: <gerrit.1776903146000.I4d46c3672691b159cbd98a17020c4f30782bc202@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <acc53690c3c5937715c21504e771a009b06e7e29-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DZ9laos413Q="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fixup: prompting
 password from management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DZ9laos413Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fixup: prompting password from management
......................................................................

Fixup: prompting password from management

Commit b450414 added logic for reading password from management
when not in file or inline, but it was made conditional on
`response_from_stdin` which is always true! Fix by explicitly
checking for `password_from_stdin`.

Github: fixes OpenVPN/openvpn#1021

Change-Id: I4d46c3672691b159cbd98a17020c4f30782bc202
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1638
Message-Id: <20260424161840.5767-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
739.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/misc.c
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1638/2

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 979293f..10bfc35 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -336,6 +336,7 @@
              */
             if (management && (flags & GET_USER_PASS_MANAGEMENT)
                 && management_query_user_pass_enabled(management)
+                && password_from_stdin
                 && !(flags & GET_USER_PASS_USERNAME_ONLY))
             {
                 msg(D_LOW,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4d46c3672691b159cbd98a17020c4f30782bc202
Gerrit-Change-Number: 1638
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DZ9laos413Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Fixup: prompting password from mana=
gement<br><br>Commit b450414 added logic for reading password from manageme=
nt<br>when not in file or inline, but it was made conditional on<br>`respon=
se_from_stdin` which is always true! Fix by explicitly<br>checking for `pas=
sword_from_stdin`.<br><br>Github: fixes OpenVPN/openvpn#1021<br><br>Change-=
Id: I4d46c3672691b159cbd98a17020c4f30782bc202<br>Signed-off-by: Selva Nair =
&lt;selva.nair@...277...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1638<br>Message-I=
d: &lt;20260424161840.5767-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg36739.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/misc.c<br>=
1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/38/1638/2</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>ind=
ex 979293f..10bfc35 100644</span><br><span>--- a/src/openvpn/misc.c</span><=
br><span>+++ b/src/openvpn/misc.c</span><br><span>@@ -336,6 +336,7 @@</span=
><br><span>              */</span><br><span>             if (management &am=
p;&amp; (flags &amp; GET_USER_PASS_MANAGEMENT)</span><br><span>            =
     &amp;&amp; management_query_user_pass_enabled(management)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                &amp;&amp; passw=
ord_from_stdin</span><br><span>                 &amp;&amp; !(flags &amp; GE=
T_USER_PASS_USERNAME_ONLY))</span><br><span>             {</span><br><span>=
                 msg(D_LOW,</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail">chan=
ge 1638</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1638?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4d46c3672691b159cbd98a17020=
c4f30782bc202 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1638 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--DZ9laos413Q=--

