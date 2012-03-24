From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 24 Mar 2012 22:31:10 +0200
Message-Id: <1332621070-28464-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
References: <CAOazyz15xpgFxzqQFaotZSmS2=-gSmUsMMwy=SZay6bi3EEMAg@...278...>
Subject: [Openvpn-devel] [PATCH] cleanup: windows: convert argv (UCS-2 to
	UTF-8) at earliest
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Discussed at [1].

Use wmain under windows, drop the custom parsing and shell32 linkage.

There is no need for gc magic as this allocation is static.

[1] http://permalink.gmane.org/gmane.network.openvpn.devel/5433

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/Makefile.am     |    6 +++++-
 src/openvpn/openvpn.c       |   37 ++++++++++++++++++++++++++++++++++++-
 src/openvpn/openvpn.vcxproj |   10 ++++++----
 src/openvpn/options.c       |   27 ---------------------------
 4 files changed, 47 insertions(+), 33 deletions(-)
 mode change 100644 => 100755 src/openvpn/openvpn.vcxproj

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 4e485e7..0506b11 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -27,6 +27,10 @@ AM_CFLAGS = \
 	$(OPTIONAL_CRYPTO_CFLAGS) \
 	$(OPTIONAL_LZO_CFLAGS) \
 	$(OPTIONAL_PKCS11_HELPER_CFLAGS)
+if WIN32
+# we want unicode entry point but not the macro
+AM_CFLAGS += -municode -UUNICODE
+endif
 
 sbin_PROGRAMS = openvpn
 
@@ -118,5 +122,5 @@ openvpn_LDADD = \
 	$(OPTIONAL_DL_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lshell32
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm
 endif
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 3db1b86..6e70a58 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -127,8 +127,9 @@ tunnel_point_to_point (struct context *c)
  * @param argc - Commandline argument count.
  * @param argv - Commandline argument values.
  */
+static
 int
-main (int argc, char *argv[])
+openvpn_main (int argc, char *argv[])
 {
   struct context c;
 
@@ -289,3 +290,37 @@ main (int argc, char *argv[])
   openvpn_exit (OPENVPN_EXIT_STATUS_GOOD);  /* exit point */
   return 0;			            /* NOTREACHED */
 }
+
+#ifdef WIN32
+int
+wmain (int argc, wchar_t *wargv[]) {
+  char **argv;
+  int ret;
+  int i;
+
+  if ((argv = calloc(argc+1, sizeof(char*))) == NULL)
+    return 1;
+
+  for (i = 0; i < argc; i++)
+    {
+      int n = WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, NULL, 0, NULL, NULL);
+      argv[i] = malloc (n);
+      WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, argv[i], n, NULL, NULL);
+    }
+
+  ret = openvpn_main(argc, argv);
+
+  for (i=0; i < argc; i++ )
+    {
+      free (argv[i]);
+    }
+  free(argv);
+
+  return ret;
+}
+#else
+int
+main (int argc, char *argv[]) {
+	return openvpn_main(argc, argv);
+}
+#endif
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
old mode 100644
new mode 100755
index 51e19af..452876f
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -18,12 +18,12 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.Default.props" />
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
     <WholeProgramOptimization>true</WholeProgramOptimization>
+    <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>MultiByte</CharacterSet>
+    <CharacterSet>Unicode</CharacterSet>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
   <ImportGroup Label="ExtensionSettings">
@@ -56,12 +56,13 @@
       </PrecompiledHeader>
       <WarningLevel>Level3</WarningLevel>
       <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
+      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
     </ClCompile>
     <ResourceCompile>
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
@@ -80,12 +81,13 @@
       </PrecompiledHeader>
       <WarningLevel>Level3</WarningLevel>
       <DebugInformationFormat>ProgramDatabase</DebugInformationFormat>
+      <UndefinePreprocessorDefinitions>UNICODE</UndefinePreprocessorDefinitions>
     </ClCompile>
     <ResourceCompile>
       <AdditionalIncludeDirectories>$(SOURCEBASE);%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
     </ResourceCompile>
     <Link>
-      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;shell32.lib;%(AdditionalDependencies)</AdditionalDependencies>
+      <AdditionalDependencies>libeay32.lib;ssleay32.lib;lzo2.lib;pkcs11-helper.dll.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <GenerateDebugInformation>true</GenerateDebugInformation>
       <SubSystem>Console</SubSystem>
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 25786f6..66241b4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3832,33 +3832,6 @@ parse_argv (struct options *options,
 {
   int i, j;
 
-#ifdef WIN32
-  /*
-   * Windows replaces Unicode characters in argv[] that are not present
-   * in the current codepage with '?'. Get the wide char command line and
-   * convert it to UTF-8 ourselves.
-   */
-  int wargc;
-  WCHAR **wargv;
-  char **uargv;
-
-  wargv = CommandLineToArgvW (GetCommandLineW (), &wargc);
-  if (wargv == NULL || wargc != argc)
-    usage ();
-
-  uargv = gc_malloc (wargc * sizeof (*uargv), false, &options->gc);
-
-  for (i = 0; i < wargc; i++)
-    {
-      int n = WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, NULL, 0, NULL, NULL);
-      uargv[i] = gc_malloc (n, false, &options->gc);
-      WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, uargv[i], n, NULL, NULL);
-    }
-
-  LocalFree (wargv);
-  argv = uargv;
-#endif
-
   /* usage message */
   if (argc <= 1)
     usage ();
-- 
1.7.3.4


