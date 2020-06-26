From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 26 Jun 2020 13:10:50 +0300
Message-Id: <20200626101050.442-1-lstipakov@...277...>
In-Reply-To: <20200626095432.GB1431@...1296...>
References: <20200626095432.GB1431@...1296...>
Subject: [Openvpn-devel] [PATCH v4] msvc: fix various level2 warnings
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

Also set warnings level to level2 and
enable "treat warnings as errors" flag.

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v4:
  - cast setsockopt() parameter to (void *) to make Windows happy
_and_ not to make code look confusing on other platforms

 v3:
  - use proper format specifier for unsigned long long
  - add comment about cast for qsort()
  - remove unused parameter in delete_route_connected_v6_net() 

 v2:
  - rebase on top of master


 src/compat/Debug.props       |  1 -
 src/openvpn/block_dns.c      |  3 ---
 src/openvpn/crypto_openssl.c |  3 ++-
 src/openvpn/init.c           |  2 +-
 src/openvpn/mtu.c            |  8 ++++----
 src/openvpn/openvpn.vcxproj  | 26 +++++++++++++++++---------
 src/openvpn/options.c        |  2 +-
 src/openvpn/route.c          |  2 +-
 src/openvpn/ssl_openssl.c    |  2 +-
 src/openvpn/tun.c            | 12 ++++++------
 10 files changed, 33 insertions(+), 28 deletions(-)

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
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 2027d8dc..521cfca1 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -315,7 +315,8 @@ show_available_ciphers(void)
         }
     }
 
