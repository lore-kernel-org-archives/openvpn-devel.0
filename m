From: Klemens Nanni <kn@...2273...>
Date: Tue, 29 Apr 2025 08:14:50 +0300
Message-ID: <20250429051450.32551-1-kn@...2273...>
In-Reply-To: <20250428214629.49104-1-kn@...2273...>
References: <20250428214629.49104-1-kn@...2273...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [SPAM] [PATCH] Skip tmp-dir check unless actually
 used
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

As per the manual, it is subject to `chroot` and used only by
`client-connect` and `plugin`.

Without additional code being run and `chroot /var/empty/` (amongst
`user`, `persist-*`, etc.) set to reduce run-time privileges as much as
possible, the default temporary is still required upon start:

Options error: Temporary directory (--tmp-dir) fails with '/var/empty///tmp': No such file or directory (errno=2)

`tmp-dir /` works around this, but should not be needed.

In this setup, client and server effectively have no create/write
filesystem access after privilege drop;  with this fix, ktrace(1)
(on OpenBSD) shows no namei(9) lookup at runtime (after `chroot`):

	# ktrace -d -i -tn ./openvpn --config ./conf --tmp-dir /nonexistent/
	...^C
	# kdump | grep -q -e/tmp -e/nonexistent ; echo $?
	1
---
 src/openvpn/options.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c48..effa8d0f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4149,8 +4149,17 @@ options_postprocess_filechecks(struct options *options)
     /* ** Config related ** */
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
                                      R_OK|X_OK, "--client-config-dir");
-    errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
-                                     R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+
+    msg(M_WARN|M_NOPREFIX, "tmp_dir = '%s'", options->tmp_dir);
+    if (options->client_connect_script
+#ifdef ENABLE_PLUGIN
+        || options->plugin_list
+#endif /* ENABLE_PLUGIN */
+       )
+    {
+        errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
+                                         R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+    }
 
     if (errs)
     {
-- 
2.49.0


