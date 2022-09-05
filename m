From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  5 Sep 2022 14:35:34 +0300
Message-Id: <20220905113534.277-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] msvc: remove .filters file
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

Filters file defines custom logical folders in
Solution Explorer. We don't use this functionality
and it requires maintenance, so let's remove it.

While on it, remove dco linux files from VS project.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/openvpn.vcxproj         |   5 +-
 src/openvpn/openvpn.vcxproj.filters | 574 ----------------------------
 2 files changed, 1 insertion(+), 578 deletions(-)
 delete mode 100644 src/openvpn/openvpn.vcxproj.filters

diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index ccd29cd8..a45fb993 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -277,7 +277,6 @@
     <ClCompile Include="crypto_openssl.c" />
     <ClCompile Include="cryptoapi.c" />
     <ClCompile Include="dco.c" />
-    <ClCompile Include="dco_linux.c" />
     <ClCompile Include="dco_win.c" />
     <ClCompile Include="dhcp.c" />
     <ClCompile Include="dns.c" />
@@ -367,7 +366,6 @@
     <ClInclude Include="cryptoapi.h" />
     <ClInclude Include="dco.h" />
     <ClInclude Include="dco_internal.h" />
-    <ClInclude Include="dco_linux.h" />
     <ClInclude Include="dco_win.h" />
     <ClInclude Include="dhcp.h" />
     <ClInclude Include="dns.h" />
@@ -403,7 +401,6 @@
     <ClInclude Include="openvpn.h" />
     <ClInclude Include="options.h" />
     <ClInclude Include="otime.h" />
-    <ClInclude Include="ovpn_dco_linux.h" />
     <ClInclude Include="ovpn_dco_win.h" />
     <ClInclude Include="packet_id.h" />
     <ClInclude Include="perf.h" />
@@ -466,4 +463,4 @@
   <Import Project="$(VCTargetsPath)\Microsoft.Cpp.targets" />
   <ImportGroup Label="ExtensionTargets">
   </ImportGroup>
-</Project>
+</Project>
\ No newline at end of file
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
deleted file mode 100644
index bf0ba708..00000000
--- a/src/openvpn/openvpn.vcxproj.filters
+++ /dev/null
@@ -1,574 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup>
-    <Filter Include="Source Files">
-      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
-      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
-    </Filter>
-    <Filter Include="Header Files">
-      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
-      <Extensions>h;hpp;hxx;hm;inl;inc;xsd</Extensions>
-    </Filter>
-    <Filter Include="Resource Files">
-      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
-      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav</Extensions>
-    </Filter>
-  </ItemGroup>
-  <ItemGroup>
-    <ClCompile Include="base64.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="buffer.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="clinat.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="console.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="crypto.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="crypto_openssl.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="cryptoapi.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="dco.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="dco_linux.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="dco_win.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="dhcp.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="dns.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="error.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="event.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="fdmisc.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="forward.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="fragment.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="gremlin.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="helper.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="httpdigest.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="init.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="interval.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="list.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="lladdr.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="lzo.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="manage.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mbuf.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="misc.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mroute.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mss.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mstats.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mtcp.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mtu.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="mudp.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="multi.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ntlm.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="occ.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="openvpn.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="options.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="otime.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="packet_id.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="perf.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ping.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="pkcs11.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="pkcs11_openssl.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="platform.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="plugin.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="pool.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="proto.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="proxy.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ps.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="push.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="reliable.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="route.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="schedule.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="session_id.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="shaper.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="sig.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="socket.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="socks.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl_openssl.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl_verify.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl_verify_openssl.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="status.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="tun.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="win32.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="win32-util.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="comp.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="compstub.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="comp-lz4.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="argv.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="block_dns.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="console_builtin.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="tls_crypt.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="env_set.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="run_command.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="auth_token.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="vlan.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl_ncp.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl_pkt.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="ssl_util.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="xkey_helper.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="xkey_provider.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="base64.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="basic.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="buffer.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="circ_list.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="clinat.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="common.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="comp.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="comp-lz4.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="console.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="crypto.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="crypto_backend.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="crypto_openssl.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="cryptoapi.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClCompile Include="dco.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="dco_internal.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="dco_linux.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="dco_win.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="dhcp.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="dns.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="errlevel.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="error.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="event.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="fdmisc.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="forward.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="fragment.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="gremlin.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="helper.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="httpdigest.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="init.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="integer.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="interval.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="list.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="lladdr.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="lzo.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="manage.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mbuf.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="memdbg.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="misc.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mroute.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mss.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mstats.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mtcp.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mtu.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="mudp.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="multi.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ntlm.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="occ.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="openvpn.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="options.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="otime.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ovpn_dco_linux.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ovpn_dco_win.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="packet_id.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="perf.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ping.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="pkcs11.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="pkcs11_backend.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="platform.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="plugin.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="pool.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="proto.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="proxy.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ps.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="push.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="pushlist.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="reliable.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="route.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="schedule.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="session_id.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="shaper.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="sig.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="socket.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="socks.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_backend.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_common.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_openssl.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_verify.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_verify_backend.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_verify_openssl.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="status.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="syshead.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="tun.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="win32.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="compstub.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="argv.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="block_dns.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="tls_crypt.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="env_set.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="run_command.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="auth_token.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="vlan.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ring_buffer.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_ncp.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="ssl_util.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="win32-util.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="xkey_common.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="openvpn_win32_resources.rc">
-      <Filter>Resource Files</Filter>
-    </ResourceCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <Manifest Include="openvpn.manifest">
-      <Filter>Resource Files</Filter>
-    </Manifest>
-  </ItemGroup>
-</Project>
-- 
2.34.1


