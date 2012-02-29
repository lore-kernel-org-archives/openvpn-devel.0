From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:37:29 +0200
Message-Id: <1330547854-18889-4-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
References: <1330547702-18756-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [tap-windows 06/11] cleanup: replace
	TAP-Win32->TAP-Windows
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>


Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/SOURCES.in           |    2 +-
 src/common.h             |    6 +++---
 src/constants.h          |    4 ++--
 src/dhcp.c               |    4 ++--
 src/dhcp.h               |    4 ++--
 src/endian.h             |    4 ++--
 src/error.c              |    4 ++--
 src/error.h              |    4 ++--
 src/hexdump.c            |    4 ++--
 src/hexdump.h            |    4 ++--
 src/i386/OemWin2k.inf.in |    6 +++---
 src/instance.c           |    4 ++--
 src/lock.h               |    4 ++--
 src/macinfo.c            |    4 ++--
 src/macinfo.h            |    4 ++--
 src/mem.c                |    4 ++--
 src/proto.h              |    4 ++--
 src/prototypes.h         |    4 ++--
 src/resource.rc          |    2 +-
 src/tapdrvr.c            |    6 +++---
 src/types.h              |    4 ++--
 21 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/src/SOURCES.in b/src/SOURCES.in
index cf030f4..2f77365 100755
--- a/src/SOURCES.in
+++ b/src/SOURCES.in
@@ -1,4 +1,4 @@
-# Build TAP-Win32 driver.
+# Build TAP-Windows driver.
 # Build Command: build -cef
 
 MAJORCOMP=ntos
diff --git a/src/common.h b/src/common.h
index bb8ab90..8dceda5 100755
--- a/src/common.h
+++ b/src/common.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
@@ -24,7 +24,7 @@
 
 //===============================================
 // This file is included both by OpenVPN and
-// the TAP-Win32 driver and contains definitions
+// the TAP-Windows driver and contains definitions
 // common to both.
 //===============================================
 
diff --git a/src/constants.h b/src/constants.h
index 9bbd7ee..2451f12 100755
--- a/src/constants.h
+++ b/src/constants.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/dhcp.c b/src/dhcp.c
index 3891d42..62602c9 100755
--- a/src/dhcp.c
+++ b/src/dhcp.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/dhcp.h b/src/dhcp.h
index 4215f81..94765a7 100755
--- a/src/dhcp.h
+++ b/src/dhcp.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/endian.h b/src/endian.h
index 128029a..0f7025d 100755
--- a/src/endian.h
+++ b/src/endian.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/error.c b/src/error.c
index 0541bc3..271dafc 100755
--- a/src/error.c
+++ b/src/error.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/error.h b/src/error.h
index d8436dc..47f436c 100755
--- a/src/error.h
+++ b/src/error.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/hexdump.c b/src/hexdump.c
index 49bc38c..8589f4b 100755
--- a/src/hexdump.c
+++ b/src/hexdump.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/hexdump.h b/src/hexdump.h
index c1af705..d0b152d 100755
--- a/src/hexdump.h
+++ b/src/hexdump.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/i386/OemWin2k.inf.in b/src/i386/OemWin2k.inf.in
index 031b06c..34888f2 100755
--- a/src/i386/OemWin2k.inf.in
+++ b/src/i386/OemWin2k.inf.in
@@ -18,10 +18,10 @@
 ;*********************************************************
 ; Note to Developers:
 ;
-; If you are bundling the TAP-Win32 driver with your app,
+; If you are bundling the TAP-Windows driver with your app,
 ; you should try to rename it in such a way that it will
-; not collide with other instances of TAP-Win32 defined
-; by other apps.  Multiple versions of the TAP-Win32
+; not collide with other instances of TAP-Windows defined
+; by other apps.  Multiple versions of the TAP-Windows
 ; driver, each installed by different apps, can coexist
 ; on the same machine if you follow these guidelines.
 ; NOTE: these instructions assume you are editing the
diff --git a/src/instance.c b/src/instance.c
index 182cee8..33ef878 100755
--- a/src/instance.c
+++ b/src/instance.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/lock.h b/src/lock.h
index ea75414..e2a2029 100755
--- a/src/lock.h
+++ b/src/lock.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/macinfo.c b/src/macinfo.c
index 8d512ec..fca5307 100755
--- a/src/macinfo.c
+++ b/src/macinfo.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/macinfo.h b/src/macinfo.h
index 51e930d..ba843e8 100755
--- a/src/macinfo.h
+++ b/src/macinfo.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/mem.c b/src/mem.c
index 6fbbed5..c56304c 100755
--- a/src/mem.c
+++ b/src/mem.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/proto.h b/src/proto.h
index 894a37f..71916a9 100755
--- a/src/proto.h
+++ b/src/proto.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/prototypes.h b/src/prototypes.h
index 18c566f..50cc461 100755
--- a/src/prototypes.h
+++ b/src/prototypes.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
diff --git a/src/resource.rc b/src/resource.rc
index 8b2d2f6..d50b60f 100755
--- a/src/resource.rc
+++ b/src/resource.rc
@@ -38,7 +38,7 @@
 */
 
 #define VER_COMPANYNAME_STR         "The OpenVPN Project"
-#define VER_FILEDESCRIPTION_STR     "TAP-Win32 Virtual Network Driver"
+#define VER_FILEDESCRIPTION_STR     "TAP-Windows Virtual Network Driver"
 #define VER_ORIGINALFILENAME_STR    TAP_COMPONENT_ID ".sys"
 #define VER_LEGALCOPYRIGHT_YEARS    "2003-2010"
 #define VER_LEGALCOPYRIGHT_STR      "OpenVPN Technologies, Inc."
diff --git a/src/tapdrvr.c b/src/tapdrvr.c
index 0f75b77..2156f8b 100755
--- a/src/tapdrvr.c
+++ b/src/tapdrvr.c
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
@@ -928,7 +928,7 @@ CreateTapDevice (TapExtensionPointer p_Extension, const char *p_Name)
   // to satisfy IRP requests in the IRP queue.
   //
   // QueueLock is used to lock the packet queue used
-  // for the TAP-Win32 NIC -> User Space packet flow direction.
+  // for the TAP-Windows NIC -> User Space packet flow direction.
   //
   // All accesses to packet or IRP queues should be
   // bracketed by the QueueLock spinlock,
diff --git a/src/types.h b/src/types.h
index bdc08e7..6ca841d 100755
--- a/src/types.h
+++ b/src/types.h
@@ -1,6 +1,6 @@
 /*
- *  TAP-Win32/TAP-Win64 -- A kernel driver to provide virtual tap
- *                         device functionality on Windows.
+ *  TAP-Windows -- A kernel driver to provide virtual tap
+ *                 device functionality on Windows.
  *
  *  This code was inspired by the CIPE-Win32 driver by Damion K. Wilson.
  *
-- 
1.7.3.4


