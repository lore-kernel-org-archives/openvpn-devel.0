From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 11:19:32 +0000
In-Reply-To: <gerrit.1758280732000.I93406dd91694974df4ea087b9312ae2fafbc7fe7@...2715...>
References: <gerrit.1758280732000.I93406dd91694974df4ea087b9312ae2fafbc7fe7@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1a3152ce1bbd6c44609e91df0d892827aeb7c536-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wNjpIvg1ehE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: Makefile: fix
 "make dist"
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

--wNjpIvg1ehE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1201?usp=3Demail

to look at the new patch set (#2).


Change subject: Makefile: fix "make dist"
......................................................................

Makefile: fix "make dist"

Commit

  6c3afe5 ("Validate DNS domain name before powershell invocation")

has introduced a new header file but didn't add it to Makefile's
SOURCES, breaking "make dist".

Change-Id: I93406dd91694974df4ea087b9312ae2fafbc7fe7
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/Makefile.am
1 file changed, 1 insertion(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1201/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--wNjpIvg1ehE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1201?usp=3Demail">View Change</=
a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">Makefile: fix &quot;make dist&quot;<br><br>Commit<br><br>  6c3afe5 (&quo=
t;Validate DNS domain name before powershell invocation&quot;)<br><br>has i=
ntroduced a new header file but didn&#39;t add it to Makefile&#39;s<br>SOUR=
CES, breaking &quot;make dist&quot;.<br><br>Change-Id: I93406dd91694974df4e=
a087b9312ae2fafbc7fe7<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M src/openvpn/Makefile.am<br>1 file changed, 1 insertion(+), 0 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/01/1201/2</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn=
/Makefile.am</span><br><span>index 4492c15..e80179c 100644</span><br><span>=
--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am=
</span><br><span>@@ -57,6 +57,7 @@</span><br><span> 	dco_win.c dco_win.h \<=
/span><br><span> 	dhcp.c dhcp.h \</span><br><span> 	dns.c dns.h \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	domain_helper.h \</span><br>=
<span> 	env_set.c env_set.h \</span><br><span> 	errlevel.h \</span><br><spa=
n> 	error.c error.h \</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1201?usp=3Demail">change 120=
1</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1201?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I93406dd91694974df4ea087b931=
2ae2fafbc7fe7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1201 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--wNjpIvg1ehE=--

