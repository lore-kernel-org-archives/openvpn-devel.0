From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Feb 2026 15:00:22 +0000
References: <gerrit.1770735616000.Iaf0d8f528211f1971f163a8006b054efb4917e2a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <238cad596a5aebd4abb003c0f7ac42eaaba80bdd-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S8Ih7FAsi94="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S8Ih7FAsi94=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail

to review the following change.


Change subject: Update the clang-format reference version to 21.1.8
......................................................................

Update the clang-format reference version to 21.1.8

Latest v21.x version.
Changes a few file in Windows specific code due
to bug fixes.

Change-Id: Iaf0d8f528211f1971f163a8006b054efb4917e2a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .pre-commit-config.yaml
M src/openvpnmsica/openvpnmsica.c
M src/tapctl/main.c
3 files changed, 15 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/14/1514/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaf0d8f528211f1971f163a8006b054efb4917e2a
Gerrit-Change-Number: 1514
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--S8Ih7FAsi94=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1514?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Update the clang-format reference version t=
o 21.1.8<br><br>Latest v21.x version.<br>Changes a few file in Windows spec=
ific code due<br>to bug fixes.<br><br>Change-Id: Iaf0d8f528211f1971f163a800=
6b054efb4917e2a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M .pre-commit-config.yaml<br>M src/openvpnmsica/openvpnmsica.c<=
br>M src/tapctl/main.c<br>3 files changed, 15 insertions(+), 8 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/14/1514/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/.pre-commit-config.yaml b/.pre=
-commit-config.yaml</span><br><span>index c1bca47..5fd5465 100644</span><br=
><span>--- a/.pre-commit-config.yaml</span><br><span>+++ b/.pre-commit-conf=
ig.yaml</span><br><span>@@ -1,6 +1,6 @@</span><br><span> repos:</span><br><=
span>   - repo: https://github.com/pre-commit/mirrors-clang-format</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    rev: &#39;v20.1.0&#39;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    rev: &#39;v21.1.8&#=
39;</span><br><span>     hooks:</span><br><span>       - id: clang-format</=
span><br><span>         files: \.[ch]$</span><br><span>diff --git a/src/ope=
nvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>=
index b5d8cd2..a145b64 100644</span><br><span>--- a/src/openvpnmsica/openvp=
nmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><s=
pan>@@ -308,7 +308,8 @@</span><br><span> }</span><br><span> </span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall Fin=
dSystemInfo(_In_ MSIHANDLE hInstall)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+UINT __stdcall</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+FindSystemInfo(_In_ MSIHANDLE hInstall)</span><br><span> {</spa=
n><br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, =
DLLEXP_EXPORT)</span><br><span>@@ -335,7 +336,8 @@</span><br><span> }</span=
><br><span> </span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-UINT __stdcall CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+CloseOpenVPNGUI(_In_ MSIHANDLE hIns=
tall)</span><br><span> {</span><br><span> #ifdef DLLEXP_EXPORT</span><br><s=
pan> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span>@@ -359,7 +361,=
8 @@</span><br><span> }</span><br><span> </span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall StartOpenVPNGUI(_In_ M=
SIHANDLE hInstall)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+U=
INT __stdcall</span><br><span style=3D"color: hsl(120, 100%, 40%);">+StartO=
penVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span> #ifd=
ef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</s=
pan><br><span>@@ -620,7 +623,8 @@</span><br><span> }</span><br><span> </spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-UINT __s=
tdcall EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+UINT __stdcall</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstal=
l)</span><br><span> {</span><br><span> #ifdef DLLEXP_EXPORT</span><br><span=
> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span>@@ -963,7 +967,8 @=
@</span><br><span>     }</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-UINT __stdcall ProcessDeferredActio=
n(_In_ MSIHANDLE hInstall)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+UINT __stdcall</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ProcessDeferredAction(_In_ MSIHANDLE hInstall)</span><br><span> {</span><=
br><span> #ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLL=
EXP_EXPORT)</span><br><span>@@ -1166,7 +1171,8 @@</span><br><span>     retu=
rn uiResult;</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-UINT __stdcall CheckAndScheduleReboot(_In_ MSIH=
ANDLE hInstall)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+UINT=
 __stdcall</span><br><span style=3D"color: hsl(120, 100%, 40%);">+CheckAndS=
cheduleReboot(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span> =
#ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT=
)</span><br><span>diff --git a/src/tapctl/main.c b/src/tapctl/main.c</span>=
<br><span>index 6bb4119..1d047dd 100644</span><br><span>--- a/src/tapctl/ma=
in.c</span><br><span>+++ b/src/tapctl/main.c</span><br><span>@@ -609,7 +609=
,8 @@</span><br><span> /**</span><br><span>  * Program entry point</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-int __cde=
cl wmain(int argc, LPCWSTR argv[])</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int __cdecl</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+wmain(int argc, LPCWSTR argv[])</span><br><span> {</span><br><span> =
    int iResult;</span><br><span>     BOOL bRebootRequired =3D FALSE;</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1514?usp=3Demail">change 1514</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1514?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaf0d8f528211f1971f163a8006b=
054efb4917e2a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1514 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--S8Ih7FAsi94=--

