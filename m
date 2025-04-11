From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 11 Apr 2025 14:06:58 +0000
In-Reply-To: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
References: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <fdc69cbc683d9301bac69e42253ba6fb402a35de-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LwGUIQTveZE="; charset=UTF-8
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

--LwGUIQTveZE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail

to look at the new patch set (#4).


Change subject: Remove uncrustify config and scripts, switch GHA
......................................................................

Remove uncrustify config and scripts, switch GHA

Replaced with clang-format and pre-commit.

Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
D dev-tools/git-pre-commit-uncrustify.sh
D dev-tools/reformat-all.sh
D dev-tools/special-files.lst
D dev-tools/uncrustify.conf
5 files changed, 12 insertions(+), 402 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/830/4

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 0f5e617..da5fb9a 100644
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--LwGUIQTveZE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">Remove uncrustify config and scripts, switch GHA<br><br>Replaced w=
ith clang-format and pre-commit.<br><br>Change-Id: I15d4946800cbfaead67a734=
50ff3b12193814e54<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>---<br>M .github/workflows/build.yaml<br>D dev-tools/git-pre-commit-=
uncrustify.sh<br>D dev-tools/reformat-all.sh<br>D dev-tools/special-files.l=
st<br>D dev-tools/uncrustify.conf<br>5 files changed, 12 insertions(+), 402=
 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn ref=
s/changes/30/830/4</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.git=
hub/workflows/build.yaml</span><br><span>index 0f5e617..da5fb9a 100644</spa=
n><br><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.githu=
b/workflows/build.yaml</span><br><span>@@ -5,35 +5,26 @@</span><br><span>  =
 pull_request:</span><br><span> </span><br><span> jobs:</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  checkuncrustify:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    name: &quot;Check code style with Uncru=
stify&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Ubun=
tu 22.04 has uncrustify 0.72_f</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    runs-on: ubuntu-22.04</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  clang-format:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    name: Check code style with clang-format</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    runs-on: ubuntu-24.04</span><br><sp=
an>     steps:</span><br><span>       - name: Install dependencies</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt update &=
amp;&amp; sudo apt install -y uncrustify</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          sudo apt update &amp;&amp; sudo apt install -y py=
thon3-pip</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
pip3 install pre-commit</span><br><span>       - name: Checkout OpenVPN</sp=
an><br><span>         uses: actions/checkout@...2844... # v4.2.2</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        with:</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-          path: openvpn</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - name: Show uncrustify version<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: uncrustif=
y --version</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - na=
me: Run uncrustify</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     run: ./dev-tools/reformat-all.sh</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        working-directory: openvpn</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      - name: Run clang-format</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        run: pre-commit run -a --=
show-diff-on-failure || true</span><br><span>       - name: Check for chang=
es</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: git di=
ff --output=3Duncrustify-changes.patch</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        working-directory: openvpn</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: Show changes on standard outp=
ut</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: git di=
ff</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-dir=
ectory: openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    run: git diff --output=3Dformat-changes.patch</span><br><span>       - =
uses: actions/upload-artifact@...2868... # v4.6.2</span><br><span>         =
with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          name: =
uncrustify-changes.patch</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          path: &#39;openvpn/uncrustify-changes.patch&#39;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          name: format-changes.pa=
tch</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: =
format-changes.patch</span><br><span>       - name: Set job status</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        run: test ! -s uncrust=
ify-changes.patch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    working-directory: openvpn</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        run: test ! -s format-changes.patch</span><br><span> </s=
pan><br><span>   android:</span><br><span>     strategy:</span><br><span>di=
ff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-commi=
t-uncrustify.sh</span><br><span>deleted file mode 100755</span><br><span>in=
dex 9851c21..0000000</span><br><span>--- a/dev-tools/git-pre-commit-uncrust=
ify.sh</span><br><span>+++ /dev/null</span><br><span>@@ -1,161 +0,0 @@</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#!/bin/sh</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# Copyright (c) 2015, David Martin</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#               2022, Heiko Hund</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-# All rights reserved.</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-# Redistribution and use in source and binary forms, w=
ith or without</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# modif=
ication, are permitted provided that the following conditions are met:</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# * Redistributions of source code must retain=
 the above copyright notice, this</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#   list of conditions and the following disclaimer.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# * Redistributions in binary form must reproduce th=
e above copyright notice,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#   this list of conditions and the following disclaimer in the documen=
tation</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#   and/or othe=
r materials provided with the distribution.</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS &qu=
ot;AS IS&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# AND A=
NY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# IMPLIED WARRANTIES OF MERC=
HANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# DISCLAIMED. IN NO EVENT SHALL THE COPYRIG=
HT HOLDER OR CONTRIBUTORS BE LIABLE</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-# FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, O=
R CONSEQUENTIAL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# DAMA=
GES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-# SERVICES; LOSS OF USE, D=
ATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# CAUSED AND ON ANY THEORY OF LIABILITY, WHETH=
ER IN CONTRACT, STRICT LIABILITY,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WA=
Y OUT OF THE USE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# OF =
THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# git pre-commit hook that runs an Uncrustify stylecheck.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# Features:</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#  - abort commit when commit does not comply w=
ith the style guidelines</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#  - create a patch of the proposed style changes</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# More info on Uncrustify: http://uncrustify.sourceforge.net/</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# This file was taken from a set of unoffic=
ial pre-commit hooks available</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# at https://github.com/ddddavidmartin/Pre-commit-hooks and modifi=
ed to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# fit the openvp=
n project&#39;s needs</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# exit on error</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-set -e</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# If call=
ed so, install this script as pre-commit hook</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-if [ &quot;$1&quot; =3D &quot;install&quot; ] ; the=
n</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    TARGET=3D&quot;$=
(git rev-parse --git-path hooks)/pre-commit&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if [ -e &quot;$TARGET&quot; ] ; then</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        printf &quot;$TARGET file exists. Won&#39=
;t overwrite.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        printf &quot;Aborting installation.\n&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        exit 1</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    read -p=
 &quot;Install as $TARGET? [y/N] &quot; INPUT</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    [ &quot;$INPUT&quot; =3D &quot;y&quot; ] || exi=
t 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cp &quot;$0&qu=
ot; &quot;$TARGET&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    chmod +x $TARGET</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    exit 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-# check whether the given file matches any of the =
set extensions</span><br><span style=3D"color: hsl(0, 100%, 40%);">-matches=
_extension() {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    loc=
al filename=3D&quot;$(basename -- &quot;$1&quot;)&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    local extension=3D&quot;.${filename##=
*.}&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    local ex=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    for ext in .c .h ; do [ &quot;$ext&qu=
ot; =3D &quot;$extension&quot; ] &amp;&amp; return 0; done</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return 1</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-# necessary check for initial comm=
it</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if git rev-parse --=
verify HEAD &gt;/dev/null 2&gt;&amp;1 ; then</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    against=3DHEAD</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    # Initial commit: diff against an empty tree object</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    against=3D4b825dc642cb6eb9a060e54b=
f8d69288fbee4904</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-UNCRUSTIFY=3D$(command -v uncrustify)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-UNCRUST_CONFIG=3D&quot;$(gi=
t rev-parse --show-toplevel)/dev-tools/uncrustify.conf&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-# make sure the config file and executable are correctly =
set</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -f &quot;$U=
NCRUST_CONFIG&quot; ] ; then</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    printf &quot;Error: uncrustify config file not found.\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Expecte=
d to find it at $UNCRUST_CONFIG.\n&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    printf &quot;Aborting commit.\n&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    exit 1</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quo=
t;$UNCRUSTIFY&quot; ] ; then</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    printf &quot;Error: uncrustify executable not found.\n&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf &quot;Is it in=
stalled and in your \$PATH?\n&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    printf &quot;Aborting commit.\n&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    exit 1</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-fi</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# create a filena=
me to store our generated patch</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-patch=3D$(mktemp /tmp/ovpn-fmt-XXXXXX)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-tmpout=3D$(mktemp /tmp/uncrustify-XXXXXX)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-# create one patch containing all changes to the =
files</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# sed to remove =
quotes around the filename, if inserted by the system</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# (done sometimes, if the filename contains=
 special characters, like the quote itself)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-git diff-index --cached --diff-filter=3DACMR --name-o=
