From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Nov 2023 12:20:37 +0000
In-Reply-To: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
References: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., max@...2606...
Message-ID: <721273e48f2fcdf5055f7a710f09b8341f9e24b5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9PcgLfvmZG0="; charset=UTF-8
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

--9PcgLfvmZG0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Allow specifying custom mbed TLS directories with CMake
......................................................................

Allow specifying custom mbed TLS directories with CMake

When installing mbed TLS 2.x and 3.x in parallel, it is useful to point
cmake to the version that should be used.

Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M config.h.cmake.in
M src/openvpn/mbedtls_compat.h
3 files changed, 34 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/377/5

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..236c78a 100644
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
@@ -231,9 +233,33 @@
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
index 19b79bc..d140204 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -387,10 +387,10 @@
 #undef HAVE_VSNPRINTF

 /* we always assume a recent mbed TLS version */
-#define HAVE_MBEDTLS_PSA_CRYPTO_H 1
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: MaxF <max@...2606...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--9PcgLfvmZG0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Allow specifying custom mbed TLS directories =
with CMake<br><br>When installing mbed TLS 2.x and 3.x in parallel, it is u=
seful to point<br>cmake to the version that should be used.<br><br>Change-I=
d: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e<br>Signed-off-by: Arne Schwabe=
 &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<=
br>M src/openvpn/mbedtls_compat.h<br>3 files changed, 34 insertions(+), 8 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/77/377/5</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span=
><br><span>index d21c9bd..236c78a 100644</span><br><span>--- a/CMakeLists.t=
xt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -32,6 +32,8 @@</=
span><br><span> endif ()</span><br><span> </span><br><span> option(MBED &qu=
ot;BUILD with mbed&quot; OFF)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+set(MBED_INCLUDE_PATH &quot;&quot; CACHE STRING &quot;Path to mbe=
d TLS include directory&quot;)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+set(MBED_LIBRARY_PATH &quot;&quot; CACHE STRING &quot;Path to mb=
ed library directory&quot;)</span><br><span> option(WOLFSSL &quot;BUILD wit=
h wolfSSL&quot; OFF)</span><br><span> option(ENABLE_LZ4 &quot;BUILD with lz=
4&quot; ON)</span><br><span> option(ENABLE_LZO &quot;BUILD with lzo&quot; O=
N)</span><br><span>@@ -231,9 +233,33 @@</span><br><span>     pkg_search_mod=
ule(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_TARGET)</span><br><s=
pan> endif ()</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+function(check_mbed_configuration)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (NOT (MBED_INCLUDE_PATH STREQUAL &quot;&q=
uot;) )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(=
CMAKE_REQUIRED_INCLUDES ${MBED_INCLUDE_PATH})</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (NOT (MBED_LIBRARY_PATH STREQUAL &quot;&quot;))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CMAKE_REQ=
UIRED_LINK_OPTIONS &quot;-L${MBED_LIBRARY_PATH}&quot;)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    set(CMAKE_REQUIRED_LIBRARIES &quot;mbedtls;=
mbedx509;mbedcrypto&quot;)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg=
.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_c=
b mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    check_include_files(psa/crypto.h =
HAVE_MBEDTLS_PSA_CRYPTO_H)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+endfunction()</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (${MBED})</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_mbed_configurat=
ion()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+endif()</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> function=
(add_library_deps target)</span><br><span>     if (${MBED})</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        target_link_libraries(${targe=
t} -lmbedtls -lmbedx509 -lmbedcrypto)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (NOT (MBED_INCLUDE_PATH STREQUAL &quot;&quot;)=
 )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            targe=
t_include_directories(${target} PRIVATE ${MBED_INCLUDE_PATH})</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        endif ()</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if(NOT (MBED_LIBRARY_PATH ST=
REQUAL &quot;&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            target_link_directories(${target} PRIVATE ${MBED_LIBRARY_PATH=
})</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        endif ()<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        target_link_libraries($=
{target} PRIVATE -lmbedtls -lmbedx509 -lmbedcrypto)</span><br><span>     el=
seif (${WOLFSSL})</span><br><span>         pkg_search_module(wolfssl wolfss=
l REQUIRED)</span><br><span>         target_link_libraries(${target} PUBLIC=
 ${wolfssl_LINK_LIBRARIES})</span><br><span>diff --git a/config.h.cmake.in =
b/config.h.cmake.in</span><br><span>index 19b79bc..d140204 100644</span><br=
><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</spa=
n><br><span>@@ -387,10 +387,10 @@</span><br><span> #undef HAVE_VSNPRINTF</s=
pan><br><span> </span><br><span> /* we always assume a recent mbed TLS vers=
ion */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_MB=
EDTLS_PSA_CRYPTO_H 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#cmakedefine01 HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><span> #define HAVE_MBE=
DTLS_SSL_TLS_PRF 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#de=
fine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB 1</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine01 HAVE_MBEDTLS_SSL=
_SET_EXPORT_KEYS_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#cmakedefine01 HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET</span><br><span> </span><br=
><span> /* Path to ifconfig tool */</span><br><span> #define IFCONFIG_PATH =
&quot;@IFCONFIG_PATH@&quot;</span><br><span>diff --git a/src/openvpn/mbedtl=
s_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span>index 610215b..d7=
42b54 100644</span><br><span>--- a/src/openvpn/mbedtls_compat.h</span><br><=
span>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -77,13 +77,13 @@=
</span><br><span>                                const unsigned char *addit=
ional,</span><br><span>                                size_t add_len)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if MBEDTLS_VERSION_NUMBER &gt; 0x03000000</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_ctr_drbg_update(ctx, a=
dditional, add_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#elif HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET</span><br><span>     return mbedtls=
_ctr_drbg_update_ret(ctx, additional, add_len);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#elif MBEDTLS_VERSION_NUMBER &lt; 0x03020100</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>  =
   mbedtls_ctr_drbg_update(ctx, additional, add_len);</span><br><span>     =
return 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_ctr_drbg_=
update(ctx, additional, add_len);</span><br><span> #endif /* HAVE_MBEDTLS_C=
TR_DRBG_UPDATE_RET */</span><br><span> }</span><br><span> </span><br><span>=
</span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/377?usp=3Demail">change 377</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/377?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7fd9e730e87210d2b7d090c8f9c=
7c6734bd7374e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: MaxF &lt;max@...2606...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--9PcgLfvmZG0=--

