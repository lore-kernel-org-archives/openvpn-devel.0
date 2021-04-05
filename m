From: Antonio Quartulli <a@...2181...>
Date: Mon,  5 Apr 2021 14:28:27 +0200
Message-Id: <20210405122827.16836-1-a@...2181...>
In-Reply-To: <9577ce6a-a845-71ad-b777-010fe88ed376@...2181...>
References: <9577ce6a-a845-71ad-b777-010fe88ed376@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/3] ssl: remove unneeded if block
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
 src/openvpn/ssl.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 9d18c6e5..d8662d00 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1592,7 +1592,6 @@ openvpn_PRF(const uint8_t *secret,
             uint8_t *output,
             int output_len)
 {
-    bool ret = true;
     /* concatenate seed components */
 
     struct buffer seed = alloc_buf(strlen(label)
@@ -1614,10 +1613,8 @@ openvpn_PRF(const uint8_t *secret,
     }
 
     /* compute PRF */
-    if (!ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len, output, output_len))
-    {
-        ret = false;
-    }
+    bool ret = ssl_tls1_PRF(BPTR(&seed), BLEN(&seed), secret, secret_len,
+                            output, output_len);
 
     buf_clear(&seed);
     free_buf(&seed);
-- 
2.26.3


