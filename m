From: Steffan Karger <steffan@...1856...>
Date: Mon, 12 Sep 2016 13:58:29 +0200
Message-Id: <1473681509-25495-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Restore pre-NCP cipher options on SIGUSR1
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

As reported by debbie10t on the openvpn-devel list (Message-ID:
<326b8ff7-39a6-1974-c0b0-82fd2abdc7b7@...277...>), an NCP client will
attempt to reconnect with the previously pushed cipher, instead of the
cipher from the config file, after a sigusr1 restart.  This can be a
problem when the server is reconfigured (as debbie10t explainted), or when
roaming to a differently-configured server.  Fix this by restoring the
cipher options from the config file after a sigusr1 restart.

This makes the cipher options behaviour different from other pushable
options, because those are also cached until a sighup restart.  We might
want to change this behaviour in general, but for now let's just fix the
issue at hand.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4d106c7..8140292 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2289,6 +2289,10 @@ do_init_crypto_tls_c1 (struct context *c)
   else
     {
       msg (D_INIT_MEDIUM, "Re-using SSL/TLS context");
+
+      /* Restore pre-NCP cipher options */
+      c->options.ciphername = c->c1.ciphername;
+      c->options.authname = c->c1.authname;
     }
 }
 
-- 
2.7.4


