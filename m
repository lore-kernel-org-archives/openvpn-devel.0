From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 14 Nov 2023 15:08:20 +0000
In-Reply-To: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
References: <gerrit.1699964322000.I53eaee85d7b284af6bc63da5f6d8f310ddd96c47@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3930ee742096050390e72e437470c723f2c66cb3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DjzCaTrRWBs="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DjzCaTrRWBs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/42=
9?usp=3Demail )

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
Gerrit-MessageType: merged

--DjzCaTrRWBs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/429?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">config.h: fix incorrect defines for _wopen()<b=
r><br>This is a regression from commit<br><br>  01341840 (&quot;add basic C=
Make based build&quot;)<br><br>S_IRUSR and S_IWUSR should NOT be defined as=
 0 but<br>as _S_IREAD and _S_IWRITE, as it was already fixed in commit<br><=
br>  077445d0 (&quot;Fix some more wrong defines in config-msvc.h&quot;)<br=
><br>Those are used as permission mode when opening a file. Passing<br>zero=
 makes file read-only, which break for example --status-file<br>functionali=
ty.<br><br>Github: fixes OpenVPN/openvpn#454<br>Trac: #1430<br><br>Change-I=
d: I53eaee85d7b284af6bc63da5f6d8f310ddd96c47<br>Signed-off-by: Lev Stipakov=
 &lt;lev@...515...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Message-Id: &lt;20231114141653.10486-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27393.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M config.h.cm=
ake.in<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index=
 f2cdd39..1c0dd6f 100644</span><br><span>--- a/config.h.cmake.in</span><br>=
<span>+++ b/config.h.cmake.in</span><br><span>@@ -469,8 +469,8 @@</span><br=
><span> #define strncasecmp strnicmp</span><br><span> #define strcasecmp _s=
tricmp</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define S_IRUSR 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define S_IWUSR 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#de=
fine S_IRUSR _S_IREAD</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define S_IWUSR _S_IWRITE</span><br><span> #define R_OK 4</span><br><span=
> #define W_OK 2</span><br><span> #define X_OK 1</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
29?usp=3Demail">change 429</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/429?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--DjzCaTrRWBs=--

