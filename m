From: Steffan Karger <steffan@...1856...>
Date: Sun, 28 Aug 2016 21:41:40 +0200
Message-Id: <1472413300-21668-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (2.3)] Make gnu89 support explicit
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

In the release/2.3 branch we support gnu89, basically to keep
pre-2015 MSVC happy.  Old gcc (<5) defaulted to gnu89.  But
gcc 5+ and clang default to gnu11/c11.  This patch makes our
gnu89 support explicit, such these newer compilers will also
point out gnu89 violations to developers.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 62b389e..e5c7ef1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1069,6 +1069,7 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+CFLAGS="${CFLAGS} -std=gnu89"
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
-- 
2.7.4


