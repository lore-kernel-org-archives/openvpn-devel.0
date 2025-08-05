From: Gert Doering <gert@...1296...>
Date: Tue,  5 Aug 2025 18:59:00 +0200
Message-ID: <20250805165906.30010-1-gert@...1296...>
In-Reply-To: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
References: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v16] Remove uncrustify config and
 reformat-all.sh
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

From: Frank Lichtenheld <frank@...2641...>

Replaced with clang-format.

Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/830
This mail reflects revision 16 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
deleted file mode 100755
index 0a31a83..0000000
--- a/dev-tools/reformat-all.sh
+++ /dev/null
@@ -1,135 +0,0 @@
-#!/bin/sh
-# reformat-all.sh - Reformat all git files in the checked out
-#                   git branch using uncrustify.
-#
-# Copyright (C) 2016-2025 - David Sommerseth <davids@...515...>
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
-# along with this program; if not, see <https://www.gnu.org/licenses/>.
-#
-
-tstamp="$(date +%Y%m%d-%H%M%S)"
-files="$(pwd)/reformat-all_files-$tstamp.lst"
-log="$(pwd)/reformat-all_log-$tstamp.txt"
-
-srcroot="$(git rev-parse --show-toplevel)"
-cfg="$srcroot/dev-tools/uncrustify.conf"
-specialfiles="$srcroot/dev-tools/special-files.lst"
-
-export gitfiles=0
-export procfiles=0
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
-    awk -F\# '{gsub("\n| ", "", $1); print $1}' "$specialfiles" > "${files}.sp"
-    while read srcfile
-    do
-        res=$(grep "$srcfile" "${files}.sp" 2>/dev/null)
-        if [ $? -ne 0 ]; then
-            # If grep didn't find the file among special files,
-            # process it normally
-            echo "$srcfile" >> "$files"
-        else
-            mode=$(echo "$res" | cut -d:  -f1)
-            case "$mode" in
-                E)
-                    echo "** INFO **  Excluding '$srcfile'"
-                    ;;
-                P)
-                    echo "** INFO **  Pre-patching '$srcfile'"
-                    patchfile="${srcroot}"/dev-tools/reformat-patches/before_$(echo "$srcfile" | tr "/" "_").patch
-                    if [ -r "$patchfile" ]; then
-                        git apply "$patchfile"
-                        if [ $? -ne 0 ]; then
-                            echo "** ERROR **  Failed to apply pre-patch file: $patchfile"
-                            exit 2
-                        fi
-                    else
-                        echo "** WARN ** Pre-patch file for $srcfile is missing: $patchfile"
-                    fi
-                    echo "$srcfile" >> "${files}.postpatch"
-                    echo "$srcfile" >> "$files"
-                    ;;
-                *)
-                    echo "** WARN ** Unknown mode '$mode' for file '$srcfile'"
-                    ;;
-            esac
-        fi
-    done < "${files}.git"
-    rm -f "${files}.git" "${files}.sp"
-
-    # Kick off uncrustify
-    echo
-    echo "** INFO ** Running: uncrustify -c $cfg --no-backup -l C -F $files"
-    uncrustify -c "$cfg" --no-backup -l C -F "$files" 2>&1
-    res=$?
-    echo "** INFO ** Uncrustify completed (exit code $res)"
-} | tee "${log}-1"  # Log needs to be closed here, to be processed in next block
-
-{
-    # Check the results
-    gitfiles=$(wc -l "$files" | cut -d\  -f1)
-    procfiles=$(grep "Parsing: " "${log}-1" | wc -l)
-    echo
-    echo "C source/header files checked into git: $gitfiles"
-    echo "Files processed by uncrustify:          $procfiles"
-    echo
-
-    # Post-Patch files modified after we uncrustify have adjusted them
-    if [ -r "${files}.postpatch" ]; then
-        while read srcfile;
-        do
-            patchfile="${srcroot}"/dev-tools/reformat-patches/after_$(echo "$srcfile" | tr "/" "_").patch
-            if [ -r "$patchfile" ]; then
-                echo "** INFO **  Post-patching '$srcfile'"
-                git apply "$patchfile"
-                if [ $? -ne 0 ]; then
-                    echo "** WARN ** Failed to apply $patchfile"
-                fi
-            else
-                echo "** WARN ** Post-patch file for $srcfile is missing: $patchfile"
-            fi
-        done < "${files}.postpatch"
-        rm -f "${files}.postpatch"
-    fi
-} | tee "${log}-2" # Log needs to be closed here, to be processed in next block
-
-cat "${log}-1" "${log}-2" > "$log"
-
-{
-    ec=1
-    echo
-    if [ "$gitfiles" -eq "$procfiles" ]; then
-        echo "Reformatting completed successfully"
-        ec=0
-    else
-        last=$(tail -n1 "${log}-1")
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
-E:doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated, exclude it
-E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
-E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
-E:src/openvpn/ovpn_dco_linux.h         # Preserve ovpn-dco upstream formatting
-E:src/openvpn/ovpn_dco_win.h           # Preserve ovpn-dco-win upstream formatting
diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
deleted file mode 100644
index 325f310..0000000
--- a/dev-tools/uncrustify.conf
+++ /dev/null
@@ -1,79 +0,0 @@
-# Use Allman-style
-indent_columns=4
-indent_braces=false
-indent_else_if=false
-indent_switch_case=4
-indent_label=1
-nl_if_brace=add
-nl_brace_else=add
-nl_elseif_brace=add
-nl_else_brace=add
-nl_else_if=remove
-nl_for_brace=add
-nl_while_brace=add
-nl_switch_brace=add
-nl_fdef_brace=add
-nl_do_brace=add
-sp_func_proto_paren=Remove
-sp_func_def_paren=Remove
-sp_func_call_paren=Remove
-sp_sizeof_paren=Remove
-
-# No tabs, spaces only
-indent_with_tabs=0
-align_with_tabs=false
-cmt_convert_tab_to_spaces=true
-
-# Do not put spaces between the # and preprocessor statements
-pp_space=remove
-
-# Various whitespace fiddling
-sp_assign=add
-sp_before_sparen=add
-sp_inside_sparen=remove
-sp_cond_colon=add
-sp_cond_question=add
-sp_bool=add
-sp_else_brace=add
-sp_brace_else=add
-sp_after_comma=add
-pos_arith=Lead
-pos_bool=Lead
-nl_func_type_name=add
-nl_before_case=true
-nl_assign_leave_one_liners=true
-nl_enum_leave_one_liners=true
-nl_brace_fparen=add
-nl_max=4
-nl_after_func_proto=2
-nl_end_of_file_min=1
-nl_end_of_file=force
-
-# Always use scoping braces for conditionals
-mod_full_brace_if=add
-mod_full_brace_if_chain=false
-mod_full_brace_while=add
-mod_full_brace_for=add
-mod_full_brace_do=add
-
-# Annotate #else and #endif statements
-mod_add_long_ifdef_endif_comment=20
-mod_add_long_ifdef_else_comment=5
-
-# Misc cleanup
-mod_remove_extra_semicolon=true
-
-# leave blank at end of empty for() statements
-sp_after_semi_for_empty=Add
-
-# Use C-style comments (/* .. */)
-cmt_c_nl_end=true
-cmt_star_cont=true
-cmt_cpp_to_c=true
-
-# Use "char **a"-style pointer stars/dereferences
-sp_before_ptr_star=Add
-sp_between_ptr_star=Remove
-sp_after_ptr_star=Remove
-sp_before_byref=Add
-sp_after_byref=Remove

