From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 16 May 2012 01:21:15 +0300
Message-Id: <1337120475-3959-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH] cleanup: update .gitignore
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

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 .gitignore |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/.gitignore b/.gitignore
index 9f546a3..f762089 100644
--- a/.gitignore
+++ b/.gitignore
@@ -1,4 +1,5 @@
 *.[oa]
+*.l[oa]
 *.dll
 *.exe
 *.exe.*
@@ -17,6 +18,7 @@ Release
 Debug
 Win32-Output
 .deps
+.libs
 Makefile
 Makefile.in
 aclocal.m4
-- 
1.7.3.4


