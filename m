From: Heiko Hund <heiko@...2662...>
Date: Thu, 21 Apr 2022 01:31:48 +0200
Message-Id: <20220420233148.2384208-1-heiko@...2662...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add git pre-commit hook script to uncrustify
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

The script is self installing if you call it with "install" as the first
parameter. Once installed as the pre-commit hook it will check files to
be committed according to the rules in uncrustify.conf and abort the
commit if there's formatting issues. The script produces a patch in /tmp
which can be git apply'ed to fix all issues found.

The script was originally authored by David Martin [1] and slightly
modified to fit our needs. At the time it had a 2-clause BSD license.

[1] https://github.com/ddddavidmartin/Pre-commit-hooks

Signed-off-by: Heiko Hund <heiko@...2662...>
---
 dev-tools/git-pre-commit-uncrustify.sh | 146 +++++++++++++++++++++++++
 1 file changed, 146 insertions(+)
 create mode 100644 dev-tools/git-pre-commit-uncrustify.sh

diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-commit-uncrustify.sh
new file mode 100644
index 00000000..64e5e396
--- /dev/null
+++ b/dev-tools/git-pre-commit-uncrustify.sh
@@ -0,0 +1,146 @@
+#!/bin/sh
+
+# git pre-commit hook that runs an Uncrustify stylecheck.
+# Features:
+#  - abort commit when commit does not comply with the style guidelines
+#  - create a patch of the proposed style changes
+#
+# More info on Uncrustify: http://uncrustify.sourceforge.net/
+
+# This file was taken from a set of unofficial pre-commit hooks available
+# at https://github.com/ddddavidmartin/Pre-commit-hooks and modified to
+# fit the openvpn project's needs
+
+# exit on error
+set -e
+
+
+# If called so, install this script as pre-commit hook
+if [ "$1" = "install" ] ; then
+    ROOTDIR=$(git rev-parse --show-toplevel)
+    HOOKSDIR="$ROOTDIR/.git/hooks"
+    TARGET="$HOOKSDIR/pre-commit"
+
+    if [ -e "$TARGET" ] ; then
+        printf "$TARGET file exists. Won't overwrite.\n"
+        printf "Aborting installation.\n"
+        exit 1
+    fi
+
+    read -p "Install as $TARGET? [y/N] " INPUT
+    [ "$INPUT" = "y" ] || exit 0
+    cp "$0" "$TARGET"
+    chmod +x $TARGET
+    exit 0
+fi
+
+# check whether the given file matches any of the set extensions
+matches_extension() {
+    local filename="$(basename -- "$1")"
+    local extension=".${filename##*.}"
+    local ext
+
+    for ext in .c .h ; do [ "$ext" = "$extension" ] && return 0; done
+
+    return 1
+}
+
+# necessary check for initial commit
+if git rev-parse --verify HEAD >/dev/null 2>&1 ; then
+    against=HEAD
+else
+    # Initial commit: diff against an empty tree object
+    against=4b825dc642cb6eb9a060e54bf8d69288fbee4904
+fi
+
+UNCRUSTIFY=$(command -v uncrustify)
+UNCRUST_CONFIG="$PWD/dev-tools/uncrustify.conf"
+
+# make sure the config file and executable are correctly set
+if [ ! -f "$UNCRUST_CONFIG" ] ; then
+    printf "Error: uncrustify config file not found.\n"
+    printf "Expected to find it at $UNCRUST_CONFIG.\n"
+    printf "Aborting commit.\n"
+    exit 1
+fi
+
+if [ -z "$UNCRUSTIFY" ] ; then
+    printf "Error: uncrustify executable not found.\n"
+    printf "Is it installed and in your \$PATH?\n"
+    printf "Aborting commit.\n"
+    exit 1
+fi
+
+# create a filename to store our generated patch
+prefix="ovpn-fmt"
+suffix="$(date +%C%y%m%d%H%M%S)"
+patch="/tmp/$prefix-$suffix.patch"
+
+# create one patch containing all changes to the files
+# sed to remove quotes around the filename, if inserted by the system
+# (done sometimes, if the filename contains special characters, like the quote itself)
+git diff-index --cached --diff-filter=ACMR --name-only $against -- | \
+sed -e 's/^"\(.*\)"$/\1/' | \
+while read file
+do
+    # ignore file if we do check for file extensions and the file
+    # does not match any of the extensions specified in $FILE_EXTS
+    if ! matches_extension "$file"; then
+        continue;
+    fi
+
+    # escape special characters in the source filename:
+    # - '\': backslash needs to be escaped
+    # - '*': used as matching string => '*' would mean expansion
+    #        (curiously, '?' must not be escaped)
+    # - '[': used as matching string => '[' would mean start of set
+    # - '|': used as sed split char instead of '/', so it needs to be escaped
+    #        in the filename
+    # printf %s particularly important if the filename contains the % character
+    file_escaped_source=$(printf "%s" "$file" | sed -e 's/[\*[|]/\\&/g')
+
+    # escape special characters in the target filename:
+    # phase 1 (characters escaped in the output diff):
+    #     - '\': backslash needs to be escaped in the output diff
+    #     - '"': quote needs to be escaped in the output diff if present inside
+    #            of the filename, as it used to bracket the entire filename part
+    # phase 2 (characters escaped in the match replacement):
+    #     - '\': backslash needs to be escaped again for sed itself
+    #            (i.e. double escaping after phase 1)
+    #     - '&': would expand to matched string
+    #     - '|': used as sed split char instead of '/'
+    # printf %s particularly important if the filename contains the % character
+    file_escaped_target=$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e 's/[\&|]/\\&/g')
+
+    # uncrustify our sourcefile, create a patch with diff and append it to our $patch
+    # The sed call is necessary to transform the patch from
+    #    --- $file timestamp
+    #    +++ - timestamp
+    # to both lines working on the same file and having a a/ and b/ prefix.
+    # Else it can not be applied with 'git apply'.
+    "$UNCRUSTIFY" -q -c "$UNCRUST_CONFIG" -f "$file" | \
+        diff -u -- "$file" - | \
+        sed -e "1s|--- $file_escaped_source|--- \"a/$file_escaped_target\"|" -e "2s|+++ -|+++ \"b/$file_escaped_target\"|" >> "$patch"
+done
+
+# if no patch has been generated all is ok, clean up the file stub and exit
+if [ ! -s "$patch" ] ; then
+    rm -f "$patch"
+    exit 0
+fi
+
+# a patch has been created, notify the user and exit
+printf "Formatting of some code does not follow the project guidelines.\n"
+
+if [ $(wc -l < $patch) -gt 80 ] ; then
+    printf "The file $patch contains the necessary fixes.\n"
+else
+    printf "Here's the patch that fixes the formatting:\n\n"
+    cat $patch
+fi
+
+printf "\nYou can apply these changes with:\n git apply $patch\n"
+printf "(from the root directory of the repository) and then commit again.\n"
+printf "\nAborting commit.\n"
+
+exit 1
-- 
2.32.0


