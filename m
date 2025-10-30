From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 14:11:24 +0000
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <919c933c21b99b20d9b61fc9d6787b8ecbf0cf21-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z1PNA5aKr6E="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
 validate opevnvpn-gui process path
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

--Z1PNA5aKr6E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail

to review the following change.


Change subject: openvpnserv: validate opevnvpn-gui process path
......................................................................

openvpnserv: validate opevnvpn-gui process path

Ensure that the service pipe client process (which is openvpn-gui)
is from openvpn binary directory, defined in registry. This limits
unauthorized connections to the service pipe.

Reported-by: Abdul Mhanni <abdul.mhanni@...2951...>

Change-Id: Ie990f4dd10094810d6632f8dedfa261727ebfbcb
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpnserv/interactive.c
M src/openvpnserv/validate.c
M src/openvpnserv/validate.h
3 files changed, 55 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1333/1

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index ce0d4dd..f4b3311 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -3275,6 +3275,12 @@
     ZeroMemory(&undo_lists, sizeof(undo_lists));
     ZeroMemory(&proc_info, sizeof(proc_info));

+    if (!ValidateServicePipeClient(pipe, &settings))
+    {
+        ReturnError(pipe, ERROR_ACCESS_DENIED, L"ValidateServicePipeClient=
", 1, &exit_event);
+        goto out;
+    }
+
     if (!GetStartupData(pipe, &sud))
     {
         goto out;
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 2187fb5..c5688d2 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -342,3 +342,48 @@

     return TRUE;
 }
+
+BOOL
+ValidateServicePipeClient(HANDLE pipe, const settings_t *s)
+{
+    ULONG clientPID =3D 0;
+    if (!GetNamedPipeClientProcessId(pipe, &clientPID))
+    {
+        MsgToEventLog(M_SYSERR, L"GetNamedPipeClientProcessId() failed");
+        return FALSE;
+    }
+
+    HANDLE hProc =3D OpenProcess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE,=
 clientPID);
+    if (hProc =3D=3D NULL)
+    {
+        MsgToEventLog(M_SYSERR, L"OpenProcess() failed");
+        return FALSE;
+    }
+
+    wchar_t path[MAX_PATH] =3D { 0 };
+    DWORD size =3D _countof(path);
+    BOOL res =3D FALSE;
+    if (QueryFullProcessImageNameW(hProc, 0, path, &size))
+    {
+        WCHAR bin_dir[MAX_PATH];
+
+        /* canonicalize bin_dir and add trailing slash before comparison */
+        HRESULT hr =3D PathCchCanonicalizeEx(bin_dir, _countof(bin_dir), s=
->bin_dir,
+                                           PATHCCH_ENSURE_TRAILING_SLASH);
+        if ((hr =3D=3D S_OK) && wcsncmp(bin_dir, path, wcslen(bin_dir)) =
=3D=3D 0)
+        {
+            res =3D TRUE;
+        }
+        else
+        {
+            MsgToEventLog(M_ERR, L"Reject client from untrusted path %ls",=
 path);
+        }
+    }
+    else
+    {
+        MsgToEventLog(M_SYSERR, L"QueryFullProcessImageNameW() failed");
+    }
+    CloseHandle(hProc);
+
+    return res;
+}
diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/validate.h
index 6f3bf09..495902d 100644
--- a/src/openvpnserv/validate.h
+++ b/src/openvpnserv/validate.h
@@ -49,4 +49,8 @@
     return (wcsncmp(o, L"--", 2) =3D=3D 0);
 }

+/* Ensures that the service pipe client (openvpn-gui process)
+ * is from OpenVPN binary directory */
+BOOL ValidateServicePipeClient(HANDLE pipe, const settings_t *s);
+
 #endif /* ifndef VALIDATE_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie990f4dd10094810d6632f8dedfa261727ebfbcb
