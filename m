From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 May 2025 11:27:55 +0000
In-Reply-To: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
References: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <98bdda39b52fa85faa12f12b686f47b365770575-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Dz7Rvk91Le4="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove uncrustify
 config and scripts, switch GHA
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Dz7Rvk91Le4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail

to look at the new patch set (#10).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Remove uncrustify config and scripts, switch GHA
......................................................................

Remove uncrustify config and scripts, switch GHA

Replaced with clang-format and pre-commit.

Add a README file that explains how to use pre-commit
and how to combine this with the old hook.

Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
A dev-tools/README.precommit.md
D dev-tools/git-pre-commit-uncrustify.sh
D dev-tools/reformat-all.sh
D dev-tools/special-files.lst
D dev-tools/uncrustify.conf
6 files changed, 42 insertions(+), 402 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/830/10

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d4fdc9d..37c09fe 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -5,35 +5,26 @@
   pull_request:

 jobs:
-  checkuncrustify:
-    name: "Check code style with Uncrustify"
-    # Ubuntu 22.04 has uncrustify 0.72_f
-    runs-on: ubuntu-22.04
+  clang-format:
+    name: Check code style with clang-format
+    runs-on: ubuntu-24.04
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y uncrustify
+        run: |
+          sudo apt update && sudo apt install -y python3-pip
+          pip3 install pre-commit
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2
-        with:
-          path: openvpn
-      - name: Show uncrustify version
-        run: uncrustify --version
-      - name: Run uncrustify
-        run: ./dev-tools/reformat-all.sh
-        working-directory: openvpn
+      - name: Run clang-format
+        run: pre-commit run -a --show-diff-on-failure || true
       - name: Check for changes
-        run: git diff --output=3Duncrustify-changes.patch
-        working-directory: openvpn
-      - name: Show changes on standard output
-        run: git diff
-        working-directory: openvpn
+        run: git diff --output=3Dformat-changes.patch
       - uses: actions/upload-artifact@...2868... # v4.6.2
         with:
-          name: uncrustify-changes.patch
-          path: 'openvpn/uncrustify-changes.patch'
+          name: format-changes.patch
+          path: format-changes.patch
       - name: Set job status
-        run: test ! -s uncrustify-changes.patch
-        working-directory: openvpn
+        run: test ! -s format-changes.patch

   android:
     strategy:
diff --git a/dev-tools/README.precommit.md b/dev-tools/README.precommit.md
new file mode 100644
index 0000000..fe01058
--- /dev/null
+++ b/dev-tools/README.precommit.md
@@ -0,0 +1,30 @@
+How to use pre-commit hooks in openvpn repository
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
+
+openvpn comes with a .pre-commit-config.yaml which can be used
+with https://pre-commit.com/
+
+To install the pre-commit hook you can just use
+
+    pip install pre-commit
+    pre-commit install
+
+This will enable the pre-commit checks which currently only
+consists of a clang-format formatting check.
+
+**However**, in older branches, up to and including release/2.6
+we had a different pre-commit hook
+`dev-tools/git-pre-commit-uncrustify.sh` that implemented a
+formatting check based on the uncrustify tool.
+
+If you want to use both pre-commit hooks you can use the following
+installation:
+
+    rm .git/hooks/pre-commit # make sure to start fresh
+    git checkout release/2.6
+    ./dev-tools/git-pre-commit-uncrustify.sh install
+    git checkout master
+    pre-commit install --allow-missing-config
+
+This will run both hooks every time you commit but the "wrong" hook
+will be skipped.
diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-com=
mit-uncrustify.sh
deleted file mode 100755
index 9851c21..0000000
--- a/dev-tools/git-pre-commit-uncrustify.sh
+++ /dev/null
@@ -1,161 +0,0 @@
-#!/bin/sh
-
-# Copyright (c) 2015, David Martin
-#               2022, Heiko Hund
-# All rights reserved.
-#
-# Redistribution and use in source and binary forms, with or without
-# modification, are permitted provided that the following conditions are m=
et:
-#
-# * Redistributions of source code must retain the above copyright notice,=
 this
-#   list of conditions and the following disclaimer.
-#
-# * Redistributions in binary form must reproduce the above copyright noti=
ce,
-#   this list of conditions and the following disclaimer in the documentat=
ion
-#   and/or other materials provided with the distribution.
-#
-# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS =
IS"
-# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPO=
SE ARE
-# DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LI=
ABLE
-# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTI=
AL
-# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS =
OR
-# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEV=
ER
-# CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABI=
LITY,
-# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF TH=
E USE
-# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
-
-
-# git pre-commit hook that runs an Uncrustify stylecheck.
-# Features:
-#  - abort commit when commit does not comply with the style guidelines
-#  - create a patch of the proposed style changes
-#
-# More info on Uncrustify: http://uncrustify.sourceforge.net/
-
-# This file was taken from a set of unofficial pre-commit hooks available
-# at https://github.com/ddddavidmartin/Pre-commit-hooks and modified to
-# fit the openvpn project's needs
-
-# exit on error
-set -e
-
-
-# If called so, install this script as pre-commit hook
-if [ "$1" =3D "install" ] ; then
-    TARGET=3D"$(git rev-parse --git-path hooks)/pre-commit"
-
-    if [ -e "$TARGET" ] ; then
-        printf "$TARGET file exists. Won't overwrite.\n"
-        printf "Aborting installation.\n"
-        exit 1
-    fi
-
-    read -p "Install as $TARGET? [y/N] " INPUT
-    [ "$INPUT" =3D "y" ] || exit 0
-    cp "$0" "$TARGET"
-    chmod +x $TARGET
-    exit 0
-fi
-
-# check whether the given file matches any of the set extensions
-matches_extension() {
-    local filename=3D"$(basename -- "$1")"
-    local extension=3D".${filename##*.}"
-    local ext
-
-    for ext in .c .h ; do [ "$ext" =3D "$extension" ] && return 0; done
-
-    return 1
-}
-
-# necessary check for initial commit
-if git rev-parse --verify HEAD >/dev/null 2>&1 ; then
-    against=3DHEAD
-else
-    # Initial commit: diff against an empty tree object
-    against=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
-fi
-
-UNCRUSTIFY=3D$(command -v uncrustify)
-UNCRUST_CONFIG=3D"$(git rev-parse --show-toplevel)/dev-tools/uncrustify.co=
nf"
-
-# make sure the config file and executable are correctly set
-if [ ! -f "$UNCRUST_CONFIG" ] ; then
-    printf "Error: uncrustify config file not found.\n"
-    printf "Expected to find it at $UNCRUST_CONFIG.\n"
-    printf "Aborting commit.\n"
-    exit 1
-fi
-
-if [ -z "$UNCRUSTIFY" ] ; then
-    printf "Error: uncrustify executable not found.\n"
-    printf "Is it installed and in your \$PATH?\n"
-    printf "Aborting commit.\n"
-    exit 1
-fi
-
-# create a filename to store our generated patch
-patch=3D$(mktemp /tmp/ovpn-fmt-XXXXXX)
-tmpout=3D$(mktemp /tmp/uncrustify-XXXXXX)
-
-# create one patch containing all changes to the files
-# sed to remove quotes around the filename, if inserted by the system
-# (done sometimes, if the filename contains special characters, like the q=
uote itself)
-git diff-index --cached --diff-filter=3DACMR --name-only $against -- | \
-sed -e 's/^"\(.*\)"$/\1/' | \
-while read file
-do
-    # ignore file if we do check for file extensions and the file
-    # does not match the extensions .c or .h
-    if ! matches_extension "$file"; then
-        continue;
-    fi
-
-    # escape special characters in the target filename:
-    # phase 1 (characters escaped in the output diff):
-    #     - '\': backslash needs to be escaped in the output diff
-    #     - '"': quote needs to be escaped in the output diff if present i=
nside
-    #            of the filename, as it used to bracket the entire filenam=
e part
-    # phase 2 (characters escaped in the match replacement):
-    #     - '\': backslash needs to be escaped again for sed itself
-    #            (i.e. double escaping after phase 1)
-    #     - '&': would expand to matched string
-    #     - '|': used as sed split char instead of '/'
-    # printf %s particularly important if the filename contains the % char=
acter
-    file_escaped_target=3D$(printf "%s" "$file" | sed -e 's/[\"]/\\&/g' -e=
 's/[\&|]/\\&/g')
