From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 15:46:17 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f927c6e4145fab0a45c98f3ed91e21f43ea37ea8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8gafk5LYZK8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add building/testing
 with msbuild and the clang compiler
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8gafk5LYZK8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail

to look at the new patch set (#3).


Change subject: Add building/testing with msbuild and the clang compiler
......................................................................

Add building/testing with msbuild and the clang compiler

The LLVM/clang compiler warning and error message are easier too read
than their MSVC cl counterparts. Also compiling/running tests on Windows
with a different compiler has the benefit of a better coverage.

Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M CMakePresets.json
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
5 files changed, 67 insertions(+), 9 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/3

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 361d457..d326937 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -272,7 +272,7 @@
       strategy:
         fail-fast: false
         matrix:
-          arch: [amd64, x86, arm64]
+          arch: [amd64, x86, arm64, amd64-clang, x86-clang]

       name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6271574..a841590 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -624,7 +624,8 @@
         check_linker_flag(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_WRAP)
     endif()

-    if (${LD_SUPPORTS_WRAP})
+    # Clang-cl (which is also MSVC) is wrongly detected to support wrap
+    if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
             "test_argv"
             "test_tls_crypt"
diff --git a/CMakePresets.json b/CMakePresets.json
index 135b19d..c53c960 100644
--- a/CMakePresets.json
+++ b/CMakePresets.json
@@ -122,6 +122,10 @@
             }
         },
         {
+            "name": "clangtoolset",
+            "toolset": "ClangCL"
+        },
+        {
             "name": "mingw-x64",
             "inherits": [ "base", "base-mingw", "x64-mingw" ]
         },
@@ -134,6 +138,10 @@
             "inherits": [ "base", "base-windows", "x64", "release" ]
         },
         {
+            "name": "win-amd64-clang-release",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x64", "=
release" ]
+        },
+        {
             "name": "win-arm64-release",
             "inherits": [ "base", "base-windows", "arm64", "release" ]
         },
@@ -142,10 +150,18 @@
             "inherits": [ "base", "base-windows", "x86", "release" ]
         },
         {
+            "name": "win-x86-clang-release",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x86", "=
release" ]
+        },
+        {
             "name": "win-amd64-debug",
             "inherits": [ "base", "base-windows", "x64", "debug" ]
         },
         {
+            "name": "win-amd64-clang-debug",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x64", "=
debug" ]
+        },
+        {
             "name": "win-arm64-debug",
             "inherits": [ "base", "base-windows", "arm64", "debug" ]
         },
@@ -154,6 +170,10 @@
             "inherits": [ "base", "base-windows", "x86", "debug" ]
         },
         {
+            "name": "win-x86-clang-debug",
+            "inherits": [ "base", "base-windows", "clangtoolset", "x86", "=
debug" ]
+        },
+        {
             "name": "unix-native",
             "generator": "Ninja Multi-Config",
             "binaryDir": "out/build/unix"
@@ -174,6 +194,11 @@
             "configuration": "Release"
         },
         {
+            "name": "win-amd64-clang-release",
+            "configurePreset": "win-amd64-clang-release",
+            "configuration": "Release"
+        },
+        {
             "name": "win-arm64-release",
             "configurePreset": "win-arm64-release",
             "configuration": "Release"
@@ -184,11 +209,21 @@
             "configuration": "Release"
         },
         {
+            "name": "win-x86-clang-release",
+            "configurePreset": "win-x86-release",
+            "configuration": "Release"
+        },
+        {
             "name": "win-amd64-debug",
             "configurePreset": "win-amd64-debug",
             "configuration": "Debug"
         },
         {
+            "name": "win-amd64-clang-debug",
+            "configurePreset": "win-amd64-debug",
+            "configuration": "Debug"
+        },
+        {
             "name": "win-arm64-debug",
             "configurePreset": "win-arm64-debug",
             "configuration": "Debug"
@@ -199,6 +234,11 @@
             "configuration": "Debug"
         },
         {
+            "name": "win-x86-clang-debug",
+            "configurePreset": "win-x86-clang-debug",
+            "configuration": "Debug"
+        },
+        {
             "name": "unix-native",
             "configurePreset": "unix-native"
         }
@@ -209,18 +249,34 @@
             "configurePreset": "win-amd64-release"
         },
         {
+            "name": "win-amd64-clang-release",
+            "configurePreset": "win-amd64-clang-release"
+        },
+        {
             "name": "win-x86-release",
             "configurePreset": "win-x86-release"
         },
         {
+            "name": "win-x86-clang-release",
+            "configurePreset": "win-x86-clang-release"
+        },
+        {
             "name": "win-amd64-debug",
             "configurePreset": "win-amd64-debug"
         },
         {
+            "name": "win-amd64-clang-debug",
+            "configurePreset": "win-amd64-clang-debug"
+        },
+        {
             "name": "win-x86-debug",
             "configurePreset": "win-x86-debug"
         },
         {
+            "name": "win-x86-clang-debug",
+            "configurePreset": "win-x86-clang-debug"
+        },
+        {
             "name": "unix-native",
             "configurePreset": "unix-native"
         }
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 5ffb5b3..49d7944 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -300,7 +300,7 @@
 UINT __stdcall
 FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#if defined(_MSC_VER) && !defined(__clang__)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -337,7 +337,7 @@
 UINT __stdcall
 CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#if defined(_MSC_VER) && !defined(__clang__)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
     UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with=
 MSI session (report errors, access properties, tables, etc.). */
