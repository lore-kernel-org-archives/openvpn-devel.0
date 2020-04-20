From: Antonio Quartulli <a@...2181...>
Date: Mon, 20 Apr 2020 12:21:02 +0200
Message-Id: <20200420102102.20981-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] remove bogus file check on --genkey argument
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

When invoking openvpn as standalone with the --genkey
argument, options_postprocess() is not called at all
because do_genkey() takes over the execution earlier.

For this reason, checking the --genkey argument in
options_postprocess_filechecks() is a no-op.

Geti rid of the bogus check altogether.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/options.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 63dc53c3..a8394c6c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3420,9 +3420,6 @@ options_postprocess_filechecks(struct options *options)
                                   "--tls-crypt-v2");
     }
 
-    errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
-                              options->genkey_filename, R_OK,
-                              "--genkey");
     errs |= check_file_access(CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
                               options->shared_secret_file, R_OK, "--secret");
 
-- 
2.26.1


