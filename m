From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 27 Dec 2024 11:39:22 +0000
In-Reply-To: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
References: <gerrit.1726585476000.I43d84034f3e920a45731c4aab4f851a60921290d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <820e9273bf6422670c11884b462723a090005b0e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="khj5adgcQCg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--khj5adgcQCg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/751?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20241227112209.11572-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
231.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M CMakePresets.json
M config.h.cmake.in
M src/openvpnmsica/openvpnmsica.c
M src/openvpnmsica/openvpnmsica.h
M tests/unit_tests/openvpn/test_buffer.c
7 files changed, 81 insertions(+), 17 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/7

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
index d43d5c1..3a1007a 100644
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
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--khj5adgcQCg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
751?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Add building/testing with msbuild and the clang comp=
iler<br><br>The LLVM/clang compiler warning and error message are easier to=
o read<br>than their MSVC cl counterparts. Also compiling/running tests on =
Windows<br>with a different compiler has the benefit of a better coverage.<=
br><br>This includes a few minor changes to allow clang-cl to compile the<b=
r>project.<br><br>Change-Id: I43d84034f3e920a45731c4aab4f851a60921290d<br>S=
igned-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Lev Stipako=
v &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20241227112209.11572-1-ger=
t@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1096...=
ourceforge.net/msg30231.html<br>Signed-off-by: Gert Doering &lt;gert@...1826...=
6...&gt;<br>---<br>M .github/workflows/build.yaml<br>M CMakeLists.txt<br>M =
CMakePresets.json<br>M config.h.cmake.in<br>M src/openvpnmsica/openvpnmsica=
.c<br>M src/openvpnmsica/openvpnmsica.h<br>M tests/unit_tests/openvpn/test_=
buffer.c<br>7 files changed, 81 insertions(+), 17 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/51/751/7</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</=
span><br><span>index 3958ef0..767de0b 100644</span><br><span>--- a/.github/=
workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</sp=
an><br><span>@@ -259,7 +259,7 @@</span><br><span>       strategy:</span><br=
><span>         fail-fast: false</span><br><span>         matrix:</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-          arch: [amd64, x86, ar=
m64]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          arch:=
 [amd64, x86, arm64, amd64-clang, x86-clang]</span><br><span> </span><br><s=