-
-    # uncrustify our sourcefile, create a patch with diff and append it to=
 our $patch
-    # The sed call is necessary to transform the patch from
-    #    --- - timestamp
-    #    +++ $tmpout timestamp
-    # to both lines working on the same file and having a a/ and b/ prefix.
-    # Else it can not be applied with 'git apply'.
-    git show ":$file" | "$UNCRUSTIFY" -q -l C -c "$UNCRUST_CONFIG" -o "$tm=
pout"
-    git show ":$file" | diff -u -- - "$tmpout" | \
-        sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpo=
ut|+++ \"a/$file_escaped_target\"|" >> "$patch"
-done
-
-rm -f "$tmpout"
-
-# if no patch has been generated all is ok, clean up the file stub and exit
-if [ ! -s "$patch" ] ; then
-    rm -f "$patch"
-    exit 0
-fi
-
-# a patch has been created, notify the user and exit
-printf "Formatting of some code does not follow the project guidelines.\n"
-
-if [ $(wc -l < $patch) -gt 80 ] ; then
-    printf "The file $patch contains the necessary fixes.\n"
-else
-    printf "Here's the patch that fixes the formatting:\n\n"
-    cat $patch
-fi
-
-printf "\nYou can apply these changes with:\n git apply $patch\n"
-printf "(from the root directory of the repository) and then commit again.=
\n"
-printf "\nAborting commit.\n"
-
-exit 1
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
deleted file mode 100755
index 42d7368..0000000
--- a/dev-tools/reformat-all.sh
+++ /dev/null
@@ -1,136 +0,0 @@
-#!/bin/sh
-# reformat-all.sh - Reformat all git files in the checked out
-#                   git branch using uncrustify.
-#
-# Copyright (C) 2016-2024 - David Sommerseth <davids@...515...>
-#
-# This program is free software; you can redistribute it and/or
-# modify it under the terms of the GNU General Public License
-# as published by the Free Software Foundation; either version 2
-# of the License.
-#
-# This program is distributed in the hope that it will be useful,
-# but WITHOUT ANY WARRANTY; without even the implied warranty of
-# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-# GNU General Public License for more details.
-#
-# You should have received a copy of the GNU General Public License
-# along with this program; if not, write to the Free Software
-# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-130=
1, USA.
-#
-
-tstamp=3D"$(date +%Y%m%d-%H%M%S)"
-files=3D"$(pwd)/reformat-all_files-$tstamp.lst"
-log=3D"$(pwd)/reformat-all_log-$tstamp.txt"
-
-srcroot=3D"$(git rev-parse --show-toplevel)"
-cfg=3D"$srcroot/dev-tools/uncrustify.conf"
-specialfiles=3D"$srcroot/dev-tools/special-files.lst"
-
-export gitfiles=3D0
-export procfiles=3D0
-
-# Go to the root of the source tree
-cd "$srcroot"
-
-{
-    echo -n "** Starting $0: "
-    date
-
-    # Find all C source/header files
-    git ls-files | grep -E ".*\.[ch](\.in$|$)" > "${files}.git"
-
-    # Manage files which needs special treatment
-    awk -F\# '{gsub("\n| ", "", $1); print $1}' "$specialfiles" > "${files=
}.sp"
-    while read srcfile
-    do
-        res=3D$(grep "$srcfile" "${files}.sp" 2>/dev/null)
-        if [ $? -ne 0 ]; then
-            # If grep didn't find the file among special files,
-            # process it normally
-            echo "$srcfile" >> "$files"
-        else
-            mode=3D$(echo "$res" | cut -d:  -f1)
-            case "$mode" in
-                E)
-                    echo "** INFO **  Excluding '$srcfile'"
-                    ;;
-                P)
-                    echo "** INFO **  Pre-patching '$srcfile'"
-                    patchfile=3D"${srcroot}"/dev-tools/reformat-patches/be=
fore_$(echo "$srcfile" | tr "/" "_").patch
-                    if [ -r "$patchfile" ]; then
-                        git apply "$patchfile"
-                        if [ $? -ne 0 ]; then
-                            echo "** ERROR **  Failed to apply pre-patch f=
ile: $patchfile"
-                            exit 2
-                        fi
-                    else
-                        echo "** WARN ** Pre-patch file for $srcfile is mi=
ssing: $patchfile"
-                    fi
-                    echo "$srcfile" >> "${files}.postpatch"
-                    echo "$srcfile" >> "$files"
-                    ;;
-                *)
-                    echo "** WARN ** Unknown mode '$mode' for file '$srcfi=
le'"
-                    ;;
-            esac
-        fi
-    done < "${files}.git"
-    rm -f "${files}.git" "${files}.sp"
-
-    # Kick off uncrustify
-    echo
-    echo "** INFO ** Running: uncrustify -c $cfg --no-backup -l C -F $file=
s"
-    uncrustify -c "$cfg" --no-backup -l C -F "$files" 2>&1
-    res=3D$?
-    echo "** INFO ** Uncrustify completed (exit code $res)"
-} | tee "${log}-1"  # Log needs to be closed here, to be processed in next=
 block
