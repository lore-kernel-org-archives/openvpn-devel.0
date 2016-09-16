From: Steffan Karger <steffan@...1856...>
Date: Fri, 16 Sep 2016 17:40:36 +0200
Message-Id: <1474040436-9855-1-git-send-email-steffan@...1856...>
In-Reply-To: <1472413300-21668-1-git-send-email-steffan@...1856...>
References: <1472413300-21668-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2.3 v2] Make gnu89 support explicit
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

v2: only set -std=gnu89 if no -std flag is present in $CFLAGS

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/configure.ac b/configure.ac
index 62b389e..af24392 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1069,6 +1069,12 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+# Set -std=gnu89 unless user already specified a -std=
+case "${CFLAGS}" in
+  *-std=*) ;;
+  *)       CFLAGS="${CFLAGS} -std=gnu89" ;;
+esac
+
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
-- 
2.7.4


