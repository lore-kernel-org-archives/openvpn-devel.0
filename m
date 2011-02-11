From: =?utf-8?q?Samuli=20Sepp=C3=A4nen?= <samuli@...515...>
Date: Fri, 11 Feb 2011 17:09:40 +0200
Message-Id: <1297436985-18991-8-git-send-email-samuli@...515...>
In-Reply-To: <1297436985-18991-1-git-send-email-samuli@...515...>
References: <1297436985-18991-1-git-send-email-samuli@...515...>
Subject: [Openvpn-devel] [PATCH 08/13] Added configure.h and version.m4
	variable parsing to win/config.py
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

Python-based buildsystem uses win/config.py to obtain global build parameters
from various sources. Added parsing of the (fake) configure.h and version.m4 to
it so that other Python build files can use them.
---
 win/config.py |    4 +++-
 1 files changed, 3 insertions(+), 1 deletions(-)

diff --git a/win/config.py b/win/config.py
index cf38cac..d4dc6f4 100644
--- a/win/config.py
+++ b/win/config.py
@@ -1,6 +1,8 @@
-from wb import preprocess, autogen, mod_fn, home_fn, build_autodefs, make_headers_objs, dict_def
+from wb import preprocess, autogen, mod_fn, home_fn, build_configure_h, build_version_m4_vars, build_autodefs, make_headers_objs, dict_def
 
 def main(config):
+    build_configure_h(config, mod_fn(home_fn('configure.h')), head_comment='/* %s */\n\n' % autogen)
+    build_version_m4_vars(mod_fn(mod_fn('version_m4_vars.tmp')), head_comment='/* %s */\n\n' % autogen)
     build_autodefs(config, mod_fn('autodefs.h.in'), home_fn('autodefs.h'))
     ho = make_headers_objs(home_fn('Makefile.am'))
 
-- 
1.6.3.3


