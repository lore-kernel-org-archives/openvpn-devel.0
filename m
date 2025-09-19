From: Gert Doering <gert@...1296...>
Date: Fri, 19 Sep 2025 13:24:19 +0200
Message-ID: <20250919112424.24728-1-gert@...1296...>
In-Reply-To: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
References: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] fix building of openvpnsrvmsg.dll from
 eventmsg.mc in mingw builds
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

commit 06919a60ae61 introduces .mc files that need to be compiled to
.h and .bin by the windows "mc.exe" tool, and from there into a new
.dll.  This worked for MSVC builds, did nothing for cmake/mingw builds,
and broke compilation on autoconf/mingw builds.

This patch consists of two parts:

1. add building of openvpnsrvmsg.dll to autoconf/mingw builds

   Add logic to configure.ac to find the "windmc" binary in the linux or
   mingw variants, add rules to src/openvpnserv/Makefile.am so make knows
   what to do.

   Libtool is getting in the way when "openvpnsrvmsg.dll" is created as
   anything listed in ...BIN or ...LIB, so decare it as "DATA" and make
   the necessary rules explicit.

2. fix building of openvpnsrvmsg.dll on cmake/mingw builds

   Fix "find_program()" invocation to avoid using "midnight commander"
   binary (mc) on Linux (called "windmc" there).

   Change from "-Wl,--noentry" to linker invocation that works.

See also:
https://learn.microsoft.com/en-us/cpp/build/creating-a-resource-only-dll?view=msvc-170

Change-Id: I071e8190dac28f429257b8af1c6f9e68f8896bc0
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1197
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1197
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/configure.ac b/configure.ac
index 7059871..38b14a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -441,6 +441,7 @@
 AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
 AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"], [Path to systemd-ask-password tool])
+AC_CHECK_TOOLS([WINDMC], [windmc mc.exe],[no])
 
 #
 #  man page generation - based on python-docutils
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 82099f1..340b904 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -41,7 +41,7 @@
 file(MAKE_DIRECTORY ${MC_GEN_DIR})
 set(MC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)
 
-find_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i686-w64-mingw32-windmc windmc)
+find_program(MC_COMPILER NAMES mc.exe x86_64-w64-mingw32-windmc i686-w64-mingw32-windmc windmc)
 
 if (NOT MC_COMPILER)
     message(FATAL_ERROR "No message compiler found.")
@@ -58,12 +58,17 @@
 add_custom_target(msg_mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h)
 
 add_library(openvpnservmsg SHARED ${MC_GEN_DIR}/eventmsg.rc)
+add_dependencies(openvpnservmsg msg_mc_gen)
 
 if (MSVC)
     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS "/NOENTRY")
 else()
-    target_link_options(openvpnservmsg PRIVATE "-Wl,--no-entry")
+    set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME "openvpnservmsg")
+    target_link_options(openvpnservmsg PRIVATE
+        -Wl,--entry=0
+        -nostdlib
+        -nostartfiles
+    )
 endif()
 
-add_dependencies(openvpnservmsg msg_mc_gen)
 add_dependencies(openvpnserv msg_mc_gen)
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index ef5f3f3..a27fbbf 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -28,6 +28,10 @@
 openvpnserv_LDADD = \
 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32
+noinst_DATA = \
+	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll
+BUILT_SOURCES = \
+	eventmsg.h
 endif
 
 openvpnserv_SOURCES = \
@@ -37,3 +41,11 @@
 	validate.c validate.h \
 	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block.h \
 	openvpnserv_resources.rc
+
+openvpnservmsg.dll: eventmsg.o
+	$(CC) -shared -Wl,--entry=0 -nostdlib -nostartfiles -o $@ $<
+
+eventmsg.o: eventmsg.rc
+
+eventmsg.h: eventmsg.mc
+	$(WINDMC) -U $<