-
-{
-    # Check the results
-    gitfiles=3D$(wc -l "$files" | cut -d\  -f1)
-    procfiles=3D$(grep "Parsing: " "${log}-1" | wc -l)
-    echo
-    echo "C source/header files checked into git: $gitfiles"
-    echo "Files processed by uncrustify:          $procfiles"
-    echo
-
-    # Post-Patch files modified after we uncrustify have adjusted them
-    if [ -r "${files}.postpatch" ]; then
-        while read srcfile;
-        do
-            patchfile=3D"${srcroot}"/dev-tools/reformat-patches/after_$(ec=
ho "$srcfile" | tr "/" "_").patch
-            if [ -r "$patchfile" ]; then
-                echo "** INFO **  Post-patching '$srcfile'"
-                git apply "$patchfile"
-                if [ $? -ne 0 ]; then
-                    echo "** WARN ** Failed to apply $patchfile"
-                fi
-            else
-                echo "** WARN ** Post-patch file for $srcfile is missing: =
$patchfile"
-            fi
-        done < "${files}.postpatch"
-        rm -f "${files}.postpatch"
-    fi
-} | tee "${log}-2" # Log needs to be closed here, to be processed in next =
block
-
-cat "${log}-1" "${log}-2" > "$log"
-
-{
-    ec=3D1
-    echo
-    if [ "$gitfiles" -eq "$procfiles" ]; then
-        echo "Reformatting completed successfully"
-        ec=3D0
-    else
-        last=3D$(tail -n1 "${log}-1")
-        echo "** ERROR ** Reformating failed to process all files."
-        echo "            uncrustify exit code: $res"
-        echo "            Last log line: $last"
-        echo
-    fi
-    rm -f "${log}-1" "${log}-2"
-} | tee -a "$log"
-rm -f "${files}"
-
-exit $ec
diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
deleted file mode 100644
index e5f2fc2..0000000
--- a/dev-tools/special-files.lst
+++ /dev/null
@@ -1,5 +0,0 @@
-E:doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated=
, exclude it
-E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
-E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
-E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream format=
ting
-E:src/openvpn/ovpn_dco_win.h           # Preserve ovpn-dco-win upstream fo=
rmatting
diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
deleted file mode 100644
index 325f310..0000000
--- a/dev-tools/uncrustify.conf
+++ /dev/null
@@ -1,79 +0,0 @@
-# Use Allman-style
-indent_columns=3D4
-indent_braces=3Dfalse
-indent_else_if=3Dfalse
-indent_switch_case=3D4
-indent_label=3D1
-nl_if_brace=3Dadd
-nl_brace_else=3Dadd
-nl_elseif_brace=3Dadd
-nl_else_brace=3Dadd
-nl_else_if=3Dremove
-nl_for_brace=3Dadd
-nl_while_brace=3Dadd
-nl_switch_brace=3Dadd
-nl_fdef_brace=3Dadd
-nl_do_brace=3Dadd
-sp_func_proto_paren=3DRemove
-sp_func_def_paren=3DRemove
-sp_func_call_paren=3DRemove
-sp_sizeof_paren=3DRemove
-
-# No tabs, spaces only
-indent_with_tabs=3D0
-align_with_tabs=3Dfalse
-cmt_convert_tab_to_spaces=3Dtrue
-
-# Do not put spaces between the # and preprocessor statements
-pp_space=3Dremove
-
-# Various whitespace fiddling
-sp_assign=3Dadd
-sp_before_sparen=3Dadd
-sp_inside_sparen=3Dremove
-sp_cond_colon=3Dadd
-sp_cond_question=3Dadd
-sp_bool=3Dadd
-sp_else_brace=3Dadd
-sp_brace_else=3Dadd
-sp_after_comma=3Dadd
-pos_arith=3DLead
-pos_bool=3DLead
-nl_func_type_name=3Dadd
-nl_before_case=3Dtrue
-nl_assign_leave_one_liners=3Dtrue
-nl_enum_leave_one_liners=3Dtrue
-nl_brace_fparen=3Dadd
-nl_max=3D4
-nl_after_func_proto=3D2
-nl_end_of_file_min=3D1
-nl_end_of_file=3Dforce
-
-# Always use scoping braces for conditionals
-mod_full_brace_if=3Dadd
-mod_full_brace_if_chain=3Dfalse
-mod_full_brace_while=3Dadd
-mod_full_brace_for=3Dadd
-mod_full_brace_do=3Dadd
-
-# Annotate #else and #endif statements
-mod_add_long_ifdef_endif_comment=3D20
-mod_add_long_ifdef_else_comment=3D5
-
-# Misc cleanup
-mod_remove_extra_semicolon=3Dtrue
-
-# leave blank at end of empty for() statements
-sp_after_semi_for_empty=3DAdd
-
-# Use C-style comments (/* .. */)
-cmt_c_nl_end=3Dtrue
-cmt_star_cont=3Dtrue
-cmt_cpp_to_c=3Dtrue
-
-# Use "char **a"-style pointer stars/dereferences
-sp_before_ptr_star=3DAdd
-sp_between_ptr_star=3DRemove
-sp_after_ptr_star=3DRemove
-sp_before_byref=3DAdd
-sp_after_byref=3DRemove

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54
Gerrit-Change-Number: 830
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--Dz7Rvk91Le4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>flichtenheld <strong>uploaded patch set #10</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove uncrustify config and scripts, switch GHA<br>=
<br>Replaced with clang-format and pre-commit.<br><br>Add a README file tha=
t explains how to use pre-commit<br>and how to combine this with the old ho=
ok.<br><br>Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/workf=
lows/build.yaml<br>A dev-tools/README.precommit.md<br>D dev-tools/git-pre-c=
ommit-uncrustify.sh<br>D dev-tools/reformat-all.sh<br>D dev-tools/special-f=
iles.lst<br>D dev-tools/uncrustify.conf<br>6 files changed, 42 insertions(+=
), 402 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/30/830/10</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml=
 b/.github/workflows/build.yaml</span><br><span>index d4fdc9d..37c09fe 1006=
