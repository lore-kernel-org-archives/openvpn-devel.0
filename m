From: Arne Schwabe <arne@...1227...>
Date: Mon, 26 Nov 2012 15:33:09 +0100
Message-Id: <1353940389-31075-1-git-send-email-arne@...1227...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901323D0B158@...1436...>
References: <1CED409804E2164C8104F9E623B08B901323D0B158@...1436...>
Subject: [Openvpn-devel] [PATCH] Properly require --key even if
	defined(MANAGMENT_EXTERNAL_KEY)
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

When specifying --tls-client --cert ... without a --key (or --pkcs11) option,
OpenVPN should complain: "You must define private key file (--key)...". Ensure
that this works even when compiling with MANAGMENT_EXTERNAL_KEY.

Also fix the other instance where this logic is broken

Orginal-Patch-by: Found by Joachim Schipper <joachim.schipper@...1435...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5f19c27..a8843ed 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2274,7 +2274,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 	    {
 	      notnull (options->cert_file, "certificate file (--cert) or PKCS#12 file (--pkcs12)");
 #ifdef MANAGMENT_EXTERNAL_KEY
-          if (!options->management_flags & MF_EXTERNAL_KEY)
+          if (!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
 	      notnull (options->priv_key_file, "private key file (--key) or PKCS#12 file (--pkcs12)");
 	    }
@@ -2666,7 +2666,7 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
                              "--extra-certs");
 #ifdef MANAGMENT_EXTERNAL_KEY
-  if(!options->management_flags & MF_EXTERNAL_KEY)
+  if(!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
      errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
                              "--key");
-- 
1.7.9.5


