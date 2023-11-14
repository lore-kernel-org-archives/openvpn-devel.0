From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Nov 2023 15:08:18 +0000
In-Reply-To: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
References: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3930ee742096050390e72e437470c723f2c66cb3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="o9GhJ/pBBUQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: config.h: fix
 incorrect defines for _wopen()
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

--o9GhJ/pBBUQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: config.h: fix incorrect defines for _wopen()
......................................................................

config.h: fix incorrect defines for _wopen()

This is a regression from commit

  01341840 ("add basic CMake based build")

S_IRUSR and S_IWUSR should NOT be defined as 0 but
as _S_IREAD and _S_IWRITE, as it was already fixed in commit

  077445d0 ("Fix some more wrong defines in config-msvc.h")

Those are used as permission mode when opening a file. Passing
zero makes file read-only, which break for example --status-file
functionality.

Github: fixes OpenVPN/openvpn#454
Trac: #1430

Change-Id: I53eaee85d7b284af6bc63da5f6d8f310ddd96c47
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20231114141653.10486-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
393.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M config.h.cmake.in
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/429/2

diff --git a/config.h.cmake.in b/config.h.cmake.in
index f2cdd39..1c0dd6f 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -469,8 +469,8 @@
 #define strncasecmp strnicmp
 #define strcasecmp _stricmp

-#define S_IRUSR 0
-#define S_IWUSR 0
+#define S_IRUSR _S_IREAD
+#define S_IWUSR _S_IWRITE
 #define R_OK 4
 #define W_OK 2
 #define X_OK 1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I53eaee85d7b284af6bc63da5f6d8f310ddd96c47
Gerrit-Change-Number: 429
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--o9GhJ/pBBUQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/429?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">config.h: fix incorrect defines for _wopen()<br><br>=
This is a regression from commit<br><br>  01341840 (&quot;add basic CMake b=
ased build&quot;)<br><br>S_IRUSR and S_IWUSR should NOT be defined as 0 but=
<br>as _S_IREAD and _S_IWRITE, as it was already fixed in commit<br><br>  0=
77445d0 (&quot;Fix some more wrong defines in config-msvc.h&quot;)<br><br>T=
hose are used as permission mode when opening a file. Passing<br>zero makes=
 file read-only, which break for example --status-file<br>functionality.<br=
><br>Github: fixes OpenVPN/openvpn#454<br>Trac: #1430<br><br>Change-Id: I53=
eaee85d7b284af6bc63da5f6d8f310ddd96c47<br>Signed-off-by: Lev Stipakov &lt;l=
ev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Messa=
ge-Id: &lt;20231114141653.10486-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg27393.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M config.h.cmake.in=
<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/29/429/2</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index f2cdd39..1c0=
dd6f 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/c=
onfig.h.cmake.in</span><br><span>@@ -469,8 +469,8 @@</span><br><span> #defi=
ne strncasecmp strnicmp</span><br><span> #define strcasecmp _stricmp</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_=
IRUSR 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define S_IWUS=
R 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S_IRUSR =
_S_IREAD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S_I=
WUSR _S_IWRITE</span><br><span> #define R_OK 4</span><br><span> #define W_O=
K 2</span><br><span> #define X_OK 1</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demai=
l">change 429</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53eaee85d7b284af6bc63da5f6d=
8f310ddd96c47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 429 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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


--o9GhJ/pBBUQ=--

