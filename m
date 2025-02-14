From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 14 Feb 2025 11:19:09 +0000
In-Reply-To: <gerrit.1739460301000.If6afa1108f9234f98afdbe0de7b7320403871772@...2715...>
References: <gerrit.1739460301000.If6afa1108f9234f98afdbe0de7b7320403871772@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <488d4e0cbcec8680035b5f83d8b65061762f5fcd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="k/LC30Ewpos="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add Android cmake
 building
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

--k/LC30Ewpos=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/895?usp=3Demail

to look at the new patch set (#3).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: Add Android cmake building
......................................................................

Add Android cmake building

There is a mode to build with a real Android NDK that requires setting up c=
make to build with the NDK and so.
For quick&dirty compile tests that do not actually use the Android NDK on L=
inux, -DFAKE_ANDROID on Linux can be
used to compile a binary using TARGET_ANDROID.

Change-Id: If6afa1108f9234f98afdbe0de7b7320403871772
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 12 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/95/895/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--k/LC30Ewpos=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/895?usp=3Demail">View Chang=
e</a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is=
 unsatisfied now.</p><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">Add Android cmake building<br><br>There is a mode to buil=
d with a real Android NDK that requires setting up cmake to build with the =
NDK and so.<br>For quick&amp;dirty compile tests that do not actually use t=
he Android NDK on Linux, -DFAKE_ANDROID on Linux can be<br>used to compile =
a binary using TARGET_ANDROID.<br><br>Change-Id: If6afa1108f9234f98afdbe0de=
7b7320403871772<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>-=
--<br>M CMakeLists.txt<br>M config.h.cmake.in<br>2 files changed, 12 insert=
ions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/95/895/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeList=
s.txt</span><br><span>index 5081e81..b04adce 100644</span><br><span>--- a/C=
MakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -39,6=
 +39,7 @@</span><br><span> option(ENABLE_LZO &quot;BUILD with lzo&quot; ON)=
</span><br><span> option(ENABLE_PKCS11 &quot;BUILD with pkcs11-helper&quot;=
 ON)</span><br><span> option(USE_WERROR &quot;Treat compiler warnings as er=
rors (-Werror)&quot; ON)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+option(FAKE_ANDROID &quot;Target Android but do not use actual cross c=
ompile/Android cmake to build for simple compile checks on Linux&quot;)</sp=
an><br><span> </span><br><span> set(PLUGIN_DIR /usr/local/lib/openvpn/plugi=
ns CACHE FILEPATH &quot;Location of the plugin directory&quot;)</span><br><=
span> </span><br><span>@@ -122,7 +123,14 @@</span><br><span> set(CMAKE_C_ST=
ANDARD 11)</span><br><span> </span><br><span> # Set the various defines for=
 config.h.cmake.in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-if =
(${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Andro=
id&quot; OR ${FAKE_ANDROID})</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    set(TARGET_ANDROID YES)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    set(ENABLE_ASYNC_PUSH YES)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    set(ENABLE_SITNL YES)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    set(HAVE_LINUX_TYPES_H 1)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    # Wacky workaround as OpenS=
SL package detection is otherwise broken (https://stackoverflow.com/questio=
ns/45958214/android-cmake-could-not-find-openssl)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    list(APPEND CMAKE_FIND_ROOT_PATH ${OPENSS=
L_ROOT_DIR})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+elseif =
(${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;)</span><br><span>     set(=
TARGET_LINUX YES)</span><br><span>     set(ENABLE_ASYNC_PUSH YES)</span><br=
><span>     set(ENABLE_LINUXDCO YES)</span><br><span>diff --git a/config.h.=
cmake.in b/config.h.cmake.in</span><br><span>index 74a53a6..2f7b43d 100644<=
/span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmak=
e.in</span><br><span>@@ -432,6 +432,9 @@</span><br><span> /* Are we running=
 WIN32? */</span><br><span> #cmakedefine TARGET_WIN32</span><br><span> </sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Are we targeting And=
roid? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefin=
e TARGET_ANDROID</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> #define TARGET_ALIAS &quot;@CMAKE_SYSTEM_NAME@&quot;</span><=
br><span> </span><br><span> /* Enable GNU extensions on systems that have t=
hem.  */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/895?usp=3Demail">change 895</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/895?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If6afa1108f9234f98afdbe0de7b=
7320403871772 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 895 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--k/LC30Ewpos=--

