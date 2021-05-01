From: Antonio Quartulli <a@...2181...>
Date: Sat,  1 May 2021 15:06:39 +0200
Message-Id: <20210501130640.9330-3-a@...2181...>
In-Reply-To: <20210501130640.9330-1-a@...2181...>
References: <20210501130640.9330-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] windows: define variable only where used
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

warn_used is a static variable but that is used only under certain
conditions. These conditions do not apply for Windows and therefore
mingw is spitting a warning for unused variable.

Move variable declaration inside code block that uses it.

Fixes:

run_command.c: In function ‘openvpn_popen’:
run_command.c:236:17: warning: unused variable ‘warn_shown’ [-Wunused-variable]
  236 |     static bool warn_shown = false;
      |                 ^~~~~~~~~~

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/run_command.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 34f95c5c..650876c1 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -233,11 +233,11 @@ openvpn_popen(const struct argv *a,  const struct env_set *es)
 {
     struct gc_arena gc = gc_new();
     int ret = -1;
-    static bool warn_shown = false;
 
     if (a && a->argv[0])
     {
 #if defined(ENABLE_FEATURE_EXECVE)
+        static bool warn_shown = false;
         if (script_security() >= SSEC_BUILT_IN)
         {
             const char *cmd = a->argv[0];
-- 
2.26.3


