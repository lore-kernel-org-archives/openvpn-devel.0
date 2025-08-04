From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 09:34:52 +0000
In-Reply-To: <gerrit.1751017165000.I03195c21807cdef0a2f903f424982ec29a555103@...2715...>
References: <gerrit.1751017165000.I03195c21807cdef0a2f903f424982ec29a555103@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9cabba7d662d711e03c1954bc4a8b8e6e4d991ee-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zHZTVoUEXdA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Update
 git-pre-commit-uncrustify.sh to handle clang-format
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zHZTVoUEXdA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
70?usp=3Demail )

Change subject: Update git-pre-commit-uncrustify.sh to handle clang-format
......................................................................

Update git-pre-commit-uncrustify.sh to handle clang-format

Rename it as well, since it is not specific to
uncrustify anymore.

Change-Id: I03195c21807cdef0a2f903f424982ec29a555103
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250804092739.16410-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
497.html
Signed-off-by: Gert Doering <gert@...1296...>
---
R dev-tools/git-pre-commit-format.sh
1 file changed, 32 insertions(+), 14 deletions(-)




diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-com=
mit-format.sh
similarity index 81%
rename from dev-tools/git-pre-commit-uncrustify.sh
rename to dev-tools/git-pre-commit-format.sh
index 9851c21..6e1ac71 100755
--- a/dev-tools/git-pre-commit-uncrustify.sh
+++ b/dev-tools/git-pre-commit-format.sh
@@ -2,6 +2,7 @@

 # Copyright (c) 2015, David Martin
 #               2022, Heiko Hund
+#               2025, Frank Lichtenheld
 # All rights reserved.
 #
 # Redistribution and use in source and binary forms, with or without
@@ -26,10 +27,12 @@
 # OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


-# git pre-commit hook that runs an Uncrustify stylecheck.
+# git pre-commit hook that runs a stylecheck.
 # Features:
 #  - abort commit when commit does not comply with the style guidelines
 #  - create a patch of the proposed style changes
+#  - use clang-format or uncrustify depending on presence of .clang-format
+#    config file
 #
 # More info on Uncrustify: http://uncrustify.sourceforge.net/

@@ -77,27 +80,42 @@
     against=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904
 fi

-UNCRUSTIFY=3D$(command -v uncrustify)
-UNCRUST_CONFIG=3D"$(git rev-parse --show-toplevel)/dev-tools/uncrustify.co=
nf"
+TOPDIR=3D"$(git rev-parse --show-toplevel)"
+if [ -e "${TOPDIR}/.clang-format" ]; then
+    TOOL=3Dclang-format
+    TOOL_BIN=3D$(command -v clang-format)
+    TOOL_CMD=3D"$TOOL_BIN"

-# make sure the config file and executable are correctly set
-if [ ! -f "$UNCRUST_CONFIG" ] ; then
-    printf "Error: uncrustify config file not found.\n"
-    printf "Expected to find it at $UNCRUST_CONFIG.\n"
-    printf "Aborting commit.\n"
-    exit 1
+    # Allow to use in parallel with pre-commit
+    if [ $(basename "$0") =3D "pre-commit.legacy" ]; then
+       echo "Skipping clang-format check in favor of pre-commit"
+       exit 0
+    fi
+else
+    TOOL=3Duncrustify
+    TOOL_BIN=3D$(command -v uncrustify)
+    UNCRUST_CONFIG=3D"${TOPDIR}/dev-tools/uncrustify.conf"
+    TOOL_CMD=3D"$TOOL_BIN -q -l C -c $UNCRUST_CONFIG"
+
+    # make sure the config file is correctly set
+    if [ ! -f "$UNCRUST_CONFIG" ] ; then
+        printf "Error: uncrustify config file not found.\n"
+        printf "Expected to find it at $UNCRUST_CONFIG.\n"
+        printf "Aborting commit.\n"
+        exit 1
+    fi
 fi

