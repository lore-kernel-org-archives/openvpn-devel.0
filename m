From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 19:57:28 +0000
In-Reply-To: <gerrit.1754309056000.I3046f4b09a4700001a1d9dcce802990dfa701b52@...2715...>
References: <gerrit.1754309056000.I3046f4b09a4700001a1d9dcce802990dfa701b52@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a3da31e4541f3e14aed5073ae5bdbb9193a12d33-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VMih2Ci2c6I="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix build error
 with clang-cl on latest Windows SDK
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

--VMih2Ci2c6I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1127?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Fix build error with clang-cl on latest Windows SDK
......................................................................

Fix build error with clang-cl on latest Windows SDK

Found when testing windows-2025 runner in GHA.
So switch to that to make sure the error is fixed.

Change-Id: I3046f4b09a4700001a1d9dcce802990dfa701b52
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250804195054.21729-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
513
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M src/openvpn/syshead.h
2 files changed, 3 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1127/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index b2bfd21..f7883c7 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -116,7 +116,7 @@
         arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, ssl, tls_crypt, user_pass]

-    runs-on: windows-latest
+    runs-on: windows-2025
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
@@ -264,7 +264,7 @@
       env:
         BUILD_CONFIGURATION: Release

-      runs-on: windows-latest
+      runs-on: windows-2025
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
       - uses: lukka/get-cmake@...2897... # v4.0.3
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 524923b..26a553b 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -44,7 +44,7 @@
 #define srandom  srand
 #endif

-#ifdef _MSC_VER /* Visual Studio */
+#if defined(_MSC_VER) && !defined(__clang__) /* Microsoft compiler */
 #define __func__ __FUNCTION__
 #define __attribute__(x)
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1127?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3046f4b09a4700001a1d9dcce802990dfa701b52
Gerrit-Change-Number: 1127
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--VMih2Ci2c6I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1127?usp=3Demail">View Change</a></p><p>The following approvals got outd=
ated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Fix build error with clang-cl on latest Windows SDK<=
br><br>Found when testing windows-2025 runner in GHA.<br>So switch to that =
to make sure the error is fixed.<br><br>Change-Id: I3046f4b09a4700001a1d9dc=
ce802990dfa701b52<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20=
250804195054.21729-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg32513<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>M s=
rc/openvpn/syshead.h<br>2 files changed, 3 insertions(+), 3 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/112=
7/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/b=
uild.yaml</span><br><span>index b2bfd21..f7883c7 100644</span><br><span>---=
 a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/bui=
ld.yaml</span><br><span>@@ -116,7 +116,7 @@</span><br><span>         arch: =
[x86, x64]</span><br><span>         test: [argv, auth_token, buffer, crypto=
api, crypto, misc, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass=
]</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  runs-on: windows-latest</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    runs-on: windows-2025</span><br><span>     name: &quot;mingw unit=
test ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&quot;</span><br><span> =
    steps:</span><br><span>       - name: Checkout OpenVPN</span><br><span>=
@@ -264,7 +264,7 @@</span><br><span>       env:</span><br><span>         BU=
ILD_CONFIGURATION: Release</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      runs-on: windows-latest</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      runs-on: windows-2025</span><br><sp=
an>       steps:</span><br><span>       - uses: actions/checkout@...2844...=
 # v4.2.2</span><br><span>       - uses: lukka/get-cmake@...2897... # v4.0.=
3</span><br><span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.=
h</span><br><span>index 524923b..26a553b 100644</span><br><span>--- a/src/o=
penvpn/syshead.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><spa=
n>@@ -44,7 +44,7 @@</span><br><span> #define srandom  srand</span><br><span=
> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#ifdef _MSC_VER /* Visual Studio */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(_MSC_VER) &amp;&amp; !defined(__clang__) /=
* Microsoft compiler */</span><br><span> #define __func__ __FUNCTION__</spa=
n><br><span> #define __attribute__(x)</span><br><span> #endif</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1127?usp=3Demail">change 1127</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/112=
7?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3046f4b09a4700001a1d9dcce80=
2990dfa701b52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1127 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--VMih2Ci2c6I=--

