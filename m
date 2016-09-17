From: Gert Doering <gert@...1296...>
Date: Sat, 17 Sep 2016 15:20:24 +0200
Message-Id: <20160917132024.12570-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix win32 building with C99 mode
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

In -std=c99 mode, WIN32 is not defined to be "1" anymore, but just
"#define WIN32" - so the "#if WIN32" breaks, needs to be "#ifdef WIN32"

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/misc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 0991d79..2982cd0 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -977,7 +977,7 @@ hostname_randomize(const char *hostname, struct gc_arena *gc)
 const char *
 gen_path (const char *directory, const char *filename, struct gc_arena *gc)
 {
-#if WIN32
+#ifdef WIN32
   const int CC_PATH_RESERVED = CC_LESS_THAN|CC_GREATER_THAN|CC_COLON|
     CC_DOUBLE_QUOTE|CC_SLASH|CC_BACKSLASH|CC_PIPE|CC_QUESTION_MARK|CC_ASTERISK;
 #else
-- 
1.9.1


