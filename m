From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Apr 2021 10:00:07 +0200
Message-Id: <20210405080007.1665-3-a@...2181...>
In-Reply-To: <20210405080007.1665-1-a@...2181...>
References: <20210405080007.1665-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] ssl: remove unneeded if block
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

There is no need to check the result of a boolean function and then
assign a constant value to a variable based on that check.

Directly assign the return value of the function to the variable.

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/ssl.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9d18c6e5..cb2a3e82 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1614,10 +1614,8 @@ openvpn_PRF(const uint8_t *secret,
     }
 
     /* compute PRF */
-    if (!ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output, output_len))
-    {
-        ret = false;
-    }
+    ret = ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output,
+                       output_len);
 
     buf_clear(&seed);
     free_buf(&seed);
-- 
2.26.3


