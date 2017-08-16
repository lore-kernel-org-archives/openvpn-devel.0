From: Antonio Quartulli <a@...2181...>
Date: Wed, 16 Aug 2017 21:11:56 +0800
Message-Id: <20170816131156.20704-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] remove the --disable-multi config switch
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
Cc: Antonio Quartulli <a@...2181...>

This switch is broken and unmaintained.
However there wasn't any ticket about it so far,
which means that it is practically unused.

Get rid of it and simplify the P2MP logic.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 configure.ac          | 8 --------
 src/openvpn/syshead.h | 2 +-
 2 files changed, 1 insertion(+), 9 deletions(-)

diff --git a/configure.ac b/configure.ac
index 8fb204ac..6f1044e8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -98,13 +98,6 @@ AC_ARG_ENABLE(
 	[enable_x509_alt_username="no"]
 )
 
-AC_ARG_ENABLE(
-	[multi],
-	[AS_HELP_STRING([--disable-multi], [disable client/server support (--mode server + client mode) @<:@default=yes@:>@])],
-	,
-	[enable_multi="yes"]
-)
-
 AC_ARG_ENABLE(
 	[server],
 	[AS_HELP_STRING([--disable-server], [disable server support only (but retain client support) @<:@default=yes@:>@])],
@@ -1197,7 +1190,6 @@ if test "${enable_x509_alt_username}" = "yes"; then
 fi
 
 test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct iovec needed for IPv6 support])
-test "${enable_multi}" = "yes" && AC_DEFINE([ENABLE_CLIENT_SERVER], [1], [Enable client/server capability])
 test "${enable_server}" = "no" && AC_DEFINE([ENABLE_CLIENT_ONLY], [1], [Enable client capability only])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
 test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 2973b5ad..d9f5a34d 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -513,7 +513,7 @@ socket_defined(const socket_descriptor_t sd)
  * Do we have point-to-multipoint capability?
  */
 
-#if defined(ENABLE_CLIENT_SERVER) && defined(ENABLE_CRYPTO) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
+#if defined(ENABLE_CRYPTO) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
 #define P2MP 1
 #else
 #define P2MP 0
-- 
2.14.0


