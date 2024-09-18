From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 11:36:53 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <7a02a2847d5c237142173b44ddf744c3cfe76b17-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bxq8/1O0U+c="; charset=UTF-8
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

--bxq8/1O0U+c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Add building/testing with msbuild and the clang compiler
......................................................................

Add building/testing with msbuild and the clang compiler

The LLVM/clang compiler warning and error message are easier too read
than their MSVC cl counterparts. Also compiling/running tests on Windows
with a different compiler has the benefit of a better coverage.

This includes a few minor changes to allow clang-cl to compile the
project.

Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M CMakePresets.json
M config.h.cmake.in
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
6 files changed, 77 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/5

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
index ad620fa..f4a305f 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -622,7 +622,8 @@
         check_linker_flag(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_WRAP)
     endif()

-    if (${LD_SUPPORTS_WRAP})
+    # Clang-cl (which is also MSVC) is wrongly detected to support wrap
+    if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
             "test_argv"
             "test_tls_crypt"
diff --git a/CMakePresets.json b/CMakePresets.json
index 135b19d..b6ec201 100644
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
+            "configurePreset": "win-x86-clang-release",
+            "configuration": "Release"
+        },
+        {
             "name": "win-amd64-debug",
             "configurePreset": "win-amd64-debug",
             "configuration": "Debug"
         },
         {
+            "name": "win-amd64-clang-debug",
+            "configurePreset": "win-amd64-clang-debug",
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
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 18af5e9..724da2e 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -442,8 +442,10 @@
 # define _GNU_SOURCE 1
 #endif

-
-#if defined(_WIN32)
+/* if inttypes.h is included this breaks rc.exe when using the ClangCL
+ * Toolchain as it pulls in a inttypes.h variant for clang that rc.exe does
+ * not understand (#include_next preprocessor directive) */
+#if defined(_WIN32) && !defined(RC_INVOKED)
 #include <inttypes.h>
 typedef uint32_t in_addr_t;
 typedef uint16_t in_port_t;
@@ -455,7 +457,7 @@
 #define SIGTERM   15
 #endif

-#if defined(_MSC_VER)
+#if defined(_MSC_VER) && !defined(RC_INVOKED)
 #include <BaseTsd.h>
 typedef SSIZE_T ssize_t;
 #define strncasecmp strnicmp
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 5ffb5b3..1033c61 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -300,7 +300,7 @@
 UINT __stdcall
 FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -337,7 +337,7 @@
 UINT __stdcall
 CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
     UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with=
 MSI session (report errors, access properties, tables, etc.). */
@@ -360,7 +360,7 @@
 UINT __stdcall
 StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -633,7 +633,7 @@
 UINT __stdcall
 EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -786,7 +786,7 @@
                 {
                     goto cleanup_szDisplayName;
                 }
-#ifdef __GNUC__
+#if defined(__GNUC__) || defined(__clang__)
 /*
  * warning: enumeration value =E2=80=98MSICONDITION_TRUE=E2=80=99 not hand=
led in switch
  * warning: enumeration value =E2=80=98MSICONDITION_NONE=E2=80=99 not hand=
led in switch
@@ -806,7 +806,7 @@
                         free(szValue);
                         goto cleanup_szDisplayName;
                 }
-#ifdef __GNUC__
+#if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
                 free(szValue);
@@ -962,7 +962,7 @@
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -1162,7 +1162,7 @@
 UINT __stdcall
 CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index 6640d7e..d4c8596 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -66,7 +66,11 @@
 extern "C" {
 #endif

-#ifdef __GNUC__
+/* Ensure that clang-cl, which does not understand the cl specific
+ * preprocessor defines like #pragma comment(linker, DLLEXP_EXPORT)
+ * is handled the same way as mingw and uses the alternative instead
+ * and does not define DLLEXP_EXPORT */
+#if defined(__GNUC__) || defined(__clang__)
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--bxq8/1O0U+c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add building/testing with msbuild and the cla=
ng compiler<br><br>The LLVM/clang compiler warning and error message are ea=
sier too read<br>than their MSVC cl counterparts. Also compiling/running te=
sts on Windows<br>with a different compiler has the benefit of a better cov=
erage.<br><br>This includes a few minor changes to allow clang-cl to compil=
e the<br>project.<br><br>Change-Id: I43d84034f3e920a45731c4aab4f851a6092129=
0d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M .gith=
ub/workflows/build.yaml<br>M CMakeLists.txt<br>M CMakePresets.json<br>M con=
fig.h.cmake.in<br>M src/openvpnmsica/openvpnmsica.c<br>M src/openvpnmsica/o=
penvpnmsica.h<br>6 files changed, 77 insertions(+), 14 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/5</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.y=
aml</span><br><span>index 361d457..d326937 100644</span><br><span>--- a/.gi=
thub/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yam=
l</span><br><span>@@ -272,7 +272,7 @@</span><br><span>       strategy:</spa=
n><br><span>         fail-fast: false</span><br><span>         matrix:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-          arch: [amd64, x8=
6, arm64]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
arch: [amd64, x86, arm64, amd64-clang, x86-clang]</span><br><span> </span><=
br><span>       name: &quot;msbuild - ${{ matrix.arch }} - openssl&quot;</s=
pan><br><span>       env:</span><br><span>diff --git a/CMakeLists.txt b/CMa=
keLists.txt</span><br><span>index ad620fa..f4a305f 100644</span><br><span>-=
-- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@=
 -622,7 +622,8 @@</span><br><span>         check_linker_flag(C -Wl,--wrap=
=3Dparse_line LD_SUPPORTS_WRAP)</span><br><span>     endif()</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (${LD_SUPPO=
RTS_WRAP})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Cla=
ng-cl (which is also MSVC) is wrongly detected to support wrap</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (NOT MSVC AND &quot;${LD_=
SUPPORTS_WRAP}&quot;)</span><br><span>         list(APPEND unit_tests</span=
><br><span>             &quot;test_argv&quot;</span><br><span>             =
&quot;test_tls_crypt&quot;</span><br><span>diff --git a/CMakePresets.json b=
/CMakePresets.json</span><br><span>index 135b19d..b6ec201 100644</span><br>=
<span>--- a/CMakePresets.json</span><br><span>+++ b/CMakePresets.json</span=
><br><span>@@ -122,6 +122,10 @@</span><br><span>             }</span><br><s=
pan>         },</span><br><span>         {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;clangtoolset&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;toolset&quot;: &quot;ClangCL&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        {</span><br><span>             &quot;name&quot;: &quot;ming=
w-x64&quot;,</span><br><span>             &quot;inherits&quot;: [ &quot;bas=
e&quot;, &quot;base-mingw&quot;, &quot;x64-mingw&quot; ]</span><br><span>  =
       },</span><br><span>@@ -134,6 +138,10 @@</span><br><span>            =
 &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;=
x64&quot;, &quot;release&quot; ]</span><br><span>         },</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;name&quot;: &quot;win-amd64-clang-release&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [=
 &quot;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &quo=
t;x64&quot;, &quot;release&quot; ]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span>             &quot;name&quot;: &quot;win-ar=
m64-release&quot;,</span><br><span>             &quot;inherits&quot;: [ &qu=
ot;base&quot;, &quot;base-windows&quot;, &quot;arm64&quot;, &quot;release&q=
uot; ]</span><br><span>         },</span><br><span>@@ -142,10 +150,18 @@</s=
pan><br><span>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;=
base-windows&quot;, &quot;x86&quot;, &quot;release&quot; ]</span><br><span>=
         },</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-releas=
