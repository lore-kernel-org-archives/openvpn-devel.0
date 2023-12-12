From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 07:14:00 +0000
In-Reply-To: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
References: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <c2b931faf468c963f6dd51aedb4599519f6553ff-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LROy6U+my0w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Fix building mbed
 TLS with CMake and allow specifying custom directories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, MaxF <max@...2606...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--LROy6U+my0w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/37=
7?usp=3Demail )

Change subject: Fix building mbed TLS with CMake and allow specifying custo=
m directories
......................................................................

Fix building mbed TLS with CMake and allow specifying custom directories

When installing mbed TLS 2.x and 3.x in parallel, it is useful to point
cmake to the version that should be used.

This fixes also building mbed TLS versions with cmake.

Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231211170549.85749-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
763.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M src/openvpn/mbedtls_compat.h
3 files changed, 35 insertions(+), 9 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 577bc5d..d40b213 100644
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
@@ -239,9 +241,33 @@
     pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_T=
ARGET)
 endif ()

+function(check_mbed_configuration)
+    if (NOT (MBED_INCLUDE_PATH STREQUAL "") )
+        set(CMAKE_REQUIRED_INCLUDES ${MBED_INCLUDE_PATH})
+    endif ()
+    if (NOT (MBED_LIBRARY_PATH STREQUAL ""))
+        set(CMAKE_REQUIRED_LINK_OPTIONS "-L${MBED_LIBRARY_PATH}")
+    endif ()
+    set(CMAKE_REQUIRED_LIBRARIES "mbedtls;mbedx509;mbedcrypto")
+    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET)
+    check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
+    check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)
+endfunction()
+
+if (${MBED})
+    check_mbed_configuration()
+endif()
+
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
index baf9556..6c846f2 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -378,11 +378,11 @@
 /* Define to 1 if you have the <vfork.h> header file. */
 #undef HAVE_VFORK_H

-/* we always assume a recent mbed TLS version */
-#define HAVE_MBEDTLS_PSA_CRYPTO_H 1
+/* Availability of different mbed TLS features and APIs */
+#cmakedefine01 HAVE_MBEDTLS_PSA_CRYPTO_H
 #define HAVE_MBEDTLS_SSL_TLS_PRF 1
