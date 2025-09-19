From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 11:44:22 +0000
In-Reply-To: <gerrit.1758280732000.I93406dd91694974df4ea087b9312ae2fafbc7fe7@...2715...>
References: <gerrit.1758280732000.I93406dd91694974df4ea087b9312ae2fafbc7fe7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1cb747f7cbd56636a469522a767fa9095cb5ef8d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+N3RynhYL7U="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Makefile: fix
 'make dist'
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+N3RynhYL7U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1201?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Makefile: fix 'make dist'
......................................................................

Makefile: fix 'make dist'

Commit

  6c3afe5 ("Validate DNS domain name before powershell invocation")

has introduced a new header file but didn't add it to Makefile's
SOURCES, breaking "make dist".

Change-Id: I93406dd91694974df4ea087b9312ae2fafbc7fe7
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1201
Message-Id: <20250919113207.25440-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
085.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/Makefile.am
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1201/3

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4492c15..e80179c 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -57,6 +57,7 @@
 	dco_win.c dco_win.h \
 	dhcp.c dhcp.h \
 	dns.c dns.h \
+	domain_helper.h \
 	env_set.c env_set.h \
 	errlevel.h \
 	error.c error.h \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1201?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I93406dd91694974df4ea087b9312ae2fafbc7fe7
Gerrit-Change-Number: 1201
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--+N3RynhYL7U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1201=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Makefile: fix &#39;make dist&#39;<br><br>Commit<br><=
br>  6c3afe5 (&quot;Validate DNS domain name before powershell invocation&q=
uot;)<br><br>has introduced a new header file but didn&#39;t add it to Make=
file&#39;s<br>SOURCES, breaking &quot;make dist&quot;.<br><br>Change-Id: I9=
3406dd91694974df4ea087b9312ae2fafbc7fe7<br>Signed-off-by: Lev Stipakov &lt;=
lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerr=
it URL: https://gerrit.openvpn.net/c/openvpn/+/1201<br>Message-Id: &lt;2025=
0919113207.25440-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com=
/openvpn-devel@lists.sourceforge.net/msg33085.html<br>Signed-off-by: Gert D=
oering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/Makefile.am<br>1 fil=
e changed, 1 insertion(+), 0 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/01/1201/3</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/Makefile.am b/src/openvpn/Makefile.am</span><br><span>index 4492c15..=
e80179c 100644</span><br><span>--- a/src/openvpn/Makefile.am</span><br><spa=
n>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -57,6 +57,7 @@</span><br=
><span> 	dco_win.c dco_win.h \</span><br><span> 	dhcp.c dhcp.h \</span><br>=
<span> 	dns.c dns.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+	domain_helper.h \</span><br><span> 	env_set.c env_set.h \</span><br><spa=
n> 	errlevel.h \</span><br><span> 	error.c error.h \</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1201?usp=3Demail">change 1201</a>. To unsubscribe, or for help writing m=
ail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings<=
/a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div ite=
mscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link =
itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1201?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I93406dd91694974df4ea087b931=
2ae2fafbc7fe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1201 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+N3RynhYL7U=--

