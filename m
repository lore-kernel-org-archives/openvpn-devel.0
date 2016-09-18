From: Gert Doering <gert@...1296...>
Date: Sun, 18 Sep 2016 14:14:23 +0200
Message-Id: <20160918121423.52139-1-gert@...1296...>
In-Reply-To: <20160917132024.12570-1-gert@...1296...>
References: <20160917132024.12570-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCHv2] Fix win32 building with C99 mode
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

v2: also fix block_dns.c (include config.h + compat.h)  (Selva Nair)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/block_dns.c     | 11 +++++++++++
 src/openvpn/misc.c          |  2 +-
 src/openvpnserv/Makefile.am |  2 +-
 3 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/block_dns.c b/src/openvpn/block_dns.c
index af2db18..ee20c68 100644
--- a/src/openvpn/block_dns.c
+++ b/src/openvpn/block_dns.c
@@ -24,6 +24,17 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+#ifdef HAVE_CONFIG_VERSION_H
+#include "config-version.h"
+#endif
+
+#include "syshead.h"
+
 #ifdef WIN32
 
 #include <fwpmu.h>
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
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index 3c757d6..3521a34 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -18,7 +18,7 @@ EXTRA_DIST = \
 	openvpnserv.vcxproj.filters
 
 AM_CPPFLAGS = \
-	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat
 
 if WIN32
 sbin_PROGRAMS = openvpnserv
-- 
1.9.1


