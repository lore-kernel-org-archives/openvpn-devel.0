From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 15:31:36 +0000
In-Reply-To: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
References: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <acc2a9de77db456216cf31d6069aa0ebb3cae9e3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5g3I0fpZQrU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5g3I0fpZQrU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
14?usp=3Demail )

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

=20
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf0d8f528211f1971f163a8006b054efb4917e2a
Gerrit-Change-Number: 1514
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5g3I0fpZQrU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1514?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Update the clang-format reference version to 21.=
1.8<br><br>Latest v21.x version.<br>Changes a few file in Windows specific =
code due<br>to bug fixes.<br><br>Change-Id: Iaf0d8f528211f1971f163a8006b054=
efb4917e2a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>=
Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerri=
t.openvpn.net/c/openvpn/+/1514<br>Message-Id: &lt;20260210151639.913-1-gert=
@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg35563.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M .pre-commit-config.yaml<br>M src/openvpnmsica/openvpnms=
ica.c<br>M src/tapctl/main.c<br>3 files changed, 15 insertions(+), 8 deleti=
ons(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.pre-commit-config.yaml b/.pre-commit-config.yaml</span><br=
><span>index c1bca47..5fd5465 100644</span><br><span>--- a/.pre-commit-conf=
ig.yaml</span><br><span>+++ b/.pre-commit-config.yaml</span><br><span>@@ -1=
,6 +1,6 @@</span><br><span> repos:</span><br><span>   - repo: https://githu=
b.com/pre-commit/mirrors-clang-format</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    rev: &#39;v20.1.0&#39;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    rev: &#39;v21.1.8&#39;</span><br><span>     hook=
s:</span><br><span>       - id: clang-format</span><br><span>         files=
: \.[ch]$</span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.c b/sr=
c/openvpnmsica/openvpnmsica.c</span><br><span>index b5d8cd2..a145b64 100644=
</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c</span><br><span>+++ =
b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -308,7 +308,8 @@</span=
><br><span> }</span><br><span> </span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-UINT __stdcall FindSystemInfo(_In_ MSIHANDLE hI=
nstall)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UINT __stdca=
ll</span><br><span style=3D"color: hsl(120, 100%, 40%);">+FindSystemInfo(_I=
n_ MSIHANDLE hInstall)</span><br><span> {</span><br><span> #ifdef DLLEXP_EX=
PORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><spa=
n>@@ -335,7 +336,8 @@</span><br><span> }</span><br><span> </span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall Close=
OpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+UINT __stdcall</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span> {</spa=
n><br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, =
DLLEXP_EXPORT)</span><br><span>@@ -359,7 +361,8 @@</span><br><span> }</span=
><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-UINT __stdcall StartOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+StartOpenVPNGUI(_In_ MSIHANDLE hIns=
tall)</span><br><span> {</span><br><span> #ifdef DLLEXP_EXPORT</span><br><s=
pan> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span>@@ -620,7 +623,=
8 @@</span><br><span> }</span><br><span> </span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall EvaluateTUNTAPAdapters=
(_In_ MSIHANDLE hInstall)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+UINT __stdcall</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)</span><br><span> {</span><=
br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLL=
EXP_EXPORT)</span><br><span>@@ -963,7 +967,8 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-UINT __stdcall ProcessDeferredAction(_In_ MSIHANDLE hInstall)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ProcessDeferredAction(_In_ =
MSIHANDLE hInstall)</span><br><span> {</span><br><span> #ifdef DLLEXP_EXPOR=
T</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span>@=
@ -1166,7 +1171,8 @@</span><br><span>     return uiResult;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-U=
INT __stdcall CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+CheckAndScheduleReboot(_In_ MSIHANDLE =
hInstall)</span><br><span> {</span><br><span> #ifdef DLLEXP_EXPORT</span><b=
r><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span>diff --git =
a/src/tapctl/main.c b/src/tapctl/main.c</span><br><span>index 6bb4119..1d04=
7dd 100644</span><br><span>--- a/src/tapctl/main.c</span><br><span>+++ b/sr=
c/tapctl/main.c</span><br><span>@@ -609,7 +609,8 @@</span><br><span> /**</s=
pan><br><span>  * Program entry point</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-int __cdecl wmain(int argc, LPCWSTR ar=
gv[])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int __cdecl</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+wmain(int argc, LPCWST=
R argv[])</span><br><span> {</span><br><span>     int iResult;</span><br><s=
pan>     BOOL bRebootRequired =3D FALSE;</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1514?usp=
=3Demail">change 1514</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--5g3I0fpZQrU=--

