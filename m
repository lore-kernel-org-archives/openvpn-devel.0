From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 11:18:31 +0000
In-Reply-To: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
References: <gerrit.1733837528000.I15d4946800cbfaead67a73450ff3b12193814e54@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <6e671351dc9926513c7bee6e7ae1bf55c5459a96-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="n9Y9qQ9E8FI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove uncrustify
 config and reformat-all.sh
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

--n9Y9qQ9E8FI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail

to look at the new patch set (#14).


Change subject: Remove uncrustify config and reformat-all.sh
......................................................................

Remove uncrustify config and reformat-all.sh

Replaced with clang-format.

Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
D dev-tools/reformat-all.sh
D dev-tools/special-files.lst
D dev-tools/uncrustify.conf
3 files changed, 0 insertions(+), 219 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/830/14

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
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--n9Y9qQ9E8FI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>flichtenheld <strong>uploaded patch set #14</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/830?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">Remove uncrustify config and reformat-all.sh<br><br>Replaced with=
 clang-format.<br><br>Change-Id: I15d4946800cbfaead67a73450ff3b12193814e54<=
br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>D de=
v-tools/reformat-all.sh<br>D dev-tools/special-files.lst<br>D dev-tools/unc=
rustify.conf<br>3 files changed, 0 insertions(+), 219 deletions(-)<br><br><=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/830/14</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/dev-tools/reformat-all.sh b/dev-tools/reformat-all.sh</s=
pan><br><span>deleted file mode 100755</span><br><span>index 0a31a83..00000=
00</span><br><span>--- a/dev-tools/reformat-all.sh</span><br><span>+++ /dev=
/null</span><br><span>@@ -1,135 +0,0 @@</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#!/bin/sh</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# reformat-all.sh - Reformat all git files in the checked out</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#                   git branc=
h using uncrustify.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Copyright (C) 2016-2=
025 - David Sommerseth &lt;davids@...515...&gt;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# This program is free software; you can redistribute it and/or</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-# modify it under the terms=
 of the GNU General Public License</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-# as published by the Free Software Foundation; either version=
 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# of the License.</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-# This program is distributed in the hope t=
hat it will be useful,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-# but WITHOUT ANY WARRANTY; without even the implied warranty of</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-# MERCHANTABILITY or FITNESS FO=
R A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-# GNU General Public License for more details.</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-# You should have received a copy of the GNU General Public=
 License</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# along with =
this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-tstamp=3D&quot;$(date +%Y%m%d-%H%M%S)&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-files=3D&quot;$(pwd)/reformat-all_files-$tstamp.lst=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-log=3D&quot;$(p=
wd)/reformat-all_log-$tstamp.txt&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-srcr=
oot=3D&quot;$(git rev-parse --show-toplevel)&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-cfg=3D&quot;$srcroot/dev-tools/uncrustify.conf=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-specialfiles=3D=
&quot;$srcroot/dev-tools/special-files.lst&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-export gitfiles=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-export procfiles=3D0</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# Go to the root o=
f the source tree</span><br><span style=3D"color: hsl(0, 100%, 40%);">-cd &=
quot;$srcroot&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    echo -n &quot;** Starting $0: &quot;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    date</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    # Find all C source/header files</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    git ls-files | grep -E &quot;.*\.[ch](\=
.in$|$)&quot; &gt; &quot;${files}.git&quot;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    # Manage files which needs special treatment</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    awk -F\# &#39;{gsub(&quot;\n| &quot;, &quot=
;&quot;, $1); print $1}&#39; &quot;$specialfiles&quot; &gt; &quot;${files}.=
sp&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while rea=
d srcfile</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    do</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        res=3D$(grep &quot;=
$srcfile&quot; &quot;${files}.sp&quot; 2&gt;/dev/null)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        if [ $? -ne 0 ]; then</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            # If grep didn&#39;t f=
ind the file among special files,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            # process it normally</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            echo &quot;$srcfile&quot; &gt;&gt; &quo=
t;$files&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mode=
=3D$(echo &quot;$res&quot; | cut -d:  -f1)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            case &quot;$mode&quot; in</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                E)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    echo &quot;** INFO **=
  Excluding &#39;$srcfile&#39;&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    ;;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                P)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    echo &quot;** INFO **  Pre-patching &#39;$=
srcfile&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 patchfile=3D&quot;${srcroot}&quot;/dev-tools/reformat-patc=
hes/before_$(echo &quot;$srcfile&quot; | tr &quot;/&quot; &quot;_&quot;).pa=
tch</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
  if [ -r &quot;$patchfile&quot; ]; then</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                        git apply &quot;$patchfile&quot;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   if [ $? -ne 0 ]; then</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                            echo &quot;** ERROR **  Failed to apply pre-=
patch file: $patchfile&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                            exit 2</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                        fi</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                        echo &quot;** WARN ** P=
re-patch file for $srcfile is missing: $patchfile&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    fi</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    echo &quot;$srcfile&=
quot; &gt;&gt; &quot;${files}.postpatch&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    echo &quot;$srcfile&quot; &gt;&=
gt; &quot;$files&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                    ;;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                *)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   echo &quot;** WARN ** Unknown mode &#39;$mode&#39; for f=
ile &#39;$srcfile&#39;&quot;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    ;;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            esac</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        fi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    done=
 &lt; &quot;${files}.git&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    rm -f &quot;${files}.git&quot; &quot;${files}.sp&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    # Kick off uncrustify</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    echo</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    echo &quot;** INFO ** Running: uncrustify -c $cfg --no-=
backup -l C -F $files&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    uncrustify -c &quot;$cfg&quot; --no-backup -l C -F &quot;$files&q=
uot; 2&gt;&amp;1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
es=3D$?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &quot=
;** INFO ** Uncrustify completed (exit code $res)&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-} | tee &quot;${log}-1&quot;  # Log needs=
 to be closed here, to be processed in next block</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Check t=
he results</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    gitfile=
s=3D$(wc -l &quot;$files&quot; | cut -d\  -f1)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    procfiles=3D$(grep &quot;Parsing: &quot; &quot=
;${log}-1&quot; | wc -l)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    echo &=
quot;C source/header files checked into git: $gitfiles&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    echo &quot;Files processed by un=
crustify:          $procfiles&quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    echo</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    # Post-Patch fil=
es modified after we uncrustify have adjusted them</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if [ -r &quot;${files}.postpatch&quot; ]; =
then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        while rea=
d srcfile;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        do<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            patchfile=
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
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
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


--n9Y9qQ9E8FI=--

