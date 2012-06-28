Message-ID: <4FEC9804.2070805@...1227...>
Date: Thu, 28 Jun 2012 19:44:36 +0200
From: Arne Schwabe <arne@...1227...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040004070800000403010209"
Subject: [Openvpn-devel] [PATCH] Fix --management-external-key in 2.3alpha
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: "openvpn-devel@lists.sourceforge.net" <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------040004070800000403010209
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit


Just a quick patch which fixes  --management-external-key, which I need
for a cleaner way to access Android key store.

Arne

--------------040004070800000403010209
Content-Type: text/plain; charset=UTF-8; x-mac-type="0"; x-mac-creator="0";
	name="0001-If-management-external-key-is-used-do-not-check-for-.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-If-management-external-key-is-used-do-not-check-for-.pa";
	filename*1="tch"

From 53c5018f953764221c0aa51daa8bfa74f146900f Mon Sep 17 00:00:00 2001
From: Arne Schwabe <arne@...1227...>
Date: Thu, 28 Jun 2012 19:41:09 +0200
Subject: [PATCH] If --management-external-key is used do not check for
 private key file existence

Fixes error:  --key fails with EXTERNAL_PRIVATE_KEY: No such file or directory if  --management-external-key is used

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 367c1bc..a5f323d 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2709,6 +2709,9 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
                              "--extra-certs");
+#ifdef MANAGMENT_EXTERNAL_KEY
+	if(!(options->management_flags | MF_EXTERNAL_KEY))
+#endif
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
                              "--key");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
-- 
1.7.7.5 (Apple Git-26)


--------------040004070800000403010209--

