From: Antonio Quartulli <a@...2181...>
Date: Wed, 26 Oct 2016 20:06:31 +0800
Message-Id: <20161026120631.15946-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] don't mix settings when crl-verify option
	appears more than once
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
Cc: Antonio Quartulli <a@...2181...>

clr-verify can be specified multiple times in the config file and the
expected behaviour is that the last occurrence should be used.

Therefore, reset the optional flags everytime a new crl-verify
option is found.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 281ef0b..5192198 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6966,6 +6966,14 @@ add_option (struct options *options,
 		  || (p[2] && streq (p[1], INLINE_FILE_TAG) ) || !p[2]) && !p[3])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      /*
+       * If crl-verify appears more than once in the config file, we have to
+       * to keep settings belonging to the last occurrence only.
+       * Reset optional settings each time.
+       */
+      options->ssl_flags &= ~SSLF_CRL_VERIFY_DIR;
+      options->crl_file_inline = NULL;
+
       if (p[2] && streq(p[2], "dir"))
 	options->ssl_flags |= SSLF_CRL_VERIFY_DIR;
       options->crl_file = p[1];
-- 
2.10.1