pan>       name: &quot;msbuild - ${{ matrix.arch }} - openssl&quot;</span><=
br><span>       env:</span><br><span>diff --git a/CMakeLists.txt b/CMakeLis=
ts.txt</span><br><span>index 61f0cc5..5b5b7ff 100644</span><br><span>--- a/=
CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -627=
,7 +627,8 @@</span><br><span>         check_linker_flag(C -Wl,--wrap=3Dpars=
e_line LD_SUPPORTS_WRAP)</span><br><span>     endif()</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (${LD_SUPPORTS_WRA=
P})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # Clang-cl (=
which is also MSVC) is wrongly detected to support wrap</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (NOT MSVC AND &quot;${LD_SUPPORT=
S_WRAP}&quot;)</span><br><span>         list(APPEND unit_tests</span><br><s=
pan>             &quot;test_argv&quot;</span><br><span>             &quot;t=
est_tls_crypt&quot;</span><br><span>diff --git a/CMakePresets.json b/CMakeP=
resets.json</span><br><span>index 135b19d..b6ec201 100644</span><br><span>-=
-- a/CMakePresets.json</span><br><span>+++ b/CMakePresets.json</span><br><s=
pan>@@ -122,6 +122,10 @@</span><br><span>             }</span><br><span>   =
      },</span><br><span>         {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;name&quot;: &quot;clangtoolset&quot;,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;tools=
et&quot;: &quot;ClangCL&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span>             &quot;name&quot;: &quot;mingw-x64&q=
uot;,</span><br><span>             &quot;inherits&quot;: [ &quot;base&quot;=
, &quot;base-mingw&quot;, &quot;x64-mingw&quot; ]</span><br><span>         =
},</span><br><span>@@ -134,6 +138,10 @@</span><br><span>             &quot;=
inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;x64&quo=
t;, &quot;release&quot; ]</span><br><span>         },</span><br><span>     =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &q=
uot;name&quot;: &quot;win-amd64-clang-release&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ &quot=
;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &quot;x64&=
quot;, &quot;release&quot; ]</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span>             &quot;name&quot;: &quot;win-arm64-re=
lease&quot;,</span><br><span>             &quot;inherits&quot;: [ &quot;bas=
e&quot;, &quot;base-windows&quot;, &quot;arm64&quot;, &quot;release&quot; ]=
</span><br><span>         },</span><br><span>@@ -142,10 +150,18 @@</span><b=
r><span>             &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-w=
indows&quot;, &quot;x86&quot;, &quot;release&quot; ]</span><br><span>      =
   },</span><br><span>         {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-release&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;clangt=
oolset&quot;, &quot;x86&quot;, &quot;release&quot; ]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;name&=
quot;: &quot;win-amd64-debug&quot;,</span><br><span>             &quot;inhe=
rits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &quot;x64&quot;, =
&quot;debug&quot; ]</span><br><span>         },</span><br><span>         {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;na=
me&quot;: &quot;win-amd64-clang-debug&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ &quot;base&quo=
t;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &quot;x64&quot;, &q=
uot;debug&quot; ]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      },</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span>             &quot;name&quot;: &quot;win-arm64-debug&quot;,<=
/span><br><span>             &quot;inherits&quot;: [ &quot;base&quot;, &quo=
t;base-windows&quot;, &quot;arm64&quot;, &quot;debug&quot; ]</span><br><spa=
n>         },</span><br><span>@@ -154,6 +170,10 @@</span><br><span>        =
     &quot;inherits&quot;: [ &quot;base&quot;, &quot;base-windows&quot;, &q=
uot;x86&quot;, &quot;debug&quot; ]</span><br><span>         },</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       &quot;name&quot;: &quot;win-x86-clang-debug&quot;,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            &quot;inherits&quot;: [ &=
quot;base&quot;, &quot;base-windows&quot;, &quot;clangtoolset&quot;, &quot;=
x86&quot;, &quot;debug&quot; ]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        {</span><br><span>             &quot;name&quot;: &quot;unix-nativ=
e&quot;,</span><br><span>             &quot;generator&quot;: &quot;Ninja Mu=
lti-Config&quot;,</span><br><span>             &quot;binaryDir&quot;: &quot=
;out/build/unix&quot;</span><br><span>@@ -174,6 +194,11 @@</span><br><span>=
             &quot;configuration&quot;: &quot;Release&quot;</span><br><span=
>         },</span><br><span>         {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang-rel=
ease&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    &quot;configurePreset&quot;: &quot;win-amd64-clang-release&quot;,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot;configu=
ration&quot;: &quot;Release&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        },</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        {</span><br><span>             &quot;name&quot;: &quot;win-arm=
64-release&quot;,</span><br><span>             &quot;configurePreset&quot;:=
 &quot;win-arm64-release&quot;,</span><br><span>             &quot;configur=
ation&quot;: &quot;Release&quot;</span><br><span>@@ -184,11 +209,21 @@</spa=
n><br><span>             &quot;configuration&quot;: &quot;Release&quot;</sp=
an><br><span>         },</span><br><span>         {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x=
86-clang-release&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            &quot;configurePreset&quot;: &quot;win-x86-clang-release&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &qu=
ot;configuration&quot;: &quot;Release&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        },</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span>             &quot;name&quot;: &qu=
ot;win-amd64-debug&quot;,</span><br><span>             &quot;configurePrese=
t&quot;: &quot;win-amd64-debug&quot;,</span><br><span>             &quot;co=
nfiguration&quot;: &quot;Debug&quot;</span><br><span>         },</span><br>=
<span>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         &quot;name&quot;: &quot;win-amd64-clang-debug&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePreset=
&quot;: &quot;win-amd64-clang-debug&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;configuration&quot;: &quot;Debug&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n>             &quot;name&quot;: &quot;win-arm64-debug&quot;,</span><br><sp=
an>             &quot;configurePreset&quot;: &quot;win-arm64-debug&quot;,</=
span><br><span>             &quot;configuration&quot;: &quot;Debug&quot;</s=
pan><br><span>@@ -199,6 +234,11 @@</span><br><span>             &quot;confi=
guration&quot;: &quot;Debug&quot;</span><br><span>         },</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      &quot;name&quot;: &quot;win-x86-clang-debug&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            &quot;configurePreset&quot=
;: &quot;win-x86-clang-debug&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;configuration&quot;: &quot;Debug&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>     =
        &quot;name&quot;: &quot;unix-native&quot;,</span><br><span>        =
     &quot;configurePreset&quot;: &quot;unix-native&quot;</span><br><span> =
        }</span><br><span>@@ -209,18 +249,34 @@</span><br><span>           =
  &quot;configurePreset&quot;: &quot;win-amd64-release&quot;</span><br><spa=
