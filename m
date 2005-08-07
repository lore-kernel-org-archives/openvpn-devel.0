From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20050807130434.GB27788@...33...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
Subject: [Openvpn-devel] PATCH: "make check" support for OpenVPN 2
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Sun Aug  7 06:05:17 2005
To: openvpn-devel@lists.sourceforge.net

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Greetings,

the attached patch adds two shell scripts and two lines to Makefile.am
so that the GNU-standard "make check" works. It will first run the
loopback test, then the client-server test shown in the INSTALL file.

The test scripts will save the output of the respective openvpn commands
to a temporary file and only print these files (with cat(1)) if the
loopback test or either client or server exit with nonzero code or signal.

The whole setup supports VPATH builds (i. e. mkdir build ; cd build ;
../configure && make) and has in fact only been tested on such.

Please apply.

Kind regards,

-- 
Matthias Andree

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-make_check.diff"

Index: Makefile.am
===================================================================
RCS file: /cvsroot/openvpn/openvpn/Makefile.am,v
retrieving revision 1.22
diff -u -r1.22 Makefile.am
--- Makefile.am	11 Apr 2005 04:16:15 -0000	1.22
+++ Makefile.am	7 Aug 2005 12:55:18 -0000
@@ -30,6 +30,9 @@
 
 nodist_openvpn_SOURCES = config.h
 
+TESTS = t_lpback.sh t_cltsrv.sh
+dist_noinst_SCRIPTS = $(TESTS)
+
 openvpn_SOURCES = \
         base64.c base64.h \
 	basic.h \
--- /dev/null	2005-03-19 20:36:14.000000000 +0100
+++ t_cltsrv.sh	2005-08-07 14:54:28.000000000 +0200
@@ -0,0 +1,38 @@
+#! /bin/sh
+#
+# t_cltsrv.sh - script to test OpenVPN's crypto loopback
+# Copyright (C) 2005  Matthias Andree
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+# 02110-1301, USA.
+
+set -e
+echo "the following test will run about two minutes..." >&2
+trap "rm -f log.$$ ; false" 1 2 3 15
+set +e
+(
+./openvpn --cd "${srcdir}" --config sample-config-files/loopback-server &
+./openvpn --cd "${srcdir}" --config sample-config-files/loopback-client
+) >log.$$ 2>&1
+e1=$?
+wait $!
+e2=$?
+set -e
+
+if [ $e1 != 0 ] || [ $e2 != 0 ] ; then
+    cat log.$$
+    exit 1
+fi
+rm log.$$
--- /dev/null	2005-03-19 20:36:14.000000000 +0100
+++ t_lpback.sh	2005-08-07 14:53:56.000000000 +0200
@@ -0,0 +1,29 @@
+#! /bin/sh
+#
+# t_lpback.sh - script to test OpenVPN's crypto loopback
+# Copyright (C) 2005  Matthias Andree
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License, or (at your option) any later version.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
+# 02110-1301, USA.
+
+set -e
+trap "rm -f key.$$ log.$$ ; false" 1 2 3 15
+./openvpn --genkey --secret key.$$
+set +e
+( ./openvpn --test-crypto --secret key.$$ ) >log.$$ 2>&1
+e=$?
+if [ $e != 0 ] ; then cat log.$$ ; fi
+rm key.$$
+exit $e

--DocE+STaALJfprDB--