@@ -360,7 +360,7 @@
 UINT __stdcall
 StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#if defined(_MSC_VER) && !defined(__clang__)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -633,7 +633,7 @@
 UINT __stdcall
 EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#if defined(_MSC_VER) && !defined(__clang__)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -962,7 +962,7 @@
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#if defined(_MSC_VER) && !defined(__clang__)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -1162,7 +1162,7 @@
 UINT __stdcall
 CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#if defined(_MSC_VER) && !defined(__clang__)
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index 6640d7e..76cba48 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -66,7 +66,8 @@
 extern "C" {
 #endif

-#ifdef __GNUC__
+/* Ensure that clang-cl, which defines __GNUC__ is not matched here */
+#if  defined(__GNUC__) || defined(__clang__)
 #define DLLEXP_DECL __declspec(dllexport)
 #else
 #define DLLEXP_DECL

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Gerrit-Change-Number: 751
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--8gafk5LYZK8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Add building/testing with msbuild and the clang compiler<br><br>The L=
LVM/clang compiler warning and error message are easier too read<br>than th=
eir MSVC cl counterparts. Also compiling/running tests on Windows<br>with a=
 different compiler has the benefit of a better coverage.<br><br>Change-Id:=
 I43d84034f3e920a45731c4aab4f851a60921290d<br>Signed-off-by: Arne Schwabe &=
lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>M CMakeL=
ists.txt<br>M CMakePresets.json<br>M src/openvpnmsica/openvpnmsica.c<br>M s=
rc/openvpnmsica/openvpnmsica.h<br>5 files changed, 67 insertions(+), 9 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/51/751/3</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/w=
orkflows/build.yaml</span><br><span>index 361d457..d326937 100644</span><br=
><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/wor=
kflows/build.yaml</span><br><span>@@ -272,7 +272,7 @@</span><br><span>     =
  strategy:</span><br><span>         fail-fast: false</span><br><span>     =
    matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
arch: [amd64, x86, arm64]</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          arch: [amd64, x86, arm64, amd64-clang, x86-clang]</span><br=
><span> </span><br><span>       name: &quot;msbuild - ${{ matrix.arch }} - =
openssl&quot;</span><br><span>       env:</span><br><span>diff --git a/CMak=
eLists.txt b/CMakeLists.txt</span><br><span>index 6271574..a841590 100644</=
span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</s=
pan><br><span>@@ -624,7 +624,8 @@</span><br><span>         check_linker_fla=
g(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_WRAP)</span><br><span>     endif()<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (${LD_SUPPORTS_WRAP})</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    # Clang-cl (which is also MSVC) is wrongly detected to support wra=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NOT MSVC A=
ND &quot;${LD_SUPPORTS_WRAP}&quot;)</span><br><span>         list(APPEND un=
it_tests</span><br><span>             &quot;test_argv&quot;</span><br><span=
>             &quot;test_tls_crypt&quot;</span><br><span>diff --git a/CMake=
Presets.json b/CMakePresets.json</span><br><span>index 135b19d..c53c960 100=
644</span><br><span>--- a/CMakePresets.json</span><br><span>+++ b/CMakePres=
ets.json</span><br><span>@@ -122,6 +122,10 @@</span><br><span>             =
}</span><br><span>         },</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;cl=
angtoolset&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;toolset&quot;: &quot;ClangCL&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span>             &quot;name&quo=
t;: &quot;mingw-x64&quot;,</span><br><span>             &quot;inherits&quot=
;: [ &quot;base&quot;, &quot;base-mingw&quot;, &quot;x64-mingw&quot; ]</spa=
n><br><span>         },</span><br><span>@@ -134,6 +138,10 @@</span><br><spa=
n>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows=
&quot;, &quot;x64&quot;, &quot;release&quot; ]</span><br><span>         },<=
/span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;name&quot;: &quot;win-amd64-clang-release&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;inh=
erits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangtools=
et&quot;, &quot;x64&quot;, &quot;release&quot; ]</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span>             &quot;name&quot;=
: &quot;win-arm64-release&quot;,</span><br><span>             &quot;inherit=
s&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;arm64&quot;, &=
quot;release&quot; ]</span><br><span>         },</span><br><span>@@ -142,10=
 +150,18 @@</span><br><span>             &quot;inherits&quot;: [ &quot;base=
&quot;, &quot;base-windows&quot;, &quot;x86&quot;, &quot;release&quot; ]</s=
pan><br><span>         },</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x=
86-clang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-window=
s&quot;, &quot;clangtoolset&quot;, &quot;x86&quot;, &quot;release&quot; ]</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>    =
         &quot;name&quot;: &quot;win-amd64-debug&quot;,</span><br><span>   =
          &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot=