n>         },</span><br><span>         {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang-re=
lease&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;configurePreset&quot;: &quot;win-amd64-clang-release&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>        =
     &quot;name&quot;: &quot;win-x86-release&quot;,</span><br><span>       =
      &quot;configurePreset&quot;: &quot;win-x86-release&quot;</span><br><s=
pan>         },</span><br><span>         {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-re=
lease&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     &quot;configurePreset&quot;: &quot;win-x86-clang-release&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>          =
   &quot;name&quot;: &quot;win-amd64-debug&quot;,</span><br><span>         =
    &quot;configurePreset&quot;: &quot;win-amd64-debug&quot;</span><br><spa=
n>         },</span><br><span>         {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            &quot;name&quot;: &quot;win-amd64-clang-de=
bug&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   &quot;configurePreset&quot;: &quot;win-amd64-clang-debug&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span>            =
 &quot;name&quot;: &quot;win-x86-debug&quot;,</span><br><span>             =
&quot;configurePreset&quot;: &quot;win-x86-debug&quot;</span><br><span>    =
     },</span><br><span>         {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            &quot;name&quot;: &quot;win-x86-clang-debug&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &quot=
;configurePreset&quot;: &quot;win-x86-clang-debug&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        },</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span>             &quot;nam=
e&quot;: &quot;unix-native&quot;,</span><br><span>             &quot;config=
urePreset&quot;: &quot;unix-native&quot;</span><br><span>         }</span><=
br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><span=
>index 3c517d7..74a53a6 100644</span><br><span>--- a/config.h.cmake.in</spa=
n><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -439,8 +439,10 @@</s=
pan><br><span> # define _GNU_SOURCE 1</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* if inttypes.h is included this brea=
ks rc.exe when using the ClangCL</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * Toolchain as it pulls in a inttypes.h variant for clang tha=
t rc.exe does</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * not=
 understand (#include_next preprocessor directive) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) &amp;&amp; !defined(R=
C_INVOKED)</span><br><span> #include &lt;inttypes.h&gt;</span><br><span> ty=
pedef uint32_t in_addr_t;</span><br><span> typedef uint16_t in_port_t;</spa=
n><br><span>@@ -452,7 +454,7 @@</span><br><span> #define SIGTERM   15</span=
><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(_MSC_VER)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defined(RC_INVOKED)</spa=
n><br><span> #include &lt;BaseTsd.h&gt;</span><br><span> typedef SSIZE_T ss=
ize_t;</span><br><span> #define strncasecmp strnicmp</span><br><span>diff -=
-git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c</s=
pan><br><span>index 154fff4..17152e0 100644</span><br><span>--- a/src/openv=
pnmsica/openvpnmsica.c</span><br><span>+++ b/src/openvpnmsica/openvpnmsica.=
c</span><br><span>@@ -303,7 +303,7 @@</span><br><span> UINT __stdcall</span=
><br><span> FindSystemInfo(_In_ MSIHANDLE hInstall)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span><br=
><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif</spa=
n><br><span> </span><br><span>@@ -340,7 +340,7 @@</span><br><span> UINT __s=
tdcall</span><br><span> CloseOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_V=
ER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXP=
ORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span=
> #endif</span><br><span>     UNREFERENCED_PARAMETER(hInstall); /* This CA =
is does not interact with MSI session (report errors, access properties, ta=
bles, etc.). */</span><br><span>@@ -363,7 +363,7 @@</span><br><span> UINT _=
_stdcall</span><br><span> StartOpenVPNGUI(_In_ MSIHANDLE hInstall)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC=
_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_E=
XPORT</span><br><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><sp=
an> #endif</span><br><span> </span><br><span>@@ -636,7 +636,7 @@</span><br>=
<span> UINT __stdcall</span><br><span> EvaluateTUNTAPAdapters(_In_ MSIHANDL=
E hInstall)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma comment(linker, DLLEXP_E=
XPORT)</span><br><span> #endif</span><br><span> </span><br><span>@@ -789,7 =
+789,7 @@</span><br><span>                 {</span><br><span>              =
       goto cleanup_szDisplayName;</span><br><span>                 }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNUC__</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || define=