44</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b=
/.github/workflows/build.yaml</span><br><span>@@ -5,35 +5,26 @@</span><br><=
span>   pull_request:</span><br><span> </span><br><span> jobs:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  checkuncrustify:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    name: &quot;Check code style with=
 Uncrustify&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
# Ubuntu 22.04 has uncrustify 0.72_f</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    runs-on: ubuntu-22.04</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  clang-format:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    name: Check code style with clang-format</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><=
br><span>     steps:</span><br><span>       - name: Install dependencies</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt up=
date &amp;&amp; sudo apt install -y uncrustify</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        run: |</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+          sudo apt update &amp;&amp; sudo apt install=
 -y python3-pip</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      pip3 install pre-commit</span><br><span>       - name: Checkout OpenV=
PN</span><br><span>         uses: actions/checkout@...2844... # v4.2.2</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        with:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          path: openvpn</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-      - name: Show uncrustify ve=
rsion</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: unc=
rustify --version</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  - name: Run uncrustify</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        run: ./dev-tools/reformat-all.sh</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        working-directory: openvpn</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      - name: Run clang-format</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        run: pre-commit run=
 -a --show-diff-on-failure || true</span><br><span>       - name: Check for=
 changes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: =
git diff --output=3Duncrustify-changes.patch</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        working-directory: openvpn</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - name: Show changes on standard =
output</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: gi=
t diff</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working=
-directory: openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        run: git diff --output=3Dformat-changes.patch</span><br><span>     =
  - uses: actions/upload-artifact@...2868... # v4.6.2</span><br><span>     =
    with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          na=
