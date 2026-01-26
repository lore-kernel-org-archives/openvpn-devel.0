From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 15:33:38 +0000
In-Reply-To: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
References: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5801b8445c014a092e3e81e306a4f07b2cce59dc-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qcp1oYa1Gps="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qcp1oYa1Gps=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: test_openvpnserv: Make sure to include config.h
......................................................................

test_openvpnserv: Make sure to include config.h

Otherwise the check for cmocka version doesn't
work. Includes the update to vcpkg in GHA since
that exposed the problem.

chore(deps): update vcpkg digest to 6d332a0

Change-Id: I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1488
Message-Id: <20260126145558.31460-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
437.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M tests/unit_tests/openvpnserv/test_openvpnserv.c
2 files changed, 7 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/88/1488/3

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ef9b3f5..4570417 100644
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
@@ -272,7 +272,7 @@
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b
Gerrit-Change-Number: 1488
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--qcp1oYa1Gps=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">test_openvpnserv: Make sure to incl=
ude config.h<br><br>Otherwise the check for cmocka version doesn&#39;t<br>w=
ork. Includes the update to vcpkg in GHA since<br>that exposed the problem.=
<br><br>chore(deps): update vcpkg digest to 6d332a0<br><br>Change-Id: I3b24=
6bcc36ba35c2ed9630dc18e97aff436eaa0b<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1488<br>Message-Id: &lt=
;20260126145558.31460-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg35437.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yam=
l<br>M tests/unit_tests/openvpnserv/test_openvpnserv.c<br>2 files changed, =
7 insertions(+), 3 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://g=
errit.openvpn.net:29418/openvpn refs/changes/88/1488/3</pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a=
/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br><spa=
n>index ef9b3f5..4570417 100644</span><br><span>--- a/.github/workflows/bui=
ld.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>=
@@ -49,7 +49,7 @@</span><br><span>       - name: Install vcpkg</span><br><s=
pan>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>     =
    with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          vc=
pkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 6d332a018c=
433fad20822ff4b536e4ccdc3413bd</span><br><span>       - name: Install depen=
dencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg install openssl l=
z4 cmocka</span><br><span>       - name: configure OpenVPN with cmake</span=
><br><span>@@ -84,7 +84,7 @@</span><br><span>       - name: Restore from ca=
che and install vcpkg</span><br><span>         uses: lukka/run-vcpkg@...2829...=
5... # v11.5</span><br><span>         with:</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee9=
3eec77921b3146e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc3413bd</span><br>=
<span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39;</span><br><sp=
an> </span><br><span>       - name: Run CMake with vcpkg.json manifest</spa=
n><br><span>@@ -272,7 +272,7 @@</span><br><span>       - name: Restore arti=
facts, or setup vcpkg (do not install any package)</span><br><span>        =
 uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommit=
Id: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 6d332a018c433fad20822f=
f4b536e4ccdc3413bd</span><br><span>           vcpkgJsonGlob: &#39;**/window=
s/vcpkg.json&#39;</span><br><span> </span><br><span>       - name: Run CMak=
e with vcpkg.json manifest (NO TESTS)</span><br><span>diff --git a/tests/un=
it_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/openvpnserv/test=
_openvpnserv.c</span><br><span>index 348de4f..45096a1 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c</span><br><span>+++=
 b/tests/unit_tests/openvpnserv/test_openvpnserv.c</span><br><span>@@ -21,6=
 +21,10 @@</span><br><span>  *  with this program; if not, see &lt;https://=
www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;=
setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span> #i=
nclude &quot;test_common.h&quot;</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail"=
>change 1488</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1488?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3b246bcc36ba35c2ed9630dc18e=
97aff436eaa0b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1488 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--qcp1oYa1Gps=--