-if [ -z "$UNCRUSTIFY" ] ; then
-    printf "Error: uncrustify executable not found.\n"
+if [ -z "$TOOL_BIN" ] ; then
+    printf "Error: $TOOL executable not found.\n"
     printf "Is it installed and in your \$PATH?\n"
     printf "Aborting commit.\n"
     exit 1
 fi

 # create a filename to store our generated patch
-patch=3D$(mktemp /tmp/ovpn-fmt-XXXXXX)
-tmpout=3D$(mktemp /tmp/uncrustify-XXXXXX)
+patch=3D$(mktemp /tmp/ovpn-fmt-patch-XXXXXX)
+tmpout=3D$(mktemp /tmp/ovpn-fmt-tmp-XXXXXX)

 # create one patch containing all changes to the files
 # sed to remove quotes around the filename, if inserted by the system
@@ -131,7 +149,7 @@
     #    +++ $tmpout timestamp
     # to both lines working on the same file and having a a/ and b/ prefix.
     # Else it can not be applied with 'git apply'.
-    git show ":$file" | "$UNCRUSTIFY" -q -l C -c "$UNCRUST_CONFIG" -o "$tm=
pout"
+    git show ":$file" | $TOOL_CMD > "$tmpout"
     git show ":$file" | diff -u -- - "$tmpout" | \
         sed -e "1s|--- -|--- \"b/$file_escaped_target\"|" -e "2s|+++ $tmpo=
ut|+++ \"a/$file_escaped_target\"|" >> "$patch"
 done

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1070?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I03195c21807cdef0a2f903f424982ec29a555103
Gerrit-Change-Number: 1070
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--zHZTVoUEXdA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1070?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Update git-pre-commit-uncrustify.sh to handle=
 clang-format<br><br>Rename it as well, since it is not specific to<br>uncr=
ustify anymore.<br><br>Change-Id: I03195c21807cdef0a2f903f424982ec29a555103=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20250804092739.1641=
0-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg32497.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>R dev-tools/git-pre-commit-format.sh<br>1 file ch=
anged, 32 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/dev-tools/git-pre-commit-uncrustify.sh b/dev-tools/git-pre-=
commit-format.sh</span><br><span>similarity index 81%</span><br><span>renam=
e from dev-tools/git-pre-commit-uncrustify.sh</span><br><span>rename to dev=
-tools/git-pre-commit-format.sh</span><br><span>index 9851c21..6e1ac71 1007=
55</span><br><span>--- a/dev-tools/git-pre-commit-uncrustify.sh</span><br><=
span>+++ b/dev-tools/git-pre-commit-format.sh</span><br><span>@@ -2,6 +2,7 =
@@</span><br><span> </span><br><span> # Copyright (c) 2015, David Martin</s=
pan><br><span> #               2022, Heiko Hund</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#               2025, Frank Lichtenheld</span><=
br><span> # All rights reserved.</span><br><span> #</span><br><span> # Redi=
stribution and use in source and binary forms, with or without</span><br><s=
pan>@@ -26,10 +27,12 @@</span><br><span> # OF THIS SOFTWARE, EVEN IF ADVISE=
D OF THE POSSIBILITY OF SUCH DAMAGE.</span><br><span> </span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-# git pre-commit hook th=
at runs an Uncrustify stylecheck.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# git pre-commit hook that runs a stylecheck.</span><br><span=
> # Features:</span><br><span> #  - abort commit when commit does not compl=
y with the style guidelines</span><br><span> #  - create a patch of the pro=
posed style changes</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#  - use clang-format or uncrustify depending on presence of .clang-format<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#    config file</sp=
an><br><span> #</span><br><span> # More info on Uncrustify: http://uncrusti=
fy.sourceforge.net/</span><br><span> </span><br><span>@@ -77,27 +80,42 @@</=
span><br><span>     against=3D4b825dc642cb6eb9a060e54bf8d69288fbee4904</spa=
n><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-UNCRUSTIFY=3D$(command -v uncrustify)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-UNCRUST_CONFIG=3D&quot;$(git rev-parse --show-t=
oplevel)/dev-tools/uncrustify.conf&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+TOPDIR=3D&quot;$(git rev-parse --show-toplevel)&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -e &quot;${TOPD=
IR}/.clang-format&quot; ]; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    TOOL=3Dclang-format</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    TOOL_BIN=3D$(command -v clang-format)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    TOOL_CMD=3D&quot;$TOOL_BIN&quot;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-# ma=
ke sure the config file and executable are correctly set</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-if [ ! -f &quot;$UNCRUST_CONFIG&quot; ] =
; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf &quo=
t;Error: uncrustify config file not found.\n&quot;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    printf &quot;Expected to find it at $UNCRU=
ST_CONFIG.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 printf &quot;Aborting commit.\n&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    exit 1</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    # Allow to use in parallel with pre-commit</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if [ $(basename &quot;$0&quot;) =3D =
&quot;pre-commit.legacy&quot; ]; then</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+       echo &quot;Skipping clang-format check in favor of=
 pre-commit&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
     exit 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    TOOL=3Duncrustify</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    TOOL_BIN=3D$(command -v uncrus=
tify)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    UNCRUST_CO=
NFIG=3D&quot;${TOPDIR}/dev-tools/uncrustify.conf&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    TOOL_CMD=3D&quot;$TOOL_BIN -q -l C -=
c $UNCRUST_CONFIG&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    # make sure=
 the config file is correctly set</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if [ ! -f &quot;$UNCRUST_CONFIG&quot; ] ; then</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        printf &quot;Error: un=
