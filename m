From: David Sommerseth <davids@...515...>
Date: Fri,  5 May 2017 23:46:24 +0200
Message-Id: <20170505214624.11675-2-davids@...515...>
In-Reply-To: <20170505214624.11675-1-davids@...515...>
References: <20170505214624.11675-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 2/2] sample-plugins/simple: Clean up the
	build method
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

This replaces a not so well functioning ./build script with a more
proper Makefile.  The README file is also updated accordingly.

Signed-off-by: David Sommerseth <davids@...515...>
---
 sample/sample-plugins/simple/Makefile | 17 +++++++++++++++++
 sample/sample-plugins/simple/README   | 33 +++++++++++++++++++++++++++------
 sample/sample-plugins/simple/build    | 15 ---------------
 3 files changed, 44 insertions(+), 21 deletions(-)
 create mode 100644 sample/sample-plugins/simple/Makefile
 delete mode 100755 sample/sample-plugins/simple/build

diff --git a/sample/sample-plugins/simple/Makefile b/sample/sample-plugins/simple/Makefile
new file mode 100644
index 00000000..24909759
--- /dev/null
+++ b/sample/sample-plugins/simple/Makefile
@@ -0,0 +1,17 @@
+
+CFLAGS = -I../../../include -O2 -Wall -g -std=c99 -pthread -fPIC
+LDFLAGS = -fPIC
+
+all : base64.so simple.so
+
+base64.so : base64.o
+	$(CC) -shared $(LDFLAGS) -o $@ $^
+
+simple.so : simple.o
+	$(CC) -shared $(LDFLAGS) -o $@ $^
+
+.c.o :
+	$(CC) -c $(CFLAGS) $<
+
+clean :
+	rm -f *.o *.so
diff --git a/sample/sample-plugins/simple/README b/sample/sample-plugins/simple/README
index 4400cd30..15fcc55c 100644
--- a/sample/sample-plugins/simple/README
+++ b/sample/sample-plugins/simple/README
@@ -1,16 +1,37 @@
-OpenVPN plugin examples.
+Simple OpenVPN plugin examples
+==============================
 
 Examples provided:
 
 simple.c -- using the --auth-user-pass-verify callback, verify
             that the username/password is "foo"/"bar".
 
-To build:
+base64.c -- Very simple plug-in demonstrating how to use the
+            BASE64 encode/decode functions via the plug-in v3 API.
 
-  ./build simple (Linux/BSD/etc.)
-  ./winbuild simple (MinGW on Windows)
+
+Non-Windows users can just run `make` inside this directory to build all
+the plug-ins.
+
+    $ make
+
+To build a specific plug-in, run:
+
+    $ make simple.so
+    $ make base64.so
+
+Windows users may use the winbuild script which takes the file name of the
+plug-in to build without the extension.
+
+    > winbuild simple
+    > winbuild base64
 
 To use in OpenVPN, add to config file:
 
-  plugin simple.so (Linux/BSD/etc.)
-  plugin simple.dll (MinGW on Windows)
+For non-Windows users:
+  plugin simple.so
+  plugin base64.so
+
+Windows users:
+  plugin simple.dll
+  plugin base64.dll
diff --git a/sample/sample-plugins/simple/build b/sample/sample-plugins/simple/build
deleted file mode 100755
index bbb05f7c..00000000
--- a/sample/sample-plugins/simple/build
+++ /dev/null
@@ -1,15 +0,0 @@
-#!/bin/sh
-
-#
-# Build an OpenVPN plugin module on *nix.  The argument should
-# be the base name of the C source file (without the .c).
-#
-
-# This directory is where we will look for openvpn-plugin.h
-CPPFLAGS="${CPPFLAGS:--I../../..}"
-
-CC="${CC:-gcc}"
-CFLAGS="${CFLAGS:--O2 -Wall -g}"
-
-$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
-$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
-- 
2.11.0


