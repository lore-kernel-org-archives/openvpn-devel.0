From: David Sommerseth <openvpn.list@...1114...>
Date: Tue,  9 Dec 2014 10:52:44 +0100
Message-Id: <1418118764-17846-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCH] sockets: Remove the limitation of
	--tcp-nodelay to be server-only
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

From: David Sommerseth <davids@...1347...>

The assert(0) happening if trying to use --tcp-nodelay in a client
config is really not helpful at all.  When this assert(0) was removed,
another warning appeared that this could only be used in server
configs.  That itself is also quite silly, as clients can choose to
use --socket-flags TCP_NODELAY in the client config instead.  This
behaviour does not help the user in any way.

This patch removes the server-only restriction and rather provides
a more helpful warning when using --tcp-nodelay on the client side.

Trac: 489
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/helper.c  | 2 +-
 src/openvpn/options.c | 4 +++-
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index 0ed0b2b..339e2ae 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -534,7 +534,7 @@ helper_tcp_nodelay (struct options *o)
 	}
       else
 	{
-	  ASSERT (0);
+	  o->sockflags |= SF_TCP_NODELAY;
 	}
     }
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 721b42e..f0091c2 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2111,7 +2111,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (options->ssl_flags & SSLF_OPT_VERIFY)
 	msg (M_USAGE, "--opt-verify requires --mode server");
       if (options->server_flags & SF_TCP_NODELAY_HELPER)
-	msg (M_USAGE, "--tcp-nodelay requires --mode server");
+	msg (M_WARN, "WARNING: setting tcp-nodelay on the client side will not "
+             "affect the server. To have TCP_NODELAY in both direction use "
+             "tcp-nodelay in the server configuration instead.");
       if (options->auth_user_pass_verify_script)
 	msg (M_USAGE, "--auth-user-pass-verify requires --mode server");
 #if PORT_SHARE
-- 
1.8.3.1


