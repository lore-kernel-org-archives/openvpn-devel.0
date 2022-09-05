From: Lev Stipakov <lstipakov@...277...>
Date: Mon,  5 Sep 2022 14:56:39 +0300
Message-Id: <20220905115639.379-1-lstipakov@...277...>
In-Reply-To: <20220905113534.277-1-lstipakov@...277...>
References: <20220905113534.277-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] msvc: remove .filters files
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
and it requires maintenance, so let's remove those.

While on it, remove dco linux files from VS project.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: remove .filters files from other projects
 and makefiles.

 src/compat/Makefile.am                        |   1 -
 src/compat/compat.vcxproj.filters             |  39 --
 src/openvpn/Makefile.am                       |   1 -
 src/openvpn/openvpn.vcxproj                   |   5 +-
 src/openvpn/openvpn.vcxproj.filters           | 574 ------------------
 src/openvpnmsica/Makefile.am                  |   1 -
 src/openvpnmsica/openvpnmsica.vcxproj.filters |  62 --
 src/openvpnserv/Makefile.am                   |   3 +-
 src/openvpnserv/openvpnserv.vcxproj.filters   |  53 --
 src/tapctl/Makefile.am                        |   1 -
 src/tapctl/tapctl.vcxproj.filters             |  49 --
 11 files changed, 2 insertions(+), 787 deletions(-)
 delete mode 100644 src/compat/compat.vcxproj.filters
 delete mode 100644 src/openvpn/openvpn.vcxproj.filters
 delete mode 100644 src/openvpnmsica/openvpnmsica.vcxproj.filters
 delete mode 100644 src/openvpnserv/openvpnserv.vcxproj.filters
 delete mode 100644 src/tapctl/tapctl.vcxproj.filters

diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index 6eb991dc..23346be5 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -14,7 +14,6 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	compat.vcxproj \
-	compat.vcxproj.filters \
 	PropertySheet.props \
 	Debug.props \
 	Release.props
diff --git a/src/compat/compat.vcxproj.filters b/src/compat/compat.vcxproj.filters
deleted file mode 100644
index 96ca026a..00000000
--- a/src/compat/compat.vcxproj.filters
+++ /dev/null
@@ -1,39 +0,0 @@
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
-    <ClCompile Include="compat-basename.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="compat-dirname.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="compat-gettimeofday.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="compat-daemon.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="compat-strsep.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="compat.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-  </ItemGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 5dbff4c6..71648ef1 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -16,7 +16,6 @@ MAINTAINERCLEANFILES = \
 
 EXTRA_DIST = \
 	openvpn.vcxproj \
-	openvpn.vcxproj.filters \
 	openvpn.manifest
 
 AM_CPPFLAGS = \
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
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index 95482940..d3053c42 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -24,7 +24,6 @@ MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
 EXTRA_DIST = \
 	openvpnmsica.vcxproj \
-	openvpnmsica.vcxproj.filters \
 	openvpnmsica.props \
 	openvpnmsica-Debug.props \
 	openvpnmsica-Release.props
diff --git a/src/openvpnmsica/openvpnmsica.vcxproj.filters b/src/openvpnmsica/openvpnmsica.vcxproj.filters
deleted file mode 100644
index cb050f97..00000000
--- a/src/openvpnmsica/openvpnmsica.vcxproj.filters
+++ /dev/null
@@ -1,62 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup>
-    <Filter Include="Source Files">
-      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
-      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
-    </Filter>
-    <Filter Include="Header Files">
-      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
-      <Extensions>h;hh;hpp;hxx;hm;inl;inc;xsd</Extensions>
-    </Filter>
-    <Filter Include="Resource Files">
-      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
-      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav;mfcribbon-ms</Extensions>
-    </Filter>
-  </ItemGroup>
-  <ItemGroup>
-    <ClCompile Include="dllmain.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="..\tapctl\error.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="msiex.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="openvpnmsica.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="msica_arg.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="..\tapctl\tap.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="openvpnmsica.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="msiex.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="msica_arg.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="..\tapctl\tap.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="..\tapctl\error.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="..\tapctl\basic.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="openvpnmsica_resources.rc">
-      <Filter>Resource Files</Filter>
-    </ResourceCompile>
-  </ItemGroup>
-</Project>
\ No newline at end of file
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index c230acd8..b79b3a34 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -14,8 +14,7 @@ include $(top_srcdir)/build/ltrc.inc
 MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
 EXTRA_DIST = \
