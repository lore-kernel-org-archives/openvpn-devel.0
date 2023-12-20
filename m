From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 20 Dec 2023 13:36:59 +0100
Message-Id: <20231220123659.55542-1-frank@...2641...>
In-Reply-To: <gerrit.1702721837000.Ib14c1161b4b0c9df797b9932ad14739e202cea64@...2715...>
References: <gerrit.1702721837000.Ib14c1161b4b0c9df797b9932ad14739e202cea64@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] cmake: create and link
 compile_commands.json file
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

From: Heiko Hund <heiko@...2662...>

CMake has support to create a json file which contains exact information
how each file in the project is compiled. This file can be consumed by
clangd, which in turn provides precise symbol information to IDEs for
better code navigation and contextual information.

I use it with vscode to be able to quickly switch between native Linux and
mingw builds and have the symbols info change dynamically with it. So
handy that I think it is useful for others as well.

Bump required CMake version for CREATE_LINK.

Change-Id: Ib14c1161b4b0c9df797b9932ad14739e202cea64
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/483
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.gitignore b/.gitignore
index a1da366..4153a3e 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,6 +40,7 @@
 m4/ltversion.m4
 m4/lt~obsolete.m4
 
+compile_commands.json
 doc/openvpn-examples.5
 doc/openvpn-examples.5.html
 doc/openvpn.8
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d40b213..bc46c27 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -1,4 +1,4 @@
-cmake_minimum_required(VERSION 3.12)
+cmake_minimum_required(VERSION 3.14)
 set(CMAKE_CONFIGURATION_TYPES "Release;Debug;ASAN")
 project(openvpn)
 
@@ -42,6 +42,11 @@
 
 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of the plugin directory")
 
+# Create machine readable compile commands
+set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
+file(CREATE_LINK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
+                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json SYMBOLIC)
+
 # AddressSanitize - use CXX=clang++ CC=clang cmake -DCMAKE_BUILD_TYPE=asan to build with ASAN
 set(CMAKE_C_FLAGS_ASAN
     "-fsanitize=address,undefined -fno-sanitize-recover=all -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"

