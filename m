From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 25 Nov 2025 08:58:45 +0000
In-Reply-To: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
References: <gerrit.1764008169000.Ie66a142751354e421d48b273784fc79bcb9f7208@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <bddc3a62782e2fe9e95c2eb74d9d3477e7e78e1c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dRepwTvjlPc="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dRepwTvjlPc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
01?usp=3Demail )

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

Gerrit-MessageType: merged
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

--dRepwTvjlPc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1401?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Harden interactive service pipe<br><br>- Append =
a version 4 uuid to ovpn_pipe_name to make it less<br>  predictable<br>- Do=
 not allow remote access to the pipe<br><br>This greatly reduces the possib=
ility of a rogue process racing to<br>open the pipe before CreateFile() is =
called in the worker thread.<br><br>Reported-by: Marc Heuse &lt;marc@...2967...=
3...&gt;<br>Change-Id: Ie66a142751354e421d48b273784fc79bcb9f7208<br>Signed-=
off-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Gert Doering &=
lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/=
+/1401<br>Message-Id: &lt;20251124183839.24803-1-gert@...1296...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34654=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M sr=
c/openvpnserv/interactive.c<br>1 file changed, 21 insertions(+), 2 deletion=
s(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index c717e99..2dc865e 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1955,11 +1955,30 @@</span><br><span>         goto ou=
t;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    UUID pipe_uuid;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    RPC_STATUS rpc_stat =3D UuidCreate(&amp;pipe_uu=
id);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (rpc_sta=
t !=3D RPC_S_OK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ReturnErr=
or(pipe, rpc_stat, L&quot;UuidCreate&quot;, 1, &amp;exit_event);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    RPC_WSTR pipe_uuid_str =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    rpc_stat =3D UuidToStringW(&amp;pipe_uuid, &=
amp;pipe_uuid_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (rpc_stat !=3D RPC_S_OK)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      ReturnError(pipe, rpc_stat, L&quot;UuidToString&quot;, 1, &amp;exit_e=
vent);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
out;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span>     openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     TEXT(=
&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu&quot;), service_in=
stance, GetCurrentThreadId());</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quo=
t;%ls\\service_%lu_%ls&quot;), service_instance,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                     GetCurrentThreadId(), pip=
e_uuid_str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    Rpc=
StringFree(&amp;pipe_uuid_str);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_n=
ame,</span><br><span>                                 PIPE_ACCESS_DUPLEX | =
FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                PIPE_TYPE_M=
ESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT_REM=
OTE_CLIENTS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                         1, 128, 128, 0, NULL);</span><br><span>     if (ov=
pn_pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span>     {</span><br><span=
>         ReturnLastError(pipe, L&quot;CreateNamedPipe&quot;);</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1401?usp=3Demail">change 1401</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?=
usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1401?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--dRepwTvjlPc=--