nly $against -- | \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-se=
d -e &#39;s/^&quot;\(.*\)&quot;$/\1/&#39; | \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-while read file</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-do</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   # ignore file if we do check for file extensions and the file</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    # does not match the extensi=
ons .c or .h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if ! =
matches_extension &quot;$file&quot;; then</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        continue;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # escape special=
 characters in the target filename:</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    # phase 1 (characters escaped in the output diff):</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;\&#39;: bac=
kslash needs to be escaped in the output diff</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    #     - &#39;&quot;&#39;: quote needs to be esc=
aped in the output diff if present inside</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    #            of the filename, as it used to bracket=
 the entire filename part</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    # phase 2 (characters escaped in the match replacement):</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;\&#39;: backsla=
sh needs to be escaped again for sed itself</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    #            (i.e. double escaping after phase 1)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #     - &#39;&amp=
;&#39;: would expand to matched string</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    #     - &#39;|&#39;: used as sed split char instead of=
 &#39;/&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # pri=
ntf %s particularly important if the filename contains the % character</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    file_escaped_target=3D=
$(printf &quot;%s&quot; &quot;$file&quot; | sed -e &#39;s/[\&quot;]/\\&amp;=
/g&#39; -e &#39;s/[\&amp;|]/\\&amp;/g&#39;)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    # uncrustify our sourcefile, create a patch with diff and append it to=
 our $patch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # The =
sed call is necessary to transform the patch from</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    #    --- - timestamp</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    #    +++ $tmpout timestamp</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    # to both lines working on the=
 same file and having a a/ and b/ prefix.</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    # Else it can not be applied with &#39;git apply&#3=
9;.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    git show &quot=
;:$file&quot; | &quot;$UNCRUSTIFY&quot; -q -l C -c &quot;$UNCRUST_CONFIG&qu=
ot; -o &quot;$tmpout&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    git show &quot;:$file&quot; | diff -u -- - &quot;$tmpout&quot; | \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sed -e &quot;=
1s|--- -|--- \&quot;b/$file_escaped_target\&quot;|&quot; -e &quot;2s|+++ $t=
mpout|+++ \&quot;a/$file_escaped_target\&quot;|&quot; &gt;&gt; &quot;$patch=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-done</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-rm -f &quot;$tmpout&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# if no patch has been generated all is ok, clean up the file stub and=
 exit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if [ ! -s &quot;=
$patch&quot; ] ; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    rm -f &quot;$patch&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    exit 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# a patch has been created, notify the user=
 and exit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-printf &quot=
;Formatting of some code does not follow the project guidelines.\n&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-if [ $(wc -l &lt; $patch) -gt 80 ] ; then</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf &quot;The fi=
le $patch contains the necessary fixes.\n&quot;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    printf &quot;Here&#39;s the patch that fixes the formatting:\n=
\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    cat $patc=
h</span><br><span style=3D"color: hsl(0, 100%, 40%);">-fi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-printf &quot;\nYou can apply these changes with:\n git apply=
 $patch\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-printf=
 &quot;(from the root directory of the repository) and then commit again.\n=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-printf &quot;\n=
Aborting commit.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-exit 1</span><br><=
span>diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh</sp=
an><br><span>deleted file mode 100755</span><br><span>index 42d7368..000000=
0</span><br><span>--- a/dev-tools/reformat-all.sh</span><br><span>+++ /dev/=
null</span><br><span>@@ -1,136 +0,0 @@</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# reformat-all.sh - Reformat all git files in the checked out</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#                   git branch=
 using uncrustify.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyright (C) 2016-20=
24 - David Sommerseth &lt;davids@...515...&gt;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-# This program is free software; you can redistribute it and/or</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-# modify it under the terms =
of the GNU General Public License</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-# as published by the Free Software Foundation; either version =
2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# of the License.</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-# MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# GNU General Public License for more details.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# You should have received a copy of the GNU General Public=
 License</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# along with =
this program; if not, write to the Free Software</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-# Foundation, Inc., 51 Franklin Street, Fifth Fl=
oor, Boston, MA  02110-1301, USA.</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-tstamp=3D&quot;$(date +%Y%m%d=
-%H%M%S)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-files=
=3D&quot;$(pwd)/reformat-all_files-$tstamp.lst&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-log=3D&quot;$(pwd)/reformat-all_log-$tstamp=
.txt&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-srcroot=3D&quot;$(git rev-parse =
--show-toplevel)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-cfg=3D&quot;$srcroot/dev-tools/uncrustify.conf&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-specialfiles=3D&quot;$srcroot/dev-tools/spe=
cial-files.lst&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-export gitfiles=3D0</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-export procfiles=3D0</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-# Go to the root of the source tree</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-cd &quot;$srcroot&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    echo -n &quot;** Starting $0: &quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    date</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Find =
all C source/header files</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    git ls-files | grep -E &quot;.*\.[ch](\.in$|$)&quot; &gt; &quot;${f=
iles}.git&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Manage files which ne=
eds special treatment</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    awk -F\# &#39;{gsub(&quot;\n| &quot;, &quot;&quot;, $1); print $1}&#39;=
 &quot;$specialfiles&quot; &gt; &quot;${files}.sp&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    while read srcfile</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    do</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        res=3D$(grep &quot;$srcfile&quot; &quot;${files=
}.sp&quot; 2&gt;/dev/null)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            # If grep didn&#39;t find the file among special f=
iles,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            # pr=
ocess it normally</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        echo &quot;$srcfile&quot; &gt;&gt; &quot;$files&quot;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            mode=3D$(echo &quot;$res&quot; =
| cut -d:  -f1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      case &quot;$mode&quot; in</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                E)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    echo &quot;** INFO **  Excluding &#39;$srcfile&#=
39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     P)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      echo &quot;** INFO **  Pre-patching &#39;$srcfile&#39;&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    patchfile=
=3D&quot;${srcroot}&quot;/dev-tools/reformat-patches/before_$(echo &quot;$s=
rcfile&quot; | tr &quot;/&quot; &quot;_&quot;).patch</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if [ -r &quot;$patchfil=
e&quot; ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                  git apply &quot;$patchfile&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                        if [ $? -ne 0 ]; then<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
      echo &quot;** ERROR **  Failed to apply pre-patch file: $patchfile&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
          exit 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                        echo &quot;** WARN ** Pre-patch file for $srcfil=
e is missing: $patchfile&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    fi</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    echo &quot;$srcfile&quot; &gt;&gt; &quot;${fi=
les}.postpatch&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   echo &quot;$srcfile&quot; &gt;&gt; &quot;$files&quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ;;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                *)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                    echo &=
quot;** WARN ** Unknown mode &#39;$mode&#39; for file &#39;$srcfile&#39;&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            esac<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fi</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    done &lt; &quot;${files}.git&=
quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rm -f &quot;=
${files}.git&quot; &quot;${files}.sp&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    # Kick off uncrustify</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo =
&quot;** INFO ** Running: uncrustify -c $cfg --no-backup -l C -F $files&quo=
t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uncrustify -c &=
quot;$cfg&quot; --no-backup -l C -F &quot;$files&quot; 2&gt;&amp;1</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    res=3D$?</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    echo &quot;** INFO ** Uncrustify co=
mpleted (exit code $res)&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-} | tee &quot;${log}-1&quot;  # Log needs to be closed here, to be=
 processed in next block</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    # Check the results</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    gitfiles=3D$(wc -l &quot;$files&=
