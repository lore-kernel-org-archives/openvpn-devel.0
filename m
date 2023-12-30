From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 30 Dec 2023 15:26:10 +0000
In-Reply-To: <gerrit.1702387180000.Ib226079d1543209e08e5fdcf7344cd20850bea9d@...2715...>
References: <gerrit.1702387180000.Ib226079d1543209e08e5fdcf7344cd20850bea9d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c2d14768b6162adade5af713e11806363f41121c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZW7p2U16kgM="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: configure: enable
 silent rules by default
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

--ZW7p2U16kgM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/480?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: configure: enable silent rules by default
......................................................................

configure: enable silent rules by default

The default build log is big and basically
unreadable.

Go the way of other build systems and do not
print compile commands by default. Verbose
output can always be enabled with make V=3D1.

Change-Id: Ib226079d1543209e08e5fdcf7344cd20850bea9d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20231230142348.29108-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
865.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/480/5

diff --git a/configure.ac b/configure.ac
index 22ed448..f420612 100644
--- a/configure.ac
+++ b/configure.ac
@@ -56,6 +56,7 @@
 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
 AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this p=
arameter.
+AM_SILENT_RULES([yes])
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/480?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib226079d1543209e08e5fdcf7344cd20850bea9d
Gerrit-Change-Number: 480
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--ZW7p2U16kgM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/480?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">configure: enable silent rules by default<br><br>The=
 default build log is big and basically<br>unreadable.<br><br>Go the way of=
 other build systems and do not<br>print compile commands by default. Verbo=
se<br>output can always be enabled with make V=3D1.<br><br>Change-Id: Ib226=
079d1543209e08e5fdcf7344cd20850bea9d<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Message-Id: &lt;20231230142348.29108-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27865.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M configure.a=
c<br>1 file changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/80/480/5</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/configure.ac b/configure.ac</span><br><span>index 22ed448..f420612 10064=
4</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</sp=
an><br><span>@@ -56,6 +56,7 @@</span><br><span> # This foreign option preve=
nts autoreconf from overriding our COPYING and</span><br><span> # INSTALL t=
argets:</span><br><span> AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl N=
B: Do not [quote] this parameter.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+AM_SILENT_RULES([yes])</span><br><span> AC_CANONICAL_HOST</sp=
an><br><span> AC_USE_SYSTEM_EXTENSIONS</span><br><span> </span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/480?usp=3Demail">change 480</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/480?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib226079d1543209e08e5fdcf734=
4cd20850bea9d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 480 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ZW7p2U16kgM=--

