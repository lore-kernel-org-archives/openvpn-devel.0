From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 31 Oct 2011 16:29:17 +0100
Message-ID: <1320074961-3809-5-git-send-email-dejong@...1435...>
In-Reply-To: <1320074961-3809-1-git-send-email-dejong@...1435...>
References: <1320074961-3809-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/8] Reordered functions to ensure
	warning-free Windows build
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

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 plugin.h |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/plugin.h b/plugin.h
index 7aacb47..948ab88 100644
--- a/plugin.h
+++ b/plugin.h
@@ -122,6 +122,16 @@ void plugin_list_open (struct plugin_list *pl,
 
 struct plugin_list *plugin_list_inherit (const struct plugin_list *src);
 
+int plugin_call_ssl (const struct plugin_list *pl,
+		 const int type,
+		 const struct argv *av,
+		 struct plugin_return *pr,
+		 struct env_set *es
+#ifdef USE_SSL
+		 , int current_cert_depth,
+		 x509_cert_t *current_cert
+#endif
+		);
 
 static inline int
 plugin_call(const struct plugin_list *pl,
@@ -137,17 +147,6 @@ plugin_call(const struct plugin_list *pl,
       );
 }
 
-int plugin_call_ssl (const struct plugin_list *pl,
-		 const int type,
-		 const struct argv *av,
-		 struct plugin_return *pr,
-		 struct env_set *es
-#ifdef USE_SSL
-		 , int current_cert_depth,
-		 x509_cert_t *current_cert
-#endif
-		);
-
 void plugin_list_close (struct plugin_list *pl);
 bool plugin_defined (const struct plugin_list *pl, const int type);
 
-- 
1.7.5.4