;, &quot;x64&quot;, &quot;debug&quot; ]</span><br><span>         },</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;name&quot;: &quot;win-amd64-clang-debug&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quo=
t;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;,=
 &quot;x64&quot;, &quot;debug&quot; ]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span>             &quot;name&quot;: &quot;win=
-arm64-debug&quot;,</span><br><span>             &quot;inherits&quot;: [ &q=
uot;base&quot;, &quot;base-windows&quot;, &quot;arm64&quot;, &quot;debug&qu=
ot; ]</span><br><span>         },</span><br><span>@@ -154,6 +170,10 @@</spa=
n><br><span>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;ba=
se-windows&quot;, &quot;x86&quot;, &quot;debug&quot; ]</span><br><span>    =
     },</span><br><span>         {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-debug&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangt=
oolset&quot;, &quot;x86&quot;, &quot;debug&quot; ]</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span>             &quot;name&quo=
t;: &quot;unix-native&quot;,</span><br><span>             &quot;generator&q=
uot;: &quot;Ninja Multi-Config&quot;,</span><br><span>             &quot;bi=
naryDir&quot;: &quot;out/build/unix&quot;</span><br><span>@@ -174,6 +194,11=
 @@</span><br><span>             &quot;configuration&quot;: &quot;Release&q=
uot;</span><br><span>         },</span><br><span>         {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot=
;win-amd64-clang-release&quot;,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;configurePreset&quot;: &quot;win-amd64-clang-=
release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &quot;configuration&quot;: &quot;Release&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;name&=
quot;: &quot;win-arm64-release&quot;,</span><br><span>             &quot;co=
nfigurePreset&quot;: &quot;win-arm64-release&quot;,</span><br><span>       =
      &quot;configuration&quot;: &quot;Release&quot;</span><br><span>@@ -18=
4,11 +209,21 @@</span><br><span>             &quot;configuration&quot;: &qu=
ot;Release&quot;</span><br><span>         },</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&=
quot;: &quot;win-x86-clang-release&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;configurePreset&quot;: &quot;win-x8=
6-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;configuration&quot;: &quot;Release&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;nam=
e&quot;: &quot;win-amd64-debug&quot;,</span><br><span>             &quot;co=
nfigurePreset&quot;: &quot;win-amd64-debug&quot;,</span><br><span>         =
    &quot;configuration&quot;: &quot;Debug&quot;</span><br><span>         }=
,</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;name&quot;: &quot;win-amd64-clang-debug&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;con=
figurePreset&quot;: &quot;win-amd64-debug&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;configuration&quot;: &quot;D=
ebug&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span>             &quot;name&quot;: &quot;win-arm64-debug&quot;,</span><=
br><span>             &quot;configurePreset&quot;: &quot;win-arm64-debug&qu=
ot;,</span><br><span>             &quot;configuration&quot;: &quot;Debug&qu=
ot;</span><br><span>@@ -199,6 +234,11 @@</span><br><span>             &quot=
;configuration&quot;: &quot;Debug&quot;</span><br><span>         },</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;name&quot;: &quot;win-x86-clang-debug&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePrese=
t&quot;: &quot;win-x86-clang-debug&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;configuration&quot;: &quot;Debug&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
>             &quot;name&quot;: &quot;unix-native&quot;,</span><br><span>  =
           &quot;configurePreset&quot;: &quot;unix-native&quot;</span><br><=
