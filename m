From: Gert Doering <gert@...1296...>
Date: Wed, 25 Sep 2024 17:13:42 +0200
Message-ID: <20240925151342.13307-1-gert@...1296...>
In-Reply-To: <gerrit.1727273213000.Ia020c696f63a2a317f001c061b2ab4da69977750@...2715...>
References: <gerrit.1727273213000.Ia020c696f63a2a317f001c061b2ab4da69977750@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix check for CMake not detecting struct
 cmsg
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

This check seems to have never worked and on Linux we hard coded
the check instead. Remove this hard coded assumption and use a
working check based on check_struct_has_member instead.

This is has the side-effect of port-sharing being enabled on macOS
when compiled with cmake.

Change-Id: Ia020c696f63a2a317f001c061b2ab4da69977750
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/771
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 6271574..5db207d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -131,7 +131,6 @@
     set(ENABLE_FEATURE_TUN_PERSIST 1)
     set(HAVE_LINUX_TYPES_H 1)
     set(ENABLE_DCO YES)
-    set(HAVE_CMSGHDR YES)
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
     set(TARGET_FREEBSD YES)
     set(ENABLE_DCO YES)
@@ -185,7 +184,6 @@
 
 check_symbol_exists(sendmsg sys/socket.h HAVE_SENDMSG)
 check_symbol_exists(recvmsg sys/socket.h HAVE_RECVMSG)
-check_symbol_exists(cmsghdr sys/socket.h HAVE_CMSGHDR)
 check_symbol_exists(openlog syslog.h HAVE_OPENLOG)
 check_symbol_exists(syslog syslog.h HAVE_SYSLOG)
 check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
@@ -193,6 +191,11 @@
 check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
 check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIMIT)
 
+# Checking for existence of structs with check_symbol_exists does not work,
+# so we use check_struct_hash_member with a member instead
+check_struct_has_member("struct cmsghdr" cmsg_len sys/socket.h HAVE_CMSGHDR)
+
+
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
 set(NETEXTRA sys/types.h)

