From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:34 +0200
Message-Id: <1297436985-18991-2-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 02/13] Added a nmake makefile for
	openvpnserv.exe building
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

This change adds a nmake makefile (service-win32/msvc.mak) which allows building
openvpnserv.exe using the new Python-based buildsystem.
---
 service-win32/msvc.mak |   30 ++++++++++++++++++++++++++++++
 1 files changed, 30 insertions(+), 0 deletions(-)
 create mode 100644 service-win32/msvc.mak

diff --git a/service-win32/msvc.mak b/service-win32/msvc.mak
new file mode 100644
index 0000000..0da85a5
--- /dev/null
+++ b/service-win32/msvc.mak
@@ -0,0 +1,30 @@
+# This makefile builds the OpenVPN service wrapper for Windows in the 
+# Visual Studio 2008 environment.
+
+# Some of these libs may not be needed
+LIBS = ws2_32.lib crypt32.lib iphlpapi.lib winmm.lib user32.lib gdi32.lib advapi32.lib wininet.lib
+EXE = openvpnserv.exe
+
+CPP=cl.exe
+CPP_ARG_COMMON=/nologo /W3 -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D_MBCS -D_CRT_SECURE_NO_DEPRECATE /FD /c -I".."
+CPP_PROJ=$(CPP_ARG_COMMON) /O2 /MD -DNDEBUG
+
+LINK32=link.exe
+LINK32_FLAGS=/nologo /subsystem:console /incremental:no
+
+OBJS = \
+	openvpnserv.obj \
+	service.obj
+
+openvpnserv : $(OBJS)
+	$(LINK32) @<<
+	$(LINK32_FLAGS) "/out:$(EXE)" $(LIBS) $(OBJS)
+<<
+
+clean :
+	del /Q $(OBJS) $(EXE) *.idb *.pdb
+
+.c.obj::
+   $(CPP) @<<
+   $(CPP_PROJ) $<
+<<
-- 
1.6.3.3


