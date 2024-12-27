From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 01:19:34 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296..., lstipakov@...277...
Message-ID: <25416643107c1bbb90a5a5ecead4104201577ba3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KgTxTETDFKg="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>, stipa <lstipakov@...277...>

--KgTxTETDFKg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail

to look at the new patch set (#6).


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
M tests/unit_tests/openvpn/test_buffer.c
7 files changed, 81 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/6

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 3958ef0..767de0b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -259,7 +259,7 @@
       strategy:
         fail-fast: false
         matrix:
-          arch: [amd64, x86, arm64]
+          arch: [amd64, x86, arm64, amd64-clang, x86-clang]

       name: "msbuild - ${{ matrix.arch }} - openssl"
       env:
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 61f0cc5..5b5b7ff 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -627,7 +627,8 @@
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
index 3c517d7..74a53a6 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -439,8 +439,10 @@
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
@@ -452,7 +454,7 @@
 #define SIGTERM   15
 #endif

-#if defined(_MSC_VER)
+#if defined(_MSC_VER) && !defined(RC_INVOKED)
 #include <BaseTsd.h>
 typedef SSIZE_T ssize_t;
 #define strncasecmp strnicmp
diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsic=
a.c
index 154fff4..17152e0 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -303,7 +303,7 @@
 UINT __stdcall
 FindSystemInfo(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -340,7 +340,7 @@
 UINT __stdcall
 CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif
     UNREFERENCED_PARAMETER(hInstall); /* This CA is does not interact with=
 MSI session (report errors, access properties, tables, etc.). */
@@ -363,7 +363,7 @@
 UINT __stdcall
 StartOpenVPNGUI(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -636,7 +636,7 @@
 UINT __stdcall
 EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -789,7 +789,7 @@
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
@@ -809,7 +809,7 @@
                         free(szValue);
                         goto cleanup_szDisplayName;
                 }
-#ifdef __GNUC__
+#if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #endif
                 free(szValue);
@@ -965,7 +965,7 @@
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

@@ -1165,7 +1165,7 @@
 UINT __stdcall
 CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
 {
-#ifdef _MSC_VER
+#ifdef DLLEXP_EXPORT
 #pragma comment(linker, DLLEXP_EXPORT)
 #endif

diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsic=
a.h
index 7aacdf3..761aa47 100644
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
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 0fb4697..06e8b98 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -389,8 +389,9 @@

     /* Instead of trying to trick the compiler here, disable the warnings
      * for this unit test. We know that the results will be truncated
-     * and we want to test that */
-#if defined(__GNUC__)
+     * and we want to test that. Not we need the clang as clang-cl (msvc) =
does
+     * not define __GNUC__ like it does under UNIX(-like) platforms */
+#if defined(__GNUC__) || defined(__clang__)
 /* some clang version do not understand -Wformat-truncation, so ignore the
  * warning to avoid warnings/errors (-Werror) about unknown pragma/option =
*/
 #if defined(__clang__)
@@ -418,7 +419,7 @@
     assert_int_equal(ret, 10);
     assert_int_equal(buf[9], '\0');

-#if defined(__GNUC__)
+#if defined(__GNUC__) || defined(__clang__)
 #pragma GCC diagnostic pop
 #if defined(__clang__)
 #pragma clang diagnostic pop

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d
Gerrit-Change-Number: 751
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--KgTxTETDFKg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
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
openvpnmsica/openvpnmsica.c<br>M src/openvpnmsica/openvpnmsica.h<br>M tests=
/unit_tests/openvpn/test_buffer.c<br>7 files changed, 81 insertions(+), 17 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/51/751/6</pre><pre style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.gith=
ub/workflows/build.yaml</span><br><span>index 3958ef0..767de0b 100644</span=
><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github=
/workflows/build.yaml</span><br><span>@@ -259,7 +259,7 @@</span><br><span> =
      strategy:</span><br><span>         fail-fast: false</span><br><span> =
        matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
    arch: [amd64, x86, arm64]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          arch: [amd64, x86, arm64, amd64-clang, x86-clang]</span=
><br><span> </span><br><span>       name: &quot;msbuild - ${{ matrix.arch }=
} - openssl&quot;</span><br><span>       env:</span><br><span>diff --git a/=
CMakeLists.txt b/CMakeLists.txt</span><br><span>index 61f0cc5..5b5b7ff 1006=
44</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.tx=
t</span><br><span>@@ -627,7 +627,8 @@</span><br><span>         check_linker=
_flag(C -Wl,--wrap=3Dparse_line LD_SUPPORTS_WRAP)</span><br><span>     endi=
f()</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (${LD_SUPPORTS_WRAP})</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    # Clang-cl (which is also MSVC) is wrongly detected to support=
 wrap</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (NOT MS=
VC AND &quot;${LD_SUPPORTS_WRAP}&quot;)</span><br><span>         list(APPEN=
D unit_tests</span><br><span>             &quot;test_argv&quot;</span><br><=
span>             &quot;test_tls_crypt&quot;</span><br><span>diff --git a/C=
MakePresets.json b/CMakePresets.json</span><br><span>index 135b19d..b6ec201=
 100644</span><br><span>--- a/CMakePresets.json</span><br><span>+++ b/CMake=
Presets.json</span><br><span>@@ -122,6 +122,10 @@</span><br><span>         =
    }</span><br><span>         },</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quo=
t;clangtoolset&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            &quot;toolset&quot;: &quot;ClangCL&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;name=
&quot;: &quot;mingw-x64&quot;,</span><br><span>             &quot;inherits&=
quot;: [ &quot;base&quot;, &quot;base-mingw&quot;, &quot;x64-mingw&quot; ]<=
/span><br><span>         },</span><br><span>@@ -134,6 +138,10 @@</span><br>=
<span>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-win=
dows&quot;, &quot;x64&quot;, &quot;release&quot; ]</span><br><span>        =
 },</span><br><span>         {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang-release&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangt=
oolset&quot;, &quot;x64&quot;, &quot;release&quot; ]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;name&=
quot;: &quot;win-arm64-release&quot;,</span><br><span>             &quot;in=
herits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;arm64&quo=
t;, &quot;release&quot; ]</span><br><span>         },</span><br><span>@@ -1=
42,10 +150,18 @@</span><br><span>             &quot;inherits&quot;: [ &quot=
;base&quot;, &quot;base-windows&quot;, &quot;x86&quot;, &quot;release&quot;=
 ]</span><br><span>         },</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;w=
