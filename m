From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 4 Apr 2025 11:08:30 +0000
In-Reply-To: <gerrit.1743589873000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
References: <gerrit.1743589873000.Ief11d5d7ccae084c863b50054d4e97c71f57d6f0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7bf17f8affe92f4e8ffaab5806362cac733a4755-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+ZmQHJpbcu0="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[release/2.6]: GHA: Pin
 version of CMake for MinGW build
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

--+ZmQHJpbcu0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/93=
0?usp=3Demail )

Change subject: GHA: Pin version of CMake for MinGW build
......................................................................

GHA: Pin version of CMake for MinGW build

Turns out that "apt install cmake" is useless since
Github installs also CMake but not as a package. So
make sure we control which CMake we get and not
Github.

Switch to get-cmake action (which also installs ninja)
and remove the installation via apt.

Backport from master but much more limited since we
do not have Android nor AWS LC builds in release/2.6.

Change-Id: Ief11d5d7ccae084c863b50054d4e97c71f57d6f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250401170420.29808-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
299.html
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit da65c4fdde20e36df38a90c1f1ef1d8ebf486c28)
Message-Id: <20250402153250.4764-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20250402153250.4764-1-=
gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 1 deletion(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5b1c797..37ac6ec 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -47,10 +47,11 @@
       VCPKG_ROOT: ${{ github.workspace }}/vcpkg
     steps:
       - name: Install dependencies
-        run: sudo apt update && sudo apt install -y mingw-w64 unzip cmake =
ninja-build build-essential wget python3-docutils man2html-base
+        run: sudo apt update && sudo apt install -y mingw-w64 unzip build-=
essential wget python3-docutils man2html-base
       - name: Checkout OpenVPN
         uses: actions/checkout@...2844... # v4.2.2

+      - uses: lukka/get-cmake@...2870... # v3.31.6
       - name: Restore from cache and install vcpkg
         uses: lukka/run-vcpkg@...2815... # v11.5
         with:

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/930?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ief11d5d7ccae084c863b50054d4e97c71f57d6f0
Gerrit-Change-Number: 930
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--+ZmQHJpbcu0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/930?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">GHA: Pin version of CMake for MinGW build<br><=
br>Turns out that &quot;apt install cmake&quot; is useless since<br>Github =
installs also CMake but not as a package. So<br>make sure we control which =
CMake we get and not<br>Github.<br><br>Switch to get-cmake action (which al=
so installs ninja)<br>and remove the installation via apt.<br><br>Backport =
from master but much more limited since we<br>do not have Android nor AWS L=
C builds in release/2.6.<br><br>Change-Id: Ief11d5d7ccae084c863b50054d4e97c=
71f57d6f0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2025040117=
0420.29808-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg31299.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<=
br>(cherry picked from commit da65c4fdde20e36df38a90c1f1ef1d8ebf486c28)<br>=
Message-Id: &lt;20250402153250.4764-1-gert@...1296...&gt;<br>URL: https://w=
ww.mail-archive.com/search?l=3Dmid&amp;q=3D20250402153250.4764-1-gert@...1711...=
96...<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .g=
ithub/workflows/build.yaml<br>1 file changed, 2 insertions(+), 1 deletion(-=
)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 5b1c797..37ac6ec 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -47,10 +47,11 @@</span><br><span>       VCPKG_ROOT: ${{ g=
ithub.workspace }}/vcpkg</span><br><span>     steps:</span><br><span>      =
 - name: Install dependencies</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        run: sudo apt update &amp;&amp; sudo apt install -y mingw-w=
64 unzip cmake ninja-build build-essential wget python3-docutils man2html-b=
ase</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: sud=
o apt update &amp;&amp; sudo apt install -y mingw-w64 unzip build-essential=
 wget python3-docutils man2html-base</span><br><span>       - name: Checkou=
t OpenVPN</span><br><span>         uses: actions/checkout@...2844... # v4.2=
.2</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      - uses: lukka/get-cmake@...2870... # v3.31.6</span><br><span>       =
- name: Restore from cache and install vcpkg</span><br><span>         uses:=
 lukka/run-vcpkg@...2815... # v11.5</span><br><span>         with:</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/930?usp=3Demail">change 930</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
930?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief11d5d7ccae084c863b50054d4=
e97c71f57d6f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 930 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--+ZmQHJpbcu0=--

