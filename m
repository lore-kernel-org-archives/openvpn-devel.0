From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 17:51:14 +0000
In-Reply-To: <gerrit.1763922943000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
References: <gerrit.1763922943000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 selva.nair@...277..., openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <748e7300f0a55494d83621de2dad798e184ca7e7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ErXf8Kch+PI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Harden interactive
 service pipe
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

--ErXf8Kch+PI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1396?usp=3Demail )


Change subject: Harden interactive service pipe
......................................................................

Harden interactive service pipe

- Append a version 4 uuid to ovpn_pipe_name to make it less
  predictable
- Do not allow remote access to the pipe

This greatly reduces the possibility of a rogue process racing to
open the pipe before CreateFile() is called in the worker thread.

Reported-by: Marc Heuse <marc@...2953...>
Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208
Signed-off-by: Selva Nair <selva.nair@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1396
Message-Id: <20251124165311.14859-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
638.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 20 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/96/1396/3

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 07ca7c9..afa8047 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3397,12 +3397,29 @@
         goto out;
     }

+    UUID pipe_uuid;
+    RPC_STATUS rpc_stat =3D UuidCreate(&pipe_uuid);
+    if (rpc_stat !=3D RPC_S_OK)
+    {
+        ReturnError(pipe, rpc_stat, L"UuidCreate", 1, &exit_event);
+        goto out;
+    }
+
+    RPC_WSTR pipe_uuid_str =3D NULL;
+    rpc_stat =3D UuidToStringW(&pipe_uuid, &pipe_uuid_str);
+    if (rpc_stat !=3D RPC_S_OK)
+    {
+        ReturnError(pipe, rpc_stat, L"UuidToString", 1, &exit_event);
+        goto out;
+    }
     swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-             L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu", service_ins=
tance,
-             GetCurrentThreadId());
+             L"\\\\.\\pipe\\" _L(PACKAGE) L"%ls\\service_%lu_%ls", service=
_instance,
+             GetCurrentThreadId(), pipe_uuid_str);
+    RpcStringFree(&pipe_uuid_str);
+
     ovpn_pipe =3D CreateNamedPipe(
         ovpn_pipe_name, PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE=
 | FILE_FLAG_OVERLAPPED,
-        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128=
, 0, NULL);
+        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJEC=
T_REMOTE_CLIENTS, 1, 128, 128, 0, NULL);
     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)
     {
         ReturnLastError(pipe, L"CreateNamedPipe");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1396?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208
Gerrit-Change-Number: 1396
Gerrit-PatchSet: 3
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ErXf8Kch+PI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1396?usp=3Demail">Vi=
ew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">Harden interactive service pipe<br><br>- App=
end a version 4 uuid to ovpn_pipe_name to make it less<br>  predictable<br>=
- Do not allow remote access to the pipe<br><br>This greatly reduces the po=
ssibility of a rogue process racing to<br>open the pipe before CreateFile()=
 is called in the worker thread.<br><br>Reported-by: Marc Heuse &lt;marc@...1186...=
.2953...&gt;<br>Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208<br>Sig=
ned-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Gerrit URL: https://=
gerrit.openvpn.net/c/openvpn/+/1396<br>Message-Id: &lt;20251124165311.14859=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg34638.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpnserv/interactive.c<br>1 file changed,=
 20 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/96/1396/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c</span><=
br><span>index 07ca7c9..afa8047 100644</span><br><span>--- a/src/openvpnser=
v/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive.c</span><=
br><span>@@ -3397,12 +3397,29 @@</span><br><span>         goto out;</span><=
br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    UUID pipe_uuid;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    RPC_STATUS rpc_stat =3D UuidCreate(&amp;pipe_uuid);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rpc_stat !=3D RPC=
_S_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        ReturnError(pipe, r=
pc_stat, L&quot;UuidCreate&quot;, 1, &amp;exit_event);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    RPC_WSTR pipe_uuid_str =3D NULL;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    rpc_stat =3D UuidToStringW(&amp;pipe_uuid, &amp;pipe_=
uuid_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (r=
pc_stat !=3D RPC_S_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Ret=
urnError(pipe, rpc_stat, L&quot;UuidToString&quot;, 1, &amp;exit_event);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>  =
   swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             L&quot;\\\\.\\pipe\\&quot; _L(=
PACKAGE) L&quot;%ls\\service_%lu&quot;, service_instance,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             GetCurrentThreadId());</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+             L&quot;\\\=
\.\\pipe\\&quot; _L(PACKAGE) L&quot;%ls\\service_%lu_%ls&quot;, service_ins=
tance,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
GetCurrentThreadId(), pipe_uuid_str);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    RpcStringFree(&amp;pipe_uuid_str);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ovpn_pipe =3D Cr=
eateNamedPipe(</span><br><span>         ovpn_pipe_name, PIPE_ACCESS_DUPLEX =
| FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        PIPE_TYPE_MESSAGE | PIPE_READMODE=
_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE =
| PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS, 1, 128, 128, 0, NULL);</span><br>=
<span>     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     =
{</span><br><span>         ReturnLastError(pipe, L&quot;CreateNamedPipe&quo=
t;);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/1396?usp=3Demail">change 1396</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1396?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie66a142751354e421d48b273784=
fc79bcb9f7208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1396 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ErXf8Kch+PI=--

