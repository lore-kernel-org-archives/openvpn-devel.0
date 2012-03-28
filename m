From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 28 Mar 2012 20:43:15 +0200
Message-Id: <1332960195-25301-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
References: <CAOazyz06swLVgdoE1GPt2m9EEO7cvB2S8nBstn-a1ktDYtgH-Q@...278...>
Subject: [Openvpn-devel] [PATCH] Enable pedantic in windows compilation
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
To: Openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Apparently -ansi undef WIN32 macro.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 configure.ac |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/configure.ac b/configure.ac
index d217343..ef34697 100644
--- a/configure.ac
+++ b/configure.ac
@@ -886,7 +886,8 @@ fi
 
 if test "${enable_pedantic}" = "yes"; then
 	enable_strict="yes"
-	CFLAGS="${CFLAGS} -ansi -pedantic"
+	CFLAGS="${CFLAGS} -pedantic"
+	test "${WIN32}" != "yes" && CFLAGS="${CFLAGS} -ansi"
 fi
 if test "${enable_strict}" = "yes"; then
 	CFLAGS="${CFLAGS} -Wall -Wno-unused-parameter -Wno-unused-function"
-- 
1.7.3.4


