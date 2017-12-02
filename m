From: Antonio Quartulli <a@...2181...>
Date: Sat,  2 Dec 2017 21:45:40 +0800
Message-Id: <20171202134541.7688-6-a@...2181...>
In-Reply-To: <20171202134541.7688-1-a@...2181...>
References: <20171202134541.7688-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 6/7] Remove MD5SUM
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

Apparently the MS5SUM macro is not used anywhere.
Remove it.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/openvpn.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index d843c913..fe8324ab 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -563,7 +563,6 @@ struct context
                                           |(c->c2.tls_multi ? PD_TLS : 0)   \
                                           |(c->options.tls_auth_file ? c->c1.ks.key_type.hmac_length : 0), \
                                           gc)
-#define MD5SUM(buf, len, gc) md5sum((buf), (len), 0, (gc))
 
 /* this represents "disabled peer-id" */
 #define MAX_PEER_ID 0xFFFFFF
-- 
2.15.1


