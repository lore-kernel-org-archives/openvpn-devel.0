From: Arne Schwabe <arne@...1227...>
Date: Fri, 31 May 2013 17:26:32 +0200
Message-Id: <1370013992-18592-1-git-send-email-arne@...1227...>
In-Reply-To: <20130531073813.GU20843@...1296...>
References: <20130531073813.GU20843@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix another #ifdef/#if P2MP_SERVER
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

---
 src/openvpn/ssl.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 088eea8..d9076f3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1107,7 +1107,7 @@ tls_multi_free (struct tls_multi *multi, bool clear)
   man_def_auth_set_client_reason(multi, NULL);  
 
 #endif
-#ifdef P2MP_SERVER
+#if P2MP_SERVER
   free (multi->peer_info);
 #endif
 
-- 
1.7.9.5


