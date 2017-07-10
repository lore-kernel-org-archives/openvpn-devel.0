From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Jul 2017 12:34:39 +0800
Message-Id: <20170710043441.24770-3-a@...2181...>
In-Reply-To: <20170710043441.24770-1-a@...2181...>
References: <20170710043441.24770-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 2/4] ntlm: avoid useless cast
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
Cc: Antonio Quartulli <a@...2181...>

The argument passed to my_strupr() is converted to an upper case
string by means of toupper(). The latter expects a single signed int
as argument, therefore it makes sense to have my_strupr() take a
signed argument too and avoid an explicit and an implicit cast.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ntlm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 76dda576..bb929283 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -131,7 +131,7 @@ gen_nonce(unsigned char *nonce)
 }
 
 void
-my_strupr(unsigned char *str)
+my_strupr(char *str)
 {
     /* converts string to uppercase in place */
 
@@ -273,7 +273,7 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
         int tib_len;
 
         /* NTLMv2 hash */
-        my_strupr((unsigned char *)strcpy(userdomain, username));
+        my_strupr(strcpy(userdomain, username));
         if (strlen(username) + strlen(domain) < sizeof(userdomain))
         {
             strcat(userdomain, domain);
-- 
2.13.2