-#define HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB 1
-#define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1
+#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#cmakedefine01 HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET

 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 610215b..d742b54 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -77,13 +77,13 @@
                                const unsigned char *additional,
                                size_t add_len)
 {
-#if HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#if MBEDTLS_VERSION_NUMBER > 0x03000000
+    return mbedtls_ctr_drbg_update(ctx, additional, add_len);
+#elif HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
     return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
-#elif MBEDTLS_VERSION_NUMBER < 0x03020100
+#else
     mbedtls_ctr_drbg_update(ctx, additional, add_len);
     return 0;
-#else
-    return mbedtls_ctr_drbg_update(ctx, additional, add_len);
 #endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Gerrit-Change-Number: 377
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--LROy6U+my0w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/377?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Fix building mbed TLS with CMake and allow spe=
cifying custom directories<br><br>When installing mbed TLS 2.x and 3.x in p=
arallel, it is useful to point<br>cmake to the version that should be used.=
<br><br>This fixes also building mbed TLS versions with cmake.<br><br>Chang=
e-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Message-Id: &lt;20231211170549.85749-1-frank@...2641...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
763.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 CMakeLists.txt<br>M config.h.cmake.in<br>M src/openvpn/mbedtls_compat.h<br=
>3 files changed, 35 insertions(+), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 577bc=
5d..d40b213 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -32,6 +32,8 @@</span><br><span> endif =
()</span><br><span> </span><br><span> option(MBED &quot;BUILD with mbed&quo=
t; OFF)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(MBED_INC=
LUDE_PATH &quot;&quot; CACHE STRING &quot;Path to mbed TLS include director=
y&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+set(MBED_LI=
BRARY_PATH &quot;&quot; CACHE STRING &quot;Path to mbed library directory&q=
uot;)</span><br><span> option(WOLFSSL &quot;BUILD with wolfSSL&quot; OFF)</=
span><br><span> option(ENABLE_LZ4 &quot;BUILD with lz4&quot; ON)</span><br>=
<span> option(ENABLE_LZO &quot;BUILD with lzo&quot; ON)</span><br><span>@@ =
-239,9 +241,33 @@</span><br><span>     pkg_search_module(pkcs11-helper libp=
kcs11-helper-1 REQUIRED IMPORTED_TARGET)</span><br><span> endif ()</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+function(c=
heck_mbed_configuration)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (NOT (MBED_INCLUDE_PATH STREQUAL &quot;&quot;) )</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        set(CMAKE_REQUIRED_INCLUDE=
S ${MBED_INCLUDE_PATH})</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (NOT (MBED_LIBRARY_PATH STREQUAL &quot;&quot;))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        set(CMAKE_REQUIRED_LINK_OPTIONS &=
quot;-L${MBED_LIBRARY_PATH}&quot;)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    set(CMAKE_REQUIRED_LIBRARIES &quot;mbedtls;mbedx509;mbedcrypto&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_sym=
bol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_=
DRBG_UPDATE_RET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h HAVE=
_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRY=
PTO_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endfunction()=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+if (${MBED})</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    check_mbed_configuration()</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+endif()</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> function(add_library_deps ta=
rget)</span><br><span>     if (${MBED})</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        target_link_libraries(${target} -lmbedtls -lmbedx=
509 -lmbedcrypto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (NOT (MBED_INCLUDE_PATH STREQUAL &quot;&quot;) )</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            target_include_directorie=
s(${target} PRIVATE ${MBED_INCLUDE_PATH})</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        endif ()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if(NOT (MBED_LIBRARY_PATH STREQUAL &quot;&quot;)=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            target=
_link_directories(${target} PRIVATE ${MBED_LIBRARY_PATH})</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        endif ()</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        target_link_libraries(${target} PRIVATE -lmbedtls -=
lmbedx509 -lmbedcrypto)</span><br><span>     elseif (${WOLFSSL})</span><br>=
<span>         pkg_search_module(wolfssl wolfssl REQUIRED)</span><br><span>=
         target_link_libraries(${target} PUBLIC ${wolfssl_LINK_LIBRARIES})<=
/span><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><b=
r><span>index baf9556..6c846f2 100644</span><br><span>--- a/config.h.cmake.=
in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -378,11 +378,=
11 @@</span><br><span> /* Define to 1 if you have the &lt;vfork.h&gt; heade=
r file. */</span><br><span> #undef HAVE_VFORK_H</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/* we always assume a recent mb=
ed TLS version */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine HAVE_MBEDTLS_PSA_CRYPTO_H 1</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* Availability of different mbed TLS features and APIs */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine01 HAVE_MBED=
TLS_PSA_CRYPTO_H</span><br><span> #define HAVE_MBEDTLS_SSL_TLS_PRF 1</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_MBEDTLS_SSL_SET=
_EXPORT_KEYS_CB 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine01 HAVE_MBEDT=
LS_CTR_DRBG_UPDATE_RET</span><br><span> </span><br><span> /* Path to ifconf=
ig tool */</span><br><span> #define IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quo=
t;</span><br><span>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/=
mbedtls_compat.h</span><br><span>index 610215b..d742b54 100644</span><br><s=
pan>--- a/src/openvpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mb=
edtls_compat.h</span><br><span>@@ -77,13 +77,13 @@</span><br><span>        =
                        const unsigned char *additional,</span><br><span>  =
                              size_t add_len)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_CTR_DRBG_UPDATE=
_RET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VER=
SION_NUMBER &gt; 0x03000000</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return mbedtls_ctr_drbg_update(ctx, additional, add_len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif HAVE_MBEDTLS_CTR_DR=
BG_UPDATE_RET</span><br><span>     return mbedtls_ctr_drbg_update_ret(ctx, =
additional, add_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#elif MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#else</span><br><span>     mbedtls_ctr_drbg_update=
(ctx, additional, add_len);</span><br><span>     return 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return mbedtls_ctr_drbg_update(ctx, additional, ad=
d_len);</span><br><span> #endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */</spa=
n><br><span> }</span><br><span> </span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail">=
change 377</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c=
7c6734bd7374e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--LROy6U+my0w=--

