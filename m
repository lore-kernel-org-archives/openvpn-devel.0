From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 28 Nov 2023 11:41:29 +0100
Message-Id: <20231128104129.62761-1-frank@...2641...>
In-Reply-To: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
References: <gerrit.1700475817000.I2cc8f9b82079acca250db5871ffd9fad2997d1a8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Add check for nice in cmake config
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

Change-Id: I2cc8f9b82079acca250db5871ffd9fad2997d1a8
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/444
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index fe9b596..f82ee96 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -146,6 +146,7 @@
 check_symbol_exists(fork unistd.h HAVE_FORK)
 check_symbol_exists(execve unistd.h HAVE_EXECVE)
 check_symbol_exists(ftruncate unistd.h HAVE_FTRUNCATE)
+check_symbol_exists(nice unistd.h HAVE_NICE)
 check_symbol_exists(setgid unistd.h HAVE_SETGID)
 check_symbol_exists(setuid unistd.h HAVE_SETUID)
 check_symbol_exists(setsid unistd.h HAVE_SETSID)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 85f5fa5..bf582bc 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -212,7 +212,7 @@
 #cmakedefine HAVE_NET_TUN_IF_TUN_H
 
 /* Define to 1 if you have the `nice' function. */
-#undef HAVE_NICE
+#cmakedefine HAVE_NICE
 
 /* Define to 1 if you have the `openlog' function. */
 #cmakedefine HAVE_OPENLOG

