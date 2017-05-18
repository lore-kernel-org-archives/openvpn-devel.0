From: David Sommerseth <davids@...515...>
Date: Thu, 18 May 2017 15:24:32 +0200
Message-Id: <20170518132432.22776-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] dev-tools: Script generating the source
	releases in an automated fashion
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

As we've had an ugly blunder with the v2.3.15 release, this release
tries to avoid making the same mistake once again.  Plus it documents
how we produce the source packages.

Signed-off-by: David Sommerseth <davids@...515...>
---
 dev-tools/gen-release-tarballs.sh | 248 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 248 insertions(+)
 create mode 100755 dev-tools/gen-release-tarballs.sh

diff --git a/dev-tools/gen-release-tarballs.sh b/dev-tools/gen-release-tarballs.sh
new file mode 100755
index 00000000..4969d72a
--- /dev/null
+++ b/dev-tools/gen-release-tarballs.sh
@@ -0,0 +1,248 @@
+#!/bin/sh
+# gen-release-tarballs.sh  -  Generates release tarballs with signatures
+#
+# Copyright (C) 2017 - David Sommerseth <davids@...515...>
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
+set -u
+
+if [ $# -ne 4 ]; then
+    echo "Usage: $0 <remote-name> <tag-name> <sign-key> <dest-dir>"
+    echo ""
+    echo "   remote-name  -- valid remotes: `git remote | tr \\\n ' '`"
+    echo "   tag-name     -- An existing release tag"
+    echo "   sign-key     -- PGP key used to sign all files"
+    echo "   dest-dir     -- Where to put the complete set of release tarballs"
+    echo ""
+    echo "   Example: $0 origin v2.4.2 /tmp/openvpn-release"
+    echo
+    exit 1
+fi
+
+arg_remote_name="$1"
+arg_tag_name="$2"
+arg_sign_key="$3"
+arg_dest_dir="$4"
+
+#
+# Sanity checks
+#
+
+# Check that the tag exists
+git tag | grep "$arg_tag_name" 1>/dev/null
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  The tag '$arg_tag_name' does not exist"
+    exit 2
+fi
+
+# Extract the git URL
+giturl="`git remote get-url $arg_remote_name 2>/dev/null`"
+if [ $? -ne 0 ]; then
+    echo "** ERROR ** Invalid git remote name: $arg_remote_name"
+    exit 2
+fi
+
+# Check we have the needed signing key
+echo "test" | gpg -a --clearsign -u "$arg_sign_key" 2>/dev/null 1>/dev/null
+if [ $? -ne 0 ]; then
+    echo "** ERROR ** Failed when testing the PGP signing.  Wrong signing key?"
+    exit 2;
+fi
+
+
+#
+# Helper functions
+#
+
+get_filename()
+{
+    local wildcard="$1"
+
+    res="`find . -maxdepth 1 -type f -name \"$wildcard\" | head -n1 | cut -d/ -f2-`"
+    if [ $? -ne 0 ]; then
+        echo "-- 'find' failed."
+        exit 5
+    fi
+    if [ -z "$res" ]; then
+        echo "-- Could not find a file with the wildcard: $wildcard"
+        exit 4
+    fi
+    echo "$res"
+}
+
+copy_files()
+{
+    local fileext="$1"
+    local dest="$2"
+
+    file="`get_filename openvpn-*.*.*.$fileext`"
+    if [ -z "$file" ]; then
+        echo "** ERROR Failed to find source file"
+        exit 5
+    fi
+    echo "-- Copying $file"
+    cp "$file" "$dest"
+    if [ $? -ne 0 ]; then
+        echo "** ERROR ** Failed to copy $file to $destdir"
+        exit 3;
+    fi
+}
+
+sign_file()
+{
+    local signkey="$1"
+    local srchfile="$2"
+    local signtype="$3"
+    local file="`get_filename $srchfile`"
+
+    echo "-- Signing $file ..."
+    case "$signtype" in
+        inline)
+            # Have the signature in the same file as the data
+            gpg -a --clearsign -u "$signkey" "$file" 2>/dev/null
+            res=$?
+            if [ $res -eq 0 ]; then
+                rm -f "$file"
+            fi
+            ;;
+
+        detached)
+            # Have the signature in a separate file
+            gpg -a --detach-sign -u "$signkey" "$file" 2>/dev/null
+            res=$?
+            ;;
+
+        *)
+            echo "** ERROR **  Unknown signing type \"$signtype\"."
+            exit 4;
+    esac
+
+    if [ $res -ne 0 ]; then
+        echo "** ERROR **  Failed to sign the file $PWD/$file"
+        exit 4;
+    fi
+}
+
+
+#
+# Preparations
+#
+
+# Create the destination directory, using a sub-dir with the tag-name
+destdir=""
+case "$arg_dest_dir" in
+    /*) # Absolute path
+        destdir="$arg_dest_dir/$arg_tag_name"
+        ;;
+    *)  # Make absolute path from relative path
+        destdir="$PWD/$arg_dest_dir/$arg_tag_name"
+        ;;
+esac
+echo "-- Destination directory: $destdir"
+if [ -e "$destdir" ]; then
+    echo "** ERROR ** Destination directory already exists.  "
+    echo "            Please check your command line carefully."
+    exit 2
+fi
+
+mkdir -p "$destdir"
+if [ $? -ne 0 ]; then
+    echo "** ERROR ** Failed to create destination directory"
+    exit 2
+fi
+
+#
+# Start the release process
+#
+
+# Clone the remote repository
+workdir="`mktemp -d -p /var/tmp openvpn-build-release-XXXXXX`"
+cd $workdir
+echo "-- Working directory: $workdir"
+echo "-- git clone $giturl"
+git clone $giturl openvpn-gen-tarball 2> "$workdir/git-clone.log" 1>&2
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  git clone failed.  See $workdir/git-clone.log for details"
+    exit 3;
+fi
+cd openvpn-gen-tarball
+
+# Check out the proper release tag
+echo "-- Checking out tag $arg_tag_name ... "
+git checkout -b mkrelease "$arg_tag_name" 2> "$workdir/git-checkout-tag.log" 1>&2
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  git checkout failed.  See $workdir/git-checkout-tag.log for details"
+    exit 3;
+fi
+
+# Prepare the source tree
+echo "-- Running autoreconf + a simple configure ... "
+(autoreconf -vi && ./configure) 2> "$workdir/autotools-prep.log" 1>&2
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  Failed running autotools.  See $workdir/autotools-prep.log for details"
+    exit 3;
+fi
+
+# Generate the tar/zip files
+echo "-- Running make distcheck (generates .tar.gz) ... "
+(make distcheck) 2> "$workdir/make-distcheck.log" 1>&2
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  make distcheck failed.  See $workdir/make-distcheck.log for details"
+    exit 3;
+fi
+copy_files tar.gz "$destdir"
+
+echo "-- Running make dist-xz (generates .tar.xz) ... "
+(make dist-xz) 2> "$workdir/make-dist-xz.log" 1>&2
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  make dist-xz failed.  See $workdir/make-dist-xz.log for details"
+    exit 3;
+fi
+copy_files tar.xz "$destdir"
+
+echo "-- Running make dist-zip (generates .zip) ... "
+(make dist-zip) 2> "$workdir/make-dist-zip.log" 1>&2
+if [ $? -ne 0 ]; then
+    echo "** ERROR **  make dist-zip failed.  See $workdir/make-dist-zip.log for details"
+    exit 3;
+fi
+copy_files zip "$destdir"
+
+# Generate SHA256 checksums
+cd "$destdir"
+sha256sum openvpn-*.tar.{gz,xz} openvpn-*.zip > "openvpn-$arg_tag_name.sha256sum"
+
+# Sign all the files
+echo "-- Signing files ... "
+sign_file "$arg_sign_key" "openvpn-$arg_tag_name.sha256sum" inline
+sign_file "$arg_sign_key" "openvpn-*.tar.gz" detached
+sign_file "$arg_sign_key" "openvpn-*.tar.xz" detached
+sign_file "$arg_sign_key" "openvpn-*.zip" detached
+
+# Create a tar-bundle with everything
+echo "-- Creating final tarbundle with everything ..."
+tar cf "openvpn-$arg_tag_name.tar" openvpn-*.{tar.gz,tar.xz,zip}{,.asc} openvpn-*.sha256sum.asc
+
+echo "-- Cleaning up ..."
+# Save the log files
+mkdir -p "$destdir/logs"
+mv $workdir/*.log "$destdir/logs"
+
+# Finally, done!
+rm -rf "$workdir"
+echo "-- Done"
+exit 0
+
-- 
2.11.0