-	openvpnserv.vcxproj \
-	openvpnserv.vcxproj.filters
+	openvpnserv.vcxproj
 
 AM_CPPFLAGS = \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
diff --git a/src/openvpnserv/openvpnserv.vcxproj.filters b/src/openvpnserv/openvpnserv.vcxproj.filters
deleted file mode 100644
index 389dac31..00000000
--- a/src/openvpnserv/openvpnserv.vcxproj.filters
+++ /dev/null
@@ -1,53 +0,0 @@
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
-    <ClCompile Include="service.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="common.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="interactive.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="validate.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="..\openvpn\block_dns.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="service.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="validate.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="..\openvpn\block_dns.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="..\openvpn\ring_buffer.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="openvpnserv_resources.rc">
-      <Filter>Resource Files</Filter>
-    </ResourceCompile>
-  </ItemGroup>
-</Project>
\ No newline at end of file
diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 305181bf..ff61fb7f 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -24,7 +24,6 @@ MAINTAINERCLEANFILES = $(srcdir)/Makefile.in
 
 EXTRA_DIST = \
 	tapctl.vcxproj \
-	tapctl.vcxproj.filters \
 	tapctl.props \
 	tapctl.exe.manifest
 
diff --git a/src/tapctl/tapctl.vcxproj.filters b/src/tapctl/tapctl.vcxproj.filters
deleted file mode 100644
index c7f71e9c..00000000
--- a/src/tapctl/tapctl.vcxproj.filters
+++ /dev/null
@@ -1,49 +0,0 @@
-﻿<?xml version="1.0" encoding="utf-8"?>
-<Project ToolsVersion="4.0" xmlns="http://schemas.microsoft.com/developer/msbuild/2003">
-  <ItemGroup>
-    <Filter Include="Source Files">
-      <UniqueIdentifier>{4FC737F1-C7A5-4376-A066-2A32D752A2FF}</UniqueIdentifier>
-      <Extensions>cpp;c;cc;cxx;def;odl;idl;hpj;bat;asm;asmx</Extensions>
-    </Filter>
-    <Filter Include="Header Files">
-      <UniqueIdentifier>{93995380-89BD-4b04-88EB-625FBE52EBFB}</UniqueIdentifier>
-      <Extensions>h;hh;hpp;hxx;hm;inl;inc;xsd</Extensions>
-    </Filter>
-    <Filter Include="Resource Files">
-      <UniqueIdentifier>{67DA6AB6-F800-4c08-8B7A-83BB121AAD01}</UniqueIdentifier>
-      <Extensions>rc;ico;cur;bmp;dlg;rc2;rct;bin;rgs;gif;jpg;jpeg;jpe;resx;tiff;tif;png;wav;mfcribbon-ms</Extensions>
-    </Filter>
-  </ItemGroup>
-  <ItemGroup>
-    <ClCompile Include="tap.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="main.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-    <ClCompile Include="error.c">
-      <Filter>Source Files</Filter>
-    </ClCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <ClInclude Include="tap.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="error.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-    <ClInclude Include="basic.h">
-      <Filter>Header Files</Filter>
-    </ClInclude>
-  </ItemGroup>
-  <ItemGroup>
-    <ResourceCompile Include="tapctl_resources.rc">
-      <Filter>Resource Files</Filter>
-    </ResourceCompile>
-  </ItemGroup>
-  <ItemGroup>
-    <Manifest Include="tapctl.exe.manifest">
-      <Filter>Resource Files</Filter>
-    </Manifest>
-  </ItemGroup>
-</Project>
\ No newline at end of file
-- 
2.23.0.windows.1