me: uncrustify-changes.patch</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          path: &#39;openvpn/uncrustify-changes.patch&#39;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+          name: format-change=
s.patch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          pa=
th: format-changes.patch</span><br><span>       - name: Set job status</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: test ! -s unc=
rustify-changes.patch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        working-directory: openvpn</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        run: test ! -s format-changes.patch</span><br><span>=
 </span><br><span>   android:</span><br><span>     strategy:</span><br><spa=
n>diff --git a/dev-tools/README.precommit.md b/dev-tools/README.precommit.m=
d</span><br><span>new file mode 100644</span><br><span>index 0000000..fe010=
58</span><br><span>--- /dev/null</span><br><span>+++ b/dev-tools/README.pre=
commit.md</span><br><span>@@ -0,0 +1,30 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+How to use pre-commit hooks in openvpn repository</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+openvpn comes with a .pre-commit-config.yaml which can be us=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+with https://pre-=
commit.com/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+To install the pre-commit h=
ook you can just use</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pip install pr=
e-commit</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pre-com=
mit install</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+This will enable the pre-co=
mmit checks which currently only</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+consists of a clang-format formatting check.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+**However**, in older branches, up to and including rele=
ase/2.6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+we had a dif=
ferent pre-commit hook</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+`dev-tools/git-pre-commit-uncrustify.sh` that implemented a</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+formatting check based on the un=
crustify tool.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+If you want to use both =
pre-commit hooks you can use the following</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+installation:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  rm .git/hooks/pre-commit # make sure to start fresh</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    git checkout release/2.6</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    ./dev-tools/git-pre-commit-u=
ncrustify.sh install</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    git checkout master</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    pre-commit install --allow-missing-config</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+This will run both hooks every time you commit but the &quot;wr=
ong&quot; hook</span><br><span style=3D"color: hsl(120, 100%, 40%);">+will =
be skipped.</span><br><span>diff --git a/dev-tools/git-pre-commit-uncrustif=
y.sh b/dev-tools/git-pre-commit-uncrustify.sh</span><br><span>deleted file =
mode 100755</span><br><span>index 9851c21..0000000</span><br><span>--- a/de=
v-tools/git-pre-commit-uncrustify.sh</span><br><span>+++ /dev/null</span><b=
r><span>@@ -1,161 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyright (c) 2015, David M=
artin</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#               =
2022, Heiko Hund</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# All=
 rights reserved.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# Redistribution and use=
 in source and binary forms, with or without</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# modification, are permitted provided that the foll=
owing conditions are met:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# * Redistributi=
ons of source code must retain the above copyright notice, this</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#   list of conditions and the fo=
llowing disclaimer.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# * Redistributions in=
 binary form must reproduce the above copyright notice,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#   this list of conditions and the follo=
wing disclaimer in the documentation</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#   and/or other materials provided with the distribution.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# THIS SOFTWARE IS PROVIDED BY THE COPYRIGH=
T HOLDERS AND CONTRIBUTORS &quot;AS IS&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, =
BUT NOT LIMITED TO, THE</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURP=
OSE ARE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# DISCLAIMED. =
IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# FOR ANY DIRECT, INDIRECT, INCI=
DENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMEN=
T OF SUBSTITUTE GOODS OR</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-# SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOW=
EVER</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# CAUSED AND ON A=
NY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# OR TORT (INCLUDING NEGLIGENCE OR=
 OTHERWISE) ARISING IN ANY WAY OUT OF THE USE</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-# OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBIL=
ITY OF SUCH DAMAGE.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# git pre-commit hook that runs an Uncrusti=
fy stylecheck.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Featu=
res:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  - abort commit=
 when commit does not comply with the style guidelines</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#  - create a patch of the proposed style =
changes</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# More info on Uncrustify: http://=
uncrustify.sourceforge.net/</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This file was=
 taken from a set of unofficial pre-commit hooks available</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-# at https://github.com/ddddavidmartin=
/Pre-commit-hooks and modified to</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# fit the openvpn project&#39;s needs</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-# exit on error</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-set -e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-# If called so, install this script as pre-commit hook</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ &quot;$1&quot; =3D=
 &quot;install&quot; ] ; then</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    TARGET=3D&quot;$(git rev-parse --git-path hooks)/pre-commit&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if [ -e &quot;$TARGET&quot; ] ; then=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        printf &quot;=
