From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 15:48:16 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <4f2ec23fabfec550c0931dc18ce059ff409d537a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t+cidfbb5hg="; charset=UTF-8
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

--t+cidfbb5hg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail

to look at the new patch set (#4).


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
6 files changed, 75 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/4

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
index 5ffb5b3..4517f51 100644
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
index 6640d7e..88780e8 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -66,7 +66,9 @@
 extern "C" {
 #endif

-#ifdef __GNUC__
+/* Ensure that clang-cl, which does not understand the #pragma comment(lin=
ker, ...)
+ * is handled the same way as mingw */
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--t+cidfbb5hg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Add building/testing with msbuild and the clang compiler<br><br>The L=
LVM/clang compiler warning and error message are easier too read<br>than th=
eir MSVC cl counterparts. Also compiling/running tests on Windows<br>with a=
 different compiler has the benefit of a better coverage.<br><br>This inclu=
des a few minor changes to allow clang-cl to compile the<br>project.<br><br=
>Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d<br>Signed-off-by: Arn=
e Schwabe &lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<=
br>M CMakeLists.txt<br>M CMakePresets.json<br>M config.h.cmake.in<br>M src/=
openvpnmsica/openvpnmsica.c<br>M src/openvpnmsica/openvpnmsica.h<br>6 files=
 changed, 75 insertions(+), 14 deletions(-)<br><br></pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit=
.openvpn.net:29418/openvpn refs/changes/51/751/4</pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.gith=
ub/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>inde=
x 361d457..d326937 100644</span><br><span>--- a/.github/workflows/build.yam=
l</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -27=
2,7 +272,7 @@</span><br><span>       strategy:</span><br><span>         fai=
l-fast: false</span><br><span>         matrix:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-          arch: [amd64, x86, arm64]</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+          arch: [amd64, x86, arm64=
, amd64-clang, x86-clang]</span><br><span> </span><br><span>       name: &q=
uot;msbuild - ${{ matrix.arch }} - openssl&quot;</span><br><span>       env=
:</span><br><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><s=
pan>index ad620fa..f4a305f 100644</span><br><span>--- a/CMakeLists.txt</spa=
n><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -622,7 +622,8 @@</span>=
<br><span>         check_linker_flag(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_=
WRAP)</span><br><span>     endif()</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (${LD_SUPPORTS_WRAP})</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    # Clang-cl (which is also MSVC=
) is wrongly detected to support wrap</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (NOT MSVC AND &quot;${LD_SUPPORTS_WRAP}&quot;)</sp=
an><br><span>         list(APPEND unit_tests</span><br><span>             &=
quot;test_argv&quot;</span><br><span>             &quot;test_tls_crypt&quot=
;</span><br><span>diff --git a/CMakePresets.json b/CMakePresets.json</span>=
<br><span>index 135b19d..b6ec201 100644</span><br><span>--- a/CMakePresets.=
json</span><br><span>+++ b/CMakePresets.json</span><br><span>@@ -122,6 +122=
,10 @@</span><br><span>             }</span><br><span>         },</span><br=
><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          &quot;name&quot;: &quot;clangtoolset&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;toolset&quot;: &quot;Cl=
angCL&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
},</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span>             &quot;name&quot;: &quot;mingw-x64&quot;,</span><br><s=
pan>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-mingw=
&quot;, &quot;x64-mingw&quot; ]</span><br><span>         },</span><br><span=
>@@ -134,6 +138,10 @@</span><br><span>             &quot;inherits&quot;: [ =
&quot;base&quot;, &quot;base-windows&quot;, &quot;x64&quot;, &quot;release&=
quot; ]</span><br><span>         },</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &q=
uot;win-amd64-clang-release&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;inherits&quot;: [ &quot;base&quot;, &quot;=
base-windows&quot;, &quot;clangtoolset&quot;, &quot;x64&quot;, &quot;releas=
e&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br=
><span>             &quot;name&quot;: &quot;win-arm64-release&quot;,</span>=
<br><span>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;base=
-windows&quot;, &quot;arm64&quot;, &quot;release&quot; ]</span><br><span>  =
       },</span><br><span>@@ -142,10 +150,18 @@</span><br><span>           =
  &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot=
;x86&quot;, &quot;release&quot; ]</span><br><span>         },</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;name&quot;: &quot;win-x86-clang-release&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ =
&quot;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &quot=
;x86&quot;, &quot;release&quot; ]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span>             &quot;name&quot;: &quot;win-amd=
64-debug&quot;,</span><br><span>             &quot;inherits&quot;: [ &quot;=
base&quot;, &quot;base-windows&quot;, &quot;x64&quot;, &quot;debug&quot; ]<=
/span><br><span>         },</span><br><span>         {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-=
amd64-clang-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windo=
ws&quot;, &quot;clangtoolset&quot;, &quot;x64&quot;, &quot;debug&quot; ]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>     =
        &quot;name&quot;: &quot;win-arm64-debug&quot;,</span><br><span>    =
         &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;=
