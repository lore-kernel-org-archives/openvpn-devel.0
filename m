From: Gert Doering <gert@...1296...>
Date: Sun, 18 Jun 2017 11:22:44 +0200
Message-Id: <20170618092244.8801-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Fix edge case with clients failing to set
 up cipher on empty PUSH_REPLY.
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

The NCP (data channel crypto negotiation) code on the client side waits
for an incoming PUSH_REPLY before setting up the data channel crypto
parameters, because the PUSH_REPLY could contain a "cipher xxx" setting.

In the particular case of a empty PUSH_REPLY message, the relevant code
bits was not called because "we have not received any options, do not
bother to look into it in more detail" - so, ciphers were not set up,
resulting in an error message like this:

    Key [AF_INET]... [0] not initialized (yet), dropping packet.

Remove that check, always init the crypto layer on PUSH_REPLY.

Trac: #903

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2532cf8..91ab28e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1925,7 +1925,7 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
     {
         reset_coarse_timers(c);
 
-        if (pulled_options && option_types_found)
+        if (pulled_options)
         {
             if (!do_deferred_options(c, option_types_found))
             {
-- 
2.10.2


