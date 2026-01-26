From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 15:33:41 +0000
In-Reply-To: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
References: <gerrit.1769435786000.I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5801b8445c014a092e3e81e306a4f07b2cce59dc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ERkN/7Qhj5Q="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ERkN/7Qhj5Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
88?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3b246bcc36ba35c2ed9630dc18e97aff436eaa0b
Gerrit-Change-Number: 1488
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ERkN/7Qhj5Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1488?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_openvpnserv: Make sure to include config.h<=
br><br>Otherwise the check for cmocka version doesn&#39;t<br>work. Includes=
 the update to vcpkg in GHA since<br>that exposed the problem.<br><br>chore=
(deps): update vcpkg digest to 6d332a0<br><br>Change-Id: I3b246bcc36ba35c2e=
d9630dc18e97aff436eaa0b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: =
https://gerrit.openvpn.net/c/openvpn/+/1488<br>Message-Id: &lt;202601261455=
58.31460-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg35437.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>M tests/=
unit_tests/openvpnserv/test_openvpnserv.c<br>2 files changed, 7 insertions(=
+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index ef9b3f5..4570417 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -49,7 +49,7 @@</span><br><span>       - name: Install vcp=
kg</span><br><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span>=
<br><span>         with:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommi=
tId: 6d332a018c433fad20822ff4b536e4ccdc3413bd</span><br><span>       - name=
: Install dependencies</span><br><span>         run: ${VCPKG_ROOT}/vcpkg in=
stall openssl lz4 cmocka</span><br><span>       - name: configure OpenVPN w=
ith cmake</span><br><span>@@ -84,7 +84,7 @@</span><br><span>       - name: =
Restore from cache and install vcpkg</span><br><span>         uses: lukka/r=
un-vcpkg@...2815... # v11.5</span><br><span>         with:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-          vcpkgGitCommitId: eeb00f1ecb=
a68f68fad6a1ee93eec77921b3146e</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          vcpkgGitCommitId: 6d332a018c433fad20822ff4b536e4ccdc34=
13bd</span><br><span>           vcpkgJsonGlob: &#39;**/mingw/vcpkg.json&#39=
;</span><br><span> </span><br><span>       - name: Run CMake with vcpkg.jso=
n manifest</span><br><span>@@ -272,7 +272,7 @@</span><br><span>       - nam=
e: Restore artifacts, or setup vcpkg (do not install any package)</span><br=
><span>         uses: lukka/run-vcpkg@...2815... # v11.5</span><br><span>  =
       with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
 vcpkgGitCommitId: eeb00f1ecba68f68fad6a1ee93eec77921b3146e</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          vcpkgGitCommitId: 6d332a0=
18c433fad20822ff4b536e4ccdc3413bd</span><br><span>           vcpkgJsonGlob:=
 &#39;**/windows/vcpkg.json&#39;</span><br><span> </span><br><span>       -=
 name: Run CMake with vcpkg.json manifest (NO TESTS)</span><br><span>diff -=
-git a/tests/unit_tests/openvpnserv/test_openvpnserv.c b/tests/unit_tests/o=
penvpnserv/test_openvpnserv.c</span><br><span>index 348de4f..45096a1 100644=
</span><br><span>--- a/tests/unit_tests/openvpnserv/test_openvpnserv.c</spa=
n><br><span>+++ b/tests/unit_tests/openvpnserv/test_openvpnserv.c</span><br=
><span>@@ -21,6 +21,10 @@</span><br><span>  *  with this program; if not, s=
ee &lt;https://www.gnu.org/licenses/&gt;.</span><br><span>  */</span><br><s=
pan> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CO=
NFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quo=
t;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</spa=
n><br><span> #include &quot;test_common.h&quot;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/14=
88?usp=3Demail">change 1488</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1488?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--ERkN/7Qhj5Q=--

