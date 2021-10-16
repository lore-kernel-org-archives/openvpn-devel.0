From: Ilya Shipitsin <chipitsine@...277...>
Date: Sat, 16 Oct 2021 19:15:19 +0500
Message-Id: <20211016141519.1928-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] BUILD: MSVC: enable the Control-flow
 Enforcement Technology (CET) Shadow Stack mitigation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

found by BinSkim, more details:
https://docs.microsoft.com/en-us/cpp/build/reference/cetcompat?view=msvc-160

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 src/compat/Debug.props                      | 10 ++++++++++
 src/compat/Release.props                    | 10 ++++++++++
 src/openvpn/openvpn.vcxproj                 |  4 ++++
 src/openvpnmsica/openvpnmsica-Debug.props   | 10 ++++++++++
 src/openvpnmsica/openvpnmsica-Release.props | 10 ++++++++++
 src/openvpnserv/openvpnserv.vcxproj         |  4 ++++
 6 files changed, 48 insertions(+)

diff --git a/src/compat/Debug.props b/src/compat/Debug.props
index 31bb9d91..14d7a1f7 100644
--- a/src/compat/Debug.props
+++ b/src/compat/Debug.props
@@ -17,5 +17,15 @@
       <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup />
 </Project>
\ No newline at end of file
diff --git a/src/compat/Release.props b/src/compat/Release.props
index 50eaa8de..df04ddf2 100644
--- a/src/compat/Release.props
+++ b/src/compat/Release.props
@@ -22,5 +22,15 @@
       <OptimizeReferences>true</OptimizeReferences>
     </Link>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup />
 </Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 65ee6839..38dd22de 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -158,6 +158,7 @@
       <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
@@ -173,6 +174,7 @@
       <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
@@ -204,6 +206,7 @@
       <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
@@ -220,6 +223,7 @@
       <AdditionalDependencies>Ncrypt.lib;gdi32.lib;ws2_32.lib;wininet.lib;crypt32.lib;iphlpapi.lib;winmm.lib;Fwpuclnt.lib;Rpcrt4.lib;setupapi.lib;Advapi32.lib</AdditionalDependencies>
       <AdditionalLibraryDirectories>$(OPENSSL_HOME)/lib;$(LZO_HOME)/lib;$(PKCS11H_HOME)/lib;%(AdditionalLibraryDirectories)</AdditionalLibraryDirectories>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
diff --git a/src/openvpnmsica/openvpnmsica-Debug.props b/src/openvpnmsica/openvpnmsica-Debug.props
index 43532cfe..c99346af 100644
--- a/src/openvpnmsica/openvpnmsica-Debug.props
+++ b/src/openvpnmsica/openvpnmsica-Debug.props
@@ -10,5 +10,15 @@
       <RuntimeLibrary>MultiThreadedDebug</RuntimeLibrary>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup />
 </Project>
\ No newline at end of file
diff --git a/src/openvpnmsica/openvpnmsica-Release.props b/src/openvpnmsica/openvpnmsica-Release.props
index 47727b35..70f82713 100644
--- a/src/openvpnmsica/openvpnmsica-Release.props
+++ b/src/openvpnmsica/openvpnmsica-Release.props
@@ -11,5 +11,15 @@
       <ControlFlowGuard>Guard</ControlFlowGuard>
     </ClCompile>
   </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
+  <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
+    <Link>
+      <CETCompat>true</CETCompat>
+    </Link>
+  </ItemDefinitionGroup>
   <ItemGroup />
 </Project>
\ No newline at end of file
diff --git a/src/openvpnserv/openvpnserv.vcxproj b/src/openvpnserv/openvpnserv.vcxproj
index 5fd7d60b..65d03e3b 100644
--- a/src/openvpnserv/openvpnserv.vcxproj
+++ b/src/openvpnserv/openvpnserv.vcxproj
@@ -130,6 +130,7 @@
     <Link>
       <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'">
@@ -141,6 +142,7 @@
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Debug|ARM64'">
@@ -163,6 +165,7 @@
     <Link>
       <AdditionalDependencies>Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'">
@@ -174,6 +177,7 @@
     <Link>
       <AdditionalDependencies>legacy_stdio_definitions.lib;Userenv.lib;Iphlpapi.lib;ntdll.lib;Fwpuclnt.lib;Netapi32.lib;Shlwapi.lib;%(AdditionalDependencies)</AdditionalDependencies>
       <SubSystem>Console</SubSystem>
+      <CETCompat>true</CETCompat>
     </Link>
   </ItemDefinitionGroup>
   <ItemDefinitionGroup Condition="'$(Configuration)|$(Platform)'=='Release|ARM64'">
-- 
2.29.2.windows.2


