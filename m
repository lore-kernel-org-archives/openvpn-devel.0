From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 23 Mar 2026 12:21:30 +0000
References: <gerrit.1774268486000.I52773764e0f4056fe5367918a9b2e6720b165c21@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0bfbfb06fc3d2a05af9efb3d13a04bda3848fbbb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wkxP95kYWC0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dev-tools: Add new
 script to convert mails to Gerrit patches
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

--wkxP95kYWC0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1585?usp=3Demail

to review the following change.


Change subject: dev-tools: Add new script to convert mails to Gerrit patches
......................................................................

dev-tools: Add new script to convert mails to Gerrit patches

Also checks for some common issues.

Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A dev-tools/gerrit-submit-from-mail.sh
1 file changed, 42 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1585/1

diff --git a/dev-tools/gerrit-submit-from-mail.sh b/dev-tools/gerrit-submit=
-from-mail.sh
new file mode 100755
index 0000000..ac1988f
--- /dev/null
+++ b/dev-tools/gerrit-submit-from-mail.sh
@@ -0,0 +1,42 @@
+#!/bin/bash
+
+# Assertions:
+#  - there is a remote called "gerrit" that can be used to
+#    pushed to gerrit. Create it with
+#    git remote add gerrit ssh://<yourgerritusername>@gerrit.openvpn.net:2=
9418/openvpn.git
+# - the master branch does not contain pending commits, move them to branc=
hes
+#
+# Usage:
+# - Pipe mail to this script on stdin
+# - You can specify the target branch as the first argument to the script
+#   if it is not master.
+
+set -eu
+
+TARGET_BRANCH=3D${1:-master}
+SOURCE_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+TIMESTAMP=3D$(date +%Y%M%dT%H%S)
+
+git -C $SOURCE_DIR checkout $TARGET_BRANCH
+git -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}
+git -C $SOURCE_DIR am
+
+warnings=3D0
+if git -C $SOURCE_DIR log -n1 --format=3D%an | grep -q "via Openvpn-devel"=
; then
+    echo WARNING: Author contains \"via Openvpn-devel\"
+    echo Try to get an actual email-adress from the submitter!
+    warnings=3D$((warnings + 1))
+fi
+
+if ! git -C $SOURCE_DIR log -n1 --format=3D%b | grep -qi "signed-off-by:";=
 then
+    echo WARNING: Signed-off-by: line missing
+    echo Consider adding it.
+    warnings=3D$((warnings + 1))
+fi
+
+if [ "$warnings" -ge 0 ]; then
+    echo Please fix the $warnings warnings above before pushing.
+    echo Push the changes with git -C $SOURCE_DIR push gerrit HEAD:refs/fo=
r/$TARGET_BRANCH
+else
+    echo git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH
+fi

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1585?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I52773764e0f4056fe5367918a9b2e6720b165c21
Gerrit-Change-Number: 1585
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--wkxP95kYWC0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1585?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dev-tools: Add new script to convert mails =
to Gerrit patches<br><br>Also checks for some common issues.<br><br>Change-=
Id: I52773764e0f4056fe5367918a9b2e6720b165c21<br>Signed-off-by: Frank Licht=
enheld &lt;frank@...2641...&gt;<br>---<br>A dev-tools/gerrit-submit-from-ma=
il.sh<br>1 file changed, 42 insertions(+), 0 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/85/1=
585/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/dev-tools/gerrit-submit-from-mail.sh b/dev-tools=
/gerrit-submit-from-mail.sh</span><br><span>new file mode 100755</span><br>=
<span>index 0000000..ac1988f</span><br><span>--- /dev/null</span><br><span>=
+++ b/dev-tools/gerrit-submit-from-mail.sh</span><br><span>@@ -0,0 +1,42 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#!/bin/bash</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# Assertions:</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#  - there is a remote called &quot;gerrit&quot; tha=
t can be used to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#  =
  pushed to gerrit. Create it with</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#    git remote add gerrit ssh://&lt;yourgerritusername&gt;@=
gerrit.openvpn.net:29418/openvpn.git</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# - the master branch does not contain pending commits, mo=
ve them to branches</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Usage:</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# - Pipe mail to this script =
on stdin</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# - You can=
 specify the target branch as the first argument to the script</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#   if it is not master.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+set -eu</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TA=
RGET_BRANCH=3D${1:-master}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+SOURCE_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURCE[0]}&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+TIMESTAMP=3D$(date =
+%Y%M%dT%H%S)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+git -C $SOURCE_DIR checko=
ut $TARGET_BRANCH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+gi=
t -C $SOURCE_DIR checkout -B mail-submit-${TIMESTAMP}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+git -C $SOURCE_DIR am</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+warnings=3D0</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+if git -C $SOURCE_DIR log -n1 --format=3D%an | grep -q &quot;via =
Openvpn-devel&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    echo WARNING: Author contains \&quot;via Openvpn-devel\&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo Try to get an =
actual email-adress from the submitter!</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    warnings=3D$((warnings + 1))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if=
 ! git -C $SOURCE_DIR log -n1 --format=3D%b | grep -qi &quot;signed-off-by:=
&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ech=
o WARNING: Signed-off-by: line missing</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    echo Consider adding it.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    warnings=3D$((warnings + 1))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+if [ &quot;$warnings&quot; -ge 0 ]; then</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    echo Please fix the $warnings warnings above =
before pushing.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
echo Push the changes with git -C $SOURCE_DIR push gerrit HEAD:refs/for/$TA=
RGET_BRANCH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    echo git -C $SOURCE=
_DIR push gerrit HEAD:refs/for/$TARGET_BRANCH</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+fi</span><br><span></span><br></pre><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1585?usp=3Demail">cha=
nge 1585</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1585?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I52773764e0f4056fe5367918a9b=
2e6720b165c21 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1585 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--wkxP95kYWC0=--