e&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;=
clangtoolset&quot;, &quot;x86&quot;, &quot;release&quot; ]</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;=
name&quot;: &quot;win-amd64-debug&quot;,</span><br><span>             &quot=
;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;x64&qu=
ot;, &quot;debug&quot; ]</span><br><span>         },</span><br><span>      =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;name&quot;: &quot;win-amd64-clang-debug&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ &quot;bas=
e&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &quot;x64&quot=
;, &quot;debug&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span>             &quot;name&quot;: &quot;win-arm64-debug&qu=
ot;,</span><br><span>             &quot;inherits&quot;: [ &quot;base&quot;,=
 &quot;base-windows&quot;, &quot;arm64&quot;, &quot;debug&quot; ]</span><br=
><span>         },</span><br><span>@@ -154,6 +170,10 @@</span><br><span>   =
          &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot=
;, &quot;x86&quot;, &quot;debug&quot; ]</span><br><span>         },</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;name&quot;: &quot;win-x86-clang-debug&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;=
: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &=
quot;x86&quot;, &quot;debug&quot; ]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span>             &quot;name&quot;: &quot;unix-=
native&quot;,</span><br><span>             &quot;generator&quot;: &quot;Nin=
ja Multi-Config&quot;,</span><br><span>             &quot;binaryDir&quot;: =
&quot;out/build/unix&quot;</span><br><span>@@ -174,6 +194,11 @@</span><br><=
span>             &quot;configuration&quot;: &quot;Release&quot;</span><br>=
<span>         },</span><br><span>         {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clan=
g-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;configurePreset&quot;: &quot;win-amd64-clang-release&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;co=
nfiguration&quot;: &quot;Release&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span>             &quot;name&quot;: &quot;wi=
n-arm64-release&quot;,</span><br><span>             &quot;configurePreset&q=
uot;: &quot;win-arm64-release&quot;,</span><br><span>             &quot;con=
figuration&quot;: &quot;Release&quot;</span><br><span>@@ -184,11 +209,21 @@=
</span><br><span>             &quot;configuration&quot;: &quot;Release&quot=
;</span><br><span>         },</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;wi=
n-x86-clang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;configurePreset&quot;: &quot;win-x86-clang-release=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
&quot;configuration&quot;: &quot;Release&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span>             &quot;name&quot;: =
&quot;win-amd64-debug&quot;,</span><br><span>             &quot;configurePr=
eset&quot;: &quot;win-amd64-debug&quot;,</span><br><span>             &quot=
;configuration&quot;: &quot;Debug&quot;</span><br><span>         },</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;name&quot;: &quot;win-amd64-clang-debug&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePre=
set&quot;: &quot;win-amd64-clang-debug&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot;configuration&quot;: &quot;Debu=
g&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span>             &quot;name&quot;: &quot;win-arm64-debug&quot;,</span><br>=
<span>             &quot;configurePreset&quot;: &quot;win-arm64-debug&quot;=
,</span><br><span>             &quot;configuration&quot;: &quot;Debug&quot;=
</span><br><span>@@ -199,6 +234,11 @@</span><br><span>             &quot;co=
nfiguration&quot;: &quot;Debug&quot;</span><br><span>         },</span><br>=
<span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;name&quot;: &quot;win-x86-clang-debug&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePreset&q=
uot;: &quot;win-x86-clang-debug&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;configuration&quot;: &quot;Debug&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>  =
           &quot;name&quot;: &quot;unix-native&quot;,</span><br><span>     =
        &quot;configurePreset&quot;: &quot;unix-native&quot;</span><br><spa=
