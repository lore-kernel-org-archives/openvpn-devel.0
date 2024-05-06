From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 May 2024 15:37:22 +0000
In-Reply-To: <gerrit.1715003428000.Ie2b62bc95371daf7e1eb58e0323835f169399910@...2715...>
References: <gerrit.1715003428000.Ie2b62bc95371daf7e1eb58e0323835f169399910@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5b95d8e05e994543561a9c1a10365e257602ad39-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jLBvXgr91dg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Repeat the unknown
 command in errors from management interface
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

--jLBvXgr91dg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Repeat the unknown command in errors from management interf=
ace
......................................................................

Repeat the unknown command in errors from management interface

This help pinpointing errors in logs from my app

Change-Id: Ie2b62bc95371daf7e1eb58e0323835f169399910
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240506142303.13198-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
621.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/manage.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/84/584/2

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 89591ea..24f3121 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1663,7 +1663,7 @@
 #endif
     else
     {
-        msg(M_CLIENT, "ERROR: unknown command, enter 'help' for more optio=
ns");
+        msg(M_CLIENT, "ERROR: unknown command [%s], enter 'help' for more =
options", p[0]);
     }

 done:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie2b62bc95371daf7e1eb58e0323835f169399910
Gerrit-Change-Number: 584
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--jLBvXgr91dg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
584?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Repeat the unknown command in errors from man=
agement interface<br><br>This help pinpointing errors in logs from my app<b=
r><br>Change-Id: Ie2b62bc95371daf7e1eb58e0323835f169399910<br>Signed-off-by=
: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Message-Id: &lt;20240506142303.13198-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg28621.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpn/manage.c<br>1 file changed, 1 insertion(+), 1 deleti=
on(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/84/584/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c=
</span><br><span>index 89591ea..24f3121 100644</span><br><span>--- a/src/op=
envpn/manage.c</span><br><span>+++ b/src/openvpn/manage.c</span><br><span>@=
@ -1663,7 +1663,7 @@</span><br><span> #endif</span><br><span>     else</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     msg(M_CLIENT, &quot;ERROR: unknown command, enter &#39;help&#39; for m=
ore options&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(M_CLIENT, &quot;ERROR: unknown command [%s], enter &#39;help&#3=
9; for more options&quot;, p[0]);</span><br><span>     }</span><br><span> <=
/span><br><span> done:</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail">change 584=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/584?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie2b62bc95371daf7e1eb58e0323=
835f169399910 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 584 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--jLBvXgr91dg=--

