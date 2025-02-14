From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 13:06:52 +0000
In-Reply-To: <gerrit.1739460301000.If6afa1108f9234f98afdbe0de7b7320403871772@...2715...>
References: <gerrit.1739460301000.If6afa1108f9234f98afdbe0de7b7320403871772@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <60dbd6d239dda9933fcfa6080ea455a0a158b727-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="V3qIrCCc+eg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add (fake) Android
 cmake building
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--V3qIrCCc+eg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/895?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Add (fake) Android cmake building
......................................................................

Add (fake) Android cmake building

There is a mode to build with a real Android NDK that requires setting
up cmake to build with the NDK and so.
For quick&dirty compile tests that do not actually use the Android NDK
on Linux, -DFAKE_ANDROID on Linux can be used to compile a binary using
TARGET_ANDROID.

Change-Id: If6afa1108f9234f98afdbe0de7b7320403871772
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250214125238.17558-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
885.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 12 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/895/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5081e81..b04adce 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -39,6 +39,7 @@
 option(ENABLE_LZO "BUILD with lzo" ON)
 option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
+option(FAKE_ANDROID "Target Android but do not use actual cross compile/An=
droid cmake to build for simple compile checks on Linux")

 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")

@@ -122,7 +123,14 @@
 set(CMAKE_C_STANDARD 11)

 # Set the various defines for config.h.cmake.in
-if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Android" OR ${FAKE_ANDROID})
+    set(TARGET_ANDROID YES)
+    set(ENABLE_ASYNC_PUSH YES)
+    set(ENABLE_SITNL YES)
+    set(HAVE_LINUX_TYPES_H 1)
+    # Wacky workaround as OpenSSL package detection is otherwise broken (h=
ttps://stackoverflow.com/questions/45958214/android-cmake-could-not-find-op=
enssl)
+    list(APPEND CMAKE_FIND_ROOT_PATH ${OPENSSL_ROOT_DIR})
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
     set(TARGET_LINUX YES)
     set(ENABLE_ASYNC_PUSH YES)
     set(ENABLE_LINUXDCO YES)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 74a53a6..2f7b43d 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -432,6 +432,9 @@
 /* Are we running WIN32? */
 #cmakedefine TARGET_WIN32

+/* Are we targeting Android? */
+#cmakedefine TARGET_ANDROID
+
 #define TARGET_ALIAS "@CMAKE_SYSTEM_NAME@"

 /* Enable GNU extensions on systems that have them.  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/895?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If6afa1108f9234f98afdbe0de7b7320403871772
Gerrit-Change-Number: 895
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--V3qIrCCc+eg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
895?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add (fake) Android cmake building<br><br>Ther=
e is a mode to build with a real Android NDK that requires setting<br>up cm=
ake to build with the NDK and so.<br>For quick&amp;dirty compile tests that=
 do not actually use the Android NDK<br>on Linux, -DFAKE_ANDROID on Linux c=
an be used to compile a binary using<br>TARGET_ANDROID.<br><br>Change-Id: I=
f6afa1108f9234f98afdbe0de7b7320403871772<br>Signed-off-by: Arne Schwabe &lt=
;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Message-Id: &lt;20250214125238.17558-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30885.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLi=
sts.txt<br>M config.h.cmake.in<br>2 files changed, 12 insertions(+), 1 dele=
tion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/95/895/4</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br=
><span>index 5081e81..b04adce 100644</span><br><span>--- a/CMakeLists.txt</=
span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -39,6 +39,7 @@</span=
><br><span> option(ENABLE_LZO &quot;BUILD with lzo&quot; ON)</span><br><spa=
n> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&quot; ON)</span><br>=
<span> option(USE_WERROR &quot;Treat compiler warnings as errors (-Werror)&=
quot; ON)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+option(FAK=
E_ANDROID &quot;Target Android but do not use actual cross compile/Android =
cmake to build for simple compile checks on Linux&quot;)</span><br><span> <=
/span><br><span> set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPA=
TH &quot;Location of the plugin directory&quot;)</span><br><span> </span><b=
r><span>@@ -122,7 +123,14 @@</span><br><span> set(CMAKE_C_STANDARD 11)</spa=
n><br><span> </span><br><span> # Set the various defines for config.h.cmake=
.in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if (${CMAKE_SYSTEM=
_NAME} STREQUAL &quot;Linux&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Android&quot; OR ${F=
AKE_ANDROID})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    se=
t(TARGET_ANDROID YES)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    set(ENABLE_ASYNC_PUSH YES)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    set(ENABLE_SITNL YES)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    set(HAVE_LINUX_TYPES_H 1)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    # Wacky workaround as OpenSSL package dete=
ction is otherwise broken (https://stackoverflow.com/questions/45958214/and=
roid-cmake-could-not-find-openssl)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    list(APPEND CMAKE_FIND_ROOT_PATH ${OPENSSL_ROOT_DIR})</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+elseif (${CMAKE_SYSTEM=
_NAME} STREQUAL &quot;Linux&quot;)</span><br><span>     set(TARGET_LINUX YE=
S)</span><br><span>     set(ENABLE_ASYNC_PUSH YES)</span><br><span>     set=
(ENABLE_LINUXDCO YES)</span><br><span>diff --git a/config.h.cmake.in b/conf=
ig.h.cmake.in</span><br><span>index 74a53a6..2f7b43d 100644</span><br><span=
>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br>=
<span>@@ -432,6 +432,9 @@</span><br><span> /* Are we running WIN32? */</spa=
n><br><span> #cmakedefine TARGET_WIN32</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+/* Are we targeting Android? */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine TARGET_ANDROI=
D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
#define TARGET_ALIAS &quot;@CMAKE_SYSTEM_NAME@&quot;</span><br><span> </spa=
n><br><span> /* Enable GNU extensions on systems that have them.  */</span>=
<br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/895?usp=3Demail">change 895</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/895?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If6afa1108f9234f98afdbe0de7b=
7320403871772 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 895 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--V3qIrCCc+eg=--