quot; | cut -d\  -f1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    procfiles=3D$(grep &quot;Parsing: &quot; &quot;${log}-1&quot; | wc -l)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;C source/header file=
s checked into git: $gitfiles&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo &quot;Files processed by uncrustify:          $procf=
iles&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    # Post-Patch files modified after we un=
crustify have adjusted them</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    if [ -r &quot;${files}.postpatch&quot; ]; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        while read srcfile;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        do</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            patchfile=3D&quot;${srcroot}&qu=
ot;/dev-tools/reformat-patches/after_$(echo &quot;$srcfile&quot; | tr &quot=
;/&quot; &quot;_&quot;).patch</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if [ -r &quot;$patchfile&quot; ]; then</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                echo &quot;** INFO ** =
 Post-patching &#39;$srcfile&#39;&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                git apply &quot;$patchfile&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                if [ $? -ne 0 =
]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      echo &quot;** WARN ** Failed to apply $patchfile&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                fi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                echo &quot;** WARN ** Post-=
patch file for $srcfile is missing: $patchfile&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            fi</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        done &lt; &quot;${files}.postpatch&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rm -f &quot;${f=
iles}.postpatch&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-} | tee &quot;$=
{log}-2&quot; # Log needs to be closed here, to be processed in next block<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-cat &quot;${log}-1&quot; &quot;${log}-2&quo=
t; &gt; &quot;$log&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    ec=3D1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    echo</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if [ &quot;$gitfiles&quot; -eq &quot;$procfiles&quot; ]; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot=
;Reformatting completed successfully&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        ec=3D0</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        last=3D$(tail -n1 &quot;${log}-1&quot;)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        echo &quot;** ERROR ** Reformating faile=
d to process all files.&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        echo &quot;            uncrustify exit code: $res&quot;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        echo &quot;      =
      Last log line: $last&quot;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        echo</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    rm -f &qu=