$TARGET file exists. Won&#39;t overwrite.\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        printf &quot;Aborting installation.\n&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        exit 1</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    read -p &quot;Install as $TARGET? [y/N] &quot; INPUT</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    [ &quot;$INPUT&quot; =
=3D &quot;y&quot; ] || exit 0</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    cp &quot;$0&quot; &quot;$TARGET&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    chmod +x $TARGET</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    exit 0</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# check whether the give=
n file matches any of the set extensions</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-matches_extension() {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    local filename=3D&quot;$(basename -- &quot;$1&quot;)=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local exten=
sion=3D&quot;.${filename##*.}&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    local ext</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for ext in =
.c .h ; do [ &quot;$ext&quot; =3D &quot;$extension&quot; ] &amp;&amp; retur=
n 0; done</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    return 1</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# necess=
ary check for initial commit</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-if git rev-parse --verify HEAD &gt;/dev/null 2&gt;&amp;1 ; then</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    against=3DHEAD</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    # Initial commit: diff against an empty tr=
ee object</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    against=
=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-UNCRUSTIFY=3D$(com=
mand -v uncrustify)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-UN=
CRUST_CONFIG=3D&quot;$(git rev-parse --show-toplevel)/dev-tools/uncrustify.=
conf&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# make sure the config file and =
executable are correctly set</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-if [ ! -f &quot;$UNCRUST_CONFIG&quot; ] ; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Error: uncrustify config f=
ile not found.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    printf &quot;Expected to find it at $UNCRUST_CONFIG.\n&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Aborting commi=
t.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 1<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-if [ -z &quot;$UNCRUSTIFY&quot; ] ; then</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Error: uncrustify executab=
le not found.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    printf &quot;Is it installed and in your \$PATH?\n&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Aborting commit.\n&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    exit 1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# create a filename to store our generated patch</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-patch=3D$(mktemp /tmp/ovpn-fmt-XXXXXX)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-tmpout=3D$(mktemp /tmp/=
uncrustify-XXXXXX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# create one patch conta=
ining all changes to the files</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# sed to remove quotes around the filename, if inserted by the sys=
tem</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# (done sometimes,=
 if the filename contains special characters, like the quote itself)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-git diff-index --cached --di=
ff-filter=3DACMR --name-only $against -- | \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-sed -e &#39;s/^&quot;\(.*\)&quot;$/\1/&#39; | \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-while read file</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-do</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    # ignore file if we do check for file extension=
s and the file</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # d=
oes not match the extensions .c or .h</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if ! matches_extension &quot;$file&quot;; then</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        continue;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    # escape special characters in the target filename:</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    # phase 1 (characters escaped in=
 the output diff):</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 #     - &#39;\&#39;: backslash needs to be escaped in the output diff</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;&quot;&#3=
9;: quote needs to be escaped in the output diff if present inside</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    #            of the filena=
me, as it used to bracket the entire filename part</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    # phase 2 (characters escaped in the match=
 replacement):</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #  =
   - &#39;\&#39;: backslash needs to be escaped again for sed itself</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    #            (i.e. doubl=
e escaping after phase 1)</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    #     - &#39;&amp;&#39;: would expand to matched string</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;|&#39;: used as =
sed split char instead of &#39;/&#39;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    # printf %s particularly important if the filename cont=
ains the % character</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   file_escaped_target=3D$(printf &quot;%s&quot; &quot;$file&quot; | sed -e=
 &#39;s/[\&quot;]/\\&amp;/g&#39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    # uncrustify our sourcefile, create a patch w=
ith diff and append it to our $patch</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    # The sed call is necessary to transform the patch from<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #    --- - timesta=
mp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #    +++ $tmpou=
t timestamp</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # to b=
oth lines working on the same file and having a a/ and b/ prefix.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    # Else it can not be applie=
d with &#39;git apply&#39;.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    git show &quot;:$file&quot; | &quot;$UNCRUSTIFY&quot; -q -l C -c =
&quot;$UNCRUST_CONFIG&quot; -o &quot;$tmpout&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    git show &quot;:$file&quot; | diff -u -- -=
 &quot;$tmpout&quot; | \</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        sed -e &quot;1s|--- -|--- \&quot;b/$file_escaped_target\&quot;|&=
quot; -e &quot;2s|+++ $tmpout|+++ \&quot;a/$file_escaped_target\&quot;|&quo=
t; &gt;&gt; &quot;$patch&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-done</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-rm -f &quot;$tmpout&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# if no patch has been generated all is ok, cl=
ean up the file stub and exit</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-if [ ! -s &quot;$patch&quot; ] ; then</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    rm -f &quot;$patch&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    exit 0</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# a patch has been =
created, notify the user and exit</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-printf &quot;Formatting of some code does not follow the projec=
t guidelines.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ $(wc -l &lt; $pa=
tch) -gt 80 ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   printf &quot;The file $patch contains the necessary fixes.\n&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Here&#39;s the patch that =
fixes the formatting:\n\n&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    cat $patch</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-printf &quot;\nYou can apply these ch=
anges with:\n git apply $patch\n&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-printf &quot;(from the root directory of the repository) a=
nd then commit again.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-printf &quot;\nAborting commit.\n&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-exit 1</span><br><span>diff --git a/dev-tools/reformat-all.sh b/dev-to=
ols/reformat-all.sh</span><br><span>deleted file mode 100755</span><br><spa=
n>index 42d7368..0000000</span><br><span>--- a/dev-tools/reformat-all.sh</s=
pan><br><span>+++ /dev/null</span><br><span>@@ -1,136 +0,0 @@</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# reformat-all.sh - Reformat all git files in t=
he checked out</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#      =
             git branch using uncrustify.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# Copyright (C) 2016-2024 - David Sommerseth &lt;davids@...515...&gt;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-# This program is free software; you can redist=
ribute it and/or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# mod=
ify it under the terms of the GNU General Public License</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-# as published by the Free Software Foun=
dation; either version 2</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-# of the License.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# This program is dis=
tributed in the hope that it will be useful,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# but WITHOUT ANY WARRANTY; without even the implied=
 warranty of</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# MERCHAN=
TABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-# GNU General Public License for more deta=
ils.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# You should have received a copy of =
the GNU General Public License</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# along with this program; if not, write to the Free Software</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# Foundation, Inc., 51 Fra=
nklin Street, Fifth Floor, Boston, MA  02110-1301, USA.</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tstamp=
=3D&quot;$(date +%Y%m%d-%H%M%S)&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-files=3D&quot;$(pwd)/reformat-all_files-$tstamp.lst&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-log=3D&quot;$(pwd)/refo=
rmat-all_log-$tstamp.txt&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-srcroot=3D&q=
uot;$(git rev-parse --show-toplevel)&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-cfg=3D&quot;$srcroot/dev-tools/uncrustify.conf&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-specialfiles=3D&quot;$s=
rcroot/dev-tools/special-files.lst&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ex=
port gitfiles=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-expo=
rt procfiles=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# Go to the root of the so=
urce tree</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cd &quot;$sr=
croot&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    echo -n &quot;** Starting $0: &quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    date</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    # Find all C source/header files</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    git ls-files | grep -E &quot;.*\.[ch](\.in$|$=
)&quot; &gt; &quot;${files}.git&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #=
 Manage files which needs special treatment</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    awk -F\# &#39;{gsub(&quot;\n| &quot;, &quot;&quot=