Gerrit-Change-Number: 1333
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--Z1PNA5aKr6E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">openvpnserv: validate opevnvpn-gui process =
path<br><br>Ensure that the service pipe client process (which is openvpn-g=
ui)<br>is from openvpn binary directory, defined in registry. This limits<b=
r>unauthorized connections to the service pipe.<br><br>Reported-by: Abdul M=
hanni &lt;abdul.mhanni@...2951...&gt;<br><br>Change-Id: Ie990f4dd10094810d6=
632f8dedfa261727ebfbcb<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;=
<br>---<br>M src/openvpnserv/interactive.c<br>M src/openvpnserv/validate.c<=
br>M src/openvpnserv/validate.h<br>3 files changed, 55 insertions(+), 0 del=
etions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/33/1333/1</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpnserv/inter=
active.c b/src/openvpnserv/interactive.c</span><br><span>index ce0d4dd..f4b=
3311 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><=
span>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -3275,6 +3275,1=
2 @@</span><br><span>     ZeroMemory(&amp;undo_lists, sizeof(undo_lists));<=
/span><br><span>     ZeroMemory(&amp;proc_info, sizeof(proc_info));</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
ValidateServicePipeClient(pipe, &amp;settings))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ReturnError(pipe, ERROR_ACCESS_DENIED, L&quot;Validat=
eServicePipeClient&quot;, 1, &amp;exit_event);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        goto out;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span>     if (!GetStartupData(pipe, &amp;sud))</span=
><br><span>     {</span><br><span>         goto out;</span><br><span>diff -=
-git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c</span><br><s=
pan>index 2187fb5..c5688d2 100644</span><br><span>--- a/src/openvpnserv/val=
idate.c</span><br><span>+++ b/src/openvpnserv/validate.c</span><br><span>@@=
 -342,3 +342,48 @@</span><br><span> </span><br><span>     return TRUE;</spa=
n><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+BOOL</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ValidateServicePipeClient(HANDLE pipe, =
const settings_t *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ULONG clientP=
ID =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!G=
etNamedPipeClientProcessId(pipe, &amp;clientPID))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;GetNamedPipeClientPr=
ocessId() failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    HANDLE hProc =3D OpenP=
rocess(PROCESS_QUERY_LIMITED_INFORMATION, FALSE, clientPID);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (hProc =3D=3D NULL)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;Op=
enProcess() failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        return FALSE;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    wchar_t path[MAX_PAT=
H] =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DW=
ORD size =3D _countof(path);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    BOOL res =3D FALSE;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (QueryFullProcessImageNameW(hProc, 0, path, &amp;size))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        WCHAR bin_dir[MAX_PATH];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        /* canonicalize bin_dir and add=
 trailing slash before comparison */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        HRESULT hr =3D PathCchCanonicalizeEx(bin_dir, _cou=
ntof(bin_dir), s-&gt;bin_dir,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                           PATHCCH_ENSURE_TRAILIN=
G_SLASH);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 ((hr =3D=3D S_OK) &amp;&amp; wcsncmp(bin_dir, path, wcslen(bin_dir)) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            res =3D TRU=
E;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            MsgToEventLog(M_ERR, L&quot;Reje=
ct client from untrusted path %ls&quot;, path);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog=
(M_SYSERR, L&quot;QueryFullProcessImageNameW() failed&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    CloseHandle(hProc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return res;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span>diff --git a/src/openvpnserv/validate.h b/src/=
openvpnserv/validate.h</span><br><span>index 6f3bf09..495902d 100644</span>=
<br><span>--- a/src/openvpnserv/validate.h</span><br><span>+++ b/src/openvp=
nserv/validate.h</span><br><span>@@ -49,4 +49,8 @@</span><br><span>     ret=
urn (wcsncmp(o, L&quot;--&quot;, 2) =3D=3D 0);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ensures =
that the service pipe client (openvpn-gui process)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * is from OpenVPN binary directory */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+BOOL ValidateServicePipeC=
lient(HANDLE pipe, const settings_t *s);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> #endif /* ifndef VALIDATE_H */</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1333?usp=3Demail">change 1333</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1333?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie990f4dd10094810d6632f8dedf=
a261727ebfbcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1333 </div>
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

</body></html>=

--Z1PNA5aKr6E=--