d(__clang__)</span><br><span> /*</span><br><span>  * warning: enumeration v=
alue =E2=80=98MSICONDITION_TRUE=E2=80=99 not handled in switch</span><br><s=
pan>  * warning: enumeration value =E2=80=98MSICONDITION_NONE=E2=80=99 not =
handled in switch</span><br><span>@@ -809,7 +809,7 @@</span><br><span>     =
                    free(szValue);</span><br><span>                        =
 goto cleanup_szDisplayName;</span><br><span>                 }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNUC__</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__) || defined(__cl=
ang__)</span><br><span> #pragma GCC diagnostic pop</span><br><span> #endif<=
/span><br><span>                 free(szValue);</span><br><span>@@ -965,7 +=
965,7 @@</span><br><span> UINT __stdcall</span><br><span> ProcessDeferredAc=
tion(_In_ MSIHANDLE hInstall)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span><br><span> #pragma commen=
t(linker, DLLEXP_EXPORT)</span><br><span> #endif</span><br><span> </span><b=
r><span>@@ -1165,7 +1165,7 @@</span><br><span> UINT __stdcall</span><br><sp=
an> CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)</span><br><span> {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef DLLEXP_EXPORT</span><br=
><span> #pragma comment(linker, DLLEXP_EXPORT)</span><br><span> #endif</spa=
n><br><span> </span><br><span>diff --git a/src/openvpnmsica/openvpnmsica.h =
b/src/openvpnmsica/openvpnmsica.h</span><br><span>index 7aacdf3..761aa47 10=
0644</span><br><span>--- a/src/openvpnmsica/openvpnmsica.h</span><br><span>=
+++ b/src/openvpnmsica/openvpnmsica.h</span><br><span>@@ -66,7 +66,11 @@</s=
pan><br><span> extern &quot;C&quot; {</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __GNUC__</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Ensure that clang-=
cl, which does not understand the cl specific</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * preprocessor defines like #pragma comment(link=
er, DLLEXP_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* is handled the same way as mingw and uses the alternative instead</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ * and does not define DLLE=
XP_EXPORT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if def=
ined(__GNUC__) || defined(__clang__)</span><br><span> #define DLLEXP_DECL _=
_declspec(dllexport)</span><br><span> #else</span><br><span> #define DLLEXP=
_DECL</span><br><span>diff --git a/tests/unit_tests/openvpn/test_buffer.c b=
/tests/unit_tests/openvpn/test_buffer.c</span><br><span>index d43d5c1..3a10=
07a 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@=
@ -389,8 +389,9 @@</span><br><span> </span><br><span>     /* Instead of try=
ing to trick the compiler here, disable the warnings</span><br><span>      =
* for this unit test. We know that the results will be truncated</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-     * and we want to test that =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC_=
_)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and we wan=
t to test that. Not we need the clang as clang-cl (msvc) does</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     * not define __GNUC__ like i=
t does under UNIX(-like) platforms */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#if defined(__GNUC__) || defined(__clang__)</span><br><sp=
an> /* some clang version do not understand -Wformat-truncation, so ignore =
the</span><br><span>  * warning to avoid warnings/errors (-Werror) about un=
known pragma/option */</span><br><span> #if defined(__clang__)</span><br><s=
pan>@@ -418,7 +419,7 @@</span><br><span>     assert_int_equal(ret, 10);</sp=
an><br><span>     assert_int_equal(buf[9], &#39;\0&#39;);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC_=
_) || defined(__clang__)</span><br><span> #pragma GCC diagnostic pop</span>=
<br><span> #if defined(__clang__)</span><br><span> #pragma clang diagnostic=
 pop</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/751?usp=3Demail">change 751</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/751?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I43d84034f3e920a45731c4aab4f=
851a60921290d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 751 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--khj5adgcQCg=--

