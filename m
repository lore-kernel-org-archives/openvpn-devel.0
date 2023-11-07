From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  7 Nov 2023 15:17:55 +0100
Message-Id: <20231107141755.30559-1-frank@...2641...>
In-Reply-To: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
References: <gerrit.1697649588000.I3ca6965799b23d542ababc3e38880317cb46a3ac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove CMake custom compiler flags for
 RELEASE and DEBUG build
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

This overwrites the default that cmake automatically sets. In the
case of debug builds, this breaks debugging as -O1 already optimises
many variables away.

Change-Id: I3ca6965799b23d542ababc3e38880317cb46a3ac
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/374
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 376a060..d21c9bd 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -79,10 +79,6 @@
         add_link_options("$<$<CONFIG:Release>:/CETCOMPAT>")
     endif()
 else ()
-    set(CMAKE_C_FLAGS_RELEASE "-O2")
-    set(CMAKE_CXX_FLAGS_RELEASE "-O2")
-    set(CMAKE_C_FLAGS_DEBUG "-g -O1")
-    set(CMAKE_CXX_FLAGS_DEBUG "-g -O1")
     add_compile_options(-Wall -Wuninitialized)
     check_c_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
 