in-x86-clang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-wi=
ndows&quot;, &quot;clangtoolset&quot;, &quot;x86&quot;, &quot;release&quot;=
 ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>=
             &quot;name&quot;: &quot;win-amd64-debug&quot;,</span><br><span=
>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&=
quot;, &quot;x64&quot;, &quot;debug&quot; ]</span><br><span>         },</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;name&quot;: &quot;win-amd64-clang-debug&quot;,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits=
&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&qu=
ot;, &quot;x64&quot;, &quot;debug&quot; ]</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span>             &quot;name&quot;: &quot=
;win-arm64-debug&quot;,</span><br><span>             &quot;inherits&quot;: =
[ &quot;base&quot;, &quot;base-windows&quot;, &quot;arm64&quot;, &quot;debu=
g&quot; ]</span><br><span>         },</span><br><span>@@ -154,6 +170,10 @@<=
/span><br><span>             &quot;inherits&quot;: [ &quot;base&quot;, &quo=
t;base-windows&quot;, &quot;x86&quot;, &quot;debug&quot; ]</span><br><span>=
         },</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-debug&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &=
quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;cl=
angtoolset&quot;, &quot;x86&quot;, &quot;debug&quot; ]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;name=
&quot;: &quot;unix-native&quot;,</span><br><span>             &quot;generat=
or&quot;: &quot;Ninja Multi-Config&quot;,</span><br><span>             &quo=
t;binaryDir&quot;: &quot;out/build/unix&quot;</span><br><span>@@ -174,6 +19=
4,11 @@</span><br><span>             &quot;configuration&quot;: &quot;Relea=
se&quot;</span><br><span>         },</span><br><span>         {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &=
quot;win-amd64-clang-release&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;configurePreset&quot;: &quot;win-amd64-cl=
ang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &quot;configuration&quot;: &quot;Release&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;n=
ame&quot;: &quot;win-arm64-release&quot;,</span><br><span>             &quo=
t;configurePreset&quot;: &quot;win-arm64-release&quot;,</span><br><span>   =
          &quot;configuration&quot;: &quot;Release&quot;</span><br><span>@@=
 -184,11 +209,21 @@</span><br><span>             &quot;configuration&quot;:=
 &quot;Release&quot;</span><br><span>         },</span><br><span>         {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;n=
ame&quot;: &quot;win-x86-clang-release&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            &quot;configurePreset&quot;: &quot;wi=
n-x86-clang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            &quot;configuration&quot;: &quot;Release&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>            =
 &quot;name&quot;: &quot;win-amd64-debug&quot;,</span><br><span>           =
  &quot;configurePreset&quot;: &quot;win-amd64-debug&quot;,</span><br><span=
>             &quot;configuration&quot;: &quot;Debug&quot;</span><br><span>=
         },</span><br><span>         {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang-debu=
g&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 &quot;configurePreset&quot;: &quot;win-amd64-clang-debug&quot;,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configuratio=
n&quot;: &quot;Debug&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span>             &quot;name&quot;: &quot;win-arm64-debu=
g&quot;,</span><br><span>             &quot;configurePreset&quot;: &quot;wi=
n-arm64-debug&quot;,</span><br><span>             &quot;configuration&quot;=
: &quot;Debug&quot;</span><br><span>@@ -199,6 +234,11 @@</span><br><span>  =
           &quot;configuration&quot;: &quot;Debug&quot;</span><br><span>   =
      },</span><br><span>         {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-debug&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quo=
t;configurePreset&quot;: &quot;win-x86-clang-debug&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;configuration&quot;=
: &quot;Debug&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {=
</span><br><span>             &quot;name&quot;: &quot;unix-native&quot;,</s=
pan><br><span>             &quot;configurePreset&quot;: &quot;unix-native&q=
uot;</span><br><span>         }</span><br><span>@@ -209,18 +249,34 @@</span=
><br><span>             &quot;configurePreset&quot;: &quot;win-amd64-releas=
e&quot;</span><br><span>         },</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &q=
uot;win-amd64-clang-release&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;configurePreset&quot;: &quot;win-amd64-cla=
ng-release&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span>             &quot;name&quot;: &quot;win-x86-release&quot;,</=
span><br><span>             &quot;configurePreset&quot;: &quot;win-x86-rele=
ase&quot;</span><br><span>         },</span><br><span>         {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: =
&quot;win-x86-clang-release&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;configurePreset&quot;: &quot;win-x86-clang=
-release&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span>             &quot;name&quot;: &quot;win-amd64-debug&quot;,</sp=
an><br><span>             &quot;configurePreset&quot;: &quot;win-amd64-debu=
g&quot;</span><br><span>         },</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &q=
uot;win-amd64-clang-debug&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &quot;configurePreset&quot;: &quot;win-amd64-clang=
-debug&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span>             &quot;name&quot;: &quot;win-x86-debug&quot;,</span><=
br><span>             &quot;configurePreset&quot;: &quot;win-x86-debug&quot=
;</span><br><span>         },</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;wi=
n-x86-clang-debug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            &quot;configurePreset&quot;: &quot;win-x86-clang-debug&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>=
             &quot;name&quot;: &quot;unix-native&quot;,</span><br><span>   =
          &quot;configurePreset&quot;: &quot;unix-native&quot;</span><br><s=
