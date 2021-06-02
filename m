From: selva.nair@...277...
Date: Tue,  1 Jun 2021 23:42:53 -0400
Message-Id: <20210602034253.19984-3-selva.nair@...277...>
In-Reply-To: <20210602034253.19984-1-selva.nair@...277...>
References: <20210602034253.19984-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Fix parsing of IV_SSO string
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

From: Selva Nair <selva.nair@...277...>

Expect comma separated keywords

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/ssl_verify.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0b41eea2..512b4f72 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -913,7 +913,7 @@ check_auth_pending_method(const char *peer_info, const char *method)
             supported = true;
             break;
         }
-        client_method = strtok(NULL, ":");
+        client_method = strtok(NULL, ",");
     }
 
     gc_free(&gc);
-- 
2.20.1


