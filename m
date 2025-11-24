From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 18:16:14 +0000
References: <gerrit.1764008169000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2684eb63715634a06440eab46bec9eb552638bd4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qhFRR1piTxk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qhFRR1piTxk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail

to review the following change.


Change subject: Restrict access to the service pipe to SYSTEM and owner
......................................................................

Restrict access to the service pipe to SYSTEM and owner

Access is restricted to SYSTEM and pipe client user
(the user starting openvpn.exe). The default is
full access to Administrtors, owner, and read access
to everyone. This hardens the pipe further.

Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpnserv/interactive.c
1 file changed, 17 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/1402/1

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Gerrit-Change-Number: 1402
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--qhFRR1piTxk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Restrict access to the service pipe to SYST=
EM and owner<br><br>Access is restricted to SYSTEM and pipe client user<br>=
(the user starting openvpn.exe). The default is<br>full access to Administr=
tors, owner, and read access<br>to everyone. This hardens the pipe further.=
<br><br>Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e<br>Signed-off-=
by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpnserv/int=
eractive.c<br>1 file changed, 17 insertions(+), 1 deletion(-)<br><br></pre>=
<pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/=
02/1402/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpns=
erv/interactive.c</span><br><span>index 2dc865e..275bf42 100644</span><br><=
span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpns=
erv/interactive.c</span><br><span>@@ -1975,10 +1975,26 @@</span><br><span> =
                     GetCurrentThreadId(), pipe_uuid_str);</span><br><span>=
     RpcStringFree(&amp;pipe_uuid_str);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* make a security descriptor for=
 the named pipe with access</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * restricted to the user and SYSTEM</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    SECURITY_ATTRIBUTES sa;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    PSECURITY_DESCRIPTOR pSD =3D NULL;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    LPCWSTR szSDDL =3D L&quot;D=
:(A;;GA;;;SY)(A;;GA;;;OW)&quot;;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (!ConvertStringSecurityDescriptorToSecurityDescriptorW(=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            szSDDL,=
 SDDL_REVISION_1, &amp;pSD, NULL))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ReturnLastError(pipe, L&quot;ConvertSDDL&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    sa.nLength =3D sizeof(sa);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    sa.lpSecurityDescriptor =3D pSD;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa.bInheritHandle =
=3D FALSE;</span><br><span>     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_nam=
e,</span><br><span>                                 PIPE_ACCESS_DUPLEX | FI=
LE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><span>       =
                          PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_=
WAIT | PIPE_REJECT_REMOTE_CLIENTS,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                1, 128, 128, 0, NULL);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                           =
     1, 128, 128, 0, &amp;sa);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     if (ovpn_pipe =3D=3D INVALID_HANDLE_VALUE)=
</span><br><span>     {</span><br><span>         ReturnLastError(pipe, L&qu=
ot;CreateNamedPipe&quot;);</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail">chang=
e 1402</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1402?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd02=
27976606fe71e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1402 </div>
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

--qhFRR1piTxk=--

