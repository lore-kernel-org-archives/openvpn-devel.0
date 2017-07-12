From: Antonio Quartulli <a@...2181...>
Date: Wed, 12 Jul 2017 11:58:35 +0800
Message-Id: <20170712035835.6398-1-a@...2181...>
In-Reply-To: <20170710043441.24770-1-a@...2181...>
References: <20170710043441.24770-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 5/4] ntlm: unwrap multiple function calls
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

In order to improve code readability it is better to unwrap
multiple function calls onto multiple lines.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/ntlm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index c0319287..47ad8959 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -276,7 +276,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2,
         int tib_len;
 
         /* NTLMv2 hash */
-        my_strupr(strcpy(userdomain, username));
+        strcpy(userdomain, username)
+        my_strupr(userdomain);
         if (strlen(username) + strlen(domain) < sizeof(userdomain))
         {
             strcat(userdomain, domain);
-- 
2.13.2


