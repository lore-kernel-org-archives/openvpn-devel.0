From: Lev Stipakov <lstipakov@...277...>
Date: Mon, 11 Nov 2019 13:50:25 +0200
Message-Id: <20191111115025.1121-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] msvc: fix various level2 warnings
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

This also sets warnings level to level2, which
makes them manageable.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/compat/Debug.props       |  1 -
 src/openvpn/block_dns.c      |  3 ---
 src/openvpn/buffer.c         |  2 +-
 src/openvpn/crypto_openssl.c |  2 +-
 src/openvpn/init.c           |  2 +-
 src/openvpn/mtu.c            |  4 ++--
 src/openvpn/openvpn.vcxproj  | 20 ++++++++++----------
 src/openvpn/options.c        |  2 +-
 src/openvpn/route.c          |  2 +-
 src/openvpn/ssl_backend.h    |  2 +-
 src/openvpn/tun.c            |  4 ++--
 11 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/src/compat/Debug.props b/src/compat/Debug.props
index e5e9f681..31bb9d91 100644
--- a/src/compat/Debug.props
+++ b/src/compat/Debug.props
@@ -15,7 +15,6 @@
       <PreprocessorDefinitions>_DEBUG;%(PreprocessorDefinitions)</PreprocessorDefinitions>
       <RuntimeLibrary>MultiThreadedDebugDLL</RuntimeLibrary>
       <DebugInformationFormat>EditAndContinue</DebugInformationFormat>
-      <MinimalRebuild>true</MinimalRebuild>
     </ClCompile>
   </ItemDefinitionGroup>
   <ItemGroup />
diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index 889d6bb9..f4718fc2 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -109,9 +109,6 @@ DEFINE_GUID(
 
 static WCHAR *FIREWALL_NAME = L"OpenVPN";
 
-VOID NETIOAPI_API_
-InitializeIpInterfaceEntry(PMIB_IPINTERFACE_ROW Row);
-
 /*
  * Default msg handler does nothing
  */
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8575e295..b32bc8b2 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -474,7 +474,7 @@ x_gc_freespecial(struct gc_arena *a)
 }
 
 void
-gc_addspecial(void *addr, void (free_function)(void *), struct gc_arena *a)
+gc_addspecial(void *addr, void (*free_function)(void *), struct gc_arena *a)
 {
     ASSERT(a);
     struct gc_entry_special *e;
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 520e40ee..1057fd1d 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -313,7 +313,7 @@ show_available_ciphers(void)
         }
     }
 
-    qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
+    qsort((void *)cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
 
     for (i = 0; i < num_ciphers; i++)
     {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0bdb0a9c..2120acaa 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1778,7 +1778,7 @@ do_open_tun(struct context *c)
 #ifdef _WIN32
     /* store (hide) interactive service handle in tuntap_options */
     c->c1.tuntap->options.msg_channel = c->options.msg_channel;
-    msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
+    msg(D_ROUTE, "interactive service msg_channel=%llu", (unsigned long long) c->options.msg_channel);
 #endif
 
     /* allocate route list structure */
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 04868cd6..8178ff06 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -175,7 +175,7 @@ set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af)
 #if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER)
             case AF_INET:
                 if (setsockopt
-                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
+                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, (const char *)&mtu_type, sizeof(mtu_type)))
                 {
                     msg(M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
                         mtu_type);
@@ -186,7 +186,7 @@ set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af)
 #if defined(HAVE_SETSOCKOPT) && defined(IPV6_MTU_DISCOVER)
             case AF_INET6:
                 if (setsockopt
-                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
+                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, (const char *)&mtu_type, sizeof(mtu_type)))
                 {
                     msg(M_ERR, "Error setting IPV6_MTU_DISCOVER type=%d on TCP6/UDP6 socket",
                         mtu_type);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 7446d97d..ca13fbcb 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -28,23 +28,19 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
+    <WholeProgramOptimization>true</WholeProgramOptimization>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
@@ -74,7 +70,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -87,7 +84,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -100,7 +98,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -113,7 +112,8 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -303,4 +303,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c282b582..ea5e3279 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7172,7 +7172,7 @@ add_option(struct options *options,
 #ifdef _WIN32
         VERIFY_PERMISSION(OPT_P_GENERAL);
         HANDLE process = GetCurrentProcess();
-        HANDLE handle = (HANDLE) atoi(p[1]);
+        HANDLE handle = (HANDLE) atoll(p[1]);
         if (!DuplicateHandle(process, handle, process, &options->msg_channel, 0,
                              FALSE, DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
         {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 97e90e56..2e2216c5 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2825,7 +2825,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         DestinationAddress.Ipv6.sin6_addr = *dest;
     }
 
-    status = GetBestInterfaceEx( &DestinationAddress, &BestIfIndex );
+    status = GetBestInterfaceEx((struct sockaddr *)&DestinationAddress, &BestIfIndex );
 
     if (status != NO_ERROR)
     {
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index 1c244ece..a241a32e 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -529,7 +529,7 @@ void print_details(struct key_state_ssl *ks_ssl, const char *prefix);
 void
 show_available_tls_ciphers_list(const char *cipher_list,
                                 const char *tls_cert_profile,
-                                bool tls13);
+                                const bool tls13);
 
 /*
  * Show the available elliptic curves in the crypto library
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 37bf065b..ebfeee4e 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -4613,7 +4613,7 @@ static DWORD
 get_adapter_index_method_1(const char *guid)
 {
     DWORD index;
-    ULONG aindex;
+    ULONG aindex = 0;
     wchar_t wbuf[256];
     openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%S", guid);
     if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
@@ -5868,7 +5868,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     /* get driver MTU */
     if (!tt->wintun)
     {
-        ULONG mtu;
+        ULONG mtu = 0;
         if (DeviceIoControl(tt->hand, TAP_WIN_IOCTL_GET_MTU,
                             &mtu, sizeof(mtu),
                             &mtu, sizeof(mtu), &len, NULL))
-- 
2.17.1


