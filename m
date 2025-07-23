From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 08:15:21 +0000
In-Reply-To: <gerrit.1753215725000.I18df6ef659cab9525dd7847b7dd3950fc1895dd5@...2715...>
References: <gerrit.1753215725000.I18df6ef659cab9525dd7847b7dd3950fc1895dd5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <27bc20dbd24f82f0eabc3b206e952e03a7b52c26-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9rsXWOyw7pU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco_linux: fix case
 statement by using proper error value
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

--9rsXWOyw7pU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 ordex. ( http://gerrit.openvpn.net/c/openvpn/+/1095?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco_linux: fix case statement by using proper error value
......................................................................

dco_linux: fix case statement by using proper error value

A M_ERR constant accidentally slipped in as possible
netlink error value.

Substitute it with the actual code matching the following
error message.

Change-Id: I18df6ef659cab9525dd7847b7dd3950fc1895dd5
Signed-off-by: Antonio Quartulli <antonio@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250723062012.22781-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
269.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dco_linux.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/1095/3

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index f04ebfe..0a73882 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -143,7 +143,7 @@
             msg(M_ERR, "%s: netlink out of memory error", prefix);
             break;

-        case -M_ERR:
+        case -NLE_AGAIN:
             msg(M_WARN, "%s: netlink reports blocking read - aborting wait=
", prefix);
             break;


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1095?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I18df6ef659cab9525dd7847b7dd3950fc1895dd5
Gerrit-Change-Number: 1095
Gerrit-PatchSet: 3
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--9rsXWOyw7pU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by ordex.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1095=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco_linux: fix case statement by using proper error =
value<br><br>A M_ERR constant accidentally slipped in as possible<br>netlin=
k error value.<br><br>Substitute it with the actual code matching the follo=
wing<br>error message.<br><br>Change-Id: I18df6ef659cab9525dd7847b7dd3950fc=
1895dd5<br>Signed-off-by: Antonio Quartulli &lt;antonio@...2726...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2025072306=
2012.22781-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg32269.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco_linux.c<br>1 file chan=
ged, 1 insertion(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/95/1095/3</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/d=
co_linux.c b/src/openvpn/dco_linux.c</span><br><span>index f04ebfe..0a73882=
 100644</span><br><span>--- a/src/openvpn/dco_linux.c</span><br><span>+++ b=
/src/openvpn/dco_linux.c</span><br><span>@@ -143,7 +143,7 @@</span><br><spa=
n>             msg(M_ERR, &quot;%s: netlink out of memory error&quot;, pref=
ix);</span><br><span>             break;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        case -M_ERR:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        case -NLE_AGAIN:</span><br><s=
pan>             msg(M_WARN, &quot;%s: netlink reports blocking read - abor=
ting wait&quot;, prefix);</span><br><span>             break;</span><br><sp=
an> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1095?usp=3Demail">change 1095</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1095?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I18df6ef659cab9525dd7847b7dd=
3950fc1895dd5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1095 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9rsXWOyw7pU=--

