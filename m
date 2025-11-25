From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 25 Nov 2025 08:58:41 +0000
In-Reply-To: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
References: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <bddc3a62782e2fe9e95c2eb74d9d3477e7e78e1c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3MRLklfVJeQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Harden
 interactive service pipe
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3MRLklfVJeQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1401
Message-Id: <20251124183839.24803-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
654.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 21 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1401/2

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index c717e99..2dc865e 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1955,11 +1955,30 @@
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
     openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), ser=
vice_instance, GetCurrentThreadId());
+                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu_%ls"),=
 service_instance,
+                     GetCurrentThreadId(), pipe_uuid_str);
+    RpcStringFree(&pipe_uuid_str);
+
     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_=
INSTANCE | FILE_FLAG_OVERLAPPED,
-                                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE =
| PIPE_WAIT, 1, 128, 128, 0, NULL);
+                                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE =
| PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS,
+                                1, 128, 128, 0, NULL);
     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)
     {
         ReturnLastError(pipe, L"CreateNamedPipe");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208
Gerrit-Change-Number: 1401
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3MRLklfVJeQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Harden interactive service pipe<br>=
<br>- Append a version 4 uuid to ovpn_pipe_name to make it less<br>  predic=
table<br>- Do not allow remote access to the pipe<br><br>This greatly reduc=
es the possibility of a rogue process racing to<br>open the pipe before Cre=
ateFile() is called in the worker thread.<br><br>Reported-by: Marc Heuse &l=
t;marc@...2953...&gt;<br>Change-Id: Ie66a142751354e421d48b273784fc79bcb9f72=
08<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: G=
ert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/1401<br>Message-Id: &lt;20251124183839.24803-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg34654.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpnserv/interactive.c<br>1 file changed, 21 insertions(+=
), 2 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/01/1401/2</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnse=
rv/interactive.c b/src/openvpnserv/interactive.c</span><br><span>index c717=
e99..2dc865e 100644</span><br><span>--- a/src/openvpnserv/interactive.c</sp=
an><br><span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -1955,1=
1 +1955,30 @@</span><br><span>         goto out;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    U=
UID pipe_uuid;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    R=
PC_STATUS rpc_stat =3D UuidCreate(&amp;pipe_uuid);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (rpc_stat !=3D RPC_S_OK)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        ReturnError(pipe, rpc_stat, L&quot;Uui=
dCreate&quot;, 1, &amp;exit_event);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    RPC_WSTR pipe_u=
uid_str =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rpc_stat =3D UuidToStringW(&amp;pipe_uuid, &amp;pipe_uuid_str);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (rpc_stat !=3D RPC_S_O=
K)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ReturnError(pipe, rpc_s=
tat, L&quot;UuidToString&quot;, 1, &amp;exit_event);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     openvpn_swprin=
tf(ovpn_pipe_name, _countof(ovpn_pipe_name),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                     TEXT(&quot;\\\\.\\pipe\\&quot; =
PACKAGE &quot;%ls\\service_%lu&quot;), service_instance, GetCurrentThreadId=
());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
      TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu_%ls&quo=
t;), service_instance,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     GetCurrentThreadId(), pipe_uuid_str);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    RpcStringFree(&amp;pipe_uuid_=
str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,</span><br><span>     =
                            PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTA=
NCE | FILE_FLAG_OVERLAPPED,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                PIPE_TYPE_MESSAGE | PIPE_READMODE_MES=
SAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                PIPE_TYPE_MESSAGE | PI=
PE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                                1=
, 128, 128, 0, NULL);</span><br><span>     if (ovpn_pipe =3D=3D INVALID_HAN=
DLE_VALUE)</span><br><span>     {</span><br><span>         ReturnLastError(=
pipe, L&quot;CreateNamedPipe&quot;);</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Dem=
ail">change 1401</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie66a142751354e421d48b273784=
fc79bcb9f7208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1401 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--3MRLklfVJeQ=--

