From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 15:31:34 +0000
In-Reply-To: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
References: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <acc2a9de77db456216cf31d6069aa0ebb3cae9e3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5EW2SqOjTts="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Update the
 clang-format reference version to 21.1.8
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5EW2SqOjTts=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Update the clang-format reference version to 21.1.8
......................................................................

Update the clang-format reference version to 21.1.8

Latest v21.x version.
Changes a few file in Windows specific code due
to bug fixes.

Change-Id: Iaf0d8f528211f1971f163a8006b054efb4917e2a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1514
Message-Id: <20260210151639.913-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
563.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .pre-commit-config.yaml
M src/openvpnmsica/openvpnmsica.c
M src/tapctl/main.c
3 files changed, 15 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1514/2

diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml
index c1bca47..5fd5465 100644
--- a/.pre-commit-config.yaml
+++ b/.pre-commit-config.yaml
@@ -1,6 +1,6 @@
 repos:
   - repo: https://github.com/pre-commit/mirrors-clang-format
-    rev: 'v20.1.0'
+    rev: 'v21.1.8'
     hooks:
       - id: clang-format
         files: \.[ch]$
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index b5d8cd2..a145b64 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -308,7 +308,8 @@
 }


-UINT __stdcall FindSystemInfo(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -335,7 +336,8 @@
 }


-UINT __stdcall CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -359,7 +361,8 @@
 }


-UINT __stdcall StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -620,7 +623,8 @@
 }


-UINT __stdcall EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -963,7 +967,8 @@
     }
 }

-UINT __stdcall ProcessDeferredAction(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
@@ -1166,7 +1171,8 @@
     return uiResult;
 }

-UINT __stdcall CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
+UINT __stdcall
+CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 {
 #ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index 6bb4119..1d047dd 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -609,7 +609,8 @@
 /**
  * Program entry point
  */
-int __cdecl wmain(int argc, LPCWSTR argv[])
+int __cdecl
+wmain(int argc, LPCWSTR argv[])
 {
     int iResult;
     BOOL bRebootRequired =3D FALSE;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf0d8f528211f1971f163a8006b054efb4917e2a
Gerrit-Change-Number: 1514
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5EW2SqOjTts=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Update the clang-format reference v=
ersion to 21.1.8<br><br>Latest v21.x version.<br>Changes a few file in Wind=
ows specific code due<br>to bug fixes.<br><br>Change-Id: Iaf0d8f528211f1971=
f163a8006b054efb4917e2a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: =
https://gerrit.openvpn.net/c/openvpn/+/1514<br>Message-Id: &lt;202602101516=
39.913-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg35563.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M .pre-commit-config.yaml<br>M src/openvpnms=
ica/openvpnmsica.c<br>M src/tapctl/main.c<br>3 files changed, 15 insertions=
(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/14/1514/2</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.pre-commit=
-config.yaml b/.pre-commit-config.yaml</span><br><span>index c1bca47..5fd54=
65 100644</span><br><span>--- a/.pre-commit-config.yaml</span><br><span>+++=
 b/.pre-commit-config.yaml</span><br><span>@@ -1,6 +1,6 @@</span><br><span>=
 repos:</span><br><span>   - repo: https://github.com/pre-commit/mirrors-cl=
ang-format</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rev: &#=
39;v20.1.0&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
rev: &#39;v21.1.8&#39;</span><br><span>     hooks:</span><br><span>       -=
 id: clang-format</span><br><span>         files: \.[ch]$</span><br><span>d=
iff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica=
.c</span><br><span>index b5d8cd2..a145b64 100644</span><br><span>--- a/src/=
openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnm=
sica.c</span><br><span>@@ -308,7 +308,8 @@</span><br><span> }</span><br><sp=
an> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-UINT __stdcall FindSystemInfo(_In_ MSIHANDLE hInstall)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+FindSystemInfo(_In_ MSIHANDLE hInstall)</spa=
n><br><span> {</span><br><span> #ifdef DLLEXP_EXPORT</span><br><span> #prag=
ma comment(linker, DLLEXP_EXPORT)</span><br><span>@@ -335,7 +336,8 @@</span=
><br><span> }</span><br><span> </span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-UINT __stdcall CloseOpenVPNGUI(_In_ MSIHANDLE h=
Install)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UINT __stdc=
all</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CloseOpenVPNGUI(=
_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span> #ifdef DLLEXP_=
EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><s=
pan>@@ -359,7 +361,8 @@</span><br><span> }</span><br><span> </span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall Sta=
rtOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+UINT __stdcall</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+StartOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span> {</s=
pan><br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker=
, DLLEXP_EXPORT)</span><br><span>@@ -620,7 +623,8 @@</span><br><span> }</sp=
an><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-UINT __stdcall EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+EvaluateTUNTAPAdapters(_In=
_ MSIHANDLE hInstall)</span><br><span> {</span><br><span> #ifdef DLLEXP_EXP=
ORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span=
>@@ -963,7 +967,8 @@</span><br><span>     }</span><br><span> }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall P=
rocessDeferredAction(_In_ MSIHANDLE hInstall)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+UINT __stdcall</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ProcessDeferredAction(_In_ MSIHANDLE hInstall)</span><=
br><span> {</span><br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma =
comment(linker, DLLEXP_EXPORT)</span><br><span>@@ -1166,7 +1171,8 @@</span>=
<br><span>     return uiResult;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall CheckAndSched=
uleReboot(_In_ MSIHANDLE hInstall)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+UINT __stdcall</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)</span><br><span> =
{</span><br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(li=
nker, DLLEXP_EXPORT)</span><br><span>diff --git a/src/tapctl/main.c b/src/t=
apctl/main.c</span><br><span>index 6bb4119..1d047dd 100644</span><br><span>=
--- a/src/tapctl/main.c</span><br><span>+++ b/src/tapctl/main.c</span><br><=
span>@@ -609,7 +609,8 @@</span><br><span> /**</span><br><span>  * Program e=
ntry point</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-int __cdecl wmain(int argc, LPCWSTR argv[])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+int __cdecl</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+wmain(int argc, LPCWSTR argv[])</span><br><span> =
{</span><br><span>     int iResult;</span><br><span>     BOOL bRebootRequir=
ed =3D FALSE;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail">change 1514</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf0d8f528211f1971f163a8006b=
054efb4917e2a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1514 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--5EW2SqOjTts=--

