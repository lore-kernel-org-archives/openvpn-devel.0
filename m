From: Gert Doering <gert@...1296...>
Date: Tue, 16 Jan 2024 14:18:31 +0100
Message-ID: <20240116131831.31217-1-gert@...1296...>
In-Reply-To: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
References: <gerrit.1701971374000.Ie5aa643ab6190262f7c8b9e614bedb398e85859b@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Use mingw compile definition also to
 unit tests
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

Currently we only apply the defines for windows APIs and Unicode to
OpenVPN itself. We should rather treat the unit tests the same as
our main binary to reduce potential differences.

Change-Id: Ie5aa643ab6190262f7c8b9e614bedb398e85859b
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/469
This mail reflects revision 4 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bc46c27..6f370c3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -290,6 +290,13 @@
 
     endif ()
 
+    if (MINGW)
+        target_compile_definitions(${target} PRIVATE
+                -DWIN32_LEAN_AND_MEAN
+                -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA
+        )
+    endif()
+
     # optional dependencies
     target_link_libraries(${target} PUBLIC
         $<TARGET_NAME_IF_EXISTS:PkgConfig::liblz4>
@@ -545,11 +552,7 @@
 
 add_library_deps(openvpn)
 
-if (MINGW)
-    target_compile_options(openvpn PRIVATE
-        -DWIN32_LEAN_AND_MEAN
-        -DNTDDI_VERSION=NTDDI_VISTA -D_WIN32_WINNT=_WIN32_WINNT_VISTA
-        )
+if(MINGW)
     target_compile_options(openvpn PRIVATE -municode -UUNICODE)
     target_link_options(openvpn PRIVATE -municode)
 endif()

