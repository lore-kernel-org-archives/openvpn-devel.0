From: Gert Doering <gert@...1296...>
Date: Tue, 11 Nov 2025 16:48:39 +0100
Message-ID: <20251111154846.31360-1-gert@...1296...>
In-Reply-To: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
References: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] Enable -Wtype-limits by default (via
 -Wextra)
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

From: Frank Lichtenheld <frank@...2641...>

Removes a few smaller instances:
 - Fix return type check for socket() on Windows/Unixy
 - Ignore a few instances related to WSAWaitForMultipleEvents.
   The compiler says the check is currently useless, but
   we follow the API documentation.

Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1207
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1207
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c9301e6..e812145 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -114,7 +114,7 @@
     check_and_add_compiler_flag(-Wstrict-prototypes StrictPrototypes)
     check_and_add_compiler_flag(-Wold-style-definition OldStyleDefinition)
     add_compile_options(-Wconversion -Wno-sign-conversion)
-    add_compile_options(-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter)
+    add_compile_options(-Wextra -Wno-sign-compare -Wno-unused-parameter)
     # clang doesn't have the different levels but also doesn't include it in -Wextra
     check_and_add_compiler_flag(-Wimplicit-fallthrough=2 GCCImplicitFallthrough)
     if (WIN32)
diff --git a/configure.ac b/configure.ac
index 3117e13..f6e4b6d 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1410,7 +1410,7 @@
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wold-style-definition])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wconversion -Wno-sign-conversion])
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wall])
-ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-type-limits -Wno-unused-parameter])
+ACL_CHECK_ADD_COMPILE_FLAGS([-Wextra -Wno-sign-compare -Wno-unused-parameter])
 # clang doesn't have the different levels but also doesn't include it in -Wextra
 ACL_CHECK_ADD_COMPILE_FLAGS([-Wimplicit-fallthrough=2])
 if test "${WIN32}" = "yes"; then
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index ca84d19..ca2d0c1 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -410,6 +410,13 @@
     }
 #endif
 
+    /* WSA_WAIT_EVENT_0 == 0 but the API documentation is written in a way
+       that doesn't guarantee that. So we make useless checks. */
+#if defined(__GNUC__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wtype-limits"
+#endif
+
     /*
      * First poll our event list with 0 timeout
      */
@@ -474,6 +481,9 @@
             return -1;
         }
     }
+#if defined(__GNUC__)
+#pragma GCC diagnostic pop
+#endif
 }
 
 static struct event_set *
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8eac96d..f7317d1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -577,7 +577,8 @@
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype == SOCK_STREAM);
 
-    if ((sd = socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol)) < 0)
+    if ((sd = socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol))
+        == SOCKET_UNDEFINED)
     {
         msg(M_ERR, "Cannot create TCP socket");
     }
@@ -608,7 +609,8 @@
     ASSERT(addrinfo);
     ASSERT(addrinfo->ai_socktype == SOCK_DGRAM);
 
-    if ((sd = socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol)) < 0)
+    if ((sd = socket(addrinfo->ai_family, addrinfo->ai_socktype, addrinfo->ai_protocol))
+        == SOCKET_UNDEFINED)
     {
         msg(M_ERR, "UDP: Cannot create UDP/UDP6 socket");
     }

