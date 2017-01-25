From: David Sommerseth <davids@...515...>
Date: Wed, 25 Jan 2017 21:53:02 +0100
Message-Id: <20170125205302.23069-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] dev-tools: Simple tool wihch automates
	rebasing LZ4 compat library
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

This tool depends on a cloned upstream LZ4 git repository and a
checked out release tag.  Then run the script like this:

   $ ./dev-tools/lz4-rebaser.sh /path/to/lz4.git

To see the result before committing, use: git diff --cached

Signed-off-by: David Sommerseth <davids@...515...>
---
 dev-tools/lz4-rebaser.sh | 69 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)
 create mode 100755 dev-tools/lz4-rebaser.sh

diff --git a/dev-tools/lz4-rebaser.sh b/dev-tools/lz4-rebaser.sh
new file mode 100755
index 0000000..b565735
--- /dev/null
+++ b/dev-tools/lz4-rebaser.sh
@@ -0,0 +1,69 @@
+#!/bin/sh
+# lz4-rebaser.sh   - Does the LZ4 rebase process in an automated fashion
+#
+# Copyright (C) 2017      David Sommerseth <davids@...515...>
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
+    echo "Usage: $0 <Path to upstream LZ4 source tree>"
+    exit 1
+fi
+
+# Check that we have the files we need before starting the rebase
+LZ4_C="$1/lib/lz4.c"
+LZ4_H="$1/lib/lz4.h"
+if [ ! -r "$LZ4_C" -o ! -r "$LZ4_H" ]; then
+    echo "Could not locate $LZ4_H and/or $LZ4_C"
+    exit 1
+fi
+
+# Extract the upstream LZ4 commit base
+lz4_tag="$(git --git-dir $1/.git tag --contains HEAD)"
+lz4_commit="$(git --git-dir $1/.git rev-parse --short=20 HEAD)"
+
+# Do the rebase
+srcroot="$(git rev-parse --show-toplevel)"
+echo "* Copying upstream lz4.h to compat-lz4.h"
+cp "$LZ4_H" "${srcroot}/src/compat/compat-lz4.h"
+
+echo "* Porting upstream lz4.c to compat-lz4.c"
+{
+    cat <<EOF
+/* This file have been backported by $0
+ * from upstream lz4 commit $lz4_commit ($lz4_tag)
+ */
+ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#ifdef NEED_COMPAT_LZ4
+EOF
+    sed '/"lz4\.h"/s/\(#include "\)lz4\.h\("\+\)/\1compat-lz4.h\2/' "$LZ4_C"
+cat <<EOF
+#endif /* NEED_COMPAT_LZ4 */
+EOF
+} > "${srcroot}/src/compat/compat-lz4.c"
+
+echo "* Running 'git add'"
+git add src/compat/compat-lz4.[ch]
+
-- 
2.11.0


