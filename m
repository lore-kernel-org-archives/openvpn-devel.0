From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Aug 2012 11:51:53 +0200
Message-ID: <1345197113-24636-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove unused flag SSLF_NO_NAME_REMAPPING
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

The flag was used with the --no-name-remapping option that was removed
in commit 5e86fd93779482b90a191f929edebe414cd78a4f.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/ssl_common.h |    1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index f3f43be..cb259a9 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -288,7 +288,6 @@ struct tls_options
 # define SSLF_CLIENT_CERT_NOT_REQUIRED (1<<0)
 # define SSLF_USERNAME_AS_COMMON_NAME  (1<<1)
 # define SSLF_AUTH_USER_PASS_OPTIONAL  (1<<2)
-# define SSLF_NO_NAME_REMAPPING        (1<<3)
 # define SSLF_OPT_VERIFY               (1<<4)
 # define SSLF_CRL_VERIFY_DIR           (1<<5)
   unsigned int ssl_flags;
-- 
1.7.9.5


