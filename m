From: Gert Doering <gert@...1296...>
Date: Thu,  9 May 2024 00:05:12 +0200
Message-ID: <20240508220512.12362-1-gert@...1296...>
In-Reply-To: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
References: <gerrit.1715191782000.I85d4d27333773e8df109e42b1fa56ccf57994e57@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Support OpenBSD with cmake
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

Change-Id: I85d4d27333773e8df109e42b1fa56ccf57994e57
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/585
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3127611..f8b37a9 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -136,6 +136,8 @@
     set(TARGET_FREEBSD YES)
     set(ENABLE_DCO YES)
     link_libraries(-lnv)
+elseif (${CMAKE_SYSTEM_NAME} STREQUAL "OpenBSD")
+    set(TARGET_OPENBSD YES)
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "SunOS")
     set(TARGET_SOLARIS YES)
     set(HAVE_SYS_SOCKIO_H 1)
@@ -169,7 +171,7 @@
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
 check_symbol_exists(setsid unistd.h HAVE_SETSID)
-check_symbol_exists(getpeereid unistd.h HAVE_GETPEEREID)
+check_symbol_exists(getpeereid "unistd.h;sys/socket.h" HAVE_GETPEEREID)
 
 check_symbol_exists(epoll_create sys/epoll.h HAVE_EPOLL_CREATE)
 

