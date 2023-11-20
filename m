From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 10:23:37 +0000
In-Reply-To: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
References: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <cdbad4729af547476b425e5354eddb997ba4c6f9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SM1+D+TrEJA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow specifying
 custom mbed TLS directories with CMake
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, MaxF <max@...2606...>

--SM1+D+TrEJA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+1 by flichtenheld


Change subject: Allow specifying custom mbed TLS directories with CMake
......................................................................

Allow specifying custom mbed TLS directories with CMake

When installing mbed TLS 2.x and 3.x in parallel, it is useful to point
cmake to the version that should be used.

Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
---
M CMakeLists.txt
1 file changed, 10 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/377/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..fe9b596 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -32,6 +32,8 @@
 endif ()

 option(MBED "BUILD with mbed" OFF)
+set(MBED_INCLUDE_PATH "" CACHE STRING "Path to mbed TLS include directory")
+set(MBED_LIBRARY_PATH "" CACHE STRING "Path to mbed library directory")
 option(WOLFSSL "BUILD with wolfSSL" OFF)
 option(ENABLE_LZ4 "BUILD with lz4" ON)
 option(ENABLE_LZO "BUILD with lzo" ON)
@@ -233,7 +235,14 @@

 function(add_library_deps target)
     if (${MBED})
-        target_link_libraries(${target} -lmbedtls -lmbedx509 -lmbedcrypto)
+        if (NOT (MBED_INCLUDE_PATH STREQUAL "") )
+            target_include_directories(${target} PRIVATE ${MBED_INCLUDE_PA=
TH})
+        endif ()
+        if(NOT (MBED_LIBRARY_PATH STREQUAL ""))
+            target_link_directories(${target} PRIVATE ${MBED_LIBRARY_PATH})
+        endif ()
+
+        target_link_libraries(${target} PRIVATE -lmbedtls -lmbedx509 -lmbe=
dcrypto)
     elseif (${WOLFSSL})
         pkg_search_module(wolfssl wolfssl REQUIRED)
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Gerrit-Change-Number: 377
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--SM1+D+TrEJA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Allow specifying custom mbed TLS directories =
with CMake<br><br>When installing mbed TLS 2.x and 3.x in parallel, it is u=
seful to point<br>cmake to the version that should be used.<br><br>Change-I=
d: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e<br>---<br>M CMakeLists.txt<br>=
1 file changed, 10 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/77/377/2</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/C=
MakeLists.txt b/CMakeLists.txt</span><br><span>index d21c9bd..fe9b596 10064=
4</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt=
</span><br><span>@@ -32,6 +32,8 @@</span><br><span> endif ()</span><br><spa=
n> </span><br><span> option(MBED &quot;BUILD with mbed&quot; OFF)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+set(MBED_INCLUDE_PATH &quot;&=
quot; CACHE STRING &quot;Path to mbed TLS include directory&quot;)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+set(MBED_LIBRARY_PATH &quot;=
&quot; CACHE STRING &quot;Path to mbed library directory&quot;)</span><br><=
span> option(WOLFSSL &quot;BUILD with wolfSSL&quot; OFF)</span><br><span> o=
ption(ENABLE_LZ4 &quot;BUILD with lz4&quot; ON)</span><br><span> option(ENA=
BLE_LZO &quot;BUILD with lzo&quot; ON)</span><br><span>@@ -233,7 +235,14 @@=
</span><br><span> </span><br><span> function(add_library_deps target)</span=
><br><span>     if (${MBED})</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        target_link_libraries(${target} -lmbedtls -lmbedx509 -lmbedc=
rypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (N=
OT (MBED_INCLUDE_PATH STREQUAL &quot;&quot;) )</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            target_include_directories(${target}=
 PRIVATE ${MBED_INCLUDE_PATH})</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        endif ()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if(NOT (MBED_LIBRARY_PATH STREQUAL &quot;&quot;))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            target_link_direc=
tories(${target} PRIVATE ${MBED_LIBRARY_PATH})</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        endif ()</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        target_link_libraries(${target} PRIVATE -lmbedtls -lmb=
edx509 -lmbedcrypto)</span><br><span>     elseif (${WOLFSSL})</span><br><sp=
an>         pkg_search_module(wolfssl wolfssl REQUIRED)</span><br><span>   =
      target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/377?usp=3Demail">change 377</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/377?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c=
7c6734bd7374e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SM1+D+TrEJA=--