crustify config file not found.\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        printf &quot;Expected to find it at $UNCRUST_CO=
NFIG.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  printf &quot;Aborting commit.\n&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        exit 1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    fi</span><br><span> fi</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-if [ -z &quot;$UNCRUSTIFY&quot; ] ; t=
hen</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    printf &quot;E=
rror: uncrustify executable not found.\n&quot;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+if [ -z &quot;$TOOL_BIN&quot; ] ; then</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    printf &quot;Error: $TOOL=
 executable not found.\n&quot;</span><br><span>     printf &quot;Is it inst=
alled and in your \$PATH?\n&quot;</span><br><span>     printf &quot;Abortin=
g commit.\n&quot;</span><br><span>     exit 1</span><br><span> fi</span><br=
><span> </span><br><span> # create a filename to store our generated patch<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-patch=3D$(mktemp /tmp/=
ovpn-fmt-XXXXXX)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tmpou=
t=3D$(mktemp /tmp/uncrustify-XXXXXX)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+patch=3D$(mktemp /tmp/ovpn-fmt-patch-XXXXXX)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+tmpout=3D$(mktemp /tmp/ovpn-fmt-t=
mp-XXXXXX)</span><br><span> </span><br><span> # create one patch containing=
 all changes to the files</span><br><span> # sed to remove quotes around th=
e filename, if inserted by the system</span><br><span>@@ -131,7 +149,7 @@</=
span><br><span>     #    +++ $tmpout timestamp</span><br><span>     # to bo=
th lines working on the same file and having a a/ and b/ prefix.</span><br>=
<span>     # Else it can not be applied with &#39;git apply&#39;.</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    git show &quot;:$file&quot;=
 | &quot;$UNCRUSTIFY&quot; -q -l C -c &quot;$UNCRUST_CONFIG&quot; -o &quot;=
$tmpout&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gi=
t show &quot;:$file&quot; | $TOOL_CMD &gt; &quot;$tmpout&quot;</span><br><s=
pan>     git show &quot;:$file&quot; | diff -u -- - &quot;$tmpout&quot; | \=
</span><br><span>         sed -e &quot;1s|--- -|--- \&quot;b/$file_escaped_=
target\&quot;|&quot; -e &quot;2s|+++ $tmpout|+++ \&quot;a/$file_escaped_tar=
get\&quot;|&quot; &gt;&gt; &quot;$patch&quot;</span><br><span> done</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1070?usp=3Demail">change 1070</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1070?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I03195c21807cdef0a2f903f4249=
82ec29a555103 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1070 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--zHZTVoUEXdA=--