-    qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
+    /* cast to non-const to prevent warning */
+    qsort((EVP_CIPHER *)cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
 
     for (i = 0; i < num_ciphers; i++)
     {
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2c8db68d..2af25c1a 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1812,7 +1812,7 @@ do_open_tun(struct context *c)
 #ifdef _WIN32
     /* store (hide) interactive service handle in tuntap_options */
     c->c1.tuntap->options.msg_channel = c->options.msg_channel;
-    msg(D_ROUTE, "interactive service msg_channel=%u", (unsigned int) c->options.msg_channel);
+    msg(D_ROUTE, "interactive service msg_channel=%" PRIu64, (unsigned long long) c->options.msg_channel);
 #endif
 
     /* allocate route list structure */
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 04868cd6..3ddeac76 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -174,8 +174,8 @@ set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af)
         {
 #if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER)
             case AF_INET:
-                if (setsockopt
-                        (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
+                if (setsockopt(sd, IPPROTO_IP, IP_MTU_DISCOVER,
+                               (void *) &mtu_type, sizeof(mtu_type)))
                 {
                     msg(M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
                         mtu_type);
@@ -185,8 +185,8 @@ set_mtu_discover_type(int sd, int mtu_type, sa_family_t proto_af)
 #endif
 #if defined(HAVE_SETSOCKOPT) && defined(IPV6_MTU_DISCOVER)
             case AF_INET6:
-                if (setsockopt
-                        (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, &mtu_type, sizeof(mtu_type)))
+                if (setsockopt(sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER,
+                               (void *) &mtu_type, sizeof(mtu_type)))
                 {
                     msg(M_ERR, "Error setting IPV6_MTU_DISCOVER type=%d on TCP6/UDP6 socket",
                         mtu_type);
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 53ac5482..c34733ea 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -28,23 +28,23 @@
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
+    <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Release|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
     <WholeProgramOptimization>true</WholeProgramOptimization>
-    <CharacterSet>Unicode</CharacterSet>
+    <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|Win32'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
+    <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <PropertyGroup Condition="'$(Configuration)|$(Platform)'=='Debug|x64'" Label="Configuration">
     <ConfigurationType>Application</ConfigurationType>
-    <CharacterSet>Unicode</CharacterSet>
+    <CharacterSet>NotSet</CharacterSet>
     <PlatformToolset>v142</PlatformToolset>
   </PropertyGroup>
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.props" />
@@ -74,7 +74,9 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
+      <TreatWarningAsError>true</TreatWarningAsError>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -87,7 +89,9 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
+      <TreatWarningAsError>true</TreatWarningAsError>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -100,7 +104,9 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
+      <TreatWarningAsError>true</TreatWarningAsError>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -113,7 +119,9 @@
     <ClCompile>
       <AdditionalIncludeDirectories>..\compat;$(TAP_WINDOWS_HOME)/include;$(OPENSSL_HOME)/include;$(LZO_HOME)/include;$(PKCS11H_HOME)/include;%(AdditionalIncludeDirectories)</AdditionalIncludeDirectories>
       <PreprocessorDefinitions>_CONSOLE;%(PreprocessorDefinitions)</PreprocessorDefinitions>
-      <UndefinePreprocessorDefinitions>UNICODE;%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <UndefinePreprocessorDefinitions>%(UndefinePreprocessorDefinitions)</UndefinePreprocessorDefinitions>
+      <WarningLevel>Level2</WarningLevel>
+      <TreatWarningAsError>true</TreatWarningAsError>
     </ClCompile>
     <ResourceCompile />
     <Link>
@@ -307,4 +315,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 16f9da6a..3484f7d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7276,7 +7276,7 @@ add_option(struct options *options,
 #ifdef _WIN32
         VERIFY_PERMISSION(OPT_P_GENERAL);
         HANDLE process = GetCurrentProcess();
-        HANDLE handle = (HANDLE) atoi(p[1]);
+        HANDLE handle = (HANDLE) atoll(p[1]);
         if (!DuplicateHandle(process, handle, process, &options->msg_channel, 0,
                              FALSE, DUPLICATE_CLOSE_SOURCE | DUPLICATE_SAME_ACCESS))
         {
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 9ff36359..b57da5dd 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2833,7 +2833,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         DestinationAddress.Ipv6.sin6_addr = *dest;
     }
 
-    status = GetBestInterfaceEx( &DestinationAddress, &BestIfIndex );
+    status = GetBestInterfaceEx( (struct sockaddr *)&DestinationAddress, &BestIfIndex );
 
     if (status != NO_ERROR)
     {
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a489053b..07d422c9 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -2115,7 +2115,7 @@ print_details(struct key_state_ssl *ks_ssl, const char *prefix)
 void
 show_available_tls_ciphers_list(const char *cipher_list,
                                 const char *tls_cert_profile,
-                                const bool tls13)
+                                bool tls13)
 {
     struct tls_root_ctx tls_ctx;
 
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0e6dfe72..18cdf38d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -233,10 +233,11 @@ do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
             sizeof(set_mtu_message_t),
             0
         },
-        .iface = {.index = tt->adapter_index,.name = tt->actual_name },
+        .iface = {.index = tt->adapter_index},
         .mtu = mtu,
         .family = family
     };
+    strncpynt(mtu_msg.iface.name, tt->actual_name, sizeof(mtu_msg.iface.name));
 
     if (!send_msg_iservice(pipe, &mtu_msg, sizeof(mtu_msg), &ack, "Set_mtu"))
     {
@@ -889,8 +890,7 @@ add_route_connected_v6_net(struct tuntap *tt,
 }
 
 void
-delete_route_connected_v6_net(struct tuntap *tt,
-                              const struct env_set *es)
+delete_route_connected_v6_net(const struct tuntap *tt)
 {
     struct route_ipv6 r6;
 
@@ -901,7 +901,7 @@ delete_route_connected_v6_net(struct tuntap *tt,
     r6.metric  = 0;                     /* connected route */
     r6.flags   = RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, es, NULL);
+    delete_route_ipv6(&r6, tt, 0, NULL, NULL);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
 
@@ -6572,7 +6572,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
 
     if (ipv6)
     {
-        delete_route_connected_v6_net(tt, NULL);
+        delete_route_connected_v6_net(tt);
     }
 
     /* "store=active" is needed in Windows 8(.1) to delete the
@@ -6619,7 +6619,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
             {
                 do_dns_service(false, AF_INET6, tt);
             }
-            delete_route_connected_v6_net(tt, NULL);
+            delete_route_connected_v6_net(tt);
             do_address_service(false, AF_INET6, tt);
         }
         else
-- 
2.17.1