span>         }</span><br><span>@@ -209,18 +249,34 @@</span><br><span>     =
        &quot;configurePreset&quot;: &quot;win-amd64-release&quot;</span><b=
r><span>         },</span><br><span>         {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-cl=
ang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;configurePreset&quot;: &quot;win-amd64-clang-release&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>  =
           &quot;name&quot;: &quot;win-x86-release&quot;,</span><br><span> =
            &quot;configurePreset&quot;: &quot;win-x86-release&quot;</span>=
<br><span>         },</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-cl=
ang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;configurePreset&quot;: &quot;win-x86-clang-release&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>    =
         &quot;name&quot;: &quot;win-amd64-debug&quot;,</span><br><span>   =
          &quot;configurePreset&quot;: &quot;win-amd64-debug&quot;</span><b=
r><span>         },</span><br><span>         {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-cl=
ang-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;configurePreset&quot;: &quot;win-amd64-clang-debug&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>      =
       &quot;name&quot;: &quot;win-x86-debug&quot;,</span><br><span>       =
      &quot;configurePreset&quot;: &quot;win-x86-debug&quot;</span><br><spa=
n>         },</span><br><span>         {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-debu=
g&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;configurePreset&quot;: &quot;win-x86-clang-debug&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>             &q=
uot;name&quot;: &quot;unix-native&quot;,</span><br><span>             &quot=
;configurePreset&quot;: &quot;unix-native&quot;</span><br><span>         }<=
/span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnm=
sica/openvpnmsica.c</span><br><span>index 5ffb5b3..49d7944 100644</span><br=
><span>--- a/src/openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/open=
vpnmsica/openvpnmsica.c</span><br><span>@@ -300,7 +300,7 @@</span><br><span=
> UINT __stdcall</span><br><span> FindSystemInfo(_In_ MSIHANDLE hInstall)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(_MSC_VER) &amp;&amp; !defined(__clang__)</span><br><span> #pragma comme=
nt(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><span> </span><=
br><span>@@ -337,7 +337,7 @@</span><br><span> UINT __stdcall</span><br><spa=
n> CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defi=
ned(__clang__)</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</spa=
n><br><span> #endif</span><br><span>     UNREFERENCED_PARAMETER(hInstall); =
/* This CA is does not interact with MSI session (report errors, access pro=
perties, tables, etc.). */</span><br><span>@@ -360,7 +360,7 @@</span><br><s=
pan> UINT __stdcall</span><br><span> StartOpenVPNGUI(_In_ MSIHANDLE hInstal=
l)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(_MSC_VER) &amp;&amp; !defined(__clang__)</span><br><span> #pragma c=
omment(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><span> </sp=
an><br><span>@@ -633,7 +633,7 @@</span><br><span> UINT __stdcall</span><br>=
<span> EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;=
&amp; !defined(__clang__)</span><br><span> #pragma comment(linker, DLLEXP_E=
XPORT)</span><br><span> #endif</span><br><span> </span><br><span>@@ -962,7 =
+962,7 @@</span><br><span> UINT __stdcall</span><br><span> ProcessDeferredA=
ction(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defined(__clang__=
)</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> =
#endif</span><br><span> </span><br><span>@@ -1162,7 +1162,7 @@</span><br><s=
pan> UINT __stdcall</span><br><span> CheckAndScheduleReboot(_In_ MSIHANDLE =
hInstall)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#if defined(_MSC_VER) &amp;&amp; !defined(__clang__)</span><br><span> #p=
ragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><spa=
n> </span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.h b/src/open=
vpnmsica/openvpnmsica.h</span><br><span>index 6640d7e..76cba48 100644</span=
><br><span>--- a/src/openvpnmsica/openvpnmsica.h</span><br><span>+++ b/src/=
openvpnmsica/openvpnmsica.h</span><br><span>@@ -66,7 +66,8 @@</span><br><sp=
an> extern &quot;C&quot; {</span><br><span> #endif</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNUC__</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* Ensure that clang-cl, which d=
efines __GNUC__ is not matched here */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#if  defined(__GNUC__) || defined(__clang__)</span><br><=
span> #define DLLEXP_DECL __declspec(dllexport)</span><br><span> #else</spa=
n><br><span> #define DLLEXP_DECL</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">=
change 751</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8gafk5LYZK8=--

