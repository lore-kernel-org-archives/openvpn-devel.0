From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 25 Nov 2025 09:02:13 +0000
In-Reply-To: <gerrit.1764008169000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
References: <gerrit.1764008169000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <128bd44c75afc0b3563f428d6e4ccc2fe64ec6f6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6x5AlEiV0ek="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Restrict access
 to the service pipe to SYSTEM and owner
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

--6x5AlEiV0ek=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
02?usp=3Demail )

Change subject: Restrict access to the service pipe to SYSTEM and owner
......................................................................

Restrict access to the service pipe to SYSTEM and owner

Access is restricted to SYSTEM and pipe client user
(the user starting openvpn.exe). The default is
full access to Administrtors, owner, and read access
to everyone. This hardens the pipe further.

Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1402
Message-Id: <20251124183911.24851-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
656.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpnserv/interactive.c
1 file changed, 17 insertions(+), 1 deletion(-)




diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 2dc865e..275bf42 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -1975,10 +1975,26 @@
                      GetCurrentThreadId(), pipe_uuid_str);
     RpcStringFree(&pipe_uuid_str);

+    /* make a security descriptor for the named pipe with access
+     * restricted to the user and SYSTEM
+     */
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
     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_=
INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE =
| PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS,
-                                1, 128, 128, 0, NULL);
+                                1, 128, 128, 0, &sa);
+
     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)
     {
         ReturnLastError(pipe, L"CreateNamedPipe");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Gerrit-Change-Number: 1402
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6x5AlEiV0ek=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1402?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Restrict access to the service pipe to SYSTEM an=
d owner<br><br>Access is restricted to SYSTEM and pipe client user<br>(the =
user starting openvpn.exe). The default is<br>full access to Administrtors,=
 owner, and read access<br>to everyone. This hardens the pipe further.<br><=
br>Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e<br>Signed-off-by: S=
elva Nair &lt;selva.nair@...277...&gt;<br>Acked-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1402<br=
>Message-Id: &lt;20251124183911.24851-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34656.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn=
serv/interactive.c<br>1 file changed, 17 insertions(+), 1 deletion(-)<br><b=
r></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive=
.c</span><br><span>index 2dc865e..275bf42 100644</span><br><span>--- a/src/=
openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/interactive=
.c</span><br><span>@@ -1975,10 +1975,26 @@</span><br><span>                =
      GetCurrentThreadId(), pipe_uuid_str);</span><br><span>     RpcStringF=
ree(&amp;pipe_uuid_str);</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* make a security descriptor for the named pipe=
 with access</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
restricted to the user and SYSTEM</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    SECURITY_ATTRIBUTES sa;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    LPCWSTR szSDDL =3D L&quot;D:(A;;GA;;;SY)(A=
;;GA;;;OW)&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            szSDDL, SDDL_REVISION_=
1, &amp;pSD, NULL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        Return=
LastError(pipe, L&quot;ConvertSDDL&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    sa.nLength =3D sizeof(sa);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    sa.lpSecurityDescriptor =3D pSD;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    sa.bInheritHandle =3D FALSE;</span><=
br><span>     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,</span><br><span=
>                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE=
_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><span>                         =
        PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT=
_REMOTE_CLIENTS,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                           1, 128, 128, 0, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                1, 128, 128, =
0, &amp;sa);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)</span><br><span> =
    {</span><br><span>         ReturnLastError(pipe, L&quot;CreateNamedPipe=
&quot;);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail">change 1402</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd02=
27976606fe71e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1402 </div>
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

--6x5AlEiV0ek=--

