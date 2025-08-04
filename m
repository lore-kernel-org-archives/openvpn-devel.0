From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 4 Aug 2025 12:04:18 +0000
References: <gerrit.1754309056000.I3046f4b09a4700001a1d9dcce802990dfa701b52@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <08c4451dabd292bf745fb0a66aedb35dec8b6c38-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CHqE1DvnyKk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CHqE1DvnyKk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1127?usp=3Demail

to review the following change.


Change subject: Fix build error with clang-cl on latest Windows SDK
......................................................................

Fix build error with clang-cl on latest Windows SDK

Found when testing windows-2025 runner in GHA.
So switch to that to make sure the error is fixed.

Change-Id: I3046f4b09a4700001a1d9dcce802990dfa701b52
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M src/openvpn/syshead.h
2 files changed, 3 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/1127/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index bd5895b..cc17fba 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -125,7 +125,7 @@
         arch: [x86, x64]
         test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, ssl, tls_crypt, user_pass]

-    runs-on: windows-latest
+    runs-on: windows-2025
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Checkout OpenVPN
@@ -273,7 +273,7 @@
       env:
         BUILD_CONFIGURATION: Release

-      runs-on: windows-latest
+      runs-on: windows-2025
       steps:
       - uses: actions/checkout@...2844... # v4.2.2
       - uses: lukka/get-cmake@...2897... # v4.0.3
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e77f313..da53635 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -44,7 +44,7 @@
 #define srandom srand
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--CHqE1DvnyKk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1127?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Fix build error with clang-cl on latest Windows SDK<br><br>F=
ound when testing windows-2025 runner in GHA.<br>So switch to that to make =
sure the error is fixed.<br><br>Change-Id: I3046f4b09a4700001a1d9dcce802990=
dfa701b52<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>-=
--<br>M .github/workflows/build.yaml<br>M src/openvpn/syshead.h<br>2 files =
changed, 3 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-fa=
mily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.op=
envpn.net:29418/openvpn refs/changes/27/1127/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github=
/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index =
bd5895b..cc17fba 100644</span><br><span>--- a/.github/workflows/build.yaml<=
/span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -125,=
7 +125,7 @@</span><br><span>         arch: [x86, x64]</span><br><span>     =
    test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_i=
d, pkt, provider, ssl, tls_crypt, user_pass]</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    runs-on: windows-latest</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: windows-2025<=
/span><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{ ma=
trix.arch }} - OSSL&quot;</span><br><span>     steps:</span><br><span>     =
  - name: Checkout OpenVPN</span><br><span>@@ -273,7 +273,7 @@</span><br><s=
pan>       env:</span><br><span>         BUILD_CONFIGURATION: Release</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      run=
s-on: windows-latest</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      runs-on: windows-2025</span><br><span>       steps:</span><br><span>=
       - uses: actions/checkout@...2844... # v4.2.2</span><br><span>       =
- uses: lukka/get-cmake@...2897... # v4.0.3</span><br><span>diff --git a/sr=
c/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><span>index e77f313..=
da53635 100644</span><br><span>--- a/src/openvpn/syshead.h</span><br><span>=
+++ b/src/openvpn/syshead.h</span><br><span>@@ -44,7 +44,7 @@</span><br><sp=
an> #define srandom srand</span><br><span> #endif</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _MSC_VER /* Visual Stu=
dio */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_=
MSC_VER) &amp;&amp; !defined(__clang__) /* Microsoft compiler */</span><br>=
<span> #define __func__ __FUNCTION__</span><br><span> #define __attribute__=
(x)</span><br><span> #endif</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1127?usp=3Demail">chan=
ge 1127</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1127?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3046f4b09a4700001a1d9dcce80=
2990dfa701b52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1127 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--CHqE1DvnyKk=--

