From: Arne Schwabe <arne@...1227...>
Date: Mon,  7 Jul 2014 14:12:21 +0200
Message-Id: <1404735142-31420-3-git-send-email-arne@...1227...>
In-Reply-To: <1404735142-31420-1-git-send-email-arne@...1227...>
References: <1404735142-31420-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/4] Fix compiling without ENABLE_MANAGEMENT
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
 src/openvpn/push.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index ea788b0..24d12c7 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -68,6 +68,7 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	  ASSERT (0);
 	}
       c->sig->signal_text = "auth-failure";
+#ifdef ENABLE_MANAGEMENT
       if (management)
 	{
 	  const char *reason = NULL;
@@ -76,6 +77,7 @@ receive_auth_failed (struct context *c, const struct buffer *buffer)
 	    reason = BSTR (&buf);
 	  management_auth_failure (management, UP_TYPE_AUTH, reason);
 	} else
+#endif
 	{
 #ifdef ENABLE_CLIENT_CR
 	  struct buffer buf = *buffer;
-- 
1.8.5.2 (Apple Git-48)