n>         }</span><br><span>@@ -209,18 +249,34 @@</span><br><span>        =
     &quot;configurePreset&quot;: &quot;win-amd64-release&quot;</span><br><=
span>         },</span><br><span>         {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang=
-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &quot;configurePreset&quot;: &quot;win-amd64-clang-release&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>     =
        &quot;name&quot;: &quot;win-x86-release&quot;,</span><br><span>    =
         &quot;configurePreset&quot;: &quot;win-x86-release&quot;</span><br=
><span>         },</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang=
-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        &quot;configurePreset&quot;: &quot;win-x86-clang-release&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>       =
      &quot;name&quot;: &quot;win-amd64-debug&quot;,</span><br><span>      =
       &quot;configurePreset&quot;: &quot;win-amd64-debug&quot;</span><br><=
span>         },</span><br><span>         {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang=
-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;configurePreset&quot;: &quot;win-amd64-clang-debug&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>         =
    &quot;name&quot;: &quot;win-x86-debug&quot;,</span><br><span>          =
   &quot;configurePreset&quot;: &quot;win-x86-debug&quot;</span><br><span> =
        },</span><br><span>         {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-debug&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;configurePreset&quot;: &quot;win-x86-clang-debug&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;=
name&quot;: &quot;unix-native&quot;,</span><br><span>             &quot;con=
figurePreset&quot;: &quot;unix-native&quot;</span><br><span>         }</spa=
n><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><s=
pan>index 18af5e9..724da2e 100644</span><br><span>--- a/config.h.cmake.in</=
span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -442,8 +442,10 @@=
</span><br><span> # define _GNU_SOURCE 1</span><br><span> #endif</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* if inttypes.h is included this b=
reaks rc.exe when using the ClangCL</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * Toolchain as it pulls in a inttypes.h variant for clang =
that rc.exe does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
not understand (#include_next preprocessor directive) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) &amp;&amp; !define=
d(RC_INVOKED)</span><br><span> #include &lt;inttypes.h&gt;</span><br><span>=
 typedef uint32_t in_addr_t;</span><br><span> typedef uint16_t in_port_t;</=
span><br><span>@@ -455,7 +457,7 @@</span><br><span> #define SIGTERM   15</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#if defined(_MSC_VER)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defined(RC_INVOKED)</=
span><br><span> #include &lt;BaseTsd.h&gt;</span><br><span> typedef SSIZE_T=
 ssize_t;</span><br><span> #define strncasecmp strnicmp</span><br><span>dif=
f --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c=
</span><br><span>index 5ffb5b3..1033c61 100644</span><br><span>--- a/src/op=
envpnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnmsi=
ca.c</span><br><span>@@ -300,7 +300,7 @@</span><br><span> UINT __stdcall</s=
pan><br><span> FindSystemInfo(_In_ MSIHANDLE hInstall)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span>=
<br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif</=
span><br><span> </span><br><span>@@ -337,7 +337,7 @@</span><br><span> UINT =
__stdcall</span><br><span> CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MS=
C_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_=
EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><s=
pan> #endif</span><br><span>     UNREFERENCED_PARAMETER(hInstall); /* This =
CA is does not interact with MSI session (report errors, access properties,=
 tables, etc.). */</span><br><span>@@ -360,7 +360,7 @@</span><br><span> UIN=
T __stdcall</span><br><span> StartOpenVPNGUI(_In_ MSIHANDLE hInstall)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _=
MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEX=
P_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br>=
<span> #endif</span><br><span> </span><br><span>@@ -633,7 +633,7 @@</span><=
br><span> UINT __stdcall</span><br><span> EvaluateTUNTAPAdapters(_In_ MSIHA=
NDLE hInstall)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEX=
P_EXPORT)</span><br><span> #endif</span><br><span> </span><br><span>@@ -786=
,7 +786,7 @@</span><br><span>                 {</span><br><span>           =
          goto cleanup_szDisplayName;</span><br><span>                 }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNUC__</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span> /*</span><br><span>  * warning: enumeratio=
n value =E2=80=98MSICONDITION_TRUE=E2=80=99 not handled in switch</span><br=
><span>  * warning: enumeration value =E2=80=98MSICONDITION_NONE=E2=80=99 n=
ot handled in switch</span><br><span>@@ -806,7 +806,7 @@</span><br><span>  =
                       free(szValue);</span><br><span>                     =
    goto cleanup_szDisplayName;</span><br><span>                 }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNUC__</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span> #pragma GCC diagnostic pop</span><br><span> #end=
if</span><br><span>                 free(szValue);</span><br><span>@@ -962,=
7 +962,7 @@</span><br><span> UINT __stdcall</span><br><span> ProcessDeferre=
dAction(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma c=
omment(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><span> </sp=
an><br><span>@@ -1162,7 +1162,7 @@</span><br><span> UINT __stdcall</span><b=
r><span> CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</spa=
n><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif=
</span><br><span> </span><br><span>diff --git a/src/openvpnmsica/openvpnmsi=
ca.h b/src/openvpnmsica/openvpnmsica.h</span><br><span>index 6640d7e..d4c85=
96 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.h</span><br><=
span>+++ b/src/openvpnmsica/openvpnmsica.h</span><br><span>@@ -66,7 +66,11 =
@@</span><br><span> extern &quot;C&quot; {</span><br><span> #endif</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNU=
C__</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ensure that c=
lang-cl, which does not understand the cl specific</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * preprocessor defines like #pragma comment=
(linker, DLLEXP_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * is handled the same way as mingw and uses the alternative instead</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and does not define=
 DLLEXP_EXPORT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
f defined(__GNUC__) || defined(__clang__)</span><br><span> #define DLLEXP_D=
ECL __declspec(dllexport)</span><br><span> #else</span><br><span> #define D=
LLEXP_DECL</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">change 751</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/751?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--bxq8/1O0U+c=--

