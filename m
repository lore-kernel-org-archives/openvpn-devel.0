From: Gert Doering <gert@...1296...>
Date: Fri, 14 Feb 2025 13:52:38 +0100
Message-ID: <20250214125238.17558-1-gert@...1296...>
In-Reply-To: <gerrit.1739460301000.If6afa1108f9234f98afdbe0de7b7320403871772@...2715...>
References: <gerrit.1739460301000.If6afa1108f9234f98afdbe0de7b7320403871772@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add Android cmake building
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

There is a mode to build with a real Android NDK that requires setting up cmake to build with the NDK and so.
For quick&dirty compile tests that do not actually use the Android NDK on Linux, -DFAKE_ANDROID on Linux can be
used to compile a binary using TARGET_ANDROID.

Change-Id: If6afa1108f9234f98afdbe0de7b7320403871772
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/895
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 5081e81..b04adce 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -39,6 +39,7 @@
 option(ENABLE_LZO "BUILD with lzo" ON)
 option(ENABLE_PKCS11 "BUILD with pkcs11-helper" ON)
 option(USE_WERROR "Treat compiler warnings as errors (-Werror)" ON)
+option(FAKE_ANDROID "Target Android but do not use actual cross compile/Android cmake to build for simple compile checks on Linux")
 
 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of the plugin directory")
 
@@ -122,7 +123,14 @@
 set(CMAKE_C_STANDARD 11)
 
 # Set the various defines for config.h.cmake.in
-if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
+if (${CMAKE_SYSTEM_NAME} STREQUAL "Android" OR ${FAKE_ANDROID})
+    set(TARGET_ANDROID YES)
+    set(ENABLE_ASYNC_PUSH YES)
+    set(ENABLE_SITNL YES)
+    set(HAVE_LINUX_TYPES_H 1)
+    # Wacky workaround as OpenSSL package detection is otherwise broken (https://stackoverflow.com/questions/45958214/android-cmake-could-not-find-openssl)
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

