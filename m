From: Antonio Quartulli <a@...2181...>
Date: Mon, 10 Jul 2017 12:34:40 +0800
Message-Id: <20170710043441.24770-4-a@...2181...>
In-Reply-To: <20170710043441.24770-1-a@...2181...>
References: <20170710043441.24770-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH 3/4] ntlm: restyle compressed multiple
 function calls
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

The gen_md4_hash() function is receiving as first argument a buffer
that is filled by a function invoked when evaluating the second
argument.

Although this is proper C, it makes the call invocation a bit obscure
because it is not immediately easy to grasp how the 'pwbuf' buffer is
filled.

Unroll the multiple function call onto lines and make the core more
readable.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/ntlm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index bb929283..f18e0371 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -247,8 +247,8 @@ ntlm_phase_3(const struct http_proxy_info *p, const char *phase_2, struct gc_are
 
 
     /* fill 1st 16 bytes with md4 hash, disregard terminating null */
-    gen_md4_hash((uint8_t *)pwbuf, unicodize(pwbuf, p->up.password) - 2,
-                 md4_hash);
+    int unicode_len = unicodize(pwbuf, p->up.password) - 2;
+    gen_md4_hash((uint8_t *)pwbuf, unicode_len, md4_hash);
 
     /* pad to 21 bytes */
     memset(md4_hash + MD4_DIGEST_LENGTH, 0, 5);
-- 
2.13.2


