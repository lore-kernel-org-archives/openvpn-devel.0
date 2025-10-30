From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 30 Oct 2025 14:11:43 +0000
In-Reply-To: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
References: <gerrit.1761833482000.Ie990f4dd10094810d6632f8dedfa261727ebfbcb@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <28143412a9658f544a35b30e574cd3cfd98b08f7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FiSGQ7ww0e8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: openvpnserv:
 validate openvpn-gui process path
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

--FiSGQ7ww0e8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail

to look at the new patch set (#2).


Change subject: openvpnserv: validate openvpn-gui process path
......................................................................

openvpnserv: validate openvpn-gui process path

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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1333/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie990f4dd10094810d6632f8dedfa261727ebfbcb
Gerrit-Change-Number: 1333
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--FiSGQ7ww0e8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1333?usp=3Demail">View Change</=
a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">openvpnserv: validate openvpn-gui process path<br><br>E=
nsure that the service pipe client process (which is openvpn-gui)<br>is fro=
m openvpn binary directory, defined in registry. This limits<br>unauthorize=
d connections to the service pipe.<br><br>Reported-by: Abdul Mhanni &lt;abd=
ul.mhanni@...2951...&gt;<br><br>Change-Id: Ie990f4dd10094810d6632f8dedfa261=
727ebfbcb<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M =
src/openvpnserv/interactive.c<br>M src/openvpnserv/validate.c<br>M src/open=
vpnserv/validate.h<br>3 files changed, 55 insertions(+), 0 deletions(-)<br>=
<br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/33/1333/2</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/src/openvpnserv/interactive.c b/sr=
c/openvpnserv/interactive.c</span><br><span>index ce0d4dd..f4b3311 100644</=
span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/sr=
c/openvpnserv/interactive.c</span><br><span>@@ -3275,6 +3275,12 @@</span><b=
r><span>     ZeroMemory(&amp;undo_lists, sizeof(undo_lists));</span><br><sp=
an>     ZeroMemory(&amp;proc_info, sizeof(proc_info));</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!ValidateServi=
cePipeClient(pipe, &amp;settings))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ReturnError(pipe, ERROR_ACCESS_DENIED, L&quot;ValidateServicePipeC=
lient&quot;, 1, &amp;exit_event);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        goto out;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     if (!GetStartupData(pipe, &amp;sud))</span><br><span>  =
   {</span><br><span>         goto out;</span><br><span>diff --git a/src/op=
envpnserv/validate.c b/src/openvpnserv/validate.c</span><br><span>index 218=
7fb5..c5688d2 100644</span><br><span>--- a/src/openvpnserv/validate.c</span=
><br><span>+++ b/src/openvpnserv/validate.c</span><br><span>@@ -342,3 +342,=
48 @@</span><br><span> </span><br><span>     return TRUE;</span><br><span> =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+BOOL</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ValidateServicePipeClient(HANDLE pipe, const setting=
s_t *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ULONG clientPID =3D 0;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!GetNamedPipeCl=
ientProcessId(pipe, &amp;clientPID))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        MsgToEventLog(M_SYSERR, L&quot;GetNamedPipeClientProcessId() fai=
led&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    HANDLE hProc =3D OpenProcess(PROCES=
S_QUERY_LIMITED_INFORMATION, FALSE, clientPID);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (hProc =3D=3D NULL)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&quot;OpenProcess() f=
ailed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  return FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    wchar_t path[MAX_PATH] =3D { 0 };=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    DWORD size =3D =
_countof(path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
BOOL res =3D FALSE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (QueryFullProcessImageNameW(hProc, 0, path, &amp;size))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        WCHAR bin_dir[MAX_PATH];</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        /* canonicalize bin_dir and add trailing sla=
sh before comparison */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        HRESULT hr =3D PathCchCanonicalizeEx(bin_dir, _countof(bin_dir)=
, s-&gt;bin_dir,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                        PATHCCH_ENSURE_TRAILING_SLASH);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((hr =3D=3D =
S_OK) &amp;&amp; wcsncmp(bin_dir, path, wcslen(bin_dir)) =3D=3D 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            res =3D TRUE;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            MsgToEventLog(M_ERR, L&quot;Reject client from=
 untrusted path %ls&quot;, path);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        MsgToEventLog(M_SYSERR, L&q=
uot;QueryFullProcessImageNameW() failed&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    CloseHandle(hProc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return res;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span>diff --git a/src/openvpnserv/validate.h b/src/openvpnserv/vali=
date.h</span><br><span>index 6f3bf09..495902d 100644</span><br><span>--- a/=
src/openvpnserv/validate.h</span><br><span>+++ b/src/openvpnserv/validate.h=
</span><br><span>@@ -49,4 +49,8 @@</span><br><span>     return (wcsncmp(o, =
L&quot;--&quot;, 2) =3D=3D 0);</span><br><span> }</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ensures that the service=
 pipe client (openvpn-gui process)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * is from OpenVPN binary directory */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+BOOL ValidateServicePipeClient(HANDLE pip=
e, const settings_t *s);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> #endif /* ifndef VALIDATE_H */</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1333?usp=3Demail">change 1333</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dema=
il">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1333?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie990f4dd10094810d6632f8dedf=
a261727ebfbcb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1333 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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

--FiSGQ7ww0e8=--

