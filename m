From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sat, 28 Oct 2023 14:54:29 +0000
References: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <bc6f35d39a842decb186e0992745d9e6f2817291-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gMJvqhjjzwM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix building with
 cmake and mbed TLS
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

--gMJvqhjjzwM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail

to review the following change.


Change subject: Fix building with cmake and mbed TLS
......................................................................

Fix building with cmake and mbed TLS

Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
---
M CMakeLists.txt
M config.h.cmake.in
2 files changed, 19 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/377/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 376a060..2f57771 100644
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
@@ -219,6 +221,13 @@
 check_type_size("struct msghdr" MSGHDR)
 set(CMAKE_EXTRA_INCLUDE_FILES)

+if (${MBED})
+    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAV=
E_CTR_DRBG_UPDATE_RET)
+    check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h =
HAVE_EXPORT_KEYING_MATERIAL)
+else ()
+    set (HAVE_EXPORT_KEYING_MATERIAL TRUE)
+endif ()
+
 find_program(IFCONFIG_PATH ifconfig)
 find_program(IPROUTE_PATH ip)
 find_program(ROUTE_PATH route)
@@ -237,7 +246,14 @@

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
diff --git a/config.h.cmake.in b/config.h.cmake.in
index f2cdd39..633dfd6 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -118,7 +118,7 @@
 #cmakedefine HAVE_ERR_H

 /* Crypto library supports keying material exporter */
-#define HAVE_EXPORT_KEYING_MATERIAL 1
+#cmakedefine HAVE_EXPORT_KEYING_MATERIAL 1

 /* Define to 1 if you have the <fcntl.h> header file. */
 #cmakedefine HAVE_FCNTL_H
@@ -387,7 +387,7 @@
 #undef HAVE_VSNPRINTF

 /* we always assume a recent mbed TLS version */
-#define HAVE_CTR_DRBG_UPDATE_RET 1
+#cmakedefine HAVE_CTR_DRBG_UPDATE_RET

 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Gerrit-Change-Number: 377
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gMJvqhjjzwM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Fix building with cmake and mbed TLS<br><br>Change-Id: I7fd9e=
730e87210d2b7d090c8f9c7c6734bd7374e<br>---<br>M CMakeLists.txt<br>M config.=
h.cmake.in<br>2 files changed, 19 insertions(+), 3 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/377/1</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 376a06=
0..2f57771 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ =
b/CMakeLists.txt</span><br><span>@@ -32,6 +32,8 @@</span><br><span> endif (=
)</span><br><span> </span><br><span> option(MBED &quot;BUILD with mbed&quot=
; OFF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(MBED_INCL=
UDE_PATH &quot;&quot; CACHE STRING &quot;Path to mbed TLS include directory=
&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(MBED_LIB=
RARY_PATH &quot;&quot; CACHE STRING &quot;Path to mbed library directory&qu=
ot;)</span><br><span> option(WOLFSSL &quot;BUILD with wolfSSL&quot; OFF)</s=
pan><br><span> option(ENABLE_LZ4 &quot;BUILD with lz4&quot; ON)</span><br><=
span> option(ENABLE_LZO &quot;BUILD with lzo&quot; ON)</span><br><span>@@ -=
219,6 +221,13 @@</span><br><span> check_type_size(&quot;struct msghdr&quot;=
 MSGHDR)</span><br><span> set(CMAKE_EXTRA_INCLUDE_FILES)</span><br><span> <=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (${MBED})</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(mbe=
dtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_CTR_DRBG_UPDATE_RET)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(m=
bedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h HAVE_EXPORT_KEYING_MATERIA=
L)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+else ()</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set (HAVE_EXPORT_KEYING_M=
ATERIAL TRUE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif =
()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 find_program(IFCONFIG_PATH ifconfig)</span><br><span> find_program(IPROUTE=
_PATH ip)</span><br><span> find_program(ROUTE_PATH route)</span><br><span>@=
@ -237,7 +246,14 @@</span><br><span> </span><br><span> function(add_library=
_deps target)</span><br><span>     if (${MBED})</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        target_link_libraries(${target} -lmbedtls=
 -lmbedx509 -lmbedcrypto)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (NOT (MBED_INCLUDE_PATH STREQUAL &quot;&quot;) )</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            target_include_di=
rectories(${target} PRIVATE ${MBED_INCLUDE_PATH})</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        endif ()</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if(NOT (MBED_LIBRARY_PATH STREQUAL &quot=
;&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  target_link_directories(${target} PRIVATE ${MBED_LIBRARY_PATH})</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        endif ()</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries(${target} P=
RIVATE -lmbedtls -lmbedx509 -lmbedcrypto)</span><br><span>     elseif (${WO=
LFSSL})</span><br><span>         pkg_search_module(wolfssl wolfssl REQUIRED=
)</span><br><span>         target_link_libraries(${target} PUBLIC ${wolfssl=
_LINK_LIBRARIES})</span><br><span>diff --git a/config.h.cmake.in b/config.h=
.cmake.in</span><br><span>index f2cdd39..633dfd6 100644</span><br><span>---=
 a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><spa=
n>@@ -118,7 +118,7 @@</span><br><span> #cmakedefine HAVE_ERR_H</span><br><s=
pan> </span><br><span> /* Crypto library supports keying material exporter =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_EXPORT=
_KEYING_MATERIAL 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
cmakedefine HAVE_EXPORT_KEYING_MATERIAL 1</span><br><span> </span><br><span=
> /* Define to 1 if you have the &lt;fcntl.h&gt; header file. */</span><br>=
<span> #cmakedefine HAVE_FCNTL_H</span><br><span>@@ -387,7 +387,7 @@</span>=
<br><span> #undef HAVE_VSNPRINTF</span><br><span> </span><br><span> /* we a=
lways assume a recent mbed TLS version */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define HAVE_CTR_DRBG_UPDATE_RET 1</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CTR_DRBG_UPDATE_RET</s=
pan><br><span> </span><br><span> /* Path to ifconfig tool */</span><br><spa=
n> #define IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quot;</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/377?usp=3Demail">change 377</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c=
7c6734bd7374e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 377 </div>
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


--gMJvqhjjzwM=--