pan>         }</span><br><span>diff --git a/config.h.cmake.in b/config.h.cm=
ake.in</span><br><span>index 3c517d7..74a53a6 100644</span><br><span>--- a/=
config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@=
@ -439,8 +439,10 @@</span><br><span> # define _GNU_SOURCE 1</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN=
32)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* if inttypes.h=
 is included this breaks rc.exe when using the ClangCL</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * Toolchain as it pulls in a inttypes.h=
 variant for clang that rc.exe does</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * not understand (#include_next preprocessor directive) */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)=
 &amp;&amp; !defined(RC_INVOKED)</span><br><span> #include &lt;inttypes.h&g=
t;</span><br><span> typedef uint32_t in_addr_t;</span><br><span> typedef ui=
nt16_t in_port_t;</span><br><span>@@ -452,7 +454,7 @@</span><br><span> #def=
ine SIGTERM   15</span><br><span> #endif</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(_MSC_VER)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !de=
fined(RC_INVOKED)</span><br><span> #include &lt;BaseTsd.h&gt;</span><br><sp=
an> typedef SSIZE_T ssize_t;</span><br><span> #define strncasecmp strnicmp<=
/span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnm=
sica/openvpnmsica.c</span><br><span>index 154fff4..17152e0 100644</span><br=
><span>--- a/src/openvpnmsica/openvpnmsica.c</span><br><span>+++ b/src/open=
vpnmsica/openvpnmsica.c</span><br><span>@@ -303,7 +303,7 @@</span><br><span=
> UINT __stdcall</span><br><span> FindSystemInfo(_In_ MSIHANDLE hInstall)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef D=
LLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span>=
<br><span> #endif</span><br><span> </span><br><span>@@ -340,7 +340,7 @@</sp=
an><br><span> UINT __stdcall</span><br><span> CloseOpenVPNGUI(_In_ MSIHANDL=
E hInstall)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_E=
XPORT)</span><br><span> #endif</span><br><span>     UNREFERENCED_PARAMETER(=
hInstall); /* This CA is does not interact with MSI session (report errors,=
 access properties, tables, etc.). */</span><br><span>@@ -363,7 +363,7 @@</=
