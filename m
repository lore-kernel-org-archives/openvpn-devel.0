From: Steffan Karger <steffan@...1856...>
Date: Fri, 26 Jan 2018 11:58:03 +0100
Message-Id: <20180126105803.26646-1-steffan@...1856...>
In-Reply-To: <20180120164114.12478-1-steffan@...1856...>
References: <20180120164114.12478-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v2] Enable stricter compiler warnings by
 default
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

This by default enables the compiler warnings one could previously
enable using the --enable-strict configure option.  I think it is
okay to do so now, because we've taken care of many warnings in the
more standard builds.  (Most of those were totally harmless, but they
prevented us from spotting new more serious mistakes.)

The --enable-strict flag now enables two extra warning flags that I
think can be useful:

-Wsign-compare warns when the compiler promotes a signed type to
unsigned before comparing, which can lead to unexpected behaviour.

-Wuninitialized adds extra warnings about usage of uninitialized variables
or struct elements.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: Just move forward with warnings, don't add --disable-strict.

 configure.ac | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/configure.ac b/configure.ac
index 2c1937e5..4d415565 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1292,13 +1292,14 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
 	AC_DEFINE([PEDANTIC], [1], [Enable pedantic mode])
 fi
 if test "${enable_strict}" = "yes"; then
-	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
+	CFLAGS="${CFLAGS} -Wsign-compare -Wuninitialized"
 fi
 if test "${enable_werror}" = "yes"; then
 	CFLAGS="${CFLAGS} -Werror"
-- 
2.14.1