, &quot;arm64&quot;, &quot;debug&quot; ]</span><br><span>         },</span>=
<br><span>@@ -154,6 +170,10 @@</span><br><span>             &quot;inherits&=
quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;x86&quot;, &quot=
;debug&quot; ]</span><br><span>         },</span><br><span>         {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&qu=
ot;: &quot;win-x86-clang-debug&quot;,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            &quot;inherits&quot;: [ &quot;base&quot;, &qu=
ot;base-windows&quot;, &quot;clangtoolset&quot;, &quot;x86&quot;, &quot;deb=
ug&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><b=
r><span>             &quot;name&quot;: &quot;unix-native&quot;,</span><br><=
span>             &quot;generator&quot;: &quot;Ninja Multi-Config&quot;,</s=
pan><br><span>             &quot;binaryDir&quot;: &quot;out/build/unix&quot=
;</span><br><span>@@ -174,6 +194,11 @@</span><br><span>             &quot;c=
onfiguration&quot;: &quot;Release&quot;</span><br><span>         },</span><=
br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &quot;name&quot;: &quot;win-amd64-clang-release&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configureP=
reset&quot;: &quot;win-amd64-clang-release&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;configuration&quot;: &quot;=
Release&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span>             &quot;name&quot;: &quot;win-arm64-release&quot;,</s=
pan><br><span>             &quot;configurePreset&quot;: &quot;win-arm64-rel=
ease&quot;,</span><br><span>             &quot;configuration&quot;: &quot;R=
elease&quot;</span><br><span>@@ -184,11 +209,21 @@</span><br><span>        =
     &quot;configuration&quot;: &quot;Release&quot;</span><br><span>       =
  },</span><br><span>         {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-release&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;=
configurePreset&quot;: &quot;win-x86-clang-release&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;configuration&quot;=
: &quot;Release&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span>             &quot;name&quot;: &quot;win-amd64-debug&quo=
t;,</span><br><span>             &quot;configurePreset&quot;: &quot;win-amd=
64-debug&quot;,</span><br><span>             &quot;configuration&quot;: &qu=
ot;Debug&quot;</span><br><span>         },</span><br><span>         {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&qu=
ot;: &quot;win-amd64-clang-debug&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;configurePreset&quot;: &quot;win-amd6=
4-clang-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;configuration&quot;: &quot;Debug&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;n=
ame&quot;: &quot;win-arm64-debug&quot;,</span><br><span>             &quot;=
configurePreset&quot;: &quot;win-arm64-debug&quot;,</span><br><span>       =
      &quot;configuration&quot;: &quot;Debug&quot;</span><br><span>@@ -199,=
6 +234,11 @@</span><br><span>             &quot;configuration&quot;: &quot;=
Debug&quot;</span><br><span>         },</span><br><span>         {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;=
: &quot;win-x86-clang-debug&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;configurePreset&quot;: &quot;win-x86-clang=
-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;configuration&quot;: &quot;Debug&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span>             &quot;name&quo=
t;: &quot;unix-native&quot;,</span><br><span>             &quot;configurePr=
eset&quot;: &quot;unix-native&quot;</span><br><span>         }</span><br><s=
pan>@@ -209,18 +249,34 @@</span><br><span>             &quot;configurePrese=
t&quot;: &quot;win-amd64-release&quot;</span><br><span>         },</span><b=
r><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;name&quot;: &quot;win-amd64-clang-release&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePr=
eset&quot;: &quot;win-amd64-clang-release&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span>             &quot;name&quot;:=
 &quot;win-x86-release&quot;,</span><br><span>             &quot;configureP=
