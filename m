From: Steffan Karger <steffan@...1856...>
Date: Sun, 28 Aug 2016 21:42:03 +0200
Message-Id: <1472413323-21723-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (master)] Drop gnu89/c89 support,
	switch to c99
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

Previously, we would use the compiler's default C version, which defaults
to gnu89 for GCC < 5, gnu11 for GCC > 5, and c11 for clang, but might even
differ per distro.

One of the reasons to accept the gnu89 default of GCC < 4.9, was that MSVC
didn't support c99.  But in MSVC 2015, MS finanally fixed that.

Having to support c89 in the codebase occasionally forces us to write less
readable code, for example by forcing all declaration to be at the starting
of a block (which includes 'for loop initial declarations').

Let's be clear about what standard we obey, and stop punishing ourselves
with c89/gnu89.  Let's switch the master branch to c99.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 configure.ac | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure.ac b/configure.ac
index 9189c94..16cab19 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1125,6 +1125,7 @@ if test "${enable_pkcs11}" = "yes"; then
 	)
 fi
 
+CFLAGS="${CFLAGS} -std=c99"
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
 	CFLAGS="${CFLAGS} -pedantic"
-- 
2.7.4


