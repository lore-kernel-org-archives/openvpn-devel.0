From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 11 Dec 2023 18:05:49 +0100
Message-Id: <20231211170549.85749-1-frank@...2641...>
In-Reply-To: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
References: <gerrit.1698504866000.I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Fix building mbed TLS with CMake and
 allow specifying custom directories
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Arne Schwabe <arne@...1227...>

When installing mbed TLS 2.x and 3.x in parallel, it is useful to point
cmake to the version that should be used.

This fixes also building mbed TLS versions with cmake.

Change-Id: I7fd9e730e87210d2b7d090c8f9c7c6734bd7374e
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/377
This mail reflects revision 6 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
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
     pkg_search_module(pkcs11-helper libpkcs11-helper-1 REQUIRED IMPORTED_TARGET)
 endif ()
 
+function(check_mbed_configuration)
+    if (NOT (MBED_INCLUDE_PATH STREQUAL "") )
+        set(CMAKE_REQUIRED_INCLUDES ${MBED_INCLUDE_PATH})
+    endif ()
+    if (NOT (MBED_LIBRARY_PATH STREQUAL ""))
+        set(CMAKE_REQUIRED_LINK_OPTIONS "-L${MBED_LIBRARY_PATH}")
+    endif ()
+    set(CMAKE_REQUIRED_LIBRARIES "mbedtls;mbedx509;mbedcrypto")
+    check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)
+    check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
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
+            target_include_directories(${target} PRIVATE ${MBED_INCLUDE_PATH})
+        endif ()
+        if(NOT (MBED_LIBRARY_PATH STREQUAL ""))
+            target_link_directories(${target} PRIVATE ${MBED_LIBRARY_PATH})
+        endif ()
+
+        target_link_libraries(${target} PRIVATE -lmbedtls -lmbedx509 -lmbedcrypto)
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
 

