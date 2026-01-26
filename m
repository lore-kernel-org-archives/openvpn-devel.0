From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 13:56:33 +0000
References: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a03e8ec9849db8bea59908330765b02eb443c315-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A9U+KxWMN8Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_openvpnserv:
 Make sure to include config.h
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

--A9U+KxWMN8Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail

to review the following change.


Change subject: test_openvpnserv: Make sure to include config.h
......................................................................

test_openvpnserv: Make sure to include config.h

Otherwise the check for cmocka version doesn't
work. Includes the update to vcpkg in GHA since
that exposed the problem.

chore(deps): update vcpkg digest to 6d332a0

Change-Id: I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M tests/unit_tests/openvpnserv/test_openvpnserv.c
2 files changed, 7 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1488/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5f5d624..7d1574c 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -49,7 +49,7 @@
       - name: Install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
       - name: Install dependencies
         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
       - name: configure OpenVPN with cmake
@@ -84,7 +84,7 @@
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
           vcpkgJsonGlob: '**/mingw/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest
@@ -274,7 +274,7 @@
       - name: Restore artifacts, or setup vcpkg (do not install any packag=
e)
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e
+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd
           vcpkgJsonGlob: '**/windows/vcpkg.json'

       - name: Run CMake with vcpkg.json manifest (NO TESTS)
diff --git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_t=
ests/openvpnserv/test_openvpnserv.c
index 348de4f..45096a1 100644
--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c
+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c
@@ -21,6 +21,10 @@
  *  with this program; if not, see <https://www.gnu.org/licenses/>.
  */

+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
 #include <setjmp.h>
 #include <cmocka.h>
 #include "test_common.h"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b
Gerrit-Change-Number: 1488
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--A9U+KxWMN8Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_openvpnserv: Make sure to include conf=
ig.h<br><br>Otherwise the check for cmocka version doesn&#39;t<br>work. Inc=
ludes the update to vcpkg in GHA since<br>that exposed the problem.<br><br>=
chore(deps): update vcpkg digest to 6d332a0<br><br>Change-Id: I3b246bcc36ba=
35c2ed9630dc18e97aff436eaa0b<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>M tests/unit_tes=
ts/openvpnserv/test_openvpnserv.c<br>2 files changed, 7 insertions(+), 3 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/88/1488/1</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/bu=
ild.yaml b/.github/workflows/build.yaml</span><br><span>index 5f5d624..7d15=
74c 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><sp=
an>+++ b/.github/workflows/build.yaml</span><br><span>@@ -49,7 +49,7 @@</sp=
an><br><span>       - name: Install vcpkg</span><br><span>         uses: lu=
kka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: eeb00=
f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4c=
cdc3413bd</span><br><span>       - name: Install dependencies</span><br><sp=
an>         run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka</span><br><=
span>       - name: configure OpenVPN with cmake</span><br><span>@@ -84,7 +=
84,7 @@</span><br><span>       - name: Restore from cache and install vcpkg=
</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><b=
r><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitI=
d: 6d332a018c433fad20822ff4b536e4ccdc3413bd</span><br><span>           vcpk=
gJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><span> </span><br><span>=
       - name: Run CMake with vcpkg.json manifest</span><br><span>@@ -274,7=
 +274,7 @@</span><br><span>       - name: Restore artifacts, or setup vcpkg=
 (do not install any package)</span><br><span>         uses: lukka/run-vcpk=
g@...2815... # v11.5</span><br><span>         with:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: eeb00f1ecba68f6=
8fad6a1ee93eec77921b3146e</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd<=
/span><br><span>           vcpkgJsonGlob: &#39;**/windows/vcpkg.json&#39;</=
span><br><span> </span><br><span>       - name: Run CMake with vcpkg.json m=
anifest (NO TESTS)</span><br><span>diff --git a/tests/unit_tests/openvpnser=
v/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test_openvpnserv.c</spa=
n><br><span>index 348de4f..45096a1 100644</span><br><span>--- a/tests/unit_=
tests/openvpnserv/test_openvpnserv.c</span><br><span>+++ b/tests/unit_tests=
/openvpnserv/test_openvpnserv.c</span><br><span>@@ -21,6 +21,10 @@</span><b=
r><span>  *  with this program; if not, see &lt;https://www.gnu.org/license=
s/&gt;.</span><br><span>  */</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;setjmp.h&gt;</span>=
<br><span> #include &lt;cmocka.h&gt;</span><br><span> #include &quot;test_c=
ommon.h&quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail">change 1488</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b246bcc36ba35c2ed9630dc18e=
97aff436eaa0b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1488 </div>
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

--A9U+KxWMN8Y=--

