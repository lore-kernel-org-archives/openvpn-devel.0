From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:16 +0100
Message-ID: <1320074961-3809-4-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/8] Fixed missing comma in plugin.h
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

Fixed a bug where the wrong value was being passed to plugin_call_ssl, due to a missing comma.

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 plugin.h |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/plugin.h b/plugin.h
index 8782751..7aacb47 100644
--- a/plugin.h
+++ b/plugin.h
@@ -132,7 +132,7 @@ plugin_call(const struct plugin_list *pl,
 {
   return plugin_call_ssl(pl, type, av, pr, es
 #ifdef USE_SSL
-      -1, NULL
+      , -1, NULL
 #endif
       );
 }
-- 
1.7.5.4


