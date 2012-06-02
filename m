From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat,  2 Jun 2012 18:31:49 +0300
Message-Id: <1338651109-15806-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz0aMBvtfzHRU1RUKWtAwKirGJ-U5__yf4uQO4s0XM2FYQ@...278...>
References: <CAOazyz0aMBvtfzHRU1RUKWtAwKirGJ-U5__yf4uQO4s0XM2FYQ@...278...>
Subject: [Openvpn-devel] [PATCH] build: support platforms that does not need
	explicit tun headers
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Both "generic" and Darwin have no special headers to use tap.

Fixes commit 7cacdfd4b7.

Reported-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/configure.ac b/configure.ac
index 5ace128..339164f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -283,6 +283,7 @@ case "$host" in
 	*-*-darwin*)
 		AC_DEFINE([TARGET_DARWIN], [1], [Are we running on Mac OS X?])
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["M"], [Target prefix])
+		have_tap_header="yes"
 		dnl some Mac OS X tendering (we use vararg macros...)
 		CPPFLAGS="$CPPFLAGS -no-cpp-precomp"
 		;;
@@ -299,6 +300,7 @@ case "$host" in
 		;;
 	*)
 		AC_DEFINE_UNQUOTED([TARGET_PREFIX], ["X"], [Target prefix])
+		have_tap_header="yes"
 		;;
 esac
 
-- 
1.7.3.4


