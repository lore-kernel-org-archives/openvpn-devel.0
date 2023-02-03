From: Frank Lichtenheld <frank@...2641...>
Date: Fri,  3 Feb 2023 20:14:36 +0100
Message-Id: <20230203191440.136050-2-frank@...2641...>
In-Reply-To: <20230203191440.136050-1-frank@...2641...>
References: <20230203191440.136050-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] Windows: fix unused function
 setenv_foreign_option
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

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/options.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6ae3faf8..ab1b01cf 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1041,6 +1041,7 @@ setenv_settings(struct env_set *es, const struct options *o)
     }
 }
 
+#ifndef _WIN32
 static void
 setenv_foreign_option(struct options *o, const char *argv[], int len, struct env_set *es)
 {
@@ -1078,6 +1079,7 @@ setenv_foreign_option(struct options *o, const char *argv[], int len, struct env
         gc_free(&gc);
     }
 }
+#endif /* ifndef _WIN32 */
 
 static in_addr_t
 get_ip_addr(const char *ip_string, int msglevel, bool *error)
-- 
2.34.1


