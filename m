Message-ID: <55A41225.2020705@...1856...>
Date: Mon, 13 Jul 2015 21:31:49 +0200
From: Steffan Karger <steffan@...1856...>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------060703030300060703000901"
Subject: [Openvpn-devel] [PATCH] Fix --askpass not allowing for password
	input via stdin
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

This is a multi-part message in MIME format.
--------------060703030300060703000901
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

ACK to the attached (rebase by me) patch from trac:
https://community.openvpn.net/openvpn/ticket/248

-Steffan

--------------060703030300060703000901
Content-Type: text/x-patch;
	name="0001-Fix-askpass-not-allowing-for-password-input-via-stdi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename*0="0001-Fix-askpass-not-allowing-for-password-input-via-stdi.pa";
	filename*1="tch"

From 0e132ca6733ede1f066b0cd717b1886a28e09d32 Mon Sep 17 00:00:00 2001
From: James Geboski <jgeboski@...277...>
Date: Tue, 8 Jan 2013 17:52:57 -0500
Subject: [PATCH] Fix --askpass not allowing for password input via stdin

This resolves --askpass treating stdin as a file during the file access
check. In turn, this leads to openvpn failing to start if this option is
set to stdin.

By default, --askpass reads the certificate's password from stdin rather
than a file. Without passing the CHKACC_ACPTSTDIN flag to
check_file_access(), stdin is marked as being a nonexistent file.

Signed-off-by: James Geboski <jgeboski@...277...>
---
 src/openvpn/options.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 74276d4..cd13aa9 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2738,8 +2738,8 @@ options_postprocess_filechecks (struct options *options)
                              options->packet_id_file, R_OK|W_OK, "--replay-persist");
 
   /* ** Password files ** */
-  errs |= check_file_access (CHKACC_FILE, options->key_pass_file, R_OK,
-                             "--askpass");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+                             options->key_pass_file, R_OK, "--askpass");
 #endif /* ENABLE_CRYPTO */
 #ifdef ENABLE_MANAGEMENT
   errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
-- 
2.1.4


--------------060703030300060703000901--

