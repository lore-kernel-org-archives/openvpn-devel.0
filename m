From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 13 Feb 2025 16:12:59 +0000
References: <gerrit.1739463173000.I09d7e8cf4f15ae5810e0adafda15e489a3375892@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <05494024a8ead03cb61ba2e1b772dcb40ff8a9e8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8SA+yj9jGPU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Build on all four
 possible Android ABIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8SA+yj9jGPU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/897?usp=3Demail

to review the following change.


Change subject: Build on all four possible Android ABIs
......................................................................

Build on all four possible Android ABIs

This also includes the last of the still used 32 bit platforms.
But the installed device base is getting thin as well.

Change-Id: I09d7e8cf4f15ae5810e0adafda15e489a3375892
---
M .github/workflows/build.yaml
1 file changed, 7 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/897/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 9022e23..4fe6532 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -39,10 +39,16 @@
     strategy:
       fail-fast: false
       matrix:
-        abi: [ arm64-v8a ]
+        abi: [ armeabi-v7a, arm64-v8a, x86_64, x86 ]
         include:
+          - abi: armeabi-v7a
+            vcpkg_triplet: arm-neon-android
           - abi: arm64-v8a
             vcpkg_triplet: arm64-android
+          - abi: x86_64
+            vcpkg_triplet: x64-android
+          - abi: x86
+            vcpkg_triplet: x86-android
     runs-on: ubuntu-24.04
     name: "Android - ${{ matrix.abi }}"
     # Github images already setup NDK with ANDROID_NDK_ROOT pointing to th=
e root

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/897?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I09d7e8cf4f15ae5810e0adafda15e489a3375892
Gerrit-Change-Number: 897
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--8SA+yj9jGPU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/897?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Build on all four possible Android ABIs<br><br>This also incl=
udes the last of the still used 32 bit platforms.<br>But the installed devi=
ce base is getting thin as well.<br><br>Change-Id: I09d7e8cf4f15ae5810e0ada=
fda15e489a3375892<br>---<br>M .github/workflows/build.yaml<br>1 file change=
d, 7 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/97/897/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflo=
ws/build.yaml b/.github/workflows/build.yaml</span><br><span>index 9022e23.=
.4fe6532 100644</span><br><span>--- a/.github/workflows/build.yaml</span><b=
r><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -39,10 +39,16=
 @@</span><br><span>     strategy:</span><br><span>       fail-fast: false<=
/span><br><span>       matrix:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        abi: [ arm64-v8a ]</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        abi: [ armeabi-v7a, arm64-v8a, x86_64, x86 ]</span>=
<br><span>         include:</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+          - abi: armeabi-v7a</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            vcpkg_triplet: arm-neon-android</span><br><spa=
n>           - abi: arm64-v8a</span><br><span>             vcpkg_triplet: a=
rm64-android</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
   - abi: x86_64</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         vcpkg_triplet: x64-android</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          - abi: x86</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            vcpkg_triplet: x86-android</span><br><span>   =
  runs-on: ubuntu-24.04</span><br><span>     name: &quot;Android - ${{ matr=
ix.abi }}&quot;</span><br><span>     # Github images already setup NDK with=
 ANDROID_NDK_ROOT pointing to the root</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/897?usp=3De=
mail">change 897</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/897?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I09d7e8cf4f15ae5810e0adafda1=
5e489a3375892 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 897 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--8SA+yj9jGPU=--

