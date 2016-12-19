From: David Sommerseth <davids@...515...>
Date: Mon, 19 Dec 2016 19:52:12 +0100
Message-Id: <1482173532-25132-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] dev-tools: Added script for updating
	copyright years in files
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

Very simple tool which modifies the Copyright lines in all git checked-in
files with an updated year.  Lines only listing a single year (2016) will
be modified to list a range instead.

Only the Copyright lines owners of specific owners will be modified.  The
script will need to be slightly updated to cover more owners.  See the
UPDATE_COPYRIGHT_LINES line in the script for the currently set owners.

Signed-off-by: David Sommerseth <davids@...515...>
---
 dev-tools/update-copyright.sh | 50 +++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 50 insertions(+)
 create mode 100755 dev-tools/update-copyright.sh

diff --git a/dev-tools/update-copyright.sh b/dev-tools/update-copyright.sh
new file mode 100755
index 0000000..26486ec
--- /dev/null
+++ b/dev-tools/update-copyright.sh
@@ -0,0 +1,50 @@
+#!/bin/sh
+# update-copyright-sh - Simple tool to update the Copyright lines
+#                       in all files checked into git
+#
+# Copyright (C) 2016 David Sommerseth <davids@...515...>
+#
+# This program is free software; you can redistribute it and/or
+# modify it under the terms of the GNU General Public License
+# as published by the Free Software Foundation; either version 2
+# of the License.
+#
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+#
+# You should have received a copy of the GNU General Public License
+# along with this program; if not, write to the Free Software
+# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
+#
+
+# Basic shell sanity
+set -eu
+
+# Simple argument control
+if [ $# -ne 1 ]; then
+    echo "Usage: $0 <New Copyright Year>"
+    exit 1
+fi
+
+# Only update Copyright lines with these owners
+# The 'or' operator is GNU sed specific, and must be \|
+UPDATE_COPYRIGHT_LINES="@openvpn\.net\|@fox-it\.com\|@eurephia\.net\|@greenie\.muc\.de"
+COPY_YEAR="$1"
+
+cd "$(git rev-parse --show-toplevel)"
+for file in $(git ls-files | grep -v cmocka);
+do
+    echo -n "Updating $file ..."
+    # The first sed operation covers 20xx-20yy copyright lines,
+    # The second sed operation changes 20xx -> 20xx-20yy
+    sed -e "/$UPDATE_COPYRIGHT_LINES/s/\(Copyright (C) 20..-\)\(20..\)[[:blank:]]\+/\1$COPY_YEAR /" \
+        -e "/$UPDATE_COPYRIGHT_LINES/s/\(Copyright (C) \)\(20..\)[[:blank:]]\+/\1\2-$COPY_YEAR /" \
+        -i $file
+    echo " Done"
+done
+echo
+echo "** All files updated with $COPY_YEAR as the ending copyright year"
+echo
+exit 0
-- 
1.8.3.1


