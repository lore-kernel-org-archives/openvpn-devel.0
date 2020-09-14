From: David Sommerseth <davids@...515...>
Date: Mon, 14 Sep 2020 13:57:06 +0200
Message-Id: <20200914115706.11066-1-davids@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] sample-plugins: Partially autotoolize the
 sample-plugins build
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

The sample-plugins have their own set of build/winbuild scripts in each
of these plugin directories.  This does not give a good way to reuse
various macros the autoconf/automake/configure process enables; which
can contain important macros to make some code build without errors or
warnings.

Normally we would embrace the full autoconf/automake approach. But this
is sample code which we only want to build per request and the built
code should not be installed anywhere via 'make install'.  But since we
do use libtool other plug-ins being installed and automake gets kind of
cranky when it comes to define certain build targets not following the
expected use cases, we try to only embrace just enough of automake to
get our main goals achieved.

This changeset kicks out the build scripts and replaces them with a
single Makefile.plugins file, which defines the plugins we want to build
by default when running 'make from the sample-plugins directory.
Neither of these plugins are otherwise built by default.  No sample-plugins
are being installed.  But we have enough strings attached to automake
to grab the CFLAGS and LDFLAGS used by the rest of the code.  This also
makes it easy to use #include "config.h" in sample code, to also get
various macros defined by the ./configure run.

This patch does not touch the winbuild scripts, as it seems building
these sample-plugins on Windows requires a bit different compile and
linking steps than *nix systems in general.

Signed-off-by: David Sommerseth <davids@...515...>
---
 configure.ac                                  |  1 +
 sample/sample-plugins/Makefile.am             | 28 +++++++++++++++++
 sample/sample-plugins/Makefile.plugins        | 31 +++++++++++++++++++
 sample/sample-plugins/defer/build             | 15 ---------
 .../keying-material-exporter-demo/build       | 15 ---------
 sample/sample-plugins/log/build               | 15 ---------
 sample/sample-plugins/simple/build            | 15 ---------
 7 files changed, 60 insertions(+), 60 deletions(-)
 create mode 100644 sample/sample-plugins/Makefile.am
 create mode 100644 sample/sample-plugins/Makefile.plugins
 delete mode 100755 sample/sample-plugins/defer/build
 delete mode 100755 sample/sample-plugins/keying-material-exporter-demo/build
 delete mode 100755 sample/sample-plugins/log/build
 delete mode 100755 sample/sample-plugins/simple/build

diff --git a/configure.ac b/configure.ac
index f8279924..ebb32204 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1433,6 +1433,7 @@ AC_CONFIG_FILES([
 	doc/doxygen/Makefile
 	doc/doxygen/openvpn.doxyfile
 	include/Makefile
+	sample/sample-plugins/Makefile
 	src/Makefile
 	src/compat/Makefile
 	src/openvpn/Makefile
diff --git a/sample/sample-plugins/Makefile.am b/sample/sample-plugins/Makefile.am
new file mode 100644
index 00000000..d02abe48
--- /dev/null
+++ b/sample/sample-plugins/Makefile.am
@@ -0,0 +1,28 @@
+#
+#  OpenVPN -- An application to securely tunnel IP networks
+#             over a single UDP port, with support for SSL/TLS-based
+#             session authentication and key exchange,
+#             packet encryption, packet authentication, and
+#             packet compression.
+#
+#  Copyright (C) 2002-2020 OpenVPN Inc <sales@...515...>
+#
+
+MAINTAINERCLEANFILES = \
+	$(srcdir)/Makefile.in
+
+# We don't want automake to pull in libtool for building these
+# sample-plugins.  Even though this breaks the conceptual ideas
+# around autoconf/automake/libtools ... these sample plug-ins
+# are just sample code, not to be installed or distributed outside
+# of the source tarball.  Not even built by default, by design.
+#
+# We only add this as a simple and convenient way to build all
+# these plug-ins with the same build parameters as the rest
+# of the OpenVPN code.
+#
+# All the plugins which will be built are processed in this
+# separate Makefile, which disconnects everything just enough
+# to achieve our goal.
+include Makefile.plugins
+
diff --git a/sample/sample-plugins/Makefile.plugins b/sample/sample-plugins/Makefile.plugins
new file mode 100644
index 00000000..76768dbe
--- /dev/null
+++ b/sample/sample-plugins/Makefile.plugins
@@ -0,0 +1,31 @@
+#  SPDX-License-Identifier: GPL-2.0-only
+#
+#  Copyright (C) 2020 OpenVPN Inc <sales@...515...>
+#
+
+#
+# Plug-ins to build - listed entries should not carry any extensions
+#
+PLUGINS = \
+	defer/simple \
+	keying-material-exporter-demo/keyingmaterialexporter \
+	log/log log/log_v3 \
+	simple/base64 \
+	simple/simple
+
+# All the plugins to build - rewritten with .so extension
+all : $(foreach var, $(PLUGINS), $(var).so)
+
+# Compile step
+.c.o :
+	test -d `dirname $@` || $(MKDIR_P) `dirname $@`; \
+	$(CC) -c -o $@ $(CFLAGS) -I$(top_srcdir) -fPIC $<
+
+# Link step
+%.so : %.o
+	$(CC) $(LDFLAGS) -shared -fPIC -o $@ $<
+
+# Clean up all build object and shared object files
+clean :
+	rm -f $(foreach var, $(PLUGINS), $(var).o) \
+	$(foreach var, $(PLUGINS), $(var).so)
diff --git a/sample/sample-plugins/defer/build b/sample/sample-plugins/defer/build
deleted file mode 100755
index ba41a39f..00000000
--- a/sample/sample-plugins/defer/build
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
-CPPFLAGS="${CPPFLAGS:--I../../../include}"
-
-CC="${CC:-gcc}"
-CFLAGS="${CFLAGS:--O2 -Wall -g}"
-
-$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
-$CC $CFLAGS -fPIC -shared ${LDFLAGS} -Wl,-soname,$1.so -o $1.so $1.o -lc
diff --git a/sample/sample-plugins/keying-material-exporter-demo/build b/sample/sample-plugins/keying-material-exporter-demo/build
deleted file mode 100755
index bbb05f7c..00000000
--- a/sample/sample-plugins/keying-material-exporter-demo/build
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
diff --git a/sample/sample-plugins/log/build b/sample/sample-plugins/log/build
deleted file mode 100755
index c07ec408..00000000
--- a/sample/sample-plugins/log/build
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
-CPPFLAGS="${CPPFLAGS:--I../../../include}"
-
-CC="${CC:-gcc}"
-CFLAGS="${CFLAGS:--O2 -Wall -g}"
-
-$CC $CPPFLAGS $CFLAGS -fPIC -c $1.c && \
-$CC $CFLAGS -fPIC -shared $LDFLAGS -Wl,-soname,$1.so -o $1.so $1.o -lc
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
2.26.0


