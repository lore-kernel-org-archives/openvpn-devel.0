From: Steffan Karger <steffan@...1856...>
Date: Wed, 19 Oct 2016 21:24:20 +0200
Message-Id: <1476905060-29896-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix use-after-free bug in
	prepare_push_reply()
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

This was introduced by commit dfd3513e, which changes the push_cipher
memory allocation from the options gc to a temporary gc.  For the
ciphername in the options structure, which has to be available longer,
change this back to using the options gc.

Apologies for not spotting this during patch review.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/push.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 54726e7..f86bdd3 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -366,7 +366,7 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
 	{
 	  /* Push the first cipher from --ncp-ciphers to the client.
 	   * TODO: actual negotiation, instead of server dictatorship. */
-	  char *push_cipher = string_alloc(o->ncp_ciphers, gc);
+	  char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
 	  o->ciphername = strtok (push_cipher, ":");
 	  push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
 	}
-- 
2.7.4