span><br><span> UINT __stdcall</span><br><span> StartOpenVPNGUI(_In_ MSIHAN=
DLE hInstall)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP=
_EXPORT)</span><br><span> #endif</span><br><span> </span><br><span>@@ -636,=
7 +636,7 @@</span><br><span> UINT __stdcall</span><br><span> EvaluateTUNTAP=
Adapters(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma c=
omment(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><span> </sp=
an><br><span>@@ -789,7 +789,7 @@</span><br><span>                 {</span><=
br><span>                     goto cleanup_szDisplayName;</span><br><span> =
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifd=
ef __GNUC__</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span> /*</span><br><span>  *=
 warning: enumeration value =E2=80=98MSICONDITION_TRUE=E2=80=99 not handled=
 in switch</span><br><span>  * warning: enumeration value =E2=80=98MSICONDI=
TION_NONE=E2=80=99 not handled in switch</span><br><span>@@ -809,7 +809,7 @=
@</span><br><span>                         free(szValue);</span><br><span> =
                        goto cleanup_szDisplayName;</span><br><span>       =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __G=
NUC__</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__=
GNUC__) || defined(__clang__)</span><br><span> #pragma GCC diagnostic pop</=
span><br><span> #endif</span><br><span>                 free(szValue);</spa=
n><br><span>@@ -965,7 +965,7 @@</span><br><span> UINT __stdcall</span><br><=
span> ProcessDeferredAction(_In_ MSIHANDLE hInstall)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span><b=
r><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif</sp=
an><br><span> </span><br><span>@@ -1165,7 +1165,7 @@</span><br><span> UINT =
__stdcall</span><br><span> CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)<=
/span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
def _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span=
><br><span> #endif</span><br><span> </span><br><span>diff --git a/src/openv=
pnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h</span><br><span>in=
dex 7aacdf3..761aa47 100644</span><br><span>--- a/src/openvpnmsica/openvpnm=
sica.h</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.h</span><br><spa=
n>@@ -66,7 +66,11 @@</span><br><span> extern &quot;C&quot; {</span><br><spa=
n> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#ifdef __GNUC__</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* Ensure that clang-cl, which does not understand the cl specific</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * preprocessor defines li=
ke #pragma comment(linker, DLLEXP_EXPORT)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * is handled the same way as mingw and uses the alte=
rnative instead</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * a=
nd does not define DLLEXP_EXPORT */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><span=
> #define DLLEXP_DECL __declspec(dllexport)</span><br><span> #else</span><b=
r><span> #define DLLEXP_DECL</span><br><span>diff --git a/tests/unit_tests/=
openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</span><br><s=
pan>index 0fb4697..06e8b98 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buf=
fer.c</span><br><span>@@ -389,8 +389,9 @@</span><br><span> </span><br><span=
>     /* Instead of trying to trick the compiler here, disable the warnings=
</span><br><span>      * for this unit test. We know that the results will =
be truncated</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * an=
d we want to test that */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * and we want to test that. Not we need the clang as clang-cl (m=
svc) does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * not=
 define __GNUC__ like it does under UNIX(-like) platforms */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(_=
_clang__)</span><br><span> /* some clang version do not understand -Wformat=
-truncation, so ignore the</span><br><span>  * warning to avoid warnings/er=
rors (-Werror) about unknown pragma/option */</span><br><span> #if defined(=
__clang__)</span><br><span>@@ -418,7 +419,7 @@</span><br><span>     assert_=
int_equal(ret, 10);</span><br><span>     assert_int_equal(buf[9], &#39;\0&#=
39;);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#if defined(__GNUC__)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(__GNUC__) || defined(__clang__)</span><br><span> #pragma GC=
C diagnostic pop</span><br><span> #if defined(__clang__)</span><br><span> #=
pragma clang diagnostic pop</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail">chang=
e 751</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KgTxTETDFKg=--