reset&quot;: &quot;win-x86-release&quot;</span><br><span>         },</span>=
<br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            &quot;name&quot;: &quot;win-x86-clang-release&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePr=
eset&quot;: &quot;win-x86-clang-release&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span>             &quot;name&quot;: &=
quot;win-amd64-debug&quot;,</span><br><span>             &quot;configurePre=
set&quot;: &quot;win-amd64-debug&quot;</span><br><span>         },</span><b=
r><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;name&quot;: &quot;win-amd64-clang-debug&quot;,</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePres=
et&quot;: &quot;win-amd64-clang-debug&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span>             &quot;name&quot;: &qu=
ot;win-x86-debug&quot;,</span><br><span>             &quot;configurePreset&=
quot;: &quot;win-x86-debug&quot;</span><br><span>         },</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;name&quot;: &quot;win-x86-clang-debug&quot;,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePreset&quot;=
: &quot;win-x86-clang-debug&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span>             &quot;name&quot;: &quot;unix-na=
tive&quot;,</span><br><span>             &quot;configurePreset&quot;: &quot=
;unix-native&quot;</span><br><span>         }</span><br><span>diff --git a/=
config.h.cmake.in b/config.h.cmake.in</span><br><span>index 18af5e9..724da2=
e 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/conf=
ig.h.cmake.in</span><br><span>@@ -442,8 +442,10 @@</span><br><span> # defin=
e _GNU_SOURCE 1</span><br><span> #endif</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(_WIN32)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/* if inttypes.h is included this breaks rc.exe when using t=
he ClangCL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Toolch=
ain as it pulls in a inttypes.h variant for clang that rc.exe does</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * not understand (#include_=
next preprocessor directive) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#if defined(_WIN32) &amp;&amp; !defined(RC_INVOKED)</span><br><=
span> #include &lt;inttypes.h&gt;</span><br><span> typedef uint32_t in_addr=
_t;</span><br><span> typedef uint16_t in_port_t;</span><br><span>@@ -455,7 =
+457,7 @@</span><br><span> #define SIGTERM   15</span><br><span> #endif</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if def=
ined(_MSC_VER)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if d=
efined(_MSC_VER) &amp;&amp; !defined(RC_INVOKED)</span><br><span> #include =
&lt;BaseTsd.h&gt;</span><br><span> typedef SSIZE_T ssize_t;</span><br><span=
> #define strncasecmp strnicmp</span><br><span>diff --git a/src/openvpnmsic=
a/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</span><br><span>index 5f=
fb5b3..4517f51 100644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.c=
</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.c</span><br><span>@@ -=
300,7 +300,7 @@</span><br><span> UINT __stdcall</span><br><span> FindSystem=
Info(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defined(__clang__)=
</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #=
endif</span><br><span> </span><br><span>@@ -337,7 +337,7 @@</span><br><span=
> UINT __stdcall</span><br><span> CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(_MSC_VER) &amp;&amp; !defined(__clang__)</span><br><span> #pragma comm=
ent(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><span>     UNR=
EFERENCED_PARAMETER(hInstall); /* This CA is does not interact with MSI ses=
sion (report errors, access properties, tables, etc.). */</span><br><span>@=
@ -360,7 +360,7 @@</span><br><span> UINT __stdcall</span><br><span> StartOp=
enVPNGUI(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defined(__cla=
ng__)</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><sp=
an> #endif</span><br><span> </span><br><span>@@ -633,7 +633,7 @@</span><br>=
<span> UINT __stdcall</span><br><span> EvaluateTUNTAPAdapters(_In_ MSIHANDL=
E hInstall)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(_MSC_VER) &amp;&amp; !defined(__clang__)</span><br><span> =
#pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><s=
pan> </span><br><span>@@ -786,7 +786,7 @@</span><br><span>                 =
{</span><br><span>                     goto cleanup_szDisplayName;</span><b=
r><span>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef __GNUC__</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(__GNUC__) || defined(__clang__)</span><br><span> /*</span><br>=
<span>  * warning: enumeration value =E2=80=98MSICONDITION_TRUE=E2=80=99 no=
t handled in switch</span><br><span>  * warning: enumeration value =E2=80=
=98MSICONDITION_NONE=E2=80=99 not handled in switch</span><br><span>@@ -806=
,7 +806,7 @@</span><br><span>                         free(szValue);</span>=
<br><span>                         goto cleanup_szDisplayName;</span><br><s=
pan>                 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#ifdef __GNUC__</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagn=
ostic pop</span><br><span> #endif</span><br><span>                 free(szV=
alue);</span><br><span>@@ -962,7 +962,7 @@</span><br><span> UINT __stdcall<=
/span><br><span> ProcessDeferredAction(_In_ MSIHANDLE hInstall)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VE=
R</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_MSC_V=
ER) &amp;&amp; !defined(__clang__)</span><br><span> #pragma comment(linker,=
 DLLEXP_EXPORT)</span><br><span> #endif</span><br><span> </span><br><span>@=
@ -1162,7 +1162,7 @@</span><br><span> UINT __stdcall</span><br><span> Check=
AndScheduleReboot(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defin=
ed(__clang__)</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span=
><br><span> #endif</span><br><span> </span><br><span>diff --git a/src/openv=
pnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h</span><br><span>in=
dex 6640d7e..88780e8 100644</span><br><span>--- a/src/openvpnmsica/openvpnm=
sica.h</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.h</span><br><spa=
n>@@ -66,7 +66,9 @@</span><br><span> extern &quot;C&quot; {</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef __GNUC__</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* Ensure that clang-cl, which does not understand the #pragma comment(lin=
ker, ...)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is hand=
led the same way as mingw */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span> #defi=
ne DLLEXP_DECL __declspec(dllexport)</span><br><span> #else</span><br><span=
> #define DLLEXP_DECL</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">change 751<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--t+cidfbb5hg=--