;, $1); print $1}&#39; &quot;$specialfiles&quot; &gt; &quot;${files}.sp&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while read srcf=
ile</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        res=3D$(grep &quot;$srcfi=
le&quot; &quot;${files}.sp&quot; 2&gt;/dev/null)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if [ $? -ne 0 ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            # If grep didn&#39;t find th=
e file among special files,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            # process it normally</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            echo &quot;$srcfile&quot; &gt;&gt; &quot;$fil=
es&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mode=3D$(e=
cho &quot;$res&quot; | cut -d:  -f1)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            case &quot;$mode&quot; in</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                E)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    echo &quot;** INFO **  Exc=
luding &#39;$srcfile&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    ;;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                P)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    echo &quot;** INFO **  Pre-patching &#39;$srcfi=
le&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            patchfile=3D&quot;${srcroot}&quot;/dev-tools/reformat-patches/b=
efore_$(echo &quot;$srcfile&quot; | tr &quot;/&quot; &quot;_&quot;).patch</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if =
[ -r &quot;$patchfile&quot; ]; then</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        git apply &quot;$patchfile&quot;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                        if=
 [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                          echo &quot;** ERROR **  Failed to apply pre-patch=
 file: $patchfile&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                            exit 2</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                        fi</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                        echo &quot;** WARN ** Pre-pa=
tch file for $srcfile is missing: $patchfile&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    fi</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    echo &quot;$srcfile&quo=
t; &gt;&gt; &quot;${files}.postpatch&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    echo &quot;$srcfile&quot; &gt;&gt;=
 &quot;$files&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                  ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               *)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                echo &quot;** WARN ** Unknown mode &#39;$mode&#39; for file=
 &#39;$srcfile&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                    ;;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            esac</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    done &l=
t; &quot;${files}.git&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    rm -f &quot;${files}.git&quot; &quot;${files}.sp&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    # Kick off uncrustify</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    echo</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    echo &quot;** INFO ** Running: uncrustify -c $cfg --no-bac=
kup -l C -F $files&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    uncrustify -c &quot;$cfg&quot; --no-backup -l C -F &quot;$files&quot=
; 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    res=
=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;*=
* INFO ** Uncrustify completed (exit code $res)&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-} | tee &quot;${log}-1&quot;  # Log needs t=
o be closed here, to be processed in next block</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Check the=
 results</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gitfiles=
