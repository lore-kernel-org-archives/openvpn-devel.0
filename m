From: Adriaan de Jong <dejong@...1435...>
Date: Mon, 24 Oct 2011 11:39:05 +0200
Message-ID: <1319449145-27671-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Added missing #ifdef to allow
	--disable-managent to work again
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
 ssl_verify.h |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/ssl_verify.h b/ssl_verify.h
index 1eaf639..1809137 100644
--- a/ssl_verify.h
+++ b/ssl_verify.h
@@ -172,7 +172,10 @@ static inline bool verify_user_pass_enabled(struct tls_session *session)
 {
   return (session->opt->auth_user_pass_verify_script
         || plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-        || management_enable_def_auth (management));
+#ifdef MANAGEMENT_DEF_AUTH
+        || management_enable_def_auth (management)
+#endif
+        );
 }
 
 /**
-- 
1.7.5.4


