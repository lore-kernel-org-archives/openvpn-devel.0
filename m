From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:38 +0200
Message-Id: <1297436985-18991-6-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 06/13] Added comments and made small
	modifications to win/msvc.mak.in
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

The win/msvc.mak.in file is used as basis for msvc.mak file which drives
openvpn.exe building. This change separates output file from LINK32_FLAGS and
adds helpful comments to the win/msvc.mak.in file.
---
 win/msvc.mak.in |   32 ++++++++++++++++----------------
 1 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/win/msvc.mak.in b/win/msvc.mak.in
index 5d94a6e..1ffb5da 100644
--- a/win/msvc.mak.in
+++ b/win/msvc.mak.in
@@ -1,12 +1,15 @@
-# This makefile builds the user-mode component
-# of OpenVPN for Windows in the Visual Studio 2008 environment.
-
-# To build:
-#    python win\config.py
-#    nmake /f msvc.mak
-
-# Each of the OPENSSL and LZO dirs should have 'lib' and 'include'
-# directories under them.
+# This makefile builds the user-mode component of OpenVPN for Windows in the 
+# Visual Studio 2008 environment. Note that this file is basis for the real 
+# makefile (..\msvc.mak) but unusable as is. The real makefile is automatically 
+# generated during the build process by the Python build scripts.
+#
+# A few details are in order:
+#
+# - Everything between @<< and << is inserted into a s.c. "in-line file". This 
+#   file drives the linker (link.exe).
+# - HEADERS_OBJS is expanded to all all header and source files listed in 
+#  ..\Makefile.am
+# - OPENSSL_DIR and LZO_DIR are dynamically created from settings.in
 
 OPENSSL = @OPENSSL_DIR@
 OPENSSL_DYNAMIC = libeay32.lib ssleay32.lib
@@ -30,22 +33,19 @@ LINK32=link.exe
 !ifdef PRODUCT_OPENVPN_DEBUG
 # debug:
 CPP_PROJ=$(CPP_ARG_COMMON) /MD /Z7
-LINK32_FLAGS=/nologo /subsystem:console /incremental:no /opt:ref /opt:icf /debug /out:"$(EXE)"
-# old debug:
-#CPP_PROJ=$(CPP_ARG_COMMON) /MDd /Zi /Od -D_DEBUG
-#LINK32_FLAGS=/nologo /subsystem:console /incremental:no /debug /out:"$(EXE)"
+LINK32_FLAGS=/nologo /subsystem:console /incremental:no /opt:ref /opt:icf /debug
 !else
 # release:
 CPP_PROJ=$(CPP_ARG_COMMON) /O2 /MD -DNDEBUG
-LINK32_FLAGS=/nologo /subsystem:console /incremental:no /out:"$(EXE)"
+LINK32_FLAGS=/nologo /subsystem:console /incremental:no
 !endif
 
-# HEADERS and OBJS definitions, automatically generated
+# HEADERS and OBJS definitions, automatically generated from ../Makefile.am
 @HEADERS_OBJS@
 
 openvpn : $(OBJS)
 	$(LINK32) @<<
-	$(LINK32_FLAGS) $(LIB_DIRS) $(LIBS) $(OBJS)
+	$(LINK32_FLAGS) "/out:$(EXE)" $(LIB_DIRS) $(LIBS) $(OBJS)
 <<
 
 clean :
-- 
1.6.3.3


