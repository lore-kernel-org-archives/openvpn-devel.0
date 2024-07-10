From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 Jul 2024 18:03:06 +0200
Message-Id: <20240710160306.190351-1-frank@...2641...>
In-Reply-To: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
References: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] configure: Switch to C11 by default
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Mostly so we can use anonymous structs without jumping through
hoops or relying on unofficial support.

Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/673
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 096837d..ad620fa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -119,7 +119,7 @@
 set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
 set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})
 
-set(CMAKE_C_STANDARD 99)
+set(CMAKE_C_STANDARD 11)
 
 # Set the various defines for config.h.cmake.in
 if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
diff --git a/configure.ac b/configure.ac
index 1f03f90..dcc46e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -421,10 +421,10 @@
 AC_CHECK_PROGS([RST2HTML], [rst2html rst2html.py])
 AM_CONDITIONAL([HAVE_PYDOCUTILS], [test "${RST2MAN}" -a "${RST2HTML}"])
 
-# Set -std=c99 unless user already specified a -std=
+# Set -std=c11 unless user already specified a -std=
 case "${CFLAGS}" in
   *-std=*) ;;
-  *)       CFLAGS="${CFLAGS} -std=c99" ;;
+  *)       CFLAGS="${CFLAGS} -std=c11" ;;
 esac
 
 #

