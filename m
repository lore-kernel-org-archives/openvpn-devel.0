From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 13 Dec 2021 17:28:41 +0100
Message-Id: <20211213162841.15763-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make build deterministic, remove __DATE__
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

The information provided by this is minimal
and it makes it more difficult to provide
deterministic builds. There are work-arounds
for that but I think it is easier to just remove
it completely.

Allows the build to pass with -Wdate-time -Werror.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/options.c | 1 -
 src/tapctl/main.c     | 1 -
 2 files changed, 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ac13412a..79f453d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -105,7 +105,6 @@ const char title_string[] =
 #endif
 #endif
     " [AEAD]"
-    " built on " __DATE__
 ;
 
 #ifndef ENABLE_SMALL
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index a3d3966a..d60df275 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -44,7 +44,6 @@
 
 const TCHAR title_string[] =
     TEXT(PACKAGE_NAME) TEXT(" ") TEXT(PACKAGE_VERSION)
-    TEXT(" built on ") TEXT(__DATE__)
 ;
 
 static const TCHAR usage_message[] =
-- 
2.30.2