ot;${log}-1&quot; &quot;${log}-2&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-} | tee -a &quot;$log&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-rm -f &quot;${files}&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-exit $ec</span><br><span>diff --git a/dev-tools/special-files.lst b/=
dev-tools/special-files.lst</span><br><span>deleted file mode 100644</span>=
<br><span>index e5f2fc2..0000000</span><br><span>--- a/dev-tools/special-fi=
les.lst</span><br><span>+++ /dev/null</span><br><span>@@ -1,5 +0,0 @@</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-E:doc/doxygen/doc_key_gener=
ation.h     # @verbatim section gets mistreated, exclude it</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-E:src/compat/compat-lz4.c            =
  # Preserve LZ4 upstream formatting</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-E:src/compat/compat-lz4.h              # Preserve LZ4 upstre=
am formatting</span><br><span style=3D"color: hsl(0, 100%, 40%);">-E:src/op=
envpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream formatting</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-E:src/openvpn/ovpn_dco_win=
.h           # Preserve ovpn-dco-win upstream formatting</span><br><span>di=
ff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf</span><br>=
<span>deleted file mode 100644</span><br><span>index 325f310..0000000</span=
><br><span>--- a/dev-tools/uncrustify.conf</span><br><span>+++ /dev/null</s=
pan><br><span>@@ -1,79 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-# Use Allman-style</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-indent_columns=3D4</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-indent_braces=3Dfalse</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-indent_else_if=3Dfalse</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-indent_switch_case=3D4</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-indent_label=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
nl_if_brace=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_b=
race_else=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_els=
eif_brace=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_els=
e_brace=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_else_=
if=3Dremove</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_for_bra=
ce=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_while_brac=
e=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_switch_brac=
e=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_fdef_brace=
=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_do_brace=3Da=
dd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_func_proto_paren=
=3DRemove</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_func_def_=
paren=3DRemove</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_func=
_call_paren=3DRemove</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
p_sizeof_paren=3DRemove</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# No tabs, spaces o=
nly</span><br><span style=3D"color: hsl(0, 100%, 40%);">-indent_with_tabs=
=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-align_with_tabs=
=3Dfalse</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cmt_convert_t=
ab_to_spaces=3Dtrue</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Do not put spaces bet=
ween the # and preprocessor statements</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-pp_space=3Dremove</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Variou=
s whitespace fiddling</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
sp_assign=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_bef=
ore_sparen=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_in=
side_sparen=3Dremove</span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
p_cond_colon=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_=
cond_question=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp=
_bool=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_else_br=
ace=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_brace_els=
e=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_after_comma=
=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pos_arith=3DLea=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pos_bool=3DLead</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_func_type_name=3Dadd</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_before_case=3Dtrue</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_assign_leave_one_line=
rs=3Dtrue</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_enum_leav=
e_one_liners=3Dtrue</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl=
_brace_fparen=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl=
_max=3D4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_after_func=
_proto=3D2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_end_of_f=
ile_min=3D1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-nl_end_of_=
file=3Dforce</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-# Always use scoping braces fo=
r conditionals</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mod_ful=
l_brace_if=3Dadd</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mod_f=
ull_brace_if_chain=3Dfalse</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-mod_full_brace_while=3Dadd</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-mod_full_brace_for=3Dadd</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-mod_full_brace_do=3Dadd</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Anno=
tate #else and #endif statements</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-mod_add_long_ifdef_endif_comment=3D20</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-mod_add_long_ifdef_else_comment=3D5</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-# Misc cleanup</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-mod_remove_extra_semicolon=3Dtrue</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-# leave blank at end of empty for() statements</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-sp_after_semi_for_empty=3DAdd</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# Use C-style comments (/* .. */)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-cmt_c_nl_end=3Dtrue</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-cmt_star_cont=3Dtrue</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-cmt_cpp_to_c=3Dtrue</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-# Use &quot;char **a&quot;-style pointer stars/dereferences</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-sp_before_ptr_star=3DAdd</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-sp_between_ptr_star=3DRemove</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_after_ptr_star=3DRemov=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_before_byref=3DAd=
d</span><br><span style=3D"color: hsl(0, 100%, 40%);">-sp_after_byref=3DRem=
ove</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/830?usp=3Demail">change 830</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.or=
g/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schem=
a.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/830?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I15d4946800cbfaead67a73450ff=
3b12193814e54 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 830 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LwGUIQTveZE=--

