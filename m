From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 17:56:21 +0000
In-Reply-To: <gerrit.1763922943000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
References: <gerrit.1763922943000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <66cc059a442fea08cbb177bf2f3ca05bf303580a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/CtquBEvtmI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Restrict access to
 the service pipe to SYSTEM and owner
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, stipa <lstipakov@...277...>
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/CtquBEvtmI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Restrict access to the service pipe to SYSTEM and owner
......................................................................

Restrict access to the service pipe to SYSTEM and owner

Access is restricted to SYSTEM and pipe client user
(the user starting openvpn.exe). The default is
full access to Administrtors, owner, and read access
to everyone. This hardens the pipe further.

Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1397
Message-Id: <20251124165353.14923-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
640.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 18 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1397/3

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index afa8047..dbb5a4b 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3417,9 +3417,26 @@
              GetCurrentThreadId(), pipe_uuid_str);
     RpcStringFree(&pipe_uuid_str);

+    /* make a security descriptor for the named pipe with access
+     * restricted to the user and SYSTEM
+     */
+
+    SECURITY_ATTRIBUTES sa;
+    PSECURITY_DESCRIPTOR pSD =3D NULL;
+    LPCWSTR szSDDL =3D L"D:(A;;GA;;;SY)(A;;GA;;;OW)";
+    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(
+            szSDDL, SDDL_REVISION_1, &pSD, NULL))
+    {
+        ReturnLastError(pipe, L"ConvertSDDL");
+        goto out;
+    }
+    sa.nLength =3D sizeof(sa);
+    sa.lpSecurityDescriptor =3D pSD;
+    sa.bInheritHandle =3D FALSE;
+
     ovpn_pipe =3D CreateNamedPipe(
         ovpn_pipe_name, PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE=
 | FILE_FLAG_OVERLAPPED,
-        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJEC=
T_REMOTE_CLIENTS, 1, 128, 128, 0, NULL);
+        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJEC=
T_REMOTE_CLIENTS, 1, 128, 128, 0, &sa);
     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)
     {
         ReturnLastError(pipe, L"CreateNamedPipe");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Gerrit-Change-Number: 1397
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/CtquBEvtmI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Restrict access to the service pipe=
 to SYSTEM and owner<br><br>Access is restricted to SYSTEM and pipe client =
user<br>(the user starting openvpn.exe). The default is<br>full access to A=
dministrtors, owner, and read access<br>to everyone. This hardens the pipe =
further.<br><br>Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e<br>Sig=
ned-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Lev Stipak=
ov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1397<br>Message-Id: &lt;20251124165353.14923-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg34640.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpnserv/interactive.c<br>1 file changed, 18 insertions(+), 1 =
deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/97/1397/3</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/int=
eractive.c b/src/openvpnserv/interactive.c</span><br><span>index afa8047..d=
bb5a4b 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br=
><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -3417,9 +3417=
,26 @@</span><br><span>              GetCurrentThreadId(), pipe_uuid_str);<=
/span><br><span>     RpcStringFree(&amp;pipe_uuid_str);</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* make a securit=
y descriptor for the named pipe with access</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * restricted to the user and SYSTEM</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    SECURITY_ATTRIBUTES sa;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szSDDL =3D L&quot;D:(=
A;;GA;;;SY)(A;;GA;;;OW)&quot;;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            szSDDL, S=
DDL_REVISION_1, &amp;pSD, NULL))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ReturnLastError(pipe, L&quot;ConvertSDDL&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sa.nLength =3D sizeof(sa);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    sa.lpSecurityDescriptor =3D pSD;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    sa.bInheritHandle =3D F=
ALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     ovpn_pipe =3D CreateNamedPipe(</span><br><span>         ovpn_pipe_n=
ame, PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAP=
PED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        PIPE_TYPE=
_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS, =
1, 128, 128, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJ=
ECT_REMOTE_CLIENTS, 1, 128, 128, 0, &amp;sa);</span><br><span>     if (ovpn=
_pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     {</span><br><span> =
        ReturnLastError(pipe, L&quot;CreateNamedPipe&quot;);</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1397?usp=3Demail">change 1397</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1397?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd02=
27976606fe71e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1397 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--/CtquBEvtmI=--

