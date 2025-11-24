From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 18:16:13 +0000
References: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b481a79ba60bb6e737e5a379bf802b4f5b84cdfd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fHsp6cNs7pk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fHsp6cNs7pk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail

to review the following change.


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
---
M src/openvpnserv/interactive.c
1 file changed, 21 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1401/1

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208
Gerrit-Change-Number: 1401
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--fHsp6cNs7pk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Harden interactive service pipe<br><br>- Ap=
pend a version 4 uuid to ovpn_pipe_name to make it less<br>  predictable<br=
>- Do not allow remote access to the pipe<br><br>This greatly reduces the p=
ossibility of a rogue process racing to<br>open the pipe before CreateFile(=
) is called in the worker thread.<br><br>Reported-by: Marc Heuse &lt;marc@...220...=
..2953...&gt;<br>Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208<br>Si=
gned-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvp=
nserv/interactive.c<br>1 file changed, 21 insertions(+), 2 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/01/1401/1</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/sr=
c/openvpnserv/interactive.c</span><br><span>index c717e99..2dc865e 100644</=
span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/sr=
c/openvpnserv/interactive.c</span><br><span>@@ -1955,11 +1955,30 @@</span><=
br><span>         goto out;</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    UUID pipe_uuid;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    RPC_STATUS rpc_stat =
=3D UuidCreate(&amp;pipe_uuid);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (rpc_stat !=3D RPC_S_OK)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        ReturnError(pipe, rpc_stat, L&quot;UuidCreate&quot;, 1, &=
amp;exit_event);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     goto out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    RPC_WSTR pipe_uuid_str =3D NULL;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rpc_stat =3D Uuid=
ToStringW(&amp;pipe_uuid, &amp;pipe_uuid_str);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (rpc_stat !=3D RPC_S_OK)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        ReturnError(pipe, rpc_stat, L&quot;UuidToS=
tring&quot;, 1, &amp;exit_event);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span>     openvpn_swprintf(ovpn_pipe_name, _co=
untof(ovpn_pipe_name),</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                     TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\ser=
vice_%lu&quot;), service_instance, GetCurrentThreadId());</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                     TEXT(&quot;\\\\.=
\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu_%ls&quot;), service_instance,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
  GetCurrentThreadId(), pipe_uuid_str);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    RpcStringFree(&amp;pipe_uuid_str);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ovpn_pipe =3D =
CreateNamedPipe(ovpn_pipe_name,</span><br><span>                           =
      PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLA=
PPED,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 1=
28, 128, 0, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                               PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | =
PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                1, 128, 128, 0, NULL);<=
/span><br><span>     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><=
span>     {</span><br><span>         ReturnLastError(pipe, L&quot;CreateNam=
edPipe&quot;);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail">change 1401</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1401?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie66a142751354e421d48b273784=
fc79bcb9f7208 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1401 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--fHsp6cNs7pk=--

