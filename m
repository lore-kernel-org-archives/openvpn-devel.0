From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  4 Aug 2022 17:03:01 +0200
Message-Id: <20220804150301.62856-2-frank@...2641...>
In-Reply-To: <20220804150301.62856-1-frank@...2641...>
References: <YukYNOwpaIeA7j80@...1296...>
 <20220804150301.62856-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Reduce usage of __DATE__
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

To increase the reproducibility of builds
we shouldn't use __DATE__. However, for
the development builds there is some demand
for leaving this in.

So as suggested by Gert Doering go for a
compromise where we only use __DATE__ if
we also include the git information. This
will remove this information from release
builds, but not from builds done directly
from the git checkout.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/options.c | 2 ++
 src/tapctl/main.c     | 1 -
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3eae14a7..0ce3158b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -110,7 +110,9 @@ const char title_string[] =
 #ifdef ENABLE_DCO
     " [DCO]"
 #endif
+#ifdef CONFIGURE_GIT_REVISION
     " built on " __DATE__
+#endif
 ;
 
 #ifndef ENABLE_SMALL
diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index e13549bf..0724cc4d 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -41,7 +41,6 @@
 
 const TCHAR title_string[] =
     TEXT(PACKAGE_NAME) TEXT(" ") TEXT(PACKAGE_VERSION)
-    TEXT(" built on ") TEXT(__DATE__)
 ;
 
 static const TCHAR usage_message[] =
-- 
2.34.1


