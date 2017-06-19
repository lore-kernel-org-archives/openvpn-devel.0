From: David Sommerseth <davids@...515...>
Date: Mon, 19 Jun 2017 15:05:07 +0200
Message-Id: <20170619130507.13892-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] auth-token with auth-nocache fix broke
 --disable-crypto builds
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

After adding commit 571165360db0392fa83e, it broke builds where
the --disable-crypto was used with ./configure.  This was due to
the delayed_auth_pass_purge() which requires the crypto code paths
being called from init.c without the proper #ifdef encapsulation.

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/init.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 0832f1d1..a54307ad 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1382,6 +1382,8 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     /* If we delayed UID/GID downgrade or chroot, do it now */
     do_uid_gid_chroot(c, true);
 
+
+#ifdef ENABLE_CRYPTO
     /*
      * In some cases (i.e. when receiving auth-token via
      * push-reply) the auth-nocache option configured on the
@@ -1393,6 +1395,7 @@ initialization_sequence_completed(struct context *c, const unsigned int flags)
     {
         delayed_auth_pass_purge();
     }
+#endif /* ENABLE_CRYPTO */
 
     /* Test if errors */
     if (flags & ISC_ERRORS)
-- 
2.11.0


