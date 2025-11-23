From: "selvanair (Code Review)" <gerrit@...515...>
Date: Sun, 23 Nov 2025 18:35:48 +0000
References: <gerrit.1763922943000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <03f74554af5caef6f620c2c0bcabc6dc17b0d225-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+vGBvyQ7hhw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+vGBvyQ7hhw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail

to review the following change.


Change subject: Restrict access to the service pipe to SYSTEM and owner
......................................................................

Restrict access to the service pipe to SYSTEM and owner

Access is restrcted to SYSTEM and pipe client user
(the user starting openvpn.exe). The default is
full access to Administrtors, owner, and read access
to everyone. This hardens the pipe further.

Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M src/openvpnserv/interactive.c
1 file changed, 18 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1397/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 7a0a075..521ffff 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3418,9 +3418,26 @@
              GetCurrentThreadId(), pipe_uuid_str);
     RpcStringFree(&pipe_uuid_str);

+    /* make a security descriptor for the named pipe with access
+     * restrcted to the user and SYSTEM
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Gerrit-Change-Number: 1397
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--+vGBvyQ7hhw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>selvanair would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Restrict access to the service pipe to SYST=
EM and owner<br><br>Access is restrcted to SYSTEM and pipe client user<br>(=
the user starting openvpn.exe). The default is<br>full access to Administrt=
ors, owner, and read access<br>to everyone. This hardens the pipe further.<=
br><br>Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e<br>Signed-off-b=
y: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M src/openvpnserv/inte=
ractive.c<br>1 file changed, 18 insertions(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/9=
7/1397/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnse=
rv/interactive.c</span><br><span>index 7a0a075..521ffff 100644</span><br><s=
pan>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnse=
rv/interactive.c</span><br><span>@@ -3418,9 +3418,26 @@</span><br><span>   =
           GetCurrentThreadId(), pipe_uuid_str);</span><br><span>     RpcSt=
ringFree(&amp;pipe_uuid_str);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* make a security descriptor for the named=
 pipe with access</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * restrcted to the user and SYSTEM</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    SECURITY_=
ATTRIBUTES sa;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    P=
SECURITY_DESCRIPTOR pSD =3D NULL;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    LPCWSTR szSDDL =3D L&quot;D:(A;;GA;;;SY)(A;;GA;;;OW)&quot=
;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ConvertS=
tringSecurityDescriptorToSecurityDescriptorW(</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            szSDDL, SDDL_REVISION_1, &amp;pSD, NU=
LL))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        ReturnLastError(pipe,=
 L&quot;ConvertSDDL&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sa.n=
Length =3D sizeof(sa);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    sa.lpSecurityDescriptor =3D pSD;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    sa.bInheritHandle =3D FALSE;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     ovpn_pipe =3D Creat=
eNamedPipe(</span><br><span>         ovpn_pipe_name, PIPE_ACCESS_DUPLEX | F=
ILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        PIPE_TYPE_MESSAGE | PIPE_READMODE_M=
ESSAGE | PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS, 1, 128, 128, 0, NULL);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        PIPE_TYPE_MESSA=
GE | PIPE_READMODE_MESSAGE | PIPE_WAIT | PIPE_REJECT_REMOTE_CLIENTS, 1, 128=
, 128, 0, &amp;sa);</span><br><span>     if (ovpn_pipe =3D=3D INVALID_HANDL=
E_VALUE)</span><br><span>     {</span><br><span>         ReturnLastError(pi=
pe, L&quot;CreateNamedPipe&quot;);</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demai=
l">change 1397</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd02=
27976606fe71e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1397 </div>
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

--+vGBvyQ7hhw=--

