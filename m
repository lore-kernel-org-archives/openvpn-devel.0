From: Gert Doering <gert@...1296...>
Date: Mon,  8 Jan 2024 18:13:49 +0100
Message-ID: <20240108171349.15871-1-gert@...1296...>
In-Reply-To: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
References: <gerrit.1702476419000.I525ccf7872880367b248ebebb0ddc83551498042@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Move get_tmp_dir to win32-util.c and
 error out on failure
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

From: Arne Schwabe <arne@...1227...>

Currently we only warn in get_tmp_dir fails and set o->tmp_dir to
a null pointer. This will not be caught by check_file_access_chroot
either since that ignores NULL pointers but other parts of OpenVPN
will assume that tmp_dir is set to a non-NULL string.

Also move get_tmp_dir to ssl-utils.c to use it in unit tests.

Change-Id: I525ccf7872880367b248ebebb0ddc83551498042
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/481
This mail reflects revision 2 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e498114..79958db 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -885,7 +885,15 @@
 #ifdef _WIN32
     /* On Windows, find temp dir via environment variables */
     o->tmp_dir = win_get_tempdir();
-#else
+
+    if (!o->tmp_dir)
+    {
+        /* Error out if we can't find a valid temporary directory, which should
+         * be very unlikely. */
+        msg(M_USAGE, "Could not find a suitable temporary directory."
+            " (GetTempPath() failed).  Consider using --tmp-dir");
+    }
+#else  /* ifdef _WIN32 */
     /* Non-windows platforms use $TMPDIR, and if not set, default to '/tmp' */
     o->tmp_dir = getenv("TMPDIR");
     if (!o->tmp_dir)
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
index 81e504a..c5e7505 100644
--- a/src/openvpn/win32-util.c
+++ b/src/openvpn/win32-util.c
@@ -147,4 +147,26 @@
     }
     return true;
 }
+
+const char *
+win_get_tempdir(void)
+{
+    static char tmpdir[MAX_PATH];
+    WCHAR wtmpdir[MAX_PATH];
+
+    if (!GetTempPathW(_countof(wtmpdir), wtmpdir))
+    {
+        return NULL;
+    }
+
+    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) > sizeof(tmpdir))
+    {
+        msg(M_WARN, "Could not get temporary directory. Path is too long."
+            "  Consider using --tmp-dir");
+        return NULL;
+    }
+
+    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), NULL, NULL);
+    return tmpdir;
+}
 #endif /* _WIN32 */
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
index ac37979..98bf74b 100644
--- a/src/openvpn/win32-util.h
+++ b/src/openvpn/win32-util.h
@@ -40,5 +40,8 @@
 /* return true if filename is safe to be used on Windows */
 bool win_safe_filename(const char *fn);
 
+/* Find temporary directory */
+const char *win_get_tempdir(void);
+
 #endif /* OPENVPN_WIN32_UTIL_H */
 #endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index e998d90..6b7ba5e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1137,34 +1137,6 @@
     set_win_sys_path(buf, es);
 }
 
-
-const char *
-win_get_tempdir(void)
-{
-    static char tmpdir[MAX_PATH];
-    WCHAR wtmpdir[MAX_PATH];
-
-    if (!GetTempPathW(_countof(wtmpdir), wtmpdir))
-    {
-        /* Warn if we can't find a valid temporary directory, which should
-         * be unlikely.
-         */
-        msg(M_WARN, "Could not find a suitable temporary directory."
-            " (GetTempPath() failed).  Consider using --tmp-dir");
-        return NULL;
-    }
-
-    if (WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, NULL, 0, NULL, NULL) > sizeof(tmpdir))
-    {
-        msg(M_WARN, "Could not get temporary directory. Path is too long."
-            "  Consider using --tmp-dir");
-        return NULL;
-    }
-
-    WideCharToMultiByte(CP_UTF8, 0, wtmpdir, -1, tmpdir, sizeof(tmpdir), NULL, NULL);
-    return tmpdir;
-}
-
 static bool
 win_block_dns_service(bool add, int index, const HANDLE pipe)
 {
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 3605966..aa8513b 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -286,9 +286,6 @@
 /* call self in a subprocess */
 void fork_to_self(const char *cmdline);
 
-/* Find temporary directory */
-const char *win_get_tempdir(void);
-
 bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
 
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);