=3D$(wc -l &quot;$files&quot; | cut -d\  -f1)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    procfiles=3D$(grep &quot;Parsing: &quot; &quot;=
${log}-1&quot; | wc -l)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &q=
uot;C source/header files checked into git: $gitfiles&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;Files processed by unc=
rustify:          $procfiles&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Post-Patch file=
s modified after we uncrustify have adjusted them</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    if [ -r &quot;${files}.postpatch&quot; ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while read=
 srcfile;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            patchfile=
=3D&quot;${srcroot}&quot;/dev-tools/reformat-patches/after_$(echo &quot;$sr=
cfile&quot; | tr &quot;/&quot; &quot;_&quot;).patch</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if [ -r &quot;$patchfile&quot; =
]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  echo &quot;** INFO **  Post-patching &#39;$srcfile&#39;&quot;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                git apply &quot;$=
patchfile&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    echo &quot;** WARN ** Failed to apply $patchf=
ile&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                echo=
 &quot;** WARN ** Post-patch file for $srcfile is missing: $patchfile&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            fi</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        done &lt; &quot;${fi=
les}.postpatch&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       rm -f &quot;${files}.postpatch&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-} | tee &quot;${log}-2&quot; # Log needs to be closed here, to be pr=
ocessed in next block</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cat &quot;${log}-1&qu=
ot; &quot;${log}-2&quot; &gt; &quot;$log&quot;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ec=3D1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if [ &quot;$gitfiles&quot; -eq &quot=
;$procfiles&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        echo &quot;Reformatting completed successfully&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ec=3D0</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        last=3D$(tail -n1 &quot;${log}-1&quot;)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;** ERRO=
R ** Reformating failed to process all files.&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        echo &quot;            uncrustify e=
xit code: $res&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       echo &quot;            Last log line: $last&quot;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        echo</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    rm -f &quot;${log}-1&quot; &quot;${log}-2&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-} | tee -a &quot;$log&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-rm -f &quot;${files}&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-exit $ec</span><br><span>diff --git a/dev-t=
ools/special-files.lst b/dev-tools/special-files.lst</span><br><span>delete=
d file mode 100644</span><br><span>index e5f2fc2..0000000</span><br><span>-=
-- a/dev-tools/special-files.lst</span><br><span>+++ /dev/null</span><br><s=
pan>@@ -1,5 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-E:=
doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated, e=
xclude it</span><br><span style=3D"color: hsl(0, 100%, 40%);">-E:src/compat=
/compat-lz4.c              # Preserve LZ4 upstream formatting</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-E:src/compat/compat-lz4.h          =
    # Preserve LZ4 upstream formatting</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco=
 upstream formatting</span><br><span style=3D"color: hsl(0, 100%, 40%);">-E=
:src/openvpn/ovpn_dco_win.h           # Preserve ovpn-dco-win upstream form=
atting</span><br><span>diff --git a/dev-tools/uncrustify.conf b/dev-tools/u=
ncrustify.conf</span><br><span>deleted file mode 100644</span><br><span>ind=
ex 325f310..0000000</span><br><span>--- a/dev-tools/uncrustify.conf</span><=
br><span>+++ /dev/null</span><br><span>@@ -1,79 +0,0 @@</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-# Use Allman-style</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-indent_columns=3D4</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-indent_braces=3Dfalse</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-indent_else_if=3Dfalse</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-indent_switch_case=3D4</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-indent_label=3D1</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-nl_if_brace=3Dadd</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-nl_brace_else=3Dadd</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-nl_elseif_brace=3Dadd</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-nl_else_brace=3Dadd</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-nl_else_if=3Dremove</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-nl_for_brace=3Dadd</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-nl_while_brace=3Dadd</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-nl_switch_brace=3Dadd</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-nl_fdef_brace=3Dadd</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-nl_do_brace=3Dadd</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-sp_func_proto_paren=3DRemove</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-sp_func_def_paren=3DRemove</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-sp_func_call_paren=3DRemove</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-sp_sizeof_paren=3DRemove</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-# No tabs, spaces only</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-indent_with_tabs=3D0</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-align_with_tabs=3Dfalse</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-cmt_convert_tab_to_spaces=3Dtrue</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
# Do not put spaces between the # and preprocessor statements</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-pp_space=3Dremove</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-# Various whitespace fiddling</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-sp_assign=3Dadd</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-sp_before_sparen=3Dadd</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-sp_inside_sparen=3Dremove</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-sp_cond_colon=3Dadd</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-sp_cond_question=3Dadd</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-sp_bool=3Dadd</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-sp_else_brace=3Dadd</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-sp_brace_else=3Dadd</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-sp_after_comma=3Dadd</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-pos_arith=3DLead</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-pos_bool=3DLead</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_=
func_type_name=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-n=
l_before_case=3Dtrue</span><br><span style=3D"color: hsl(0, 100%, 40%);">-n=
l_assign_leave_one_liners=3Dtrue</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-nl_enum_leave_one_liners=3Dtrue</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-nl_brace_fparen=3Dadd</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-nl_max=3D4</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-nl_after_func_proto=3D2</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-nl_end_of_file_min=3D1</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-nl_end_of_file=3Dforce</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Alway=
s use scoping braces for conditionals</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-mod_full_brace_if=3Dadd</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-mod_full_brace_if_chain=3Dfalse</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-mod_full_brace_while=3Dadd</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-mod_full_brace_for=3Dadd</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-mod_full_brace_do=3Dadd</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-# Annotate #else and #endif statements</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-mod_add_long_ifdef_endif_comment=3D20</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-mod_add_long_ifdef_else_c=
omment=3D5</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-# Misc cleanup</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-mod_remove_extra_semicolon=3Dtrue</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# leave blank at end of empty for() statements</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_after_semi_for_empty=
=3DAdd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Use C-style comments (/* .. */)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-cmt_c_nl_end=3Dtrue</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-cmt_star_cont=3Dtrue</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-cmt_cpp_to_c=3Dtrue</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-# Use &quot;char **a&quot;-style pointer stars/der=
eferences</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_before_pt=
r_star=3DAdd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_betwee=
n_ptr_star=3DRemove</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp=
_after_ptr_star=3DRemove</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-sp_before_byref=3DAdd</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-sp_after_byref=3DRemove</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail">change=
 830</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15d4946800cbfaead67a73450ff=
3b12193814e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 830 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Dz7Rvk91Le4=--

