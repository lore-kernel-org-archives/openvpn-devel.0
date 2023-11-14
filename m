From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 14 Nov 2023 12:18:44 +0000
References: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <74f4822077ddd436c408edb6f2e6b1a3d9b5c162-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="O6kbgaZ0WaA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--O6kbgaZ0WaA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demail

to review the following change.


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

Fixes https://github.com/OpenVPN/openvpn/issues/454

Change-Id: I53eaee85d7b284af6bc63da5f6d8f310ddd96c47
Signed-off-by: Lev Stipakov <lev@...515...>
---
M config.h.cmake.in
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/29/429/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--O6kbgaZ0WaA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">config.h: fix incorrect defines for _wopen()<br><br>This is a=
 regression from commit<br><br>  01341840 (&quot;add basic CMake based buil=
d&quot;)<br><br>S_IRUSR and S_IWUSR should NOT be defined as 0 but<br>as _S=
_IREAD and _S_IWRITE, as it was already fixed in commit<br><br>  077445d0 (=
&quot;Fix some more wrong defines in config-msvc.h&quot;)<br><br>Those are =
used as permission mode when opening a file. Passing<br>zero makes file rea=
d-only, which break for example --status-file<br>functionality.<br><br>Fixe=
s https://github.com/OpenVPN/openvpn/issues/454<br><br>Change-Id: I53eaee85=
d7b284af6bc63da5f6d8f310ddd96c47<br>Signed-off-by: Lev Stipakov &lt;lev@...493...=
515...&gt;<br>---<br>M config.h.cmake.in<br>1 file changed, 2 insertions(+)=
, 2 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/29/429/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cma=
ke.in</span><br><span>index f2cdd39..1c0dd6f 100644</span><br><span>--- a/c=
onfig.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@=
 -469,8 +469,8 @@</span><br><span> #define strncasecmp strnicmp</span><br><=
span> #define strcasecmp _stricmp</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define S_IRUSR 0</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#define S_IWUSR 0</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define S_IRUSR _S_IREAD</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define S_IWUSR _S_IWRITE</span><br><span> #=
define R_OK 4</span><br><span> #define W_OK 2</span><br><span> #define X_OK=
 1</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/429?usp=3Demail">change 429</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/429?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I53eaee85d7b284af6bc63da5f6d=
8f310ddd96c47 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 429 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--O6kbgaZ0WaA=--

