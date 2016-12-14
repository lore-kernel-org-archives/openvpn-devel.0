From: David Sommerseth <davids@...515...>
Date: Wed, 14 Dec 2016 22:05:00 +0100
Message-Id: <1481749500-8795-1-git-send-email-davids@...515...>
In-Reply-To: <1481746052-17372-1-git-send-email-davids@...515...>
References: <1481746052-17372-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH v3] dev-tools: Add reformat-all.sh for code
	style unification
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

This script will run all files related to the currently checked out
git branch through uncrustify using a standardized style configuration.

Due to a bug in uncrustify 0.64, it is needed to add a special treatment
to one of the files at the moment.  So this both pre- and post-patched
before/after uncrustify is run.  This is to simply to assure that all
file processing will happen consistently each time.

Also added doc/doxygen/doc_key_generation.h to an ignore list, as
it carries some specific Doxygen formatting we should be careful with.
This file is anyhow not so critical and can be managed manually.

The src/compat/compat-lz4.[ch] files are also not touched, as they
are based on upstream formatting.  This makes it easier to update
to a newer LZ4 version later on and even see what the differences
are.

v2 - Include updated config from CodeStyle wiki page
     Remove line lenght restriction for The Great Reformatting
     Update the script with improvements by krzee

v3 - Update with a fixed config from the CodeStyle wiki page
     Corrected a typo in the commit message (0.63->0.64)
     Minor changes to the reformat script (no pushd/popd,
     some new lines moved around)

Signed-off-by: David Sommerseth <davids@...515...>
---
 dev-tools/reformat-all.sh                          | 136 +++++++++++++++++++++
 .../after_include_openvpn-plugin.h.in.patch        |  13 ++
 .../before_include_openvpn-plugin.h.in.patch       |  13 ++
 dev-tools/special-files.lst                        |   4 +
 dev-tools/uncrustify.conf                          |  65 ++++++++++
 5 files changed, 231 insertions(+)
 create mode 100755 dev-tools/reformat-all.sh
 create mode 100644 dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch
 create mode 100644 dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch
 create mode 100644 dev-tools/special-files.lst
 create mode 100644 dev-tools/uncrustify.conf

diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh
new file mode 100755
index 0000000..ac5cf6f
--- /dev/null
+++ b/dev-tools/reformat-all.sh
@@ -0,0 +1,136 @@
+#!/bin/bash
+# reformat-all.sh - Reformat all git files in the checked out
+#                   git branch using uncrustify.
+#
+# Copyright (C) 2016 - David Sommerseth <davids@...515...>
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
+tstamp="$(date +%Y%m%d-%H%M%S)"
+files="$(pwd)/reformat-all_files-$tstamp.lst"
+log="$(pwd)/reformat-all_log-$tstamp.txt"
+
+srcroot="$(git rev-parse --show-toplevel)"
+cfg="$srcroot/dev-tools/uncrustify.conf"
+specialfiles="$srcroot/dev-tools/special-files.lst"
+
+export gitfiles=0
+export procfiles=0
+
+# Go to the root of the source tree
+cd "$srcroot"
+
+{
+    echo -n "** Starting $0: "
+    date
+
+    # Find all C source/header files
+    git ls-files | grep -E ".*\.[ch](\.in$|$)" > "${files}.git"
+
+    # Manage files which needs special treatment
+    awk -F\# '{gsub("\n| ", "", $1); print $1}' "$specialfiles" > "${files}.sp"
+    while read srcfile
+    do
+        res=$(grep "$srcfile" "${files}.sp" 2>/dev/null)
+        if [ $? -ne 0 ]; then
+            # If grep didn't find the file among special files,
+            # process it normally
+            echo "$srcfile" >> "$files"
+        else
+            mode=$(echo "$res" | cut -d:  -f1)
+            case "$mode" in
+                E)
+                    echo "** INFO **  Excluding '$srcfile'"
+                    ;;
+                P)
+                    echo "** INFO **  Pre-patching '$srcfile'"
+                    patchfile="${srcroot}"/dev-tools/reformat-patches/before_$(echo "$srcfile" | tr "/" "_").patch
+                    if [ -r "$patchfile" ]; then
+                        git apply "$patchfile"
+                        if [ $? -ne 0 ]; then
+                            echo "** ERROR **  Failed to apply pre-patch file: $patchfile"
+                            exit 2
+                        fi
+                    else
+                        echo "** WARN ** Pre-patch file for $srcfile is missing: $patchfile"
+                    fi
+                    echo "$srcfile" >> "${files}.postpatch"
+                    echo "$srcfile" >> "$files"
+                    ;;
+                *)
+                    echo "** WARN ** Unknown mode '$mode' for file '$srcfile'"
+                    ;;
+            esac
+        fi
+    done < "${files}.git"
+    rm -f "${files}.git" "${files}.sp"
+
+    # Kick off uncrustify
+    echo
+    echo "** INFO ** Running: uncrustify -c $cfg --no-backup -l C -p debug.uncr -F $files"
+    uncrustify -c "$cfg" --no-backup -l C -p debug.uncr -F "$files" 2>&1
+    res=$?
+    echo "** INFO ** Uncrustify completed (exit code $res)"
+} | tee "${log}-1"  # Log needs to be closed here, to be processed in next block
+
+{
+    # Check the results
+    gitfiles=$(wc -l "$files" | cut -d\  -f1)
+    procfiles=$(grep "Parsing: " "${log}-1" | wc -l)
+    echo
+    echo "C source/header files checked into git: $gitfiles"
+    echo "Files processed by uncrustify:          $procfiles"
+    echo
+
+    # Post-Patch files modified after we uncrustify have adjusted them
+    if [ -r "${files}.postpatch" ]; then
+        while read srcfile;
+        do
+            patchfile="${srcroot}"/dev-tools/reformat-patches/after_$(echo "$srcfile" | tr "/" "_").patch
+            if [ -r "$patchfile" ]; then
+                echo "** INFO **  Post-patching '$srcfile'"
+                git apply "$patchfile"
+                if [ $? -ne 0 ]; then
+                    echo "** WARN ** Failed to apply $patchfile"
+                fi
+            else
+                echo "** WARN ** Post-patch file for $srcfile is missing: $patchfile"
+            fi
+        done < "${files}.postpatch"
+        rm -f "${files}.postpatch"
+    fi
+} | tee "${log}-2" # Log needs to be closed here, to be processed in next block
+
+cat "${log}-1" "${log}-2" > "$log"
+
+{
+    ec=1
+    echo
+    if [ "$gitfiles" -eq "$procfiles" ]; then
+        echo "Reformatting completed successfully"
+        ec=0
+    else
+        last=$(tail -n1 "${log}-1")
+        echo "** ERROR ** Reformating failed to process all files."
+        echo "            uncrustify exit code: $res"
+        echo "            Last log line: $last"
+        echo
+    fi
+    rm -f "${log}-1" "${log}-2"
+} | tee -a "$log"
+rm -f "${files}"
+
+exit $ec
diff --git a/dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch b/dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch
new file mode 100644
index 0000000..4faa4d8
--- /dev/null
+++ b/dev-tools/reformat-patches/after_include_openvpn-plugin.h.in.patch
@@ -0,0 +1,13 @@
+diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
+index 05bffab..05b4b6a 100644
+--- a/include/openvpn-plugin.h.in
++++ b/include/openvpn-plugin.h.in
+@@ -169,7 +169,7 @@ typedef void *openvpn_plugin_handle_t;
+ /*
+  * We are compiling OpenVPN.
+  */
+-/* #define OPENVPN_PLUGIN_DEF        typedef */
++#define OPENVPN_PLUGIN_DEF        typedef
+ #define OPENVPN_PLUGIN_FUNC(name) (*name)
+ 
+ #else  /* ifdef OPENVPN_PLUGIN_H */
diff --git a/dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch b/dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch
new file mode 100644
index 0000000..7c7249d
--- /dev/null
+++ b/dev-tools/reformat-patches/before_include_openvpn-plugin.h.in.patch
@@ -0,0 +1,13 @@
+diff --git a/include/openvpn-plugin.h.in b/include/openvpn-plugin.h.in
+index 34ad18b..f4c5472 100644
+--- a/include/openvpn-plugin.h.in
++++ b/include/openvpn-plugin.h.in
+@@ -169,7 +169,7 @@ typedef void *openvpn_plugin_handle_t;
+ /*
+  * We are compiling OpenVPN.
+  */
+-#define OPENVPN_PLUGIN_DEF        typedef
++// #define OPENVPN_PLUGIN_DEF        typedef
+ #define OPENVPN_PLUGIN_FUNC(name) (*name)
+ 
+ #else
diff --git a/dev-tools/special-files.lst b/dev-tools/special-files.lst
new file mode 100644
index 0000000..f3f77ea
--- /dev/null
+++ b/dev-tools/special-files.lst
@@ -0,0 +1,4 @@
+E:doc/doxygen/doc_key_generation.h     # @verbatim section gets mistreated, exclude it
+E:src/compat/compat-lz4.c              # Preserve LZ4 upstream formatting
+E:src/compat/compat-lz4.h              # Preserve LZ4 upstream formatting
+P:include/openvpn-plugin.h.in          # uncrustify segfaults, patch it before+after
diff --git a/dev-tools/uncrustify.conf b/dev-tools/uncrustify.conf
new file mode 100644
index 0000000..95e0b2a
--- /dev/null
+++ b/dev-tools/uncrustify.conf
@@ -0,0 +1,65 @@
+# Use Allman-style
+indent_columns=4
+indent_braces=false
+indent_else_if=false
+indent_switch_case=4
+indent_label=1
+nl_if_brace=add
+nl_brace_else=add
+nl_elseif_brace=add
+nl_else_brace=add
+nl_else_if=remove
+sp_func_proto_paren=Remove
+sp_func_def_paren=Remove
+sp_func_call_paren=Remove
+sp_sizeof_paren=Remove
+
+# No tabs, spaces only
+indent_with_tabs=0
+align_with_tabs=false
+cmt_convert_tab_to_spaces=true
+
+# Do not put spaces between the # and preprocessor statements
+pp_space=remove
+
+# Various whitespace fiddling
+sp_assign=add
+sp_before_sparen=add
+sp_inside_sparen=remove
+sp_cond_colon=add
+sp_cond_question=add
+sp_bool=add
+sp_else_brace=add
+sp_brace_else=add
+pos_arith=Lead
+pos_bool=Lead
+nl_func_type_name=add
+nl_before_case=true
+nl_assign_leave_one_liners=true
+nl_enum_leave_one_liners=true
+nl_brace_fparen=add
+nl_max=4
+nl_after_func_proto=2
+
+# Always use scoping braces for conditionals
+mod_full_brace_if=add
+mod_full_brace_if_chain=false
+
+# Annotate #else and #endif statements
+mod_add_long_ifdef_endif_comment=20
+mod_add_long_ifdef_else_comment=5
+
+# Misc cleanup
+mod_remove_extra_semicolon=true
+
+# Use C-style comments (/* .. */)
+cmt_c_nl_end=true
+cmt_star_cont=true
+cmt_cpp_to_c=true
+
+# Use "char **a"-style pointer stars/dereferences
+sp_before_ptr_star=Add
+sp_between_ptr_star=Remove
+sp_after_ptr_star=Remove
+sp_before_byref=Add
+sp_after_byref=Remove
-- 
1.8.3.1


